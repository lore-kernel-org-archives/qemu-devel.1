Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4527C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D88C20661
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAGJjtEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D88C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaWA-00024v-GX
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHv-0000Pq-I0
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHu-00013x-Jp
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:35 -0400
Received: by mail-wr1-x42b.google.com with SMTP id k1so1831667wro.12
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=w72aHgPZMgOA36un6Lhv4DDQAzkYim3so5bL3PT2h+I=;
 b=KAGJjtEbhGnOGh4/ouaIIP+RwQ2P5YDzKQGjyD8J2bQ/UE+su28WTSOt45D6w16e82
 8CU7rI1IOPhTDlesP6GJ4pFwBgWRIJC+TpfFxQ0FRCUPb+Wp612VYbk/85p279sOjXOy
 M0oG2ooOX02leiFDiuoZPZZG2MzpYOStonR1XSuE7FXU4uUoRSwY9KbWaja905+BkCau
 9yJG+BykhQrz9CC/sQ/IF8aQRL7xFgZi6NQMw+G00B5NlzAmtPV8jRfoJKckS3lehhAI
 b9V2ZIBvxXS3Na7GHfjWMOcp/2gUErBCw9XCuaUeYETuZMxK/rgxkrwPUGdgX1x8UbPn
 /eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w72aHgPZMgOA36un6Lhv4DDQAzkYim3so5bL3PT2h+I=;
 b=oVdi7aMpzmqHPdsagfwfnEqzCIAFQH/Eiaf1+yqmxq+nlplOVfCPLwb8KmGXyE1Xik
 kYjexOHXGjWIX0LGuqejltJrNLoGdKaAqF9fXxlVpbEEIAYeGPC3N4JDInD0+Sng0J4h
 DmKWAEy8kNUyDKAFwqx/uLJQaniv2EDw4R0RxA5wUZhDToN1Sej8um9PhLf9CV6WcOXS
 EJwBQO8wA+2yTlwkZMcFOXVqJyiytT5iEIj1Fb2KDLdxgk0iSoF8ONyzSmSYRytcY2nl
 y49rzpLh4zlLnlLEYiBNdAjgDv1O6eh54b2UbWisKv683ellha8XCwa+akSFvh6TBxQH
 1uEA==
X-Gm-Message-State: AGi0PuaMbqHzT7XjE4mu24LWb9UZmB8nhM/HALu+xjg5NbwoChEhsmjx
 UwIm6SSL+dw8qfqGizeoQ4G1Zw5OwLKGwA==
X-Google-Smtp-Source: APiQypI15IHgOCbknECrxLT6GrMsn4/KGCCN00nV0ovak5Mn5DrfqwaMdqln5e1rqRmFUw3pQwz/dg==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr18844288wrn.173.1588595613001; 
 Mon, 04 May 2020 05:33:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/39] hw/arm: versal-virt: Add support for the RTC
Date: Mon,  4 May 2020 13:32:49 +0100
Message-Id: <20200504123309.3808-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for the RTC.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200427181649.26851-12-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal-virt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 0afee48672a..7e749e19267 100644
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


