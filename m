Received: from eggs.gnu.org ([209.51.188.92]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Gdl-0004uL-2L
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Gdj-0002AI-AK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3Gdi-00029U-Ua
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:31 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 11 Mar 2019 09:50:22 +0100
Message-Id: <20190311085024.13780-4-kraxel@redhat.com>
In-Reply-To: <20190311085024.13780-1-kraxel@redhat.com>
References: <20190311085024.13780-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] virtio-gpu: make virtio_gpu_reset static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20190307080244.9011-4-kraxel@redhat.com
---
 include/hw/virtio/virtio-gpu.h | 1 -
 hw/display/virtio-gpu.c        | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index 98504f907583..ce0ca7217175 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -148,7 +148,6 @@ extern const GraphicHwOps virtio_gpu_ops;
     } while (0)
=20
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
=20
-void virtio_gpu_reset(VirtIODevice *vdev)
+static void virtio_gpu_reset(VirtIODevice *vdev)
 {
     VirtIOGPU *g =3D VIRTIO_GPU(vdev);
     struct virtio_gpu_simple_resource *res, *tmp;
--=20
2.18.1
