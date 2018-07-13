Received: from eggs.gnu.org ([2001:4830:134:3::10]:41427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxq1-0004bh-Gs
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpy-0005f0-9W
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxpx-0005bo-N7
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 632FF72632
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:10:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:09:11 +0200
Message-Id: <20180713130916.4153-25-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 24/29] virtio-gpu: remove unused config_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 2 --
 hw/display/virtio-gpu.c        | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index c54c903a65..4c68bc4559 100644
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
index 30027f3384..7cfb25879a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1189,10 +1189,9 @@ static void virtio_gpu_device_realize(DeviceState =
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
2.18.0.129.ge3331758f1
