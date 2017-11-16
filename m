Received: from eggs.gnu.org ([2001:4830:134:3::10]:60026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7x-0007sG-LL
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7o-0003vd-8K
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:39:01 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 16 Nov 2017 12:38:05 -0500
Message-Id: <20171116173810.16457-6-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-1-crosa@redhat.com>
References: <20171116173810.16457-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 05/10] qemu-iotests: define functions used in
 _cleanup() before its use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>

The functions used in _cleanup() come from common.rc, which currently
gets sourced after _cleanup() is defined and registered as a signal
handler.  When _cleanup() is executed, it has no valid references to
those functions, as BASH won't resolve the reference at that time.

While at it, also fix some tabs versus spaces indentation in
_cleanup() in a few tests.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/001 |  6 +++---
 tests/qemu-iotests/002 |  6 +++---
 tests/qemu-iotests/003 |  6 +++---
 tests/qemu-iotests/004 |  6 +++---
 tests/qemu-iotests/005 |  6 +++---
 tests/qemu-iotests/007 |  6 +++---
 tests/qemu-iotests/008 |  6 +++---
 tests/qemu-iotests/009 |  6 +++---
 tests/qemu-iotests/010 |  6 +++---
 tests/qemu-iotests/011 |  6 +++---
 tests/qemu-iotests/012 |  6 +++---
 tests/qemu-iotests/013 |  8 ++++----
 tests/qemu-iotests/014 |  8 ++++----
 tests/qemu-iotests/015 |  6 +++---
 tests/qemu-iotests/017 |  8 ++++----
 tests/qemu-iotests/018 |  8 ++++----
 tests/qemu-iotests/019 |  8 ++++----
 tests/qemu-iotests/020 |  8 ++++----
 tests/qemu-iotests/021 |  6 +++---
 tests/qemu-iotests/022 |  8 ++++----
 tests/qemu-iotests/023 |  8 ++++----
 tests/qemu-iotests/024 |  8 ++++----
 tests/qemu-iotests/025 |  8 ++++----
 tests/qemu-iotests/026 |  8 ++++----
 tests/qemu-iotests/027 |  6 +++---
 tests/qemu-iotests/028 | 10 +++++-----
 tests/qemu-iotests/029 |  8 ++++----
 tests/qemu-iotests/031 |  8 ++++----
 tests/qemu-iotests/032 |  8 ++++----
 tests/qemu-iotests/033 |  6 +++---
 tests/qemu-iotests/034 |  6 +++---
 tests/qemu-iotests/035 |  6 +++---
 tests/qemu-iotests/036 |  8 ++++----
 tests/qemu-iotests/037 |  6 +++---
 tests/qemu-iotests/038 |  6 +++---
 tests/qemu-iotests/039 |  6 +++---
 tests/qemu-iotests/042 |  6 +++---
 tests/qemu-iotests/043 |  6 +++---
 tests/qemu-iotests/046 |  6 +++---
 tests/qemu-iotests/047 |  6 +++---
 tests/qemu-iotests/048 |  8 ++++----
 tests/qemu-iotests/049 |  6 +++---
 tests/qemu-iotests/050 |  6 +++---
 tests/qemu-iotests/051 |  6 +++---
 tests/qemu-iotests/052 |  6 +++---
 tests/qemu-iotests/053 |  6 +++---
 tests/qemu-iotests/054 |  6 +++---
 tests/qemu-iotests/058 |  8 ++++----
 tests/qemu-iotests/059 |  6 +++---
 tests/qemu-iotests/060 |  6 +++---
 tests/qemu-iotests/061 |  6 +++---
 tests/qemu-iotests/062 |  6 +++---
 tests/qemu-iotests/063 |  8 ++++----
 tests/qemu-iotests/064 |  6 +++---
 tests/qemu-iotests/066 |  6 +++---
 tests/qemu-iotests/068 |  6 +++---
 tests/qemu-iotests/069 |  6 +++---
 tests/qemu-iotests/070 |  6 +++---
 tests/qemu-iotests/071 |  6 +++---
 tests/qemu-iotests/072 |  6 +++---
 tests/qemu-iotests/073 |  6 +++---
 tests/qemu-iotests/074 |  8 ++++----
 tests/qemu-iotests/075 |  6 +++---
 tests/qemu-iotests/076 |  6 +++---
 tests/qemu-iotests/077 |  6 +++---
 tests/qemu-iotests/078 |  6 +++---
 tests/qemu-iotests/079 |  6 +++---
 tests/qemu-iotests/080 |  6 +++---
 tests/qemu-iotests/082 |  6 +++---
 tests/qemu-iotests/084 |  6 +++---
 tests/qemu-iotests/085 |  8 ++++----
 tests/qemu-iotests/086 |  6 +++---
 tests/qemu-iotests/088 |  6 +++---
 tests/qemu-iotests/089 |  6 +++---
 tests/qemu-iotests/090 |  6 +++---
 tests/qemu-iotests/091 |  8 ++++----
 tests/qemu-iotests/092 |  6 +++---
 tests/qemu-iotests/094 |  9 ++++-----
 tests/qemu-iotests/095 |  8 ++++----
 tests/qemu-iotests/097 |  8 ++++----
 tests/qemu-iotests/098 |  8 ++++----
 tests/qemu-iotests/099 |  6 +++---
 tests/qemu-iotests/101 |  6 +++---
 tests/qemu-iotests/102 |  8 ++++----
 tests/qemu-iotests/103 |  6 +++---
 tests/qemu-iotests/105 |  6 +++---
 tests/qemu-iotests/106 |  6 +++---
 tests/qemu-iotests/107 |  6 +++---
 tests/qemu-iotests/108 |  6 +++---
 tests/qemu-iotests/109 |  8 ++++----
 tests/qemu-iotests/110 |  6 +++---
 tests/qemu-iotests/111 |  6 +++---
 tests/qemu-iotests/112 |  6 +++---
 tests/qemu-iotests/113 |  6 +++---
 tests/qemu-iotests/114 |  6 +++---
 tests/qemu-iotests/115 |  6 +++---
 tests/qemu-iotests/116 |  6 +++---
 tests/qemu-iotests/117 | 10 +++++-----
 tests/qemu-iotests/119 |  6 +++---
 tests/qemu-iotests/120 |  6 +++---
 tests/qemu-iotests/121 |  6 +++---
 tests/qemu-iotests/122 |  6 +++---
 tests/qemu-iotests/123 |  6 +++---
 tests/qemu-iotests/125 |  6 +++---
 tests/qemu-iotests/127 |  8 ++++----
 tests/qemu-iotests/130 |  8 ++++----
 tests/qemu-iotests/131 |  6 +++---
 tests/qemu-iotests/133 |  6 +++---
 tests/qemu-iotests/134 |  8 ++++----
 tests/qemu-iotests/135 |  6 +++---
 tests/qemu-iotests/137 |  8 ++++----
 tests/qemu-iotests/138 |  6 +++---
 tests/qemu-iotests/140 |  8 ++++----
 tests/qemu-iotests/141 |  8 ++++----
 tests/qemu-iotests/142 |  6 +++---
 tests/qemu-iotests/143 |  8 ++++----
 tests/qemu-iotests/144 |  8 ++++----
 tests/qemu-iotests/145 |  6 +++---
 tests/qemu-iotests/146 |  8 ++++----
 tests/qemu-iotests/150 |  6 +++---
 tests/qemu-iotests/153 |  8 ++++----
 tests/qemu-iotests/154 |  6 +++---
 tests/qemu-iotests/156 |  8 ++++----
 tests/qemu-iotests/157 |  6 +++---
 tests/qemu-iotests/158 |  6 +++---
 tests/qemu-iotests/159 |  6 +++---
 tests/qemu-iotests/160 |  6 +++---
 tests/qemu-iotests/170 |  6 +++---
 tests/qemu-iotests/171 |  6 +++---
 tests/qemu-iotests/172 |  8 ++++----
 tests/qemu-iotests/173 |  8 ++++----
 tests/qemu-iotests/174 |  6 +++---
 tests/qemu-iotests/175 |  6 +++---
 tests/qemu-iotests/176 |  8 ++++----
 tests/qemu-iotests/177 |  6 +++---
 tests/qemu-iotests/178 |  8 ++++----
 tests/qemu-iotests/179 |  8 ++++----
 tests/qemu-iotests/181 | 10 +++++-----
 tests/qemu-iotests/182 |  8 ++++----
 tests/qemu-iotests/183 |  8 ++++----
 tests/qemu-iotests/184 |  6 +++---
 tests/qemu-iotests/185 |  8 ++++----
 tests/qemu-iotests/186 |  6 +++---
 tests/qemu-iotests/187 |  8 ++++----
 tests/qemu-iotests/188 |  6 +++---
 tests/qemu-iotests/189 |  6 +++---
 tests/qemu-iotests/190 |  8 ++++----
 tests/qemu-iotests/191 |  8 ++++----
 tests/qemu-iotests/192 |  8 ++++----
 tests/qemu-iotests/195 |  6 +++---
 150 files changed, 506 insertions(+), 507 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index f93298a0e1..22d82e4be8 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index 750d8d6498..6fd7183974 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index 29618f040c..acad5a2a4d 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index a8b98b5464..954a46ef7b 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt raw qcow qcow2 qed vdi vmdk vhdx luks
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index f514ac8979..f77caab3eb 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -30,15 +30,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index 1e1dff6cef..b0bd1e1520 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # currently only qcow2 allows for consistency checks using qemu-img
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index dce57adc3a..7ab1a403f1 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index 8ae55ec3f5..aeaed1d782 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index b74d96dfcd..ce3e939796 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index 3a87df8cf0..8c98c9510e 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index d646d0dec5..484b47a9d3 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -29,15 +29,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index b46493358e..afc4c5a2b0 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -27,16 +27,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # much of this could be generic for any format supporting compression.
 _supported_fmt qcow qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index a7c912e913..7307e10015 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -29,16 +29,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # much of this could be generic for any format supporting snapshots
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index 1a685ec927..735f597dac 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # actually any format that supports snapshots
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 0ef6b9a04e..765dee9157 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -27,16 +27,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index 315aad6663..ae7907c1e9 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -27,16 +27,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index e25fa6309f..3b0e97feb9 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -29,6 +29,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
@@ -37,10 +41,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 18bc6fc48d..a2bad2f04e 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
@@ -35,10 +39,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index 391afccea5..e34d50be52 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index c165f1aa2c..13c13e3e3e 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -29,16 +29,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # Any format that supports snapshots
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index 54713838c1..c7d64cf026 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -27,16 +27,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # much of this could be generic for any format supporting compression.
 _supported_fmt qcow qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 63a50322dc..d2efc27aae 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
@@ -35,10 +39,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # Currently only qcow2 and qed support rebasing
 _supported_fmt qcow2 qed
 _supported_proto file
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index f0d57aff94..afb5cf0ae0 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -27,16 +27,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 _supported_fmt raw qcow2 qed
 _supported_proto file sheepdog rbd nfs
 _supported_os Linux
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 5a97803f0c..a3be017ccb 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
@@ -34,10 +38,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # Currently only qcow2 supports rebasing
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index d6d47ab6b4..ea950e09d1 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt vmdk qcow qcow2 qed
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index ee3adf64c1..0192004d84 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -30,6 +30,11 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -38,11 +43,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-. ./common.qemu
-
 # Any format supporting backing files except vmdk and qcow which do not support
 # smaller backing files.
 _supported_fmt qcow2 qed
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 7f47b50dc6..d18d004e18 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
     rm -f $TEST_IMG.snap
@@ -34,10 +38,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # Any format supporting intenal snapshots
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index 03a1699d2d..b2aa016e00 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -27,16 +27,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index f2339e8a75..97404db0da 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -29,16 +29,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # This works for any image format (though unlikely to segfault for raw)
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 3bf5325630..1b9c3ba37a 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index 1459ff5b9d..8c9db83134 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index 53f0f3fe6a..cead994725 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index f9560e9771..07f3d30f77 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -30,16 +30,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index 383e770d57..510d113990 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index b0d4510cdf..2286c081d6 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2 qed
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index d5e6205528..cc1e7d74db 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -30,15 +30,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index bccc01f8ed..45d533b7d9 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2 qed
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index c650054328..b63073db37 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # Any format supporting backing files
 _supported_fmt qcow2 qed
 _supported_proto file
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index e4c3c5364c..09192b25de 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index e941a6f110..a11d212d44 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
index 5b77c195b8..f75cb4926e 100755
--- a/tests/qemu-iotests/048
+++ b/tests/qemu-iotests/048
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 
 status=1        # failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
     echo "Cleanup"
@@ -41,10 +45,6 @@ _compare()
     echo $?
 }
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 _supported_fmt raw qcow2 qed luks
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index 70f02d3f41..20207a7023 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index c7a2858cea..9d22200910 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
@@ -35,9 +38,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2 qed
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 2f3eca42ec..0ad210c560 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 612dff2d8d..3355094e3e 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index 6f7667bfd9..09e6a4f8bb 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	rm -f "$TEST_IMG.orig"
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2 qcow
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index a2c7632158..46d0714881 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 08f8bd5d6b..34dcd10a58 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -29,6 +29,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 nbd_unix_socket=$TEST_DIR/test_qemu_nbd_socket
 nbd_snapshot_img="nbd:unix:$nbd_unix_socket"
 rm -f "${TEST_DIR}/qemu-nbd.pid"
@@ -83,10 +87,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 19f09eca35..96883b78b9 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # This tests vmdk-specific low-level functionality
 _supported_fmt vmdk
 _supported_proto file
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index ab25c85019..5775ec2871 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 266e0515d7..2097d64fe4 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 1eaafdff0f..6116453e30 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index 968b624be5..fbffd6d9e7 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -28,6 +28,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
 	_cleanup_test_img
@@ -35,10 +39,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 _supported_fmt qcow qcow2 vmdk qed raw
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index 9d62b0bf94..3bfb46146a 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt vhdx
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 8841354cd8..f29fcc7eae 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index ce33795dda..a0df34898e 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index 5cdf0c1e47..e01cbc98f4 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index 60c4b74a5e..6cbe62e1a0 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt vhdx
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 802b2b9da2..66806e3a8c 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index 0851a72239..2d28db91d5 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt vpc vmdk vhdx vdi qed qcow2 qcow
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index e1982454b0..2738010eb3 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto generic
 _unsupported_proto vxhs
diff --git a/tests/qemu-iotests/074 b/tests/qemu-iotests/074
index 4ba59ba1d7..0dcbe946da 100755
--- a/tests/qemu-iotests/074
+++ b/tests/qemu-iotests/074
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 
 status=1        # failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
     echo "Cleanup"
@@ -42,10 +46,6 @@ _compare()
     echo $?
 }
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index 8d6179f847..2e819c2a5a 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt cloop
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index fb5da1fd17..d7406739a1 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt parallels
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index ec30895982..eb6a189bdf 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt raw
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index 74ab4ee259..1664c9c74c 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt bochs
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 9c368991d1..fc9de46cc7 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file nfs
 _supported_os Linux
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 4667ca229b..0947ed0559 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     rm -f $TEST_IMG.snap
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 7167632e67..64075693f3 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file nfs
 _supported_os Linux
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 9bfa2e57e6..1a610e1ad4 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # This tests vdi-specific header fields
 _supported_fmt vdi
 _supported_proto file
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 1b330c28ca..12df84d6bc 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -37,6 +37,10 @@ snapshot_virt1="snapshot-v1.qcow2"
 
 SNAPSHOTS=10
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -50,10 +54,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index 859e80a291..9329e14b62 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2 raw
 _supported_proto file nfs
 _supported_os Linux
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index 2a51616be8..dcde4813d2 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     rm -f $TEST_IMG.snap
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt vpc
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 70aef90ca7..e1093f73c3 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 8b141e1043..f88b3a7992 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file nfs
 _supported_os Linux
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 447514af51..b1c5988c8a 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -31,6 +31,10 @@ status=1    # failure is the default!
 
 MIG_FIFO="${TEST_DIR}/migrate"
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     rm -f "${MIG_FIFO}"
@@ -39,10 +43,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index f11b6747b3..eb6064daeb 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     rm -f $TEST_IMG.snap
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index ba14a11ade..e8a07c195b 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -27,19 +27,18 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
     _cleanup_test_img
     rm -f "$TEST_DIR/source.$IMGFMT"
 }
-
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt generic
 _supported_proto nbd
 _supported_os Linux
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index c35dc42cd6..da0cc9fed2 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -30,6 +30,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -38,10 +42,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 788393e0c6..10aa13a0ce 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -28,6 +28,10 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
     _cleanup_test_img
@@ -35,10 +39,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # Any format supporting backing files and bdrv_make_empty
 _supported_fmt qcow qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index 92b1e75817..61c27f1f46 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
     _cleanup_test_img
@@ -34,10 +38,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index d103e53ea0..90924c2ad2 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # Basically all formats, but "raw" has issues with _filter_imgfmt regarding the
 # raw comparison image for blkverify; also, all images have to support creation
 _supported_fmt qcow qcow2 qed vdi vhdx vmdk vpc
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index 806da17830..663038378b 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index cdf714412a..4ed1f77542 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here=$PWD
 status=1    # failure is the default!
 
+# get standard environment, filters and qemu instance handling
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -34,10 +38,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and qemu instance handling
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 5326c6e338..0185cc73b2 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=$PWD
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file nfs
 _supported_os Linux
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 6436a275da..0f1c73eacd 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2 vmdk vhdx qed
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index 0a7b803e12..4adf5b8e74 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=$PWD
 status=1	# failure is the default!
 
+# get standard environment and filters
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment and filters
-. ./common.rc
-
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index f111c3c6fc..92c5854a80 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file nfs
 _supported_os Linux
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 95bb252fd2..d44fc8ae17 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index d9b1a344df..6bf5deb664 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -35,10 +39,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 4de36a4d6d..ea8eecb3e7 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # Any format supporting backing files
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index d41dacd948..73396468d4 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index f8a6a1b888..ac5745a559 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index c4a176fcf1..69c2dab1bc 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # We can only test one format here because we need its sample file
 _supported_fmt bochs
 _supported_proto nbd
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index c9fd36ec54..a35f2baa61 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto generic
 _unsupported_proto vxhs
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 26f550c661..cdd095bde2 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index 1995906cc8..b5e962130b 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -30,15 +30,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qed
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 205e8842a0..147d19053b 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -27,17 +27,17 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
-	_cleanup_test_img
+    _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index bdbdfe0f33..d2342ff0bd 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt raw
 _supported_proto nbd
 _supported_os Linux
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index 5227278899..83bc551d16 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index 1b50dc858c..6c69c2beee 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index b583d44952..10104ea49a 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     rm -f "$TEST_IMG".[123]
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index d2e170666e..8f68a76ee4 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt raw
 _supported_proto nbd
 _supported_os Linux
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 03ff104639..62a6d7fb1f 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=$PWD
 status=1	# failure is the default!
 
+# get standard environment and filters
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
@@ -39,9 +42,6 @@ get_image_size_on_host()
         | sed -e 's/^[^0-9]*\([0-9]\+\).*$/\1/'
 }
 
-# get standard environment and filters
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index ea2679e969..34e1eddc57 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here=$PWD
 status=1    # failure is the default!
 
+# get standard environment, filters and qemu instance handling
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -36,10 +40,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and qemu instance handling
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index c0f5782003..4906019543 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -29,6 +29,10 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -36,10 +40,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto generic
 _unsupported_proto vxhs
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 142b908981..fb771fed95 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt parallels
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 467c31e58d..1daf5895c1 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 99144151b8..5d476e1b16 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -27,16 +27,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.filter
-
 _supported_fmt qcow qcow2
 _supported_proto generic
 _unsupported_proto vxhs
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index 5f77ad5885..676e2a2c70 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt vpc
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 1e12b140ae..66ea0e9d1a 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -27,16 +27,16 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 33570ad20d..5624ef11db 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index 32af253b41..a0d255ee5f 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -31,6 +31,10 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -39,10 +43,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index f9914a91da..0bee4f8cde 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -35,10 +39,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 # Needs backing file and backing format support
 _supported_fmt qcow2 qed
 _supported_proto file
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 030269b951..dca66f8675 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index 2e4acfa580..2a8a1f044f 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -34,10 +38,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 5879fd86a1..c12441a632 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -32,6 +32,10 @@ status=1	# failure is the default!
 TMP_SNAP1=${TEST_DIR}/tmp.qcow2
 TMP_SNAP2=${TEST_DIR}/tmp2.qcow2
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -40,10 +44,6 @@ _cleanup()
 
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index 6e6181c858..cd02edd3a8 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index bdc875d143..30fe5e07bc 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1    # failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -34,10 +38,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt vpc
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/150 b/tests/qemu-iotests/150
index 182cf41597..6e77566d78 100755
--- a/tests/qemu-iotests/150
+++ b/tests/qemu-iotests/150
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt raw qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 6d93726108..6947b017f0 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -28,6 +28,10 @@ here="$PWD"
 tmp=/tmp/$$
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_test_img
@@ -40,10 +44,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 size=32M
 
 _check_ofd()
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index 2dcbed329d..d8f07422ca 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 02c52c7ec6..907d5f4e42 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -35,6 +35,10 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -42,10 +46,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2 qed
 _supported_proto generic
 _unsupported_proto vxhs
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 1f273856fd..4f2e299008 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 22a17f92cb..51c46dd259 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow qcow2
 _supported_proto generic
 _unsupported_proto vxhs
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 250905c264..463228de96 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -26,6 +26,9 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1
 
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
     _cleanup_test_img
@@ -33,9 +36,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-. ./common.rc
-. ./common.pattern
-
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index 7ec68d712e..ae6f799c9f 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -26,6 +26,9 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1
 
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
     _cleanup_test_img
@@ -33,9 +36,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-. ./common.rc
-. ./common.pattern
-
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index 2f76d43101..9454485e52 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -26,6 +26,9 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1
 
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
     _cleanup_test_img
@@ -33,9 +36,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-. ./common.rc
-. ./common.pattern
-
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index d703cae210..2c6d6e4995 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -28,15 +28,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 9da3d60146..0b63d0b116 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -27,17 +27,17 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
-	_cleanup_test_img
+    _cleanup_test_img
     rm -f "$TEST_IMG.2"
     rm -f "$TEST_IMG.3"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index ef1ed9cdd1..f08f4d93d1 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1    # failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_qemu
@@ -35,10 +39,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto nfs
 _supported_os Linux
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index a5a4ef65fb..46f557402f 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _unsupported_fmt raw
 
 
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index 4e270ce41e..d96ac79b04 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index d2f53acb1d..b0f87e4bf4 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -31,6 +31,10 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
     _cleanup_test_img
@@ -38,10 +42,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # Any format supporting backing files and bdrv_make_empty
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index b3ef552103..3afad516da 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index b5df4f5cc2..875b4e002b 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1    # failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
     _cleanup_test_img
@@ -34,10 +38,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 _supported_fmt raw qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 7a68986536..45f82a1a2d 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -27,16 +27,16 @@ echo "QA output created by $seq"
 here="$PWD"
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
-	_cleanup_test_img
+    _cleanup_test_img
     rm -f "$TEST_DIR/blkdebug.conf"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index 51b597fc13..c0254623b1 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -29,18 +29,18 @@ status=1	# failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     rm -f "${MIG_SOCKET}"
-	_cleanup_test_img
+    _cleanup_test_img
     _cleanup_qemu
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt generic
 # Formats that do not support live migration
 _unsupported_fmt qcow vdi vhdx vmdk vpc vvfat
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 7293d50bcb..4fbc1d95f9 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -28,16 +28,16 @@ here="$PWD"
 tmp=/tmp/$$
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index ead98f3a4f..320d03e6f6 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -29,6 +29,10 @@ status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     rm -f "${MIG_SOCKET}"
@@ -38,10 +42,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2 raw qed dmg quorum
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index 487e854272..e2af0660c7 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index fab1d54af0..7ba20c9eb7 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -29,6 +29,10 @@ status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     rm -f "${TEST_IMG}.mid"
@@ -38,10 +42,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index fcf9204801..c7e28d4435 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index dfd1da9469..a53d2637e0 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -27,17 +27,17 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
-	_cleanup_test_img
+    _cleanup_test_img
     rm -f "$TEST_IMG.2"
     rm -f "$TEST_IMG.3"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index 481e77dc17..ba523e0b50 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index 6ab55b618a..a2f62fc520 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -27,15 +27,15 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 179949bd3b..0a848a6c94 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -27,6 +27,10 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1    # failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.pattern
+
 _cleanup()
 {
     _cleanup_test_img
@@ -34,10 +38,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.pattern
-
 # See 178 for more extensive tests across more formats
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index ce6284a05e..b29822c9c3 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -29,6 +29,10 @@ status=1 # failure is the default!
 
 MIG_SOCKET="${TEST_DIR}/migrate"
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
     rm -f "${TEST_IMG}.mid"
@@ -39,10 +43,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt qcow2
 _unsupported_imgopts compat=0.10
 _supported_proto file
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 4d0776432a..4bf2ea2757 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -28,16 +28,16 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1	# failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.qemu
+
 _cleanup()
 {
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.qemu
-
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index 810054a085..31135ac290 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -27,6 +27,9 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1 # failure is the default!
 
+# get standard environment, filters and checks
+. ./common.rc
+
 _cleanup()
 {
     _cleanup_test_img
@@ -34,9 +37,6 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
-# get standard environment, filters and checks
-. ./common.rc
-
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
-- 
2.13.6
