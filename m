Received: from eggs.gnu.org ([209.51.188.92]:43380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmlP-0007at-5u
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gwmlO-0002ua-I3
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:43:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gwmlO-0002u0-CH
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 06:43:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 931BC81F10
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:43:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 Feb 2019 12:43:27 +0100
Message-Id: <20190221114330.17968-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190221114330.17968-1-marcandre.lureau@redhat.com>
References: <20190221114330.17968-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] virtio-gpu: remove unused qdev
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
 include/hw/virtio/virtio-gpu.h | 1 -
 hw/display/virtio-gpu.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index c8c599f1b9..c7cb821ae3 100644
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
index c6fab56f9b..a52c2aed0e 100644
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
2.21.0.rc1
