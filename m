Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20769C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7948A207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XGAQOuI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7948A207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRHZ-0004kw-EZ
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBp-0004bd-JO
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBl-0002ls-T6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762053; x=1631298053;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xmfLuBMIZrrebJFSnBFwUcn364LhcpeKGj2U18KR0nM=;
 b=XGAQOuI/LuYUd9TUxiMVzt+VKUWOAP2jYq5KlLw68vl73ZqOA/XSkEC2
 EkYngQHzHwababiNvL4BBvzcrmjUzgXxZgRN3DCejD+ZW2SaL2xPm/yO1
 77Kq9818g10yVDLmWuMJf0ZPsK3/pfDePYmVAmKFIs2rgx/eRt0XPfOrq
 o9sE1xaWxK+F0vy73D56WZtcZimeXJ92QfO5Os3dl49J2ZWAqcGHATv+x
 BOI6p5+IDZ0zRj/UzS7FijwX7dXDtXbi6oe7ayoXGRc3kNMD5wW6Qkhu9
 MPmuFgxCvZdyJW5JqS3+HAuWC8Kev/w3jdK8eTEvRzamzslR2O5RA9TUY g==;
IronPort-SDR: FUkBMRD1n1UokujTUfIiPYqXmV0AqAsGNzaTo67IGZSn5KqzuObh4xZF/xYSgnYs5idkRHx4MI
 SI1KO6QR0H2x4dACflRT3MLngxTK+6+9r5z9k0s32EdK7PecqFO5eIkj0F07gjPvnNscKinhpb
 jmoYBR/WCHkBm9ljTGUfvKwBehtGwbD3l3iZcCogsJNU7YqAEhNqgft+Av6ArKhc+McwlwSA6E
 qvnzmfPf6i1zQYtWVLL1TFgoP3tQqRqss9HbmnzfE0Ww4gzTNe+7w6bh+nY5rAYAgwUjBPp0At
 oa4=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979235"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:18 +0800
IronPort-SDR: TgXoK+kr9ZkAgNaEtFg4Wjlcd5RbwVjkAclHrH8WkFk12fZeS5CtIR8AIz4Ykp3Lpyo6w49kFD
 bVfGd8OW4Gmg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:35 -0700
IronPort-SDR: H/gnIYOWDmRbJtFO0/3NW31oTvyF9AM6EFsyG7QDzSx6v5KmAkrPhJT1SVHeYUOVzmz1yUrOZN
 DnfL9EoP3Qow==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 15/30] hw/riscv: microchip_pfsoc: Connect 2 Cadence GEMs
Date: Thu, 10 Sep 2020 11:09:23 -0700
Message-Id: <20200910180938.584205-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Microchip PolarFire SoC integrates 2 Candence GEMs to provide
IEEE 802.3 standard-compliant 10/100/1000 Mbps ethernet interface.

On the Icicle Kit board, GEM0 connects to a PHY at address 8 while
GEM1 connects to a PHY at address 9.

The 2nd stage bootloader (U-Boot) is using GEM1 by default, so we
must specify 2 '-nic' options from the command line in order to get
a working ethernet.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <1598924352-89526-14-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h |  7 ++++++
 hw/riscv/microchip_pfsoc.c         | 39 ++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 63e786052a..6d20853039 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -24,6 +24,7 @@
 
 #include "hw/char/mchp_pfsoc_mmuart.h"
 #include "hw/dma/sifive_pdma.h"
+#include "hw/net/cadence_gem.h"
 #include "hw/sd/cadence_sdhci.h"
 
 typedef struct MicrochipPFSoCState {
@@ -42,6 +43,8 @@ typedef struct MicrochipPFSoCState {
     MchpPfSoCMMUartState *serial3;
     MchpPfSoCMMUartState *serial4;
     SiFivePDMAState dma;
+    CadenceGEMState gem0;
+    CadenceGEMState gem1;
     CadenceSDHCIState sdhci;
 } MicrochipPFSoCState;
 
@@ -84,6 +87,8 @@ enum {
     MICROCHIP_PFSOC_MMUART2,
     MICROCHIP_PFSOC_MMUART3,
     MICROCHIP_PFSOC_MMUART4,
+    MICROCHIP_PFSOC_GEM0,
+    MICROCHIP_PFSOC_GEM1,
     MICROCHIP_PFSOC_ENVM_CFG,
     MICROCHIP_PFSOC_ENVM_DATA,
     MICROCHIP_PFSOC_IOSCB_CFG,
@@ -99,6 +104,8 @@ enum {
     MICROCHIP_PFSOC_DMA_IRQ5 = 10,
     MICROCHIP_PFSOC_DMA_IRQ6 = 11,
     MICROCHIP_PFSOC_DMA_IRQ7 = 12,
+    MICROCHIP_PFSOC_GEM0_IRQ = 64,
+    MICROCHIP_PFSOC_GEM1_IRQ = 70,
     MICROCHIP_PFSOC_EMMC_SD_IRQ = 88,
     MICROCHIP_PFSOC_MMUART0_IRQ = 90,
     MICROCHIP_PFSOC_MMUART1_IRQ = 91,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index d8ec973958..7f25609182 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -14,6 +14,7 @@
  * 3) MMUARTs (Multi-Mode UART)
  * 4) Cadence eMMC/SDHC controller and an SD card connected to it
  * 5) SiFive Platform DMA (Direct Memory Access Controller)
+ * 6) GEM (Gigabit Ethernet MAC Controller)
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -59,6 +60,9 @@
 #define BIOS_FILENAME   "hss.bin"
 #define RESET_VECTOR    0x20220000
 
+/* GEM version */
+#define GEM_REVISION    0x0107010c
+
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -83,6 +87,8 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
     [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
     [MICROCHIP_PFSOC_MMUART4] =         { 0x20106000,     0x1000 },
+    [MICROCHIP_PFSOC_GEM0] =            { 0x20110000,     0x2000 },
+    [MICROCHIP_PFSOC_GEM1] =            { 0x20112000,     0x2000 },
     [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
     [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
@@ -119,6 +125,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "dma-controller", &s->dma,
                             TYPE_SIFIVE_PDMA);
 
+    object_initialize_child(obj, "gem0", &s->gem0, TYPE_CADENCE_GEM);
+    object_initialize_child(obj, "gem1", &s->gem1, TYPE_CADENCE_GEM);
+
     object_initialize_child(obj, "sd-controller", &s->sdhci,
                             TYPE_CADENCE_SDHCI);
 }
@@ -134,6 +143,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *envm_data = g_new(MemoryRegion, 1);
     char *plic_hart_config;
     size_t plic_hart_config_len;
+    NICInfo *nd;
     int i;
 
     sysbus_realize(SYS_BUS_DEVICE(&s->e_cpus), &error_abort);
@@ -272,6 +282,35 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART4_IRQ),
         serial_hd(4));
 
+    /* GEMs */
+
+    nd = &nd_table[0];
+    if (nd->used) {
+        qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
+        qdev_set_nic_properties(DEVICE(&s->gem0), nd);
+    }
+    nd = &nd_table[1];
+    if (nd->used) {
+        qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
+        qdev_set_nic_properties(DEVICE(&s->gem1), nd);
+    }
+
+    object_property_set_int(OBJECT(&s->gem0), "revision", GEM_REVISION, errp);
+    object_property_set_int(OBJECT(&s->gem0), "phy-addr", 8, errp);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gem0), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem0), 0,
+                    memmap[MICROCHIP_PFSOC_GEM0].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem0), 0,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_GEM0_IRQ));
+
+    object_property_set_int(OBJECT(&s->gem1), "revision", GEM_REVISION, errp);
+    object_property_set_int(OBJECT(&s->gem1), "phy-addr", 9, errp);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gem1), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem1), 0,
+                    memmap[MICROCHIP_PFSOC_GEM1].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem1), 0,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_GEM1_IRQ));
+
     /* eNVM */
     memory_region_init_rom(envm_data, OBJECT(dev), "microchip.pfsoc.envm.data",
                            memmap[MICROCHIP_PFSOC_ENVM_DATA].size,
-- 
2.28.0


