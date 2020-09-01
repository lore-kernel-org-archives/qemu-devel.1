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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EA8C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82BF2098B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tML274Fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82BF2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCvO5-0006FM-3h
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 21:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvIb-0005WK-3x; Mon, 31 Aug 2020 21:41:25 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvIZ-0005ft-7I; Mon, 31 Aug 2020 21:41:24 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mm21so874626pjb.4;
 Mon, 31 Aug 2020 18:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1beGznQG533V78BCqqj/QrYnc/FOqiQEqa+BFrJTWkg=;
 b=tML274FxmYmzPs57vWI0ZjzscwgVST/k4Igr5Ar7l4QhkhotRuAz+kUX1Jvg21D2Ag
 KnU0SDRwENQJ8S7XBODSkI9OfD71MXjRYwFNt5uFbC8gXdORnh88n0FH4APSnXJRAgFi
 Uk4Q/jm9AVRd13vsRHGMOsJjVT6JjEFJxdYZvZgI4BDi8ECgJ9n/GzeAXAoYdIe8yUgV
 2p3Es14UwZWOTLJa2zNuu1K5k/9Pb2XZPy06OpO9/dQbxlIXUDRnGCkRqKt6oshC41I9
 o1aE/Pau7oHqyX1hbz4Q5ITR3FOdYkw2X39URsM0p76wdi/CDUXsAr77IWEmj7sJRq/L
 DFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1beGznQG533V78BCqqj/QrYnc/FOqiQEqa+BFrJTWkg=;
 b=qM9gZVGqbal/t5zVVEUQtIVpBzdz4CrEfJUf3aaTFlShdbGyGYIX3ThtIiW6x08ypB
 O9fWfBrLxshgsb0h3OAS+OKn7giLH3qAKFs+sAl9y1kaML44Fd+e0D64Idrbru4IpqH8
 qhjrOK6CUnhynfBLQ+59dVXx5dKSUwVrqh04qJwEeo3dqJH96klVjtAvpFEO2IRAYrhY
 bx14PpkdTBboA9MrYVdK3MDP8wVPyO/o2iNoGL1SMMBtPx7PQI0KbQE8QH3eW6gcr8a5
 vzCE9n5zHsuUIW5y5iLRfDtJnZTgBXw8PLX4kozXXVwNcRHdAZvEtigF9E7CjjYX6s4S
 xYPA==
X-Gm-Message-State: AOAM531jMNVI+Jka0Mc/CYxdkXXudw3DWc6BXa6GlWJnCJqrAax2eJ98
 j5ka4JDJ0Uwd80lINmTN+OxrrYL48+M=
X-Google-Smtp-Source: ABdhPJz2yz/2SOnBSJ/FXsnwqel7F8D1RlmAqdL+adiMPosXnIvv3BnoC9P4zA2DHPwBmC34M/QdTg==
X-Received: by 2002:a17:90a:cd06:: with SMTP id
 d6mr1922910pju.202.1598924480516; 
 Mon, 31 Aug 2020 18:41:20 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id l13sm8887520pgq.33.2020.08.31.18.41.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 18:41:20 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 16/16] hw/riscv: sifive_u: Connect a DMA controller
Date: Tue,  1 Sep 2020 09:39:11 +0800
Message-Id: <1598924352-89526-17-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1041.google.com
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

SiFive FU540 SoC integrates a platform DMA controller with 4 DMA
channels. This connects the exsiting SiFive PDMA model to the SoC,
and adds its device tree data as well.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

(no changes since v1)

 include/hw/riscv/sifive_u.h | 11 +++++++++++
 hw/riscv/sifive_u.c         | 30 ++++++++++++++++++++++++++++++
 hw/riscv/Kconfig            |  1 +
 3 files changed, 42 insertions(+)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index d3c0c00..793000a 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -19,6 +19,7 @@
 #ifndef HW_SIFIVE_U_H
 #define HW_SIFIVE_U_H
 
+#include "hw/dma/sifive_pdma.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_cpu.h"
@@ -43,6 +44,7 @@ typedef struct SiFiveUSoCState {
     SiFiveUPRCIState prci;
     SIFIVEGPIOState gpio;
     SiFiveUOTPState otp;
+    SiFivePDMAState dma;
     CadenceGEMState gem;
 
     uint32_t serial;
@@ -72,6 +74,7 @@ enum {
     SIFIVE_U_MROM,
     SIFIVE_U_CLINT,
     SIFIVE_U_L2CC,
+    SIFIVE_U_PDMA,
     SIFIVE_U_L2LIM,
     SIFIVE_U_PLIC,
     SIFIVE_U_PRCI,
@@ -108,6 +111,14 @@ enum {
     SIFIVE_U_GPIO_IRQ13 = 20,
     SIFIVE_U_GPIO_IRQ14 = 21,
     SIFIVE_U_GPIO_IRQ15 = 22,
+    SIFIVE_U_PDMA_IRQ0 = 23,
+    SIFIVE_U_PDMA_IRQ1 = 24,
+    SIFIVE_U_PDMA_IRQ2 = 25,
+    SIFIVE_U_PDMA_IRQ3 = 26,
+    SIFIVE_U_PDMA_IRQ4 = 27,
+    SIFIVE_U_PDMA_IRQ5 = 28,
+    SIFIVE_U_PDMA_IRQ6 = 29,
+    SIFIVE_U_PDMA_IRQ7 = 30,
     SIFIVE_U_GEM_IRQ = 0x35
 };
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 2bc3992..7997537 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -14,6 +14,7 @@
  * 4) GPIO (General Purpose Input/Output Controller)
  * 5) OTP (One-Time Programmable) memory with stored serial number
  * 6) GEM (Gigabit Ethernet Controller) and management block
+ * 7) DMA (Direct Memory Access Controller)
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -73,6 +74,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_MROM] =     {     0x1000,     0xf000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_L2CC] =     {  0x2010000,     0x1000 },
+    [SIFIVE_U_PDMA] =     {  0x3000000,   0x100000 },
     [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
@@ -303,6 +305,22 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "gpio-restart");
     g_free(nodename);
 
+    nodename = g_strdup_printf("/soc/dma@%lx",
+        (long)memmap[SIFIVE_U_PDMA].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "#dma-cells", 1);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
+        SIFIVE_U_PDMA_IRQ0, SIFIVE_U_PDMA_IRQ1, SIFIVE_U_PDMA_IRQ2,
+        SIFIVE_U_PDMA_IRQ3, SIFIVE_U_PDMA_IRQ4, SIFIVE_U_PDMA_IRQ5,
+        SIFIVE_U_PDMA_IRQ6, SIFIVE_U_PDMA_IRQ7);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[SIFIVE_U_PDMA].base,
+        0x0, memmap[SIFIVE_U_PDMA].size);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                            "sifive,fu540-c000-pdma");
+    g_free(nodename);
+
     nodename = g_strdup_printf("/soc/cache-controller@%lx",
         (long)memmap[SIFIVE_U_L2CC].base);
     qemu_fdt_add_subnode(fdt, nodename);
@@ -627,6 +645,7 @@ static void sifive_u_soc_instance_init(Object *obj)
     object_initialize_child(obj, "otp", &s->otp, TYPE_SIFIVE_U_OTP);
     object_initialize_child(obj, "gem", &s->gem, TYPE_CADENCE_GEM);
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_SIFIVE_GPIO);
+    object_initialize_child(obj, "pdma", &s->dma, TYPE_SIFIVE_PDMA);
 }
 
 static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
@@ -730,6 +749,17 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
                                             SIFIVE_U_GPIO_IRQ0 + i));
     }
 
+    /* PDMA */
+    sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0, memmap[SIFIVE_U_PDMA].base);
+
+    /* Connect PDMA interrupts to the PLIC */
+    for (i = 0; i < SIFIVE_PDMA_IRQS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->dma), i,
+                           qdev_get_gpio_in(DEVICE(s->plic),
+                                            SIFIVE_U_PDMA_IRQ0 + i));
+    }
+
     qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
         return;
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 9032cb0..e53ab1e 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -22,6 +22,7 @@ config SIFIVE_U
     select CADENCE
     select HART
     select SIFIVE
+    select SIFIVE_PDMA
     select UNIMP
 
 config SPIKE
-- 
2.7.4


