Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7344CC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456A92173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUJrLX+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456A92173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT8R-0000cx-A0
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39508)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hoT87-00085y-Oi
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hoT86-00022B-Ln
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:40:59 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1hoT80-0001xx-1D; Fri, 19 Jul 2019 09:40:52 -0400
Received: by mail-pg1-x541.google.com with SMTP id n9so8271851pgc.1;
 Fri, 19 Jul 2019 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6dyCplzXwUw8GtWTsKy07/e6mMRhjIeVbz3Ym+eYJ7o=;
 b=nUJrLX+E8mbBqhE87aseiOzt4TEcDuBFYdWzreDP53UxGwu+FyVRqaPiVwwPosiKYc
 rorzrq1VTvQfAvkuAV5DbuK7kvguCFLJpR1fzJFWAM5tSOhgDUUhtMcuhkunZoyIapcJ
 zD6n38xyLRKjQZptOEDtRoDF8vg8Uja8s9Fhc2luqv4lEjWrbB2sPIMx28gYxE2R7kba
 K+ylqvQTWRv6pNJQmvEkPzJ5mTqAkjSLTZjNN4Pn+4UOVYi5oY9QCr5SkWfj3dZDcGfK
 iPMT+w6hmH5H1XAwV/Pvf2B3uhSpVXJBcif4tISp+AuymOhGk6Q3DycYr6JRrhxeHilY
 W0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=6dyCplzXwUw8GtWTsKy07/e6mMRhjIeVbz3Ym+eYJ7o=;
 b=MPgoTi6maZZGMaR0NaeBaU11pdkz3yBoarj8l6VYIXoIFJY62wnV/QnkrB+56DzisM
 WbrRd5MmOCKW+y85+XPFOO7YK0+VxWyjcqElUH6hdG5zmNNjFT70OrCQC9Yqv6c7A9Gj
 BE9Id5N+v6/prr/enVgW2azQbBJiSprwSWtKqf8CcFwDSywNj+1MYdPbVCpexyG0QGMw
 oHO4mmYHaFHGie2DrgY44/HC7Mx/uvpOA2GwcipDLzPUfPa95ldu/6eRF0vIZFbjgCKj
 faohLFu45iKvvrZl8pOGJ1AYUBBUykt0Jj/YQ/bbWmdavlGn+JRdMo7bHyUOni4ejYCH
 axLw==
X-Gm-Message-State: APjAAAVCRWSoXvDmGl+mpdTcaETUMgySrbmABG/fpP0PDb176R9ePFY9
 jeQeB7NA6PksbzO18X8Qwrk=
X-Google-Smtp-Source: APXvYqwi2529KKBlsVJlA21hlm4yA+/HXdBSEZZnxb+Sl44BLOUlMr42YGRpsrIuRE/75/r//v2t9A==
X-Received: by 2002:a65:4509:: with SMTP id n9mr1210613pgq.133.1563543650268; 
 Fri, 19 Jul 2019 06:40:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id p65sm30919298pfp.58.2019.07.19.06.40.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 06:40:49 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Palmer Dabbelt <palmer@sifive.com>
Date: Fri, 19 Jul 2019 06:40:44 -0700
Message-Id: <1563543645-20804-2-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563543645-20804-1-git-send-email-linux@roeck-us.net>
References: <1563543645-20804-1-git-send-email-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 2/3] riscv: sivive_u: Add dummy serial clock
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/riscv/sifive_u.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0657046..5a221c6 100644
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
2.7.4


