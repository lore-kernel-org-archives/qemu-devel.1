Received: from eggs.gnu.org ([2001:4830:134:3::10]:60055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fMClI-0006LB-Go
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fMClH-0000t0-B0
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fMClH-0000p1-4m
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:03 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 14:27:50 +0100
Message-Id: <20180525132755.21839-2-peter.maydell@linaro.org>
In-Reply-To: <20180525132755.21839-1-peter.maydell@linaro.org>
References: <20180525132755.21839-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/6] virtio-gpu-3d: Define
 VIRTIO_GPU_CAPSET_VIRGL2 elsewhere
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Alex Williamson <alex.williamson@redhat.com>

Commit 5643cc94ac1c ("virtio-gpu-3d: add support for second capability
set (v4)") updated virtio_gpu.h with a define that does not yet(?)
exist upstream resulting in build breakage every time Linux headers
are updated via the standard update script.  Conditionally define this
within QEMU code instead to avoid future breakage.

Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Fixes: 5643cc94ac1c ("virtio-gpu-3d: add support for second capability set (v4)")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/virtio/virtio-gpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 79bb3fb3dd..d6ba61f2f1 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -21,6 +21,12 @@
 #include "qemu/log.h"
 
 #include "standard-headers/linux/virtio_gpu.h"
+
+/* Not yet(?) defined in standard-headers, remove when possible */
+#ifndef VIRTIO_GPU_CAPSET_VIRGL2
+#define VIRTIO_GPU_CAPSET_VIRGL2 2
+#endif
+
 #define TYPE_VIRTIO_GPU "virtio-gpu-device"
 #define VIRTIO_GPU(obj)                                        \
         OBJECT_CHECK(VirtIOGPU, (obj), TYPE_VIRTIO_GPU)
-- 
2.17.0
