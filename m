Received: from eggs.gnu.org ([209.51.188.92]:40614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1nzV-0004az-Rt
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1nzT-0002Qh-VR
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:02:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1nzS-0002P2-3S
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 03:02:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 957C630718D4
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 08:02:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  7 Mar 2019 09:02:44 +0100
Message-Id: <20190307080244.9011-4-kraxel@redhat.com>
In-Reply-To: <20190307080244.9011-1-kraxel@redhat.com>
References: <20190307080244.9011-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] virtio-gpu: make virtio_gpu_reset static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 1 -
 hw/display/virtio-gpu.c        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 98504f907583..ce0ca7217175 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -148,7 +148,6 @@ extern const GraphicHwOps virtio_gpu_ops;
     } while (0)
 
 /* virtio-gpu.c */
-void virtio_gpu_reset(VirtIODevice *vdev);
 void virtio_gpu_ctrl_response(VirtIOGPU *g,
                               struct virtio_gpu_ctrl_command *cmd,
                               struct virtio_gpu_ctrl_hdr *resp,
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index a3627f58a9dd..4dbf48e42482 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1346,7 +1346,7 @@ static void virtio_gpu_instance_init(Object *obj)
 {
 }
 
-void virtio_gpu_reset(VirtIODevice *vdev)
+static void virtio_gpu_reset(VirtIODevice *vdev)
 {
     VirtIOGPU *g = VIRTIO_GPU(vdev);
     struct virtio_gpu_simple_resource *res, *tmp;
-- 
2.18.1
