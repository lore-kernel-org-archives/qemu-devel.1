Received: from eggs.gnu.org ([2001:4830:134:3::10]:40525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsmGe-0004qZ-CI
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsmGb-0005e1-B8
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:46:32 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Sep 2017 10:46:21 +0200
Message-Id: <1505465181-4147-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/display/virtio-gpu: Put the
 virtio-gpu-device into the display category
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org

The virtio-gpu-pci device is already in the display category, so the
virtio-gpu-device should be there, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/virtio-gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index f0761cf..cc9385d 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1279,6 +1279,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
 
     vdc->reset = virtio_gpu_reset;
 
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     dc->props = virtio_gpu_properties;
     dc->vmsd = &vmstate_virtio_gpu;
     dc->hotpluggable = false;
-- 
1.8.3.1
