Received: from eggs.gnu.org ([2001:4830:134:3::10]:51635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRA-0003nN-OR
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmR6-0001kK-RU
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:16 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Sep 2017 16:44:51 +0200
Message-Id: <20170912144459.11359-3-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-1-pbonzini@redhat.com>
References: <20170912144459.11359-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/10] qemu-iotests: get rid of AWK_PROG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/check         | 4 ++--
 tests/qemu-iotests/common        | 2 +-
 tests/qemu-iotests/common.config | 3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 4a6ed67b42..5c0d0c51dc 100755
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
2.13.5
