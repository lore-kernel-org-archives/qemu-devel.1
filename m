Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29524C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E82B42078D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwdayXy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82B42078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6crk-0001Pb-5R
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cm6-00088m-Lk; Fri, 14 Aug 2020 12:41:50 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cm4-0002im-KG; Fri, 14 Aug 2020 12:41:50 -0400
Received: by mail-pf1-x444.google.com with SMTP id d22so4815587pfn.5;
 Fri, 14 Aug 2020 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FK50ORz16F3dnaLHeIWxnRqzsyIO5VCFaWwZ349ZLBQ=;
 b=ZwdayXy92Zc009OwTIbJbfKn8uCZoQP111ub8pqYd3cK9Nx9K7tFMvQWArFLSlQI7w
 dBcDNbbdIEOukzLAPqrh1SrnK05HNd+jxPsDYfQRp5dAhxVGCgpk5G32TnUxfYw1jlDS
 VotQ20tNL9PXRIisZjfleZxWc/uRVWDaNQKuV9nECvasxBZzAfWV6ETL5ItohLqN7utd
 L36lZAOKV3vib+/+u5pRMl+MwYHVYdRbuesydup5gHenhozN5MMVwk6SVqBmL47FrtA8
 6b5gSEOOEsO2j/jHgci3W4/OitnoRkadKgnxaXgAUI3UwfTT443+LPLHFyZq6g2XoyaT
 B8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FK50ORz16F3dnaLHeIWxnRqzsyIO5VCFaWwZ349ZLBQ=;
 b=NPwF0hSN2G1lzWP3aZinY6xNYwIt/LWPvJJnAhUkHJHFNFHBmp4OHXWGWcbEx97JrJ
 +TVOZB0XklJAYf2UJmaUmUyG06mNDJMU+n75gGYIpuZAIWS5jCIPmusmvJ9jNUB0W9/A
 vK9PVeaRSiVaIWrFXafiN4T+07zzfDtPyhNdMf9T8/v0hLkBiil34VNXSfTGFEoVwzVQ
 kzCdGqPJYeO1gZQRGo3AFk7uMeh8DgAN7ZjfaHOAkSsKd2T7HcB8RjLTTAvmrafCs4hZ
 qwunQhzxO29qgOHwhbeoG1HCy2CawNQgDI/UKexR57vthONnAWKK2zUYZKzqnkEZqBwL
 SOIw==
X-Gm-Message-State: AOAM5336naaQgbes+UZkbeYQGpTbvkpHaTp+wxs4rgTsQlHu+GJKy6lf
 lmoUCPWiFgvsnYJzavaCJw4=
X-Google-Smtp-Source: ABdhPJxzS2vMKeKILxWuL1Ege8SIBqWqDAeic59RVa3oqxjTSVteoA48phwxoZZMAaWijIfT/36Bqw==
X-Received: by 2002:a63:af47:: with SMTP id s7mr2381722pgo.335.1597423306955; 
 Fri, 14 Aug 2020 09:41:46 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id 16sm9836332pfi.161.2020.08.14.09.41.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:41:46 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 11/18] hw/riscv: microchip_pfsoc: Connect a Cadence SDHCI
 controller and an SD card
Date: Sat, 15 Aug 2020 00:40:49 +0800
Message-Id: <1597423256-14847-12-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>
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
---

 hw/riscv/Kconfig                   |  1 +
 hw/riscv/microchip_pfsoc.c         | 26 ++++++++++++++++++++++++++
 include/hw/riscv/microchip_pfsoc.h |  4 ++++
 3 files changed, 31 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index ceb7c16..7412db9 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -55,3 +55,4 @@ config MICROCHIP_PFSOC
     select SIFIVE
     select UNIMP
     select MCHP_PFSOC_MMUART
+    select CADENCE_SDHCI
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index f6b375c..7c09078 100644
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
@@ -111,6 +113,11 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type",
                          TYPE_RISCV_CPU_SIFIVE_U54);
     qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", RESET_VECTOR);
+
+    object_initialize_child(obj, "sd-controller", &s->sdhci,
+                            TYPE_CADENCE_SDHCI);
+    object_initialize_child(OBJECT(&s->sdhci), "sd-controller.sdhci",
+                            &s->sdhci.slot, TYPE_SYSBUS_SDHCI);
 }
 
 static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
@@ -223,6 +230,13 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_MPUCFG].base,
         memmap[MICROCHIP_PFSOC_MPUCFG].size);
 
+    /* SDHCI */
+    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
+                    memmap[MICROCHIP_PFSOC_EMMC_SD].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci.slot), 0,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_EMMC_SD_IRQ));
+
     /* MMUARTs */
     s->serial0 = mchp_pfsoc_mmuart_create(system_memory,
         memmap[MICROCHIP_PFSOC_MMUART0].base,
@@ -290,6 +304,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
+    DriveInfo *dinfo = drive_get_next(IF_SD);
 
     /* Sanity check on RAM size */
     if (machine->ram_size < mc->default_ram_size) {
@@ -312,6 +327,17 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
 
     /* Load the firmware */
     riscv_find_and_load_firmware(machine, BIOS_FILENAME, RESET_VECTOR, NULL);
+
+    /* Attach an SD card */
+    if (dinfo) {
+        SDHCIState *sdhci = &(s->soc.sdhci.slot);
+        DeviceState *card = qdev_new(TYPE_SD_CARD);
+        BusState *bus = qdev_get_child_bus(DEVICE(sdhci), "sd-bus");
+
+        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, bus, &error_fatal);
+    }
 }
 
 static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index a5efa1d..d810ee8 100644
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
-- 
2.7.4


