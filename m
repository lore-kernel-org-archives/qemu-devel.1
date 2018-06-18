Received: from eggs.gnu.org ([2001:4830:134:3::10]:44088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwrE-0002Ek-Df
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwrD-0005G0-GU
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fUwrD-0005FL-Bn
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E7B7401EF03
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 16:18:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 18:17:23 +0200
Message-Id: <20180618161729.334-21-marcandre.lureau@redhat.com>
In-Reply-To: <20180618161729.334-1-marcandre.lureau@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 20/26] virtio-gpu: remove unused qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h | 1 -
 hw/display/virtio-gpu.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
index d6ba61f2f1..6cb13d2711 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -102,7 +102,6 @@ typedef struct VirtIOGPU {
     int enable;
=20
     int config_size;
-    DeviceState *qdev;
=20
     QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
     QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6a55416be7..7f7e18c2ee 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1192,7 +1192,6 @@ static void virtio_gpu_device_realize(DeviceState *=
qdev, Error **errp)
     QTAILQ_INIT(&g->fenceq);
=20
     g->enabled_output_bitmask =3D 1;
-    g->qdev =3D qdev;
=20
     for (i =3D 0; i < g->conf.max_outputs; i++) {
         g->scanout[i].con =3D
--=20
2.18.0.rc1
