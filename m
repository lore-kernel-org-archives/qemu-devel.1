Received: from eggs.gnu.org ([2001:4830:134:3::10]:59892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7g-0007cx-21
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eFO7Z-0003Gq-OJ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 12:38:44 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 16 Nov 2017 12:38:03 -0500
Message-Id: <20171116173810.16457-4-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-1-crosa@redhat.com>
References: <20171116173810.16457-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 03/10] qemu-iotests: be strict with expected
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>

The contract between runner (check) and test is one that accepts some
minor differences in the expcted output, as the comparison method
employed is a "diff -w".

This is an exception to a clearer and more straightforward rule of
just requiring the generated output to be *equal* (and not similar) to
the recorded expected output.

Let's drop this exception and make things more predictable.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/026.out | 92 +++++++++++++++++++++++-----------------------
 tests/qemu-iotests/049.out |  4 +-
 tests/qemu-iotests/061.out |  4 +-
 tests/qemu-iotests/104.out |  2 +-
 tests/qemu-iotests/109.out | 44 +++++++++++-----------
 tests/qemu-iotests/175.out |  2 +-
 tests/qemu-iotests/check   |  4 +-
 7 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index 86a50a2e13..38d76418b7 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -3,7 +3,7 @@ Errors while writing 128 kB
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l1_update; errno: 5; imm: off; once: on; write
+Event: l1_update; errno: 5; imm: off; once: on; write 
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -13,7 +13,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l1_update; errno: 5; imm: off; once: off; write
+Event: l1_update; errno: 5; imm: off; once: off; write 
 Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
@@ -31,7 +31,7 @@ write failed: Input/output error
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l1_update; errno: 28; imm: off; once: on; write
+Event: l1_update; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -41,7 +41,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l1_update; errno: 28; imm: off; once: off; write
+Event: l1_update; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
@@ -59,7 +59,7 @@ write failed: No space left on device
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_load; errno: 5; imm: off; once: on; write
+Event: l2_load; errno: 5; imm: off; once: on; write 
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
@@ -75,7 +75,7 @@ read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_load; errno: 5; imm: off; once: off; write
+Event: l2_load; errno: 5; imm: off; once: off; write 
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
@@ -91,7 +91,7 @@ read failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_load; errno: 28; imm: off; once: on; write
+Event: l2_load; errno: 28; imm: off; once: on; write 
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: No space left on device
@@ -107,7 +107,7 @@ read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_load; errno: 28; imm: off; once: off; write
+Event: l2_load; errno: 28; imm: off; once: off; write 
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: No space left on device
@@ -123,7 +123,7 @@ read failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_update; errno: 5; imm: off; once: on; write
+Event: l2_update; errno: 5; imm: off; once: on; write 
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -133,7 +133,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_update; errno: 5; imm: off; once: off; write
+Event: l2_update; errno: 5; imm: off; once: off; write 
 Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
@@ -151,7 +151,7 @@ write failed: Input/output error
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_update; errno: 28; imm: off; once: on; write
+Event: l2_update; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -161,7 +161,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_update; errno: 28; imm: off; once: off; write
+Event: l2_update; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
@@ -179,7 +179,7 @@ write failed: No space left on device
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_alloc_write; errno: 5; imm: off; once: on; write
+Event: l2_alloc_write; errno: 5; imm: off; once: on; write 
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -189,7 +189,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_alloc_write; errno: 5; imm: off; once: off; write
+Event: l2_alloc_write; errno: 5; imm: off; once: off; write 
 Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
@@ -205,7 +205,7 @@ write failed: Input/output error
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_alloc_write; errno: 28; imm: off; once: on; write
+Event: l2_alloc_write; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -215,7 +215,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: l2_alloc_write; errno: 28; imm: off; once: off; write
+Event: l2_alloc_write; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
@@ -231,7 +231,7 @@ write failed: No space left on device
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: write_aio; errno: 5; imm: off; once: on; write
+Event: write_aio; errno: 5; imm: off; once: on; write 
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -241,7 +241,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: write_aio; errno: 5; imm: off; once: off; write
+Event: write_aio; errno: 5; imm: off; once: off; write 
 Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
@@ -255,7 +255,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: write_aio; errno: 28; imm: off; once: on; write
+Event: write_aio; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -265,7 +265,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: write_aio; errno: 28; imm: off; once: off; write
+Event: write_aio; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
@@ -279,7 +279,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_load; errno: 5; imm: off; once: on; write
+Event: refblock_load; errno: 5; imm: off; once: on; write 
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -289,7 +289,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_load; errno: 5; imm: off; once: off; write
+Event: refblock_load; errno: 5; imm: off; once: off; write 
 Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
@@ -303,7 +303,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_load; errno: 28; imm: off; once: on; write
+Event: refblock_load; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -313,7 +313,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_load; errno: 28; imm: off; once: off; write
+Event: refblock_load; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
@@ -327,7 +327,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_update_part; errno: 5; imm: off; once: on; write
+Event: refblock_update_part; errno: 5; imm: off; once: on; write 
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -337,7 +337,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_update_part; errno: 5; imm: off; once: off; write
+Event: refblock_update_part; errno: 5; imm: off; once: off; write 
 Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
@@ -351,7 +351,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_update_part; errno: 28; imm: off; once: on; write
+Event: refblock_update_part; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -361,7 +361,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_update_part; errno: 28; imm: off; once: off; write
+Event: refblock_update_part; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
@@ -375,7 +375,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc; errno: 5; imm: off; once: on; write
+Event: refblock_alloc; errno: 5; imm: off; once: on; write 
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -385,7 +385,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc; errno: 5; imm: off; once: off; write
+Event: refblock_alloc; errno: 5; imm: off; once: off; write 
 Failed to flush the L2 table cache: Input/output error
 Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
@@ -399,7 +399,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc; errno: 28; imm: off; once: on; write
+Event: refblock_alloc; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -409,7 +409,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc; errno: 28; imm: off; once: off; write
+Event: refblock_alloc; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
@@ -423,7 +423,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: cluster_alloc; errno: 5; imm: off; once: on; write
+Event: cluster_alloc; errno: 5; imm: off; once: on; write 
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -433,7 +433,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: cluster_alloc; errno: 5; imm: off; once: off; write
+Event: cluster_alloc; errno: 5; imm: off; once: off; write 
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -443,7 +443,7 @@ write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: cluster_alloc; errno: 28; imm: off; once: on; write
+Event: cluster_alloc; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -453,7 +453,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: cluster_alloc; errno: 28; imm: off; once: off; write
+Event: cluster_alloc; errno: 28; imm: off; once: off; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -466,7 +466,7 @@ No errors were found on the image.
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write
+Event: refblock_alloc_hookup; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -476,7 +476,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write
+Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
@@ -494,7 +494,7 @@ write failed: No space left on device
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc_write; errno: 28; imm: off; once: on; write
+Event: refblock_alloc_write; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -504,7 +504,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc_write; errno: 28; imm: off; once: off; write
+Event: refblock_alloc_write; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
@@ -518,7 +518,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write
+Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -528,7 +528,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write
+Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
@@ -546,7 +546,7 @@ write failed: No space left on device
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write
+Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -556,7 +556,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write
+Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
@@ -574,7 +574,7 @@ write failed: No space left on device
 This means waste of disk space, but no harm to data.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write
+Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write 
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -584,7 +584,7 @@ write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
-Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write
+Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write 
 Failed to flush the L2 table cache: No space left on device
 Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 003247023e..5a93d8fc4b 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -106,7 +106,7 @@ qemu-img: Value '-1k' is out of range for parameter 'size'
 qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
-qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
+qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for 
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=1kilobyte TEST_DIR/t.qcow2
@@ -116,7 +116,7 @@ and exabytes, respectively.
 qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- foobar
-qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
+qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for 
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=foobar TEST_DIR/t.qcow2
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 942485de99..3dbbeb73ff 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -417,7 +417,7 @@ wrote 65536/65536 bytes at offset 2147483648
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 3221225472
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-    (0.00/100%)
    (12.50/100%)
    (25.00/100%)
    (37.50/100%)
    (50.00/100%)
    (62.50/100%)
    (75.00/100%)
    (87.50/100%)
    (100.00/100%)
    (100.00/100%)
+    (0.00/100%)
    (12.50/100%)
    (25.00/100%)
    (37.50/100%)
    (50.00/100%)
    (62.50/100%)
    (75.00/100%)
    (87.50/100%)
    (100.00/100%)
    (100.00/100%)
 No errors were found on the image.
 
 === Testing progress report with snapshot ===
@@ -432,6 +432,6 @@ wrote 65536/65536 bytes at offset 2147483648
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 3221225472
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-    (0.00/100%)
    (6.25/100%)
    (12.50/100%)
    (18.75/100%)
    (25.00/100%)
    (31.25/100%)
    (37.50/100%)
    (43.75/100%)
    (50.00/100%)
    (56.25/100%)
    (62.50/100%)
    (68.75/100%)
    (75.00/100%)
    (81.25/100%)
    (87.50/100%)
    (93.75/100%)
    (100.00/100%)
    (100.00/100%)
+    (0.00/100%)
    (6.25/100%)
    (12.50/100%)
    (18.75/100%)
    (25.00/100%)
    (31.25/100%)
    (37.50/100%)
    (43.75/100%)
    (50.00/100%)
    (56.25/100%)
    (62.50/100%)
    (68.75/100%)
    (75.00/100%)
    (81.25/100%)
    (87.50/100%)
    (93.75/100%)
    (100.00/100%)
    (100.00/100%)
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/104.out b/tests/qemu-iotests/104.out
index ab8d892c2a..f9f59d2950 100644
--- a/tests/qemu-iotests/104.out
+++ b/tests/qemu-iotests/104.out
@@ -9,4 +9,4 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1234
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 1.5K (1536 bytes)
-***done
+*** done
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index c189e2833d..4fcb497e5e 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -6,8 +6,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
@@ -32,8 +32,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 512, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
@@ -58,8 +58,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 262144, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
@@ -84,8 +84,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
@@ -110,8 +110,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
@@ -136,8 +136,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
@@ -161,8 +161,8 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
@@ -186,8 +186,8 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
@@ -211,8 +211,8 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
@@ -236,8 +236,8 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_ERROR", "data": {"device": "src", "operation": "write", "action": "report"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
@@ -261,8 +261,8 @@ Images are identical.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 {"return": {}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed raw.
-Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
-Specify the 'raw' format explicitly to remove the restrictions.
+         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"return": [{"io-status": "ok", "device": "src", "busy": false, "len": 512, "offset": 512, "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
index 76c02c6a57..53c5186dbd 100644
--- a/tests/qemu-iotests/175.out
+++ b/tests/qemu-iotests/175.out
@@ -15,4 +15,4 @@ size=1048576, blocks=2048
 == creating image with preallocation falloc ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=falloc
 size=1048576, blocks=2048
- *** done
+*** done
diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 08741328d0..7718b98bc4 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -795,7 +795,7 @@ do
                 echo " - no qualified output"
                 err=true
             else
-                if diff -w "$reference" $tmp.out >/dev/null 2>&1
+                if diff "$reference" $tmp.out >/dev/null 2>&1
                 then
                     echo ""
                     if $err
@@ -807,7 +807,7 @@ do
                 else
                     echo " - output mismatch (see $seq.out.bad)"
                     mv $tmp.out $seq.out.bad
-                    $diff -w "$reference" $(realpath $seq.out.bad)
+                    $diff "$reference" $(realpath $seq.out.bad)
                     err=true
                 fi
             fi
-- 
2.13.6
