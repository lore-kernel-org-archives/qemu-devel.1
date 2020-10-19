Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EB6C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74BF21741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74BF21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpYH-0006rJ-QG
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQw-00062i-0e; Tue, 20 Oct 2020 07:04:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5263 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQt-0006nw-3r; Tue, 20 Oct 2020 07:04:01 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id DCB023420655B35F5E41;
 Tue, 20 Oct 2020 19:03:54 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 19:03:46 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 07/10] hw/pci-host/:split some lines containing more than 80
 characters
Date: Tue, 20 Oct 2020 04:30:20 +0800
Message-ID: <20201019203023.658555-8-ganqixin@huawei.com>
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

By using scripts/checkpatch.pl, it is found that many files in hw/pci-host/
contain lines with more than 80 characters.

Signed-off-by: Gan Qixin <ganqixin@huawei.com>
---
 hw/pci-host/gpex-acpi.c | 18 ++++++++----------
 hw/pci-host/pam.c       |  4 ++--
 hw/pci-host/ppce500.c   |  8 +++++---
 hw/pci-host/q35.c       | 11 +++++++----
 hw/pci-host/versatile.c |  5 +++--
 5 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index dbb350a837..a7cf59018d 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -64,12 +64,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                             nr_pcie_buses));
     if (cfg->mmio32.size) {
         aml_append(rbuf,
-                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                                    AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
-                                    cfg->mmio32.base,
+                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
+                                    AML_READ_WRITE, 0x0000, cfg->mmio32.base,
                                     cfg->mmio32.base + cfg->mmio32.size - 1,
-                                    0x0000,
-                                    cfg->mmio32.size));
+                                    0x0000, cfg->mmio32.size));
     }
     if (cfg->pio.size) {
         aml_append(rbuf,
@@ -81,12 +80,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     }
     if (cfg->mmio64.size) {
         aml_append(rbuf,
-                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                                    AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
-                                    cfg->mmio64.base,
+                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
+                                    AML_READ_WRITE, 0x0000, cfg->mmio64.base,
                                     cfg->mmio64.base + cfg->mmio64.size - 1,
-                                    0x0000,
-                                    cfg->mmio64.size));
+                                    0x0000, cfg->mmio64.size));
     }
     aml_append(dev, aml_name_decl("_CRS", rbuf));
 
diff --git a/hw/pci-host/pam.c b/hw/pci-host/pam.c
index a496205783..6253406abd 100644
--- a/hw/pci-host/pam.c
+++ b/hw/pci-host/pam.c
@@ -45,8 +45,8 @@ void init_pam(DeviceState *dev, MemoryRegion *ram_memory,
     memory_region_set_readonly(&mem->alias[1], true);
 
     /* XXX: should distinguish read/write cases */
-    memory_region_init_alias(&mem->alias[0], OBJECT(dev), "pam-pci", pci_address_space,
-                             start, size);
+    memory_region_init_alias(&mem->alias[0], OBJECT(dev), "pam-pci",
+                             pci_address_space, start, size);
     memory_region_init_alias(&mem->alias[2], OBJECT(dev), "pam-pci", ram_memory,
                              start, size);
 
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 9517aab913..d3e8e77236 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -423,8 +423,9 @@ static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
     PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
                                   "/e500-ccsr"));
 
-    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
-                             0, int128_get64(ccsr->ccsr_space.size));
+    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0",
+                             &ccsr->ccsr_space, 0,
+                             int128_get64(ccsr->ccsr_space.size));
     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);
 }
 
@@ -474,7 +475,8 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
 
     pci_create_simple(b, 0, "e500-host-bridge");
 
-    memory_region_init(&s->container, OBJECT(h), "pci-container", PCIE500_ALL_SIZE);
+    memory_region_init(&s->container, OBJECT(h), "pci-container",
+                       PCIE500_ALL_SIZE);
     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_be_ops, h,
                           "pci-conf-idx", 4);
     memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops, h,
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index b67cb9c29f..8c4031dda7 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -573,14 +573,17 @@ static void mch_realize(PCIDevice *d, Error **errp)
 
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
-                             mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+                             mch->pci_address_space,
+                             MCH_HOST_BRIDGE_SMRAM_C_BASE,
                              MCH_HOST_BRIDGE_SMRAM_C_SIZE);
-    memory_region_add_subregion_overlap(mch->system_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+    memory_region_add_subregion_overlap(mch->system_memory,
+                                        MCH_HOST_BRIDGE_SMRAM_C_BASE,
                                         &mch->smram_region, 1);
     memory_region_set_enabled(&mch->smram_region, true);
 
-    memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), "smram-open-high",
-                             mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+    memory_region_init_alias(&mch->open_high_smram, OBJECT(mch),
+                             "smram-open-high", mch->ram_memory,
+                             MCH_HOST_BRIDGE_SMRAM_C_BASE,
                              MCH_HOST_BRIDGE_SMRAM_C_SIZE);
     memory_region_add_subregion_overlap(mch->system_memory, 0xfeda0000,
                                         &mch->open_high_smram, 1);
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 3553277f94..1dab38e695 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -454,8 +454,9 @@ static void pci_vpb_realize(DeviceState *dev, Error **errp)
      * offsets are guest controllable via the IMAP registers.
      */
     for (i = 0; i < 3; i++) {
-        memory_region_init_alias(&s->pci_mem_window[i], OBJECT(s), "pci-vbp-window",
-                                 &s->pci_mem_space, 0, s->mem_win_size[i]);
+        memory_region_init_alias(&s->pci_mem_window[i], OBJECT(s),
+                                 "pci-vbp-window", &s->pci_mem_space, 0,
+                                 s->mem_win_size[i]);
         sysbus_init_mmio(sbd, &s->pci_mem_window[i]);
     }
 
-- 
2.23.0


