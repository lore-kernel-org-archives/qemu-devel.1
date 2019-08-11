Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D1DC433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461CE208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEw831NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461CE208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwiwF-0006OX-Ie
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60328)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisw-0006Bm-H8
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisv-00041I-BH
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:26 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwisv-00040j-5O; Sun, 11 Aug 2019 04:07:25 -0400
Received: by mail-pg1-x542.google.com with SMTP id l21so47976335pgm.3;
 Sun, 11 Aug 2019 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=Liiru73AsCPuGWNyj7I+c2HQEgE/OxfRhCFP31cqwAM=;
 b=iEw831NQCs2iSulaco7MFdykD+LCQ+fE18IUH2Mz5PWOzTO8/GZOtANxmr2H824nJ0
 xGk8pFvYqGzwWOgV9A6/ZEJBbqLBfssGQmZ9CBOAawbAcXIY1gLHgfFCVecVIB+NsIri
 Ju/K8oXAofQ2GMbVyzXFkSGJ5xcynUyW9uyiwkxwIKz4QU2W1+TkaBE57yja2zxexBY7
 9AzE/Hyb6yA5SPjQ9uOtROZ+2e+OHU2XFE6iwuXIqBvq9wEQvmvDCL/pkCX5U4oseMqY
 8vuSOtxnU/9JmolUrFdBDjUhQ4YiRd1mloaOVx7cM4G5K4DTzlYn16k7AzoT6FI1vMW1
 B/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=Liiru73AsCPuGWNyj7I+c2HQEgE/OxfRhCFP31cqwAM=;
 b=Ew0CeljdjO9AJSvddusvWqwqfnIrz6mV4RkvkTE+513pX5X5sR9KQptf2taef57q7F
 /0x9KCQmix2vtcsFvJXQGxKhA+Febqh3s3Y4KSlgNihI0UcTs7KPztdx82gyrG/CoubT
 pZbdfSABhfb4JAIj7urRpxxw8qPy/W2C0feaCEY0oUf+rc8dU9zkrVf46zFO4jiKNUHD
 dJVzYxedPF8mUP6HKJk05PrGwCuILMKthfCflADTqGYaiDRatFfssBd63tS8jXuk5y6x
 qRtd3gLFoTlN1eerlzniGKewDIin7HOxaK97To/rjzodTka6eEFuYaJQA6XRofXCVJfe
 /meg==
X-Gm-Message-State: APjAAAUDQlwGcQz5xjHodIB/pUoQvFT/BQG4eOErF0zVXxg63D4LL8WW
 KO+9jvOKyTLsgVTsPuzEG36I8PFK
X-Google-Smtp-Source: APXvYqzaidwL3pE3041tSxuygBxRm+KQkLrvTOzCv4pDrYQ3vzlmbYPqafV22Z9aLsP8wwWcfpTXtg==
X-Received: by 2002:a65:690f:: with SMTP id s15mr24513993pgq.432.1565510844344; 
 Sun, 11 Aug 2019 01:07:24 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.23
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:23 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:49 -0700
Message-Id: <1565510821-3927-17-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3 16/28] riscv: sifive_u: Add PRCI block to
 the SoC
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add PRCI mmio base address and size mappings to sifive_u machine,
and generate the corresponding device tree node.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
 include/hw/riscv/sifive_u.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f2b711a..c0b7498 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -9,6 +9,7 @@
  * 0) UART
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
+ * 3) PRCI (Power, Reset, Clock, Interrupt)
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -42,6 +43,7 @@
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_u.h"
+#include "hw/riscv/sifive_u_prci.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
@@ -60,6 +62,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
+    [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
@@ -76,7 +79,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint32_t *cells;
     char *nodename;
     char ethclk_names[] = "pclk\0hclk\0tx_clk";
-    uint32_t plic_phandle, ethclk_phandle, phandle = 1;
+    uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
@@ -183,6 +186,21 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
+    prci_phandle = phandle++;
+    nodename = g_strdup_printf("/soc/clock-controller@%lx",
+        (long)memmap[SIFIVE_U_PRCI].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", prci_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x1);
+    qemu_fdt_setprop_cells(fdt, nodename, "clocks",
+        hfclk_phandle, rtcclk_phandle);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[SIFIVE_U_PRCI].base,
+        0x0, memmap[SIFIVE_U_PRCI].size);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+        "sifive,fu540-c000-prci");
+    g_free(nodename);
+
     plic_phandle = phandle++;
     cells =  g_new0(uint32_t, s->soc.cpus.num_harts * 4 - 2);
     for (cpu = 0; cpu < s->soc.cpus.num_harts; cpu++) {
@@ -422,6 +440,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+    sifive_u_prci_create(memmap[SIFIVE_U_PRCI].base);
 
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
         plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 2b57ffc..e318ecb 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -51,6 +51,7 @@ enum {
     SIFIVE_U_MROM,
     SIFIVE_U_CLINT,
     SIFIVE_U_PLIC,
+    SIFIVE_U_PRCI,
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
     SIFIVE_U_DRAM,
-- 
2.7.4


