Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDAAC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA5A217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCrgSVj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA5A217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmeQ-0004nU-1P
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:16:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU7-0003pe-UV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU4-0008CP-Is
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmU4-0008AD-7O
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:28 -0400
Received: by mail-wr1-x442.google.com with SMTP id v11so4086515wru.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=NyUW/7CxiSp6jwDVSTGWLwGt+wdiAqLsvRe2mSONQKQ=;
	b=TCrgSVj4xaqozMJwhSkjbqNcAV00aNyULMNVD5h1c5ObOVmPHD5e6Tw99DtByfgPYC
	kkbqTIYimfHfpnEeDuAhl7cfhA/JFD9P71R37F/yucS5Vopuqe72U3P9/VW9nndC6qO+
	5lpSwMJVvDs9TQMvZpPri8HVD9bQBceINllj7FeGF+9c+Z+TYCvb7tpf/Otf6kuuRwPl
	F5Bo9oc5fw6zJyarxVdftOP4ID+uNaVFdHH8XyJLA8sNIHIjZx7rd5T67/sUlhjCBQVy
	8zlDwfmEgvOQyMH7exn+101XoXTSGzZl9HwA6FnzO3r3zgXtSwiuopwMZQsWEcBTbBlP
	Tv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NyUW/7CxiSp6jwDVSTGWLwGt+wdiAqLsvRe2mSONQKQ=;
	b=DlG+AVi28He1FKfxFQgPMIntEaJ0bmyeTOJ6msXwTPEa9h9xRWYDLnAG0YoZVHKfQb
	70suvnWGih5jYXAIL2sEry26jlI3sXQ5Q57xho8l38GJqSWjHf02no6C6nLe9oB8i9ei
	LBlOd/4rnHTqfRoN1/46fm8X6ovT02qGg+dx+DqxNzfxYPbT+wFeACVpvI4LFVx+Dt93
	j1/vlRT8r7Zw/PTmN9uWilL8v7K4qAsJ454FDFrU74bvSJihnIVXsNFET4hMipkI+BUq
	XwTssX/xCCgtpBc8Oa3QTO2mVmkm0JD3puMGAB7be3c7khDx9rcS7jQZZo5aS+ANU+jO
	MU6Q==
X-Gm-Message-State: APjAAAUPPWSOcfPrlvC+6hpe3F8ORwRsF+37zx5NMq5ehEVX8pOrPLwO
	ylaMeFgINKX5fz+fJz3RmMM3kQ==
X-Google-Smtp-Source: APXvYqyyry53sEOb2/h16mP99aOUpaXAC4IH++XvLPvFqgK40Rc1b8zyw8isiM/CNQ0ogPhtemXQMA==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr4265412wrn.9.1557421526830;
	Thu, 09 May 2019 10:05:26 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id b2sm3085172wrt.20.2019.05.09.10.05.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 10:05:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 77E941FFAA;
	Thu,  9 May 2019 17:59:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:59:10 +0100
Message-Id: <20190509165912.10512-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v1 22/23] tests/qemu-iotests: re-format output
 to for make check-block
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This attempts to clean-up the output to better match the output of the
rest of the QEMU check system. This includes:

  - formatting as "  TEST    iotest: nnn"
  - calculating time diff at the end
  - only dumping config on failure

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190503143904.31211-1-alex.bennee@linaro.org>
---
 tests/qemu-iotests/check | 101 +++++++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 922c5d1d3d3..fb239967a32 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -27,6 +27,7 @@ bad=""
 notrun=""
 casenotrun=""
 interrupt=true
+pretty=false
 
 # by default don't output timestamps
 timestamp=${TIMESTAMP:=false}
@@ -88,6 +89,22 @@ _full_platform_details()
     echo "$os/$platform $host $kernel"
 }
 
+_full_env_details()
+{
+    cat <<EOF
+QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
+QEMU_IMG      -- "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS
+QEMU_IO       -- "$QEMU_IO_PROG" $QEMU_IO_OPTIONS
+QEMU_NBD      -- "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS
+IMGFMT        -- $FULL_IMGFMT_DETAILS
+IMGPROTO      -- $IMGPROTO
+PLATFORM      -- $FULL_HOST_DETAILS
+TEST_DIR      -- $TEST_DIR
+SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
+
+EOF
+}
+
 # $1 = prog to look for
 set_prog_path()
 {
@@ -256,6 +273,7 @@ other options
     -o options          -o options to pass to qemu-img create/convert
     -T                  output timestamps
     -c mode             cache mode
+    -pretty             pretty print output for make check
 
 testlist options
     -g group[,group...]        include tests from these groups
@@ -403,7 +421,10 @@ testlist options
                 command -v xxdiff >/dev/null 2>&1 && diff=xxdiff
             fi
             ;;
-
+        -pretty)   # pretty print output
+            pretty=true
+            xpand=false
+            ;;
         -n)        # show me, don't do it
             showme=true
             xpand=false
@@ -633,12 +654,6 @@ _wallclock()
     date "+%H %M %S" | awk '{ print $1*3600 + $2*60 + $3 }'
 }
 
-_timestamp()
-{
-    now=$(date "+%T")
-    printf %s " [$now]"
-}
-
 _wrapup()
 {
     if $showme
@@ -704,23 +719,25 @@ END        { if (NR > 0) {
 
 trap "_wrapup; exit \$status" 0 1 2 3 15
 
+# Report the test result, optionally pretty printing the result
+# args: sequence, results
+_report_test_result()
+{
+    if $pretty; then
+        echo "  TEST    iotest: $1 $2"
+    else
+        echo "$1 $2"
+    fi
+}
+
 [ -f $TIMESTAMP_FILE ] || touch $TIMESTAMP_FILE
 
 FULL_IMGFMT_DETAILS=$(_full_imgfmt_details)
 FULL_HOST_DETAILS=$(_full_platform_details)
 
-cat <<EOF
-QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
-QEMU_IMG      -- "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS
-QEMU_IO       -- "$QEMU_IO_PROG" $QEMU_IO_OPTIONS
-QEMU_NBD      -- "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS
-IMGFMT        -- $FULL_IMGFMT_DETAILS
-IMGPROTO      -- $IMGPROTO
-PLATFORM      -- $FULL_HOST_DETAILS
-TEST_DIR      -- $TEST_DIR
-SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
-
-EOF
+if ! $pretty; then
+    _full_env_details
+fi
 
 seq="check"
 
@@ -728,8 +745,10 @@ seq="check"
 
 for seq in $list
 do
-    err=false
-    printf %s "$seq"
+    err=false     # error flag
+    reason=""     # reason for error
+    results=""    # results for non-error/skip
+
     if [ -n "$TESTS_REMAINING_LOG" ] ; then
         sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_LOG > $TESTS_REMAINING_LOG.tmp
         mv $TESTS_REMAINING_LOG.tmp $TESTS_REMAINING_LOG
@@ -738,7 +757,6 @@ do
 
     if $showme
     then
-        echo
         continue
     elif [ -f expunged ] && $expunge && egrep "^$seq([         ]|\$)" expunged >/dev/null
     then
@@ -753,17 +771,11 @@ do
         # really going to try and run this one
         #
         rm -f $seq.out.bad
-        lasttime=$(sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE)
-        if [ "X$lasttime" != X ]; then
-                printf %s " ${lasttime}s ..."
-        else
-                printf "        "        # prettier output with timestamps.
-        fi
         rm -f core $seq.notrun
         rm -f $seq.casenotrun
 
         start=$(_wallclock)
-        $timestamp && printf %s "        [$(date "+%T")]"
+        $timestamp && echo -n "$seq [$(date "+%T")] ->"
 
         if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
             run_command="$PYTHON $seq"
@@ -781,26 +793,24 @@ do
                     $run_command >$tmp.out 2>&1)
         fi
         sts=$?
-        $timestamp && _timestamp
+        $timestamp && echo " [$(date "+%T")]"
         stop=$(_wallclock)
 
         if [ -f core ]
         then
-            printf " [dumped core]"
             mv core $seq.core
+            reason="[dumped core] $seq.core"
             err=true
         fi
 
         if [ -f $seq.notrun ]
         then
-            $timestamp || printf " [not run] "
-            $timestamp && echo " [not run]" && printf %s "        $seq -- "
-            cat $seq.notrun
-            notrun="$notrun $seq"
+            # overwrites timestamp output
+            results="[not run] $(cat $seq.notrun)"
         else
             if [ $sts -ne 0 ]
             then
-                printf %s " [failed, exit status $sts]"
+                reason=$(printf %s "[failed, exit status $sts]")
                 err=true
             fi
 
@@ -821,22 +831,29 @@ do
 
             if [ ! -f "$reference" ]
             then
-                echo " - no qualified output"
+                reason=" - no qualified output"
                 err=true
             else
                 if diff -w "$reference" $tmp.out >/dev/null 2>&1
                 then
-                    echo ""
                     if $err
                     then
                         :
                     else
-                        echo "$seq $(expr $stop - $start)" >>$tmp.time
+                        lasttime=$(sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE)
+                        thistime=$(expr $stop - $start)
+                        echo "$seq $thistime" >>$tmp.time
+
+                        if [ "X$lasttime" != X ]; then
+                            results="${results}${thistime}s (last ${lasttime}s)"
+                        else
+                            results="${results}${thistime}s"
+                        fi
                     fi
                 else
-                    echo " - output mismatch (see $seq.out.bad)"
                     mv $tmp.out $seq.out.bad
                     $diff -w "$reference" "$PWD"/$seq.out.bad
+                    reason=" - output mismatch (see $seq.out.bad)"
                     err=true
                 fi
             fi
@@ -852,9 +869,13 @@ do
     #
     if $err
     then
+        _report_test_result $seq "FAILED $reason"
+        _full_env_details
         bad="$bad $seq"
         n_bad=$(expr $n_bad + 1)
         quick=false
+    else
+        _report_test_result $seq "$results"
     fi
     [ -f $seq.notrun ] || try=$(expr $try + 1)
 
-- 
2.20.1


