Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B12C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951732184D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngyDSJ/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951732184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dFv-0006CB-G5
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwR-0003Ol-W4
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i2cwP-0003p6-4x
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:59:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i2cwL-0003kN-Iv; Tue, 27 Aug 2019 10:59:22 -0400
Received: by mail-pl1-x644.google.com with SMTP id gn20so11914118plb.2;
 Tue, 27 Aug 2019 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=txywo/qB9NDWK7jn2LNwcr8E3yWXO0rMZ+SQkFmtAiQ=;
 b=ngyDSJ/T0JLO+nDIjvx6EJe2Mxo6Kv9tM8U8yQYfSFyelMejEJj7PP3NaSWV69wpL2
 5iEIwk+CBM9ARqli55LkEnDhxDUQ3MKQ25DNopJ99VaKv0djjo0z4Cz82XY5xibYyZWS
 hijcfQ2I5lOmgZnkuit4dIZfOmPspbNLbuQxtTlCg3o1H0RvQiz0bd1azUtJ+A2tCHR+
 X+F+vUwmOmQ1zKutKGgRqKilaHHSNH2SzSoxsEy4k4rpebolHjUTft4R20zJzH6Di4Bh
 JgwlHh0MQiPpnuEWGER0d5/IJPFgDur3vfLTQNGD2gCVo+hDEVYw68VGhvrXRQaMc0a8
 mydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=txywo/qB9NDWK7jn2LNwcr8E3yWXO0rMZ+SQkFmtAiQ=;
 b=jqqvW+uBkaqgNfE5dDyNLSGSU0F/lPqEUxwY88l9TqABi7x9nolWRXicnH5bq2k4s7
 i65G8Tw+xctM0oyCZ+3WlwkzYl4fZppGF5qQtv0E7UDb9kq1qFmCcHGRgoE8zS+Th5Yh
 ze3RF7J8BtneTp1O0BY7cxEf45r52Ce/CT8UwVUOr2pWXLanq72plT3LihuDDo7W99cS
 MW+F5aFql5FwrhI+q+/Wyw+PYBya7a5vKzTKyq8r20HRIADE/ZGnx+74fxCwzVi6E5vL
 8m4szC73fZZTNS2/+bJezEhFXkqcjCHVyUabLiPqGn9UO76o5+7JduOBVzUsANhVxrzW
 19Tw==
X-Gm-Message-State: APjAAAXZqORSKyGXIviA1YcZFs6XHn1rIEsKwx6mw053gWWJOleWxWJw
 VZiQAWLn4KtTCq3q7eFABl0=
X-Google-Smtp-Source: APXvYqxLG2yjfkWnnp+LCB7QeBIeWEQ7oFOoMrs6yoYCrrk6iyeKkRShpyZx+lh+f3ZtIW2SM2WF0A==
X-Received: by 2002:a17:902:4303:: with SMTP id
 i3mr6901058pld.30.1566917950488; 
 Tue, 27 Aug 2019 07:59:10 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id j15sm14839344pfr.146.2019.08.27.07.59.09
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Tue, 27 Aug 2019 07:59:09 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Tue, 27 Aug 2019 07:58:31 -0700
Message-Id: <1566917919-25381-23-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
References: <1566917919-25381-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v6 22/30] riscv: sifive_u: Reference PRCI
 clocks in UART and ethernet nodes
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

Now that we have added a PRCI node, update existing UART and ethernet
nodes to reference PRCI as their clock sources, to keep in sync with
the Linux kernel device tree.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_u.c              |  7 ++++---
 include/hw/riscv/sifive_u_prci.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index da8ee64..3b1fe46 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -78,7 +78,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     int cpu;
     uint32_t *cells;
     char *nodename;
-    char ethclk_names[] = "pclk\0hclk\0tx_clk";
+    char ethclk_names[] = "pclk\0hclk";
     uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
     uint32_t uartclk_phandle;
     uint32_t hfclk_phandle, rtcclk_phandle;
@@ -263,7 +263,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
-        ethclk_phandle, ethclk_phandle, ethclk_phandle);
+        prci_phandle, PRCI_CLK_GEMGXLPLL, prci_phandle, PRCI_CLK_GEMGXLPLL);
     qemu_fdt_setprop(fdt, nodename, "clock-names", ethclk_names,
         sizeof(ethclk_names));
     qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
@@ -293,7 +293,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cells(fdt, nodename, "reg",
         0x0, memmap[SIFIVE_U_UART0].base,
         0x0, memmap[SIFIVE_U_UART0].size);
-    qemu_fdt_setprop_cell(fdt, nodename, "clocks", uartclk_phandle);
+    qemu_fdt_setprop_cells(fdt, nodename, "clocks",
+        prci_phandle, PRCI_CLK_TLCLK);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
     qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_UART0_IRQ);
 
diff --git a/include/hw/riscv/sifive_u_prci.h b/include/hw/riscv/sifive_u_prci.h
index 60a2eab..0a531fd 100644
--- a/include/hw/riscv/sifive_u_prci.h
+++ b/include/hw/riscv/sifive_u_prci.h
@@ -78,4 +78,14 @@ typedef struct SiFiveUPRCIState {
     uint32_t clkmuxstatus;
 } SiFiveUPRCIState;
 
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


