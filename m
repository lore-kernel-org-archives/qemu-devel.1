Received: from eggs.gnu.org ([2001:4830:134:3::10]:32773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1fjHdE-0000E5-M1
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 01:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <baiyaowei@cmss.chinamobile.com>) id 1fjHdD-0003fm-Rh
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 01:19:08 -0400
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Date: Sat, 28 Jul 2018 13:18:44 +0800
Message-Id: <1532755124-23795-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH] virtio-blk: fix comment for
 virtio_blk_rw_complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, mst@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: baiyaowei@cmss.chinamobile.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Here should be submit_requests, there is no submit_merged_requests
function.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 hw/block/virtio-blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 50b5c86..91cbede 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -97,8 +97,8 @@ static void virtio_blk_rw_complete(void *opaque, int ret)
 
         if (req->qiov.nalloc != -1) {
             /* If nalloc is != 1 req->qiov is a local copy of the original
-             * external iovec. It was allocated in submit_merged_requests
-             * to be able to merge requests. */
+             * external iovec. It was allocated in submit_requests to be
+             * able to merge requests. */
             qemu_iovec_destroy(&req->qiov);
         }
 
-- 
1.8.3.1
