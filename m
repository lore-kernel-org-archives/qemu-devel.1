Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01895C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4BA21D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4BA21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpSX-0007rt-DT
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQx-000668-6b; Tue, 20 Oct 2020 07:04:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5265 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQt-0006nu-4n; Tue, 20 Oct 2020 07:04:02 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D58B2D8D242855D31F2D;
 Tue, 20 Oct 2020 19:03:54 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 19:03:44 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 06/10] hw/pci/:split some lines containing more than 80
 characters
Date: Tue, 20 Oct 2020 04:30:19 +0800
Message-ID: <20201019203023.658555-7-ganqixin@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201019203023.658555-1-ganqixin@huawei.com>
References: <20201019203023.658555-1-ganqixin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=ganqixin@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:03:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, f4bug@amsat.org,
 alistair.francis@wdc.com, Gan Qixin <ganqixin@huawei.com>,
 kuhn.chenqun@huawei.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using scripts/checkpatch.pl, it is found that many files in hw/pci/
contain lines with more than 80 characters.

Signed-off-by: Gan Qixin <ganqixin@huawei.com>
---
 hw/pci/msi.c        |  3 ++-
 hw/pci/msix.c       |  8 ++++----
 hw/pci/pci.c        | 31 ++++++++++++++++++++-----------
 hw/pci/pci_bridge.c |  3 ++-
 hw/pci/pcie.c       | 11 ++++++-----
 hw/pci/pcie_host.c  |  4 ++--
 6 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index 47d2b0f33c..7adea829cb 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -47,7 +47,8 @@
  * supporting such, so removing the capability is not required, and
  * it seems cleaner to have a given device look the same for all boards.
  *
- * TODO: some existing controllers violate the above rule. Identify and fix them.
+ * TODO: some existing controllers violate the above rule. Identify and fix
+ * them.
  */
 bool msi_nonbroken;
 
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 67e34f34d6..7498af09c2 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -334,11 +334,11 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
 
     msix_mask_all(dev, nentries);
 
-    memory_region_init_io(&dev->msix_table_mmio, OBJECT(dev), &msix_table_mmio_ops, dev,
-                          "msix-table", table_size);
+    memory_region_init_io(&dev->msix_table_mmio, OBJECT(dev),
+                          &msix_table_mmio_ops, dev, "msix-table", table_size);
     memory_region_add_subregion(table_bar, table_offset, &dev->msix_table_mmio);
-    memory_region_init_io(&dev->msix_pba_mmio, OBJECT(dev), &msix_pba_mmio_ops, dev,
-                          "msix-pba", pba_size);
+    memory_region_init_io(&dev->msix_pba_mmio, OBJECT(dev),
+                          &msix_pba_mmio_ops, dev, "msix-pba", pba_size);
     memory_region_add_subregion(pba_bar, pba_offset, &dev->msix_pba_mmio);
 
     return 0;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 100c9381c2..96d1b88d79 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1391,7 +1391,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
     return le32_to_cpu(val);
 }
 
-void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int l)
+void pci_default_write_config(PCIDevice *d, uint32_t addr,
+                              uint32_t val_in, int l)
 {
     int i, was_irq_disabled = pci_irq_disabled(d);
     uint32_t val = val_in;
@@ -1691,9 +1692,11 @@ static PciMemoryRegionList *qmp_query_pci_regions(const PCIDevice *dev)
         } else {
             region->value->type = g_strdup("memory");
             region->value->has_prefetch = true;
-            region->value->prefetch = !!(r->type & PCI_BASE_ADDRESS_MEM_PREFETCH);
+            region->value->prefetch = !!(r->type &
+                                         PCI_BASE_ADDRESS_MEM_PREFETCH);
             region->value->has_mem_type_64 = true;
-            region->value->mem_type_64 = !!(r->type & PCI_BASE_ADDRESS_MEM_TYPE_64);
+            region->value->mem_type_64 = !!(r->type &
+                                            PCI_BASE_ADDRESS_MEM_TYPE_64);
         }
 
         region->value->bar = i;
@@ -1738,10 +1741,13 @@ static PciBridgeInfo *qmp_query_pci_bridge(PCIDevice *dev, PCIBus *bus,
     range->limit = pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
 
     if (dev->config[PCI_SECONDARY_BUS] != 0) {
-        PCIBus *child_bus = pci_find_bus_nr(bus, dev->config[PCI_SECONDARY_BUS]);
+        PCIBus *child_bus =
+                   pci_find_bus_nr(bus, dev->config[PCI_SECONDARY_BUS]);
         if (child_bus) {
             info->has_devices = true;
-            info->devices = qmp_query_pci_devices(child_bus, dev->config[PCI_SECONDARY_BUS]);
+            info->devices =
+                qmp_query_pci_devices(child_bus,
+                                      dev->config[PCI_SECONDARY_BUS]);
         }
     }
 
@@ -1986,9 +1992,9 @@ PCIDevice *pci_vga_init(PCIBus *bus)
 static bool pci_secondary_bus_in_range(PCIDevice *dev, int bus_num)
 {
     return !(pci_get_word(dev->config + PCI_BRIDGE_CONTROL) &
-             PCI_BRIDGE_CTL_BUS_RESET) /* Don't walk the bus if it's reset. */ &&
-        dev->config[PCI_SECONDARY_BUS] <= bus_num &&
-        bus_num <= dev->config[PCI_SUBORDINATE_BUS];
+             PCI_BRIDGE_CTL_BUS_RESET) /* Don't walk the bus if it's reset. */
+             && dev->config[PCI_SECONDARY_BUS] <= bus_num
+             && bus_num <= dev->config[PCI_SUBORDINATE_BUS];
 }
 
 /* Whether a given bus number is in a range of a root bus */
@@ -2050,7 +2056,8 @@ static PCIBus *pci_find_bus_nr(PCIBus *bus, int bus_num)
 }
 
 void pci_for_each_bus_depth_first(PCIBus *bus,
-                                  void *(*begin)(PCIBus *bus, void *parent_state),
+                                  void *(*begin)(PCIBus *bus,
+                                  void *parent_state),
                                   void (*end)(PCIBus *bus, void *state),
                                   void *parent_state)
 {
@@ -2363,7 +2370,8 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
     if (vmsd) {
         snprintf(name, sizeof(name), "%s.rom", vmsd->name);
     } else {
-        snprintf(name, sizeof(name), "%s.rom", object_get_typename(OBJECT(pdev)));
+        snprintf(name, sizeof(name), "%s.rom",
+                 object_get_typename(OBJECT(pdev)));
     }
     pdev->has_rom = true;
     memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
@@ -2729,7 +2737,8 @@ static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
 
     if (pc->is_bridge) {
         pcibus_t base = pci_bridge_get_base(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
-        pcibus_t limit = pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
+        pcibus_t limit = pci_bridge_get_limit(dev,
+                                              PCI_BASE_ADDRESS_MEM_PREFETCH);
 
         base = MAX(base, 0x1ULL << 32);
 
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 3789c17edc..4124f3c156 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -379,7 +379,8 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     sec_bus->parent_dev = dev;
     sec_bus->map_irq = br->map_irq ? br->map_irq : pci_swizzle_map_irq_fn;
     sec_bus->address_space_mem = &br->address_space_mem;
-    memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
+    memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci",
+                       UINT64_MAX);
     sec_bus->address_space_io = &br->address_space_io;
     memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
                        4 * GiB);
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 5b48bae0f6..344d013c95 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -644,10 +644,10 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
     if (ranges_overlap(addr, len, pos + PCI_EXP_SLTSTA, 2)) {
         /*
          * Guests tend to clears all bits during init.
-         * If they clear bits that weren't set this is racy and will lose events:
-         * not a big problem for manual button presses, but a problem for us.
-         * As a work-around, detect this and revert status to what it was
-         * before the write.
+         * If they clear bits that weren't set this is racy and will lose
+         * events: not a big problem for manual button presses, but a problem
+         * for us. As a work-around, detect this and revert status to what it
+         * was before the write.
          *
          * Note: in theory this can be detected as a duplicate button press
          * which cancels the previous press. Does not seem to happen in
@@ -658,7 +658,8 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
                           PCI_EXP_SLTSTA_CC)
 
         if (val & ~old_slt_sta & PCIE_SLOT_EVENTS) {
-            sltsta = (sltsta & ~PCIE_SLOT_EVENTS) | (old_slt_sta & PCIE_SLOT_EVENTS);
+            sltsta = (sltsta & ~PCIE_SLOT_EVENTS) |
+                     (old_slt_sta & PCIE_SLOT_EVENTS);
             pci_set_word(exp_cap + PCI_EXP_SLTSTA, sltsta);
         }
         hotplug_event_clear(dev);
diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index 3534006f99..9a3f09fb25 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -79,8 +79,8 @@ static void pcie_host_init(Object *obj)
     PCIExpressHost *e = PCIE_HOST_BRIDGE(obj);
 
     e->base_addr = PCIE_BASE_ADDR_UNMAPPED;
-    memory_region_init_io(&e->mmio, OBJECT(e), &pcie_mmcfg_ops, e, "pcie-mmcfg-mmio",
-                          PCIE_MMCFG_SIZE_MAX);
+    memory_region_init_io(&e->mmio, OBJECT(e), &pcie_mmcfg_ops, e,
+                          "pcie-mmcfg-mmio", PCIE_MMCFG_SIZE_MAX);
 }
 
 void pcie_host_mmcfg_unmap(PCIExpressHost *e)
-- 
2.23.0


