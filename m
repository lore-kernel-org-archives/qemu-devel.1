Received: from eggs.gnu.org ([2001:4830:134:3::10]:44502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dGRRu-0006Sx-76
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dGRRr-0003Qy-23
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:51:42 -0400
Received: from m15-111.126.com ([220.181.15.111]:52512)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dGRRq-0003PB-C2
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:51:38 -0400
From: indiffPig@126.com
Date: Thu,  1 Jun 2017 10:51:27 -0400
Message-Id: <1496328687-13121-1-git-send-email-indiffPig@126.com>
Subject: [Qemu-devel] [PATCH] vhost_dev:qemu will quit when vhost_dev is null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, "yin.zuowei" <cxasm@qq.com>

From: "yin.zuowei" <cxasm@qq.com>

Signed-off-by: yin.zuowei <cxasm@qq.com>

when ovdk socket is not ok, this vhost_dev is null ,then qemu will be quit.
We think ovdk is just a network devices, should not cause an exit .
---
 hw/virtio/vhost-user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index dde094a..3a9fdf4 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -387,6 +387,9 @@ static int vhost_user_set_vring_base(struct vhost_dev *dev,
 static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
 {
     int i;
+    if (!dev) {
+        return -1;
+    }
 
     if (!virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
         return -1;
-- 
1.8.3.1
