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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A9CC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00DA2208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNQawIO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DA2208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwj0R-00081D-81
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60432)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwit2-0006XT-S9
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwit1-000458-Lz
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:32 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwit1-00044q-G0; Sun, 11 Aug 2019 04:07:31 -0400
Received: by mail-pg1-x541.google.com with SMTP id z14so10749910pga.5;
 Sun, 11 Aug 2019 01:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=mFSi8bsvQ+ibTWLMsL81ncTe9xLI7iHKgNdZSijsA8g=;
 b=eNQawIO5GUwGWHIs3AMwAau2uKMAFUL3bEZNirfnhsYho+nzFEYrcjnBkVlq1sVaKM
 kCiVa+VA0vxcVXVmjUT6MiWllwbr/HyFEKGC7ANhfpnqqVcrWWPhrrCRQLGBi31RwnKk
 22StIKtabygvZH+eGYMQmjQVlCCy0kjG6jPqA6Brd899ggT+1105hCXhc7ss0vM1hPpu
 oEBQE2JYSQo9qB0VzyY2e1crOF/3eRQ6oyVAO1HloLPextPtnaZR6S/0XIVtTLeOCeol
 I59MqZBWYj/lHTW//NeDz3aABD8CDVeqEu4quh/2oQhot8T+LBfpOZAVQHXxlnryip0h
 4bLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=mFSi8bsvQ+ibTWLMsL81ncTe9xLI7iHKgNdZSijsA8g=;
 b=LHJ9aZdcnRcC0x5M28d8q8xFUbQpATPXU9DRS0pkzl4NcOovjlX2vaw0Q8DhNDj6/z
 fbEPeJ1HBr8Y0AJtaWPdGv8BaOUY3AS2so4sO/Fa2QsXq88wkTFqrxOTVT8903YU6ZZ7
 7ZMHH7zJCRwYGJj4XZfc4eN1YU2bVNILvTY3cQ3BaX33Rn3x20P10AorYbit9vCKdqpf
 n9y/6ZwnKSk5u7gPdmjpTAkB9gzuHMk0om9JwCRxsoK9BPoU3mcYPmW9sMkyg6LgLHS+
 om5846jwu+HZltsb/Szj2tuCCX68QmkCk2pFIoCzs8vh9lmMOnEYDhRwtK+PoM71i6fX
 Ik6g==
X-Gm-Message-State: APjAAAX8dRRSQhl8tG1IwihsGXYAldBXMTapBAV+fPQQQdg43y8Vsizm
 rRGBg4WFHSWKDYkc0tbOdf6Ie0MW
X-Google-Smtp-Source: APXvYqyPR5FaE/stfu33bCMZ7RtUvcfJhdXdUzPpF+nG7RuyyXUPIdQ4hFypMKjQCbRxsUp9O4bNKA==
X-Received: by 2002:a63:61cd:: with SMTP id
 v196mr25599693pgb.263.1565510850672; 
 Sun, 11 Aug 2019 01:07:30 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.29
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:30 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:54 -0700
Message-Id: <1565510821-3927-22-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 21/28] riscv: sifive_u: Update UART and
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

Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c              | 21 +++++----------------
 include/hw/riscv/sifive_u.h      |  3 +--
 include/hw/riscv/sifive_u_prci.h | 10 ++++++++++
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 486b247..7eb2b7e 100644
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
index 3ae75b5..2a7877e 100644
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
 
 #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
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


