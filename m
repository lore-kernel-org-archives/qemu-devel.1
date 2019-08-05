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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4FBC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9437217D9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAr7KuB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9437217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufYk-0003Yo-TJ
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58591)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPu-0000mp-3U
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPr-00033V-Tt
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:57 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPr-0002zt-Jr; Mon, 05 Aug 2019 12:00:55 -0400
Received: by mail-pg1-x543.google.com with SMTP id l21so39965997pgm.3;
 Mon, 05 Aug 2019 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=iw3UhpEoqzqlfxDvmCEyz/VBWnKFldOICt3Mur3ua7Y=;
 b=IAr7KuB+ZevFKcALbCAZCXgPwwekHsNTcSXzUjeu0g3cJKC92aitErwCkcrg94Xh3k
 e2sD6ahuHD37CB1FNWBsJsr5CFxbqcGwz1v1Yu+9FGWHA2fai58uViJOfO/tmQ51EK6r
 V+XelcOx/g3Y/D1QF1WjzFqgk/nMhS72cP5cCcPo7R1CHrhJIW3PALG8awIS7lM8lNVv
 JmkLAXeliRTs5cWLj/CwKGFf5id4hf0QAdqPXOwDguhPK/dq09Sy5jNReijO+0w2P7+5
 w7iCEg1h944tqj9b1SOVSoFXZJ9mMDEcOB0OyWg99hK6YBW4lz3JNmThwZj/tfVR2ESd
 Cl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=iw3UhpEoqzqlfxDvmCEyz/VBWnKFldOICt3Mur3ua7Y=;
 b=Y4/awLT7svXeBE4Di0igM2XWVxXl0FTMmjbEwlzyOuun/OgSMcOAoWVIYXbUm7UjqA
 HFu409pPnkf5/PdqsPaKhyuyOXeC+k/KdjoPkI0mndFBVXdSVU/mYSgHKdj9oC99XHAX
 e5E6lmFMUVeJrNzv+a1CIGXXKD1FkxhClm5DWHv9s5lvez3+22LPX1E9XWXs132E6or9
 ZMULSScSoglySr+MkvxwHTbVihlGlRWsPszyLH3lQAGwaid5+20N+m4qOyZDFVmaMr/l
 +u611Zx6d6YTeO0T2k3PoGpPvXhGRtshF1F+akt1CdWwJq/1KaBSE4uPMowuuaLPD6MB
 s9jQ==
X-Gm-Message-State: APjAAAURzEt0zuNwHjV/y5Nwqkm7BE+NBi0YigDUezqZ55YJS4BIupkh
 xpn2j+uUmM65u5GftLeQuzEy6u1c
X-Google-Smtp-Source: APXvYqzqQd0jvLOsboelX2b/rn1AhnUlKToo67PHIZbHEo+S0NfVPwz+VAdOjg080rgVwmPrOEh+uQ==
X-Received: by 2002:a62:3347:: with SMTP id z68mr75500336pfz.174.1565020851049; 
 Mon, 05 Aug 2019 09:00:51 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.49
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:50 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:16 -0700
Message-Id: <1565020823-24223-22-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 21/28] riscv: sifive_u: Update UART and
 ethernet node clock properties
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

Now that we have added PRCI nodes, update existing UART and ethernet
nodes to use PRCI as their clock sources, to keep in sync with the
Linux kernel device tree.

With above changes, the previously handcrafted "/soc/ethclk" node is
no longer needed. Remove it.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c              | 21 +++++----------------
 include/hw/riscv/sifive_u.h      |  3 +--
 include/hw/riscv/sifive_u_prci.h | 10 ++++++++++
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b90aa53..061d6d4 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -81,8 +81,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     int cpu;
     uint32_t *cells;
     char *nodename;
-    char ethclk_names[] = "pclk\0hclk\0tx_clk";
-    uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
+    char ethclk_names[] = "pclk\0hclk";
+    uint32_t plic_phandle, prci_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
@@ -241,17 +241,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
-    ethclk_phandle = phandle++;
-    nodename = g_strdup_printf("/soc/ethclk");
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
-    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
-    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
-        SIFIVE_U_GEM_CLOCK_FREQ);
-    qemu_fdt_setprop_cell(fdt, nodename, "phandle", ethclk_phandle);
-    ethclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
-    g_free(nodename);
-
     nodename = g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
     qemu_fdt_add_subnode(fdt, nodename);
@@ -264,7 +253,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
-        ethclk_phandle, ethclk_phandle, ethclk_phandle);
+        prci_phandle, PRCI_CLK_GEMGXLPLL, prci_phandle, PRCI_CLK_GEMGXLPLL);
     qemu_fdt_setprop(fdt, nodename, "clocks-names", ethclk_names,
         sizeof(ethclk_names));
     qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
@@ -284,8 +273,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_UART0].base,
         0x0, memmap[SIFIVE_U_UART0].size);
-    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
-                          SIFIVE_U_CLOCK_FREQ / 2);
+    qemu_fdt_setprop_cells(fdt, nodename, "clocks",
+        prci_phandle, PRCI_CLK_TLCLK);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_UART0_IRQ);
 
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 2f475c5..0461331 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -68,8 +68,7 @@ enum {
 enum {
     SIFIVE_U_CLOCK_FREQ = 1000000000,
     SIFIVE_U_HFCLK_FREQ = 33333333,
-    SIFIVE_U_RTCCLK_FREQ = 1000000,
-    SIFIVE_U_GEM_CLOCK_FREQ = 125000000
+    SIFIVE_U_RTCCLK_FREQ = 1000000
 };
 
 #define SIFIVE_U_PLIC_HART_CONFIG "MS"
diff --git a/include/hw/riscv/sifive_u_prci.h b/include/hw/riscv/sifive_u_prci.h
index f3a4656..640c641 100644
--- a/include/hw/riscv/sifive_u_prci.h
+++ b/include/hw/riscv/sifive_u_prci.h
@@ -87,4 +87,14 @@ typedef struct SiFivePRCIState {
 
 DeviceState *sifive_u_prci_create(hwaddr addr);
 
+/*
+ * Clock indexes for use by Device Tree data and the PRCI driver.
+ *
+ * These values are from sifive-fu540-prci.h in the Linux kernel.
+ */
+#define PRCI_CLK_COREPLL        0
+#define PRCI_CLK_DDRPLL         1
+#define PRCI_CLK_GEMGXLPLL      2
+#define PRCI_CLK_TLCLK          3
+
 #endif /* HW_SIFIVE_U_PRCI_H */
-- 
2.7.4


