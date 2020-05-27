Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179D2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B6720C09
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oHmnQpcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B6720C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdzPv-000472-6m
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 13:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOS-0001gD-23; Wed, 27 May 2020 12:59:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOQ-0002HI-DR; Wed, 27 May 2020 12:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590598742; x=1622134742;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K4XlrLlAS/GbGHM9Mx0P5M/b+/b3IuzGOYQ8eXtwnDU=;
 b=oHmnQpcQBV/DQtwo69Qg34r9QQxSucg/8Yme8dW/DjisUoa8EpM95H7a
 03OIyXj49yocoA8J3Dp+MYu99szkzckwrtTI2nI897qZjSWKT9JDZsN3A
 tN8Fxlh3eqTatfd/UIpgVGlTXfGGPmfOqIlSzcfPpq+HLz3RP8V/NBG8g
 GlKKlyJX+0kjdcEGOQThWvwtM244xaQwjoZntOL9QFra0H3a0GPEG+0de
 4eabqWxuiTv9ZMYirma6NW7m0vzyVvi3iab90eYDM2tprEMRSKUU7HHJu
 FbpN5oRn6aX9CkcPdtp3AVstML1jSIgVKuFAZdRq4HuZ1O57DHNZLJJH0 w==;
IronPort-SDR: 136ex7hxnq2CM9HF6e1NVlQnbFdxTkXPCp47R+ceNSZtuU7pGu7bQUOZ1qRK93R4hVN8f09l4v
 IYxvVhING4zX2sF0KkK1th5tTAQjGrePMWKPuZw4HiVaNk8zaQFb1N/ai3dF2WRxpB9YkRK4zm
 AoJXPdu82BjI1xPZucfMTwZ2IVL4NnzYDM1lmROFu1axsr8obuzbQN89graQSWsGt4SgqIXUmk
 17U++lx5hukKC2qzzQtw4W0/Z9Kphr7X0fSZAzzo+LYBiO1pSx9Dt8ZvMwHBFn3ALeaW3UE0bH
 6FQ=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; d="scan'208";a="140062126"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 00:59:01 +0800
IronPort-SDR: q7LbVjiSaXONLJTSUDUbjlbp46iuELpoVzPuiPnYbt4Xb9VOSACloy3+YnoPdsyAz8umOX44ov
 7d04SINnMGHfla8bBaZ/Ewpjqfp0qzJb8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 09:48:17 -0700
IronPort-SDR: LLusL2122mTe1QRChPOzSq2sqTZ9S8RRTQ4zD5z2YSDWSJ+M9RAueUvx9FBUW2y4gnCjDqMWeI
 G+0ZYpUSmvyQ==
WDCIronportException: Internal
Received: from 71vjjc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.96])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 May 2020 09:59:00 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 05/10] riscv: Initial commit of OpenTitan machine
Date: Wed, 27 May 2020 09:50:26 -0700
Message-Id: <0747fe5da70615cca9c6a0e69eadc61969ab0761.1590598125.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590598125.git.alistair.francis@wdc.com>
References: <cover.1590598125.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=40961fbaf=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 12:58:55
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a barebone OpenTitan machine to QEMU.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 default-configs/riscv32-softmmu.mak |   1 +
 default-configs/riscv64-softmmu.mak |  11 +-
 include/hw/riscv/opentitan.h        |  63 +++++++++++
 hw/riscv/opentitan.c                | 169 ++++++++++++++++++++++++++++
 MAINTAINERS                         |   9 ++
 hw/riscv/Kconfig                    |   5 +
 hw/riscv/Makefile.objs              |   1 +
 7 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/riscv/opentitan.h
 create mode 100644 hw/riscv/opentitan.c

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
index 1ae077ed87..94a236c9c2 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -10,3 +10,4 @@ CONFIG_SPIKE=y
 CONFIG_SIFIVE_E=y
 CONFIG_SIFIVE_U=y
 CONFIG_RISCV_VIRT=y
+CONFIG_OPENTITAN=y
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
index 235c6f473f..aaf6d735bb 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -1,3 +1,12 @@
 # Default configuration for riscv64-softmmu
 
-include riscv32-softmmu.mak
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_PCI_DEVICES=n
+
+# Boards:
+#
+CONFIG_SPIKE=y
+CONFIG_SIFIVE_E=y
+CONFIG_SIFIVE_U=y
+CONFIG_RISCV_VIRT=y
diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
new file mode 100644
index 0000000000..15a3d87ed0
--- /dev/null
+++ b/include/hw/riscv/opentitan.h
@@ -0,0 +1,63 @@
+/*
+ * QEMU RISC-V Board Compatible with OpenTitan FPGA platform
+ *
+ * Copyright (c) 2020 Western Digital
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_OPENTITAN_H
+#define HW_OPENTITAN_H
+
+#include "hw/riscv/riscv_hart.h"
+
+#define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
+#define RISCV_IBEX_SOC(obj) \
+    OBJECT_CHECK(LowRISCIbexSoCState, (obj), TYPE_RISCV_IBEX_SOC)
+
+typedef struct LowRISCIbexSoCState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    RISCVHartArrayState cpus;
+    MemoryRegion flash_mem;
+    MemoryRegion rom;
+} LowRISCIbexSoCState;
+
+typedef struct OpenTitanState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    LowRISCIbexSoCState soc;
+} OpenTitanState;
+
+enum {
+    IBEX_ROM,
+    IBEX_RAM,
+    IBEX_FLASH,
+    IBEX_UART,
+    IBEX_GPIO,
+    IBEX_SPI,
+    IBEX_FLASH_CTRL,
+    IBEX_RV_TIMER,
+    IBEX_AES,
+    IBEX_HMAC,
+    IBEX_PLIC,
+    IBEX_PINMUX,
+    IBEX_ALERT_HANDLER,
+    IBEX_USBDEV,
+};
+
+#endif
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
new file mode 100644
index 0000000000..c00f0720ab
--- /dev/null
+++ b/hw/riscv/opentitan.c
@@ -0,0 +1,169 @@
+/*
+ * QEMU RISC-V Board Compatible with OpenTitan FPGA platform
+ *
+ * Copyright (c) 2020 Western Digital
+ *
+ * Provides a board compatible with the OpenTitan FPGA platform:
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/riscv/opentitan.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/misc/unimp.h"
+#include "hw/riscv/boot.h"
+#include "exec/address-spaces.h"
+
+static const struct MemmapEntry {
+    hwaddr base;
+    hwaddr size;
+} ibex_memmap[] = {
+    [IBEX_ROM] =            {  0x00008000,   0xc000 },
+    [IBEX_RAM] =            {  0x10000000,  0x10000 },
+    [IBEX_FLASH] =          {  0x20000000,  0x80000 },
+    [IBEX_UART] =           {  0x40000000,  0x10000 },
+    [IBEX_GPIO] =           {  0x40010000,  0x10000 },
+    [IBEX_SPI] =            {  0x40020000,  0x10000 },
+    [IBEX_FLASH_CTRL] =     {  0x40030000,  0x10000 },
+    [IBEX_PINMUX] =         {  0x40070000,  0x10000 },
+    [IBEX_RV_TIMER] =       {  0x40080000,  0x10000 },
+    [IBEX_PLIC] =           {  0x40090000,  0x10000 },
+    [IBEX_AES] =            {  0x40110000,  0x10000 },
+    [IBEX_HMAC] =           {  0x40120000,  0x10000 },
+    [IBEX_ALERT_HANDLER] =  {  0x40130000,  0x10000 },
+    [IBEX_USBDEV] =         {  0x40150000,  0x10000 }
+};
+
+static void riscv_opentitan_init(MachineState *machine)
+{
+    const struct MemmapEntry *memmap = ibex_memmap;
+    OpenTitanState *s = g_new0(OpenTitanState, 1);
+    MemoryRegion *sys_mem = get_system_memory();
+    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
+
+    /* Initialize SoC */
+    object_initialize_child(OBJECT(machine), "soc", &s->soc,
+                            sizeof(s->soc), TYPE_RISCV_IBEX_SOC,
+                            &error_abort, NULL);
+    object_property_set_bool(OBJECT(&s->soc), true, "realized",
+                            &error_abort);
+
+    memory_region_init_ram(main_mem, NULL, "riscv.lowrisc.ibex.ram",
+        memmap[IBEX_RAM].size, &error_fatal);
+    memory_region_add_subregion(sys_mem,
+        memmap[IBEX_RAM].base, main_mem);
+
+
+    if (machine->firmware) {
+        riscv_load_firmware(machine->firmware, memmap[IBEX_RAM].base, NULL);
+    }
+
+    if (machine->kernel_filename) {
+        riscv_load_kernel(machine->kernel_filename, NULL);
+    }
+}
+
+static void riscv_opentitan_machine_init(MachineClass *mc)
+{
+    mc->desc = "RISC-V Board compatible with OpenTitan";
+    mc->init = riscv_opentitan_init;
+    mc->max_cpus = 1;
+    mc->default_cpu_type = TYPE_RISCV_CPU_IBEX;
+}
+
+DEFINE_MACHINE("opentitan", riscv_opentitan_machine_init)
+
+static void riscv_lowrisc_ibex_soc_init(Object *obj)
+{
+    LowRISCIbexSoCState *s = RISCV_IBEX_SOC(obj);
+
+    object_initialize_child(obj, "cpus", &s->cpus,
+                            sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
+                            &error_abort, NULL);
+}
+
+static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    const struct MemmapEntry *memmap = ibex_memmap;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    LowRISCIbexSoCState *s = RISCV_IBEX_SOC(dev_soc);
+    MemoryRegion *sys_mem = get_system_memory();
+
+    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
+                            &error_abort);
+    object_property_set_bool(OBJECT(&s->cpus), true, "realized",
+                            &error_abort);
+
+    /* Boot ROM */
+    memory_region_init_rom(&s->rom, OBJECT(dev_soc), "riscv.lowrisc.ibex.rom",
+                           memmap[IBEX_ROM].size, &error_fatal);
+    memory_region_add_subregion(sys_mem,
+        memmap[IBEX_ROM].base, &s->rom);
+
+    /* Flash memory */
+    memory_region_init_rom(&s->flash_mem, OBJECT(dev_soc), "riscv.lowrisc.ibex.flash",
+                           memmap[IBEX_FLASH].size, &error_fatal);
+    memory_region_add_subregion(sys_mem, memmap[IBEX_FLASH].base,
+                                &s->flash_mem);
+
+    create_unimplemented_device("riscv.lowrisc.ibex.uart",
+        memmap[IBEX_UART].base, memmap[IBEX_UART].size);
+    create_unimplemented_device("riscv.lowrisc.ibex.gpio",
+        memmap[IBEX_GPIO].base, memmap[IBEX_GPIO].size);
+    create_unimplemented_device("riscv.lowrisc.ibex.spi",
+        memmap[IBEX_SPI].base, memmap[IBEX_SPI].size);
+    create_unimplemented_device("riscv.lowrisc.ibex.flash_ctrl",
+        memmap[IBEX_FLASH_CTRL].base, memmap[IBEX_FLASH_CTRL].size);
+    create_unimplemented_device("riscv.lowrisc.ibex.rv_timer",
+        memmap[IBEX_RV_TIMER].base, memmap[IBEX_RV_TIMER].size);
+    create_unimplemented_device("riscv.lowrisc.ibex.aes",
+        memmap[IBEX_AES].base, memmap[IBEX_AES].size);
+    create_unimplemented_device("riscv.lowrisc.ibex.hmac",
+        memmap[IBEX_HMAC].base, memmap[IBEX_HMAC].size);
+    create_unimplemented_device("riscv.lowrisc.ibex.plic",
+        memmap[IBEX_PLIC].base, memmap[IBEX_PLIC].size);
+    create_unimplemented_device("riscv.lowrisc.ibex.pinmux",
+        memmap[IBEX_PINMUX].base, memmap[IBEX_PINMUX].size);
+    create_unimplemented_device("riscv.lowrisc.ibex.alert_handler",
+        memmap[IBEX_ALERT_HANDLER].base, memmap[IBEX_ALERT_HANDLER].size);
+    create_unimplemented_device("riscv.lowrisc.ibex.USBDEV",
+        memmap[IBEX_USBDEV].base, memmap[IBEX_USBDEV].size);
+}
+
+static void riscv_lowrisc_ibex_soc_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = riscv_lowrisc_ibex_soc_realize;
+    /* Reason: Uses serial_hds in realize function, thus can't be used twice */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo riscv_lowrisc_ibex_soc_type_info = {
+    .name = TYPE_RISCV_IBEX_SOC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(LowRISCIbexSoCState),
+    .instance_init = riscv_lowrisc_ibex_soc_init,
+    .class_init = riscv_lowrisc_ibex_soc_class_init,
+};
+
+static void riscv_lowrisc_ibex_soc_register_types(void)
+{
+    type_register_static(&riscv_lowrisc_ibex_soc_type_info);
+}
+
+type_init(riscv_lowrisc_ibex_soc_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 3690f313c3..668e664fa5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1236,6 +1236,15 @@ F: pc-bios/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
 
+RISC-V Machines
+---------------
+OpenTitan
+M: Alistair Francis <Alistair.Francis@wdc.com>
+L: qemu-riscv@nongnu.org
+S: Supported
+F: hw/riscv/opentitan.c
+F: include/hw/riscv/opentitan.h
+
 SH4 Machines
 ------------
 R2D
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index ff9fbe958a..94d19571f7 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -27,6 +27,11 @@ config SPIKE
     select HTIF
     select SIFIVE
 
+config OPENTITAN
+    bool
+    select HART
+    select UNIMP
+
 config RISCV_VIRT
     bool
     imply PCI_DEVICES
diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index fc3c6dd7c8..57cc708f5d 100644
--- a/hw/riscv/Makefile.objs
+++ b/hw/riscv/Makefile.objs
@@ -1,6 +1,7 @@
 obj-y += boot.o
 obj-$(CONFIG_SPIKE) += riscv_htif.o
 obj-$(CONFIG_HART) += riscv_hart.o
+obj-$(CONFIG_OPENTITAN) += opentitan.o
 obj-$(CONFIG_SIFIVE_E) += sifive_e.o
 obj-$(CONFIG_SIFIVE_E) += sifive_e_prci.o
 obj-$(CONFIG_SIFIVE) += sifive_clint.o
-- 
2.26.2


