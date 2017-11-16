Received: from eggs.gnu.org ([2001:4830:134:3::10]:59964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7o-0007iA-JX
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7i-0003e6-AV
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:52 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 16 Nov 2017 12:38:07 -0500
Message-Id: <20171116173810.16457-8-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-1-crosa@redhat.com>
References: <20171116173810.16457-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 07/10] qemu-iotests: remove the concept of
 $seq.full (and boiler plate code)
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

The $seq.full file, in theory, should contain the full output of a
test error.  In practice, it's only used on a single test, and the
boiler plate code to clean it up plagues all other tests.

Let's remove the concept altogether, and record the failure in the
output itself for the one test using this function.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/001 | 1 -
 tests/qemu-iotests/002 | 1 -
 tests/qemu-iotests/003 | 1 -
 tests/qemu-iotests/004 | 1 -
 tests/qemu-iotests/005 | 1 -
 tests/qemu-iotests/007 | 1 -
 tests/qemu-iotests/008 | 1 -
 tests/qemu-iotests/009 | 1 -
 tests/qemu-iotests/010 | 1 -
 tests/qemu-iotests/011 | 1 -
 tests/qemu-iotests/012 | 1 -
 tests/qemu-iotests/013 | 1 -
 tests/qemu-iotests/014 | 1 -
 tests/qemu-iotests/015 | 1 -
 tests/qemu-iotests/017 | 1 -
 tests/qemu-iotests/018 | 1 -
 tests/qemu-iotests/019 | 1 -
 tests/qemu-iotests/020 | 1 -
 tests/qemu-iotests/021 | 1 -
 tests/qemu-iotests/022 | 1 -
 tests/qemu-iotests/023 | 1 -
 tests/qemu-iotests/024 | 1 -
 tests/qemu-iotests/025 | 1 -
 tests/qemu-iotests/026 | 1 -
 tests/qemu-iotests/027 | 1 -
 tests/qemu-iotests/028 | 1 -
 tests/qemu-iotests/029 | 1 -
 tests/qemu-iotests/031 | 1 -
 tests/qemu-iotests/032 | 1 -
 tests/qemu-iotests/033 | 1 -
 tests/qemu-iotests/034 | 1 -
 tests/qemu-iotests/035 | 1 -
 tests/qemu-iotests/036 | 1 -
 tests/qemu-iotests/037 | 1 -
 tests/qemu-iotests/038 | 1 -
 tests/qemu-iotests/039 | 1 -
 tests/qemu-iotests/042 | 1 -
 tests/qemu-iotests/043 | 1 -
 tests/qemu-iotests/046 | 1 -
 tests/qemu-iotests/047 | 1 -
 tests/qemu-iotests/049 | 1 -
 tests/qemu-iotests/050 | 1 -
 tests/qemu-iotests/051 | 1 -
 tests/qemu-iotests/052 | 1 -
 tests/qemu-iotests/053 | 1 -
 tests/qemu-iotests/054 | 1 -
 tests/qemu-iotests/058 | 1 -
 tests/qemu-iotests/059 | 1 -
 tests/qemu-iotests/060 | 1 -
 tests/qemu-iotests/061 | 1 -
 tests/qemu-iotests/062 | 1 -
 tests/qemu-iotests/063 | 1 -
 tests/qemu-iotests/064 | 1 -
 tests/qemu-iotests/066 | 1 -
 tests/qemu-iotests/067 | 1 -
 tests/qemu-iotests/068 | 1 -
 tests/qemu-iotests/069 | 1 -
 tests/qemu-iotests/070 | 1 -
 tests/qemu-iotests/071 | 1 -
 tests/qemu-iotests/072 | 1 -
 tests/qemu-iotests/073 | 1 -
 tests/qemu-iotests/075 | 1 -
 tests/qemu-iotests/076 | 1 -
 tests/qemu-iotests/077 | 1 -
 tests/qemu-iotests/078 | 1 -
 tests/qemu-iotests/079 | 1 -
 tests/qemu-iotests/080 | 1 -
 tests/qemu-iotests/081 | 1 -
 tests/qemu-iotests/082 | 1 -
 tests/qemu-iotests/083 | 1 -
 tests/qemu-iotests/084 | 1 -
 tests/qemu-iotests/085 | 1 -
 tests/qemu-iotests/086 | 1 -
 tests/qemu-iotests/087 | 1 -
 tests/qemu-iotests/088 | 1 -
 tests/qemu-iotests/089 | 1 -
 tests/qemu-iotests/090 | 1 -
 tests/qemu-iotests/091 | 1 -
 tests/qemu-iotests/092 | 1 -
 tests/qemu-iotests/094 | 1 -
 tests/qemu-iotests/095 | 1 -
 tests/qemu-iotests/097 | 1 -
 tests/qemu-iotests/098 | 1 -
 tests/qemu-iotests/099 | 1 -
 tests/qemu-iotests/101 | 1 -
 tests/qemu-iotests/102 | 1 -
 tests/qemu-iotests/103 | 1 -
 tests/qemu-iotests/104 | 1 -
 tests/qemu-iotests/105 | 1 -
 tests/qemu-iotests/106 | 1 -
 tests/qemu-iotests/107 | 1 -
 tests/qemu-iotests/108 | 1 -
 tests/qemu-iotests/109 | 1 -
 tests/qemu-iotests/110 | 1 -
 tests/qemu-iotests/111 | 1 -
 tests/qemu-iotests/112 | 1 -
 tests/qemu-iotests/113 | 1 -
 tests/qemu-iotests/114 | 1 -
 tests/qemu-iotests/115 | 1 -
 tests/qemu-iotests/116 | 1 -
 tests/qemu-iotests/117 | 1 -
 tests/qemu-iotests/119 | 1 -
 tests/qemu-iotests/120 | 1 -
 tests/qemu-iotests/121 | 1 -
 tests/qemu-iotests/122 | 1 -
 tests/qemu-iotests/123 | 1 -
 tests/qemu-iotests/125 | 1 -
 tests/qemu-iotests/126 | 1 -
 tests/qemu-iotests/127 | 1 -
 tests/qemu-iotests/128 | 1 -
 tests/qemu-iotests/130 | 1 -
 tests/qemu-iotests/131 | 1 -
 tests/qemu-iotests/133 | 1 -
 tests/qemu-iotests/134 | 1 -
 tests/qemu-iotests/135 | 1 -
 tests/qemu-iotests/137 | 1 -
 tests/qemu-iotests/138 | 1 -
 tests/qemu-iotests/140 | 1 -
 tests/qemu-iotests/141 | 1 -
 tests/qemu-iotests/142 | 1 -
 tests/qemu-iotests/143 | 1 -
 tests/qemu-iotests/144 | 1 -
 tests/qemu-iotests/145 | 1 -
 tests/qemu-iotests/146 | 1 -
 tests/qemu-iotests/150 | 1 -
 tests/qemu-iotests/153 | 1 -
 tests/qemu-iotests/154 | 1 -
 tests/qemu-iotests/156 | 1 -
 tests/qemu-iotests/157 | 1 -
 tests/qemu-iotests/158 | 1 -
 tests/qemu-iotests/162 | 1 -
 tests/qemu-iotests/171 | 1 -
 tests/qemu-iotests/172 | 1 -
 tests/qemu-iotests/173 | 1 -
 tests/qemu-iotests/174 | 9 +++++++--
 tests/qemu-iotests/175 | 1 -
 tests/qemu-iotests/176 | 1 -
 tests/qemu-iotests/178 | 1 -
 tests/qemu-iotests/181 | 1 -
 tests/qemu-iotests/182 | 1 -
 tests/qemu-iotests/183 | 1 -
 tests/qemu-iotests/184 | 1 -
 tests/qemu-iotests/185 | 1 -
 tests/qemu-iotests/186 | 1 -
 tests/qemu-iotests/187 | 1 -
 tests/qemu-iotests/188 | 1 -
 tests/qemu-iotests/189 | 1 -
 tests/qemu-iotests/190 | 1 -
 tests/qemu-iotests/191 | 1 -
 tests/qemu-iotests/192 | 1 -
 tests/qemu-iotests/195 | 1 -
 151 files changed, 7 insertions(+), 152 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index b38fb0c73d..5830f68ba0 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -58,5 +58,4 @@ $QEMU_IO -c "read -P 0xa 0 $size" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index 608d62652a..7dd1774464 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -78,5 +78,4 @@ $QEMU_IO -c 'read -pP 0xa 262186 470' "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index 68beb32aea..13cc8041a3 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -71,5 +71,4 @@ $QEMU_IO -c "readv -P 0xb $offset $chunksize $chunksize \
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 5afb23c9fd..710148c2bb 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -97,5 +97,4 @@ $QEMU_IO -c "readv $past_offset 4096" "$TEST_IMG"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index a860062847..d2c6575992 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -68,5 +68,4 @@ $QEMU_IO -c "write 8192 4096" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index f9048f9a7a..3fe2fe5dad 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -62,5 +62,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index 7755c00a43..f021b8ea3a 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -58,5 +58,4 @@ $QEMU_IO -c "aio_read -P 0xa 0 $size" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index 418c0a56f7..8d56673bc6 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -62,5 +62,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 6e9beb953d..3f91224795 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -64,5 +64,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index 275b0cc29c..921f43c03d 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -68,5 +68,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 59cac183e2..3121f947f6 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -58,5 +58,4 @@ $QEMU_IO -r -c "read 0 512" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index d33969be6a..095c2a0cd6 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -91,5 +91,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/014 b/tests/qemu-iotests/014
index 360379f2b3..c28970732b 100755
--- a/tests/qemu-iotests/014
+++ b/tests/qemu-iotests/014
@@ -70,5 +70,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index c1b920fd56..a5cda4742c 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -80,5 +80,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index b2a95c5166..2398fc2bf1 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -98,5 +98,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index 5375eae206..8d4ccda85e 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -100,5 +100,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index c2af8a0236..b06ef93976 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -126,5 +126,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 0361809a6d..b34cfc16e1 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -111,5 +111,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index 2ea6b1d161..97e27d6cf3 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -56,5 +56,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index f577278db9..bc9186c0fa 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -60,5 +60,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/023 b/tests/qemu-iotests/023
index ca8440ad83..99fda1ff14 100755
--- a/tests/qemu-iotests/023
+++ b/tests/qemu-iotests/023
@@ -113,5 +113,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 189d5c3fc1..b3cabe1fb5 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -124,5 +124,4 @@ io_pattern readv $((15 * CLUSTER_SIZE)) $CLUSTER_SIZE 0 1 0x00
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index eb12d1c7d6..a781632b09 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -71,5 +71,4 @@ io_pattern read $small_size $(($big_size - $small_size)) 0 1 0
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 3fb915f289..166c8267f7 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -200,5 +200,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index 9a25a63c28..c9416c719f 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -71,5 +71,4 @@ $QEMU_IO -c "read -pP 0 -l 512 -s $subcluster_size $subcluster_offset $(( subclu
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index e75611bab3..f2991a28aa 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -134,5 +134,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 01ed075402..fee694f305 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -95,5 +95,4 @@ poke_file "$TEST_IMG" "$offset_l1_size" "\x00\x00\x00\x01"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index 1ac200f191..da44539b0f 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -73,5 +73,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index c9f9cf5439..15a0ff6298 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -62,5 +62,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index dd8fc32ea8..d4beecc9c0 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -102,5 +102,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index 1bdd7f2e04..c0eb87b40a 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -113,5 +113,4 @@ $QEMU_IO -c "read -P 0x55 526k 498k" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index 1cd2475ba6..04c4cf0f58 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -65,5 +65,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index e49e4a7f85..990b9d82b6 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -114,5 +114,4 @@ $PYTHON qcow2.py "$TEST_IMG" dump-header
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index 06ba02a9f9..c4d55babe2 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -118,5 +118,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index 1ad0efd1a3..b35c30fa17 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -130,5 +130,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index cf83895f23..99a33df803 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -174,6 +174,5 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
 
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index db66fc8434..7fafb6a436 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -70,6 +70,5 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
 
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index 7d106ddb3b..0ce07adfd0 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -88,5 +88,4 @@ _img_info --backing-chain --output=json
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index f6914ccd1e..c3c16ebd3d 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -265,5 +265,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index 474c5cb47d..ebbb36c349 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -68,5 +68,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index 2f4d8ab932..984652cd97 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -116,5 +116,4 @@ test_qemu_img create -f $IMGFMT -o compat=0.10,lazy_refcounts=on "$TEST_IMG" 64M
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index 7096fa535c..f290c68498 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -73,5 +73,4 @@ $QEMU_IO -c "read -P 0x00 0 1048576" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index e726df6e01..b6903d13c4 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -341,5 +341,4 @@ $QEMU_IO -c "read -P 0x33 0 4k" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index c521a6fc36..33c3e55713 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -60,5 +60,4 @@ $QEMU_IO -c "read -P 0 0 $size" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index c8fda86672..a84dde31e0 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -65,6 +65,5 @@ $QEMU_IO -c "read -P0xa 0 512" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
 
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index bcea34ef86..0fc2a8faa6 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -51,5 +51,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/058 b/tests/qemu-iotests/058
index 17970357cd..74118b93d3 100755
--- a/tests/qemu-iotests/058
+++ b/tests/qemu-iotests/058
@@ -141,5 +141,4 @@ $QEMU_IO -c 'read -P 0xb 0x2000 0x1000' "$converted_image" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 6af6c6fada..fe16e9442d 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -155,5 +155,4 @@ _cleanup_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index d562b2c967..98a946f99c 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -301,5 +301,4 @@ $QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index ffc27213a5..2c6da49646 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -235,5 +235,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 4c6c3d70f4..3f97c7d6da 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -57,5 +57,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index 29acdf3a8b..9b8660e021 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -90,6 +90,5 @@ if $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG.orig" "$TEST_IMG" >/dev
 fi
 
 echo "*** done"
-rm -f $seq.full
 status=0
 exit 0
diff --git a/tests/qemu-iotests/064 b/tests/qemu-iotests/064
index 0f220282c7..40954b36d7 100755
--- a/tests/qemu-iotests/064
+++ b/tests/qemu-iotests/064
@@ -81,5 +81,4 @@ $QEMU_IO -c "read -pP 0xc3 99M 58M" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index c8b0bee3be..556b42bfe6 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -184,5 +184,4 @@ _cleanup_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index 976822b34c..b7a6ef2097 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -150,5 +150,4 @@ EOF
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index dc00ee1c2d..162cd26005 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -81,5 +81,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index 1d44ef37a1..1f3baeea13 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -53,5 +53,4 @@ $QEMU_IO -c quit "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/070 b/tests/qemu-iotests/070
index d52a85f624..684742893c 100755
--- a/tests/qemu-iotests/070
+++ b/tests/qemu-iotests/070
@@ -78,5 +78,4 @@ _img_info
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index fd74238312..7b1fdf7989 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -252,5 +252,4 @@ EOF
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index 568f8774d8..5d4e8becac 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -62,5 +62,4 @@ $QEMU_IO -c 'read -P 42 0 512' "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 37e68263b4..f5be7347d1 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -160,5 +160,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/075 b/tests/qemu-iotests/075
index 3e7ab6de95..b924d7a5f7 100755
--- a/tests/qemu-iotests/075
+++ b/tests/qemu-iotests/075
@@ -99,5 +99,4 @@ $QEMU_IO -c "read 0 512" $TEST_IMG 2>&1 | _filter_qemu_io | _filter_testdir
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/076 b/tests/qemu-iotests/076
index df4a1614fb..64b935ad02 100755
--- a/tests/qemu-iotests/076
+++ b/tests/qemu-iotests/076
@@ -79,5 +79,4 @@ _use_sample_img parallels-v2.bz2
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/077 b/tests/qemu-iotests/077
index 8d4be8c1e8..897afb688d 100755
--- a/tests/qemu-iotests/077
+++ b/tests/qemu-iotests/077
@@ -262,5 +262,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/078 b/tests/qemu-iotests/078
index b5f7c3a44a..36490ec94c 100755
--- a/tests/qemu-iotests/078
+++ b/tests/qemu-iotests/078
@@ -84,5 +84,4 @@ poke_file "$TEST_IMG" "$extent_size_offset" "\x00\x00\x00\x00"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 3363e43146..d8a2a17e71 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -50,5 +50,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index e7e7caf00d..aa7b13776a 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -177,5 +177,4 @@ poke_file "$TEST_IMG" "$offset_snap1_l1_size" "\x10\x00\x00\x00"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index 33b18106c1..d840841b0d 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -168,5 +168,4 @@ $QEMU_IO -c "open -o $quorum" -c "read -P 0x32 0 $size" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index fd904d69f8..4f1c03b882 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -201,5 +201,4 @@ run_qemu_img convert -o help
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index 51fd8825b4..39162b36ef 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -146,5 +146,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/084 b/tests/qemu-iotests/084
index 333488a949..3daf41615b 100755
--- a/tests/qemu-iotests/084
+++ b/tests/qemu-iotests/084
@@ -109,5 +109,4 @@ _img_info
 # success, all done
 echo
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index da481225d6..375a51e07a 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -241,5 +241,4 @@ _send_qemu_cmd $h "{ 'execute': 'blockdev-snapshot',
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index 8611514049..1224e068b7 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -58,5 +58,4 @@ $QEMU_IMG convert -p -O $IMGFMT -f $IMGFMT "$TEST_IMG" "$TEST_IMG".base  2>&1 |\
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index dd6e5976ca..fb572dc5b8 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -199,5 +199,4 @@ EOF
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/088 b/tests/qemu-iotests/088
index f6e1848ce9..75e6ba9908 100755
--- a/tests/qemu-iotests/088
+++ b/tests/qemu-iotests/088
@@ -57,5 +57,4 @@ poke_file "$TEST_IMG" "$offset_block_size" "\x12\x34\x56\x78"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index f925f5f245..dad9fcb69f 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -126,5 +126,4 @@ $QEMU_IO -c "open -o driver=qcow2 json:{\"driver\":\"raw\",\"file.filename\":\"$
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 2ae70f7d79..74e14e9f00 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -54,5 +54,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 48cf18d312..bb32f681bb 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -103,5 +103,4 @@ echo "Running 'qemu-img check -r all \$TEST_IMG'"
 "${QEMU_IMG}" check -r all "${TEST_IMG}" 2>&1 | _filter_testdir | _filter_qemu
 
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/092 b/tests/qemu-iotests/092
index eeb039c7bd..041d888984 100755
--- a/tests/qemu-iotests/092
+++ b/tests/qemu-iotests/092
@@ -91,5 +91,4 @@ poke_file "$TEST_IMG" "$offset_backing_file_size" "\x7f\xff\xff\xff"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index aa5faff5de..47ff00651f 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -80,5 +80,4 @@ wait=1 _cleanup_qemu
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index fa17640c2c..bc80c019ed 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -81,5 +81,4 @@ TEST_IMG="${TEST_IMG}.base" _img_info | _filter_img_info
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 2914da2da3..2a68a08358 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -121,5 +121,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index 97f890dcf7..afe5b72c87 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -75,5 +75,4 @@ rm -f "$TEST_DIR/blkdebug.conf"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index 8e8306d1e3..ac94ca7f21 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -123,5 +123,4 @@ rm -f "$TEST_IMG.compare" "$TEST_DIR/blkdebug.conf"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/101 b/tests/qemu-iotests/101
index 38dace6aec..cc57078727 100755
--- a/tests/qemu-iotests/101
+++ b/tests/qemu-iotests/101
@@ -51,5 +51,4 @@ $QEMU_IO -c "read -P 0 0 512" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 0fac4555b2..9acc2772c7 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -75,5 +75,4 @@ _send_qemu_cmd $QEMU_HANDLE 'quit' ''
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 55df533835..eaab111b5a 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -102,5 +102,4 @@ $QEMU_IO -c "open -o cache-size=0 $TEST_IMG" -c 'write 0 64k' | _filter_qemu_io
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 903471346f..5818b449da 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -47,5 +47,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 68c6b732c2..e975f2930e 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -63,5 +63,4 @@ $QEMU_IO -c "write 14T 4096" "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index 9771198d70..ee81af19da 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -86,5 +86,4 @@ done
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index 7ddb27fbc9..87e2a22cec 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -53,6 +53,5 @@ $QEMU_IO -c "open -o driver=raw $TEST_IMG" -c 'read -p -P 0 196616 65528' \
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
 
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 1284fc98d1..31ea282f20 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -136,5 +136,4 @@ _check_test_img -r all
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/109 b/tests/qemu-iotests/109
index 87985f66fb..e011ad86c3 100755
--- a/tests/qemu-iotests/109
+++ b/tests/qemu-iotests/109
@@ -130,5 +130,4 @@ done
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 0f62778f15..e596efddb5 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -87,5 +87,4 @@ _make_test_img -b "$TEST_IMG_REL.base"
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index 85b6dd1746..37223d93d7 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -46,5 +46,4 @@ $QEMU_IMG create -f $IMGFMT -b "$TEST_IMG.inexistent" "$TEST_IMG" 2>&1 \
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index 5c4ecfeb4c..221892fbd1 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -289,5 +289,4 @@ _check_test_img
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
index 91af75d687..9d48020b94 100755
--- a/tests/qemu-iotests/113
+++ b/tests/qemu-iotests/113
@@ -69,5 +69,4 @@ $QEMU_IMG amend -f $IMGFMT -o foo=bar "$TEST_IMG" 2>&1 | _filter_imgfmt
 # success, all done
 echo
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index 66313cae91..44ef79a87f 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -55,5 +55,4 @@ $QEMU_IO -c "open -o backing.driver=$IMGFMT $TEST_IMG" -c "read 0 4k" | _filter_
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 2f06622e36..f2ec8fbd44 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -88,5 +88,4 @@ $QEMU_IMG check "$TEST_IMG" | \
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/116 b/tests/qemu-iotests/116
index 7378c34bd6..715a44200f 100755
--- a/tests/qemu-iotests/116
+++ b/tests/qemu-iotests/116
@@ -89,5 +89,4 @@ $QEMU_IO -f "$IMGFMT" -c "read 0 $size" "$TEST_IMG" 2>&1 | _filter_qemu_io | _fi
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 2ace2c9f89..07aca0eba1 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -80,5 +80,4 @@ $QEMU_IO -c 'read -P 42 0 64k' "$TEST_IMG" | _filter_qemu_io
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index 3df227748a..dbc7350458 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -53,5 +53,4 @@ echo "{'execute': 'qmp_capabilities'}
 # success, all done
 echo
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index 0ce0a2c9cd..3816260951 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -59,5 +59,4 @@ $QEMU_IO_PROG -c 'read -P 42 0 64k' \
 # success, all done
 echo
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index c6ce9e782a..04b38c9de8 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -95,5 +95,4 @@ _check_test_img
 # success, all done
 echo
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index e513b6abbf..ea4ba0f098 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -216,5 +216,4 @@ done
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index 9edcc4c8d2..6701c7ab54 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -55,5 +55,4 @@ $QEMU_IO -c 'read -P 42 0 1M' "$TEST_IMG" | _filter_qemu_io
 # success, all done
 echo
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 1a11496024..6a0504ba0a 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -127,5 +127,4 @@ done
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index 73ed16a9af..882ace0191 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -99,5 +99,4 @@ popd >/dev/null
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index ee7e3d365d..e84f0d80f6 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -91,5 +91,4 @@ wait=yes _cleanup_qemu
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/128 b/tests/qemu-iotests/128
index 412d4f86ca..51009f18f6 100755
--- a/tests/qemu-iotests/128
+++ b/tests/qemu-iotests/128
@@ -84,5 +84,4 @@ _sudo_qemu_io_wrapper --format "$IMGFMT" --nocache \
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index e5986d59bb..ed234c3b6d 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -90,5 +90,4 @@ _img_info | _filter_img_info
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/131 b/tests/qemu-iotests/131
index 930a80e02f..9c12d6c7f9 100755
--- a/tests/qemu-iotests/131
+++ b/tests/qemu-iotests/131
@@ -70,5 +70,4 @@ _check_test_img -r all
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 61af222c9e..61adc4374b 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -83,5 +83,4 @@ $QEMU_IO -c 'reopen -o backing.driver=qcow2' $TEST_IMG
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 59f2662614..c1c45c66d6 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -72,5 +72,4 @@ $QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --image-opts $IMGSPEC | _f
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/135 b/tests/qemu-iotests/135
index a6d35c147a..5c41718490 100755
--- a/tests/qemu-iotests/135
+++ b/tests/qemu-iotests/135
@@ -47,5 +47,4 @@ $QEMU_IMG info "$TEST_IMG" 2>&1| _filter_testdir
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 1c3981c982..1e6c6afcca 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -138,5 +138,4 @@ $QEMU_IO \
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 4b21217038..cb98fc34b9 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -66,5 +66,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index bdc1e08027..63390fd896 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -97,5 +97,4 @@ wait=1 _cleanup_qemu
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index c5e3981530..996bf16963 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -183,5 +183,4 @@ _cleanup_qemu
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 6a8d6d8daa..6cb73bc6fa 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -352,5 +352,4 @@ echo "$hmp_cmds" | run_qemu -drive "$files","$ids" | grep "Cache"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index 100d225e24..1ae5296607 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -67,5 +67,4 @@ wait=1 _cleanup_qemu
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 65fcfb77a6..d6015ce0eb 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -108,5 +108,4 @@ _send_qemu_cmd $h "{ 'execute': 'blockdev-snapshot-sync',
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index 3fa205a07d..c81bbb8a20 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -61,5 +61,4 @@ echo quit | $QEMU -nographic $SYSEMU_EXTRA_ARGS -drive $SYSEMU_DRIVE_ARG \
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 6b418c60f7..238658d642 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -159,5 +159,4 @@ echo
 ${QEMU_IO} -c "open -o driver=vpc,force_size_calc=current_size ${TEST_IMG}" -c 'map'
 
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/150 b/tests/qemu-iotests/150
index 51e4e124cd..6c5d54228b 100755
--- a/tests/qemu-iotests/150
+++ b/tests/qemu-iotests/150
@@ -67,5 +67,4 @@ $QEMU_IMG map "$TEST_IMG" | _filter_qemu_img_map
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index ae9158fa91..54f3ad8c79 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -228,5 +228,4 @@ _cleanup_qemu
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index 7bf0c2e91e..7b56d60339 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -451,5 +451,4 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 62100fff7a..618060180c 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -170,5 +170,4 @@ echo
 
 # success, all done
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 2b2b886e99..c44edd65e7 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -94,5 +94,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index fe3318bbe2..abf79f3cc2 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -80,5 +80,4 @@ $QEMU_IO --object $SECRET -c "read -P 0xa 1024 64512" --image-opts $IMGSPEC | _f
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 6cadc0c75b..c601c13525 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -110,5 +110,4 @@ rm -f 42
 # success, all done
 echo
 echo '*** done'
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index 3ea97f46b6..93b119939d 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -206,5 +206,4 @@ _cleanup_test_img
 # success, all done
 echo
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 2fd80c7844..56376f0f37 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -245,5 +245,4 @@ check_cache_mode -device floppy,drive=none0,write-cache=off
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index 0df1865199..f5185a1945 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -92,5 +92,4 @@ _cleanup_qemu
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
index 2c530a1e64..b1527583c7 100755
--- a/tests/qemu-iotests/174
+++ b/tests/qemu-iotests/174
@@ -35,9 +35,15 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+_fail()
+{
+    echo "$*"
+    status=1
+    exit 1
+}
+
 _unsupported_fmt raw
 
-
 size=256K
 IMGFMT=raw IMGKEYSECRET= IMGOPTS= _make_test_img $size | _filter_imgfmt
 
@@ -53,5 +59,4 @@ test $? -eq 1 || _fail "did not fail"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index a000405737..b9703dd99c 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -55,5 +55,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 9928833137..9f4a5db86a 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -125,5 +125,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index ffa3d3148b..4eba90243d 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -164,5 +164,4 @@ done
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index b308c8194f..cd90eb98c5 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -128,5 +128,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index c7cd4ff678..f7705b36f7 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -71,5 +71,4 @@ _cleanup_qemu
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 764632c16b..ced0df4a76 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -134,5 +134,4 @@ $QEMU_IMG compare "$TEST_IMG.dest" "$TEST_IMG"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index 1b2859de5a..c5d0226a67 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -200,5 +200,4 @@ EOF
 echo
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 563ae366fd..09ebe6b659 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -204,5 +204,4 @@ _check_test_img
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 3d52508452..a87a7f81ff 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -141,5 +141,4 @@ check_info_block -drive if=pflash,driver=null-co,size=1M
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index 4351702784..4d304f91ca 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -63,5 +63,4 @@ $QEMU_IO -c 'reopen -r' -c 'reopen -w' -c 'write 0 64k' $TEST_IMG | _filter_qemu
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index 042bf96178..6e945ccf38 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -70,5 +70,4 @@ $QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --image-opts $IMGSPEC | _f
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
index 9108495d99..5213057b14 100755
--- a/tests/qemu-iotests/189
+++ b/tests/qemu-iotests/189
@@ -80,5 +80,4 @@ $QEMU_IO --object $SECRET0 --object $SECRET1 -c "read -P 0xa 1024 64512" --image
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index aceba63b49..577bbb70f7 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -53,5 +53,4 @@ $QEMU_IMG measure -O qcow2 -o cluster_size=2M -f qcow2 "$TEST_IMG"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index 25d94211d9..0f740f7b38 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -148,5 +148,4 @@ TEST_IMG="$TEST_IMG.ovl2" _img_info
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 37fbb71cd0..5d0af35816 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -66,5 +66,4 @@ _send_qemu_cmd $h "q" "(qemu)"
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index 248cf90f53..ff6b1fde9d 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -87,5 +87,4 @@ _img_info
 
 # success, all done
 echo "*** done"
-rm -f $seq.full
 status=0
-- 
2.13.6
