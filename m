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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071DDC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C160420651
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaJtLwlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C160420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufaY-00006Q-0B
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58595)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPu-0000ms-3n
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPr-00033K-Mg
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPr-000328-91; Mon, 05 Aug 2019 12:00:55 -0400
Received: by mail-pf1-x444.google.com with SMTP id t16so39843687pfe.11;
 Mon, 05 Aug 2019 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=s/GGftnAQofWbHcLlvYGC8C8gu8FXqIu5dq4uDy4E24=;
 b=XaJtLwlmHWNElbOvgx6+rVIllv0QHp3yTNeGEN+sDckvrSZmyeloi2oij0b42vH7tB
 Zm4WmP3VOxJ1w0Czxdw1CY1bClfMT6IjL4zN35ynDa+vw/nMDp9XX9M6yltgEFhdzyPI
 RtHO51Mmfs27SDf6tmpvCPNwKfNCqfQQVKguBCogxVEx7PYzr5oj4krm7AkXrEvhhJr5
 vEe4pCEsqEEIpB9qPjDyiunqXsUHlFu6/41ZmTety8N2WVSEE1cCmoP7aU2wDLU5G23Y
 L82MAnyo5sPdEnMciQFQb7TLt3XgyvtvqGh30ZfcLVfGLCUL3MKKzRyGU36vMkFw1hzf
 c6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=s/GGftnAQofWbHcLlvYGC8C8gu8FXqIu5dq4uDy4E24=;
 b=Sb5uV1PV58zyBAPHAJrPD4+UtMldeJFc/JFA/e98QbDxKvvFUJsHokTWPAuBuQuhNK
 XIYxYIWrwpPjr8kjrW8tlcb8Wgo92HhB5z9U6xjsn+sdVu2tHTBPEkVOyv8OaZCUo2M+
 iOfJ+E+dAgjWrJAuDbI7TG3jSe1L8efTrHuqufn55c1zmM5psqa0E+lK+ydBi85SAMcf
 SpZvpQvCd88/62FG7PVHpyMD699LXKMNxzW8hfH6DC6cU8Etpf0SKk1uyKBTQx91ogf9
 JjK4gf6Ql+GzU01FUyxdXR4PBBFbC3CY+0uKuh6RY59hZrrLIrfm6HytKBPFG/BW/TB1
 LIdg==
X-Gm-Message-State: APjAAAXfazaqpgiCLWYGf1yrc4NqPwL6jww/qNE6M5oIRrUero0uxl7t
 mExezrpT2Y5Q0IHJpmazTxw=
X-Google-Smtp-Source: APXvYqw1Tbc8kWcrhl2cYkvDscRq0ur177F9vPlqWjLDjuy9wk9+WxnSHR0Yyz8FNTrzSSrKRzquJA==
X-Received: by 2002:a62:82c2:: with SMTP id
 w185mr76487908pfd.202.1565020854292; 
 Mon, 05 Aug 2019 09:00:54 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.53
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:53 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:19 -0700
Message-Id: <1565020823-24223-25-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 24/28] riscv: sifive_u: Fix broken GEM support
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

At present the GEM support in sifive_u machine is seriously broken.

- The GEM block register base was set to a weird number (0x100900FC),
  which for no way could work with the cadence_gem model in QEMU.
- The generated DT node for GEM has a "clocks-names" which is an
  invalid property name.

Not like other GEM variants, the FU540-specific GEM has a management
block to control 10/100/1000Mbps link speed changes, that is mapped
to 0x100a0000. We can simply map it into MMIO space without special
handling using sifive_mmio_emulate().

Update the GEM node compatible string to use the official name used
by the upstream Linux kernel, and add the management block reg base
& size to the <reg> property encoding.

Tested with upstream U-Boot and Linux kernel MACB drivers.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c         | 17 +++++++++++++----
 include/hw/riscv/sifive_u.h |  3 ++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9945b82..85cd4b5 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
  * Copyright (c) 2017 SiFive, Inc.
+ * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
  *
  * Provides a board compatible with the SiFive Freedom U SDK:
  *
@@ -11,6 +12,7 @@
  * 2) PLIC (Platform Level Interrupt Controller)
  * 3) PRCI (Power, Reset, Clock, Interrupt)
  * 4) OTP (One-Time Programmable) memory with stored serial number
+ * 5) GEM (Gigabit Ethernet Controller) and management block
  *
  * This board currently uses a hardcoded devicetree that indicates five harts.
  *
@@ -68,7 +70,8 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
-    [SIFIVE_U_GEM] =      { 0x100900FC,     0x2000 },
+    [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
+    [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
 };
 
 #define SIFIVE_OTP_SERIAL   1
@@ -244,17 +247,20 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     nodename = g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
     qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "cdns,macb");
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+        "sifive,fu540-c000-gem");
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_GEM].base,
-        0x0, memmap[SIFIVE_U_GEM].size);
+        0x0, memmap[SIFIVE_U_GEM].size,
+        0x0, memmap[SIFIVE_U_GEM_MGMT].base,
+        0x0, memmap[SIFIVE_U_GEM_MGMT].size);
     qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
     qemu_fdt_setprop_string(fdt, nodename, "phy-mode", "gmii");
     qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
         prci_phandle, PRCI_CLK_GEMGXLPLL, prci_phandle, PRCI_CLK_GEMGXLPLL);
-    qemu_fdt_setprop(fdt, nodename, "clocks-names", ethclk_names,
+    qemu_fdt_setprop(fdt, nodename, "clock-names", ethclk_names,
         sizeof(ethclk_names));
     qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
     qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0);
@@ -455,6 +461,9 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
                        plic_gpios[SIFIVE_U_GEM_IRQ]);
+
+    sifive_mmio_emulate(system_memory, "riscv.sifive.u.gem-mgmt",
+        memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
 }
 
 static void riscv_sifive_u_machine_init(MachineClass *mc)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 0461331..e92f1aa 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -56,7 +56,8 @@ enum {
     SIFIVE_U_UART1,
     SIFIVE_U_OTP,
     SIFIVE_U_DRAM,
-    SIFIVE_U_GEM
+    SIFIVE_U_GEM,
+    SIFIVE_U_GEM_MGMT
 };
 
 enum {
-- 
2.7.4


