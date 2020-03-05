Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA182C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7956020637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAZdIyJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7956020637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tUA-0003iZ-F4
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tOt-0003Cr-Io
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tOs-00025F-EL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:07 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tOs-00024k-7q
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:06 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so7802534wrn.6
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yEiymKhkPROqYzNJ51XYaQjzjgzEBScugFbYELCXiTs=;
 b=WAZdIyJtpvTzEe2dl4d/NyQM5LyI8aBJcyzH3QLfvySD0Nlz7CTEFomvWpACmrlAKc
 ezylUjdtp6oM1+6+wBa51tPRB20ilUyqBWZt8LsFnz1hYXgM7oHtAZKcLyXKZ0j/WCep
 xUMiObVoG1F7VYAGypc4e+gCwR8RRendsxTbm24eYNfho9BplXCDiQh7o6hOOqertbC+
 Xo55/CkYya5ymlmjEIMnRwADbrKl5+AC9xoMerRDRALvSedICUc/aBnMQvTg37nfgmWZ
 PQs0xZIabR4ajaxu7x5nPCc9eZxjo1KnLQz8KR9g3lViRybyWx2lKIg55ZFlTuW0Svpx
 n7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yEiymKhkPROqYzNJ51XYaQjzjgzEBScugFbYELCXiTs=;
 b=RwRWLFUjoH4obSVMBhpCN3J/AadEsT3rlyxH8wQ6UI/+FjvNZd9xuZ2G9RAlN2L6KX
 F+lbHlB30BhoiPIgaVtIv7FXzVj7JHY/UA5tegN9hVbajV15NzQ/wl3Cv0uZsO6s6EFN
 0VSZJfxvKGcY8FMy7CcQs4XiXDF/eXBrBAYCrnVlNzt2WQIjF5AwF9dI5G1Tb4xQRQSY
 NvC33qx2uYDlSCheQ/2/sh9mDxtEoYUz3wXnFMDW+tPozgdwBR9oZPVWk01Bx6Ql9mNT
 DHQuIFH8uHeYlwXySZn++TIRXV9b3VS+IhS2l/cfYY3g0CWXhwSh0KbJK/t7/zrYnK1Q
 CJYQ==
X-Gm-Message-State: ANhLgQ0NQXvpEnbfDkLbvShr3OqqtWIUdTaKyXDkI2APSgvOfqINbgzU
 k/XhGtcT16pZbzCj65XVRwTd+j+cntnEdA==
X-Google-Smtp-Source: ADFU+vtA0kPCR5Orj3C6WQw9qTciGUtirEnCMl0eWew44VVFLEroUEpemEPgEXySrn2mUyESbvuByw==
X-Received: by 2002:a5d:5043:: with SMTP id h3mr5963574wrt.274.1583425864900; 
 Thu, 05 Mar 2020 08:31:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/37] hw/arm: versal: Generate xlnx-versal-virt zdma FDT nodes
Date: Thu,  5 Mar 2020 16:30:25 +0000
Message-Id: <20200305163100.22912-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Generate xlnx-versal-virt zdma FDT nodes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal-virt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index e7f4ca8bf95..878a2751400 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -229,6 +229,33 @@ static void fdt_add_gem_nodes(VersalVirt *s)
     }
 }
 
+static void fdt_add_zdma_nodes(VersalVirt *s)
+{
+    const char clocknames[] = "clk_main\0clk_apb";
+    const char compat[] = "xlnx,zynqmp-dma-1.0";
+    int i;
+
+    for (i = XLNX_VERSAL_NR_ADMAS - 1; i >= 0; i--) {
+        uint64_t addr = MM_ADMA_CH0 + MM_ADMA_CH0_SIZE * i;
+        char *name = g_strdup_printf("/dma@%" PRIx64, addr);
+
+        qemu_fdt_add_subnode(s->fdt, name);
+
+        qemu_fdt_setprop_cell(s->fdt, name, "xlnx,bus-width", 64);
+        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
+                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
+        qemu_fdt_setprop(s->fdt, name, "clock-names",
+                         clocknames, sizeof(clocknames));
+        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_ADMA_IRQ_0 + i,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+                                     2, addr, 2, 0x1000);
+        qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
+        g_free(name);
+    }
+}
+
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
@@ -427,6 +454,7 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_uart_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
+    fdt_add_zdma_nodes(s);
     fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
-- 
2.20.1


