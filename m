Received: from eggs.gnu.org ([2001:4830:134:3::10]:52611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cw7Ge-0003C3-W8
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cw7Gc-00035b-Jr
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:16:04 -0400
From: jemmy858585@gmail.com
Date: Thu,  6 Apr 2017 21:15:35 +0800
Message-Id: <1491484536-22776-2-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1491484536-22776-1-git-send-email-lidongchen@tencent.com>
References: <1491484536-22776-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 1/2] block: make bdrv_get_cluster_size public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <lidongchen@tencent.com>

The bdrv_get_cluster_size function is need by block migration
to optimize zero cluster.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 block/io.c            | 2 +-
 include/block/block.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 2709a70..1c31c2b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -459,7 +459,7 @@ void bdrv_round_to_clusters(BlockDriverState *bs,
     }
 }
 
-static int bdrv_get_cluster_size(BlockDriverState *bs)
+int bdrv_get_cluster_size(BlockDriverState *bs)
 {
     BlockDriverInfo bdi;
     int ret;
diff --git a/include/block/block.h b/include/block/block.h
index 5149260..a0d78fc 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -473,6 +473,7 @@ void bdrv_round_to_clusters(BlockDriverState *bs,
                             int64_t offset, unsigned int bytes,
                             int64_t *cluster_offset,
                             unsigned int *cluster_bytes);
+int bdrv_get_cluster_size(BlockDriverState *bs);
 
 const char *bdrv_get_encrypted_filename(BlockDriverState *bs);
 void bdrv_get_backing_filename(BlockDriverState *bs,
-- 
1.8.3.1
