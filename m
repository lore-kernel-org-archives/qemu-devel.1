Received: from eggs.gnu.org ([2001:4830:134:3::10]:40887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKnkq-0005JF-WE
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKnk7-00018s-2u
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:01:33 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 30 Nov 2017 19:47:50 +0300
Message-Id: <20171130164750.47320-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171130164750.47320-1-vsementsov@virtuozzo.com>
References: <20171130164750.47320-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] qcow2: fix indentation after previous patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h | 34 +++++++++++++++++-----------------
 block/qcow2.c | 16 ++++++++--------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 8f226a3609..896ad08e5b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -399,29 +399,29 @@ typedef enum QCow2ClusterType {
 } QCow2ClusterType;
 
 typedef enum QCow2MetadataOverlap {
-    QCOW2_OL_MAIN_HEADER_BITNR    = 0,
-    QCOW2_OL_ACTIVE_L1_BITNR      = 1,
-    QCOW2_OL_ACTIVE_L2_BITNR      = 2,
-    QCOW2_OL_REFCOUNT_TABLE_BITNR = 3,
-    QCOW2_OL_REFCOUNT_BLOCK_BITNR = 4,
-    QCOW2_OL_SNAPSHOT_TABLE_BITNR = 5,
-    QCOW2_OL_INACTIVE_L1_BITNR    = 6,
-    QCOW2_OL_INACTIVE_L2_BITNR    = 7,
+    QCOW2_OL_MAIN_HEADER_BITNR      = 0,
+    QCOW2_OL_ACTIVE_L1_BITNR        = 1,
+    QCOW2_OL_ACTIVE_L2_BITNR        = 2,
+    QCOW2_OL_REFCOUNT_TABLE_BITNR   = 3,
+    QCOW2_OL_REFCOUNT_BLOCK_BITNR   = 4,
+    QCOW2_OL_SNAPSHOT_TABLE_BITNR   = 5,
+    QCOW2_OL_INACTIVE_L1_BITNR      = 6,
+    QCOW2_OL_INACTIVE_L2_BITNR      = 7,
     QCOW2_OL_BITMAP_DIRECTORY_BITNR = 8,
 
     QCOW2_OL_MAX_BITNR              = 9,
 
-    QCOW2_OL_NONE           = 0,
-    QCOW2_OL_MAIN_HEADER    = (1 << QCOW2_OL_MAIN_HEADER_BITNR),
-    QCOW2_OL_ACTIVE_L1      = (1 << QCOW2_OL_ACTIVE_L1_BITNR),
-    QCOW2_OL_ACTIVE_L2      = (1 << QCOW2_OL_ACTIVE_L2_BITNR),
-    QCOW2_OL_REFCOUNT_TABLE = (1 << QCOW2_OL_REFCOUNT_TABLE_BITNR),
-    QCOW2_OL_REFCOUNT_BLOCK = (1 << QCOW2_OL_REFCOUNT_BLOCK_BITNR),
-    QCOW2_OL_SNAPSHOT_TABLE = (1 << QCOW2_OL_SNAPSHOT_TABLE_BITNR),
-    QCOW2_OL_INACTIVE_L1    = (1 << QCOW2_OL_INACTIVE_L1_BITNR),
+    QCOW2_OL_NONE             = 0,
+    QCOW2_OL_MAIN_HEADER      = (1 << QCOW2_OL_MAIN_HEADER_BITNR),
+    QCOW2_OL_ACTIVE_L1        = (1 << QCOW2_OL_ACTIVE_L1_BITNR),
+    QCOW2_OL_ACTIVE_L2        = (1 << QCOW2_OL_ACTIVE_L2_BITNR),
+    QCOW2_OL_REFCOUNT_TABLE   = (1 << QCOW2_OL_REFCOUNT_TABLE_BITNR),
+    QCOW2_OL_REFCOUNT_BLOCK   = (1 << QCOW2_OL_REFCOUNT_BLOCK_BITNR),
+    QCOW2_OL_SNAPSHOT_TABLE   = (1 << QCOW2_OL_SNAPSHOT_TABLE_BITNR),
+    QCOW2_OL_INACTIVE_L1      = (1 << QCOW2_OL_INACTIVE_L1_BITNR),
     /* NOTE: Checking overlaps with inactive L2 tables will result in bdrv
      * reads. */
-    QCOW2_OL_INACTIVE_L2    = (1 << QCOW2_OL_INACTIVE_L2_BITNR),
+    QCOW2_OL_INACTIVE_L2      = (1 << QCOW2_OL_INACTIVE_L2_BITNR),
     QCOW2_OL_BITMAP_DIRECTORY = (1 << QCOW2_OL_BITMAP_DIRECTORY_BITNR),
 } QCow2MetadataOverlap;
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 8278c0e124..23f36a67c7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -687,14 +687,14 @@ static QemuOptsList qcow2_runtime_opts = {
 };
 
 static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
-    [QCOW2_OL_MAIN_HEADER_BITNR]    = QCOW2_OPT_OVERLAP_MAIN_HEADER,
-    [QCOW2_OL_ACTIVE_L1_BITNR]      = QCOW2_OPT_OVERLAP_ACTIVE_L1,
-    [QCOW2_OL_ACTIVE_L2_BITNR]      = QCOW2_OPT_OVERLAP_ACTIVE_L2,
-    [QCOW2_OL_REFCOUNT_TABLE_BITNR] = QCOW2_OPT_OVERLAP_REFCOUNT_TABLE,
-    [QCOW2_OL_REFCOUNT_BLOCK_BITNR] = QCOW2_OPT_OVERLAP_REFCOUNT_BLOCK,
-    [QCOW2_OL_SNAPSHOT_TABLE_BITNR] = QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE,
-    [QCOW2_OL_INACTIVE_L1_BITNR]    = QCOW2_OPT_OVERLAP_INACTIVE_L1,
-    [QCOW2_OL_INACTIVE_L2_BITNR]    = QCOW2_OPT_OVERLAP_INACTIVE_L2,
+    [QCOW2_OL_MAIN_HEADER_BITNR]      = QCOW2_OPT_OVERLAP_MAIN_HEADER,
+    [QCOW2_OL_ACTIVE_L1_BITNR]        = QCOW2_OPT_OVERLAP_ACTIVE_L1,
+    [QCOW2_OL_ACTIVE_L2_BITNR]        = QCOW2_OPT_OVERLAP_ACTIVE_L2,
+    [QCOW2_OL_REFCOUNT_TABLE_BITNR]   = QCOW2_OPT_OVERLAP_REFCOUNT_TABLE,
+    [QCOW2_OL_REFCOUNT_BLOCK_BITNR]   = QCOW2_OPT_OVERLAP_REFCOUNT_BLOCK,
+    [QCOW2_OL_SNAPSHOT_TABLE_BITNR]   = QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE,
+    [QCOW2_OL_INACTIVE_L1_BITNR]      = QCOW2_OPT_OVERLAP_INACTIVE_L1,
+    [QCOW2_OL_INACTIVE_L2_BITNR]      = QCOW2_OPT_OVERLAP_INACTIVE_L2,
     [QCOW2_OL_BITMAP_DIRECTORY_BITNR] = QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
 };
 
-- 
2.11.1
