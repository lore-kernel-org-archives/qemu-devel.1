Received: from eggs.gnu.org ([2001:4830:134:3::10]:53998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4JZV-0001Ka-EP
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e4JZT-0005TA-SL
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:33:41 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 17 Oct 2017 00:32:42 -0400
Message-Id: <4a6a39c0f2d981479cb2d323fe6ef9eb73104ac1.1508213452.git.jcody@redhat.com>
In-Reply-To: <cover.1508213452.git.jcody@redhat.com>
References: <cover.1508213452.git.jcody@redhat.com>
In-Reply-To: <cover.1508213452.git.jcody@redhat.com>
References: <cover.1508213452.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v4 06/10] qemu-iotests: make ./check
 automatically reap QEMU processes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

Check will now take care of cleaning up all QEMU processes started
from bash tests using the common.qemu framework.

This also paves the way to added another check option to keep QEMU
processes around, in the case of a failed test.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/085   | 2 --
 tests/qemu-iotests/091   | 2 --
 tests/qemu-iotests/094   | 2 --
 tests/qemu-iotests/095   | 2 --
 tests/qemu-iotests/102   | 2 --
 tests/qemu-iotests/109   | 2 --
 tests/qemu-iotests/117   | 2 --
 tests/qemu-iotests/130   | 2 --
 tests/qemu-iotests/140   | 2 --
 tests/qemu-iotests/141   | 2 --
 tests/qemu-iotests/143   | 2 --
 tests/qemu-iotests/144   | 2 --
 tests/qemu-iotests/146   | 2 --
 tests/qemu-iotests/156   | 2 --
 tests/qemu-iotests/173   | 2 --
 tests/qemu-iotests/181   | 2 --
 tests/qemu-iotests/183   | 2 --
 tests/qemu-iotests/185   | 2 --
 tests/qemu-iotests/191   | 6 ------
 tests/qemu-iotests/check | 2 ++
 20 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 7b69f86..283f9a9 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -37,8 +37,6 @@ snapshot_virt1="snapshot-v1.qcow2"
 
 SNAPSHOTS=10
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index c4df2fb..cc4c50c 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -31,8 +31,6 @@ status=1    # failure is the default!
 
 MIG_FIFO="${TEST_DIR}/migrate"
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 35e882c..1587550 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -27,8 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 75d60c4..2891014 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -30,8 +30,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 201c520..2980638 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -27,8 +27,6 @@ echo "QA output created by $seq"
 here=$PWD
 status=1    # failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and qemu instance handling
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index d4fca99..2f6e456 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -27,8 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 579cecb..a427ee7 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -27,8 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index 4aad4ea..3610738 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -29,8 +29,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index c5e1a5b..ec79402 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -31,8 +31,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index cff2319..39b75a4 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -27,8 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index b4736aa..e107ae3 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -27,8 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index b47c561..8b55d33 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -32,8 +32,6 @@ status=1	# failure is the default!
 TMP_SNAP1=${TEST_DIR}/tmp.qcow2
 TMP_SNAP2=${TEST_DIR}/tmp2.qcow2
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 99b1e81..7dffe22 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -27,8 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1    # failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 9dbc6d7..26ebd73 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -35,8 +35,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index 0c2fde4..933cd96 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -27,8 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1    # failure is the default!
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index 18fb133..e6f7908 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -29,8 +29,6 @@ status=1	# failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 2e09679..cb82d3c 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -29,8 +29,6 @@ status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 7269d5e..ef4b1cd 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -29,8 +29,6 @@ status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
 
-trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index f97e580..7fc1365 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -29,12 +29,6 @@ status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
 
-_cleanup()
-{
-    _cleanup_qemu
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 45fad05..d2fb933 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -847,8 +847,10 @@ do
         export TEST_DIR=$TEST_DIR_SEQ
         . "$source_iotests/common.config"
         . "$source_iotests/common.rc"
+        . "$source_iotests/common.qemu"
 
         _cleanup_protocols
+        _cleanup_qemu
         )
         rm -rf "$TEST_DIR_SEQ"
 
-- 
2.9.5
