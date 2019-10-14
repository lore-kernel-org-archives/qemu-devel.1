Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8B4C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089222133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+YQ1Sem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089222133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3j5-0001el-Ej
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qu-0005X5-9V
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qt-0008GD-2o
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:44 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qs-0008Fr-T3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id b9so20414959wrs.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5mJ0GPrObe+pueZ1GTRIi8XqZtfYiyJoa0nyAQxJfzA=;
 b=H+YQ1SemLM71n5ni4tE20PJB/OT6wdi7eDL7Oh/5+27r68/X0BRoJU9L+4+gI3+Cre
 /GlJjIZUj5lXkJ4p/wFjTonjpnlcS6EhkYr+3xU2sBvEUEugx8dQCsPjMBeZsGB8TgGu
 QfubcusS873uxqEmJWtrlaUj3Ve+TeIkOtHSS/VXtPYP8vdPfkr+Ofb+oAe1GIXbmcpq
 4xuGgzYqTWHV2FMQCDJ5T1b0BphV44xVT9jtCUhXhlkExzUDV0tDEMaaUc/7ZGTYcOqx
 Om7QKoDckN0JfGGSVtxxgeKQy3oUdkzvSsTG0ZITjLpgit0IosGDjIZ+AJttdny4UkzW
 eSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5mJ0GPrObe+pueZ1GTRIi8XqZtfYiyJoa0nyAQxJfzA=;
 b=jKVfms911LpgGagCxOsjiVuGR3blQpcqgmgwbueznqsApB/AVrHAe2O4q7gNV08BbI
 wmEic/0d9Ak1EQwLZG78aqv4xma6zfXjSwSfDfBPNsMIYtpWEX7Lr5cNPZq2SUG+g8kY
 lnw5FgKgHv4UldVb0Sl4vfGbfeILrgUFPFF7m3Na5nTygu2Yf5api7lvbMRRwOHSRSdd
 CFo7Fh5Ucfa3wVw1ZxuihAsRoFIpu/srZjimx0K2aKmyDnYFl+m4wjrz5vWrmNMsyDQA
 pg891QV3R6gya31D9N0ZumPoEfzenERdc45tyhPKSlMqx9kmA9C+dQjI+jRFglj8ExRQ
 TenA==
X-Gm-Message-State: APjAAAVAigOpSun1qvsigqXtT4POP/ngf7mHRZ5rlcDWtKzC16pJKFjI
 pOTs4Tt+3C+izFcWHtNbFDj7SwLxch3iLw==
X-Google-Smtp-Source: APXvYqyDDYZzp4r2ixayQ/IQd1lZ93595kGZxZCzaaLoYE7pdJrcG2QACEVsA6vk/6Px2xlhVWReYA==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr26479638wrr.220.1571069141489; 
 Mon, 14 Oct 2019 09:05:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/68] aspeed/soc: Add ASPEED Video stub
Date: Mon, 14 Oct 2019 17:03:58 +0100
Message-Id: <20191014160404.19553-63-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

From: Joel Stanley <joel@jms.id.au>

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190925143248.10000-24-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h | 1 +
 hw/arm/aspeed_ast2600.c     | 5 +++++
 hw/arm/aspeed_soc.c         | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 43478f61787..cccb684a19b 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -96,6 +96,7 @@ enum {
     ASPEED_SDMC,
     ASPEED_SCU,
     ASPEED_ADC,
+    ASPEED_VIDEO,
     ASPEED_SRAM,
     ASPEED_SDHCI,
     ASPEED_GPIO,
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index af047463a35..931887ac681 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -44,6 +44,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_SCU]       = 0x1E6E2000,
     [ASPEED_XDMA]      = 0x1E6E7000,
     [ASPEED_ADC]       = 0x1E6E9000,
+    [ASPEED_VIDEO]     = 0x1E700000,
     [ASPEED_SDHCI]     = 0x1E740000,
     [ASPEED_GPIO]      = 0x1E780000,
     [ASPEED_GPIO_1_8V] = 0x1E780800,
@@ -236,6 +237,10 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
                                 ASPEED_SOC_IOMEM_SIZE);
 
+    /* Video engine stub */
+    create_unimplemented_device("aspeed.video", sc->memmap[ASPEED_VIDEO],
+                                0x1000);
+
     if (s->num_cpus > sc->num_cpus) {
         warn_report("%s: invalid number of CPUs %d, using default %d",
                     sc->name, s->num_cpus, sc->num_cpus);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 6defb143acd..f4fe243458f 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -34,6 +34,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] = {
     [ASPEED_SDMC]   = 0x1E6E0000,
     [ASPEED_SCU]    = 0x1E6E2000,
     [ASPEED_XDMA]   = 0x1E6E7000,
+    [ASPEED_VIDEO]  = 0x1E700000,
     [ASPEED_ADC]    = 0x1E6E9000,
     [ASPEED_SRAM]   = 0x1E720000,
     [ASPEED_SDHCI]  = 0x1E740000,
@@ -63,6 +64,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
     [ASPEED_SCU]    = 0x1E6E2000,
     [ASPEED_XDMA]   = 0x1E6E7000,
     [ASPEED_ADC]    = 0x1E6E9000,
+    [ASPEED_VIDEO]  = 0x1E700000,
     [ASPEED_SRAM]   = 0x1E720000,
     [ASPEED_SDHCI]  = 0x1E740000,
     [ASPEED_GPIO]   = 0x1E780000,
@@ -231,6 +233,10 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOMEM],
                                 ASPEED_SOC_IOMEM_SIZE);
 
+    /* Video engine stub */
+    create_unimplemented_device("aspeed.video", sc->memmap[ASPEED_VIDEO],
+                                0x1000);
+
     if (s->num_cpus > sc->num_cpus) {
         warn_report("%s: invalid number of CPUs %d, using default %d",
                     sc->name, s->num_cpus, sc->num_cpus);
-- 
2.20.1


