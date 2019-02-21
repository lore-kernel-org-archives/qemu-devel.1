Received: from eggs.gnu.org ([209.51.188.92]:43437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmll-0007tA-RR
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmll-0003BL-1Z
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmlk-0002yZ-O4
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:44:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0173330821B4
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:43:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:43:28 +0100
Message-Id: <20190221114330.17968-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190221114330.17968-1-marcandre.lureau@redhat.com>
References: <20190221114330.17968-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] virtio-gpu: remove unused config_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 2 --
 hw/display/virtio-gpu.c        | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index c7cb821ae3..a1cecd1df8 100644
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
index a52c2aed0e..8f4351420b 100644
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
2.21.0.rc1
