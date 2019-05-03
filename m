Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7795CC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FF02075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hsgOOJ3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FF02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41569 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMZM5-00040U-FH
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 10:40:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMZLE-0003cM-D0
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMZLD-00075B-4g
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:39:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMZLC-00071s-QY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:39:11 -0400
Received: by mail-wm1-x342.google.com with SMTP id y197so7034540wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=PGqJkjCBNOGw04Ltrq56HoeA7c2401B0UKpQKkw6gjE=;
	b=hsgOOJ3vvPnvHaLUuG468wtWRgtKXpiUpaI6TRwrvNw3n1fDjjv8PiOHFAiSM142bj
	0NunyoSlUYFSEeSLw4at1c3TYfbiU3d8NDhCNLwt/1CZq4CZDOUPQrvwUGShXlWKOPnK
	uyDcpnw6CdsXkDAEGSLDJZBBfiNTWEu4niFg0AdChJMpbIT4MoRgeXiPeyPwdnKQT9gb
	A9wfagCzNIaNJ4BvVhK8RyF5H2tZnyDtCkwVpHVcOIzt+0IHqNdUdAvu7Q88Qa7LezeU
	mWzKgLb58dhejpboWrm3VK+M27L4Zk14lD/VgMCT5mB4OvP7BQmnDvW264hJ5uZFZFWm
	qZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=PGqJkjCBNOGw04Ltrq56HoeA7c2401B0UKpQKkw6gjE=;
	b=kyIpB8O1FS4d+o3Hby+vKG73hZmdoHOxsaZ4cu08ysIgOnBJATlWOj8ZBQNO/dzhvF
	3+SLlXTFseRKl9dufXxPeZloNUmB1F5xVehVXJ18K4GCC1b/0nQgeMB2XnKP9gzy0DAp
	j4RVHOD6jLUEmFXtMgznD8tCDUKSYb1iDE+ERQ5th95R3/oQGABL6KpFOgY1fBHVlKLp
	7oxXcVUNie7IMZ7Tik9cKm5Vfg9ZuVJGuaCxwtTAboPhwFougamKCjJr9R9Dz3PSTZ6f
	Vweb+HuF2+evMPCLZxDLDjaOC9wBQ6EPONlJzVCFK99PqDyME6zstRqOKdxsrIjMiY7C
	+HDA==
X-Gm-Message-State: APjAAAVUO+UjNjsalWj5is6CXH3DlXmch7sajLU1cSE1ZA2lz1MmRa3h
	aJse8PudAZEVfo0sQMKYihQSkw==
X-Google-Smtp-Source: APXvYqy3oBarCkQmE2FC44G3x4WpfH5CZQPPeOH3MDyJJtV0BpukuEkCyLYGxYpXRAuXT56RwvAFtQ==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr1784480wmc.145.1556894349224;
	Fri, 03 May 2019 07:39:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	o16sm2869845wro.63.2019.05.03.07.39.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 07:39:08 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 0AFF01FF87;
	Fri,  3 May 2019 15:39:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: thuth@redhat.com
Date: Fri,  3 May 2019 15:39:04 +0100
Message-Id: <20190503143904.31211-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [RFC PATCH] tests/qemu-iotests: re-format output to
 for make check-block
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503143904.uhQaurPlQeEMnBju9bleDDDPG6Q8L7uvD_fJK-obF_Q@z>

This attempts to clean-up the output to better match the output of the
rest of the QEMU check system. This includes:

  - formatting as "  TEST    iotest: nnn"
  - calculating time diff at the end
  - only dumping config on failure

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qemu-iotests/check | 71 +++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 37 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 922c5d1d3d..2ffc14113e 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -633,12 +633,6 @@ _wallclock()
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
@@ -709,19 +703,6 @@ trap "_wrapup; exit \$status" 0 1 2 3 15
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
-
 seq="check"
 
 [ -n "$TESTS_REMAINING_LOG" ] && echo $list > $TESTS_REMAINING_LOG
@@ -729,7 +710,9 @@ seq="check"
 for seq in $list
 do
     err=false
-    printf %s "$seq"
+    reason=""
+    times=""
+
     if [ -n "$TESTS_REMAINING_LOG" ] ; then
         sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_LOG > $TESTS_REMAINING_LOG.tmp
         mv $TESTS_REMAINING_LOG.tmp $TESTS_REMAINING_LOG
@@ -738,7 +721,7 @@ do
 
     if $showme
     then
-        echo
+        echo "  TEST    iotest: $seq (not actually run)"
         continue
     elif [ -f expunged ] && $expunge && egrep "^$seq([         ]|\$)" expunged >/dev/null
     then
@@ -753,17 +736,11 @@ do
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
+        $timestamp && times="[$(date "+%T")]"
 
         if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
             run_command="$PYTHON $seq"
@@ -781,26 +758,26 @@ do
                     $run_command >$tmp.out 2>&1)
         fi
         sts=$?
-        $timestamp && _timestamp
+        $timestamp && times="$times -> [$(date "+%T")]"
         stop=$(_wallclock)
 
         if [ -f core ]
         then
-            printf " [dumped core]"
             mv core $seq.core
+            reason="dumped core $seq.core"
             err=true
         fi
 
         if [ -f $seq.notrun ]
         then
-            $timestamp || printf " [not run] "
-            $timestamp && echo " [not run]" && printf %s "        $seq -- "
+            $timestamp || reason="[not run]"
+            $timestamp && reason="[not run] $seq -- "
             cat $seq.notrun
             notrun="$notrun $seq"
         else
             if [ $sts -ne 0 ]
             then
-                printf %s " [failed, exit status $sts]"
+                reason=$(printf %s "[failed, exit status $sts]")
                 err=true
             fi
 
@@ -821,22 +798,27 @@ do
 
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
+                            times="$times ${thistime}s (last ${lasttime}s)"
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
@@ -852,9 +834,24 @@ do
     #
     if $err
     then
+        echo "  TEST    iotest: $seq FAILED $reason"
+        cat <<EOF
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
         bad="$bad $seq"
         n_bad=$(expr $n_bad + 1)
         quick=false
+    else
+        echo "  TEST    iotest: $seq $times"
     fi
     [ -f $seq.notrun ] || try=$(expr $try + 1)
 
-- 
2.20.1


