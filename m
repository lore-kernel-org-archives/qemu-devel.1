Received: from eggs.gnu.org ([2001:4830:134:3::10]:53104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKW-0000T1-SW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKS-0007cB-W6
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:17:51 +0200
Message-Id: <1500387486-5469-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 06/21] block: Make blk_get_attached_dev_id()
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/block-backend.c          | 3 +--
 include/sysemu/block-backend.h | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index fe3542b..8171270 100644
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
index d9ea0cd..fe47799 100644
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
