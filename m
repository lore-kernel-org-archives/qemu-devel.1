Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033AEC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43F120651
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1OFREqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43F120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufXT-0000BE-3m
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58539)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPk-0000gX-Lm
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPi-0002y1-S1
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:48 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPi-0002xI-64; Mon, 05 Aug 2019 12:00:46 -0400
Received: by mail-pf1-x442.google.com with SMTP id i189so39874815pfg.10;
 Mon, 05 Aug 2019 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=UOGQihbkCSuXF1N9Rsgla60y4gUdIYOL+L4Hkd4525A=;
 b=t1OFREqXq/VKpM0rN0lmTexaUcgdDcKmhEfFVoksZ11zyc4yIV4avHFJa1O7HbWP1F
 oyvB95z+McuzWC2+yzY4tgLQxir2RBUAjAYz35qj/S8fOAHs5ddj9JVutRzNnO019GqJ
 CuY7OGQV8bSCj2AhiJmYy9ybSw2UCL9L7VdZcrh0YjjMthwX2XN87mXYZGJJOKNV0VuB
 iJ5B4aE1xcTZ73Ba1HKmpOafFTU98oIB2YPxsp+dEgcNPGSjtHHSn+3/PV+W7zFg4O8q
 wjNtC5j4G1apU35V9o+U9IkjHXLjuqkSyPBVjrSau7iMDt59eQa7J8mwcpI5FlVcRFuB
 4TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=UOGQihbkCSuXF1N9Rsgla60y4gUdIYOL+L4Hkd4525A=;
 b=Is/n59i2O7au0l99kT38Zwf4k3C9gwYERmzhXPppsv/1eHTmyg+5P5cSPt6qSoftmM
 nr67EAK1FE4DCRKxt/ocmIUliG9WJFbqnYk8ScZ35JFTXkHwkT1XDNxHzryt9cWTMUP2
 m+aWIkjS1TVI1pyYT/CAkLdIG91QvK9ea5pLDvL2Cy7pH6qmYSWod//JLptChjmLdKgo
 jQmOep5hXlEbty9ViEKXXdL/ICs7aX4kwGVf/uB+6uDq6TfQvHXcyN8xThA9OqGr/0tF
 oh4wNh7DBZq7cxo7CdtoADD24iZUUKx42f6HpErcV66jQsFKnnaxorAnubs7yvvPCpVI
 nFYg==
X-Gm-Message-State: APjAAAU71381s30H5twGY549kn0E4pXmqOdap2I5Fh+5HRr6qaYPNnLg
 uspSEQBMBBA9s0PvPHGARIM=
X-Google-Smtp-Source: APXvYqxCQnRQ3yYE1MnKN+MOHVP8iEEiVTbmX61ZwgMMhOLPGxUBdg6mgRD193NUbiXuBNnXAlhxAw==
X-Received: by 2002:a63:4a0d:: with SMTP id x13mr10229312pga.75.1565020845215; 
 Mon, 05 Aug 2019 09:00:45 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.44
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:44 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:11 -0700
Message-Id: <1565020823-24223-17-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 16/28] riscv: sifive_u: Add PRCI block to the
 SoC
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

 hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
 include/hw/riscv/sifive_u.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f619ca6..20dee52 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -9,6 +9,7 @@
  * 0) UART
  * 1) CLINT (Core Level Interruptor)
  * 2) PLIC (Platform Level Interrupt Controller)
+ * 3) PRCI (Power, Reset, Clock, Interrupt)
  *
  * This board currently uses a hardcoded devicetree that indicates five harts.
  *
@@ -41,6 +42,7 @@
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_u.h"
+#include "hw/riscv/sifive_u_prci.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
@@ -59,6 +61,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
+    [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
@@ -75,7 +78,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint32_t *cells;
     char *nodename;
     char ethclk_names[] = "pclk\0hclk\0tx_clk";
-    uint32_t plic_phandle, ethclk_phandle, phandle = 1;
+    uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
@@ -182,6 +185,21 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
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
@@ -421,6 +439,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+    sifive_u_prci_create(memmap[SIFIVE_U_PRCI].base);
 
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
         plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index bacd60f..19d5a6f 100644
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


