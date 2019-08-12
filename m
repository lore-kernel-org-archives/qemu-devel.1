Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EF3C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 07:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489DF206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 07:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489DF206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43503 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx52A-0005e9-Is
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 03:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51252)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hx51R-00043f-Aq
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hx51P-0007di-Nw
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hx51P-0007cV-EZ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so1437014wrr.8
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 00:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/RddpD4U/uvkTQBHUlrj6JKlm4EFO0cmLwADivRnN0c=;
 b=ZyJ3d+f+zT5fgxbQQkn4IhL3HlSW7xL8lCBddhQePTsK8bWucSvTXPGGbu4gSpzvKO
 pk85BAXocuffnEpWmuddPlm/lXzFO46+0qSdv5l35u8v7IYw/AEYNEeFhC+N08NZbXbm
 O3Em7LoI+0gBFPDYyMb5i+0diUPeX5m39xbKsGdXatK9tU/AQ3jaWLi4ns6B/Is7KJqj
 xaHqXupNiO/nkjHr/pE9QNEOO2He7rs88Q5MammVqIfqZRbMpq0f/UR8+X8yrhMgae/7
 iZThAJ4wSwfaWp1Yjz5XXcKzryOtf0V1+0IagsqRoJ5Ehfw8dSnQxKqDpP6U8y1baByT
 Stzg==
X-Gm-Message-State: APjAAAUXdW0qgZ71bGhgFSjPV1mxJh+rSDfq9H5Virkty8mMmMszbBiu
 HAGeKLmT4QqUThVRac0KzjumBhtZzRKbhw==
X-Google-Smtp-Source: APXvYqxqr+2cK6s8/wrE80i/+84bisxo6p5MkWyjenzgG22xS3d3EbTL2jQMpSS3UYSKsscoc7mvMQ==
X-Received: by 2002:adf:cd08:: with SMTP id w8mr2854034wrm.147.1565595936665; 
 Mon, 12 Aug 2019 00:45:36 -0700 (PDT)
Received: from xz-x1.redhat.com (net77-43-52-122.mclink.it. [77.43.52.122])
 by smtp.gmail.com with ESMTPSA id a84sm15909450wmf.29.2019.08.12.00.45.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 00:45:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 12 Aug 2019 09:45:28 +0200
Message-Id: <20190812074531.28970-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812074531.28970-1-peterx@redhat.com>
References: <20190812074531.28970-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: [Qemu-devel] [PATCH RFC 1/4] intel_iommu: Sanity check vfio-pci
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
 peterx@redhat.com, Bandan Das <bsd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index de86f53b4e..642dd595ed 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -61,6 +61,13 @@
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
@@ -2926,9 +2933,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     IntelIOMMUState *s = vtd_as->iommu_state;
 
     if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
-        error_report("We need to set caching-mode=on for intel-iommu to enable "
-                     "device assignment with IOMMU protection.");
-        exit(1);
+        vtd_panic_require_caching_mode();
     }
 
     /* Update per-address-space notifier flags */
@@ -3696,6 +3701,32 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
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
@@ -3741,6 +3772,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     pci_setup_iommu(bus, vtd_host_dma_iommu, dev);
     /* Pseudo address space under root PCI bus. */
     pcms->ioapic_as = vtd_host_dma_iommu(bus, s, Q35_PSEUDO_DEVFN_IOAPIC);
+    qemu_add_machine_init_done_notifier(&vtd_machine_done_notify);
 }
 
 static void vtd_class_init(ObjectClass *klass, void *data)
-- 
2.21.0


