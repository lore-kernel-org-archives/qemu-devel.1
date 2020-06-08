Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD59C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DC02053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4/hogD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DC02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIiv-0004QO-Ng
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIba-0001Ca-RV; Mon, 08 Jun 2020 10:18:26 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbZ-0004Uz-Kp; Mon, 08 Jun 2020 10:18:26 -0400
Received: by mail-pf1-x441.google.com with SMTP id h185so8613698pfg.2;
 Mon, 08 Jun 2020 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6Wqt96NR0n/waWEiKSwOGDZAUFOrfX8hwcz3Fr4yuQs=;
 b=g4/hogD6Yh9IvdPBpael8gj0JYEAMGs3+nHk2zxjNDQJHMYBUhZppBpLuWrev/ZxRy
 u1c0tQnbV51F57Ktzgg90/fYu3BUMfIl9XzY/Xk1gczIbOKGRdFvRH5xBAxiOJJ+8YNt
 wpfuzQnPrs//QvYyLN3fofNvVmysGgJ1+7a5hpriDCEDZMJ76LAtVg9EVRUCN4F9vVx8
 R7yZ1iCh9M5qslxPsCXIwrwE9BWut5tb3tPW8BqLJCP3pN385Fajxr1g8ArXyv03TX5s
 HPjEsMUGIlGyXlS0k/m//pRtAViJdVt4FWJCv7LWskELka6gC828e+h0iRjvaVqrddx3
 Vjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6Wqt96NR0n/waWEiKSwOGDZAUFOrfX8hwcz3Fr4yuQs=;
 b=mcwOFpD0+GYUjZtXxSF8X70wgc4x2FKvFpXbuLEXJ1MFNjOiE1EyEpDbzdkpKhncEz
 zwIODvw8HbUfMYbCbY2vB5QIveVSJFb6fyit3PKvcKBHP60E9EJZbPxsB652IT2NgDZC
 6KKog67ANeIbu0Rs/1PAOkvK0G2xGkVL2KE4f4cFi8pm6R+qB+OG/LYEyhzZpUFtAtnw
 +/bIpEYyoSspHdOkJAM43s1c8Mr8lN+jY6GQIW361mEkCfH+q6NlPujRFOmclb7d8Ta7
 gG/arBL3lAAMvvLTrDeKhff20WJxv4X3VmZX/zdprG8524HqMXJnvL5UsvZYbN5qtkkO
 qGRw==
X-Gm-Message-State: AOAM5311PSxLcNENmlHkTzjJ6a7NqlYUkeGCb8+scMAGttfUSm/ok4mA
 M/jfY8yCeLWIgb+T8gGlmfQ=
X-Google-Smtp-Source: ABdhPJwlxh3b9ZGuN7SJH62dQ5w1uiBCuExEPZzfw2ZgLPfrxicYFxiTahgg1T0OtNPBaRmZxJqksQ==
X-Received: by 2002:a62:e40b:: with SMTP id r11mr14240001pfh.265.1591625904092; 
 Mon, 08 Jun 2020 07:18:24 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.23
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:23 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 07/15] hw/riscv: sifive_u: Hook a GPIO controller
Date: Mon,  8 Jun 2020 07:17:36 -0700
Message-Id: <1591625864-31494-8-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

SiFive FU540 SoC integrates a GPIO controller with 16 GPIO lines.
This hooks the exsiting SiFive GPIO model to the SoC, and adds its
device tree data as well.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_u.c         | 44 ++++++++++++++++++++++++++++++++++++++++++--
 include/hw/riscv/sifive_u.h | 19 +++++++++++++++++++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 8dc6842..881949b 100644
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
@@ -525,6 +549,8 @@ static void sifive_u_soc_instance_init(Object *obj)
 
     sysbus_init_child_obj(obj, "prci", &s->prci, sizeof(s->prci),
                           TYPE_SIFIVE_U_PRCI);
+    sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
+                          TYPE_SIFIVE_GPIO);
     sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
                           TYPE_SIFIVE_U_OTP);
     sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
@@ -618,6 +644,20 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
 
+    qdev_prop_set_uint32(DEVICE(&s->gpio), "ngpio", 16);
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
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
     object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 16c297e..dcf7f3b 100644
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
 
-- 
2.7.4


