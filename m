Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D95C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119C32199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdDsOGUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119C32199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGmQ-0003Ta-B1
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdw-0001DY-Ls
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvGdv-0008Cy-99
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:45:56 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvGdv-0008CS-2C; Wed, 07 Aug 2019 03:45:55 -0400
Received: by mail-pl1-x641.google.com with SMTP id c14so39397942plo.0;
 Wed, 07 Aug 2019 00:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=iTctY9qvWpXmxPkVyXSKVQceUtv+x2qlyz/k9SkFORE=;
 b=jdDsOGUSDqd75IqncBV29Pysbgdccgk3HzavyqWibGvW8Iohme5ToAM+z/1rqZRopw
 arxcKL4/OK4iTY57CsSj6vujrckdQagVmluPZbE1fcsAQhP6P5InTjhEk9G/JtkAh+9+
 uO9n5U0vJ96sln5Syex4tamd4QufPbf5S8pxvameTQRUzTo+gVyHrD/2HN0fOnWqbUtz
 54EstziCtS7Tf1tmgtYtUIL47wpYoxcPrbDE6DH1DkZEi8AzxNFHFA7e3sNgWG761GfQ
 eVFDqB2S9aNLIQv/5kyzOhqsQFpGHP0Ak4ua6h7WFSINUpbiH6a5eQ+dmv5SdFqRcToY
 H4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=iTctY9qvWpXmxPkVyXSKVQceUtv+x2qlyz/k9SkFORE=;
 b=E+UaCMQE5+GpETdxpiHSN7td4o6jzyOynIvOOLvIEXg6PRWpPfAdN55dJ3+O456DpR
 KhvpKACZ72vpRlGo9+i1II/S9b1m/IcOqAHiqP9nccrnG5WSpMWHTurE8M63Zoxt9w8N
 gKU+ZZagO+1rnNQ4HncJGAd7Nqwr+Lzat5ujcXhOxkEFrCDTZSj4GFJOVl4yeND2dYT2
 7UG5ja9bV5ywyqTNUHMNZPKxAgPLejaG7Bry+1o3UEmNndMHY025cec62mLVt5UjaRdw
 5aCt4d41+UBzKDe2eHdIPu13hv4E/9DmuHamcNuvlKXn7guRpmnwmiEfFddlfAQPnZ12
 DKxQ==
X-Gm-Message-State: APjAAAWccj2A4v/ZScSsc8tqr2DwCbpTAmXhgXNB8lHc2aceQZenuCcl
 Rn0sDl0iSZ1SUGDy7n/RuMs=
X-Google-Smtp-Source: APXvYqxsdSd/rhwvc/yD2JpW/hEAwD3HfXUxaremWIMGKl6rkYFAIfm5xtVDGJBSBWHJESDv7hD3ag==
X-Received: by 2002:a17:902:8f81:: with SMTP id
 z1mr6825808plo.290.1565163954338; 
 Wed, 07 Aug 2019 00:45:54 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id l44sm20154449pje.29.2019.08.07.00.45.53
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 07 Aug 2019 00:45:53 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Wed,  7 Aug 2019 00:45:17 -0700
Message-Id: <1565163924-18621-22-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v2 21/28] riscv: sifive_u: Update UART and
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

Changes in v2: None

 hw/riscv/sifive_u.c              | 21 +++++----------------
 include/hw/riscv/sifive_u.h      |  3 +--
 include/hw/riscv/sifive_u_prci.h | 10 ++++++++++
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7b4a684..fb4845c 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -82,8 +82,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     int cpu;
     uint32_t *cells;
     char *nodename;
-    char ethclk_names[] = "pclk\0hclk\0tx_clk";
-    uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
+    char ethclk_names[] = "pclk\0hclk";
+    uint32_t plic_phandle, prci_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
@@ -242,17 +242,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
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
@@ -265,7 +254,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
-        ethclk_phandle, ethclk_phandle, ethclk_phandle);
+        prci_phandle, PRCI_CLK_GEMGXLPLL, prci_phandle, PRCI_CLK_GEMGXLPLL);
     qemu_fdt_setprop(fdt, nodename, "clocks-names", ethclk_names,
         sizeof(ethclk_names));
     qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
@@ -285,8 +274,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
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


