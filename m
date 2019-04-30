Received: from eggs.gnu.org ([209.51.188.92]:46282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hLOLB-0005X7-CL
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hLOL8-00029Q-E1
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:42:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2494 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wangjie88@huawei.com>)
	id 1hLOKR-0001y8-K4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:42:14 -0400
From: Jie Wang <wangjie88@huawei.com>
Date: Tue, 30 Apr 2019 14:29:33 +0800
Message-ID: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] vhost: fix incorrect print type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, wangjie88@huawei.com, wu.wubin@huawei.com, eric.fangyi@huawei.com

fix incorrect print type in vhost_virtqueue_stop

Signed-off-by: Jie Wang <wangjie88@huawei.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7f61018f2a..286bb27c65 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1081,7 +1081,7 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
 
     r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
     if (r < 0) {
-        VHOST_OPS_DEBUG("vhost VQ %d ring restore failed: %d", idx, r);
+        VHOST_OPS_DEBUG("vhost VQ %u ring restore failed: %d", idx, r);
         /* Connection to the backend is broken, so let's sync internal
          * last avail idx to the device used idx.
          */
-- 
2.16.2.windows.1
