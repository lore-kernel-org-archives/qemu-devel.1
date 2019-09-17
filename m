Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A217FC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9F42171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9F42171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFER-00070t-Ix
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF8A-0002UU-QI
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF88-0000Pg-W0
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF88-0000PV-Na
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:00 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E65B9C058CB8
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 15:10:59 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id k22so4554495qtm.7
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/WaFagnMbKh/h2WuJ8FQlSsR9KbfZmX5nXKCqZCh95U=;
 b=tiTmV0h/WM2hLmQQ79RzgJK04Rd72Q1711V6SjeUPs/I7OfLcmgBV3vQ4G9NdG6vQq
 m2n5koZRwJoki3+LyoxBEo2MqroMkXItwkrD5yUZx8mtSv0xEyVeIhG8k5fqpiClDfDP
 GC+8ll8vHzDKDs8ccl/23RHy47a2yvUBxTQc5AAw8fQC7EoyX48s5AM5fDRwhbImyTm2
 l357OFQKPFWVioMCPxjCZpgQR3E1jKIkZ675FXbglGh5VbLcCpJ+zRIzwjboUTG1yQXo
 yvTSZKfodT2s5nwl+HAvRKWX83qqqlulb2h4KCgCi5yN7T6bp91Zoi0H7b1Pd+i4paE4
 goDw==
X-Gm-Message-State: APjAAAVgWqtGyaH6oBRHGq8xaiPqqJN72oAhjO648AGIK7d8jixA57yO
 NSVMJ6t1QJBH3KR5QG5Iq2ZQPI5ShA4QSzansns3xaLRp+KRwvdJpt/SNQf83wUseAFjHTmXG0v
 bHjl8FbK0zdSz+ZE=
X-Received: by 2002:a37:4ecb:: with SMTP id c194mr4296876qkb.126.1568733058727; 
 Tue, 17 Sep 2019 08:10:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxz6FJO5dzKvzCDZzFGW2tVCETREBajNe4mSWcAnaSn/AeAo6VBjUx7w68f3oJSv8i99lZexA==
X-Received: by 2002:a37:4ecb:: with SMTP id c194mr4296855qkb.126.1568733058530; 
 Tue, 17 Sep 2019 08:10:58 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id u132sm1407780qka.50.2019.09.17.08.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:10:57 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:10:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190916080718.3299-2-peterx@redhat.com>
References: <20190917151011.24588-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190917151011.24588-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/10] intel_iommu: Sanity check vfio-pci config
 on machine init done
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190917151054.uN5KONI5LRBeNINGNAVTOXpQijvmweDwNJVuPSxxiTY@z>

From: Peter Xu <peterx@redhat.com>

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
Message-Id: <20190916080718.3299-2-peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
+static void vtd_panic_require_caching_mode(void)
+{
+    error_report("We need to set caching-mode=on for intel-iommu to enable "
+                 "device assignment with IOMMU protection.");
+    exit(1);
+}
+
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
 {
@@ -2929,9 +2937,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     IntelIOMMUState *s = vtd_as->iommu_state;
 
     if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
-        error_report("We need to set caching-mode=on for intel-iommu to enable "
-                     "device assignment with IOMMU protection.");
-        exit(1);
+        vtd_panic_require_caching_mode();
     }
 
     /* Update per-address-space notifier flags */
@@ -3699,6 +3705,32 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     return true;
 }
 
+static int vtd_machine_done_notify_one(Object *child, void *unused)
+{
+    IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
+
+    /*
+     * We hard-coded here because vfio-pci is the only special case
+     * here.  Let's be more elegant in the future when we can, but so
+     * far there seems to be no better way.
+     */
+    if (object_dynamic_cast(child, "vfio-pci") && !iommu->caching_mode) {
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
+static Notifier vtd_machine_done_notify = {
+    .notify = vtd_machine_done_hook,
+};
+
 static void vtd_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -3744,6 +3776,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
     /* Pseudo address space under root PCI bus. */
     pcms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
+    qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
 }
 
 static void vtd_class_init(ObjectClass *klass, void *data)
-- 
MST


