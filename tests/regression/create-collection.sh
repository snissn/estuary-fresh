#!/bin/bash

###################################################################
#Script Name	: create-collection.sh
#Description	: This is a script file that runs a curl command to add a file to the estuary content server.
#Author         : ARG
#Email          :
###################################################################

. ../data/config/run.config

echo '#####################################'
echo `basename "$0"`
echo '#####################################'
echo ''

. config/run.config

fname=$(basename $EST_SAMPLE_FILE)
name="Sample Collection"
description="This is a sample collection"

# Let's add a collection
data="$(echo {} | jq --raw-output \
  --arg name "$name" \
  --arg description "$description" \
  '. + { "name": $name,
         "description": $description
       }'
)"

echo $data

set -x
curl --trace - --trace-time --progress-bar -X POST -H "Authorization: Bearer $ESTUARY_TOKEN" -H "Content-Type: application/json" -d "$data" $EST_API_HOST/collections/create
