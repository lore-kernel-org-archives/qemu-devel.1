Received: from eggs.gnu.org ([2001:4830:134:3::10]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBQ-0006HZ-ID
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBO-0003xK-Vk
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fORBO-0003wv-RK
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73AAA401EF10
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:15:55 +0200
Message-Id: <20180531171606.21604-4-pbonzini@redhat.com>
In-Reply-To: <20180531171606.21604-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 42/53] virtio-gpu-3d: Define
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
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

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
Message-Id: <20180525132755.21839-2-peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
