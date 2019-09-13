Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E7AC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477BC20640
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fScq1Bf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477BC20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ns1-0000vl-FK
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npg-0007Ts-QF
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8npf-0000oj-OO
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:50:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8npf-0000oM-Ij
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:49:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id x2so3297607wmj.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HwYqxy/bmpDz5O1ucFFc7CGqvNwTRTsg+04HLrtha5U=;
 b=fScq1Bf1Nzy077kbEzY2l5n4O+oGu/ukLdXJFFof25g9IX+5pPWN3u40lYuvE6vyi2
 UAYD041+EbrjU0UnPOqrhzCsljCpkqx6MgnMPpd/hbKeMM+CA/lAci0mEFyI01n5Hqtp
 5RzXWff2DQbHh8L4NSvvJYZSCWb6wrD4gMwp4Drlhg1Vr0gK4Y3mq320ARfPKE4CUVIp
 5qfVYN3EjvYKfubmFTASg7dUL8kJ0I2Mrs1L3bzIlhHfWvN8L8IVT/DS3Eh6g+VSLDGM
 xMoI/JauwWWijqNnWSGMhCvk2AjRFM9i7rlFrXH7vK4pewjmXGP7UDggJCdwXuKcTQms
 yvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HwYqxy/bmpDz5O1ucFFc7CGqvNwTRTsg+04HLrtha5U=;
 b=N0ePXCbyKddh214BcqY0tsGAmyoW5B4n6jvKerJbqE4XjZ6hXbs6rLG3OZApGO9yd6
 Vmw9Rua3rsTa68tB1e2mklG5zYI3c/qb9pxOUXrk6JORWwgSKiQJB9ouOukeh+oXvBG3
 78rh+IQiitS7Lgn1XtVHTr+9ZUt7iKBDDnhpKWxsiJt9jz0RXEUZB2dtUmBWGdu1J1HU
 RGJajSV3/aMIAbiluB5Udd8Im65ul1WRSQA2CfDTbnF0w9ympm4GL4XpEHdtnISyBbrr
 lkAsWgfPBXb1iOVv/mWB4tgTO6XlO++LdBhINDVPNsz68l+r121wKPZAFndM6wPURZio
 fc9Q==
X-Gm-Message-State: APjAAAVJus9blwx4EtRxti5IPVLhlxIxRRG+PLZx7/PtgFqhAzcVgJp5
 DyV2LRhtgPYVKB6zQDSMko+cgbPdKllgYA==
X-Google-Smtp-Source: APXvYqzwdeENPcz7n70WLRy0FzuYbRPzdvUjHATdKsvdvOj8jlQgJZfJZutes77ZXQVXcP0Rhq0qdg==
X-Received: by 2002:a05:600c:290c:: with SMTP id
 i12mr3995936wmd.19.1568389798380; 
 Fri, 13 Sep 2019 08:49:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c132sm3562207wme.27.2019.09.13.08.49.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 08:49:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 16:49:43 +0100
Message-Id: <20190913154952.27724-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913154952.27724-1-peter.maydell@linaro.org>
References: <20190913154952.27724-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PULL 03/12] aspeed: Remove unused SoC definitions
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

There are no QEMU Aspeed machines using the SoCs "ast2400-a0" or
"ast2400".

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190904070506.1052-4-clg@kaod.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_soc.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 04480875d0d..3aa73d2438e 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -118,19 +118,6 @@ static const char *aspeed_soc_ast2500_typenames[] = {
 
 static const AspeedSoCInfo aspeed_socs[] = {
     {
-        .name         = "ast2400-a0",
-        .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
-        .silicon_rev  = AST2400_A0_SILICON_REV,
-        .sram_size    = 0x8000,
-        .spis_num     = 1,
-        .fmc_typename = "aspeed.smc.fmc",
-        .spi_typename = aspeed_soc_ast2400_typenames,
-        .gpio_typename = "aspeed.gpio-ast2400",
-        .wdts_num     = 2,
-        .irqmap       = aspeed_soc_ast2400_irqmap,
-        .memmap       = aspeed_soc_ast2400_memmap,
-        .num_cpus     = 1,
-    }, {
         .name         = "ast2400-a1",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
         .silicon_rev  = AST2400_A1_SILICON_REV,
@@ -143,19 +130,6 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .irqmap       = aspeed_soc_ast2400_irqmap,
         .memmap       = aspeed_soc_ast2400_memmap,
         .num_cpus     = 1,
-    }, {
-        .name         = "ast2400",
-        .cpu_type     = ARM_CPU_TYPE_NAME("arm926"),
-        .silicon_rev  = AST2400_A0_SILICON_REV,
-        .sram_size    = 0x8000,
-        .spis_num     = 1,
-        .fmc_typename = "aspeed.smc.fmc",
-        .spi_typename = aspeed_soc_ast2400_typenames,
-        .gpio_typename = "aspeed.gpio-ast2400",
-        .wdts_num     = 2,
-        .irqmap       = aspeed_soc_ast2400_irqmap,
-        .memmap       = aspeed_soc_ast2400_memmap,
-        .num_cpus     = 1,
     }, {
         .name         = "ast2500-a1",
         .cpu_type     = ARM_CPU_TYPE_NAME("arm1176"),
-- 
2.20.1


