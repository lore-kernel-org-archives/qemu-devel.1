Received: from eggs.gnu.org ([209.51.188.92]:50973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx68l-0002cL-GN
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx68j-0007I3-Kp
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx68j-0007DQ-9s
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:25:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E974307D985
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 08:24:51 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 09:24:32 +0100
Message-Id: <20190222082436.23029-2-kraxel@redhat.com>
In-Reply-To: <20190222082436.23029-1-kraxel@redhat.com>
References: <20190222082436.23029-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] virtio-gpu: remove unused qdev
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
Message-id: 20190221114330.17968-2-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 1 -
 hw/display/virtio-gpu.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index c8c599f1b92a..c7cb821ae3a5 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -97,7 +97,6 @@ typedef struct VirtIOGPU {
     int enable;
=20
     int config_size;
-    DeviceState *qdev;
=20
     QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
     QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index c6fab56f9ba1..a52c2aed0e26 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1268,7 +1268,6 @@ static void virtio_gpu_device_realize(DeviceState *=
qdev, Error **errp)
     QTAILQ_INIT(&g->fenceq);
=20
     g->enabled_output_bitmask =3D 1;
-    g->qdev =3D qdev;
=20
     for (i =3D 0; i < g->conf.max_outputs; i++) {
         g->scanout[i].con =3D
--=20
2.9.3
