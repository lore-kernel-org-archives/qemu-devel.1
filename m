Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0332DC4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C012324672
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 03:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkcsCSMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C012324672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79i7-0001np-0A
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 22:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1j79gX-00087C-M6
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1j79gW-0003dH-Ky
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 22:18:01 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1j79gW-0003bj-DX; Wed, 26 Feb 2020 22:18:00 -0500
Received: by mail-lj1-x242.google.com with SMTP id w19so1557856lje.13;
 Wed, 26 Feb 2020 19:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FoZhsAb+/1S+pgpJASq34rn2TkwqgMpwQN0+sRMg6Pw=;
 b=dkcsCSMD510WAEd8KKw29IhV5MR6L/gd8wBue1RRUd1yjkkBekXN4U2YxqSxy6nNkx
 KTEzU1sE0Rg8PyE2D5GrAt5J3ykL+q68OHRKZ9/9fpDdh8NG1D7ejLI+pqAowCNlRhCD
 jgkc34v05obb4LIvUwMghQPM2lCcRFTr8MxixRDdEcx422Vx00ScTTDxIcOJFKY8yDy0
 J9UCrTVggMkIBUCJmCvbsV6loKhnlxnYs1X9c5on1P51cxriTmh/mXqMYyuAXqIZMiAQ
 SGd0022QseUJfkcZRXsnIBfpsrxHZw06MdkKzN7RBV20Mx+liIhDsJkpKm1cAiPoZiz7
 5Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FoZhsAb+/1S+pgpJASq34rn2TkwqgMpwQN0+sRMg6Pw=;
 b=Lu/2X7+DrhDq7TCc9mnHqJLIdy2TJOFwgHIw43NG7rA7DAtHWjNZ//hskESadyc8S9
 MD0OSsrfkS/pcJNuzSuoonUCb2bM1/ldggJNko6/8QvTk+m4635khwIgIz/LeCz2G12H
 sxuNVosxbNCiCLbk4N1xV71Uz9vI+2YjKZ1GIcGKSUcWiFWc8QXAVzlEEGsn8sOFm/h9
 B+12wDz7UMpm/JVxhvsVOqLYPqAV07R7TrZv4PJdit31ZJNDNPwkbYc9/kQ2tom0jKhS
 XOP/DkKL87JNSyERRkvhmoPIHNsu+q9apqOrZhizgEiaRmk5vmYDXh1Let7d6JjI5oWQ
 /Zdg==
X-Gm-Message-State: ANhLgQ1luuxlFl4iY7S02k74TaDSbWOUO3hvtIeYdi1qTCf6xkCbrmrM
 TC1tuaS/S4ASdvEk/SasvqOETK6y5FWWoA==
X-Google-Smtp-Source: ADFU+vuHmHZskKpuGVVzWzwESf2ltMZvLz5q8TSWSaDaxCrcnVNFSOUqKSZp3rCctp8+C/IqTzA6yw==
X-Received: by 2002:a2e:b017:: with SMTP id y23mr1309319ljk.229.1582773479032; 
 Wed, 26 Feb 2020 19:17:59 -0800 (PST)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id x1sm1071115lfq.46.2020.02.26.19.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 19:17:58 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/2] hw/arm: versal: Generate xlnx-versal-virt zdma FDT
 nodes
Date: Thu, 27 Feb 2020 16:44:24 +0100
Message-Id: <20200227154424.6849-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227154424.6849-1-edgar.iglesias@gmail.com>
References: <20200227154424.6849-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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

Generate xlnx-versal-virt zdma FDT nodes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal-virt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index e7f4ca8bf9..878a275140 100644
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


