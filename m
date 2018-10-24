Received: from eggs.gnu.org ([2001:4830:134:3::10]:39689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfW-00054y-9R
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfP-0004wH-VV
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:38 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:56475)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gFFfL-0004n1-KI
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:41:28 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Wed, 24 Oct 2018 17:40:51 +0800
Message-Id: <20181024094051.4470-4-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
References: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v2 3/3] qemu-iotests: Modern shell scripting
 (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

Various shell files contain a mix between obsolete ``
and modern $(); It would be nice to convert to using
$() everywhere.

Cc: kwolf@redhat.com
Cc: mreitz@redhat.com
Cc: eblake@redhat.com

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 tests/qemu-iotests/check         | 60 ++++++++++++++++----------------
 tests/qemu-iotests/common.config |  4 +--
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index b37713277d..89ed275988 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -80,17 +80,17 @@ _full_imgfmt_details()
 
 _full_platform_details()
 {
-    os=`uname -s`
-    host=`hostname -s`
-    kernel=`uname -r`
-    platform=`uname -m`
+    os=$(uname -s)
+    host=$(hostname -s)
+    kernel=$(uname -r)
+    platform=$(uname -m)
     echo "$os/$platform $host $kernel"
 }
 
 # $1 = prog to look for
 set_prog_path()
 {
-    p=`command -v $1 2> /dev/null`
+    p=$(command -v $1 2> /dev/null)
     if [ -n "$p" -a -x "$p" ]; then
         type -p "$p"
     else
@@ -147,9 +147,9 @@ do
     if $group
     then
         # arg after -g
-        group_list=`sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[0-9][0-9][0-9].* $r /"'{
+        group_list=$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[0-9][0-9][0-9].* $r /"'{
 s/ .*//p
-}'`
+}')
         if [ -z "$group_list" ]
         then
             echo "Group \"$r\" is empty or not defined?"
@@ -173,9 +173,9 @@ s/ .*//p
         # arg after -x
         # Populate $tmp.list with all tests
         awk '/^[0-9]{3,}/ {print $1}' "${source_iotests}/group" > $tmp.list 2>/dev/null
-        group_list=`sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[0-9][0-9][0-9].* $r /"'{
+        group_list=$(sed -n <"$source_iotests/group" -e 's/$/ /' -e "/^[0-9][0-9][0-9].* $r /"'{
 s/ .*//p
-}'`
+}')
         if [ -z "$group_list" ]
         then
             echo "Group \"$r\" is empty or not defined?"
@@ -193,7 +193,7 @@ s/ .*//p
                 rm -f $tmp.sed
             fi
             echo "/^$t\$/d" >>$tmp.sed
-            numsed=`expr $numsed + 1`
+            numsed=$(expr $numsed + 1)
         done
         sed -f $tmp.sed <$tmp.list >$tmp.tmp
         mv $tmp.tmp $tmp.list
@@ -433,12 +433,12 @@ testlist options
             ;;
 
         [0-9]*-[0-9]*)
-            eval `echo $r | sed -e 's/^/start=/' -e 's/-/ end=/'`
+            eval $(echo $r | sed -e 's/^/start=/' -e 's/-/ end=/')
             ;;
 
         [0-9]*-)
-            eval `echo $r | sed -e 's/^/start=/' -e 's/-//'`
-            end=`echo [0-9][0-9][0-9] [0-9][0-9][0-9][0-9] | sed -e 's/\[0-9]//g' -e 's/  *$//' -e 's/.* //'`
+            eval $(echo $r | sed -e 's/^/start=/' -e 's/-//')
+            end=$(echo [0-9][0-9][0-9] [0-9][0-9][0-9][0-9] | sed -e 's/\[0-9]//g' -e 's/  *$//' -e 's/.* //')
             if [ -z "$end" ]
             then
                 echo "No tests in range \"$r\"?"
@@ -455,8 +455,8 @@ testlist options
     esac
 
     # get rid of leading 0s as can be interpreted as octal
-    start=`echo $start | sed 's/^0*//'`
-    end=`echo $end | sed 's/^0*//'`
+    start=$(echo $start | sed 's/^0*//')
+    end=$(echo $end | sed 's/^0*//')
 
     if $xpand
     then
@@ -531,7 +531,7 @@ fi
 # should be sort -n, but this did not work for Linux when this
 # was ported from IRIX
 #
-list=`sort $tmp.list`
+list=$(sort $tmp.list)
 rm -f $tmp.list $tmp.tmp $tmp.sed
 
 if [ -z "$QEMU_PROG" ]
@@ -590,7 +590,7 @@ fi
 export QEMU_NBD_PROG="$(type -p "$QEMU_NBD_PROG")"
 
 if [ -z "$QEMU_VXHS_PROG" ]; then
-  export QEMU_VXHS_PROG="`set_prog_path qnio_server`"
+    export QEMU_VXHS_PROG="$(set_prog_path qnio_server)"
 fi
 
 if [ -x "$build_iotests/socket_scm_helper" ]
@@ -616,7 +616,7 @@ _wallclock()
 
 _timestamp()
 {
-    now=`date "+%T"`
+    now=$(date "+%T")
     printf %s " [$now]"
 }
 
@@ -642,9 +642,9 @@ END        { if (NR > 0) {
 
         if [ -f $tmp.expunged ]
         then
-            notrun=`wc -l <$tmp.expunged | sed -e 's/  *//g'`
-            try=`expr $try - $notrun`
-            list=`echo "$list" | sed -f $tmp.expunged`
+            notrun=$(wc -l <$tmp.expunged | sed -e 's/  *//g')
+            try=$(expr $try - $notrun)
+            list=$(echo "$list" | sed -f $tmp.expunged)
         fi
 
         echo "" >>check.log
@@ -682,8 +682,8 @@ trap "_wrapup; exit \$status" 0 1 2 3 15
 
 [ -f $TIMESTAMP_FILE ] || touch $TIMESTAMP_FILE
 
-FULL_IMGFMT_DETAILS=`_full_imgfmt_details`
-FULL_HOST_DETAILS=`_full_platform_details`
+FULL_IMGFMT_DETAILS=$(_full_imgfmt_details)
+FULL_HOST_DETAILS=$(_full_platform_details)
 
 cat <<EOF
 QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
@@ -729,7 +729,7 @@ do
         # really going to try and run this one
         #
         rm -f $seq.out.bad
-        lasttime=`sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE`
+        lasttime=$(sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE)
         if [ "X$lasttime" != X ]; then
                 printf %s " ${lasttime}s ..."
         else
@@ -737,7 +737,7 @@ do
         fi
         rm -f core $seq.notrun
 
-        start=`_wallclock`
+        start=$(_wallclock)
         $timestamp && printf %s "        [$(date "+%T")]"
 
         if [ "$(head -n 1 "$source_iotests/$seq")" == "#!/usr/bin/env python" ]; then
@@ -757,7 +757,7 @@ do
         fi
         sts=$?
         $timestamp && _timestamp
-        stop=`_wallclock`
+        stop=$(_wallclock)
 
         if [ -f core ]
         then
@@ -806,7 +806,7 @@ do
                     then
                         :
                     else
-                        echo "$seq `expr $stop - $start`" >>$tmp.time
+                        echo "$seq $(expr $stop - $start)" >>$tmp.time
                     fi
                 else
                     echo " - output mismatch (see $seq.out.bad)"
@@ -824,14 +824,14 @@ do
     if $err
     then
         bad="$bad $seq"
-        n_bad=`expr $n_bad + 1`
+        n_bad=$(expr $n_bad + 1)
         quick=false
     fi
-    [ -f $seq.notrun ] || try=`expr $try + 1`
+    [ -f $seq.notrun ] || try=$(expr $try + 1)
 
     seq="after_$seq"
 done
 
 interrupt=false
-status=`expr $n_bad`
+status=$(expr $n_bad)
 exit
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index d4721ba92d..74d1851865 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -21,8 +21,8 @@ export LANG=C
 
 PATH=".:$PATH"
 
-HOSTOS=`uname -s`
-arch=`uname -m`
+HOSTOS=$(uname -s)
+arch=$(uname -m)
 [[ "$arch" =~ "ppc64" ]] && qemu_arch=ppc64 || qemu_arch="$arch"
 
 export PWD=$PWD
-- 
2.17.1
