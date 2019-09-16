Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE51FC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B3E206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B3E206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9m48-00060J-LI
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9m2s-0004rJ-Qt
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9m2r-00026S-HU
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9m2r-00026G-9k
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:37 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F25983F3D
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 08:07:36 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id 70so10796646ple.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 01:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nKl8CBZiHmXRaSy5myWUeqxs+ilBwf/wRKOrGyD7BZk=;
 b=avQwJJPNXrucjKSCp52oNMBc4SfJaQHlWsBqHmxlwSb0csmcMC5qbbEV0qa/y/KzI3
 +bxUfU12Mvg4PoOrJoBucbNVI688qxQ4KP8ozCpRwHTJPpA6MU8Rzmp84pBgdZCZm4C8
 xOoY9+Ca/Jx1DoF8pC7OBjZlbO5VcFXpZEGFs85YBzBtFLWd4yhwiY7cePHM8mA4Vh6F
 pXIl3AtYduqhL3bWjA+9UiZdc8C4hvpJ6Ibo5zfH623fmCZ+du1Qi3oaxd43833kPBcY
 w9oZQDdchOTY/01zRbAdmbFIxQFrpluthFJCN8VTMdwKPgFoDioEjrFePmZq7NeaOhYN
 ei+Q==
X-Gm-Message-State: APjAAAXiHrSKPaBJ/diwcPk1QlaR85Mlf63bk1PTBMIu69MvxqdxWshG
 /X8L3SXWY9xfm/45pROCML4S96JSkI4zRvQ1QplwwYpMkLZ2+bBEpmmqPPRI3tcAtCeQleddI8u
 s5iOl5BJLb9yv/5U=
X-Received: by 2002:a63:6097:: with SMTP id
 u145mr55686716pgb.227.1568621255632; 
 Mon, 16 Sep 2019 01:07:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyZAK4uFk2ziEouYfuiYu42mFxULSp82tsLZbOw0SbYn/EfEckQP5CCQ5P9ZvFvu2es/mpoKg==
X-Received: by 2002:a63:6097:: with SMTP id
 u145mr55686703pgb.227.1568621255358; 
 Mon, 16 Sep 2019 01:07:35 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r12sm43051515pgb.73.2019.09.16.01.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 01:07:34 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:07:15 +0800
Message-Id: <20190916080718.3299-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916080718.3299-1-peterx@redhat.com>
References: <20190916080718.3299-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/4] intel_iommu: Sanity check vfio-pci
 config on machine init done
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 peterx@redhat.com, Eric Auger <eric.auger@redhat.com>,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This check was previously only happened when the IOMMU is enabled in
the guest.  It was always too late because the enabling of IOMMU
normally only happens during the boot of guest OS.  It means that we
can bail out and exit directly during the guest OS boots if the
configuration of devices are not supported.  Or, if the guest didn't
enable vIOMMU at all, then the user can use the guest normally but as
long as it reconfigure the guest OS to enable the vIOMMU then reboot,
the user will see the panic right after the reset when the next boot
starts.

Let's make this failure even earlier so that we force the user to use
caching-mode for vfio-pci devices when with the vIOMMU.  So the user
won't get surprise at least during execution of the guest, which seems
a bit nicer.

This will affect some user who didn't enable vIOMMU in the guest OS
but was using vfio-pci and the vtd device in the past.  However I hope
it's not a majority because not enabling vIOMMU with the device
attached is actually meaningless.

We still keep the old assertion for safety so far because the hotplug
path could still reach it, so far.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 75ca6f9c70..bed8ffe446 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -35,6 +35,7 @@
 #include "hw/i386/x86-iommu.h"
 #include "hw/pci-host/q35.h"
 #include "sysemu/kvm.h"
+#include "sysemu/sysemu.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm_i386.h"
 #include "migration/vmstate.h"
@@ -64,6 +65,13 @@
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *=
n);
=20
+static void vtd_panic_require_caching_mode(void)
+{
+    error_report("We need to set caching-mode=3Don for intel-iommu to en=
able "
+                 "device assignment with IOMMU protection.");
+    exit(1);
+}
+
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t va=
l,
                             uint64_t wmask, uint64_t w1cmask)
 {
@@ -2929,9 +2937,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemo=
ryRegion *iommu,
     IntelIOMMUState *s =3D vtd_as->iommu_state;
=20
     if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
-        error_report("We need to set caching-mode=3Don for intel-iommu t=
o enable "
-                     "device assignment with IOMMU protection.");
-        exit(1);
+        vtd_panic_require_caching_mode();
     }
=20
     /* Update per-address-space notifier flags */
@@ -3699,6 +3705,32 @@ static bool vtd_decide_config(IntelIOMMUState *s, =
Error **errp)
     return true;
 }
=20
+static int vtd_machine_done_notify_one(Object *child, void *unused)
+{
+    IntelIOMMUState *iommu =3D INTEL_IOMMU_DEVICE(x86_iommu_get_default(=
));
+
+    /*
+     * We hard-coded here because vfio-pci is the only special case
+     * here.  Let's be more elegant in the future when we can, but so
+     * far there seems to be no better way.
+     */
+    if (object_dynamic_cast(child, "vfio-pci") && !iommu->caching_mode) =
{
+        vtd_panic_require_caching_mode();
+    }
+
+    return 0;
+}
+
+static void vtd_machine_done_hook(Notifier *notifier, void *unused)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   vtd_machine_done_notify_one, NULL);
+}
+
+static Notifier vtd_machine_done_notify =3D {
+    .notify =3D vtd_machine_done_hook,
+};
+
 static void vtd_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms =3D MACHINE(qdev_get_machine());
@@ -3744,6 +3776,7 @@ static void vtd_realize(DeviceState *dev, Error **e=
rrp)
     pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
     /* Pseudo address space under root PCI bus. */
     pcms->ioapic_as =3D vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAP=
IC);
+    qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
 }
=20
 static void vtd_class_init(ObjectClass *klass, void *data)
--=20
2.21.0


