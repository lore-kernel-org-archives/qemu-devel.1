Received: from eggs.gnu.org ([2001:4830:134:3::10]:42109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvj-0006aZ-QY
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cve-0007My-Q6
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d2cve-0007M8-Ge
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9A40C04B956
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 12:17:15 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Apr 2017 14:16:58 +0200
Message-Id: <20170424121708.31953-4-kraxel@redhat.com>
In-Reply-To: <20170424121708.31953-1-kraxel@redhat.com>
References: <20170424121708.31953-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/13] virtio-gpu: replace PIXMAN_* by
 PIXMAN_BE_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

This avoids a "#ifdef HOST_WORDS_BIGENDIAN" and this is the purpose
of PIXMAN_BE_* macros.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
Message-id: 20170403114044.15762-1-lvivier@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/virtio-gpu.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 9b530ab5b0..7befcef8d0 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -258,41 +258,22 @@ void virtio_gpu_get_display_info(VirtIOGPU *g,
 static pixman_format_code_t get_pixman_format(uint32_t virtio_gpu_format=
)
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
--=20
2.9.3
