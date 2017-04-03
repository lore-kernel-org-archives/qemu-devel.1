Received: from eggs.gnu.org ([2001:4830:134:3::10]:38007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cv0MA-0007zO-A5
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cv0M6-0003jX-Ul
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:41:10 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon,  3 Apr 2017 13:40:44 +0200
Message-Id: <20170403114044.15762-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-gpu: replace PIXMAN_* by PIXMAN_BE_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

This avoids a "#ifdef HOST_WORDS_BIGENDIAN" and this is the purpose
of PIXMAN_BE_* macros.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/display/virtio-gpu.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 9b530ab..7befcef 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -258,41 +258,22 @@ void virtio_gpu_get_display_info(VirtIOGPU *g,
 static pixman_format_code_t get_pixman_format(uint32_t virtio_gpu_format)
 {
     switch (virtio_gpu_format) {
-#ifdef HOST_WORDS_BIGENDIAN
     case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
-        return PIXMAN_b8g8r8x8;
+        return PIXMAN_BE_b8g8r8x8;
     case VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM:
-        return PIXMAN_b8g8r8a8;
+        return PIXMAN_BE_b8g8r8a8;
     case VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM:
-        return PIXMAN_x8r8g8b8;
+        return PIXMAN_BE_x8r8g8b8;
     case VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM:
-        return PIXMAN_a8r8g8b8;
+        return PIXMAN_BE_a8r8g8b8;
     case VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM:
-        return PIXMAN_r8g8b8x8;
+        return PIXMAN_BE_r8g8b8x8;
     case VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM:
-        return PIXMAN_r8g8b8a8;
+        return PIXMAN_BE_r8g8b8a8;
     case VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM:
-        return PIXMAN_x8b8g8r8;
+        return PIXMAN_BE_x8b8g8r8;
     case VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM:
-        return PIXMAN_a8b8g8r8;
-#else
-    case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
-        return PIXMAN_x8r8g8b8;
-    case VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM:
-        return PIXMAN_a8r8g8b8;
-    case VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM:
-        return PIXMAN_b8g8r8x8;
-    case VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM:
-        return PIXMAN_b8g8r8a8;
-    case VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM:
-        return PIXMAN_x8b8g8r8;
-    case VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM:
-        return PIXMAN_a8b8g8r8;
-    case VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM:
-        return PIXMAN_r8g8b8x8;
-    case VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM:
-        return PIXMAN_r8g8b8a8;
-#endif
+        return PIXMAN_BE_a8b8g8r8;
     default:
         return 0;
     }
-- 
2.9.3
