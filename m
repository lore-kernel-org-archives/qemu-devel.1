Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B78BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599E42076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYJNglEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599E42076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIhK-0001oL-Il
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbe-0001Id-6y; Mon, 08 Jun 2020 10:18:30 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbd-0004VY-5Y; Mon, 08 Jun 2020 10:18:29 -0400
Received: by mail-pj1-x1042.google.com with SMTP id i4so2032471pjd.0;
 Mon, 08 Jun 2020 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pLYt1l6HE7pnximoWhPblRl1OWyG0USlCkJuRGmgiG0=;
 b=JYJNglEi+RILuDsch/jvSy+OH4uxI7l25tNe/YfZ2ibOpHNpYrBiPV9GS7kSHSwBc2
 Ic0L/Jd+CJM1E1igq4t7ubdz8W1ezGw3SBt74G9cWkxcopjSnse1e0ynMB0mwFmgqaEW
 0d2mT8sPUaqgynJu0blyjYaUUmzCGQnf0lsI8c42ArSIvOVTKFQ67ZGphLajVRqaTFjM
 mdb2OuANQdNu/qVk8RZxbIPPhyyTzZmgUaGRyh35tnuKnZ5YpcsOKf/gf4H9Hak9R/Mv
 Rx4NSttweNLiC1UZpPLDnCTjQb7WcCUd10Kg8L1816UwwaCCkGoHYr6QvWaFGV5pIguL
 m/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pLYt1l6HE7pnximoWhPblRl1OWyG0USlCkJuRGmgiG0=;
 b=dpOeFqC76OBJWStR43Enu9jcDwdX1CQTe28xDwC/8/Zev7JCoaT/+Ne9MrPmw5b/SC
 9J//UdyHGo+TG+cN35J1ne/prQ/fv1ysRI21SLxNCOHN97oZJv0Fo/hlFARCaCAZFWTb
 nsKpkUFIRSGVswU+JRfS8fK+CYBWv5jbcrCifCYKxBS1XlPh+1/Tb2Xt0VKxzNwGL1R0
 uIek0BEtvk3Son5exQla+fxtpKVcbnEXsR1v5wRxuch+CzJHi1DDWFypUkyzKwl548Pf
 Z8g9Ca2HyzeXj96ZmyAML8+H8oh5VGZXZ4XsU0bwRqMqfZZQM5i9KJ7p2OA1+gs+ve+W
 OiLg==
X-Gm-Message-State: AOAM531uzO2mqPwuYTd6Sua/dk//tfg/KIMPo8N9GeacTEAlSVlJdxhv
 Ndqm+wm5LKPLeaMRr7+Y0Ek=
X-Google-Smtp-Source: ABdhPJyckMFLa/YuZMuY+4lAQHbnRdtdg8vmuVsu7jE+LurgS+Q6KJUrM9mupzIHBKs/xBAwdXEtnw==
X-Received: by 2002:a17:90b:46cf:: with SMTP id
 jx15mr17340918pjb.121.1591625905905; 
 Mon, 08 Jun 2020 07:18:25 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.25
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:25 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 09/15] hw/riscv: sifive_u: Add reset functionality
Date: Mon,  8 Jun 2020 07:17:38 -0700
Message-Id: <1591625864-31494-10-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1042.google.com
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

The HiFive Unleashed board wires GPIO pin#10 to the input of the
system reset signal. Let's set up the GPIO pin#10 and insert a
"gpio-restart" device tree node so that reboot is now functional
with QEMU 'sifive_u' machine.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_u.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 881949b..ef51874 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -37,6 +37,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/boards.h"
+#include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
@@ -53,6 +54,7 @@
 #include "net/eth.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 
@@ -96,7 +98,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint32_t *cells;
     char *nodename;
     char ethclk_names[] = "pclk\0hclk";
-    uint32_t plic_phandle, prci_phandle, phandle = 1;
+    uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
@@ -270,9 +272,11 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
+    gpio_phandle = phandle++;
     nodename = g_strdup_printf("/soc/gpio@%lx",
         (long)memmap[SIFIVE_U_GPIO].base);
     qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", gpio_phandle);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
         prci_phandle, PRCI_CLK_TLCLK);
     qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 2);
@@ -292,6 +296,12 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,gpio0");
     g_free(nodename);
 
+    nodename = g_strdup_printf("/gpio-restart");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "gpios", gpio_phandle, 10, 1);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "gpio-restart");
+    g_free(nodename);
+
     phy_phandle = phandle++;
     nodename = g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
@@ -352,6 +362,14 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 }
 
+static void sifive_u_machine_reset(void *opaque, int n, int level)
+{
+    /* gpio pin active low triggers reset */
+    if (!level) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
 static void sifive_u_machine_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_u_memmap;
@@ -383,6 +401,10 @@ static void sifive_u_machine_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_FLASH0].base,
                                 flash0);
 
+    /* register gpio-restart */
+    qdev_connect_gpio_out(DEVICE(&(s->soc.gpio)), 10,
+                          qemu_allocate_irq(sifive_u_machine_reset, NULL, 0));
+
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
-- 
2.7.4


