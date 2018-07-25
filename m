Received: from eggs.gnu.org ([2001:4830:134:3::10]:47499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiKmI-00050F-E2
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiKmF-00007h-EH
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:28:34 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Wed, 25 Jul 2018 17:27:55 +0300
Message-Id: <20180725142758.9980-2-lbloch@janustech.com>
In-Reply-To: <20180725142758.9980-1-lbloch@janustech.com>
References: <20180725142758.9980-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 1/4 for-3.0] qcow2: A grammar fix in
 conflicting cache sizing error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/qcow2.c              | 2 +-
 tests/qemu-iotests/103.out | 4 ++--
 tests/qemu-iotests/137.out | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6162ed8be2..ec9e6238a0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -797,7 +797,7 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
         if (l2_cache_size_set && refcount_cache_size_set) {
             error_setg(errp, QCOW2_OPT_CACHE_SIZE ", " QCOW2_OPT_L2_CACHE_SIZE
                        " and " QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not be set "
-                       "the same time");
+                       "at the same time");
             return;
         } else if (*l2_cache_size > combined_cache_size) {
             error_setg(errp, QCOW2_OPT_L2_CACHE_SIZE " may not exceed "
diff --git a/tests/qemu-iotests/103.out b/tests/qemu-iotests/103.out
index bd45d3875a..bd9eec3250 100644
--- a/tests/qemu-iotests/103.out
+++ b/tests/qemu-iotests/103.out
@@ -5,10 +5,10 @@ wrote 65536/65536 bytes at offset 0
 
 === Testing invalid option combinations ===
 
-can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set the same time
+can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
 can't open device TEST_DIR/t.IMGFMT: l2-cache-size may not exceed cache-size
 can't open device TEST_DIR/t.IMGFMT: refcount-cache-size may not exceed cache-size
-can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set the same time
+can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
 can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
 can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
 can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index 96724a6c33..6a2ffc71fd 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -16,7 +16,7 @@ read 33554432/33554432 bytes at offset 0
 === Try setting some invalid values ===
 
 Parameter 'lazy-refcounts' expects 'on' or 'off'
-cache-size, l2-cache-size and refcount-cache-size may not be set the same time
+cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
 l2-cache-size may not exceed cache-size
 refcount-cache-size may not exceed cache-size
 L2 cache size too big
-- 
2.14.1
