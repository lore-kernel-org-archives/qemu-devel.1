Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8C3C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4C92469C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPQZ4bce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4C92469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iJE-0000Un-E2
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7iIM-0007Ue-0n
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7iIK-0006Mp-Q6
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26340
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7iIK-0006MX-MQ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582906520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ssCl7iQooFNz+XiN2eUKax5ODBgAkEJO5ZgF5i78Ug=;
 b=hPQZ4bce0zrQkVlwou45mrFDmMRK7LD+6s/nZbalQkLT9rc4umPLRBoSRPk84Vzlhzj4Is
 Lu7CfU779scGRuIlKOBhfvgjuhT04Bu0o8L+8J4ye/tq0OVZWYPCachaMe4pyiwe1l7vsx
 EYqeiv00lnQt3nvljBB/3U5RV/+pnDM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-ifZgCyd7PL2aDfSKPDACOA-1; Fri, 28 Feb 2020 11:15:18 -0500
X-MC-Unique: ifZgCyd7PL2aDfSKPDACOA-1
Received: by mail-qk1-f199.google.com with SMTP id e11so3277342qkl.8
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mCBli3NzZY/CtljfJ87qAC58ePqvWGmUWXkzevfXcgs=;
 b=HPVDnTuXHA1uvWPXujs+2djKjug7OvR2f5gr9jA8SsMkCZjqxtktiLkqqVup1TFgh0
 JhMklYEevdrv8QJYjj8K/U8+7gao5lAo2ROBYtz8VSUAkvhwBzmZlwqwWlZfC8DBa1HF
 cGSm4aW5ywfWItn5toeCNvVAM5gNKOPGVR/31KIct2UlGjHqweZKeHkQs2SzOryjly5S
 2XlYl1npCxzBe8R571GWuS6Lb8xwf58mIntFGDb0AwhIdgl6HjNOiQNCSY4yqzmDHWzB
 vn/GDHZkGpNBldl6Nu3Wm21l5W6ucL3IbgAKoa7NF80QkqJAqErNF9jGWV8wQwit+hB2
 DIXg==
X-Gm-Message-State: APjAAAWthFyHCmb0anVhghhCYmT2+3yExTSXh1ZS5AsrnmX/6azxZiZw
 6ktyVzaeS9ARjav+qWqcAFJFhhqYCdAG/tgnsQw5f2qpMgdR7iHMX8XdVlpN3S5otw0mPCkfekm
 OQ+RdHSmIudqpMcw=
X-Received: by 2002:aed:204d:: with SMTP id 71mr4927613qta.116.1582906516605; 
 Fri, 28 Feb 2020 08:15:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqweWgL8hDVU0jD980U1HfJWmQOKlcRwZpBigQWWORlk46rgl9QatSnTV1wuGgAQJZVJGFYQiw==
X-Received: by 2002:aed:204d:: with SMTP id 71mr4927590qta.116.1582906516365; 
 Fri, 28 Feb 2020 08:15:16 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id i4sm5429255qkf.111.2020.02.28.08.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:15:15 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] vfio/pci: Use kvm_irqchip_add_irqfd_notifier_gsi() for
 irqfds
Date: Fri, 28 Feb 2020 11:15:00 -0500
Message-Id: <20200228161503.382656-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228161503.382656-1-peterx@redhat.com>
References: <20200228161503.382656-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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


