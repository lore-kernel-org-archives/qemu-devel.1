Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7789C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E34E215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E34E215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33804 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6S0-0003ku-Pf
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56335)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hb6PL-0002Od-CQ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hb6PJ-0001VZ-DO
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:47:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hb6PJ-0001HK-3n
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:47:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A0F8619FB;
 Wed, 12 Jun 2019 16:47:11 +0000 (UTC)
Received: from gondolin (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F149E5D9D5;
 Wed, 12 Jun 2019 16:47:02 +0000 (UTC)
Date: Wed, 12 Jun 2019 18:46:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190612184659.4b4efcef.cohuck@redhat.com>
In-Reply-To: <20190612124004.27336-1-eric.auger@redhat.com>
References: <20190612124004.27336-1-eric.auger@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 12 Jun 2019 16:47:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5] vfio/common: Introduce
 vfio_set_irq_signaling helper
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
Cc: alex.williamson@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Jun 2019 14:40:04 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> The code used to assign an interrupt index/subindex to an
> eventfd is duplicated many times. Let's introduce an helper that
> allows to set/unset the signaling for an ACTION_TRIGGER,
> ACTION_MASK or ACTION_UNMASK action.
>=20
> In the error message, we now use errno in case of any
> VFIO_DEVICE_SET_IRQS ioctl failure.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Looks good to me.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

I currently have the following, still untested patch on top (vfio-ap
doesn't use this ioctl):

=46rom 9c2efe73d6139e8c7b2109ac2df79fe073d942fb Mon Sep 17 00:00:00 2001
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 12 Jun 2019 18:42:29 +0200
Subject: [PATCH] vfio-ccw: use vfio_set_irq_signaling()

Make use of the new helper.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 50 +++++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 37 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 03a2becb3ec9..3643be0ee254 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -198,9 +198,9 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice=
 *vcdev, Error **errp)
 {
     VFIODevice *vdev =3D &vcdev->vdev;
     struct vfio_irq_info *irq_info;
-    struct vfio_irq_set *irq_set;
     size_t argsz;
-    int32_t *pfd;
+    int fd;
+    Error *local_err =3D NULL;
=20
     if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
         error_setg(errp, "vfio: unexpected number of io irqs %u",
@@ -224,56 +224,32 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevi=
ce *vcdev, Error **errp)
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
-    qemu_set_fd_handler(*pfd, vfio_ccw_io_notifier_handler, NULL, vcdev);
-    if (ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        error_setg(errp, "vfio: Failed to set up io notification");
-        qemu_set_fd_handler(*pfd, NULL, NULL, vcdev);
+    fd =3D event_notifier_get_fd(&vcdev->io_notifier);
+    qemu_set_fd_handler(fd, vfio_ccw_io_notifier_handler, NULL, vcdev);
+    if (vfio_set_irq_signaling(vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, &local_err=
)) {
+        error_propagate(errp, local_err);
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
+    Error *local_err =3D NULL;
+
+    if (vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &local_err=
)) {
+        error_report_err(local_err);
     }
=20
     qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
                         NULL, NULL, vcdev);
     event_notifier_cleanup(&vcdev->io_notifier);
=20
-    g_free(irq_set);
 }
=20
 static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
--=20
2.20.1


