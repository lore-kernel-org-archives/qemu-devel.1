Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08197C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0E221479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTTNcnLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0E221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43774 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5zW-0001ho-UN
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:55:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP5xI-0000bi-Od
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP5xH-0004nI-EX
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:52:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hP5xH-0004la-7R
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:52:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id w12so8048709wrp.2
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=jfSwc9LRx9QPkyAHO04GkTeKX0/bTGx9eU2qXNzcOcc=;
	b=BTTNcnLw0LV5voOfmb1iz3qEDQ/Mx3OchKekmqs41EfKYK77NWuKn+GR8vq0/+IBIY
	4N6CCVmnl5coQaxTN0rO+yywyo1+o6y9uVx8bVdU0dKOEZJdarnpA4EVA3qanIyJQHV6
	YhAwrJEGxsQwoFMAw4XoBfd6pUB4d27qaRJeVceRPao70C6vLE0JQNpAVErad86ouVRt
	g8wRU9C4oxuUUueAldUpSnG47AArqQFOVHEtuYSr2V78Am0EAfl/XcXyt7jMQLA42ZWQ
	NlMNYDy76icbUz54kwo/bJvI1ME0wUEinURzYdD2AGiPSJmGw0Xkq5w7KXUBHyanLBgB
	rHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=jfSwc9LRx9QPkyAHO04GkTeKX0/bTGx9eU2qXNzcOcc=;
	b=FAc2bT4w2i4DaYGQlFfVHiGKNCvLqeKFGTVmtifbVIzGuUPQSMvWTH8jO0KoIv7+kK
	XAvOm3BIkT4iRjqjMlp2asF+cwhsg1d5n3QZBQ77J8u/xl+Lrx2UAPpj6zB6kkkqZqHC
	4GhhSzPpHB94JCEaHKBFm9o1ELO0DDyXAF7ndeSNFYVdYabLkWZc4sMH15K/xl2hkRpz
	azzytkpvEmsQM7zsTJTSAeUEf8Nzztx694aj1Fk0D+fzyXG2QDDGv/OF60DTQa8wntuS
	lj8REOUsjdi5QQCgAefnxtGO4Tgf+UfEuaewAzRnwVbhEy7jdavlOhSZKPaNE9O8gnUL
	68lQ==
X-Gm-Message-State: APjAAAWsIDLrlM3Ht9EJsx9FG5K1jQicftXrS+1Ylnu6PFrtG367wgyG
	mOHiiBPQQQ54xd706UZBVbBwDw==
X-Google-Smtp-Source: APXvYqxW9Xbfg+U26Mv6Zq7T44OdffOTSo3bGZJYTOjfh6EpBS/DOdZTu6WcUBoQLAVVmc1vigKoMA==
X-Received: by 2002:adf:dccf:: with SMTP id x15mr8041075wrm.139.1557496373976; 
	Fri, 10 May 2019 06:52:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z74sm11937877wmc.2.2019.05.10.06.52.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 06:52:53 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A9C591FF87;
	Fri, 10 May 2019 14:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 14:52:47 +0100
Message-Id: <20190510135247.31278-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v4] tests/qemu-iotests: re-format output to for
 make check-block
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
Cc: kwolf@redhat.com, thuth@redhat.com, qemu-block@nongnu.org,
	mreitz@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This attempts to clean-up the output to better match the output of the
rest of the QEMU check system when called with -pretty. This includes:

  - formatting as "  TEST    iotest: nnn"
  - calculating time diff at the end
  - only dumping config on failure (when -pretty enabled)

The existing output is mostly preserved although the dumping of the
old time at the start "Ns ..." was removed to keep the logic simple.
The timestamp mode can still be used to see which tests are "hanging".

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190503143904.31211-1-alex.bennee@linaro.org>

---
v3
  - revert echo to printf
  - add _report_test_start
v4
  - -pretty -> -makecheck
  - keep all output together for makecheck
---
 tests/qemu-iotests/check | 104 ++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 33 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 922c5d1d3d3..dc7468c1b1e 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -27,6 +27,7 @@ bad=""
 notrun=""
 casenotrun=""
 interrupt=true
+makecheck=false
 
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
+    -makecheck          pretty print output for make check
 
 testlist options
     -g group[,group...]        include tests from these groups
@@ -403,7 +421,10 @@ testlist options
                 command -v xxdiff >/dev/null 2>&1 && diff=xxdiff
             fi
             ;;
-
+        -makecheck)   # makecheck friendly output
+            makecheck=true
+            xpand=false
+            ;;
         -n)        # show me, don't do it
             showme=true
             xpand=false
@@ -704,23 +725,33 @@ END        { if (NR > 0) {
 
 trap "_wrapup; exit \$status" 0 1 2 3 15
 
+# Report the test start and results. For makecheck we want to pretty
+# print the whole report at the end of the execution.
+# args: $seq
+_report_test_start()
+{
+    if ! $makecheck; then
+        printf "%s" "$1"
+    fi
+}
+# args:$seq $output
+_report_test_result()
+{
+    if $makecheck; then
+        printf "  TEST    iotest-$IMGFMT: %s %s\n" "$1" "$2"
+    else
+        printf " %s\n" "$2"
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
+if ! $makecheck; then
+    _full_env_details
+fi
 
 seq="check"
 
@@ -728,8 +759,11 @@ seq="check"
 
 for seq in $list
 do
-    err=false
-    printf %s "$seq"
+    _report_test_start $seq
+    err=false     # error flag
+    reason=""     # reason for error
+    results=""    # results for non-error/skip
+
     if [ -n "$TESTS_REMAINING_LOG" ] ; then
         sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_LOG > $TESTS_REMAINING_LOG.tmp
         mv $TESTS_REMAINING_LOG.tmp $TESTS_REMAINING_LOG
@@ -738,7 +772,6 @@ do
 
     if $showme
     then
-        echo
         continue
     elif [ -f expunged ] && $expunge && egrep "^$seq([         ]|\$)" expunged >/dev/null
     then
@@ -753,17 +786,11 @@ do
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
+        $timestamp && _timestamp
 
         if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
             run_command="$PYTHON $seq"
@@ -786,21 +813,19 @@ do
 
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
 
@@ -821,22 +846,29 @@ do
 
             if [ ! -f "$reference" ]
             then
-                echo " - no qualified output"
+                reason="- no qualified output"
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
+                    reason="- output mismatch (see $seq.out.bad)"
                     err=true
                 fi
             fi
@@ -852,9 +884,15 @@ do
     #
     if $err
     then
+        _report_test_result $seq "FAILED $reason"
+        if $makecheck; then
+            _full_env_details
+        fi
         bad="$bad $seq"
         n_bad=$(expr $n_bad + 1)
         quick=false
+    else
+        _report_test_result $seq "$results"
     fi
     [ -f $seq.notrun ] || try=$(expr $try + 1)
 
-- 
2.20.1


