Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0DFC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C5420707
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdf4qXzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C5420707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2kq-0005oo-PD
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2cp-000107-AD; Sat, 29 Aug 2020 11:18:39 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2cn-0005Cr-8T; Sat, 29 Aug 2020 11:18:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id i11so1789681otr.5;
 Sat, 29 Aug 2020 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cOdozXckDxNQxCzGLFO11M9mKQ/b8CPjfYZvlO3AVEI=;
 b=Zdf4qXzYLX5+lCoHQURL6+g+n6uwOm8EJPjkyfSAPlnLxpn8BU63iiJkbHpbCYXLhJ
 pfJryXp8fO4r5Vd/ExeQx4FUkj52F09nXURnBoOv++mzh+ItKZN2gJ/9QycuW/4curL3
 0Obv6gp6Qlxr1cDXaTx4Fy4Lm5Pr+gH2Spram54Y9kuRUjsccLgvJ/ez7RsvUDkK4PFP
 CIEL6OBC3eXhhNsNhuWSDw5icj3o8TOth69L9zUDAtdzwPIurZDs9qqwlHWFtkz7LMi8
 itSkLiy5ngStrAMYh0fAgKea8s/+a6ceHXFyKDdVmOzwlWASE5htMMGinpNhpXIT6PrW
 nQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cOdozXckDxNQxCzGLFO11M9mKQ/b8CPjfYZvlO3AVEI=;
 b=Kqe6ULFOduANe5vdRrKxEWfZJch87vVIlH73L8n9ehRaVPtj7hLxO5DJVl92j3swRS
 PWUcxhFkDS82vSmcgH4/aSo1LMybypeIXd231CQLUmeDM+ZAox0+omaVPOhmVZjKEj/I
 0dBqhiKgwZZ6jTA5gHxuDnKPdMSNmukLBx6ANfgljQ8rnG2aQk5R0fzX03Nhq5/TR9fi
 QrHsLEK5Ce9rEJ2WK66nW3vASnOL/IBrpJfodbPA5oAK/WP88Go6HEQ55CNd1mk3DEEy
 qaHngiSASYOYI8mlIPnp7YXtQw6VwT7GqCq1nEl3nlGc6O33wBGVMMWEFMhlRR0ZPIkJ
 cKVw==
X-Gm-Message-State: AOAM530SM77pvKQTqtyz2GlUSSxveLh+Jy164PbdFrrip3v6IfsBtrWf
 SavmReglj6BWuZJxPAY+N3o=
X-Google-Smtp-Source: ABdhPJy+PB4+AP4v7rCq7mWVr12mo27EAK+rbD2T/NMFxVhhYr8qZAAvVzA1Nm7YN4Ry7fKdKMAJtA==
X-Received: by 2002:a9d:7186:: with SMTP id o6mr550721otj.76.1598714315910;
 Sat, 29 Aug 2020 08:18:35 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id f50sm58181otf.47.2020.08.29.08.18.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:18:35 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 08/16] hw/riscv: microchip_pfsoc: Connect a Cadence SDHCI
 controller and an SD card
Date: Sat, 29 Aug 2020 23:17:32 +0800
Message-Id: <1598714261-8320-9-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
References: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=bmeng.cn@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
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

Changes in v2:
- do not initialize TYPE_SYSBUS_SDHCI in the SoC instance_init(),
  instead move that to the cadence_sdhci model
- do not access generic-sdhci's state directly,
  instead move that to the cadence_sdhci model

 include/hw/riscv/microchip_pfsoc.h |  4 ++++
 hw/riscv/microchip_pfsoc.c         | 23 +++++++++++++++++++++++
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 28 insertions(+)

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
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index cee959a..0b2e9ca 100644
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
index ceb7c16..7412db9 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -55,3 +55,4 @@ config MICROCHIP_PFSOC
     select SIFIVE
     select UNIMP
     select MCHP_PFSOC_MMUART
+    select CADENCE_SDHCI
-- 
2.7.4


