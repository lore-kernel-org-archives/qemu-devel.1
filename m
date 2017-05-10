Received: from eggs.gnu.org ([2001:4830:134:3::10]:58159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d8NqV-0000cZ-23
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d8NqR-0005vg-41
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:23:47 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 10 May 2017 17:23:33 +0800
Message-Id: <20170510092333.8890-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: Unregister memory listener when
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 03592c5..a7741f4 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2515,6 +2515,7 @@ static void virtio_device_unrealize(DeviceState *dev, Error **errp)
         }
     }
 
+    memory_listener_unregister(&vdev->listener);
     g_free(vdev->bus_name);
     vdev->bus_name = NULL;
 }
-- 
2.9.3
