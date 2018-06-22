Received: from eggs.gnu.org ([2001:4830:134:3::10]:54777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWPva-0006rI-MO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWPvZ-0000Qj-TT
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:32:54 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWPvZ-0000Oj-I8
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:32:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 18:32:49 +0100
Message-Id: <20180622173249.29963-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] virtio-gpu-3d: Drop workaround for
 VIRTIO_GPU_CAPSET_VIRGL2 define
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

In commit a8bff79e9f27df we added a definition to hw/virtio/virtio-gpu.h
for VIRTIO_GPU_CAPSET_VIRGL2, as a workaround for it not yet being
in the Linux kernel headers. In commit 77d361b13c19 we updated our
kernel headers to a version which does define the macro, so we can
now remove our workaround.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/virtio/virtio-gpu.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index d6ba61f2f12..9780f755ef0 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -22,11 +22,6 @@
 
 #include "standard-headers/linux/virtio_gpu.h"
 
-/* Not yet(?) defined in standard-headers, remove when possible */
-#ifndef VIRTIO_GPU_CAPSET_VIRGL2
-#define VIRTIO_GPU_CAPSET_VIRGL2 2
-#endif
-
 #define TYPE_VIRTIO_GPU "virtio-gpu-device"
 #define VIRTIO_GPU(obj)                                        \
         OBJECT_CHECK(VirtIOGPU, (obj), TYPE_VIRTIO_GPU)
-- 
2.17.1
