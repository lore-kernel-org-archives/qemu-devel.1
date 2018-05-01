Received: from eggs.gnu.org ([2001:4830:134:3::10]:48441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDY6K-0004TU-CX
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDY6F-00087U-Eo
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fDY6F-00086u-8Z
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:25:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F01A81DE3
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 16:25:54 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 01 May 2018 10:25:46 -0600
Message-ID: <20180501162546.28517.64220.stgit@gimli.home>
In-Reply-To: <20180501161509.28517.344.stgit@gimli.home>
References: <20180501161509.28517.344.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/3] virtio-gpu-3d: Define
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
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, mst@redhat.com

Commit 5643cc94ac1c ("virtio-gpu-3d: add support for second capability
set (v4)") updated virtio_gpu.h with a define that does not yet(?)
exist upstream resulting in build breakage every time Linux headers
are updated via the standard update script.  Conditionally define this
within QEMU code instead to avoid future breakage.

Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Fixes: 5643cc94ac1c ("virtio-gpu-3d: add support for second capability set (v4)")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 22ac3c2d0eba..6a39b6af8761 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -22,6 +22,12 @@
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
