Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B72FC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4313720707
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tnc9P0KP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4313720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCvLH-0000xx-EQ
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 21:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvIR-0005Kc-Ni; Mon, 31 Aug 2020 21:41:15 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvIO-0005dC-2Z; Mon, 31 Aug 2020 21:41:15 -0400
Received: by mail-pg1-x541.google.com with SMTP id g29so1768409pgl.2;
 Mon, 31 Aug 2020 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7R2QHjsRNu1SOw4Rj8O1LUx16kxOsEkbJPfU0SAk6Zs=;
 b=Tnc9P0KPWQGUwbKUnxq0wv+hY7Khbq2U/0rqUYrRsIs1o4JWVbGkOMppRAcDPQqrTu
 nBPU8Ka4qhre+Dwas+E6DP1rwh/HAKjg2D+gGDIRukuoxIDlqpvi0qMOHrO/IDte2y9x
 fuxE3ypNY6CwtZ+R2DAdBsLznaEwDxnKCfIOSdw+3k5YDcLaXIjE9AqTK3HTXU9xrcUD
 yi1f6wou/4u2BEpNY3j9chAnQRIrkI+pTSkOK8HzyPcqjjwLmCIHpQwwY2f8IROPzv64
 9zVXiHkHBln4qA7JvsysIohLVrG5jMSIbOus6Vfn8Bo/K7t1RYn/oCtbvhwbzdKhOudS
 m2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7R2QHjsRNu1SOw4Rj8O1LUx16kxOsEkbJPfU0SAk6Zs=;
 b=JB1kwr8Ah6l+rpGSsUrgaUiWPNlwgvBXI5aRb8OwDTND/OC9M0n/n8zgiFqVd85XEz
 zNhFRRqvCuflCPMFJg7d+V8UtF8QVWklLwqXClpwGViPK/u0duDfRn1Ux9dZMugb1zKs
 EaWwxFpzs0SUVP1OrWerrf7hqngF1O+l5IK21SWrDjbzoB74E5n6ociCB6qOS7AWY9J9
 xQ5Ug7DUc+wICbCNiYxXraVI6tOur99uW1ethwy59DCNkK0gCmUzRVSYKzQWwqvmPS6R
 uwPf4DtYUrZV+ZT6EEMWOuhN14XhYmUYE2C64Z3s5rdyujV/nwUEQZVeeeqbsOjniM36
 bFoA==
X-Gm-Message-State: AOAM5329i3DpFIyEbveH9x0AE+oHXTQBayX/I7v2G6jLn6CxmcH4bqrg
 EuTSXryboea+N+9EClDc5cQ4zM7ZtIE=
X-Google-Smtp-Source: ABdhPJzXtL+845F1EF8sUj7hoSS3+Bi3AsUngRZ6brGLLNCv7N59eGgjhidsfHZ5r19t/PhV9cxETA==
X-Received: by 2002:a63:df12:: with SMTP id u18mr3398980pgg.98.1598924470346; 
 Mon, 31 Aug 2020 18:41:10 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id l13sm8887520pgq.33.2020.08.31.18.41.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 18:41:09 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 13/16] hw/riscv: microchip_pfsoc: Connect 2 Cadence GEMs
Date: Tue,  1 Sep 2020 09:39:08 +0800
Message-Id: <1598924352-89526-14-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x541.google.com
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

Microchip PolarFire SoC integrates 2 Candence GEMs to provide
IEEE 802.3 standard-compliant 10/100/1000 Mbps ethernet interface.

On the Icicle Kit board, GEM0 connects to a PHY at address 8 while
GEM1 connects to a PHY at address 9.

The 2nd stage bootloader (U-Boot) is using GEM1 by default, so we
must specify 2 '-nic' options from the command line in order to get
a working ethernet.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 include/hw/riscv/microchip_pfsoc.h |  7 +++++++
 hw/riscv/microchip_pfsoc.c         | 39 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 63e7860..6d20853 100644
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
index d8ec973..7f25609 100644
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
2.7.4


