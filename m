Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D84C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B14208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J+s8JWS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B14208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKjE-00024M-1X
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUQ-0000sx-74
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:42 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUM-0004Pk-UO
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586467; x=1624122467;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OkbSeEt8d4QhxTt7wrMb8feZC4BTffnkVC2ibOszsG4=;
 b=J+s8JWS4X9ovmbQqQgqOt4952dwCZglA4p/zL3+NJ2KtAFe0+Ok1p/Wx
 m0ybNmMMJkwOAe+qjM+8n+o5zNQT+t/m8nFOqFI8Z+rTkIY2T2zRj/dt2
 EgWpMw+DBSnyHctxsvCUB8YM80ExMuZpQUaq1zIzaa2SofFuFa0W+sdTT
 dhZhcTZIO4FySks0YEnIiP5KgMjcMx5Tzy8ZzW7FqkZQTZJCahaG9jjki
 UUFsyeR+Ngd5OopMiMfUmLScqOY3dEuFozxGLSu6sABfVj3bpJmzfvGeU
 UJA90F9CYjdi9/E1MY0ONYmwZc7w5N2HTeAWLwBrM4VfaWyvR6IGMGWn5 Q==;
IronPort-SDR: yDtaU66bVJydsFjeXjrRSk+/exb17VdFvxQmr3YItG7TCLMH7aqQj/kIcRXzBcMbxHg+Tdop19
 Szauclo6u1mRKwE2cqKJALhpCatXfulljzCviz/3Q2xSNnv026EVrVxk5Nki3ZID+QltTRsxxQ
 SH1WL9zRSujvyF9Kmqbw2BfKI7nNlaY7XBTKASslFTMg0MyPl3WEpnqlyqhKQYTs78V04qiJkS
 cmCL428QPuQpIrnQUui0wSBSBaZWrzpIkgt1sC9efc6WiIDDvlsP3VIEq+NqiQR9tpoaRj9xlB
 aa4=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243417009"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:28 +0800
IronPort-SDR: PSZPz3K7H8uALh8i2rQHDTI1/rYaBj0ct9PpRmS96RxFLNs9Nz+dQkemdJ1n9gXx3P3PHcDU6i
 zbqxYBw9ys5LmtQLOl2Dgdq5U9oQuutgI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:04 -0700
IronPort-SDR: 7wKwWrh92ZdJ4OOW8T2ycI/DnDvHP0SUWZy70E31VIeO6qxTWG556g5vIBAC6H0gewXgROZKdb
 5wTXhgFxx+GQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 23/32] hw/riscv: sifive_u: Hook a GPIO controller
Date: Fri, 19 Jun 2020 09:58:08 -0700
Message-Id: <20200619165817.4144200-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

SiFive FU540 SoC integrates a GPIO controller with 16 GPIO lines.
This hooks the exsiting SiFive GPIO model to the SoC, and adds its
device tree data as well.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-8-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-8-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_u.h | 19 ++++++++++++++++
 hw/riscv/sifive_u.c         | 43 +++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 5f62cf5f85..b1399a90a6 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -22,6 +22,7 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_cpu.h"
+#include "hw/riscv/sifive_gpio.h"
 #include "hw/riscv/sifive_u_prci.h"
 #include "hw/riscv/sifive_u_otp.h"
 
@@ -40,6 +41,7 @@ typedef struct SiFiveUSoCState {
     RISCVHartArrayState u_cpus;
     DeviceState *plic;
     SiFiveUPRCIState prci;
+    SIFIVEGPIOState gpio;
     SiFiveUOTPState otp;
     CadenceGEMState gem;
 
@@ -73,6 +75,7 @@ enum {
     SIFIVE_U_PRCI,
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
+    SIFIVE_U_GPIO,
     SIFIVE_U_OTP,
     SIFIVE_U_FLASH0,
     SIFIVE_U_DRAM,
@@ -83,6 +86,22 @@ enum {
 enum {
     SIFIVE_U_UART0_IRQ = 4,
     SIFIVE_U_UART1_IRQ = 5,
+    SIFIVE_U_GPIO_IRQ0 = 7,
+    SIFIVE_U_GPIO_IRQ1 = 8,
+    SIFIVE_U_GPIO_IRQ2 = 9,
+    SIFIVE_U_GPIO_IRQ3 = 10,
+    SIFIVE_U_GPIO_IRQ4 = 11,
+    SIFIVE_U_GPIO_IRQ5 = 12,
+    SIFIVE_U_GPIO_IRQ6 = 13,
+    SIFIVE_U_GPIO_IRQ7 = 14,
+    SIFIVE_U_GPIO_IRQ8 = 15,
+    SIFIVE_U_GPIO_IRQ9 = 16,
+    SIFIVE_U_GPIO_IRQ10 = 17,
+    SIFIVE_U_GPIO_IRQ11 = 18,
+    SIFIVE_U_GPIO_IRQ12 = 19,
+    SIFIVE_U_GPIO_IRQ13 = 20,
+    SIFIVE_U_GPIO_IRQ14 = 21,
+    SIFIVE_U_GPIO_IRQ15 = 22,
     SIFIVE_U_GEM_IRQ = 0x35
 };
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a6dfce4273..f6976a0d09 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -11,8 +11,9 @@
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
  * 3) PRCI (Power, Reset, Clock, Interrupt)
- * 4) OTP (One-Time Programmable) memory with stored serial number
- * 5) GEM (Gigabit Ethernet Controller) and management block
+ * 4) GPIO (General Purpose Input/Output Controller)
+ * 5) OTP (One-Time Programmable) memory with stored serial number
+ * 6) GEM (Gigabit Ethernet Controller) and management block
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -75,6 +76,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
+    [SIFIVE_U_GPIO] =     { 0x10060000,     0x1000 },
     [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
     [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
@@ -268,6 +270,28 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
+    nodename = g_strdup_printf("/soc/gpio@%lx",
+        (long)memmap[SIFIVE_U_GPIO].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "clocks",
+        prci_phandle, PRCI_CLK_TLCLK);
+    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 2);
+    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(fdt, nodename, "#gpio-cells", 2);
+    qemu_fdt_setprop(fdt, nodename, "gpio-controller", NULL, 0);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[SIFIVE_U_GPIO].base,
+        0x0, memmap[SIFIVE_U_GPIO].size);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_GPIO_IRQ0,
+        SIFIVE_U_GPIO_IRQ1, SIFIVE_U_GPIO_IRQ2, SIFIVE_U_GPIO_IRQ3,
+        SIFIVE_U_GPIO_IRQ4, SIFIVE_U_GPIO_IRQ5, SIFIVE_U_GPIO_IRQ6,
+        SIFIVE_U_GPIO_IRQ7, SIFIVE_U_GPIO_IRQ8, SIFIVE_U_GPIO_IRQ9,
+        SIFIVE_U_GPIO_IRQ10, SIFIVE_U_GPIO_IRQ11, SIFIVE_U_GPIO_IRQ12,
+        SIFIVE_U_GPIO_IRQ13, SIFIVE_U_GPIO_IRQ14, SIFIVE_U_GPIO_IRQ15);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,gpio0");
+    g_free(nodename);
+
     phy_phandle = phandle++;
     nodename = g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
@@ -515,6 +539,7 @@ static void sifive_u_soc_instance_init(Object *obj)
     object_initialize_child(obj, "prci", &s->prci, TYPE_SIFIVE_U_PRCI);
     object_initialize_child(obj, "otp", &s->otp, TYPE_SIFIVE_U_OTP);
     object_initialize_child(obj, "gem", &s->gem, TYPE_CADENCE_GEM);
+    object_initialize_child(obj, "gpio", &s->gpio, TYPE_SIFIVE_GPIO);
 }
 
 static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
@@ -600,6 +625,20 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->prci), &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
 
+    qdev_prop_set_uint32(DEVICE(&s->gpio), "ngpio", 16);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_U_GPIO].base);
+
+    /* Pass all GPIOs to the SOC layer so they are available to the board */
+    qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
+
+    /* Connect GPIO interrupts to the PLIC */
+    for (i = 0; i < 16; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), i,
+                           qdev_get_gpio_in(DEVICE(s->plic),
+                                            SIFIVE_U_GPIO_IRQ0 + i));
+    }
+
     qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
     sysbus_realize(SYS_BUS_DEVICE(&s->otp), &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
-- 
2.27.0


