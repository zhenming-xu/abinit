#!/bin/sh
#
# Copyright (C) 2013-2017 ABINIT group (Yann Pouillon)
#
# This file is part of the Abinit Documentation software package. For license
# information, please see the COPYING file in the top-level directory of
# the source distribution.
#

#
# IMPORTANT NOTE:
#
#   For maintainer use only!
#
#   PLEASE DO NOT EDIT THIS FILE, AS IT COULD CAUSE A SERIOUS LOSS OF DATA.
#   *** YOU HAVE BEEN WARNED! ***
#

# Check that we are in the right directory
if test ! -s "./configure.ac" -o ! -s "config/specs/documents.conf"; then
  echo "[quicktest] Cowardly refusing to run from here!" >&2
  exit 1
fi

# Perform a full normal clean-build cycle
./wipeout.sh && \
./autogen.sh && \
mkdir tmp && \
cd tmp && \
../configure && \
make distcheck && \
make install DESTDIR=${PWD}/install
ret1="${?}"
cd ..

# Perform a full tweaked clean-build cycle
./wipeout.sh && \
./autogen.sh && \
mkdir tmp && \
cd tmp && \
../configure --enable-portability-tests && \
make distcheck && \
make install DESTDIR=${PWD}/install
ret2="${?}"
cd ..

echo ""
echo "TEST #01: Normal build  - Exit code: ${ret1}"
echo "TEST #02: Tweaked build - Exit code: ${ret2}"
echo ""
