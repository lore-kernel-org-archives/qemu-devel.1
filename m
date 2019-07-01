Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D09C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B65D208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B65D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuQB-0003aJ-U9
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43445)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hhuK3-0006XI-IZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hhuK1-0000op-3f
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:18:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hhuJw-0000Ph-Th; Mon, 01 Jul 2019 07:18:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2987C2F8BCD;
 Mon,  1 Jul 2019 11:17:48 +0000 (UTC)
Received: from localhost (ovpn-117-220.ams2.redhat.com [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 741A718351;
 Mon,  1 Jul 2019 11:17:45 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  1 Jul 2019 13:17:20 +0200
Message-Id: <20190701111722.32068-5-cohuck@redhat.com>
In-Reply-To: <20190701111722.32068-1-cohuck@redhat.com>
References: <20190701111722.32068-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 01 Jul 2019 11:17:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/6] vfio-ccw: use vfio_set_irq_signaling
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eric Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the new helper.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20190617101036.4087-1-cohuck@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 51 +++++++++++++--------------------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 03a2becb3ec9..a18bbd33b055 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -198,9 +198,8 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevi=
ce *vcdev, Error **errp)
 {
     VFIODevice *vdev =3D &vcdev->vdev;
     struct vfio_irq_info *irq_info;
-    struct vfio_irq_set *irq_set;
     size_t argsz;
-    int32_t *pfd;
+    int fd;
=20
     if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
         error_setg(errp, "vfio: unexpected number of io irqs %u",
@@ -224,56 +223,32 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDe=
vice *vcdev, Error **errp)
         goto out_free_info;
     }
=20
-    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
-    irq_set =3D g_malloc0(argsz);
-    irq_set->argsz =3D argsz;
-    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
-                     VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index =3D VFIO_CCW_IO_IRQ_INDEX;
-    irq_set->start =3D 0;
-    irq_set->count =3D 1;
-    pfd =3D (int32_t *) &irq_set->data;
-
-    *pfd =3D event_notifier_get_fd(&vcdev->io_notifier);
-    qemu_set_fd_handler(*pfd, vfio_ccw_io_notifier_handler, NULL, vcdev)=
;
-    if (ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        error_setg(errp, "vfio: Failed to set up io notification");
-        qemu_set_fd_handler(*pfd, NULL, NULL, vcdev);
+    fd =3D event_notifier_get_fd(&vcdev->io_notifier);
+    qemu_set_fd_handler(fd, vfio_ccw_io_notifier_handler, NULL, vcdev);
+
+    if (vfio_set_irq_signaling(vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
+        qemu_set_fd_handler(fd, NULL, NULL, vcdev);
         event_notifier_cleanup(&vcdev->io_notifier);
     }
=20
-    g_free(irq_set);
-
 out_free_info:
     g_free(irq_info);
 }
=20
 static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
 {
-    struct vfio_irq_set *irq_set;
-    size_t argsz;
-    int32_t *pfd;
-
-    argsz =3D sizeof(*irq_set) + sizeof(*pfd);
-    irq_set =3D g_malloc0(argsz);
-    irq_set->argsz =3D argsz;
-    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
-                     VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index =3D VFIO_CCW_IO_IRQ_INDEX;
-    irq_set->start =3D 0;
-    irq_set->count =3D 1;
-    pfd =3D (int32_t *) &irq_set->data;
-    *pfd =3D -1;
-
-    if (ioctl(vcdev->vdev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        error_report("vfio: Failed to de-assign device io fd: %m");
+    Error *err =3D NULL;
+
+    vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
+                           VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err);
+    if (err) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
     }
=20
     qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
                         NULL, NULL, vcdev);
     event_notifier_cleanup(&vcdev->io_notifier);
-
-    g_free(irq_set);
 }
=20
 static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
--=20
2.20.1


