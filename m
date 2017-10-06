Received: from eggs.gnu.org ([2001:4830:134:3::10]:55994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxz-0000fF-KY
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxy-0003Q9-Tk
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:52 +0200
Message-Id: <20171006155422.10135-25-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 24/54] qemu-iotests: get rid of AWK_PROG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/check         | 4 ++--
 tests/qemu-iotests/common        | 2 +-
 tests/qemu-iotests/common.config | 3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 041780b09f..67da67bd54 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -128,7 +128,7 @@ tmp="${TEST_DIR}"/$$
 
 _wallclock()
 {
-    date "+%H %M %S" | $AWK_PROG '{ print $1*3600 + $2*60 + $3 }'
+    date "+%H %M %S" | awk '{ print $1*3600 + $2*60 + $3 }'
 }
 
 _timestamp()
@@ -147,7 +147,7 @@ _wrapup()
         if [ -f $TIMESTAMP_FILE -a -f $tmp.time ]
         then
             cat $TIMESTAMP_FILE $tmp.time \
-            | $AWK_PROG '
+            | awk '
         { t[$1] = $2 }
 END        { if (NR > 0) {
             for (i in t) print i " " t[i]
diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index 867918895b..130f647a4d 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -366,7 +366,7 @@ testlist options
     if $xpand
     then
         have_test_arg=true
-        $AWK_PROG </dev/null '
+        awk </dev/null '
 BEGIN        { for (t='$start'; t<='$end'; t++) printf "%03d\n",t }' \
         | while read id
         do
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common.config
index b599c72211..0f571d46eb 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -56,9 +56,6 @@ _fatal()
     exit 1
 }
 
-export AWK_PROG="`set_prog_path awk`"
-[ "$AWK_PROG" = "" ] && _fatal "awk not found"
-
 if [ -z "$QEMU_PROG" ]; then
     export QEMU_PROG="`set_prog_path qemu`"
 fi
-- 
2.13.6
