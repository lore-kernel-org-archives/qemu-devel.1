Received: from eggs.gnu.org ([2001:4830:134:3::10]:57901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rD-0002X5-FF
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71rB-0007JR-Nr
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:51 +0200
Message-Id: <20181001171901.11004-14-kwolf@redhat.com>
In-Reply-To: <20181001171901.11004-1-kwolf@redhat.com>
References: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/23] qcow2: Make sizes more humanly readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Leonid Bloch <lbloch@janustech.com>

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h | 9 +++++----
 block/qcow2.c | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 81b844e936..a8d6f757b1 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -27,6 +27,7 @@
 
 #include "crypto/block.h"
 #include "qemu/coroutine.h"
+#include "qemu/units.h"
 
 //#define DEBUG_ALLOC
 //#define DEBUG_ALLOC2
@@ -43,11 +44,11 @@
 
 /* 8 MB refcount table is enough for 2 PB images at 64k cluster size
  * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
-#define QCOW_MAX_REFTABLE_SIZE 0x800000
+#define QCOW_MAX_REFTABLE_SIZE S_8MiB
 
 /* 32 MB L1 table is enough for 2 PB images at 64k cluster size
  * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
-#define QCOW_MAX_L1_SIZE 0x2000000
+#define QCOW_MAX_L1_SIZE S_32MiB
 
 /* Allow for an average of 1k per snapshot table entry, should be plenty of
  * space for snapshot names and IDs */
@@ -75,9 +76,9 @@
 
 /* Whichever is more */
 #define DEFAULT_L2_CACHE_CLUSTERS 8 /* clusters */
-#define DEFAULT_L2_CACHE_BYTE_SIZE 1048576 /* bytes */
+#define DEFAULT_L2_CACHE_SIZE S_1MiB
 
-#define DEFAULT_CLUSTER_SIZE 65536
+#define DEFAULT_CLUSTER_SIZE S_64KiB
 
 
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
diff --git a/block/qcow2.c b/block/qcow2.c
index c13153735a..d2c07ce9fe 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -830,7 +830,7 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
         }
     } else {
         if (!l2_cache_size_set) {
-            *l2_cache_size = MAX(DEFAULT_L2_CACHE_BYTE_SIZE,
+            *l2_cache_size = MAX(DEFAULT_L2_CACHE_SIZE,
                                  (uint64_t)DEFAULT_L2_CACHE_CLUSTERS
                                  * s->cluster_size);
         }
-- 
2.13.6
