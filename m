Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675B1C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EC92073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mU4lOWHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EC92073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaPu-00084B-9N
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHt-0000ID-5I
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHs-00010A-6X
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id d17so20659948wrg.11
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=46YDQfnJdBsNGu2+jdrQ8Ybw/urHvbn8NoapNHu01ns=;
 b=mU4lOWHDAb7KAy6UvkZ+Aebymk26NmLzvxcf20VRvUajEAi2lKajpqH/MNxGx8iikl
 Apmip8DoKuhzrW3+UBNzRUO2Vx7R2I7CEZcfLFvvRrdFrFBn9O3nM/c74oqJbMprByrP
 whmat3VjGBUIEYH4mm7ReAKLJVZ7Lyimq/XoYRzFi57nRMYcntgXQ6bzA4nKtO5e8icd
 iLgiS2SjWz5ilUpPTpU9sLlR2dojXAdC14jfH6SwlfajWDqu5b9qyRursh/9aP68OSV8
 CUynoFwjpO3qCWn1ZRdD3HXRWbs2trGUKUjjJhSpaE/D2Ser6MekP1qtWstRR6CUsPhW
 y3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=46YDQfnJdBsNGu2+jdrQ8Ybw/urHvbn8NoapNHu01ns=;
 b=AsDYr+hbI0rfOvMMWKkIOSRDwrfmvppV3NocpXB6MUuM/gPGY5fD9kk4zXhsqUcA4t
 e1MC3otE4nQESAvfWPaUewZXHyMrazW7iwYxyYmajZQKZ81btxZNcHr3zd7Ynr3xlnJy
 EYrMq0PC6yu7qy4WbttN2h7mZ3LduAVyePyVdHs5eDYSCF+t1xR6UsxJoTQVlM4KsYdd
 Wcuj4PXQ7vdMoCO+O+QPXNpPUQNUMJYvFMUgyXtXH40Her5JLz0LveP7prInJmrVlnNA
 llfvms5qUuYi0tYSjB1SIHFuNQGH8hEib2vMpVSDarQjahVg57zNWnhmJhLc+mzso+JU
 sn0Q==
X-Gm-Message-State: AGi0PubKH7wrm9HfoADnHxIRdnplHQpq05UXjDypPtr8B9G8MSLAqhVp
 w3JJkLOsg+zBTMGtUcr/IDviEx5/lXNIvA==
X-Google-Smtp-Source: APiQypLmlSq+jqwt0Pali9Nte0PL0tHBoZXwFacNvWpwFpSycULdyDnD621HfDlfSw421WN9Bijsig==
X-Received: by 2002:adf:b301:: with SMTP id j1mr18774014wrd.221.1588595610543; 
 Mon, 04 May 2020 05:33:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/39] hw/arm: versal: Add support for the RTC
Date: Mon,  4 May 2020 13:32:47 +0100
Message-Id: <20200504123309.3808-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

hw/arm: versal: Add support for the RTC.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20200427181649.26851-10-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  8 ++++++++
 hw/arm/xlnx-versal.c         | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index e11693e29d3..9c9f47ba9da 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -19,6 +19,7 @@
 #include "hw/char/pl011.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/net/cadence_gem.h"
+#include "hw/rtc/xlnx-zynqmp-rtc.h"
 
 #define TYPE_XLNX_VERSAL "xlnx-versal"
 #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
@@ -65,6 +66,8 @@ typedef struct Versal {
         struct {
             SDHCIState sd[XLNX_VERSAL_NR_SDS];
         } iou;
+
+        XlnxZynqMPRTC rtc;
     } pmc;
 
     struct {
@@ -89,7 +92,10 @@ typedef struct Versal {
 #define VERSAL_GEM1_IRQ_0          58
 #define VERSAL_GEM1_WAKE_IRQ_0     59
 #define VERSAL_ADMA_IRQ_0          60
+#define VERSAL_RTC_APB_ERR_IRQ     121
 #define VERSAL_SD0_IRQ_0           126
+#define VERSAL_RTC_ALARM_IRQ       142
+#define VERSAL_RTC_SECONDS_IRQ     143
 
 /* Architecturally reserved IRQs suitable for virtualization.  */
 #define VERSAL_RSVD_IRQ_FIRST 111
@@ -143,4 +149,6 @@ typedef struct Versal {
 #define MM_PMC_SD0_SIZE             0x10000
 #define MM_PMC_CRP                  0xf1260000U
 #define MM_PMC_CRP_SIZE             0x10000
+#define MM_PMC_RTC                  0xf12a0000
+#define MM_PMC_RTC_SIZE             0x10000
 #endif
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index e263bdf77a9..321171bccef 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -240,6 +240,26 @@ static void versal_create_sds(Versal *s, qemu_irq *pic)
     }
 }
 
+static void versal_create_rtc(Versal *s, qemu_irq *pic)
+{
+    SysBusDevice *sbd;
+    MemoryRegion *mr;
+
+    sysbus_init_child_obj(OBJECT(s), "rtc", &s->pmc.rtc, sizeof(s->pmc.rtc),
+                          TYPE_XLNX_ZYNQMP_RTC);
+    sbd = SYS_BUS_DEVICE(&s->pmc.rtc);
+    qdev_init_nofail(DEVICE(sbd));
+
+    mr = sysbus_mmio_get_region(sbd, 0);
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_RTC, mr);
+
+    /*
+     * TODO: Connect the ALARM and SECONDS interrupts once our RTC model
+     * supports them.
+     */
+    sysbus_connect_irq(sbd, 1, pic[VERSAL_RTC_APB_ERR_IRQ]);
+}
+
 /* This takes the board allocated linear DDR memory and creates aliases
  * for each split DDR range/aperture on the Versal address map.
  */
@@ -323,6 +343,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
     versal_create_sds(s, pic);
+    versal_create_rtc(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
-- 
2.20.1


