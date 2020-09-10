Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D9BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9075F2080A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k/BZejqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9075F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRP2-0002Re-6W
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBc-0004A0-16
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBX-0002j9-VJ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762039; x=1631298039;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G41gKu2XitSL4Fp+Wr8ihEjovr03vnAPD5/BKz1N9wg=;
 b=k/BZejqhZrbJMjJN0F9koMQFnCjDMjexOe7VCBoj7H7WT0b3bhyQFedC
 t8oR1+eFyV0c3VAzhDco56lf1Y1mf6tNwnmQUBCiBrLsExsbFVV7xBnmn
 w7kNw8SQbW7kPrGdJmyVpYGMvvQWEG280RgYgZeyCfYC2cXY0B9dDPNQN
 Mk8NB9K2kGjqcAc1Zj8ncR6kjrHytA2PyfenV/+4NPX9c1LZ9EX4m2eWZ
 7LvxJ25NEFy7JtJKqrciVjzpKRoEPZ+wHe/LpJRxDaHXZ3N0J2oU4VPCT
 nNYD+1u5uyptTD1AuLoCvp0cixtsd1PH1WN4GBuyUtJhb197roN+F9kCK w==;
IronPort-SDR: CvKrLuTrINszinW4jqVP2ykQ1QBkFRR1iuvuTxwVraOnxkCAYSW6YsUkRttwVu/s2uW3ub10MF
 58DcUZh4okEicfckvOJEH6AjyrosKk0zXcb0u0gfR421rHxf8iCnzX0/YFSUNbBcMLmRQN46zl
 5sgk5ZeIhtaI6jVmvHpfY+G4HEqJ6C/e/QDxfCLQZ11vRkyWUs7uEFHZ3TZ/c43uUxlISl8hyG
 TahkQWa+458KwiAs/LfVUq7Q9sW73oPEFsOTvtB81ncG6d4mfqh3zHic+WKkvTgDcOhCUrDkHy
 YTg=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979224"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:17 +0800
IronPort-SDR: GQNUXNts3tMm3eljmursR1Vl4sD/yzWK4ajEmNSONeP029jC4I85nQS6q1f7iRcUX/3VteY87f
 +eslcpWL18PQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:34 -0700
IronPort-SDR: //biqQMYJ87l1oNubhkgGBkXsF6YVJH4xNUNyCCUadTYY9stoG6dD8usjCDBckRPLb/YfmEu0D
 7YVgWeRQKfNw==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 10/30] hw/riscv: microchip_pfsoc: Connect a Cadence SDHCI
 controller and an SD card
Date: Thu, 10 Sep 2020 11:09:18 -0700
Message-Id: <20200910180938.584205-11-alistair.francis@wdc.com>
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

Microchip PolarFire SoC integrates one Cadence SDHCI controller.
On the Icicle Kit board, one eMMC chip and an external SD card
connect to this controller depending on different configuration.

As QEMU does not support eMMC yet, we just emulate the SD card
configuration. To test this, the Hart Software Services (HSS)
should choose the SD card configuration:

$ cp boards/icicle-kit-es/def_config.sdcard .config
$ make BOARD=icicle-kit-es

The SD card image can be built from the Yocto BSP at:
https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp

Note the generated SD card image should be resized before use:
$ qemu-img resize /path/to/sdcard.img 4G

Launch QEMU with the following command:
$ qemu-system-riscv64 -nographic -M microchip-icicle-kit -sd sdcard.img

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1598924352-89526-9-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h |  4 ++++
 hw/riscv/microchip_pfsoc.c         | 23 +++++++++++++++++++++++
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 28 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index a5efa1dcb8..d810ee8484 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -23,6 +23,7 @@
 #define HW_MICROCHIP_PFSOC_H
 
 #include "hw/char/mchp_pfsoc_mmuart.h"
+#include "hw/sd/cadence_sdhci.h"
 
 typedef struct MicrochipPFSoCState {
     /*< private >*/
@@ -39,6 +40,7 @@ typedef struct MicrochipPFSoCState {
     MchpPfSoCMMUartState *serial2;
     MchpPfSoCMMUartState *serial3;
     MchpPfSoCMMUartState *serial4;
+    CadenceSDHCIState sdhci;
 } MicrochipPFSoCState;
 
 #define TYPE_MICROCHIP_PFSOC    "microchip.pfsoc"
@@ -74,6 +76,7 @@ enum {
     MICROCHIP_PFSOC_MMUART0,
     MICROCHIP_PFSOC_SYSREG,
     MICROCHIP_PFSOC_MPUCFG,
+    MICROCHIP_PFSOC_EMMC_SD,
     MICROCHIP_PFSOC_MMUART1,
     MICROCHIP_PFSOC_MMUART2,
     MICROCHIP_PFSOC_MMUART3,
@@ -85,6 +88,7 @@ enum {
 };
 
 enum {
+    MICROCHIP_PFSOC_EMMC_SD_IRQ = 88,
     MICROCHIP_PFSOC_MMUART0_IRQ = 90,
     MICROCHIP_PFSOC_MMUART1_IRQ = 91,
     MICROCHIP_PFSOC_MMUART2_IRQ = 92,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index cee959a5e0..0b2e9ca175 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -12,6 +12,7 @@
  * 1) PLIC (Platform Level Interrupt Controller)
  * 2) eNVM (Embedded Non-Volatile Memory)
  * 3) MMUARTs (Multi-Mode UART)
+ * 4) Cadence eMMC/SDHC controller and an SD card connected to it
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -75,6 +76,7 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
     [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
     [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
+    [MICROCHIP_PFSOC_EMMC_SD] =         { 0x20008000,     0x1000 },
     [MICROCHIP_PFSOC_MMUART1] =         { 0x20100000,     0x1000 },
     [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
     [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
@@ -111,6 +113,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type",
                          TYPE_RISCV_CPU_SIFIVE_U54);
     qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", RESET_VECTOR);
+
+    object_initialize_child(obj, "sd-controller", &s->sdhci,
+                            TYPE_CADENCE_SDHCI);
 }
 
 static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
@@ -223,6 +228,13 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_MPUCFG].base,
         memmap[MICROCHIP_PFSOC_MPUCFG].size);
 
+    /* SDHCI */
+    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
+                    memmap[MICROCHIP_PFSOC_EMMC_SD].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_EMMC_SD_IRQ));
+
     /* MMUARTs */
     s->serial0 = mchp_pfsoc_mmuart_create(system_memory,
         memmap[MICROCHIP_PFSOC_MMUART0].base,
@@ -290,6 +302,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
+    DriveInfo *dinfo = drive_get_next(IF_SD);
 
     /* Sanity check on RAM size */
     if (machine->ram_size < mc->default_ram_size) {
@@ -312,6 +325,16 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
 
     /* Load the firmware */
     riscv_find_and_load_firmware(machine, BIOS_FILENAME, RESET_VECTOR, NULL);
+
+    /* Attach an SD card */
+    if (dinfo) {
+        CadenceSDHCIState *sdhci = &(s->soc.sdhci);
+        DeviceState *card = qdev_new(TYPE_SD_CARD);
+
+        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, sdhci->bus, &error_fatal);
+    }
 }
 
 static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index ceb7c166a3..7412db9ad7 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -55,3 +55,4 @@ config MICROCHIP_PFSOC
     select SIFIVE
     select UNIMP
     select MCHP_PFSOC_MMUART
+    select CADENCE_SDHCI
-- 
2.28.0


