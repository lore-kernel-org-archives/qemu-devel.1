Received: from eggs.gnu.org ([2001:4830:134:3::10]:45020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVHDa-0006nF-I6
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVHDZ-0001EC-Ul
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:58:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Jul 2017 14:57:21 +0200
Message-Id: <1499864249-26305-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/9] block: Make blk_get_attached_dev_id()
 public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c          | 3 +--
 include/sysemu/block-backend.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 0df3457..d60e53b 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -83,7 +83,6 @@ static const AIOCBInfo block_backend_aiocb_info = {
 
 static void drive_info_del(DriveInfo *dinfo);
 static BlockBackend *bdrv_first_blk(BlockDriverState *bs);
-static char *blk_get_attached_dev_id(BlockBackend *blk);
 
 /* All BlockBackends */
 static QTAILQ_HEAD(, BlockBackend) block_backends =
@@ -726,7 +725,7 @@ void *blk_get_attached_dev(BlockBackend *blk)
 
 /* Return the qdev ID, or if no ID is assigned the QOM path, of the block
  * device attached to the BlockBackend. */
-static char *blk_get_attached_dev_id(BlockBackend *blk)
+char *blk_get_attached_dev_id(BlockBackend *blk)
 {
     DeviceState *dev;
 
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 1e05281..80096f2 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -126,6 +126,7 @@ int blk_attach_dev(BlockBackend *blk, DeviceState *dev);
 void blk_attach_dev_legacy(BlockBackend *blk, void *dev);
 void blk_detach_dev(BlockBackend *blk, void *dev);
 void *blk_get_attached_dev(BlockBackend *blk);
+char *blk_get_attached_dev_id(BlockBackend *blk);
 BlockBackend *blk_by_dev(void *dev);
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
 void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *opaque);
-- 
1.8.3.1
