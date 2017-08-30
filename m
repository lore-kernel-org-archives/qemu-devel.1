Received: from eggs.gnu.org ([2001:4830:134:3::10]:56422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6F0-0001Ud-Lb
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6Et-0004yX-Kp
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:22 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 30 Aug 2017 12:52:44 -0400
Message-Id: <9b840c1229f3e25cf8ccf0d27bfabf37c751d5e1.1504111803.git.jcody@redhat.com>
In-Reply-To: <cover.1504111803.git.jcody@redhat.com>
References: <cover.1504111803.git.jcody@redhat.com>
In-Reply-To: <cover.1504111803.git.jcody@redhat.com>
References: <cover.1504111803.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/5] qemu-iotests: remove file cleanup from
 bash tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com, eblake@redhat.com

All files for a given test are now self-contained in a subdirectory,
and therefore the "./check" script can do all file-related cleanup
without any help.

This removes file cleanups from the bash tests.  The only cleanup left
is whatever is needed to kill any spawned processes; e.g. _cleanup_qemu.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/001     |  6 ------
 tests/qemu-iotests/002     |  6 ------
 tests/qemu-iotests/003     |  6 ------
 tests/qemu-iotests/004     |  6 ------
 tests/qemu-iotests/005     |  6 ------
 tests/qemu-iotests/007     |  7 -------
 tests/qemu-iotests/008     |  6 ------
 tests/qemu-iotests/009     |  6 ------
 tests/qemu-iotests/010     |  6 ------
 tests/qemu-iotests/011     |  6 ------
 tests/qemu-iotests/012     |  6 ------
 tests/qemu-iotests/013     |  6 ------
 tests/qemu-iotests/014     |  6 ------
 tests/qemu-iotests/015     |  7 -------
 tests/qemu-iotests/017     |  6 ------
 tests/qemu-iotests/018     |  6 ------
 tests/qemu-iotests/019     |  8 --------
 tests/qemu-iotests/020     |  8 --------
 tests/qemu-iotests/021     |  6 ------
 tests/qemu-iotests/022     |  6 ------
 tests/qemu-iotests/023     |  6 ------
 tests/qemu-iotests/024     |  8 --------
 tests/qemu-iotests/025     |  6 ------
 tests/qemu-iotests/026     |  7 -------
 tests/qemu-iotests/027     |  6 ------
 tests/qemu-iotests/028     |  8 --------
 tests/qemu-iotests/029     |  7 -------
 tests/qemu-iotests/031     |  6 ------
 tests/qemu-iotests/032     |  6 ------
 tests/qemu-iotests/033     |  6 ------
 tests/qemu-iotests/034     |  6 ------
 tests/qemu-iotests/035     |  6 ------
 tests/qemu-iotests/036     |  6 ------
 tests/qemu-iotests/037     |  6 ------
 tests/qemu-iotests/038     |  6 ------
 tests/qemu-iotests/039     |  6 ------
 tests/qemu-iotests/042     |  6 ------
 tests/qemu-iotests/043     |  7 -------
 tests/qemu-iotests/046     |  6 ------
 tests/qemu-iotests/047     |  6 ------
 tests/qemu-iotests/048     |  8 --------
 tests/qemu-iotests/048.out |  1 -
 tests/qemu-iotests/049     |  6 ------
 tests/qemu-iotests/050     |  8 --------
 tests/qemu-iotests/051     |  6 ------
 tests/qemu-iotests/052     |  6 ------
 tests/qemu-iotests/053     |  7 -------
 tests/qemu-iotests/054     |  6 ------
 tests/qemu-iotests/058     |  8 +-------
 tests/qemu-iotests/059     |  7 -------
 tests/qemu-iotests/060     |  6 ------
 tests/qemu-iotests/061     |  6 ------
 tests/qemu-iotests/062     |  6 ------
 tests/qemu-iotests/063     |  7 -------
 tests/qemu-iotests/064     |  6 ------
 tests/qemu-iotests/066     |  6 ------
 tests/qemu-iotests/068     |  6 ------
 tests/qemu-iotests/069     |  6 ------
 tests/qemu-iotests/070     |  6 ------
 tests/qemu-iotests/071     |  6 ------
 tests/qemu-iotests/072     |  6 ------
 tests/qemu-iotests/073     |  6 ------
 tests/qemu-iotests/074     |  9 ---------
 tests/qemu-iotests/074.out |  1 -
 tests/qemu-iotests/075     |  6 ------
 tests/qemu-iotests/076     |  6 ------
 tests/qemu-iotests/077     |  6 ------
 tests/qemu-iotests/078     |  6 ------
 tests/qemu-iotests/079     |  6 ------
 tests/qemu-iotests/080     |  7 -------
 tests/qemu-iotests/081     |  8 --------
 tests/qemu-iotests/082     |  6 ------
 tests/qemu-iotests/084     |  6 ------
 tests/qemu-iotests/085     | 13 +------------
 tests/qemu-iotests/086     |  6 ------
 tests/qemu-iotests/088     |  7 -------
 tests/qemu-iotests/089     |  6 ------
 tests/qemu-iotests/090     |  6 ------
 tests/qemu-iotests/091     |  8 +-------
 tests/qemu-iotests/092     |  7 -------
 tests/qemu-iotests/094     |  9 +--------
 tests/qemu-iotests/095     |  8 +-------
 tests/qemu-iotests/097     |  7 -------
 tests/qemu-iotests/098     |  7 -------
 tests/qemu-iotests/099     |  6 ------
 tests/qemu-iotests/101     |  6 ------
 tests/qemu-iotests/102     |  7 +------
 tests/qemu-iotests/103     |  6 ------
 tests/qemu-iotests/104     |  2 --
 tests/qemu-iotests/105     |  6 ------
 tests/qemu-iotests/106     |  6 ------
 tests/qemu-iotests/107     |  6 ------
 tests/qemu-iotests/108     |  6 ------
 tests/qemu-iotests/109     |  8 +-------
 tests/qemu-iotests/110     |  6 ------
 tests/qemu-iotests/111     |  6 ------
 tests/qemu-iotests/112     |  6 ------
 tests/qemu-iotests/113     |  6 ------
 tests/qemu-iotests/114     |  6 ------
 tests/qemu-iotests/115     |  6 ------
 tests/qemu-iotests/116     |  6 ------
 tests/qemu-iotests/117     |  7 +------
 tests/qemu-iotests/119     |  6 ------
 tests/qemu-iotests/120     |  6 ------
 tests/qemu-iotests/121     |  6 ------
 tests/qemu-iotests/122     |  7 -------
 tests/qemu-iotests/123     |  7 -------
 tests/qemu-iotests/125     |  6 ------
 tests/qemu-iotests/130     |  7 +------
 tests/qemu-iotests/131     |  6 ------
 tests/qemu-iotests/133     |  6 ------
 tests/qemu-iotests/134     |  6 ------
 tests/qemu-iotests/135     |  6 ------
 tests/qemu-iotests/137     |  6 ------
 tests/qemu-iotests/138     |  6 ------
 tests/qemu-iotests/140     |  8 +-------
 tests/qemu-iotests/141     |  8 +-------
 tests/qemu-iotests/142     |  7 -------
 tests/qemu-iotests/143     |  7 +------
 tests/qemu-iotests/144     |  8 +-------
 tests/qemu-iotests/145     |  7 -------
 tests/qemu-iotests/146     |  7 +------
 tests/qemu-iotests/150     |  6 ------
 tests/qemu-iotests/153     | 12 ------------
 tests/qemu-iotests/154     |  6 ------
 tests/qemu-iotests/156     |  7 +------
 tests/qemu-iotests/157     |  6 ------
 tests/qemu-iotests/158     |  6 ------
 tests/qemu-iotests/159     |  7 -------
 tests/qemu-iotests/160     |  7 -------
 tests/qemu-iotests/162     |  7 -------
 tests/qemu-iotests/170     |  7 -------
 tests/qemu-iotests/171     |  6 ------
 tests/qemu-iotests/172     |  8 --------
 tests/qemu-iotests/173     |  8 +-------
 tests/qemu-iotests/174     |  6 ------
 tests/qemu-iotests/175     |  6 ------
 tests/qemu-iotests/176     |  7 -------
 tests/qemu-iotests/177     |  6 ------
 tests/qemu-iotests/178     |  7 -------
 tests/qemu-iotests/179     |  7 -------
 tests/qemu-iotests/181     |  8 +-------
 tests/qemu-iotests/182     |  6 ------
 tests/qemu-iotests/183     |  9 +--------
 tests/qemu-iotests/185     |  9 +--------
 tests/qemu-iotests/186     |  6 ------
 tests/qemu-iotests/187     |  8 --------
 tests/qemu-iotests/188     |  6 ------
 tests/qemu-iotests/189     |  6 ------
 tests/qemu-iotests/190     |  7 -------
 tests/qemu-iotests/192     |  6 ------
 151 files changed, 19 insertions(+), 965 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index ffd14e2..6f71879 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index d4f8e91..4c9ff23 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index 19889b9..2648d03 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 6f2aa3d..99743b4 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 4447377..23a77e0 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -30,12 +30,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index fa543ee..c8068e5 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-	true
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index 8e89d74..7f7f8ae 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index 16e4475..e03412a 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 151dac2..8608848 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index f8d044e..0c0d15f 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 01a770d..aa9cfb4 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -29,12 +29,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index d013f87..0ff9c4d 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index 2ea79e8..3dee9f7 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -29,12 +29,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index aaf9c3f..d29a778 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-	true
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 4f9302d..994ea0e 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index 1d39d35..11ad2b1 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index 24a789a..3728193 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -29,14 +29,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-    rm -f "$TEST_IMG.base"
-    rm -f "$TEST_IMG.orig"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 7a11110..37cd5d1 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -27,14 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-    rm -f "$TEST_IMG.base"
-    rm -f "$TEST_IMG.orig"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index 11e8ed7..5ab2acb 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index 2452a9f..4870b17 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -29,12 +29,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index 497ae1e..5a2bf4e 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index e0d77ce..3e638d9 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -27,14 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-	rm -f "$TEST_DIR/t.$IMGFMT.base_old"
-	rm -f "$TEST_DIR/t.$IMGFMT.base_new"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index f5e672e..93634c1 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 7fadfba..dc4ff9f 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-    rm "$TEST_DIR/blkdebug.conf"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index 08593da..c3f9146 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 97a8869..3176789 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -30,14 +30,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    rm -f "${TEST_IMG}.copy"
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 30bab24..981a864 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    rm -f $TEST_IMG.snap
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index 1e08abc..6805c2c 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index 24bcb52..dafcfb8 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -29,12 +29,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 2cdfd13..bf3c59c 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index 1b28bda..830b0db 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index efc38e4..a79a4fd 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index ce638d6..841f347 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -30,12 +30,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index c476b82..756fc2c 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index d99a150..cf730ae 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 1f48339..dd483c4 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -30,12 +30,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index a53e7cb..0efeec6 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index 1c6c22d..48b71fe 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f "$TEST_IMG".[123].base
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index f2ebecf..362ed94 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index 1b8f3d4..1850035 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
index 9ed04a0..c95bd2f 100755
--- a/tests/qemu-iotests/048
+++ b/tests/qemu-iotests/048
@@ -27,14 +27,6 @@ echo "QA output created by $seq"
 
 status=1        # failure is the default!
 
-_cleanup()
-{
-    echo "Cleanup"
-    _cleanup_test_img
-    rm "${TEST_IMG_FILE2}"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 _compare()
 {
     $QEMU_IMG compare $QEMU_IMG_EXTRA_ARGS "$@" "$TEST_IMG" "${TEST_IMG2}"
diff --git a/tests/qemu-iotests/048.out b/tests/qemu-iotests/048.out
index 0bcf663..3318eed 100644
--- a/tests/qemu-iotests/048.out
+++ b/tests/qemu-iotests/048.out
@@ -39,4 +39,3 @@ wrote 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Content mismatch at offset 512!
 1
-Cleanup
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index df35b6d..00733a6 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 03b4a5d..e3b6d8c 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -27,14 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f "$TEST_IMG.old"
-    rm -f "$TEST_IMG.new"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index c8cfc76..7060c3e 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 842eace..fc23fad 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index 2a04f5f..e8b9037 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	rm -f "$TEST_IMG.orig"
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index bf47ef9..e2de997 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 2253c6a..a842fe4 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -75,13 +75,7 @@ _export_nbd_snapshot1()
     _wait_for_nbd
 }
 
-_cleanup()
-{
-    _cleanup_nbd
-    _cleanup_test_img
-    rm -f "$converted_image"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_nbd; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index a1c34ee..6ccd250 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f "$TEST_IMG.qcow2"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 8e95c45..6532837 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index f5678b1..1346dd9 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 051fb9f..3a1df0d 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index e4f6ea9..4a9fc44 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -28,13 +28,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-	rm -f "$TEST_IMG.orig" "$TEST_IMG.raw1" "$TEST_IMG.raw2"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index 5792fbb..211c541 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 8638217..e811f48 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index cfa0f2a..dd98227 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index 96e55ef..03d5a3c 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index 8d08d74..1220cc1 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 48b4955..1a8d6e7 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index aa027c7..8aaf3fd 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 40f85b1..c19ad0d 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/074 b/tests/qemu-iotests/074
index b17866b..d7888ab 100755
--- a/tests/qemu-iotests/074
+++ b/tests/qemu-iotests/074
@@ -27,15 +27,6 @@ echo "QA output created by $seq"
 
 status=1        # failure is the default!
 
-_cleanup()
-{
-    echo "Cleanup"
-    _cleanup_test_img
-    rm "${TEST_IMG2}"
-    rm -f "$TEST_DIR/blkdebug.conf"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 _compare()
 {
     $QEMU_IMG compare "$@" "$TEST_IMG" "${TEST_IMG2}"
diff --git a/tests/qemu-iotests/074.out b/tests/qemu-iotests/074.out
index 8fba5ae..fb93965 100644
--- a/tests/qemu-iotests/074.out
+++ b/tests/qemu-iotests/074.out
@@ -15,4 +15,3 @@ qemu-img: Error while reading offset 0 of blkdebug:TEST_DIR/blkdebug.conf:TEST_D
 qemu-img: Error while reading offset 0 of blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
 Warning: Image size mismatch!
 4
-Cleanup
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index 770d51c..c2509d1 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index ef9e6a4..69bccad 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index d2d2a2d..4a458e1 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index f333e9a..22d078e 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index b2e3f74..fba6ec6 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 55044c7..be548a9 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    rm -f $TEST_IMG.snap
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index da3fb09..2dadc16 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -27,14 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    rm -rf $TEST_DIR/1.raw
-    rm -rf $TEST_DIR/2.raw
-    rm -rf $TEST_DIR/3.raw
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index d5c83d4..aa585db 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 04f2aa9..b0d42a0 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 5c7668c..7b69f86 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -37,18 +37,7 @@ snapshot_virt1="snapshot-v1.qcow2"
 
 SNAPSHOTS=10
 
-_cleanup()
-{
-    _cleanup_qemu
-    for i in $(seq 1 ${SNAPSHOTS})
-    do
-        rm -f "${TEST_DIR}/${i}-${snapshot_virt0}"
-        rm -f "${TEST_DIR}/${i}-${snapshot_virt1}"
-    done
-    rm -f "${TEST_IMG}" "${TEST_IMG}.1" "${TEST_IMG}.2" "${TEST_IMG}.base"
-
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index cd4494a..4d5f7db 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index b8076f2..72e7c68 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    rm -f $TEST_IMG.snap
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 9bfe230..75151f1 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 7380503..c3be13c 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 10ac4a8..c4df2fb 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -31,13 +31,7 @@ status=1    # failure is the default!
 
 MIG_FIFO="${TEST_DIR}/migrate"
 
-_cleanup()
-{
-    rm -f "${MIG_FIFO}"
-    _cleanup_qemu
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index 5bbdd07..3b8cf8f 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    rm -f $TEST_IMG.snap
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 9aa01e3..35e882c 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -27,14 +27,7 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    _cleanup_test_img
-    rm -f "$TEST_DIR/source.$IMGFMT"
-}
-
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 030adb2..75d60c4 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -30,13 +30,7 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    rm  -f "${TEST_IMG}.base" "${TEST_IMG}.snp1"
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index e22670c..81e6729 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -28,13 +28,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-    _rm_test_img "$TEST_IMG.itmd"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index b002e96..24d8510 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f "$TEST_DIR/blkdebug.conf"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index caaf58e..d811b34 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index ea53f8b..62faf99 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 87db1bb..084d2cf 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -27,12 +27,7 @@ echo "QA output created by $seq"
 here=$PWD
 status=1    # failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and qemu instance handling
 . ./common.rc
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index ecbd8eb..df86d4f 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=$PWD
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 726d467..f10d311 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -27,8 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-trap "exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 3db4ce3..b469b1b 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index 3264957..b571971 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=$PWD
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment and filters
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index d7222dc..d513120 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 2355d98..8371db4 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index d70b574..d4fca99 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -27,13 +27,7 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    rm -f $TEST_IMG.src
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 9de7369..93dd09f 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index a1c152d..f590d82 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index 28eb9aa..ee3679e 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index 19b68b2..07437ea 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index 5b7dc54..5bfd473 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 665c2ea..0c9aaad 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index df0172f..e687601 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -30,12 +30,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 6c83461..579cecb 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -27,12 +27,7 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index 4f34fb4..8cdb404 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index f40b97d..bb0e2dd 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index 1307b4e..d75fce1 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 45b359c..3942604 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    rm -f "$TEST_IMG".[123]
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index b18e3fc..98fd3ce 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f "$SRC_IMG"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 9424313..bca5fb5 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=$PWD
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 get_image_size_on_host()
 {
     $QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" | grep "disk size" \
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index e7e43de..4aad4ea 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -29,12 +29,7 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 94a9ae7..52588ef 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 9d35a6a..2d0aae9 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 9914415..147ea2c 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index ce60831..75c160d 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index eb91e51..6068a13 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 21650d8..9682560 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index f89d0d6..c5e1a5b 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -31,13 +31,7 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    _cleanup_test_img
-    rm -f "$TEST_DIR/nbd"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 2f9d7b9..cff2319 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -27,13 +27,7 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    _cleanup_test_img
-    rm -f "$TEST_DIR"/{b,m,o}.$IMGFMT
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 1639c83..65775be 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f $TEST_IMG.snap
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index 5ff1944..b4736aa 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -27,12 +27,7 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    rm -f "$TEST_DIR/nbd"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 00de3c3..b47c561 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -32,13 +32,7 @@ status=1	# failure is the default!
 TMP_SNAP1=${TEST_DIR}/tmp.qcow2
 TMP_SNAP2=${TEST_DIR}/tmp2.qcow2
 
-_cleanup()
-{
-    _cleanup_qemu
-    rm -f "${TEST_IMG}" "${TMP_SNAP1}" "${TMP_SNAP2}"
-}
-
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index c371b3c..930628e 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-	true
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 043711b..99b1e81 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -27,12 +27,7 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1    # failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/150 b/tests/qemu-iotests/150
index ee8f637..120920e 100755
--- a/tests/qemu-iotests/150
+++ b/tests/qemu-iotests/150
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index fa25eb2..42882eb 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -28,18 +28,6 @@ here="$PWD"
 tmp=/tmp/$$
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f "${TEST_IMG}.base"
-    rm -f "${TEST_IMG}.convert"
-    rm -f "${TEST_IMG}.a"
-    rm -f "${TEST_IMG}.b"
-    rm -f "${TEST_IMG}.c"
-    rm -f "${TEST_IMG}.lnk"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index fde03b0..90e7e65 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index e75dc4d..9dbc6d7 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -35,12 +35,7 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    rm -f "$TEST_IMG"{,.target}{,.backing,.overlay}
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 2bf02be..bda53c8 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 24ac600..a07708e 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 9b0e1ec..7fcccde 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -26,13 +26,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f "$TEST_IMG.out"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 . ./common.rc
 . ./common.filter
 . ./common.pattern
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index 5c910e5..48dd25d 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -26,13 +26,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f "$TEST_IMG.out" "$TEST_IMG.out.dd"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 . ./common.rc
 . ./common.filter
 . ./common.pattern
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 477a806..cad2bd7 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -28,13 +28,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    rm -f "${TEST_DIR}/qemu-nbd.pid"
-    rm -f 42
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index b79359f..5288a2d 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -26,13 +26,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f "$TEST_IMG.out"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 . ./common.rc
 . ./common.filter
 . ./common.pattern
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index bcfaaf1..2798d2f 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 826d6fe..125c1d9 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -27,14 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-    rm -f "$TEST_IMG.2"
-    rm -f "$TEST_IMG.3"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index bdaa092..0c2fde4 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -27,13 +27,7 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1    # failure is the default!
 
-_cleanup()
-{
-    _cleanup_qemu
-    rm  -f "${QEMU_TEST_DIR}/image.base" "${QEMU_TEST_DIR}/image.snp1"
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index 552879d..67cd785 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index ca56e82..1407597 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 950b287..56cd490 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -31,13 +31,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-    _rm_test_img "$TEST_IMG.itmd"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index f8ed8fb..ed2e8b2 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 6af52c6..fd583d1 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1    # failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f "$TEST_IMG.converted"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 115944a..f7cf129 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-    rm -f "$TEST_DIR/blkdebug.conf"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index 0333dda..8abc61a 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -29,13 +29,7 @@ status=1	# failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
 
-_cleanup()
-{
-    rm -f "${MIG_SOCKET}"
-	_cleanup_test_img
-    _cleanup_qemu
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 7ecbb22..a4cbb03 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -28,12 +28,6 @@ here="$PWD"
 tmp=/tmp/$$
 status=1	# failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 20268ff..2e09679 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -29,14 +29,7 @@ status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
 
-_cleanup()
-{
-    rm -f "${MIG_SOCKET}"
-    rm -f "${TEST_IMG}.dest"
-    _cleanup_test_img
-    _cleanup_qemu
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index f5b47e4..7269d5e 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -29,14 +29,7 @@ status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
 
-_cleanup()
-{
-    rm -f "${TEST_IMG}.mid"
-    rm -f "${TEST_IMG}.copy"
-    _cleanup_test_img
-    _cleanup_qemu
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
+trap "_cleanup_qemu; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 2b9f618..e301871 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index 7bb7833..8b29df3 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -27,14 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-    rm -f "$TEST_IMG.2"
-    rm -f "$TEST_IMG.3"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index 83ed03e..48f855d 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index e695475..c5d516d 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -27,12 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 8f808fe..84d20c6 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -27,13 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1    # failure is the default!
 
-_cleanup()
-{
-    _cleanup_test_img
-    rm -f "$TEST_IMG.converted"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index b50a2c0..6a95b81 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -28,12 +28,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
-_cleanup()
-{
-	_cleanup_test_img
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
-- 
2.9.5
