#!/bin/bash

# Commit and Push all folders to appropriate GitHub repositories
#
# by RaveMaker - http://ravemaker.net
#

# Load settings
if [ -f settings.cfg ] ; then
    echo "Loading settings..."
    source settings.cfg
else
    echo "ERROR: Create settings.cfg (from settings.cfg.example)"
    exit
fi;

function DebugMode
{
    echo "Do you want to Continue to the Next Repo? [y/n/all]"
    read Continue
    if [ $Continue == "y" ];
    then
	echo "Moving on..."
    elif [ $Continue == "n" ];
    then
	echo "Stopping..."
	exit
    elif [ $Continue == "all" ];
    then
	echo "Stopping Debug Mode"
	DEBUG="False"
    else
	DebugMode
    fi
    echo ""
}

echo "Input Git commit message:"
read GitMsg

for GitFolder in `ls $DESTFOLDER`; do
    echo "####################################"
    echo $DESTFOLDER$GitFolder
    echo "####################################"
    cd  $DESTFOLDER$GitFolder 2> /dev/null || { echo "The directory doesn't exist"; exit -1; }
    git add -A
    git commit -am "$GitMsg"
    git push
    echo ""
    if [ $DEBUG == "True" ];
    then
	DebugMode
    elif [ $DEBUG == "False" ];
    then
	echo ""
    else
	exit
    fi
done
