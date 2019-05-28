Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB78C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6777A20883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFKoVJS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6777A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVZ3u-0005ua-Dz
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 06:10:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYti-0006Q3-V8
	for qemu-devel@nongnu.org; Tue, 28 May 2019 06:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYth-0005bP-8g
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:59:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYth-0005a1-06
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:59:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id x4so392753wrt.6
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=eb6zz8m1Vq8Xaie72PuttKF28XMFLflc0Uo0TIuBwqI=;
	b=HFKoVJS6GFjQEAEXgWRN51wQnYFw8ZWVmae9tWd6UBakn8VB5snQZju6BBMWERK6+X
	GPk/1JPkbLfH9sZ3n5YiGkRW2og1t4uZiBu6ceYiD7iJvWdmARQ/QxataGC+MxHhx8mG
	NtQbAhWBirurdelMXA2/zhZeNIq91NyjFh+knXN/CVIBkG0YeAo9bHiQdRVq2/yHFrPk
	eZae5tta8mR5b8AfkHloZhDrHLM3iN06jXTDvNDXcKOtiMOAT91PePHJvvAg72GeAeEq
	ZoUV+5YnIgl5SKFLHSBad9zQftDGtHS1BZqMsTNMtyFd3R9HBd4JHtJerQnxOb/VfdMt
	hsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=eb6zz8m1Vq8Xaie72PuttKF28XMFLflc0Uo0TIuBwqI=;
	b=RNr+xBBmOUQUiJ02g+YqLzQInpM5H87hNAHK+H8w43PEezXbRYpipnAEKwGVWAKUC9
	LpXdnldwjoLmqzTEG0gXbknCo2VeqNFkhEEdrv4gKTfAUb88aI3s8mJ+Je5N9k0LO2Nm
	RZq6mJmm/hYvvwp1k391HCufsf6jkHQ2wWOsWH0JqCzS276hmIaDpElO2hXABIMospVc
	3Xtk0c6eKU3pOVJPe3rpTruHflGfVTf0AJBGEzRK6LgQ0H6uPqic0FBp8ziUm4TvWjPe
	u2JW9iDPqqM7OE97m5VGZ3ELL6Sh/4PmRJ14he5rTLUJA+EnvIVRDn8JdoAM1Vg1saSe
	eZ/Q==
X-Gm-Message-State: APjAAAWYSykojylmIRL2F9YesJyFng5KMjDWdXHBwyfTEEZgT8Pk6uNp
	mX60Q6KSjDvkSPIOgBu4mxJVKw==
X-Google-Smtp-Source: APXvYqwQmjKfHvTg4XiLBFTrXbZubZWawf2nVFf9qdj6koqvyjz2Wt+peSBEtnPtJqP0PlEqWEdehA==
X-Received: by 2002:a5d:4310:: with SMTP id h16mr35198624wrq.331.1559037595697;
	Tue, 28 May 2019 02:59:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	205sm2424015wmd.43.2019.05.28.02.59.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:59:51 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id CDE881FFAF;
	Tue, 28 May 2019 10:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:52 +0100
Message-Id: <20190528094953.14898-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 27/28] tests/qemu-iotests: re-format output to
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This attempts to clean-up the output to better match the output of the
rest of the QEMU check system when called with -makecheck. This includes:

  - formatting as "  TEST    iotest-FMT: nnn"
  - only dumping config on failure (when -makecheck enabled)

The non-make check output has been cleaned up as well:

  - line re-displayed (\r) at the end
  - fancy colours for pass/fail/skip
  - timestamps always printed (option removed)

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190503143904.31211-1-alex.bennee@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 922c5d1d3d3..95162c6cf90 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -27,9 +27,7 @@ bad=""
 notrun=""
 casenotrun=""
 interrupt=true
-
-# by default don't output timestamps
-timestamp=${TIMESTAMP:=false}
+makecheck=false
 
 _init_error()
 {
@@ -88,6 +86,22 @@ _full_platform_details()
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
@@ -254,8 +268,8 @@ other options
     -misalign           misalign memory allocations
     -n                  show me, do not run tests
     -o options          -o options to pass to qemu-img create/convert
-    -T                  output timestamps
     -c mode             cache mode
+    -makecheck          pretty print output for make check
 
 testlist options
     -g group[,group...]        include tests from these groups
@@ -403,7 +417,10 @@ testlist options
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
@@ -416,8 +433,7 @@ testlist options
             cachemode=true
             xpand=false
             ;;
-        -T)        # turn on timestamp output
-            timestamp=true
+        -T)        # deprecated timestamp option
             xpand=false
             ;;
 
@@ -633,12 +649,6 @@ _wallclock()
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
@@ -704,23 +714,54 @@ END        { if (NR > 0) {
 
 trap "_wrapup; exit \$status" 0 1 2 3 15
 
+# Report the test start and results. For makecheck we want to pretty
+# print the whole report at the end of the execution.
+# args: $seq, $starttime, $lasttime
+_report_test_start()
+{
+    if ! $makecheck; then
+        if [ -n "$3" ]; then
+            local lasttime=" (last: $3s)"
+        fi
+        printf "%-8s %-10s [%s]            %4s%-14s\r" "$1" "..." "$2" "..." "$lasttime"
+    fi
+}
+# args:$seq $status $starttime $lasttime $thistime $details
+_report_test_result()
+{
+    local status lasttime thistime
+    if $makecheck; then
+        if [ -n "$2" ] && [ "$2" != "pass" ]; then
+            status=" [$2]"
+        fi
+        printf "  TEST    iotest-$IMGFMT: %s%s\n" "$1" "$status"
+        return
+    fi
+
+    if [ -n "$4" ]; then
+        lasttime=" (last: $4s)"
+    fi
+    if [ -n "$5" ]; then
+        thistime=" $5s"
+    fi
+    case "$2" in
+        "pass")     status=$(printf "\e[32m%-10s\e[0m" "$2") ;;
+        "fail")     status=$(printf "\e[1m\e[31m%-10s\e[0m" "$2") ;;
+        "not run")  status=$(printf "\e[33m%-10s\e[0m" "$2") ;;
+        *)          status=$(printf "%-10s" "$2") ;;
+    esac
+
+    printf "%-8s %s [%s] [%s] %4s%-14s %s\n" "$1" "$status" "$3" "$(date '+%T')" "$thistime" "$lasttime" "$6"
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
 
@@ -728,42 +769,43 @@ seq="check"
 
 for seq in $list
 do
-    err=false
-    printf %s "$seq"
+    err=false       # error flag
+    printdiff=false # show diff to reference output?
+    status=""       # test result summary
+    results=""      # test result details
+
     if [ -n "$TESTS_REMAINING_LOG" ] ; then
         sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_LOG > $TESTS_REMAINING_LOG.tmp
         mv $TESTS_REMAINING_LOG.tmp $TESTS_REMAINING_LOG
         sync
     fi
 
+    lasttime=$(sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE)
+    starttime=$(date "+%T")
+    _report_test_start $seq $starttime $lasttime
+
     if $showme
     then
-        echo
-        continue
+        status="not run"
     elif [ -f expunged ] && $expunge && egrep "^$seq([         ]|\$)" expunged >/dev/null
     then
-        echo " - expunged"
+        status="not run"
+        results="expunged"
         rm -f $seq.out.bad
         echo "/^$seq\$/d" >>$tmp.expunged
     elif [ ! -f "$source_iotests/$seq" ]
     then
-        echo " - no such test?"
+        status="not run"
+        results="no such test?"
         echo "/^$seq\$/d" >>$tmp.expunged
     else
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
 
         if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
             run_command="$PYTHON $seq"
@@ -781,26 +823,26 @@ do
                     $run_command >$tmp.out 2>&1)
         fi
         sts=$?
-        $timestamp && _timestamp
         stop=$(_wallclock)
 
         if [ -f core ]
         then
-            printf " [dumped core]"
             mv core $seq.core
+            status="fail"
+            results="[dumped core] $seq.core"
             err=true
         fi
 
         if [ -f $seq.notrun ]
         then
-            $timestamp || printf " [not run] "
-            $timestamp && echo " [not run]" && printf %s "        $seq -- "
-            cat $seq.notrun
-            notrun="$notrun $seq"
+            # overwrites timestamp output
+            status="not run"
+            results="$(cat $seq.notrun)"
         else
             if [ $sts -ne 0 ]
             then
-                printf %s " [failed, exit status $sts]"
+                status="fail"
+                results=$(printf %s "[failed, exit status $sts]")
                 err=true
             fi
 
@@ -821,22 +863,23 @@ do
 
             if [ ! -f "$reference" ]
             then
-                echo " - no qualified output"
+                status="fail"
+                reason="no qualified output"
                 err=true
             else
                 if diff -w "$reference" $tmp.out >/dev/null 2>&1
                 then
-                    echo ""
-                    if $err
-                    then
-                        :
-                    else
-                        echo "$seq $(expr $stop - $start)" >>$tmp.time
+                    if ! $err; then
+                        status="pass"
+                        thistime=$(expr $stop - $start)
+                        echo "$seq $thistime" >>$tmp.time
                     fi
                 else
-                    echo " - output mismatch (see $seq.out.bad)"
                     mv $tmp.out $seq.out.bad
                     $diff -w "$reference" "$PWD"/$seq.out.bad
+                    status="fail"
+                    results="output mismatch (see $seq.out.bad)"
+                    printdiff=true
                     err=true
                 fi
             fi
@@ -850,13 +893,27 @@ do
 
     # come here for each test, except when $showme is true
     #
-    if $err
-    then
-        bad="$bad $seq"
-        n_bad=$(expr $n_bad + 1)
-        quick=false
-    fi
-    [ -f $seq.notrun ] || try=$(expr $try + 1)
+    _report_test_result $seq "$status" "$starttime" "$lasttime" "$thistime" "$results"
+    case "$status" in
+        "pass")
+            try=$(expr $try + 1)
+            ;;
+        "fail")
+            try=$(expr $try + 1)
+            if $makecheck; then
+                _full_env_details
+            fi
+            if $printdiff; then
+                $diff -w "$reference" "$PWD"/$seq.out.bad
+            fi
+            bad="$bad $seq"
+            n_bad=$(expr $n_bad + 1)
+            quick=false
+            ;;
+        "not run")
+            notrun="$notrun $seq"
+            ;;
+    esac
 
     seq="after_$seq"
 done
-- 
2.20.1


