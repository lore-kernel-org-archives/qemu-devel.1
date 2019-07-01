Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A76C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF1F21721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 00:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPUIPgOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF1F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi6ez-0003Ks-8B
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 20:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51717)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi49X-00055t-Ac
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi49V-0007tU-0D
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:47:59 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:35496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi49U-0007p1-KF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:47:56 -0400
Received: by mail-wm1-f53.google.com with SMTP id c6so1081770wml.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pigEtb5VD7XCWgXu8Dli8Jr+xIcMfHiGbTXOqk3Rhsw=;
 b=vPUIPgOjkGlkRG6lx/rCNLO7Iw+3S0ripCG9sc1xsogG9PgBE9Rpd+1Xk2cGvaKWyI
 eWt+CGyTi5aSrZv1FrS5xRN5Eo3f85N7RdRFDjFdYqB/5UcFDbKL7PewScczaRWGf+X1
 iiRZTWGYd1uf9ypmgyEGcZFibYLTEPCZSvJ2wamf+QSknfFbR0N4LscAjrm62tMFSRNP
 clMzD2nGAJJlKHh4vRrjyMIeZ4dpjbUgrlEy/944+UPDrHDylj37Vv7XYKqQ6DHtfpw5
 B4HNSxKrP6J24hUGneYWGTHGYVRbUW7bXm21ROWY41yeCrWnasXryOnrcX1GceypVSl3
 r+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pigEtb5VD7XCWgXu8Dli8Jr+xIcMfHiGbTXOqk3Rhsw=;
 b=WIRe65lcFHhTt1VyC05dRptvo+L2jRfdvGukOIV86fZ6JXptC5vssN9UsBUF8zX8Ru
 nEr3Un6IBckY3PHfU9bfCOsq50koy5uNN9vYSjsFKk1PhvS/aRIwdwnVmCKBoyeKMmj2
 dLzyP4M0QA8bWLxm96e2k2QBkzFldBCysQTZse475HwRhRpbrB0i/pDAtjL5Bu5QmHoW
 pd+Prq9QX5k+/pPwzxBdqjKRzbDMJVpRHwzXHsJdhMpqFSuYYcl5vPM5WwzOihUYpNgk
 WYZQdrrO72M8G5PgziLCIZB0YiEI+GxlrP+dOqqRdM/oRGKzk0FDziCwRDC1muH1R9lR
 l1rg==
X-Gm-Message-State: APjAAAUy96ntKiwvvkG36yHedmiVCoLioBopQOTuPoUdMtmSDz8I597d
 6wE7+55o68Fa+hVAGmMcfGfpVHuMl7eIGQ==
X-Google-Smtp-Source: APXvYqwprTbJML91UkqV0ad/rE4aw0+YEOZyt4g6w5IZAm8A2LCqc1pQGgRpuY8E6AMHKjWi4B2V/A==
X-Received: by 2002:a1c:c109:: with SMTP id r9mr106069wmf.143.1561999207940;
 Mon, 01 Jul 2019 09:40:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:18 +0100
Message-Id: <20190701163943.22313-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.53
Subject: [Qemu-devel] [PULL 21/46] aspeed/smc: add a 'sdram_base' property
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

From: Cédric Le Goater <clg@kaod.org>

The DRAM address of a DMA transaction depends on the DRAM base address
of the SoC. Inform the SMC controller model with this value.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190618165311.27066-15-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/aspeed_smc.h | 3 +++
 hw/arm/aspeed_soc.c         | 6 ++++++
 hw/ssi/aspeed_smc.c         | 1 +
 3 files changed, 10 insertions(+)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 3b1e7fce6c8..591279ba1f4 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -97,6 +97,9 @@ typedef struct AspeedSMCState {
     uint8_t r_timings;
     uint8_t conf_enable_w0;
 
+    /* for DMA support */
+    uint64_t sdram_base;
+
     AspeedSMCFlash *flashes;
 
     uint8_t snoop_index;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 736e52366a6..02feb4361ba 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -337,6 +337,12 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_I2C));
 
     /* FMC, The number of CS is set at the board level */
+    object_property_set_int(OBJECT(&s->fmc), sc->info->memmap[ASPEED_SDRAM],
+                            "sdram-base", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9eda0d720be..81f2fb7f707 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -913,6 +913,7 @@ static const VMStateDescription vmstate_aspeed_smc = {
 
 static Property aspeed_smc_properties[] = {
     DEFINE_PROP_UINT32("num-cs", AspeedSMCState, num_cs, 1),
+    DEFINE_PROP_UINT64("sdram-base", AspeedSMCState, sdram_base, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


