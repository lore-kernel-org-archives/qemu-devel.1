Received: from eggs.gnu.org ([2001:4830:134:3::10]:59971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7p-0007is-9y
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7h-0003cs-Uy
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:53 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 16 Nov 2017 12:38:04 -0500
Message-Id: <20171116173810.16457-5-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-1-crosa@redhat.com>
References: <20171116173810.16457-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 04/10] qemu-iotests: include (source) filters
 from common.rc
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

There's an explicit dependency from common.rc on common.filters, that
is, it consumes functions defined there.  Just like common.config is
included in common.rc, it makes sense to also sense common.filter.

This drops the requirement on individual tests to include
common.filter, reducing the amount of boiler plate code (while still
making the comment found on almost every test "get standard
environment, filters and checks" accurate.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/001       | 1 -
 tests/qemu-iotests/002       | 1 -
 tests/qemu-iotests/003       | 1 -
 tests/qemu-iotests/004       | 1 -
 tests/qemu-iotests/005       | 1 -
 tests/qemu-iotests/007       | 1 -
 tests/qemu-iotests/008       | 1 -
 tests/qemu-iotests/009       | 1 -
 tests/qemu-iotests/010       | 1 -
 tests/qemu-iotests/011       | 1 -
 tests/qemu-iotests/012       | 1 -
 tests/qemu-iotests/013       | 1 -
 tests/qemu-iotests/014       | 1 -
 tests/qemu-iotests/015       | 1 -
 tests/qemu-iotests/017       | 1 -
 tests/qemu-iotests/018       | 1 -
 tests/qemu-iotests/019       | 1 -
 tests/qemu-iotests/020       | 1 -
 tests/qemu-iotests/021       | 1 -
 tests/qemu-iotests/022       | 1 -
 tests/qemu-iotests/023       | 1 -
 tests/qemu-iotests/024       | 1 -
 tests/qemu-iotests/025       | 1 -
 tests/qemu-iotests/026       | 1 -
 tests/qemu-iotests/027       | 1 -
 tests/qemu-iotests/028       | 1 -
 tests/qemu-iotests/029       | 1 -
 tests/qemu-iotests/031       | 1 -
 tests/qemu-iotests/032       | 1 -
 tests/qemu-iotests/033       | 1 -
 tests/qemu-iotests/034       | 1 -
 tests/qemu-iotests/035       | 1 -
 tests/qemu-iotests/036       | 1 -
 tests/qemu-iotests/037       | 1 -
 tests/qemu-iotests/038       | 1 -
 tests/qemu-iotests/039       | 1 -
 tests/qemu-iotests/042       | 1 -
 tests/qemu-iotests/043       | 1 -
 tests/qemu-iotests/046       | 1 -
 tests/qemu-iotests/047       | 1 -
 tests/qemu-iotests/048       | 1 -
 tests/qemu-iotests/049       | 1 -
 tests/qemu-iotests/050       | 1 -
 tests/qemu-iotests/051       | 1 -
 tests/qemu-iotests/052       | 1 -
 tests/qemu-iotests/053       | 1 -
 tests/qemu-iotests/054       | 1 -
 tests/qemu-iotests/058       | 1 -
 tests/qemu-iotests/059       | 1 -
 tests/qemu-iotests/060       | 1 -
 tests/qemu-iotests/061       | 1 -
 tests/qemu-iotests/062       | 1 -
 tests/qemu-iotests/063       | 1 -
 tests/qemu-iotests/064       | 1 -
 tests/qemu-iotests/066       | 1 -
 tests/qemu-iotests/067       | 1 -
 tests/qemu-iotests/068       | 1 -
 tests/qemu-iotests/069       | 1 -
 tests/qemu-iotests/070       | 1 -
 tests/qemu-iotests/071       | 1 -
 tests/qemu-iotests/072       | 1 -
 tests/qemu-iotests/073       | 1 -
 tests/qemu-iotests/074       | 1 -
 tests/qemu-iotests/075       | 1 -
 tests/qemu-iotests/076       | 1 -
 tests/qemu-iotests/077       | 1 -
 tests/qemu-iotests/078       | 1 -
 tests/qemu-iotests/079       | 1 -
 tests/qemu-iotests/080       | 1 -
 tests/qemu-iotests/081       | 1 -
 tests/qemu-iotests/082       | 1 -
 tests/qemu-iotests/083       | 1 -
 tests/qemu-iotests/084       | 1 -
 tests/qemu-iotests/085       | 1 -
 tests/qemu-iotests/086       | 1 -
 tests/qemu-iotests/087       | 1 -
 tests/qemu-iotests/088       | 1 -
 tests/qemu-iotests/089       | 1 -
 tests/qemu-iotests/090       | 1 -
 tests/qemu-iotests/091       | 1 -
 tests/qemu-iotests/092       | 1 -
 tests/qemu-iotests/094       | 1 -
 tests/qemu-iotests/095       | 1 -
 tests/qemu-iotests/097       | 1 -
 tests/qemu-iotests/098       | 1 -
 tests/qemu-iotests/099       | 1 -
 tests/qemu-iotests/101       | 1 -
 tests/qemu-iotests/102       | 1 -
 tests/qemu-iotests/103       | 1 -
 tests/qemu-iotests/104       | 1 -
 tests/qemu-iotests/105       | 1 -
 tests/qemu-iotests/106       | 1 -
 tests/qemu-iotests/107       | 1 -
 tests/qemu-iotests/108       | 1 -
 tests/qemu-iotests/109       | 1 -
 tests/qemu-iotests/110       | 1 -
 tests/qemu-iotests/111       | 1 -
 tests/qemu-iotests/112       | 1 -
 tests/qemu-iotests/113       | 1 -
 tests/qemu-iotests/114       | 1 -
 tests/qemu-iotests/115       | 1 -
 tests/qemu-iotests/116       | 1 -
 tests/qemu-iotests/117       | 1 -
 tests/qemu-iotests/119       | 1 -
 tests/qemu-iotests/120       | 1 -
 tests/qemu-iotests/121       | 1 -
 tests/qemu-iotests/122       | 1 -
 tests/qemu-iotests/123       | 1 -
 tests/qemu-iotests/125       | 1 -
 tests/qemu-iotests/126       | 1 -
 tests/qemu-iotests/127       | 1 -
 tests/qemu-iotests/128       | 1 -
 tests/qemu-iotests/130       | 1 -
 tests/qemu-iotests/131       | 1 -
 tests/qemu-iotests/133       | 1 -
 tests/qemu-iotests/135       | 1 -
 tests/qemu-iotests/137       | 1 -
 tests/qemu-iotests/138       | 1 -
 tests/qemu-iotests/140       | 1 -
 tests/qemu-iotests/141       | 1 -
 tests/qemu-iotests/142       | 1 -
 tests/qemu-iotests/143       | 1 -
 tests/qemu-iotests/144       | 1 -
 tests/qemu-iotests/145       | 1 -
 tests/qemu-iotests/146       | 1 -
 tests/qemu-iotests/150       | 1 -
 tests/qemu-iotests/153       | 1 -
 tests/qemu-iotests/154       | 1 -
 tests/qemu-iotests/156       | 1 -
 tests/qemu-iotests/157       | 1 -
 tests/qemu-iotests/158       | 1 -
 tests/qemu-iotests/159       | 1 -
 tests/qemu-iotests/160       | 1 -
 tests/qemu-iotests/162       | 1 -
 tests/qemu-iotests/170       | 1 -
 tests/qemu-iotests/171       | 1 -
 tests/qemu-iotests/172       | 1 -
 tests/qemu-iotests/173       | 1 -
 tests/qemu-iotests/174       | 1 -
 tests/qemu-iotests/175       | 1 -
 tests/qemu-iotests/176       | 1 -
 tests/qemu-iotests/177       | 1 -
 tests/qemu-iotests/178       | 1 -
 tests/qemu-iotests/179       | 1 -
 tests/qemu-iotests/181       | 1 -
 tests/qemu-iotests/182       | 1 -
 tests/qemu-iotests/183       | 1 -
 tests/qemu-iotests/184       | 1 -
 tests/qemu-iotests/185       | 1 -
 tests/qemu-iotests/186       | 1 -
 tests/qemu-iotests/187       | 1 -
 tests/qemu-iotests/188       | 1 -
 tests/qemu-iotests/189       | 1 -
 tests/qemu-iotests/190       | 1 -
 tests/qemu-iotests/191       | 1 -
 tests/qemu-iotests/192       | 1 -
 tests/qemu-iotests/195       | 1 -
 tests/qemu-iotests/197       | 1 -
 tests/qemu-iotests/common.rc | 7 +++++++
 159 files changed, 7 insertions(+), 158 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index ffd14e2ce9..f93298a0e1 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index d4f8e91b91..750d8d6498 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index 19889b9fcd..29618f040c 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 6f2aa3d9a2..a8b98b5464 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw qcow qcow2 qed vdi vmdk vhdx luks
 _supported_proto generic
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 444737751f..f514ac8979 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index fa543eeb7d..1e1dff6cef 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # currently only qcow2 allows for consistency checks using qemu-img
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index 8e89d74fe9..dce57adc3a 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index 16e4475ca4..8ae55ec3f5 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 151dac238d..b74d96dfcd 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index f8d044ec85..3a87df8cf0 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 01a770d59c..d646d0dec5 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto file
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index d013f87da9..b46493358e 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # much of this could be generic for any format supporting compression.
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index 2ea79e8c8b..a7c912e913 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # much of this could be generic for any format supporting snapshots
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index aaf9c3f415..1a685ec927 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # actually any format that supports snapshots
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 4f9302db42..0ef6b9a04e 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # Any format supporting backing files
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index 1d39d35c47..315aad6663 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # Any format supporting backing files
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index 24a789a25c..e25fa6309f 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # Any format supporting backing files
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 7a111100ec..18bc6fc48d 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # Any format supporting backing files
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index 11e8ed7187..391afccea5 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index 2452a9f86a..c165f1aa2c 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # Any format that supports snapshots
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index 497ae1ed17..54713838c1 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # much of this could be generic for any format supporting compression.
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index e0d77ce2f5..63a50322dc 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # Currently only qcow2 and qed support rebasing
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index f5e672e6b3..f0d57aff94 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 _supported_fmt raw qcow2 qed
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 7fadfbace5..5a97803f0c 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # Currently only qcow2 supports rebasing
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index 08593da775..d6d47ab6b4 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt vmdk qcow qcow2 qed
 _supported_proto generic
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 97a8869251..ee3adf64c1 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 . ./common.qemu
 
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 30bab24dc0..7f47b50dc6 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # Any format supporting intenal snapshots
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index 1e08abc5ed..03a1699d2d 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # This tests qcow2-specific low-level functionality
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index 24bcb52fc2..f2339e8a75 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # This works for any image format (though unlikely to segfault for raw)
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 2cdfd1397a..3bf5325630 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index 1b28bdae63..1459ff5b9d 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index efc38e4d49..53f0f3fe6a 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index ce638d6076..f9560e9771 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # This tests qcow2-specific low-level functionality
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index c476b823d2..383e770d57 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index d99a1501d7..b0d4510cdf 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2 qed
 _supported_proto file
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 1f48339692..d5e6205528 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index a53e7cb757..bccc01f8ed 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2 qed
 _supported_proto file
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index 1c6c22d92a..c650054328 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # Any format supporting backing files
 _supported_fmt qcow2 qed
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index f2ebecf24c..e4c3c5364c 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index 1b8f3d4a64..e941a6f110 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
index 9ed04a068d..5b77c195b8 100755
--- a/tests/qemu-iotests/048
+++ b/tests/qemu-iotests/048
@@ -43,7 +43,6 @@ _compare()
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 _supported_fmt raw qcow2 qed luks
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index df35b6d21e..70f02d3f41 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 03b4a5d620..c7a2858cea 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2 qed
 _supported_proto file
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index dba8816c9f..2f3eca42ec 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 842eaced3b..612dff2d8d 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto file
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index 2a04f5f551..6f7667bfd9 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2 qcow
 _supported_proto file
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index bf47ef9fac..a2c7632158 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 5eb8784669..08f8bd5d6b 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -85,7 +85,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index a1c34eeb7c..19f09eca35 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # This tests vmdk-specific low-level functionality
 _supported_fmt vmdk
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index fae08b03bf..ab25c85019 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index f5678b10c9..266e0515d7 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 051fb9f410..1eaafdff0f 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index e4f6ea9385..968b624be5 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 _supported_fmt qcow qcow2 vmdk qed raw
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index 5792fbbc92..9d62b0bf94 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt vhdx
 _supported_proto generic
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 8638217736..8841354cd8 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index 9d561ef786..cbc3180af0 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -29,7 +29,6 @@ status=1	# failure is the default!
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index e7fca6a494..ce33795dda 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index 96e55ef216..5cdf0c1e47 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index 8d08d74ff9..60c4b74a5e 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt vhdx
 _supported_proto generic
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 48b495513f..802b2b9da2 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index aa027c7d29..0851a72239 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt vpc vmdk vhdx vdi qed qcow2 qcow
 _supported_proto file
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 40f85b18b9..e1982454b0 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/074 b/tests/qemu-iotests/074
index b17866bd34..4ba59ba1d7 100755
--- a/tests/qemu-iotests/074
+++ b/tests/qemu-iotests/074
@@ -44,7 +44,6 @@ _compare()
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index 770d51c6cb..8d6179f847 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt cloop
 _supported_proto file
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index ef9e6a4ff3..fb5da1fd17 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt parallels
 _supported_proto file
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index b3c6fb1370..ec30895982 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw
 _supported_proto generic
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index f333e9ac84..74ab4ee259 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt bochs
 _supported_proto file
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index b2e3f7426a..9c368991d1 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file nfs
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 55044c700b..4667ca229b 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index da3fb0984b..b067348fb2 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw
 _supported_proto file
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index d5c83d45ed..7167632e67 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file nfs
diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index 3c1adbf0fb..b724b6bf14 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto nbd
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 04f2aa9d7d..9bfa2e57e6 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # This tests vdi-specific header fields
 _supported_fmt vdi
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 5c7668cf9b..1b330c28ca 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -52,7 +52,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index cd4494a660..859e80a291 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2 raw
 _supported_proto file nfs
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 27ab6c5151..3e29e5f9fe 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -29,7 +29,6 @@ status=1	# failure is the default!
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index b8076f216b..2a51616be8 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt vpc
 _supported_proto file
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 9bfe2307b3..70aef90ca7 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 7380503d57..8b141e1043 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file nfs
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 10ac4a8d73..447514af51 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index 5bbdd071d8..f11b6747b3 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow
 _supported_proto file
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 9aa01e3627..ba14a11ade 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt generic
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 030adb22e1..c35dc42cd6 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index e22670c8d0..788393e0c6 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # Any format supporting backing files and bdrv_make_empty
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index b002e969b3..92b1e75817 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index caaf58eee5..d103e53ea0 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # Basically all formats, but "raw" has issues with _filter_imgfmt regarding the
 # raw comparison image for blkverify; also, all images have to support creation
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index ea53f8b8d3..806da17830 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw
 _supported_proto file
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index d7ad8d9840..cdf714412a 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and qemu instance handling
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index ecbd8ebd71..5326c6e338 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file nfs
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 726d467052..869f6c5c09 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -31,7 +31,6 @@ trap "exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw qcow qcow2 qed vdi vmdk vhdx
 _supported_proto generic
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 3db4ce3cf3..6436a275da 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2 vmdk vhdx qed
 _supported_proto generic
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index bfe71f4e60..0a7b803e12 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment and filters
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw
 _supported_proto file
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index d7222dc1c9..f111c3c6fc 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file nfs
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 2355d98c1d..95bb252fd2 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index d70b574d88..d9b1a344df 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt raw
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 9de7369f3a..4de36a4d6d 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # Any format supporting backing files
 _supported_fmt qed qcow qcow2 vmdk
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index a1c152d0c1..d41dacd948 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index 28eb9aae93..f8a6a1b888 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index 19b68b2727..c4a176fcf1 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # We can only test one format here because we need its sample file
 _supported_fmt bochs
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index 5b7dc5496c..c9fd36ec54 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 665c2ead41..26f550c661 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index df0172fed3..1995906cc8 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qed
 _supported_proto generic
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 6c83461182..205e8842a0 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index 4f34fb4343..bdbdfe0f33 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw
 _supported_proto nbd
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index f40b97d099..5227278899 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto file
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index 1307b4e327..1b50dc858c 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 45b359c2ba..b583d44952 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index b18e3fca9a..d2e170666e 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw
 _supported_proto nbd
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index c20c71570c..03ff104639 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -41,7 +41,6 @@ get_image_size_on_host()
 
 # get standard environment and filters
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index a2d4d6c73d..f3058e046a 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -30,7 +30,6 @@ status=1	# failure is the default!
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # Needs backing file support
 _supported_fmt qcow qcow2 qed vmdk
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index 9e0d7d3be8..ea2679e969 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and qemu instance handling
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
index 0976a18133..934b6e7e33 100755
--- a/tests/qemu-iotests/128
+++ b/tests/qemu-iotests/128
@@ -67,7 +67,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw
 _supported_proto file
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index e7e43de6d6..c0f5782003 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 94a9ae76af..142b908981 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt parallels
 _supported_proto file
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 9d35a6a1ca..467c31e58d 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index ce608312f6..5f77ad5885 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt vpc
 _supported_proto generic
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index eb91e517d7..1e12b140ae 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 21650d8197..33570ad20d 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index a8fc95145c..32af253b41 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt generic
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 2f9d7b9bc2..f9914a91da 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 # Needs backing file and backing format support
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 1639c83985..030269b951 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index 5ff1944507..2e4acfa580 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt generic
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 00de3c33cf..5879fd86a1 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index c371b3c46a..6e6181c858 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto generic
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 043711be68..bdc875d143 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt vpc
diff --git a/tests/qemu-iotests/150 b/tests/qemu-iotests/150
index ee8f6375f6..182cf41597 100755
--- a/tests/qemu-iotests/150
+++ b/tests/qemu-iotests/150
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index fa25eb24bd..6d93726108 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 size=32M
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index fde03b0dc8..2dcbed329d 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index e75dc4d743..02c52c7ec6 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -44,7 +44,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2 qed
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 2bf02be465..1f273856fd 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_proto file
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 24ac600a4a..22a17f92cb 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 9b0e1ecc90..250905c264 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -34,7 +34,6 @@ _cleanup()
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 _supported_fmt generic
diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
index 5c910e5bfc..7ec68d712e 100755
--- a/tests/qemu-iotests/160
+++ b/tests/qemu-iotests/160
@@ -34,7 +34,6 @@ _cleanup()
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 _supported_fmt raw
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 477a806360..0572e91c9a 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt generic
 _supported_os Linux
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index b79359fc4e..2f76d43101 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -34,7 +34,6 @@ _cleanup()
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 _supported_fmt generic
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index bcfaaf1be2..d703cae210 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw
 _supported_proto file
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 02c5f79bab..9da3d60146 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index bdaa092979..ef1ed9cdd1 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index 552879db32..a5a4ef65fb 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _unsupported_fmt raw
 
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index ca56e827cd..4e270ce41e 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt raw
 _supported_proto file
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 950b28720e..d2f53acb1d 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # Any format supporting backing files and bdrv_make_empty
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 28990977f1..b3ef552103 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 6af52c653a..b5df4f5cc2 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 _supported_fmt raw qcow2
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 115944a753..7a68986536 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index 0c91e8f9de..51b597fc13 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt generic
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 2e078ceed8..7293d50bcb 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 20268ff7a1..ead98f3a4f 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2 raw qed dmg quorum
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index ee96c99af3..487e854272 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index f5b47e4c1a..fab1d54af0 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 44cc01ed87..fcf9204801 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index 7bb783363c..dfd1da9469 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index 83ed03e33e..481e77dc17 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index e695475722..6ab55b618a 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -35,7 +35,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto generic
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index 8f808fef5d..179949bd3b 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.pattern
 
 # See 178 for more extensive tests across more formats
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index ad785e10b1..ce6284a05e 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt qcow2
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 595f0d786a..4d0776432a 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 . ./common.qemu
 
 _supported_fmt generic
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index e7a403ded2..810054a085 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 _supported_fmt qcow2
 _supported_proto file
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 887eb4f496..0f7361611f 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -29,7 +29,6 @@ status=1 # failure is the default!
 
 # get standard environment, filters and checks
 . ./common.rc
-. ./common.filter
 
 TEST_WRAP="$TEST_DIR/t.wrap.qcow2"
 BLKDBG_CONF="$TEST_DIR/blkdebug.conf"
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index dcabe4c7cc..9a40e0e98f 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -190,6 +190,13 @@ _use_sample_img()
     fi
 }
 
+
+if ! . ./common.filter
+    then
+    echo "$0: failed to source common.filter"
+    exit 1
+fi
+
 _make_test_img()
 {
     # extra qemu-img options can be added by tests
-- 
2.13.6
