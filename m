Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F23C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2BD217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2BD217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44051 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6HB-0001fE-Rr
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:13:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP6BW-00048h-GM
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP6BU-0007F8-UI
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:07:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hP6BO-0007Bn-Vx; Fri, 10 May 2019 10:07:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C46FC307CB5F;
	Fri, 10 May 2019 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-183.ams2.redhat.com
	[10.36.116.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 30C835D6A9;
	Fri, 10 May 2019 14:07:28 +0000 (UTC)
Date: Fri, 10 May 2019 16:07:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190510140726.GB5887@localhost.localdomain>
References: <20190510102918.2705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190510102918.2705-1-alex.bennee@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 10 May 2019 14:07:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] tests/qemu-iotests: re-format output to
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.05.2019 um 12:29 hat Alex Benn=E9e geschrieben:
> This attempts to clean-up the output to better match the output of the
> rest of the QEMU check system when called with -pretty. This includes:
>=20
>   - formatting as "  TEST    iotest: nnn"
>   - calculating time diff at the end
>   - only dumping config on failure (when -pretty enabled)
>=20
> The existing output is mostly preserved although the dumping of the
> old time at the start "Ns ..." was removed to keep the logic simple.
> The timestamp mode can still be used to see which tests are "hanging".
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Message-Id: <20190503143904.31211-1-alex.bennee@linaro.org>

I played with it a bit more and ended up with the following patch to be
applied on top. Maybe you like some parts of it.

I'm now printing an \r at the end of the line that is printed at the
start of the test case. Normally that will be overwritten by the result
line which contains the same information again, but if you're running
multiple tests in parallel, it will be overwritten by something else -
which I think isn't a big problem because at the end, the result line
will still appear somewhere.

I fixed some bugs, too, like the "not run" list being broken.

Kevin


diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 4cfe2362f5..463ff82854 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -27,7 +27,7 @@ bad=3D""
 notrun=3D""
 casenotrun=3D""
 interrupt=3Dtrue
-pretty=3Dfalse
+make_check=3Dfalse
=20
 # by default don't output timestamps
 timestamp=3D${TIMESTAMP:=3Dfalse}
@@ -274,7 +274,7 @@ other options
     -o options          -o options to pass to qemu-img create/convert
     -T                  output timestamps
     -c mode             cache mode
-    -pretty             pretty print output for make check
+    -make-check         print short output for make check
=20
 testlist options
     -g group[,group...]        include tests from these groups
@@ -422,8 +422,8 @@ testlist options
                 command -v xxdiff >/dev/null 2>&1 && diff=3Dxxdiff
             fi
             ;;
-        -pretty)   # pretty print output
-            pretty=3Dtrue
+        -make-check)   # output for make check
+            make_check=3Dtrue
             xpand=3Dfalse
             ;;
         -n)        # show me, don't do it
@@ -643,12 +643,6 @@ _wallclock()
     date "+%H %M %S" | awk '{ print $1*3600 + $2*60 + $3 }'
 }
=20
-_timestamp()
-{
-    now=3D$(date "+%T")
-    printf %s " [$now]"
-}
-
 _wrapup()
 {
     if $showme
@@ -671,11 +665,10 @@ END        { if (NR > 0) {
=20
         if [ -f $tmp.expunged ]
         then
-            notrun=3D$(wc -l <$tmp.expunged | sed -e 's/  *//g')
-            try=3D$(expr $try - $notrun)
             list=3D$(echo "$list" | sed -f $tmp.expunged)
         fi
=20
+        echo
         echo "" >>check.log
         date >>check.log
         echo $list | fmt | sed -e 's/^/    /' >>check.log
@@ -714,20 +707,48 @@ END        { if (NR > 0) {
=20
 trap "_wrapup; exit \$status" 0 1 2 3 15
=20
-# Report the test start and results, optionally pretty printing for make
-# args: $seq
+# Report the test start and results, optionally short format for make ch=
eck
+# args: $seq, $starttime, $lasttime
 _report_test_start()
 {
-    if $pretty; then
-        printf "  TEST    iotest: %s" "$1"
-    else
-        printf "%s" "$1"
+    if $make_check; then
+        printf "  TEST    iotest: %s\r" "$1"
+        return
     fi
+
+    if [ -n "$3" ]; then
+        local lasttime=3D" (last: $3s)"
+    fi
+    printf "%-8s %-10s [%s]            %4s%-14s\r" "$1" "..." "$2" "..."=
 "$lasttime"
 }
-# args: output
+
+# args: $seq, $starttime, $lasttime, $thistime, $status, details
 _report_test_result()
 {
-    printf "%s\n" "$1"
+    local status lasttime thistime
+
+    if $make_check; then
+        if [ -n "$5" ] && [ "$5" !=3D "pass" ]; then
+            status=3D" [$5]"
+        fi
+        printf "  TEST    iotest: %s%s\n" "$1" "$status"
+        return
+    fi
+
+    if [ -n "$3" ]; then
+        lasttime=3D" (last: $3s)"
+    fi
+    if [ -n "$4" ]; then
+        thistime=3D" $4s"
+    fi
+    case "$5" in
+        "pass")     status=3D$(printf "\e[32m%-10s\e[0m" "$5") ;;
+        "fail")     status=3D$(printf "\e[1m\e[31m%-10s\e[0m" "$5") ;;
+        "not run")  status=3D$(printf "\e[33m%-10s\e[0m" "$5") ;;
+        *)          status=3D$(printf "%-10s" "$5") ;;
+    esac
+
+    printf "%-8s %s [%s] [%s] %4s%-14s %s\n" "$1" "$status" "$2" "$(date=
 '+%T')" "$thistime" "$lasttime" "$6"
 }
=20
 [ -f $TIMESTAMP_FILE ] || touch $TIMESTAMP_FILE
@@ -735,7 +756,7 @@ _report_test_result()
 FULL_IMGFMT_DETAILS=3D$(_full_imgfmt_details)
 FULL_HOST_DETAILS=3D$(_full_platform_details)
=20
-if ! $pretty; then
+if ! $make_check; then
     _full_env_details
 fi
=20
@@ -745,10 +766,10 @@ seq=3D"check"
=20
 for seq in $list
 do
-    _report_test_start $seq
-    err=3Dfalse     # error flag
-    reason=3D""     # reason for error
-    results=3D""    # results for non-error/skip
+    err=3Dfalse       # error flag
+    printdiff=3Dfalse # show diff to reference output?
+    status=3D""       # test result summary
+    results=3D""      # test result details
=20
     if [ -n "$TESTS_REMAINING_LOG" ] ; then
         sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_LOG=
 > $TESTS_REMAINING_LOG.tmp
@@ -756,17 +777,23 @@ do
         sync
     fi
=20
+    lasttime=3D$(sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE)
+    starttime=3D$(date "+%T")
+    _report_test_start $seq $starttime $lasttime
+
     if $showme
     then
-        continue
+        status=3D"not run"
     elif [ -f expunged ] && $expunge && egrep "^$seq([         ]|\$)" ex=
punged >/dev/null
     then
-        echo " - expunged"
+        status=3D"not run"
+        results=3D"expunged"
         rm -f $seq.out.bad
         echo "/^$seq\$/d" >>$tmp.expunged
     elif [ ! -f "$source_iotests/$seq" ]
     then
-        echo " - no such test?"
+        status=3D"not run"
+        results=3D"no such test?"
         echo "/^$seq\$/d" >>$tmp.expunged
     else
         # really going to try and run this one
@@ -776,7 +803,6 @@ do
         rm -f $seq.casenotrun
=20
         start=3D$(_wallclock)
-        $timestamp && _timestamp
=20
         if [ "$(head -n 1 "$source_iotests/$seq")" =3D=3D "#!/usr/bin/en=
v python" ]; then
             run_command=3D"$PYTHON $seq"
@@ -794,24 +820,26 @@ do
                     $run_command >$tmp.out 2>&1)
         fi
         sts=3D$?
-        $timestamp && _timestamp
         stop=3D$(_wallclock)
=20
         if [ -f core ]
         then
             mv core $seq.core
-            reason=3D"[dumped core] $seq.core"
+            status=3D"fail"
+            results=3D"[dumped core] $seq.core"
             err=3Dtrue
         fi
=20
         if [ -f $seq.notrun ]
         then
             # overwrites timestamp output
-            results=3D"[not run] $(cat $seq.notrun)"
+            status=3D"not run"
+            results=3D"$(cat $seq.notrun)"
         else
             if [ $sts -ne 0 ]
             then
-                reason=3D$(printf %s "[failed, exit status $sts]")
+                status=3D"fail"
+                results=3D$(printf %s "[failed, exit status $sts]")
                 err=3Dtrue
             fi
=20
@@ -830,31 +858,24 @@ do
                 [ -f "$source_iotests/$seq.out.nocache" ] && reference=3D=
"$source_iotests/$seq.out.nocache"
             fi
=20
+            thistime=3D$(expr $stop - $start)
             if [ ! -f "$reference" ]
             then
-                reason=3D"- no qualified output"
+                status=3D"fail"
+                results=3D"no qualified output"
                 err=3Dtrue
             else
                 if diff -w "$reference" $tmp.out >/dev/null 2>&1
                 then
-                    if $err
-                    then
-                        :
-                    else
-                        lasttime=3D$(sed -n -e "/^$seq /s/.* //p" <$TIME=
STAMP_FILE)
-                        thistime=3D$(expr $stop - $start)
+                    if ! $err; then
+                        status=3D"pass"
                         echo "$seq $thistime" >>$tmp.time
-
-                        if [ "X$lasttime" !=3D X ]; then
-                            results=3D"${results}${thistime}s (last ${la=
sttime}s)"
-                        else
-                            results=3D"${results}${thistime}s"
-                        fi
                     fi
                 else
                     mv $tmp.out $seq.out.bad
-                    $diff -w "$reference" "$PWD"/$seq.out.bad
-                    reason=3D"- output mismatch (see $seq.out.bad)"
+                    status=3D"fail"
+                    results=3D"output mismatch (see $seq.out.bad)"
+                    printdiff=3Dtrue
                     err=3Dtrue
                 fi
             fi
@@ -868,19 +889,28 @@ do
=20
     # come here for each test, except when $showme is true
     #
-    if $err
-    then
-        _report_test_result " FAILED $reason"
-        if $pretty; then
-            _full_env_details
-        fi
-        bad=3D"$bad $seq"
-        n_bad=3D$(expr $n_bad + 1)
-        quick=3Dfalse
-    else
-        _report_test_result " $results"
-    fi
-    [ -f $seq.notrun ] || try=3D$(expr $try + 1)
+    _report_test_result $seq "$starttime" "$lasttime" "$thistime" "$stat=
us" "$results"
+
+    case "$status" in
+        "pass")
+            try=3D$(expr $try + 1)
+            ;;
+        "fail")
+            try=3D$(expr $try + 1)
+            if $make_check; then
+                _full_env_details
+            fi
+            if $printdiff; then
+                $diff -w "$reference" "$PWD"/$seq.out.bad
+            fi
+            bad=3D"$bad $seq"
+            n_bad=3D$(expr $n_bad + 1)
+            quick=3Dfalse
+            ;;
+        "not run")
+            notrun=3D"$notrun $seq"
+            ;;
+    esac
=20
     seq=3D"after_$seq"
 done

