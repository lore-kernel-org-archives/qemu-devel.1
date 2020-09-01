Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CFDC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC12120707
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmPKbgOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC12120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCvNE-0004jZ-Tc
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 21:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvI0-0004XI-Nk; Mon, 31 Aug 2020 21:40:48 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvHy-0005ZR-QT; Mon, 31 Aug 2020 21:40:48 -0400
Received: by mail-pg1-x544.google.com with SMTP id l191so1761439pgd.5;
 Mon, 31 Aug 2020 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vnuiw/muM6soC9Fx9pcU+x5ClmS6jV/SRavwXbyBRhw=;
 b=QmPKbgOWBmRVAfYidRDv/LGT+DnPGY+hnS6bseMZuNGbi3GiV662WlJuZCU482dUtx
 fnBX58Hiyo0QAZonX8tIZd+mBM3nzioD0HJdgvMpi/DjWsUTm+ABlKwJJxHzIAL7Z91n
 Ss47Y8qySX5jStuxmTzHwK1HtgOqRBf0BXSxxKyA/7hJjCBkRYKNBYipIWdfl7GjT8CD
 iY5de6nIISll/ysR4CYixswg2eGkYgllysEonvJ1wy/3480XRdCUusJBhugXClCA+SFL
 mtmzfXqQUGXtx3nMbOYAg+XR1yoZg6fkZ/QOPzIbT2JOg1/Hb1yxZH+v0geFj4LnKvgg
 /3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vnuiw/muM6soC9Fx9pcU+x5ClmS6jV/SRavwXbyBRhw=;
 b=GYvJv2gy54NigoNMm5rrW+uyy0A+Jm4vvCIs7MCZLziLMx3Sd4nP0/RtVkGgEb5FYz
 dalEcDBhEMgUxBN6imcIZfv3jeYvrStLKdTmrhO1pVBJdrCkgSF4KAJZmalaR46FOZei
 FDr8UJ4ebyXwUqH6dMz5Fak6D4sNAhlzmZMrTv4hBu/+Kw9AwZRxV1klX5sP5x8qtUbi
 OxOkU3QgBu6burUUbgNOe/UKClMWUXIxzvbWNAC47sjKvroxSpbUq4+XxiPq5vz07+xG
 7/UEuRqr7jql4g4NoZzdKmik0/jcnsOPRamYaeWCQwy7hMIDvQpbYyVVFLX1FRxcHP6x
 icVg==
X-Gm-Message-State: AOAM532hlS3+38M2rh9uQCWnKmaYK2qo6cShSAH+XYQtbvf6R06qKDEX
 ecEXp+gAb5ZfH6bFFWfV2Q0=
X-Google-Smtp-Source: ABdhPJwro1lybONehXhgi200UJPcI88LSpoEBRJQw9g/+cnbMQpfnZeD7P6Czb7qYehly25VoMT5Aw==
X-Received: by 2002:a05:6a00:14d0:: with SMTP id
 w16mr3642594pfu.39.1598924445035; 
 Mon, 31 Aug 2020 18:40:45 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id l13sm8887520pgq.33.2020.08.31.18.40.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 18:40:44 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 06/16] hw/riscv: microchip_pfsoc: Connect 5 MMUARTs
Date: Tue,  1 Sep 2020 09:39:01 +0800
Message-Id: <1598924352-89526-7-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x544.google.com
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

Microchip PolarFire SoC has 5 MMUARTs, and the Icicle Kit board
wires 4 of them out. Let's connect all 5 MMUARTs.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 include/hw/riscv/microchip_pfsoc.h | 20 ++++++++++++++++++++
 hw/riscv/microchip_pfsoc.c         | 30 ++++++++++++++++++++++++++++++
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 51 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 1953ef1..a5efa1d 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -22,6 +22,8 @@
 #ifndef HW_MICROCHIP_PFSOC_H
 #define HW_MICROCHIP_PFSOC_H
 
+#include "hw/char/mchp_pfsoc_mmuart.h"
+
 typedef struct MicrochipPFSoCState {
     /*< private >*/
     DeviceState parent_obj;
@@ -32,6 +34,11 @@ typedef struct MicrochipPFSoCState {
     RISCVHartArrayState e_cpus;
     RISCVHartArrayState u_cpus;
     DeviceState *plic;
+    MchpPfSoCMMUartState *serial0;
+    MchpPfSoCMMUartState *serial1;
+    MchpPfSoCMMUartState *serial2;
+    MchpPfSoCMMUartState *serial3;
+    MchpPfSoCMMUartState *serial4;
 } MicrochipPFSoCState;
 
 #define TYPE_MICROCHIP_PFSOC    "microchip.pfsoc"
@@ -64,14 +71,27 @@ enum {
     MICROCHIP_PFSOC_L2CC,
     MICROCHIP_PFSOC_L2LIM,
     MICROCHIP_PFSOC_PLIC,
+    MICROCHIP_PFSOC_MMUART0,
     MICROCHIP_PFSOC_SYSREG,
     MICROCHIP_PFSOC_MPUCFG,
+    MICROCHIP_PFSOC_MMUART1,
+    MICROCHIP_PFSOC_MMUART2,
+    MICROCHIP_PFSOC_MMUART3,
+    MICROCHIP_PFSOC_MMUART4,
     MICROCHIP_PFSOC_ENVM_CFG,
     MICROCHIP_PFSOC_ENVM_DATA,
     MICROCHIP_PFSOC_IOSCB_CFG,
     MICROCHIP_PFSOC_DRAM,
 };
 
+enum {
+    MICROCHIP_PFSOC_MMUART0_IRQ = 90,
+    MICROCHIP_PFSOC_MMUART1_IRQ = 91,
+    MICROCHIP_PFSOC_MMUART2_IRQ = 92,
+    MICROCHIP_PFSOC_MMUART3_IRQ = 93,
+    MICROCHIP_PFSOC_MMUART4_IRQ = 94,
+};
+
 #define MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT    1
 #define MICROCHIP_PFSOC_COMPUTE_CPU_COUNT       4
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index d946b2a..cee959a 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -11,6 +11,7 @@
  * 0) CLINT (Core Level Interruptor)
  * 1) PLIC (Platform Level Interrupt Controller)
  * 2) eNVM (Embedded Non-Volatile Memory)
+ * 3) MMUARTs (Multi-Mode UART)
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -38,6 +39,7 @@
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
+#include "chardev/char.h"
 #include "hw/cpu/cluster.h"
 #include "target/riscv/cpu.h"
 #include "hw/misc/unimp.h"
@@ -46,6 +48,7 @@
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/microchip_pfsoc.h"
+#include "sysemu/sysemu.h"
 
 /*
  * The BIOS image used by this machine is called Hart Software Services (HSS).
@@ -69,8 +72,13 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,     0x1000 },
     [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,  0x2000000 },
     [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,  0x4000000 },
+    [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
     [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
     [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
+    [MICROCHIP_PFSOC_MMUART1] =         { 0x20100000,     0x1000 },
+    [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
+    [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
+    [MICROCHIP_PFSOC_MMUART4] =         { 0x20106000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
     [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
@@ -215,6 +223,28 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_MPUCFG].base,
         memmap[MICROCHIP_PFSOC_MPUCFG].size);
 
+    /* MMUARTs */
+    s->serial0 = mchp_pfsoc_mmuart_create(system_memory,
+        memmap[MICROCHIP_PFSOC_MMUART0].base,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART0_IRQ),
+        serial_hd(0));
+    s->serial1 = mchp_pfsoc_mmuart_create(system_memory,
+        memmap[MICROCHIP_PFSOC_MMUART1].base,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART1_IRQ),
+        serial_hd(1));
+    s->serial2 = mchp_pfsoc_mmuart_create(system_memory,
+        memmap[MICROCHIP_PFSOC_MMUART2].base,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART2_IRQ),
+        serial_hd(2));
+    s->serial3 = mchp_pfsoc_mmuart_create(system_memory,
+        memmap[MICROCHIP_PFSOC_MMUART3].base,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART3_IRQ),
+        serial_hd(3));
+    s->serial4 = mchp_pfsoc_mmuart_create(system_memory,
+        memmap[MICROCHIP_PFSOC_MMUART4].base,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART4_IRQ),
+        serial_hd(4));
+
     /* eNVM */
     memory_region_init_rom(envm_data, OBJECT(dev), "microchip.pfsoc.envm.data",
                            memmap[MICROCHIP_PFSOC_ENVM_DATA].size,
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 3292fae..ceb7c16 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -54,3 +54,4 @@ config MICROCHIP_PFSOC
     select HART
     select SIFIVE
     select UNIMP
+    select MCHP_PFSOC_MMUART
-- 
2.7.4


