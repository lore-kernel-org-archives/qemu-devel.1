Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EFDC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB532070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9FdOT9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB532070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF0xs-0008Dd-5D
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v9-0004Mv-H8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v7-00061q-8w
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jF0v7-0005y1-13
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id s1so4644601wrv.5
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 12:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8ffJlbq2q0JF0+VvZkm8rLGW/gCjOk31Ed0YGik3+A0=;
 b=N9FdOT9JxNuglsVmzMenuwerlNCbVuq94ocs1I5W+u+JT8/+ydoYLTd8N1L0PMtR4T
 zQXRfb7OS5Ke9wlTO/mMwUb36JqxtbZPNDK1WN9OHXpnJ3P57uBsUfOl5w4FMdKTR4Is
 kyWAvarw8iCER3Uj4N9DXcP/WOXkdYq5kqljlN/gaoirz5g+YdhnMNkdo/UkPkhEkq2n
 iv8UVvjpyyvBC2cNCeDc0tTQ5JNopEGhrhYlqH8wcLUUdlqwCkLqnYV1ArtTdL1s4tUT
 6R3f2PK2+V0IH1jX+jQzDkXDqHkuBm6axi6Ob1N/1ijTMQ6djl/r+4SsJC9uXhBZU9C3
 vHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8ffJlbq2q0JF0+VvZkm8rLGW/gCjOk31Ed0YGik3+A0=;
 b=B29KPrt0Y3fz6ywGwJQzVMHrVD1zs5BdMHU5POViITC230bF+WYClRvjwe9jvXty+l
 n1pyaFPch1Y4RTeukSfSIj0SNr0nM/NS82IuefG6rb11Aync348UmtYASrlzDl0qjGO2
 qc3JfwgAyLH8fz5LoBgwT5UcewMAgt74e+q4JEE3okjqkck+CpbWqEp56YNXQiO1RVLh
 z4pElDJC0llkU44I3eET+ZkAMyydHLt4F2aHL+dEGE5vbnQN/DqgoWuB05ee3kjp/AKE
 VYWAINXH8XM6/jFYkee5Goud0qmzxiVSkPn5WTtYJy+Z+sDRKNwBPHGofsEwSjQp3VAV
 +jdw==
X-Gm-Message-State: ANhLgQ1iPTUb9UNNV0KBIbb4BYPUE1WsNdwCICRvSXPU8H6V+jetV12s
 UWXns4VD0n2QV+OYhIPuWzqZSxYGVh14sA==
X-Google-Smtp-Source: ADFU+vs/utw+tv6z/iPX6qBaUvTXxSaTBb2op3C4HqPS12k+pxBI+gqvUD6cRjlU/y1mhFwGYWVc6A==
X-Received: by 2002:adf:f1c4:: with SMTP id z4mr6599188wro.342.1584646411009; 
 Thu, 19 Mar 2020 12:33:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm4984794wrw.20.2020.03.19.12.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 12:33:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] scripts/run-coverity-scan: Script to run Coverity Scan
 build
Date: Thu, 19 Mar 2020 19:33:22 +0000
Message-Id: <20200319193323.2038-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200319193323.2038-1-peter.maydell@linaro.org>
References: <20200319193323.2038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new script to automate the process of running the Coverity
Scan build tools and uploading the resulting tarball to the
website.

This is intended eventually to be driven from Travis,
but it can be run locally, if you are a maintainer of the
QEMU project on the Coverity Scan website and have the secret
upload token.

The script must be run on a Fedora 30 system.  Support for using a
Docker container is added in a following commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
changes v1->v2:
 * fix sense of DRYRUN test in check_upload_permissions
 * use nproc rather than hardcoding -j8
 * use $PWD rather than $(pwd)
 * minor tweaks to configure line
 * new --results-tarball option
---
 MAINTAINERS                             |   5 +
 scripts/coverity-scan/run-coverity-scan | 311 ++++++++++++++++++++++++
 2 files changed, 316 insertions(+)
 create mode 100755 scripts/coverity-scan/run-coverity-scan

diff --git a/MAINTAINERS b/MAINTAINERS
index 7364af0d8b0..395534522b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2003,6 +2003,11 @@ M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: scripts/coverity-model.c
 
+Coverity Scan integration
+M: Peter Maydell <peter.maydell@linaro.org>
+S: Maintained
+F: scripts/coverity-scan/
+
 Device Tree
 M: Alistair Francis <alistair.francis@wdc.com>
 R: David Gibson <david@gibson.dropbear.id.au>
diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
new file mode 100755
index 00000000000..d40b51969fa
--- /dev/null
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -0,0 +1,311 @@
+#!/bin/sh -e
+
+# Upload a created tarball to Coverity Scan, as per
+# https://scan.coverity.com/projects/qemu/builds/new
+
+# This work is licensed under the terms of the GNU GPL version 2,
+# or (at your option) any later version.
+# See the COPYING file in the top-level directory.
+#
+# Copyright (c) 2017-2020 Linaro Limited
+# Written by Peter Maydell
+
+# Note that this script will automatically download and
+# run the (closed-source) coverity build tools, so don't
+# use it if you don't trust them!
+
+# This script assumes that you're running it from a QEMU source
+# tree, and that tree is a fresh clean one, because we do an in-tree
+# build. (This is necessary so that the filenames that the Coverity
+# Scan server sees are relative paths that match up with the component
+# regular expressions it uses; an out-of-tree build won't work for this.)
+# The host machine should have as many of QEMU's dependencies
+# installed as possible, for maximum coverity coverage.
+
+# To do an upload you need to be a maintainer in the Coverity online
+# service, and you will need to know the "Coverity token", which is a
+# secret 8 digit hex string. You can find that from the web UI in the
+# project settings, if you have maintainer access there.
+
+# Command line options:
+#   --dry-run : run the tools, but don't actually do the upload
+#   --update-tools-only : update the cached copy of the tools, but don't run them
+#   --tokenfile : file to read Coverity token from
+#   --version ver : specify version being analyzed (default: ask git)
+#   --description desc : specify description of this version (default: ask git)
+#   --srcdir : QEMU source tree to analyze (default: current working dir)
+#   --results-tarball : path to copy the results tarball to (default: don't
+#                       copy it anywhere, just upload it)
+#
+# User-specifiable environment variables:
+#  COVERITY_TOKEN -- Coverity token
+#  COVERITY_EMAIL -- the email address to use for uploads (default:
+#                    looks at your git user.email config)
+#  COVERITY_BUILD_CMD -- make command (default: 'make -jN' where N is
+#                    number of CPUs as determined by 'nproc')
+#  COVERITY_TOOL_BASE -- set to directory to put coverity tools
+#                        (default: /tmp/coverity-tools)
+#
+# You must specify the token, either by environment variable or by
+# putting it in a file and using --tokenfile. Everything else has
+# a reasonable default if this is run from a git tree.
+
+check_upload_permissions() {
+    # Check whether we can do an upload to the server; will exit the script
+    # with status 1 if the check failed (usually a bad token);
+    # will exit the script with status 0 if the check indicated that we
+    # can't upload yet (ie we are at quota)
+    # Assumes that PROJTOKEN, PROJNAME and DRYRUN have been initialized.
+
+    echo "Checking upload permissions..."
+
+    if ! up_perm="$(wget https://scan.coverity.com/api/upload_permitted --post-data "token=$PROJTOKEN&project=$PROJNAME" -q -O -)"; then
+        echo "Coverity Scan API access denied: bad token?"
+        exit 1
+    fi
+
+    # Really up_perm is a JSON response with either
+    # {upload_permitted:true} or {next_upload_permitted_at:<date>}
+    # We do some hacky string parsing instead of properly parsing it.
+    case "$up_perm" in
+        *upload_permitted*true*)
+            echo "Coverity Scan: upload permitted"
+            ;;
+        *next_upload_permitted_at*)
+            if [ "$DRYRUN" = yes ]; then
+                echo "Coverity Scan: upload quota reached, continuing dry run"
+            else
+                echo "Coverity Scan: upload quota reached; stopping here"
+                # Exit success as this isn't a build error.
+                exit 0
+            fi
+            ;;
+        *)
+            echo "Coverity Scan upload check: unexpected result $up_perm"
+            exit 1
+            ;;
+    esac
+}
+
+
+update_coverity_tools () {
+    # Check for whether we need to download the Coverity tools
+    # (either because we don't have a copy, or because it's out of date)
+    # Assumes that COVERITY_TOOL_BASE, PROJTOKEN and PROJNAME are set.
+
+    mkdir -p "$COVERITY_TOOL_BASE"
+    cd "$COVERITY_TOOL_BASE"
+
+    echo "Checking for new version of coverity build tools..."
+    wget https://scan.coverity.com/download/linux64 --post-data "token=$PROJTOKEN&project=$PROJNAME&md5=1" -O coverity_tool.md5.new
+
+    if ! cmp -s coverity_tool.md5 coverity_tool.md5.new; then
+        # out of date md5 or no md5: download new build tool
+        # blow away the old build tool
+        echo "Downloading coverity build tools..."
+        rm -rf coverity_tool coverity_tool.tgz
+        wget https://scan.coverity.com/download/linux64 --post-data "token=$PROJTOKEN&project=$PROJNAME" -O coverity_tool.tgz
+        if ! (cat coverity_tool.md5.new; echo "  coverity_tool.tgz") | md5sum -c --status; then
+            echo "Downloaded tarball didn't match md5sum!"
+            exit 1
+        fi
+        # extract the new one, keeping it corralled in a 'coverity_tool' directory
+        echo "Unpacking coverity build tools..."
+        mkdir -p coverity_tool
+        cd coverity_tool
+        tar xf ../coverity_tool.tgz
+        cd ..
+        mv coverity_tool.md5.new coverity_tool.md5
+    fi
+
+    rm -f coverity_tool.md5.new
+}
+
+
+# Check user-provided environment variables and arguments
+DRYRUN=no
+UPDATE_ONLY=no
+
+while [ "$#" -ge 1 ]; do
+    case "$1" in
+        --dry-run)
+            shift
+            DRYRUN=yes
+            ;;
+        --update-tools-only)
+            shift
+            UPDATE_ONLY=yes
+            ;;
+        --version)
+            shift
+            if [ $# -eq 0 ]; then
+                echo "--version needs an argument"
+                exit 1
+            fi
+            VERSION="$1"
+            shift
+            ;;
+        --description)
+            shift
+            if [ $# -eq 0 ]; then
+                echo "--description needs an argument"
+                exit 1
+            fi
+            DESCRIPTION="$1"
+            shift
+            ;;
+        --tokenfile)
+            shift
+            if [ $# -eq 0 ]; then
+                echo "--tokenfile needs an argument"
+                exit 1
+            fi
+            COVERITY_TOKEN="$(cat "$1")"
+            shift
+            ;;
+        --srcdir)
+            shift
+            if [ $# -eq 0 ]; then
+                echo "--srcdir needs an argument"
+                exit 1
+            fi
+            SRCDIR="$1"
+            shift
+            ;;
+        --results-tarball)
+            shift
+            if [ $# -eq 0 ]; then
+                echo "--results-tarball needs an argument"
+                exit 1
+            fi
+            RESULTSTARBALL="$1"
+            shift
+            ;;
+        *)
+            echo "Unexpected argument '$1'"
+            exit 1
+            ;;
+    esac
+done
+
+if [ -z "$COVERITY_TOKEN" ]; then
+    echo "COVERITY_TOKEN environment variable not set"
+    exit 1
+fi
+
+if [ -z "$COVERITY_BUILD_CMD" ]; then
+    NPROC=$(nproc)
+    COVERITY_BUILD_CMD="make -j$NPROC"
+    echo "COVERITY_BUILD_CMD: using default '$COVERITY_BUILD_CMD'"
+fi
+
+if [ -z "$COVERITY_TOOL_BASE" ]; then
+    echo "COVERITY_TOOL_BASE: using default /tmp/coverity-tools"
+    COVERITY_TOOL_BASE=/tmp/coverity-tools
+fi
+
+if [ -z "$SRCDIR" ]; then
+    SRCDIR="$PWD"
+fi
+
+PROJTOKEN="$COVERITY_TOKEN"
+PROJNAME=QEMU
+TARBALL=cov-int.tar.xz
+
+
+if [ "$UPDATE_ONLY" = yes ]; then
+    # Just do the tools update; we don't need to check whether
+    # we are in a source tree or have upload rights for this,
+    # so do it before some of the command line and source tree checks.
+    update_coverity_tools
+    exit 0
+fi
+
+cd "$SRCDIR"
+
+echo "Checking this is a QEMU source tree..."
+if ! [ -e "$SRCDIR/VERSION" ]; then
+    echo "Not in a QEMU source tree?"
+    exit 1
+fi
+
+# Fill in defaults used by the non-update-only process
+if [ -z "$VERSION" ]; then
+    VERSION="$(git describe --always HEAD)"
+fi
+
+if [ -z "$DESCRIPTION" ]; then
+    DESCRIPTION="$(git rev-parse HEAD)"
+fi
+
+if [ -z "$COVERITY_EMAIL" ]; then
+    COVERITY_EMAIL="$(git config user.email)"
+fi
+
+check_upload_permissions
+
+update_coverity_tools
+
+TOOLBIN="$(cd "$COVERITY_TOOL_BASE" && echo $PWD/coverity_tool/cov-analysis-*/bin)"
+
+if ! test -x "$TOOLBIN/cov-build"; then
+    echo "Couldn't find cov-build in the coverity build-tool directory??"
+    exit 1
+fi
+
+export PATH="$TOOLBIN:$PATH"
+
+cd "$SRCDIR"
+
+echo "Doing make distclean..."
+make distclean
+
+echo "Configuring..."
+# We configure with a fixed set of enables here to ensure that we don't
+# accidentally reduce the scope of the analysis by doing the build on
+# the system that's missing a dependency that we need to build part of
+# the codebase.
+./configure --disable-modules --enable-sdl --enable-gtk \
+    --enable-opengl --enable-vte --enable-gnutls \
+    --enable-nettle --enable-curses --enable-curl \
+    --audio-drv-list=oss,alsa,sdl,pa --enable-virtfs \
+    --enable-vnc --enable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png \
+    --enable-xen --enable-brlapi \
+    --enable-linux-aio --enable-attr \
+    --enable-cap-ng --enable-trace-backends=log --enable-spice --enable-rbd \
+    --enable-xfsctl --enable-libusb --enable-usb-redir \
+    --enable-libiscsi --enable-libnfs --enable-seccomp \
+    --enable-tpm --enable-libssh --enable-lzo --enable-snappy --enable-bzip2 \
+    --enable-numa --enable-rdma --enable-smartcard --enable-virglrenderer \
+    --enable-mpath --enable-libxml2 --enable-glusterfs \
+    --enable-virtfs --enable-zstd
+
+echo "Making libqemustub.a..."
+make libqemustub.a
+
+echo "Running cov-build..."
+rm -rf cov-int
+mkdir cov-int
+cov-build --dir cov-int $COVERITY_BUILD_CMD
+
+echo "Creating results tarball..."
+tar cvf - cov-int | xz > "$TARBALL"
+
+if [ ! -z "$RESULTSTARBALL" ]; then
+    echo "Copying results tarball to $RESULTSTARBALL..."
+    cp "$TARBALL" "$RESULTSTARBALL"
+fi
+
+echo "Uploading results tarball..."
+
+if [ "$DRYRUN" = yes ]; then
+    echo "Dry run only, not uploading $TARBALL"
+    exit 0
+fi
+
+curl --form token="$PROJTOKEN" --form email="$COVERITY_EMAIL" \
+     --form file=@"$TARBALL" --form version="$VERSION" \
+     --form description="$DESCRIPTION" \
+     https://scan.coverity.com/builds?project="$PROJNAME"
+
+echo "Done."
-- 
2.20.1


