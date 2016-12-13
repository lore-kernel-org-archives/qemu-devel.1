Received: from eggs.gnu.org ([2001:4830:134:3::10]:52130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1cGiDh-0001kN-Vj
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1cGiDe-0003z4-Rl
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1cGiDe-0003v2-Lq
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id g23so16659474wme.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 00:13:28 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 13 Dec 2016 10:12:06 +0200
Message-Id: <1481616728-148412-3-git-send-email-yuri.benditovich@daynix.com>
In-Reply-To: <1481616728-148412-1-git-send-email-yuri.benditovich@daynix.com>
References: <1481616728-148412-1-git-send-email-yuri.benditovich@daynix.com>
Subject: [Qemu-devel] [PATCH v3 2/4] net: vhost stop updates virtio queue
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Make virtio queue suitable for push operation from qemu
after vhost was stopped.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/virtio/vhost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f7f7023..d396b22 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -993,6 +993,7 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
         virtio_queue_set_last_avail_idx(vdev, idx, state.num);
     }
     virtio_queue_invalidate_signalled_used(vdev, idx);
+    virtio_queue_update_used_idx(vdev, idx);
 
     /* In the cross-endian case, we need to reset the vring endianness to
      * native as legacy devices expect so by default.
-- 
1.9.1
