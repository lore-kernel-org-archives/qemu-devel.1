Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A28C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C810B20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0vWChse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C810B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7ne-0003gb-Uf
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jc-00034Z-St
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jY-0000OS-Qu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jY-0000NW-Ay
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 188so1511830wmc.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/JOpwnlKiYDdU9XInaBUbtyuT88O8qiGy04kfKAS7w8=;
 b=E0vWChsepRLNXmVk+DI/u6XpCvkKqovYV3OzIm04wE700TTJn2ztqeSv9JBEIWVN7n
 1bEj9o8JMToKLF0CFB6h00H+rLhZ31INM78IPf7ajMc6A7zU4XAkxirpUDJLuLNH76IJ
 zIkVpNYwSI46VtLramFuk0WDpMwsO9MLZsPGayAue3jQPkDf4lWBYeEWKWlEHXnVJL9u
 yjM+xMP2fapHkuiqcKwOPZpi3Ev5tNTTc/yrfaMHRfkbteXPLkj0Wf0aSgzjkCFcSIci
 z82dEyau9ODMoWUFHhua+Bu9sqFY6AQBK/y4FSlhWZ29eBVhe9KFcmx2gW7OoFAqwwiZ
 Q2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/JOpwnlKiYDdU9XInaBUbtyuT88O8qiGy04kfKAS7w8=;
 b=iRelBI2jDhbFpjQJcdcRoiBzIg18zuTNpzEaDNzpybHVnlaFA5P9UzoTo5J2XwjoQz
 93boUkFfOCFLLQkg2oWmjcmb/MWsp0poBTB7gZOpzxrzNRKEtZnTDIWSe1YyNxO+R5MH
 tPpAEuULuDyXju/IeDexA1ptsNKRr3OgLHZZBVyOXQXiX9URgUQqPDsj9AAR30L46lR2
 Y6+f6/p6KZobszEAY7cZAphbyk4KXTaJ4n3S4UPo79k7YHyp9pc8jP28MbUxkRG6o7nq
 ufKjgURGtRDYZWjNLuaxxa6GeqNs7nnT7cevf/cd1Vw/wxhq+oeeJ8vBA0oczeFGkdSa
 Hosg==
X-Gm-Message-State: AGi0PuYIXmwdhY7DTvcoF+iPLAZYYAx2dbr15/C3vOVSufHsE6tVr5tK
 6fIDszc0TiNCDUTCjW6PdeZdnEy/U/vZWA==
X-Google-Smtp-Source: APiQypJh0KmWp1c2rciu3V86ynqIC8zfkZ5VZ/av87IXFvOoT8EhW8RGcKKMr47CKn0XyGYRfpDaFQ==
X-Received: by 2002:a1c:2d02:: with SMTP id t2mr2597783wmt.98.1588247522584;
 Thu, 30 Apr 2020 04:52:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/31] hw/arm/xilinx_zynq: connect uart clocks to slcr
Date: Thu, 30 Apr 2020 12:51:27 +0100
Message-Id: <20200430115142.13430-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32c
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

From: Damien Hedde <damien.hedde@greensocs.com>

Add the connection between the slcr's output clocks and the uarts inputs.

Also add the main board clock 'ps_clk', which is hard-coded to 33.33MHz
(the default frequency). This clock is used to feed the slcr's input
clock.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200406135251.157596-9-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xilinx_zynq.c | 57 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 571cdcd599e..91b498dd5d3 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -35,6 +35,15 @@
 #include "hw/char/cadence_uart.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/cpu/a9mpcore.h"
+#include "hw/qdev-clock.h"
+#include "sysemu/reset.h"
+
+#define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
+#define ZYNQ_MACHINE(obj) \
+    OBJECT_CHECK(ZynqMachineState, (obj), TYPE_ZYNQ_MACHINE)
+
+/* board base frequency: 33.333333 MHz */
+#define PS_CLK_FREQUENCY (100 * 1000 * 1000 / 3)
 
 #define NUM_SPI_FLASHES 4
 #define NUM_QSPI_FLASHES 2
@@ -75,6 +84,11 @@ static const int dma_irqs[8] = {
     0xe3401000 + ARMV7_IMM16(extract32((val), 16, 16)), /* movt r1 ... */ \
     0xe5801000 + (addr)
 
+typedef struct ZynqMachineState {
+    MachineState parent;
+    Clock *ps_clk;
+} ZynqMachineState;
+
 static void zynq_write_board_setup(ARMCPU *cpu,
                                    const struct arm_boot_info *info)
 {
@@ -159,10 +173,11 @@ static inline void zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
 
 static void zynq_init(MachineState *machine)
 {
+    ZynqMachineState *zynq_machine = ZYNQ_MACHINE(machine);
     ARMCPU *cpu;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
-    DeviceState *dev;
+    DeviceState *dev, *slcr;
     SysBusDevice *busdev;
     qemu_irq pic[64];
     int n;
@@ -206,9 +221,18 @@ static void zynq_init(MachineState *machine)
                           1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2aa,
                           0);
 
-    dev = qdev_create(NULL, "xilinx,zynq_slcr");
-    qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8000000);
+    /* Create slcr, keep a pointer to connect clocks */
+    slcr = qdev_create(NULL, "xilinx,zynq_slcr");
+    qdev_init_nofail(slcr);
+    sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
+
+    /* Create the main clock source, and feed slcr with it */
+    zynq_machine->ps_clk = CLOCK(object_new(TYPE_CLOCK));
+    object_property_add_child(OBJECT(zynq_machine), "ps_clk",
+                              OBJECT(zynq_machine->ps_clk), &error_abort);
+    object_unref(OBJECT(zynq_machine->ps_clk));
+    clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY);
+    qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
 
     dev = qdev_create(NULL, TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", 1);
@@ -229,8 +253,12 @@ static void zynq_init(MachineState *machine)
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0002000, pic[53 - IRQ_OFFSET]);
     sysbus_create_simple(TYPE_CHIPIDEA, 0xE0003000, pic[76 - IRQ_OFFSET]);
 
-    cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
-    cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
+    dev = cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
+    qdev_connect_clock_in(dev, "refclk",
+                          qdev_get_clock_out(slcr, "uart0_ref_clk"));
+    dev = cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
+    qdev_connect_clock_in(dev, "refclk",
+                          qdev_get_clock_out(slcr, "uart1_ref_clk"));
 
     sysbus_create_varargs("cadence_ttc", 0xF8001000,
             pic[42-IRQ_OFFSET], pic[43-IRQ_OFFSET], pic[44-IRQ_OFFSET], NULL);
@@ -308,8 +336,9 @@ static void zynq_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &zynq_binfo);
 }
 
-static void zynq_machine_init(MachineClass *mc)
+static void zynq_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = 1;
@@ -319,4 +348,16 @@ static void zynq_machine_init(MachineClass *mc)
     mc->default_ram_id = "zynq.ext_ram";
 }
 
-DEFINE_MACHINE("xilinx-zynq-a9", zynq_machine_init)
+static const TypeInfo zynq_machine_type = {
+    .name = TYPE_ZYNQ_MACHINE,
+    .parent = TYPE_MACHINE,
+    .class_init = zynq_machine_class_init,
+    .instance_size = sizeof(ZynqMachineState),
+};
+
+static void zynq_machine_register_types(void)
+{
+    type_register_static(&zynq_machine_type);
+}
+
+type_init(zynq_machine_register_types)
-- 
2.20.1


