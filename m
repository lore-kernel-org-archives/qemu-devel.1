Received: from eggs.gnu.org ([2001:4830:134:3::10]:44558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lj-0007fU-2j
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fp1Lf-0001iN-FF
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 21:08:46 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 13 Aug 2018 04:07:23 +0300
Message-Id: <20180813010729.4844-3-lbloch@janustech.com>
In-Reply-To: <20180813010729.4844-1-lbloch@janustech.com>
References: <20180813010729.4844-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 2/8] qcow2: Make sizes more humanly readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 2 +-
 block/qcow2.h | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ec9e6238a0..67cc82f0b9 100644
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
diff --git a/block/qcow2.h b/block/qcow2.h
index 81b844e936..39e1b279f8 100644
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
+#define QCOW_MAX_REFTABLE_SIZE (8 * MiB)
 
 /* 32 MB L1 table is enough for 2 PB images at 64k cluster size
  * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
-#define QCOW_MAX_L1_SIZE 0x2000000
+#define QCOW_MAX_L1_SIZE (32 * MiB)
 
 /* Allow for an average of 1k per snapshot table entry, should be plenty of
  * space for snapshot names and IDs */
@@ -75,9 +76,9 @@
 
 /* Whichever is more */
 #define DEFAULT_L2_CACHE_CLUSTERS 8 /* clusters */
-#define DEFAULT_L2_CACHE_BYTE_SIZE 1048576 /* bytes */
+#define DEFAULT_L2_CACHE_SIZE (1 * MiB)
 
-#define DEFAULT_CLUSTER_SIZE 65536
+#define DEFAULT_CLUSTER_SIZE (64 * KiB)
 
 
 #define QCOW2_OPT_LAZY_REFCOUNTS "lazy-refcounts"
-- 
2.17.1
