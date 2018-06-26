Received: from eggs.gnu.org ([2001:4830:134:3::10]:44521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXqog-0007Zt-Ms
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXqoc-0000Ox-RH
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:27:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fXqoc-0000Of-Lw
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:27:38 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Jun 2018 18:27:36 +0200
Message-Id: <20180626162736.9749-4-kraxel@redhat.com>
In-Reply-To: <20180626162736.9749-1-kraxel@redhat.com>
References: <20180626162736.9749-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] virtio-gpu-3d: Drop workaround for
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

In commit a8bff79e9f27df we added a definition to hw/virtio/virtio-gpu.h
for VIRTIO_GPU_CAPSET_VIRGL2, as a workaround for it not yet being
in the Linux kernel headers. In commit 77d361b13c19 we updated our
kernel headers to a version which does define the macro, so we can
now remove our workaround.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180622173249.29963-1-peter.maydell@linaro.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index d6ba61f2f1..9780f755ef 100644
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
2.9.3
