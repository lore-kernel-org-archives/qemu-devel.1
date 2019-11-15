Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95FFC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FCF2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBsTUf/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FCF2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdsG-0000Ln-T0
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iVdp4-00051G-8b
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iVdp3-0008WV-4l
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:47:46 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iVdp2-0008VS-UW; Fri, 15 Nov 2019 10:47:45 -0500
Received: by mail-wr1-x444.google.com with SMTP id a15so11472452wrf.9;
 Fri, 15 Nov 2019 07:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EhldZdS5Wt/T5242OfGlTFdhubpjsMLPTiMqB/4zddA=;
 b=sBsTUf/HG8TWoOP+phHVOn0uf2GYkfAHtfZfdHi8x4NQmzedYZ8dkm+2oHrz9d7bWe
 fIy7WVQk3ohch1IMZdGEqM9R0tWSC5wM3HF1jV8upS47pJMWEl5ZTwMIsi1Tzj80bo94
 qnM8SeXfSWxRpXsiewiGCffpCYhUzcP6XdCAJzZ7b54P9nuc3A4ww8iwpdVXc9A6hnTX
 2JYAwJL50IzfR2oIR5YQV2ur128Kf1PjWNXfvZbLqhBYD+oFGX6/lu6WB3M7v9hmXbUP
 lyDhHk9Q/Mxvi2wFQj7Gq3nza/sl43o9EVydxHsLIkRiCS9/4jimXhnhSQKuHkTWfFjA
 oBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EhldZdS5Wt/T5242OfGlTFdhubpjsMLPTiMqB/4zddA=;
 b=MB7OEQEkgTqciApjTPp8QjpYdarm1vhtXAZNlUL6rwOlCFq3Oqa+dhVL7G8pigxXXJ
 TaKPyTbOiNy3oCTyl9shX9rxqz7w9NY67UwgFO6J06GQyqfsGGSqVESX7x/i8r6hmuta
 zJ+9zWe6EzfEEqNlJ77pOUtY2GA2VgyV+bYo8/V1fHd7QwMrOXni974ZEY5V1VuAQQ9y
 eCS94oObMuHwmI00qyIgPjVtTf68jnzPwUQcny1I0sUCjN08YVIF91muamjYNtgGluA1
 Ticz6VmyeKRol2Fo13o+TTwpCKyqEMraagwaA88ifvTlGMxjReDgu6RQl2ow0nBA+i5r
 Spdg==
X-Gm-Message-State: APjAAAVXPRDxhPSaJhmHOf3ffq5TNkunPv6go7thohYoOtyX4N7x4w+8
 jy190OiHJMZygQtcEZyshKueXbkcA8Q=
X-Google-Smtp-Source: APXvYqySTJ1b7A4LBcRAQAj3C/1OIyA2J0mtfffTbyZ73aQdCD8YhVuXWOqEla+IcPiy5sM2xGwQcw==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr16676423wro.392.1573832863637; 
 Fri, 15 Nov 2019 07:47:43 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id 17sm9428752wmg.19.2019.11.15.07.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 07:47:42 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] hw/arm: versal: Add the CRP as unimplemented
Date: Fri, 15 Nov 2019 16:47:34 +0100
Message-Id: <20191115154734.26449-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191115154734.26449-1-edgar.iglesias@gmail.com>
References: <20191115154734.26449-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Add the CRP as unimplemented thus avoiding bus errors when
guests access these registers.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal.c         | 2 ++
 include/hw/arm/xlnx-versal.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 98163eb1aa..8b3d8d85b8 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -257,6 +257,8 @@ static void versal_unimp(Versal *s)
                         MM_CRL, MM_CRL_SIZE);
     versal_unimp_area(s, "crf", &s->mr_ps,
                         MM_FPD_CRF, MM_FPD_CRF_SIZE);
+    versal_unimp_area(s, "crp", &s->mr_ps,
+                        MM_PMC_CRP, MM_PMC_CRP_SIZE);
     versal_unimp_area(s, "iou-scntr", &s->mr_ps,
                         MM_IOU_SCNTR, MM_IOU_SCNTR_SIZE);
     versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps,
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 14405c1465..d844c4ffe4 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -119,4 +119,7 @@ typedef struct Versal {
 #define MM_IOU_SCNTRS_SIZE          0x10000
 #define MM_FPD_CRF                  0xfd1a0000U
 #define MM_FPD_CRF_SIZE             0x140000
+
+#define MM_PMC_CRP                  0xf1260000U
+#define MM_PMC_CRP_SIZE             0x10000
 #endif
-- 
2.20.1


