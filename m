Received: from eggs.gnu.org ([209.51.188.92]:48389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDCsa-00034c-AW
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 14:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sohailalvi2236@gmail.com>) id 1hDCsX-0004BV-0U
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 14:50:54 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sohailalvi2236@gmail.com>)
	id 1hDCsW-0004A9-JR
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 14:50:52 -0400
Received: by mail-pf1-x442.google.com with SMTP id i17so3147194pfo.6
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 11:50:49 -0700 (PDT)
From: sohailalvi2236@gmail.com
Date: Mon,  8 Apr 2019 00:20:42 +0530
Message-Id: <20190407185042.7624-1-sohailalvi2236@gmail.com>
Subject: [Qemu-devel] [PATCH] set_bit() function added to the source code of
 uncategorized devices and categorizes have been assigne to them.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, Sohail Alvi <sohailalvi2236@gmail.com>

From: Sohail Alvi <sohailalvi2236@gmail.com>

a seperate class_init function has also been added for AMDVI-PCI.

Signed-off-by:SohailAlvi <sohailalvi2236@gmail.com>
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
