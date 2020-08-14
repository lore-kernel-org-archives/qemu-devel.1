Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF49C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165C32078D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGrfVYdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165C32078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ctj-00050e-Cd
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6clo-0007P4-Ew; Fri, 14 Aug 2020 12:41:32 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:50235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6clm-0002eq-Gn; Fri, 14 Aug 2020 12:41:32 -0400
Received: by mail-pj1-x1042.google.com with SMTP id e4so4673813pjd.0;
 Fri, 14 Aug 2020 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mdPr+L46xcY0jrrcKDo2FpIIhtgmjgb2ImLyVvpn5I0=;
 b=bGrfVYdS4RZKNXSI0PR7SvLA9DfAvXyFZk3+z9Jo2r2EnbteF+fTd6PpJBV7/skFaT
 y2mZr3eYT2rQQMF6tCLqujLFfcDuwGQoWOYFL99xXz2qP2tF7ov1HoKu5IecCwaXziPs
 5Db/Hp3RiIg/XvPdjetA6jt6OpH1ucOj5P9OciB2PXt8UWhC7Ml3KqdfcHbE5N/XrPbV
 ZqU6wJEmtX8QOnVGBhGmXxgtxwnY1UQOKBX5nUTaOLVXDOP9y/9yUztS1OQO2nCG2atx
 ai1r2m3pWnH2PbozlsrDrEfJ26q1/S04Xc+e2+Ei3MUVew31aPQ/qjz9KI5sy9OMzph+
 /oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mdPr+L46xcY0jrrcKDo2FpIIhtgmjgb2ImLyVvpn5I0=;
 b=mttaKykV76oibZoAGkBx756b9atIcJ2z7eWqXURidEsIRW2Fjdn8TpYZLZBORpg5he
 3JOaM5hNya3FMexVcKKc8RyDpSByQpa6VK+cCVh72r1U8j/zkhezoVjRjAM07YsCd1fG
 Od3XHPYeFdP9iqoBi+U6TBzQhmj9oeJ3BE72DWjgdTvOdRnFNEce2T90fnmB8YpUNAvX
 yAlGc4tx3dKqgfm+qfiqZHlnl8xkPkNyrT/q4IZJkbWnOG4MteCy5WjYhnvEsvG4Xh3p
 7yLIzY2NLOUXneZPI+/T1nmjeHpMrHzeti8vAXqVKAUu7LIXfUDjh5wcnapxD0GDpae2
 2CtQ==
X-Gm-Message-State: AOAM531fJqnQMmP2m5XoCZZlRrN8nZStJrN2jX3bPEQSxplczKn6PyiD
 h5L/F7RWKdJtXTdTeR7eMsg=
X-Google-Smtp-Source: ABdhPJxsGKDTIr3altxRnkUBZIH8CLyKEX3TEsiEYEk5iXzBSoLq+mmyEJzcxEhlVCoyIqpHoz25wQ==
X-Received: by 2002:a17:90b:2388:: with SMTP id
 mr8mr3202035pjb.64.1597423288857; 
 Fri, 14 Aug 2020 09:41:28 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id 16sm9836332pfi.161.2020.08.14.09.41.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:41:28 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 06/18] hw/riscv: microchip_pfsoc: Connect 5 MMUARTs
Date: Sat, 15 Aug 2020 00:40:44 +0800
Message-Id: <1597423256-14847-7-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Microchip PolarFire SoC has 5 MMUARTs, and the Icicle Kit board
wires 4 of them out. Let's connect all 5 MMUARTs.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/Kconfig                   |  1 +
 hw/riscv/microchip_pfsoc.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/riscv/microchip_pfsoc.h | 20 ++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 3292fae..ceb7c16 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -54,3 +54,4 @@ config MICROCHIP_PFSOC
     select HART
     select SIFIVE
     select UNIMP
+    select MCHP_PFSOC_MMUART
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 20a642c..f6b375c 100644
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
 
-- 
2.7.4


