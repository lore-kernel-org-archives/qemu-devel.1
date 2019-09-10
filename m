Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0933ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AD620863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AD620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xxo-00012Y-2K
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvc-0007HT-Qg
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7xvb-0006MF-7A
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7xva-0006Lk-Vb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:24:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id p13so2379741wmh.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 01:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=RB+TBC/eDyniAgGIqcf+2M7pyLD6M6TaKIyqIzJhdOQ=;
 b=hJAlVCArYAZqSdEaa9TuRwO91WMjb04xVHeZ/Stg01lzH9qxvBMVT4doZ3hHPbiEgC
 dFa/rBW6sXrQSNTenkndhc8/KbMSrGHDRBaDdW49Yhj1Mr1Olfva3tBZtFg4c2IahEAy
 vB3FN43YyDsO88fG3Bkw8LIE7vKDMyAbbAXtql39jWWk2iVGA8zrydwFHzqQqFIvHTUE
 3pqCH0VFNuw+t9Fr2xsKQNztUcWrSUo9pjvrO9x7onfQFvR8twu9MePmuyeYEZQpGPUV
 zLO5dkPsSm/tBBcYEcn/6omOrzZbHvthHQE0jVcBpjzInBYtOr069mOZCB7mcikwjh7f
 SWnw==
X-Gm-Message-State: APjAAAX1rw+0hk9jc6sm9yrVfN1Jk82/UVDs/DNWrqmBB2CFApdB1tiQ
 XiINkVIRoAfyRzpMn7nixUN3bw==
X-Google-Smtp-Source: APXvYqwMJq2ZGOLRVq2vkIEgg4im4zUBVXhKTifiNXRD0yIAGYhs3GOxJ/v+mB2VQ0/zZ6H+sQ0O7g==
X-Received: by 2002:a7b:ce0e:: with SMTP id m14mr2960016wmc.138.1568190277775; 
 Wed, 11 Sep 2019 01:24:37 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id b16sm31794804wrh.5.2019.09.11.01.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 01:24:37 -0700 (PDT)
Date: Tue, 10 Sep 2019 12:04:28 -0700
Message-Id: <20190910190513.21160-3-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
References: <20190910190513.21160-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: [Qemu-devel] [PULL 02/47] riscv: sivive_u: Add dummy serial clock
 and aliases entry for uart
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

The riscv uart needs valid clocks. This requires a refereence
to the clock node. Since the SOC clock is not emulated by qemu,
add a reference to a fixed clock instead. The clock-frequency
entry in the uart node does not seem to be necessary, so drop it.

In addition to a reference to the clock, the driver also needs
an aliases entry for the serial node. Add it as well.

Without this patch, the serial driver fails to instantiate with
the following error message.

sifive-serial 10013000.uart: unable to find controller clock
sifive-serial: probe of 10013000.uart failed with error -2

when trying to boot Linux.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 32167d05a1..8313f2605e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -76,6 +76,7 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     char *nodename;
     char ethclk_names[] = "pclk\0hclk\0tx_clk";
     uint32_t plic_phandle, ethclk_phandle, phandle = 1;
+    uint32_t uartclk_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -226,6 +227,17 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg", 0x0);
     g_free(nodename);
 
+    uartclk_phandle = phandle++;
+    nodename = g_strdup_printf("/soc/uartclk");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
+    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
+    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 3686400);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", uartclk_phandle);
+    qemu_fdt_setprop_cell(fdt, nodename, "linux,phandle", uartclk_phandle);
+    uartclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
+    g_free(nodename);
+
     nodename = g_strdup_printf("/soc/uart@%lx",
         (long)memmap[SIFIVE_U_UART0].base);
     qemu_fdt_add_subnode(fdt, nodename);
@@ -233,8 +245,7 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_UART0].base,
         0x0, memmap[SIFIVE_U_UART0].size);
-    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
-                          SIFIVE_U_CLOCK_FREQ / 2);
+    qemu_fdt_setprop_cells(fdt, nodename, "clocks", uartclk_phandle);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
     qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_UART0_IRQ);
 
@@ -243,6 +254,10 @@ static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     if (cmdline) {
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
+
+    qemu_fdt_add_subnode(fdt, "/aliases");
+    qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
+
     g_free(nodename);
 
     return fdt;
-- 
2.21.0


