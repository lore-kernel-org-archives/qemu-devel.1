Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185A8C10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 19:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA9E20879
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2DpoRNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA9E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDDJH-0000ef-WE
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 15:18:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDDIT-0000MO-4O
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 15:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDDIR-0005p6-7V
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 15:17:41 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:42626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sohailalvi2236@gmail.com>)
	id 1hDDIP-0005nm-Bu
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 15:17:37 -0400
Received: by mail-pl1-x62e.google.com with SMTP id cv12so6010479plb.9
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=xk0IR4py3Q73CS9m2OZw579cOOI17N0uvwH7IOVEyo4=;
	b=N2DpoRNjvZYRAdizs1Fe61XVqGVW5KNV+0Vv4qRhQyP1o+UtnuF71jBHfglAFHMAgB
	AFilWjO2OngrjLzLGNjhucN6rOYfALDflG96+xQtT7CtPNsms3WQKt2xS77md1Yc82Gr
	/NoQOu64BQGe2Er/KZWC+3fCL2+lR2Hqr6zLUUs4FATu+hc8wbd1hoDWSvQMbyY478xC
	GotC3+YgxBJ0GBH5GIGR78K40hnBfhWtLJLIJ01X5spt9f1myULKF7CK8v8NdTVegG+W
	NaEo07yu2b85Qr38uPsmBcXWz9r/MEMGX4my8IAUCsfHoq3+kPErAovLP9O55jlqUSlF
	hTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=xk0IR4py3Q73CS9m2OZw579cOOI17N0uvwH7IOVEyo4=;
	b=X6I3tV8r26Ww9GJ4tykNz5mMdHYQisM+Pw4Xk0Y0qoumuJ/ZoQ5AGJsC9wV242kBNY
	wREaXK7H5i1nEm/+mUP3N/FPJsJ0MTWV7BMMKIsW6xF7ieny9HLyZBRHzeHdC3yK3Opi
	qzHOsgedSd3r4TfoElvaonqFCtdfnKkICqtOdCh6G+Ulh3XvHfeXvGojsQAiXO9Tspz2
	YbAthnlUuCTOQmMfsHFqNPjaNIZShSQiXWT1VeHBgi+/7LJPGT3upGrbVB6rU2CZ2Jh6
	K6CSCRPV1yq/a3KZIf/uYf77G9d28Ppj7uYNYgcOSpe6XGEIxT88Ipbff0/xJGGwCmei
	6kYw==
X-Gm-Message-State: APjAAAVG6AcJ/F7FisBbwop4DK26shIk/40N/PcIQjjysOpLd4mZNugL
	fbSlP7qIcf7Jx2x1Jf17Yp/FPt6eAM2NiQ==
X-Google-Smtp-Source: APXvYqwJQkw6yHrvivw/oJ7wQOnJCiAQOeFWZDSrnCdqugJhbbeJd3t5uh1rz8T77LnUiMzWq92X/Q==
X-Received: by 2002:a17:902:7043:: with SMTP id
	h3mr26377107plt.228.1554664654658; 
	Sun, 07 Apr 2019 12:17:34 -0700 (PDT)
Received: from localhost.localdomain ([42.111.128.225])
	by smtp.gmail.com with ESMTPSA id
	m16sm66914461pfi.29.2019.04.07.12.17.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 07 Apr 2019 12:17:34 -0700 (PDT)
From: sohailalvi2236@gmail.com
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 00:47:28 +0530
Message-Id: <20190407191728.8552-1-sohailalvi2236@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62e
Subject: [Qemu-devel] [PATCH 1/5] Device Models
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sohail Alvi <sohailalvi2236@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190407191728.JR03nWpoQDbD3bZ3Sj88c3ttfpJetZXGq2wcKEISBRg@z>

From: Sohail Alvi <sohailalvi2236@gmail.com>

Signed-off-by: SohailAlvi <sohailalvi2236@gmail.com>
---
 hw/block/xen-block.c       | 4 +++-
 hw/dma/i82374.c            | 3 ++-
 hw/i386/amd_iommu.c        | 9 +++++++++
 hw/i386/intel_iommu.c      | 1 +
 hw/i386/pc_piix.c          | 1 +
 hw/i386/xen/xen_pvdevice.c | 1 +
 hw/ipmi/ipmi_bmc_extern.c  | 1 +
 hw/ipmi/ipmi_bmc_sim.c     | 1 +
 hw/ipmi/isa_ipmi_bt.c      | 1 +
 hw/ipmi/isa_ipmi_kcs.c     | 1 +
 hw/mem/nvdimm.c            | 1 +
 hw/mem/pc-dimm.c           | 1 +
 hw/tpm/tpm_tis.c           | 1 +
 13 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index ef635be4c2..c5a683f5c3 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -579,6 +579,7 @@ static void xen_disk_class_init(ObjectClass *class, void *data)
     DeviceClass *dev_class = DEVICE_CLASS(class);
     XenBlockDeviceClass *blockdev_class = XEN_BLOCK_DEVICE_CLASS(class);
 
+    set_bit(DEVICE_CATEGORY_STORAGE, dev_class->categories);
     blockdev_class->realize = xen_disk_realize;
     blockdev_class->unrealize = xen_disk_unrealize;
 
@@ -624,8 +625,9 @@ static void xen_cdrom_realize(XenBlockDevice *blockdev, Error **errp)
 static void xen_cdrom_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dev_class = DEVICE_CLASS(class);
-    XenBlockDeviceClass *blockdev_class = XEN_BLOCK_DEVICE_CLASS(class);
+    XenBlockDeviceClass *blockdev_class = XEN_BLOCK_DEVICE_CLASS(class);    
 
+    set_bit(DEVICE_CATEGORY_STORAGE, dev_class->categories);
     blockdev_class->realize = xen_cdrom_realize;
     blockdev_class->unrealize = xen_cdrom_unrealize;
 
diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index 892f655a7e..caf231422b 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -143,7 +143,8 @@ static Property i82374_properties[] = {
 static void i82374_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);    
     dc->realize = i82374_realize;
     dc->vmsd = &vmstate_i82374;
     dc->props = i82374_properties;
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6eabdf9917..d4ebd599b6 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1594,6 +1594,7 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     X86IOMMUClass *dc_class = X86_IOMMU_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->reset = amdvi_reset;
     dc->vmsd = &vmstate_amdvi;
     dc->hotpluggable = false;
@@ -1611,8 +1612,16 @@ static const TypeInfo amdvi = {
     .class_init = amdvi_class_init
 };
 
+static void amdvi_pci_class_init(ObjectClass *klass, void* data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+}
+
 static const TypeInfo amdviPCI = {
     .name = "AMDVI-PCI",
+    .class_init = amdvi_pci_class_init,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(AMDVIPCIState),
     .interfaces = (InterfaceInfo[]) {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 055a1e865d..89362be7fc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3719,6 +3719,7 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     X86IOMMUClass *x86_class = X86_IOMMU_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->reset = vtd_reset;
     dc->vmsd = &vtd_vmstate;
     dc->props = vtd_properties;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8ad8e885c6..2db7dee42d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -910,6 +910,7 @@ static void isa_bridge_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc        = "ISA bridge faked to support IGD PT";
     k->vendor_id    = PCI_VENDOR_ID_INTEL;
     k->class_id     = PCI_CLASS_BRIDGE_ISA;
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index a146f1883a..cb30835944 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -126,6 +126,7 @@ static void xen_pv_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     k->realize = xen_pv_realize;
     k->class_id = PCI_CLASS_SYSTEM_OTHER;
     dc->desc = "Xen PV Device";
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index bf0b7ee0f5..73604e2be6 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -521,6 +521,7 @@ static void ipmi_bmc_extern_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     IPMIBmcClass *bk = IPMI_BMC_CLASS(oc);
 
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     bk->handle_command = ipmi_bmc_extern_handle_command;
     bk->handle_reset = ipmi_bmc_extern_handle_reset;
     dc->hotpluggable = false;
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 9b509f829b..3166232fd4 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2012,6 +2012,7 @@ static void ipmi_sim_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     IPMIBmcClass *bk = IPMI_BMC_CLASS(oc);
 
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->hotpluggable = false;
     dc->realize = ipmi_sim_realize;
     dc->props = ipmi_sim_properties;
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 8bbb1fa785..3def8d3068 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -539,6 +539,7 @@ static void isa_ipmi_bt_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
 
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->realize = isa_ipmi_bt_realize;
     dc->props = ipmi_isa_properties;
 
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index a79431554a..a8f230224f 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -522,6 +522,7 @@ static void isa_ipmi_kcs_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
 
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->realize = ipmi_isa_realize;
     dc->props = ipmi_isa_properties;
 
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index bf2adf5e16..9fbbbe22e7 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -197,6 +197,7 @@ static void nvdimm_class_init(ObjectClass *oc, void *data)
     NVDIMMClass *nvc = NVDIMM_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);    
     ddc->realize = nvdimm_realize;
     mdc->get_memory_region = nvdimm_md_get_memory_region;
     dc->props = nvdimm_properties;
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 152400b1fc..d627f0c82f 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -255,6 +255,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
     PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
     MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
 
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->realize = pc_dimm_realize;
     dc->unrealize = pc_dimm_unrealize;
     dc->props = pc_dimm_properties;
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index fd183e8deb..a0a27f7ce1 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1016,6 +1016,7 @@ static void tpm_tis_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     TPMIfClass *tc = TPM_IF_CLASS(klass);
 
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->realize = tpm_tis_realizefn;
     dc->props = tpm_tis_properties;
     dc->reset = tpm_tis_reset;
-- 
2.17.1


