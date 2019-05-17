Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14B7C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6751820833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6751820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45439 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZVT-0003GC-P7
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:50:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZM6-0004M6-Nc
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZM0-00027e-G4
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:46 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:55362
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZM0-00021g-5p
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:40 -0400
Received: from host109-146-247-8.range109-146.btcentralplus.com
	([109.146.247.8] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLG-00018L-3a; Fri, 17 May 2019 10:39:56 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Fri, 17 May 2019 10:40:28 +0100
Message-Id: <20190517094029.7667-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
References: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 109.146.247.8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PULL 7/8] leon3: introduce the plug and play mechanism
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

This adds the AHB and APB plug and play devices.
They are scanned during the linux boot to discover the various peripheral.

Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 MAINTAINERS                         |   2 +-
 hw/misc/Makefile.objs               |   2 +
 hw/misc/grlib_ahb_apb_pnp.c         | 269 ++++++++++++++++++++++++++++++++++++
 hw/sparc/leon3.c                    |  30 ++++
 include/hw/misc/grlib_ahb_apb_pnp.h |  60 ++++++++
 5 files changed, 362 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/grlib_ahb_apb_pnp.c
 create mode 100644 include/hw/misc/grlib_ahb_apb_pnp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a73a61a546..bc54c6d212 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1161,7 +1161,7 @@ M: Fabien Chouteau <chouteau@adacore.com>
 S: Maintained
 F: hw/sparc/leon3.c
 F: hw/*/grlib*
-F: include/hw/sparc/grlib.h
+F: include/hw/*/grlib*
 
 S390 Machines
 -------------
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c71e07ae35..77b9df9796 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -77,3 +77,5 @@ obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
 obj-$(CONFIG_MSF2) += msf2-sysreg.o
 obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
+
+obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
new file mode 100644
index 0000000000..7338461694
--- /dev/null
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -0,0 +1,269 @@
+/*
+ * GRLIB AHB APB PNP
+ *
+ *  Copyright (C) 2019 AdaCore
+ *
+ *  Developed by :
+ *  Frederic Konrad   <frederic.konrad@adacore.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/misc/grlib_ahb_apb_pnp.h"
+
+#define GRLIB_PNP_VENDOR_SHIFT (24)
+#define GRLIB_PNP_VENDOR_SIZE   (8)
+#define GRLIB_PNP_DEV_SHIFT    (12)
+#define GRLIB_PNP_DEV_SIZE     (12)
+#define GRLIB_PNP_VER_SHIFT     (5)
+#define GRLIB_PNP_VER_SIZE      (5)
+#define GRLIB_PNP_IRQ_SHIFT     (0)
+#define GRLIB_PNP_IRQ_SIZE      (5)
+#define GRLIB_PNP_ADDR_SHIFT   (20)
+#define GRLIB_PNP_ADDR_SIZE    (12)
+#define GRLIB_PNP_MASK_SHIFT    (4)
+#define GRLIB_PNP_MASK_SIZE    (12)
+
+#define GRLIB_AHB_DEV_ADDR_SHIFT   (20)
+#define GRLIB_AHB_DEV_ADDR_SIZE    (12)
+#define GRLIB_AHB_ENTRY_SIZE       (0x20)
+#define GRLIB_AHB_MAX_DEV          (64)
+#define GRLIB_AHB_SLAVE_OFFSET     (0x800)
+
+#define GRLIB_APB_DEV_ADDR_SHIFT   (8)
+#define GRLIB_APB_DEV_ADDR_SIZE    (12)
+#define GRLIB_APB_ENTRY_SIZE       (0x08)
+#define GRLIB_APB_MAX_DEV          (512)
+
+#define GRLIB_PNP_MAX_REGS         (0x1000)
+
+typedef struct AHBPnp {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+
+    uint32_t regs[GRLIB_PNP_MAX_REGS >> 2];
+    uint8_t master_count;
+    uint8_t slave_count;
+} AHBPnp;
+
+void grlib_ahb_pnp_add_entry(AHBPnp *dev, uint32_t address, uint32_t mask,
+                             uint8_t vendor, uint16_t device, int slave,
+                             int type)
+{
+    unsigned int reg_start;
+
+    /*
+     * AHB entries look like this:
+     *
+     * 31 -------- 23 -------- 11 ----- 9 -------- 4 --- 0
+     *  | VENDOR ID | DEVICE ID | IRQ ? | VERSION  | IRQ |
+     *  --------------------------------------------------
+     *  |                      USER                      |
+     *  --------------------------------------------------
+     *  |                      USER                      |
+     *  --------------------------------------------------
+     *  |                      USER                      |
+     *  --------------------------------------------------
+     *  |                      USER                      |
+     *  --------------------------------------------------
+     * 31 ----------- 20 --- 15 ----------------- 3 ---- 0
+     *  | ADDR[31..12] | 00PC |        MASK       | TYPE |
+     *  --------------------------------------------------
+     * 31 ----------- 20 --- 15 ----------------- 3 ---- 0
+     *  | ADDR[31..12] | 00PC |        MASK       | TYPE |
+     *  --------------------------------------------------
+     * 31 ----------- 20 --- 15 ----------------- 3 ---- 0
+     *  | ADDR[31..12] | 00PC |        MASK       | TYPE |
+     *  --------------------------------------------------
+     * 31 ----------- 20 --- 15 ----------------- 3 ---- 0
+     *  | ADDR[31..12] | 00PC |        MASK       | TYPE |
+     *  --------------------------------------------------
+     */
+
+    if (slave) {
+        assert(dev->slave_count < GRLIB_AHB_MAX_DEV);
+        reg_start = (GRLIB_AHB_SLAVE_OFFSET
+                  + (dev->slave_count * GRLIB_AHB_ENTRY_SIZE)) >> 2;
+        dev->slave_count++;
+    } else {
+        assert(dev->master_count < GRLIB_AHB_MAX_DEV);
+        reg_start = (dev->master_count * GRLIB_AHB_ENTRY_SIZE) >> 2;
+        dev->master_count++;
+    }
+
+    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
+                                     GRLIB_PNP_VENDOR_SHIFT,
+                                     GRLIB_PNP_VENDOR_SIZE,
+                                     vendor);
+    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
+                                     GRLIB_PNP_DEV_SHIFT,
+                                     GRLIB_PNP_DEV_SIZE,
+                                     device);
+    reg_start += 4;
+    /* AHB Memory Space */
+    dev->regs[reg_start] = type;
+    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
+                                     GRLIB_PNP_ADDR_SHIFT,
+                                     GRLIB_PNP_ADDR_SIZE,
+                                     extract32(address,
+                                               GRLIB_AHB_DEV_ADDR_SHIFT,
+                                               GRLIB_AHB_DEV_ADDR_SIZE));
+    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
+                                     GRLIB_PNP_MASK_SHIFT,
+                                     GRLIB_PNP_MASK_SIZE,
+                                     mask);
+}
+
+static uint64_t grlib_ahb_pnp_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AHBPnp *ahb_pnp = GRLIB_AHB_PNP(opaque);
+
+    return ahb_pnp->regs[offset >> 2];
+}
+
+static const MemoryRegionOps grlib_ahb_pnp_ops = {
+    .read       = grlib_ahb_pnp_read,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void grlib_ahb_pnp_realize(DeviceState *dev, Error **errp)
+{
+    AHBPnp *ahb_pnp = GRLIB_AHB_PNP(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&ahb_pnp->iomem, OBJECT(dev), &grlib_ahb_pnp_ops,
+                          ahb_pnp, TYPE_GRLIB_AHB_PNP, GRLIB_PNP_MAX_REGS);
+    sysbus_init_mmio(sbd, &ahb_pnp->iomem);
+}
+
+static void grlib_ahb_pnp_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = grlib_ahb_pnp_realize;
+}
+
+static const TypeInfo grlib_ahb_pnp_info = {
+    .name          = TYPE_GRLIB_AHB_PNP,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AHBPnp),
+    .class_init    = grlib_ahb_pnp_class_init,
+};
+
+/* APBPnp */
+
+typedef struct APBPnp {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+
+    uint32_t regs[GRLIB_PNP_MAX_REGS >> 2];
+    uint32_t entry_count;
+} APBPnp;
+
+void grlib_apb_pnp_add_entry(APBPnp *dev, uint32_t address, uint32_t mask,
+                             uint8_t vendor, uint16_t device, uint8_t version,
+                             uint8_t irq, int type)
+{
+    unsigned int reg_start;
+
+    /*
+     * APB entries look like this:
+     *
+     * 31 -------- 23 -------- 11 ----- 9 ------- 4 --- 0
+     *  | VENDOR ID | DEVICE ID | IRQ ? | VERSION | IRQ |
+     *
+     * 31 ---------- 20 --- 15 ----------------- 3 ---- 0
+     *  | ADDR[20..8] | 0000 |        MASK       | TYPE |
+     */
+
+    assert(dev->entry_count < GRLIB_APB_MAX_DEV);
+    reg_start = (dev->entry_count * GRLIB_APB_ENTRY_SIZE) >> 2;
+    dev->entry_count++;
+
+    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
+                                     GRLIB_PNP_VENDOR_SHIFT,
+                                     GRLIB_PNP_VENDOR_SIZE,
+                                     vendor);
+    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
+                                     GRLIB_PNP_DEV_SHIFT,
+                                     GRLIB_PNP_DEV_SIZE,
+                                     device);
+    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
+                                     GRLIB_PNP_VER_SHIFT,
+                                     GRLIB_PNP_VER_SIZE,
+                                     version);
+    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
+                                     GRLIB_PNP_IRQ_SHIFT,
+                                     GRLIB_PNP_IRQ_SIZE,
+                                     irq);
+    reg_start += 1;
+    dev->regs[reg_start] = type;
+    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
+                                     GRLIB_PNP_ADDR_SHIFT,
+                                     GRLIB_PNP_ADDR_SIZE,
+                                     extract32(address,
+                                               GRLIB_APB_DEV_ADDR_SHIFT,
+                                               GRLIB_APB_DEV_ADDR_SIZE));
+    dev->regs[reg_start] = deposit32(dev->regs[reg_start],
+                                     GRLIB_PNP_MASK_SHIFT,
+                                     GRLIB_PNP_MASK_SIZE,
+                                     mask);
+}
+
+static uint64_t grlib_apb_pnp_read(void *opaque, hwaddr offset, unsigned size)
+{
+    APBPnp *apb_pnp = GRLIB_APB_PNP(opaque);
+
+    return apb_pnp->regs[offset >> 2];
+}
+
+static const MemoryRegionOps grlib_apb_pnp_ops = {
+    .read       = grlib_apb_pnp_read,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void grlib_apb_pnp_realize(DeviceState *dev, Error **errp)
+{
+    APBPnp *apb_pnp = GRLIB_APB_PNP(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&apb_pnp->iomem, OBJECT(dev), &grlib_apb_pnp_ops,
+                          apb_pnp, TYPE_GRLIB_APB_PNP, GRLIB_PNP_MAX_REGS);
+    sysbus_init_mmio(sbd, &apb_pnp->iomem);
+}
+
+static void grlib_apb_pnp_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = grlib_apb_pnp_realize;
+}
+
+static const TypeInfo grlib_apb_pnp_info = {
+    .name          = TYPE_GRLIB_APB_PNP,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(APBPnp),
+    .class_init    = grlib_apb_pnp_class_init,
+};
+
+static void grlib_ahb_apb_pnp_register_types(void)
+{
+    type_register_static(&grlib_ahb_pnp_info);
+    type_register_static(&grlib_apb_pnp_info);
+}
+
+type_init(grlib_ahb_apb_pnp_register_types)
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 6ba63e68ca..bdead85a93 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -39,6 +39,7 @@
 #include "exec/address-spaces.h"
 
 #include "hw/sparc/grlib.h"
+#include "hw/misc/grlib_ahb_apb_pnp.h"
 
 /* Default system clock.  */
 #define CPU_CLK (40 * 1000 * 1000)
@@ -58,6 +59,9 @@
 #define LEON3_TIMER_IRQ    (6)
 #define LEON3_TIMER_COUNT  (2)
 
+#define LEON3_APB_PNP_OFFSET (0x800FF000)
+#define LEON3_AHB_PNP_OFFSET (0xFFFFF000)
+
 typedef struct ResetData {
     SPARCCPU *cpu;
     uint32_t  entry;            /* save kernel entry in case of reset */
@@ -187,6 +191,8 @@ static void leon3_generic_hw_init(MachineState *machine)
     ResetData  *reset_info;
     DeviceState *dev;
     int i;
+    AHBPnp *ahb_pnp;
+    APBPnp *apb_pnp;
 
     /* Init CPU */
     cpu = SPARC_CPU(cpu_create(machine->cpu_type));
@@ -200,6 +206,20 @@ static void leon3_generic_hw_init(MachineState *machine)
     reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
     qemu_register_reset(main_cpu_reset, reset_info);
 
+    ahb_pnp = GRLIB_AHB_PNP(object_new(TYPE_GRLIB_AHB_PNP));
+    object_property_set_bool(OBJECT(ahb_pnp), true, "realized", &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(ahb_pnp), 0, LEON3_AHB_PNP_OFFSET);
+    grlib_ahb_pnp_add_entry(ahb_pnp, 0, 0, GRLIB_VENDOR_GAISLER,
+                            GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
+                            GRLIB_CPU_AREA);
+
+    apb_pnp = GRLIB_APB_PNP(object_new(TYPE_GRLIB_APB_PNP));
+    object_property_set_bool(OBJECT(apb_pnp), true, "realized", &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
+    grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
+                            GRLIB_VENDOR_GAISLER, GRLIB_APBMST_DEV,
+                            GRLIB_AHB_SLAVE, GRLIB_AHBMEM_AREA);
+
     /* Allocate IRQ manager */
     dev = qdev_create(NULL, TYPE_GRLIB_IRQMP);
     qdev_prop_set_ptr(dev, "set_pil_in", leon3_set_pil_in);
@@ -209,6 +229,9 @@ static void leon3_generic_hw_init(MachineState *machine)
     env->irq_manager = dev;
     env->qemu_irq_ack = leon3_irq_manager;
     cpu_irqs = qemu_allocate_irqs(grlib_irqmp_set_irq, dev, MAX_PILS);
+    grlib_apb_pnp_add_entry(apb_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
+                            GRLIB_VENDOR_GAISLER, GRLIB_IRQMP_DEV,
+                            2, 0, GRLIB_APBIO_AREA);
 
     /* Allocate RAM */
     if (ram_size > 1 * GiB) {
@@ -303,6 +326,10 @@ static void leon3_generic_hw_init(MachineState *machine)
                            cpu_irqs[LEON3_TIMER_IRQ + i]);
     }
 
+    grlib_apb_pnp_add_entry(apb_pnp, LEON3_TIMER_OFFSET, 0xFFF,
+                            GRLIB_VENDOR_GAISLER, GRLIB_GPTIMER_DEV,
+                            0, LEON3_TIMER_IRQ, GRLIB_APBIO_AREA);
+
     /* Allocate uart */
     if (serial_hd(0)) {
         dev = qdev_create(NULL, TYPE_GRLIB_APB_UART);
@@ -310,6 +337,9 @@ static void leon3_generic_hw_init(MachineState *machine)
         qdev_init_nofail(dev);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irqs[LEON3_UART_IRQ]);
+        grlib_apb_pnp_add_entry(apb_pnp, LEON3_UART_OFFSET, 0xFFF,
+                                GRLIB_VENDOR_GAISLER, GRLIB_APBUART_DEV, 1,
+                                LEON3_UART_IRQ, GRLIB_APBIO_AREA);
     }
 }
 
diff --git a/include/hw/misc/grlib_ahb_apb_pnp.h b/include/hw/misc/grlib_ahb_apb_pnp.h
new file mode 100644
index 0000000000..a0f6dcfda7
--- /dev/null
+++ b/include/hw/misc/grlib_ahb_apb_pnp.h
@@ -0,0 +1,60 @@
+/*
+ * GRLIB AHB APB PNP
+ *
+ *  Copyright (C) 2019 AdaCore
+ *
+ *  Developed by :
+ *  Frederic Konrad   <frederic.konrad@adacore.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef GRLIB_AHB_APB_PNP_H
+#define GRLIB_AHB_APB_PNP_H
+
+#define TYPE_GRLIB_AHB_PNP "grlib,ahbpnp"
+#define GRLIB_AHB_PNP(obj) \
+    OBJECT_CHECK(AHBPnp, (obj), TYPE_GRLIB_AHB_PNP)
+typedef struct AHBPnp AHBPnp;
+
+#define TYPE_GRLIB_APB_PNP "grlib,apbpnp"
+#define GRLIB_APB_PNP(obj) \
+    OBJECT_CHECK(APBPnp, (obj), TYPE_GRLIB_APB_PNP)
+typedef struct APBPnp APBPnp;
+
+void grlib_ahb_pnp_add_entry(AHBPnp *dev, uint32_t address, uint32_t mask,
+                             uint8_t vendor, uint16_t device, int slave,
+                             int type);
+void grlib_apb_pnp_add_entry(APBPnp *dev, uint32_t address, uint32_t mask,
+                             uint8_t vendor, uint16_t device, uint8_t version,
+                             uint8_t irq, int type);
+
+/* VENDORS */
+#define GRLIB_VENDOR_GAISLER (0x01)
+/* DEVICES */
+#define GRLIB_LEON3_DEV      (0x03)
+#define GRLIB_APBMST_DEV     (0x06)
+#define GRLIB_APBUART_DEV    (0x0C)
+#define GRLIB_IRQMP_DEV      (0x0D)
+#define GRLIB_GPTIMER_DEV    (0x11)
+/* TYPE */
+#define GRLIB_CPU_AREA       (0x00)
+#define GRLIB_APBIO_AREA     (0x01)
+#define GRLIB_AHBMEM_AREA    (0x02)
+
+#define GRLIB_AHB_MASTER     (0x00)
+#define GRLIB_AHB_SLAVE      (0x01)
+
+#endif /* GRLIB_AHB_APB_PNP_H */
-- 
2.11.0


