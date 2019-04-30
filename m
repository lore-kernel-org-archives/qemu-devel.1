Received: from eggs.gnu.org ([209.51.188.92]:42559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hLO1y-0007cn-SJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hLO1u-0002y8-W5
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:22:26 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2061 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wangjie88@huawei.com>)
	id 1hLO1u-0002dm-Kz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:22:22 -0400
From: Jie Wang <wangjie88@huawei.com>
Date: Tue, 30 Apr 2019 14:10:14 +0800
Message-ID: <1556604614-32081-1-git-send-email-wangjie88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] vhost: remove the dead code
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

remove the dead code

Signed-off-by: Jie Wang <wangjie88@huawei.com>
---
 hw/virtio/vhost.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7f61018f2a..2303a8c206 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1650,7 +1650,6 @@ fail_vq:
                              hdev->vqs + i,
                              hdev->vq_index + i);
     }
-    i = hdev->nvqs;
 
 fail_mem:
 fail_features:
-- 
2.16.2.windows.1
