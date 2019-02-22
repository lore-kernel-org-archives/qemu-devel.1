Received: from eggs.gnu.org ([209.51.188.92]:51059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx68n-0002d4-GZ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx68k-0007Jr-Si
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx68k-0007D4-Gf
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C3A0882EA
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:24:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 09:24:33 +0100
Message-Id: <20190222082436.23029-3-kraxel@redhat.com>
In-Reply-To: <20190222082436.23029-1-kraxel@redhat.com>
References: <20190222082436.23029-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/5] virtio-gpu: remove unused config_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Christophe Fergeau <cfergeau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190221114330.17968-3-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 2 --
 hw/display/virtio-gpu.c        | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index c7cb821ae3a5..a1cecd1df837 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -96,8 +96,6 @@ typedef struct VirtIOGPU {
=20
     int enable;
=20
-    int config_size;
-
     QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
     QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
     QTAILQ_HEAD(, virtio_gpu_ctrl_command) fenceq;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index a52c2aed0e26..8f4351420b01 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1238,10 +1238,9 @@ static void virtio_gpu_device_realize(DeviceState =
*qdev, Error **errp)
         }
     }
=20
-    g->config_size =3D sizeof(struct virtio_gpu_config);
     g->virtio_config.num_scanouts =3D cpu_to_le32(g->conf.max_outputs);
     virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
-                g->config_size);
+                sizeof(struct virtio_gpu_config));
=20
     g->req_state[0].width =3D g->conf.xres;
     g->req_state[0].height =3D g->conf.yres;
--=20
2.9.3
