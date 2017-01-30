Received: from eggs.gnu.org ([2001:4830:134:3::10]:43555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYAen-0008A2-Nt
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cYAeg-00058s-Jl
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:02:01 -0500
From: Nir Soffer <nirsof@gmail.com>
Date: Mon, 30 Jan 2017 13:55:51 +0200
Message-Id: <20170130115551.27254-3-nirsof@gmail.com>
In-Reply-To: <20170130115551.27254-1-nirsof@gmail.com>
References: <20170130115551.27254-1-nirsof@gmail.com>
Subject: [Qemu-devel] [PATCH v3 3/3] qemu-io: Fix tests expecting the wrong
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Nir Soffer <nsoffer@redhat.com>, Nir Soffer <nirsof@gmail.com>

From: Nir Soffer <nsoffer@redhat.com>

Many tests expected the wrong behavior when qemu-io call into the
command with after failing to open the file, writing this error:

    no file open, try 'help open'

Now that we fail immediately when opening a file fails, this error does
not exist in the output; remove it from tests output.

Tested using:

./check 059 -vmdk (unrelated failure)
./check 070 -vhdx
./check 075 -cloop
./check 076 -parallels
./check 078 -bochs
./check 080 -qcow2
./check 083 -nbd
./check 088 -vpc
./check 092 -qcow
./check 116 -qed
./check 131 -parallels
./check 140 -raw
./check 140 -qcow2
./check -raw
./check -qcow2

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 tests/qemu-iotests/059.out |  3 ---
 tests/qemu-iotests/070.out |  1 -
 tests/qemu-iotests/075.out |  7 -------
 tests/qemu-iotests/076.out |  3 ---
 tests/qemu-iotests/078.out |  6 ------
 tests/qemu-iotests/080.out | 18 ------------------
 tests/qemu-iotests/083.out | 17 -----------------
 tests/qemu-iotests/088.out |  6 ------
 tests/qemu-iotests/092.out | 12 ------------
 tests/qemu-iotests/116.out |  7 -------
 tests/qemu-iotests/131.out |  1 -
 tests/qemu-iotests/140.out |  1 -
 12 files changed, 82 deletions(-)

diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 678adb4..898b528 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -3,17 +3,14 @@ QA output created by 059
 === Testing invalid granularity ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.vmdk: Invalid granularity, image may be corrupt
-no file open, try 'help open'
 
 === Testing too big L2 table size ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.vmdk: L2 table size too big
-no file open, try 'help open'
 
 === Testing too big L1 table size ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.vmdk: L1 size too big
-no file open, try 'help open'
 
 === Testing monolithicFlat creation and opening ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2147483648 subformat=monolithicFlat
diff --git a/tests/qemu-iotests/070.out b/tests/qemu-iotests/070.out
index 131a5b1..c269d99 100644
--- a/tests/qemu-iotests/070.out
+++ b/tests/qemu-iotests/070.out
@@ -4,7 +4,6 @@ QA output created by 070
 can't open device TEST_DIR/iotest-dirtylog-10G-4M.vhdx: VHDX image file 'TEST_DIR/iotest-dirtylog-10G-4M.vhdx' opened read-only, but contains a log that needs to be replayed
 To replay the log, run:
 qemu-img check -r all 'TEST_DIR/iotest-dirtylog-10G-4M.vhdx'
- no file open, try 'help open'
 === Verify open image replays log  ===
 read 18874368/18874368 bytes at offset 0
 18 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/075.out b/tests/qemu-iotests/075.out
index 87beae4..b234b75 100644
--- a/tests/qemu-iotests/075.out
+++ b/tests/qemu-iotests/075.out
@@ -10,29 +10,22 @@ read 512/512 bytes at offset 1048064
 
 == block_size must be a multiple of 512 ==
 can't open device TEST_DIR/simple-pattern.cloop: block_size 513 must be a multiple of 512
-no file open, try 'help open'
 
 == block_size cannot be zero ==
 can't open device TEST_DIR/simple-pattern.cloop: block_size cannot be zero
-no file open, try 'help open'
 
 == huge block_size ===
 can't open device TEST_DIR/simple-pattern.cloop: block_size 4294966784 must be 64 MB or less
-no file open, try 'help open'
 
 == offsets_size overflow ===
 can't open device TEST_DIR/simple-pattern.cloop: n_blocks 4294967295 must be 536870911 or less
-no file open, try 'help open'
 
 == refuse images that require too many offsets ===
 can't open device TEST_DIR/simple-pattern.cloop: image requires too many offsets, try increasing block size
-no file open, try 'help open'
 
 == refuse images with non-monotonically increasing offsets ==
 can't open device TEST_DIR/simple-pattern.cloop: offsets not monotonically increasing at index 1, image file is corrupt
-no file open, try 'help open'
 
 == refuse images with invalid compressed block size ==
 can't open device TEST_DIR/simple-pattern.cloop: invalid compressed block size at index 1, image file is corrupt
-no file open, try 'help open'
 *** done
diff --git a/tests/qemu-iotests/076.out b/tests/qemu-iotests/076.out
index 72645b2..9c66c5f 100644
--- a/tests/qemu-iotests/076.out
+++ b/tests/qemu-iotests/076.out
@@ -6,15 +6,12 @@ read 65536/65536 bytes at offset 0
 
 == Negative catalog size ==
 can't open device TEST_DIR/parallels-v1: Catalog too large
-no file open, try 'help open'
 
 == Overflow in catalog allocation ==
 can't open device TEST_DIR/parallels-v1: Catalog too large
-no file open, try 'help open'
 
 == Zero sectors per track ==
 can't open device TEST_DIR/parallels-v1: Invalid image: Zero sectors per track
-no file open, try 'help open'
 
 == Read from a valid v2 image ==
 read 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/078.out b/tests/qemu-iotests/078.out
index 42b8a83..c3d6aa4 100644
--- a/tests/qemu-iotests/078.out
+++ b/tests/qemu-iotests/078.out
@@ -6,23 +6,17 @@ read 512/512 bytes at offset 0
 
 == Negative catalog size ==
 can't open device TEST_DIR/empty.bochs: Catalog size is too large
-no file open, try 'help open'
 
 == Overflow for catalog size * sizeof(uint32_t) ==
 can't open device TEST_DIR/empty.bochs: Catalog size is too large
-no file open, try 'help open'
 
 == Too small catalog bitmap for image size ==
 can't open device TEST_DIR/empty.bochs: Catalog size is too small for this disk size
-no file open, try 'help open'
 can't open device TEST_DIR/empty.bochs: Catalog size is too small for this disk size
-no file open, try 'help open'
 
 == Negative extent size ==
 can't open device TEST_DIR/empty.bochs: Extent size 2147483648 is too large
-no file open, try 'help open'
 
 == Zero extent size ==
 can't open device TEST_DIR/empty.bochs: Extent size must be at least 512
-no file open, try 'help open'
 *** done
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 0daac48..6a7fda1 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -3,46 +3,33 @@ QA output created by 080
 == Huge header size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: qcow2 header exceeds cluster size
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: qcow2 header exceeds cluster size
-no file open, try 'help open'
 
 == Huge unknown header extension ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Invalid backing file offset
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Header extension too large
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Header extension too large
-no file open, try 'help open'
 
 == Huge refcount table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Reference count table too large
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Reference count table too large
-no file open, try 'help open'
 
 == Misaligned refcount table ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Invalid reference count table offset
-no file open, try 'help open'
 
 == Huge refcount offset ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Invalid reference count table offset
-no file open, try 'help open'
 
 == Invalid snapshot table ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Too many snapshots
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Too many snapshots
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Invalid snapshot table offset
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Invalid snapshot table offset
-no file open, try 'help open'
 
 == Hitting snapshot table size limit ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -53,13 +40,9 @@ read 512/512 bytes at offset 0
 == Invalid L1 table ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Active L1 table too large
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Active L1 table too large
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Invalid L1 table offset
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow2: Invalid L1 table offset
-no file open, try 'help open'
 
 == Invalid L1 table (with internal snapshot in the image) ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -68,7 +51,6 @@ qemu-img: Could not open 'TEST_DIR/t.IMGFMT': L1 table is too small
 == Invalid backing file size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow2: Backing file name too long
-no file open, try 'help open'
 
 == Invalid L2 entry (huge physical offset) ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index ef3d1e3..0c13888 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -2,52 +2,42 @@ QA output created by 083
 === Check disconnect before neg1 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect after neg1 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 8 neg1 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 16 neg1 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect before export ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect after export ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 4 export ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 12 export ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 16 export ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect before neg2 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect after neg2 ===
 
@@ -56,12 +46,10 @@ read failed: Input/output error
 === Check disconnect 8 neg2 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect 10 neg2 ===
 
 can't open device nbd:127.0.0.1:PORT:exportname=foo
-no file open, try 'help open'
 
 === Check disconnect before request ===
 
@@ -99,27 +87,22 @@ read 512/512 bytes at offset 0
 === Check disconnect before neg-classic ===
 
 can't open device nbd:127.0.0.1:PORT
-no file open, try 'help open'
 
 === Check disconnect 8 neg-classic ===
 
 can't open device nbd:127.0.0.1:PORT
-no file open, try 'help open'
 
 === Check disconnect 16 neg-classic ===
 
 can't open device nbd:127.0.0.1:PORT
-no file open, try 'help open'
 
 === Check disconnect 24 neg-classic ===
 
 can't open device nbd:127.0.0.1:PORT
-no file open, try 'help open'
 
 === Check disconnect 28 neg-classic ===
 
 can't open device nbd:127.0.0.1:PORT
-no file open, try 'help open'
 
 === Check disconnect after neg-classic ===
 
diff --git a/tests/qemu-iotests/088.out b/tests/qemu-iotests/088.out
index a2a83b8..1f6bcf0 100644
--- a/tests/qemu-iotests/088.out
+++ b/tests/qemu-iotests/088.out
@@ -3,15 +3,9 @@ QA output created by 088
 == Invalid block size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.vpc: Invalid block size 0
-no file open, try 'help open'
 can't open device TEST_DIR/t.vpc: Invalid block size 0
-no file open, try 'help open'
 can't open device TEST_DIR/t.vpc: Invalid block size 128
-no file open, try 'help open'
 can't open device TEST_DIR/t.vpc: Invalid block size 128
-no file open, try 'help open'
 can't open device TEST_DIR/t.vpc: Invalid block size 305419896
-no file open, try 'help open'
 can't open device TEST_DIR/t.vpc: Invalid block size 305419896
-no file open, try 'help open'
 *** done
diff --git a/tests/qemu-iotests/092.out b/tests/qemu-iotests/092.out
index e18f54c..6eda321 100644
--- a/tests/qemu-iotests/092.out
+++ b/tests/qemu-iotests/092.out
@@ -3,36 +3,24 @@ QA output created by 092
 == Invalid cluster size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: Cluster size must be between 512 and 64k
-no file open, try 'help open'
 
 == Invalid L2 table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: L2 table size must be between 512 and 64k
-no file open, try 'help open'
 
 == Invalid size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow: Image too large
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: Image too large
-no file open, try 'help open'
 
 == Invalid backing file length ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 can't open device TEST_DIR/t.qcow: Backing file name too long
-no file open, try 'help open'
 can't open device TEST_DIR/t.qcow: Backing file name too long
-no file open, try 'help open'
 *** done
diff --git a/tests/qemu-iotests/116.out b/tests/qemu-iotests/116.out
index 1f11d44..24bee57 100644
--- a/tests/qemu-iotests/116.out
+++ b/tests/qemu-iotests/116.out
@@ -3,35 +3,28 @@ QA output created by 116
 == truncated header cluster ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 
 == invalid header magic ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Image not in QED format
-no file open, try 'help open'
 
 == invalid cluster size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 
 == invalid table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 
 == invalid header size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 
 == invalid L1 table offset ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 
 == invalid image size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 can't open device TEST_DIR/t.qed: Could not open 'TEST_DIR/t.qed': Invalid argument
-no file open, try 'help open'
 *** done
diff --git a/tests/qemu-iotests/131.out b/tests/qemu-iotests/131.out
index ae2412e..27c2c53 100644
--- a/tests/qemu-iotests/131.out
+++ b/tests/qemu-iotests/131.out
@@ -23,7 +23,6 @@ read 32768/32768 bytes at offset 0
 32 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == Corrupt image ==
 can't open device TEST_DIR/t.parallels: parallels: Image was not closed correctly; cannot be opened read/write
-no file open, try 'help open'
 ERROR image was not closed correctly
 
 1 errors were found on the image.
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 0409cd0..6c04456 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -9,7 +9,6 @@ read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": {}}
 can't open device nbd+unix:///drv?socket=TEST_DIR/nbd: No export with name 'drv' available
-no file open, try 'help open'
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
 *** done
-- 
2.9.3
