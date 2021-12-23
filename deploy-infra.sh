# @Author: jiafangliu
# @Date:   2021-09-04 17:34:28
# @Last Modified by:   yingzhimeng
# @Last Modified time: 2021-12-22 20:45:41
#!/bin/bash

STACK_NAME=awsbootstrap 
REGION=us-east-1 
CLI_PROFILE=awsbootstrap

EC2_INSTANCE_TYPE=t2.micro 
AWS_ACCOUNT_ID=`aws sts get-caller-identity --profile awsbootstrap \
  --query "Account" --output text`
CODEPIPELINE_BUCKET="$STACK_NAME-$REGION-codepipeline-$AWS_ACCOUNT_ID" 

# Deploy the CloudFormation template
echo -e "\n\n=========== Deploying main.yml ==========="
aws cloudformation deploy \
  --region $REGION \
  --profile $CLI_PROFILE \
  --stack-name $STACK_NAME \
  --template-file main.yml \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    EC2InstanceType=$EC2_INSTANCE_TYPE