Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5C1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084AE20867
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084AE20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJ2C-0007vd-VB
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kaJ0k-0006xF-IB; Wed, 04 Nov 2020 08:39:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kaJ0c-0002iN-GF; Wed, 04 Nov 2020 08:39:35 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CR76H58CBzhg5H;
 Wed,  4 Nov 2020 21:39:03 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 4 Nov 2020
 21:38:59 +0800
From: Xinhao Zhang <zhangxinhao1@huawei.com>
To: <qemu-devel@nongnu.org>, <xen-devel@lists.xenproject.org>
Subject: [PATCH] hw/xen: Don't use '#' flag of printf format
Date: Wed, 4 Nov 2020 21:37:09 +0800
Message-ID: <20201104133709.3326630-1-zhangxinhao1@huawei.com>
X-Mailer: git-send-email 2.29.0-rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhangxinhao1@huawei.com; helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 08:39:07
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: sstabellini@kernel.org, paul@xen.org, qemu-trivial@nongnu.org,
 alex.chen@huawei.com, anthony.perard@citrix.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix code style. Don't use '#' flag of printf format ('%#') in
format strings, use '0x' prefix instead

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
---
 hw/xen/xen_pt.c             | 10 +++++-----
 hw/xen/xen_pt_config_init.c |  6 +++---
 hw/xen/xen_pt_msi.c         | 16 ++++++++--------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 6d359ee486..a5f3dd590c 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -489,7 +489,7 @@ static int xen_pt_register_regions(XenPCIPassthroughState *s, uint16_t *cmd)
         pci_register_bar(&s->dev, i, type, &s->bar[i]);
 
         XEN_PT_LOG(&s->dev, "IO region %i registered (size=0x%08"PRIx64
-                   " base_addr=0x%08"PRIx64" type: %#x)\n",
+                   " base_addr=0x%08"PRIx64" type: 0x%x)\n",
                    i, r->size, r->base_addr, type);
     }
 
@@ -578,7 +578,7 @@ static void xen_pt_check_bar_overlap(PCIBus *bus, PCIDevice *d, void *opaque)
         if (ranges_overlap(arg->addr, arg->size, r->addr, r->size)) {
             XEN_PT_WARN(&s->dev,
                         "Overlapped to device [%02x:%02x.%d] Region: %i"
-                        " (addr: %#"FMT_PCIBUS", len: %#"FMT_PCIBUS")\n",
+                        " (addr: 0x%"FMT_PCIBUS", len: 0x%"FMT_PCIBUS")\n",
                         pci_bus_num(bus), PCI_SLOT(d->devfn),
                         PCI_FUNC(d->devfn), i, r->addr, r->size);
             arg->rc = true;
@@ -618,8 +618,8 @@ static void xen_pt_region_update(XenPCIPassthroughState *s,
     pci_for_each_device(pci_get_bus(d), pci_dev_bus_num(d),
                         xen_pt_check_bar_overlap, &args);
     if (args.rc) {
-        XEN_PT_WARN(d, "Region: %d (addr: %#"FMT_PCIBUS
-                    ", len: %#"FMT_PCIBUS") is overlapped.\n",
+        XEN_PT_WARN(d, "Region: %d (addr: 0x%"FMT_PCIBUS
+                    ", len: 0x%"FMT_PCIBUS") is overlapped.\n",
                     bar, sec->offset_within_address_space,
                     int128_get64(sec->size));
     }
@@ -786,7 +786,7 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
 
     /* register real device */
     XEN_PT_LOG(d, "Assigning real physical device %02x:%02x.%d"
-               " to devfn %#x\n",
+               " to devfn 0x%x\n",
                s->hostaddr.bus, s->hostaddr.slot, s->hostaddr.function,
                s->dev.devfn);
 
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index c8724cc7c8..c5c4e943a8 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -1622,7 +1622,7 @@ static int xen_pt_pcie_size_init(XenPCIPassthroughState *s,
         case PCI_EXP_TYPE_PCIE_BRIDGE:
         case PCI_EXP_TYPE_RC_EC:
         default:
-            XEN_PT_ERR(d, "Unsupported device/port type %#x.\n", type);
+            XEN_PT_ERR(d, "Unsupported device/port type 0x%x.\n", type);
             return -1;
         }
     }
@@ -1645,11 +1645,11 @@ static int xen_pt_pcie_size_init(XenPCIPassthroughState *s,
         case PCI_EXP_TYPE_PCIE_BRIDGE:
         case PCI_EXP_TYPE_RC_EC:
         default:
-            XEN_PT_ERR(d, "Unsupported device/port type %#x.\n", type);
+            XEN_PT_ERR(d, "Unsupported device/port type 0x%x.\n", type);
             return -1;
         }
     } else {
-        XEN_PT_ERR(d, "Unsupported capability version %#x.\n", version);
+        XEN_PT_ERR(d, "Unsupported capability version 0x%x.\n", version);
         return -1;
     }
 
diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index fb4b887b92..b71563f98a 100644
--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -123,7 +123,7 @@ static int msi_msix_setup(XenPCIPassthroughState *s,
             *ppirq = XEN_PT_UNASSIGNED_PIRQ;
         } else {
             XEN_PT_LOG(&s->dev, "requested pirq %d for MSI%s"
-                       " (vec: %#x, entry: %#x)\n",
+                       " (vec: 0x%x, entry: 0x%x)\n",
                        *ppirq, is_msix ? "-X" : "", gvec, msix_entry);
         }
     }
@@ -142,7 +142,7 @@ static int msi_msix_setup(XenPCIPassthroughState *s,
                                      msix_entry, table_base);
         if (rc) {
             XEN_PT_ERR(&s->dev,
-                       "Mapping of MSI%s (err: %i, vec: %#x, entry %#x)\n",
+                       "Mapping of MSI%s (err: %i, vec: 0x%x, entry 0x%x)\n",
                        is_msix ? "-X" : "", errno, gvec, msix_entry);
             return rc;
         }
@@ -165,8 +165,8 @@ static int msi_msix_update(XenPCIPassthroughState *s,
     int rc = 0;
     uint64_t table_addr = 0;
 
-    XEN_PT_LOG(d, "Updating MSI%s with pirq %d gvec %#x gflags %#x"
-               " (entry: %#x)\n",
+    XEN_PT_LOG(d, "Updating MSI%s with pirq %d gvec 0x%x gflags 0x%x"
+               " (entry: 0x%x)\n",
                is_msix ? "-X" : "", pirq, gvec, gflags, msix_entry);
 
     if (is_msix) {
@@ -208,11 +208,11 @@ static int msi_msix_disable(XenPCIPassthroughState *s,
     }
 
     if (is_binded) {
-        XEN_PT_LOG(d, "Unbind MSI%s with pirq %d, gvec %#x\n",
+        XEN_PT_LOG(d, "Unbind MSI%s with pirq %d, gvec 0x%x\n",
                    is_msix ? "-X" : "", pirq, gvec);
         rc = xc_domain_unbind_msi_irq(xen_xc, xen_domid, gvec, pirq, gflags);
         if (rc) {
-            XEN_PT_ERR(d, "Unbinding of MSI%s failed. (err: %d, pirq: %d, gvec: %#x)\n",
+            XEN_PT_ERR(d, "Unbinding of MSI%s failed. (err: %d, pirq: %d, gvec: 0x%x)\n",
                        is_msix ? "-X" : "", errno, pirq, gvec);
             return rc;
         }
@@ -539,7 +539,7 @@ int xen_pt_msix_init(XenPCIPassthroughState *s, uint32_t base)
     }
 
     if (id != PCI_CAP_ID_MSIX) {
-        XEN_PT_ERR(d, "Invalid id %#x base %#x\n", id, base);
+        XEN_PT_ERR(d, "Invalid id 0x%x base 0x%x\n", id, base);
         return -1;
     }
 
@@ -582,7 +582,7 @@ int xen_pt_msix_init(XenPCIPassthroughState *s, uint32_t base)
         XEN_PT_ERR(d, "Can't open /dev/mem: %s\n", strerror(errno));
         goto error_out;
     }
-    XEN_PT_LOG(d, "table_off = %#x, total_entries = %d\n",
+    XEN_PT_LOG(d, "table_off = 0x%x, total_entries = %d\n",
                table_off, total_entries);
     msix->table_offset_adjust = table_off & 0x0fff;
     msix->phys_iomem_base =
-- 
2.29.0-rc1


