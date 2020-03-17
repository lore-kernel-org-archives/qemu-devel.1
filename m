Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F9EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B38206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0lZdH31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B38206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIHH-0002if-SZ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jEIEw-0007uc-MC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jEIEv-0002GI-CV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:51:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37499)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jEIEv-0002Fm-8K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584474660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ssCl7iQooFNz+XiN2eUKax5ODBgAkEJO5ZgF5i78Ug=;
 b=V0lZdH31TVZGWIftqnOFzZJ2gkiHoqEEoDuVSyXKnCHHU9uWpQ8A1ynLJ8kxsVPbhdRf8U
 3GOA1Xdxo5qr6r8YCos5ERm1XZBzOgjWSkwigkGCI/Pdj5NZQSDfHW6Q6+GIGKOf2asBaE
 FIr+bOnM58iR0gxt5ZoXkM0g4nq0RB0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-H3lnBTfGNniU_tWCjyL-Wg-1; Tue, 17 Mar 2020 15:50:58 -0400
X-MC-Unique: H3lnBTfGNniU_tWCjyL-Wg-1
Received: by mail-wr1-f72.google.com with SMTP id u12so8742104wrw.10
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mCBli3NzZY/CtljfJ87qAC58ePqvWGmUWXkzevfXcgs=;
 b=Rh4wT095i583PfzsZJhs68zihrJ5J/yotZ+od4+ytSyGA+3dYQNYmuUQUvHJU2IiWC
 ycnDEL+cqxDNWNIbmowxNowiZs7HNUgCkmuf4QXe8AU/O48UQQyeec2RC3A8246pYYI4
 oe/TJxfL+E9Tse057Fa0LrEgibSpDS2yuzFBH3e9VnX1kjA1g4ujKLOma3EiOnHjT3kF
 ZicuqGuHQRsmu81cMR/KAB9KZCFQiW69sqB+ZizUrqQLPGmONS+1Lzcqj5gszp+SPmlm
 PyqjSbSInTz8XcooaYq5GHRwZ4SIVHC/CXK+R0Yyvwt9zmE+GQPjH/PFh7hsm7UZgLkz
 V2mg==
X-Gm-Message-State: ANhLgQ0DtfGfVTVKpd+/GPgJnuYXqFgcimd0HvP4x8GCZ8/3ptmGfrM5
 wnUomKLCMdEAgIQQ66B+0LV/79q8GMDfclqNqxxkSD3PxOGBquuBb+GIthvydAtBiAUHgpAWSMA
 EwffX/c45yNy13DE=
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr646134wrq.79.1584474656923;
 Tue, 17 Mar 2020 12:50:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv/91gc9c9smkJjbXwswK4kfToqysfihPBdTOefR4xQ4Z9sjShqxs789G0TngmZ5kmZmNrEJw==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr646110wrq.79.1584474656606;
 Tue, 17 Mar 2020 12:50:56 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id q13sm5761347wrs.91.2020.03.17.12.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 12:50:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi() for
 irqfds
Date: Tue, 17 Mar 2020 15:50:39 -0400
Message-Id: <20200317195042.282977-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317195042.282977-1-peterx@redhat.com>
References: <20200317195042.282977-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VFIO is currently the only one left that is not using the generic
function (kvm_irqchip_add_irqfd_notifier_gsi()) to register irqfds.
Let VFIO use the common framework too.

Follow up patches will introduce extra features for kvm irqfd, so that
VFIO can easily leverage that after the switch.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/pci.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 98e0e0c994..09703362df 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -115,11 +115,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
 static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
 #ifdef CONFIG_KVM
-    struct kvm_irqfd irqfd =3D {
-        .fd =3D event_notifier_get_fd(&vdev->intx.interrupt),
-        .gsi =3D vdev->intx.route.irq,
-        .flags =3D KVM_IRQFD_FLAG_RESAMPLE,
-    };
+    int irq_fd =3D event_notifier_get_fd(&vdev->intx.interrupt);
     Error *err =3D NULL;
=20
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
@@ -141,7 +137,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, E=
rror **errp)
     }
=20
     /* Get to a known interrupt state */
-    qemu_set_fd_handler(irqfd.fd, NULL, NULL, vdev);
+    qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
     vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending =3D false;
     pci_irq_deassert(&vdev->pdev);
@@ -152,17 +148,18 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev,=
 Error **errp)
         goto fail;
     }
=20
-    /* KVM triggers it, VFIO listens for it */
-    irqfd.resamplefd =3D event_notifier_get_fd(&vdev->intx.unmask);
-
-    if (kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd)) {
+    if (kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
+                                           &vdev->intx.interrupt,
+                                           &vdev->intx.unmask,
+                                           vdev->intx.route.irq)) {
         error_setg_errno(errp, errno, "failed to setup resample irqfd");
         goto fail_irqfd;
     }
=20
     if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0=
,
                                VFIO_IRQ_SET_ACTION_UNMASK,
-                               irqfd.resamplefd, &err)) {
+                               event_notifier_get_fd(&vdev->intx.unmask),
+                               &err)) {
         error_propagate(errp, err);
         goto fail_vfio;
     }
@@ -177,12 +174,12 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev,=
 Error **errp)
     return;
=20
 fail_vfio:
-    irqfd.flags =3D KVM_IRQFD_FLAG_DEASSIGN;
-    kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd);
+    kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt=
,
+                                          vdev->intx.route.irq);
 fail_irqfd:
     event_notifier_cleanup(&vdev->intx.unmask);
 fail:
-    qemu_set_fd_handler(irqfd.fd, vfio_intx_interrupt, NULL, vdev);
+    qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 #endif
 }
@@ -190,12 +187,6 @@ fail:
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 {
 #ifdef CONFIG_KVM
-    struct kvm_irqfd irqfd =3D {
-        .fd =3D event_notifier_get_fd(&vdev->intx.interrupt),
-        .gsi =3D vdev->intx.route.irq,
-        .flags =3D KVM_IRQFD_FLAG_DEASSIGN,
-    };
-
     if (!vdev->intx.kvm_accel) {
         return;
     }
@@ -209,7 +200,8 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     pci_irq_deassert(&vdev->pdev);
=20
     /* Tell KVM to stop listening for an INTx irqfd */
-    if (kvm_vm_ioctl(kvm_state, KVM_IRQFD, &irqfd)) {
+    if (kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.inter=
rupt,
+                                              vdev->intx.route.irq)) {
         error_report("vfio: Error: Failed to disable INTx irqfd: %m");
     }
=20
@@ -217,7 +209,8 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     event_notifier_cleanup(&vdev->intx.unmask);
=20
     /* QEMU starts listening for interrupt events. */
-    qemu_set_fd_handler(irqfd.fd, vfio_intx_interrupt, NULL, vdev);
+    qemu_set_fd_handler(event_notifier_get_fd(&vdev->intx.interrupt),
+                        vfio_intx_interrupt, NULL, vdev);
=20
     vdev->intx.kvm_accel =3D false;
=20
--=20
2.24.1


