Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C725CC4CECC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91788214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toXSP+F+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91788214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8UO-0003ZM-Os
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JY-0000Uz-5p
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JX-0005kX-PD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:07 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jT8JX-0005e5-AQ; Mon, 27 Apr 2020 14:17:07 -0400
Received: by mail-lf1-x141.google.com with SMTP id x23so14677237lfq.1;
 Mon, 27 Apr 2020 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IO/HE1kipWi5FHLRIjyeawlGTVZf+4xugUQIEPlWh94=;
 b=toXSP+F+waDi3RQf5149MZr7JFTlgP62W3Wzfo1bk49VL4dLwh/2mwfZGRW7aPt/oT
 3Km7cWIWRXPO0AfFuvqdr+8Gbs9U33idImnCOJ8g8ssfASOpsSuHdmVsWo8QOn0u3eUC
 dOI4F3zG2nj2LpixJ7L/yUyxHt7tp/ABSWd7Fz3gGmb2w4nZJRcZIiqPw4SmP41ILfBw
 pkohmeI5rCK3FlmzscMZFEfIm64mP/TO4Jka1XyCL+VNyrBMo80DHM2Bp1wV6RSj9Xji
 FQFAXTs13vkHMjUa3Lp2B43mzoGuwVCTTM1A+CQb+He8mW8G20IgOTdfvG/cWx8Eu7IZ
 RW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IO/HE1kipWi5FHLRIjyeawlGTVZf+4xugUQIEPlWh94=;
 b=CtptbjDBLXxWbBCvXsZvn/R3NxSMKO5bzJE/QHgLs/sG22rnDyKgnDCg34BrcJocJO
 R9zCJ7BcXfGUQH5DxjTRoQqAz1z3nMf9dusdvjxGlPMvDtAZ10bnDR5AYwAamMpq19PB
 oR5gD6963CufbjZBQjv05mJcc51sg6aSkTkqkDL/LvzL1gJeLwsB3uG8EFd/gFoDU7Jr
 QLbbwsKSrW7FYsOHdrpCG4ZXOGCdaUwp7QXMhgCo7/qQ/DXlQhSXNR9TducfGKSr1Ny4
 cJuNbEIPGYgflmOSUPXAqapNJixYlhXHPL3pBBLfAEM9KebAo3OjtuM/rkRtV+vBrgG3
 c2Jw==
X-Gm-Message-State: AGi0PuYsKVFVYq5+9cx9KRQlje3uQTOLqbkzGQ3u2Rcs8bYDRowj4/nf
 cT0aOTqPJd0tQ/htx4Dhzw8sEJ3U2/Y=
X-Google-Smtp-Source: APiQypJUVcbHdSVdA+OV6TH4x4UBPCQwZiUcLC/vHvSEhuNSFSqZMM1vILJSvh0sYYqxrRClFSapmA==
X-Received: by 2002:ac2:420c:: with SMTP id y12mr16234487lfh.26.1588011425204; 
 Mon, 27 Apr 2020 11:17:05 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id v26sm10394371lji.43.2020.04.27.11.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 11:17:04 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 11/11] hw/arm: versal-virt: Add support for the RTC
Date: Mon, 27 Apr 2020 20:16:49 +0200
Message-Id: <20200427181649.26851-12-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427181649.26851-1-edgar.iglesias@gmail.com>
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::141
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for the RTC.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal-virt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 0afee48672..7e749e1926 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -283,6 +283,27 @@ static void fdt_add_sd_nodes(VersalVirt *s)
     }
 }
 
+static void fdt_add_rtc_node(VersalVirt *s)
+{
+    const char compat[] = "xlnx,zynqmp-rtc";
+    const char interrupt_names[] = "alarm\0sec";
+    char *name = g_strdup_printf("/rtc@%x", MM_PMC_RTC);
+
+    qemu_fdt_add_subnode(s->fdt, name);
+
+    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_RTC_ALARM_IRQ,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI,
+                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_RTC_SECONDS_IRQ,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
+                     interrupt_names, sizeof(interrupt_names));
+    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+                                 2, MM_PMC_RTC, 2, MM_PMC_RTC_SIZE);
+    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
+    g_free(name);
+}
+
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
@@ -496,6 +517,7 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
     fdt_add_sd_nodes(s);
+    fdt_add_rtc_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
-- 
2.20.1


