Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B324C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 08:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2399420809
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 08:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2399420809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJuda-00089n-3N
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 04:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kJuab-0003Xp-Pm; Sun, 20 Sep 2020 04:20:54 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56554
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kJuaa-0003uo-24; Sun, 20 Sep 2020 04:20:53 -0400
Received: from host81-154-161-117.range81-154.btcentralplus.com
 ([81.154.161.117] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kJub7-0006Dn-8l; Sun, 20 Sep 2020 09:21:28 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: armbru@redhat.com, david@gibson.dropbear.id.au, atar4qemu@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Sun, 20 Sep 2020 09:20:16 +0100
Message-Id: <20200920082018.16135-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.154.161.117
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 4/6] sparc32-ledma: don't reference nd_table directly within
 the device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead use qdev_set_nic_properties() to configure the on-board NIC at the
sun4m machine level.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/dma/sparc32_dma.c |  5 -----
 hw/sparc/sun4m.c     | 21 +++++++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 2cbe331959..b643b413c5 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -342,12 +342,7 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
 {
     LEDMADeviceState *s = SPARC32_LEDMA_DEVICE(dev);
     SysBusPCNetState *lance = SYSBUS_PCNET(&s->lance);
-    NICInfo *nd = &nd_table[0];
 
-    /* FIXME use qdev NIC properties instead of nd_table[] */
-    qemu_check_nic_model(nd, TYPE_LANCE);
-
-    qdev_set_nic_properties(DEVICE(lance), nd);
     object_property_set_link(OBJECT(lance), "dma", OBJECT(dev), &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(lance), &error_fatal);
 }
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 947b69d159..ed5f3ccd9f 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -319,7 +319,7 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
 
 static void *sparc32_dma_init(hwaddr dma_base,
                               hwaddr esp_base, qemu_irq espdma_irq,
-                              hwaddr le_base, qemu_irq ledma_irq)
+                              hwaddr le_base, qemu_irq ledma_irq, NICInfo *nd)
 {
     DeviceState *dma;
     ESPDMADeviceState *espdma;
@@ -328,16 +328,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
     SysBusPCNetState *lance;
 
     dma = qdev_new(TYPE_SPARC32_DMA);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
-
     espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
                                    OBJECT(dma), "espdma"));
     sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
 
     esp = ESP(object_resolve_path_component(OBJECT(espdma), "esp"));
-    sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
-    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
 
     ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
                                  OBJECT(dma), "ledma"));
@@ -345,6 +340,14 @@ static void *sparc32_dma_init(hwaddr dma_base,
 
     lance = SYSBUS_PCNET(object_resolve_path_component(
                          OBJECT(ledma), "lance"));
+    qdev_set_nic_properties(DEVICE(lance), nd);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
+    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
+
     sysbus_mmio_map(SYS_BUS_DEVICE(lance), 0, le_base);
 
     return dma;
@@ -854,6 +857,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     unsigned int max_cpus = machine->smp.max_cpus;
     Object *ram_memdev = object_resolve_path_type(machine->ram_memdev_id,
                                                   TYPE_MEMORY_BACKEND, NULL);
+    NICInfo *nd = &nd_table[0];
 
     if (machine->ram_size > hwdef->max_mem) {
         error_report("Too much memory for this machine: %" PRId64 ","
@@ -914,9 +918,10 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
                         hwdef->iommu_pad_base, hwdef->iommu_pad_len);
     }
 
+    qemu_check_nic_model(nd, TYPE_LANCE);
     sparc32_dma_init(hwdef->dma_base,
                      hwdef->esp_base, slavio_irq[18],
-                     hwdef->le_base, slavio_irq[16]);
+                     hwdef->le_base, slavio_irq[16], nd);
 
     if (graphic_depth != 8 && graphic_depth != 24) {
         error_report("Unsupported depth: %d", graphic_depth);
@@ -1047,7 +1052,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
                                     machine->initrd_filename,
                                     machine->ram_size, &initrd_size);
 
-    nvram_init(nvram, (uint8_t *)&nd_table[0].macaddr, machine->kernel_cmdline,
+    nvram_init(nvram, (uint8_t *)&nd->macaddr, machine->kernel_cmdline,
                machine->boot_order, machine->ram_size, kernel_size,
                graphic_width, graphic_height, graphic_depth,
                hwdef->nvram_machine_id, "Sun4m");
-- 
2.20.1


