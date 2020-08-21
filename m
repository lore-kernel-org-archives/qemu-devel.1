Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A29C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C7E20702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOs8EEQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C7E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9AuL-0006qk-0V
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Ar1-00013T-Kb; Fri, 21 Aug 2020 13:29:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Ar0-00019S-43; Fri, 21 Aug 2020 13:29:27 -0400
Received: by mail-wr1-x442.google.com with SMTP id z18so2625650wrm.12;
 Fri, 21 Aug 2020 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MF7ZA/p+idAn4SvK+rkvL+g7qzoSAv8079JD7F/Jx7o=;
 b=XOs8EEQS24hJnGKjsNLLt8hx5jXjk/iGXAXjELZKOc0BR4jj/ndRvgYlgvkOTEv85O
 lXVeA53QdFaoQKNzDmceb0x/u0Us4qujZZQA2Vzmu9iyn6ONPxMZbesA6VfiM1dvPwjv
 EEb+sa6FgiPFtlS/yt5dlVSsq+b11eJD60cAGLo0ecgxNzB/MqkRxPkrfOpebNZpIr+u
 NftgaWQTI0vpoGjiGDj0CqCviyFEprEGByhVQ419p5ZbtnnvnNeysNODm7xoHu6aY5QQ
 NA6ttHw5Tbq8nZ5ebEbsqsbwEvufXTQj0LRoN0RqPLKSXdHAbkNUxSFUKo+BpUmLjiUI
 EDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MF7ZA/p+idAn4SvK+rkvL+g7qzoSAv8079JD7F/Jx7o=;
 b=pgDf7/CU/Wz3XS7ZQ3s5DVVnyiqUYAL0llf6DtZ7yOMIit/oApcvqGv5Nfmk+C9EEN
 9EegfkwHhXm8EZ5/t9gYlWYSCV3kToNO8F2PssnA/ZkxWwpBAsQ2/RZVNm/IubgOHG2G
 jZ9xntsMlrDXNP3hNbwWv0wHGVmhu06hQDxQ2sFOJNBiaUfSHwE0NZAvvWQR/bbhFH0M
 SwZH5JssfuVcUe69qrOWUmQTlqiK8HL9GQDPRrZ/QUddGhiXsEqIaPg5zUJlW6ke2BRU
 dwtiK/otuX7ni3O/fdrmKJBNbkAUTHzEua+dQ0omfPco/7z8jfDC17vd9ZNIht2OK24g
 lD+Q==
X-Gm-Message-State: AOAM530VNrSPX38oy0gA1/Ag81smVD3GEKO2PCTOc55n1VC1a/HjcWue
 RLTDRjvfQ3EfAO6HTKtkSgfCrZ1bCXE=
X-Google-Smtp-Source: ABdhPJx/I0FfIcQOeH2n2r5e8UHBb21Kr0xxpzEu1Lz4X3Uu7bc57tHiSaO0j2jte138CJSMThnX3w==
X-Received: by 2002:adf:c401:: with SMTP id v1mr3481858wrf.379.1598030963449; 
 Fri, 21 Aug 2020 10:29:23 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/23] hw/lm32/milkymist: Un-inline milkymist_memcard_create()
Date: Fri, 21 Aug 2020 19:28:56 +0200
Message-Id: <20200821172916.1260954-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we will modify milkymist_memcard_create(), move it first
to the source file where it is used.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200705211016.15241-2-f4bug@amsat.org>
---
 hw/lm32/milkymist-hw.h | 11 -----------
 hw/lm32/milkymist.c    | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/lm32/milkymist-hw.h b/hw/lm32/milkymist-hw.h
index 05e2c2a5a75..5dca5d52f57 100644
--- a/hw/lm32/milkymist-hw.h
+++ b/hw/lm32/milkymist-hw.h
@@ -31,17 +31,6 @@ static inline DeviceState *milkymist_hpdmc_create(hwaddr base)
     return dev;
 }
 
-static inline DeviceState *milkymist_memcard_create(hwaddr base)
-{
-    DeviceState *dev;
-
-    dev = qdev_new("milkymist-memcard");
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-
-    return dev;
-}
-
 static inline DeviceState *milkymist_vgafb_create(hwaddr base,
         uint32_t fb_offset, uint32_t fb_mask)
 {
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 85913bb68b6..469e3c43225 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -80,6 +80,17 @@ static void main_cpu_reset(void *opaque)
     env->deba = reset_info->flash_base;
 }
 
+static DeviceState *milkymist_memcard_create(hwaddr base)
+{
+    DeviceState *dev;
+
+    dev = qdev_new("milkymist-memcard");
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+
+    return dev;
+}
+
 static void
 milkymist_init(MachineState *machine)
 {
-- 
2.26.2


