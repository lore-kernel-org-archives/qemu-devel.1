Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C4AC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38242206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cL7s36FY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38242206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoas-0002SO-Mj
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFi-0007kO-Ky
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFg-00081B-AA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:25 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:45313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFg-0007y8-3V
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:24 -0500
Received: by mail-wr1-x432.google.com with SMTP id j42so2524811wrj.12
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ibgl5PVRhP+gnfhMETg2bP2CZS3sDh+cN9nWx6vn2LY=;
 b=cL7s36FYYnSUp00+ypOBJCgmw+G/2vEV2CQbGy8J9t9B+p1EW9D/5TmdXXih7O2cUq
 iM8YUgr+QqnpLwYaWh7utijb18STA9RH9QiF+plb3tYH1TFj9k9yAlvh6dfdj0GfPTvM
 dwPh/ExhIirEpwtJZtzO6qsEBXTU5xkjOdG+Knw2zqv9HUNk1U3U5M6fg8qLE9Y/fcG5
 rCjXMyjyJDkoDk5CyD2Cm7X37G5OhSGO0VTLABTvLKYeW3P58Eewm5g2lf29KZyp9bhT
 bhtA2jYks0n8ux50/LshFuuqVPmiV16eydlqbyL558eBc6V/Tb8FWcMebsi73AFOtlz2
 HKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ibgl5PVRhP+gnfhMETg2bP2CZS3sDh+cN9nWx6vn2LY=;
 b=SBCM54xoCtOrE7ysI+pzaNCVEvDS3lSA4xTLOh8qRI+wc7/NufuqSB55zv56ZKch40
 wYFKKxwXNXEfc/RQ2QHkMlC1ICwLeD3SUg0UKW2JOfDmyrZ5uRutIEjlv2dweSL+m7FG
 1RgwfbSzqppKycplApqtmM3i2QaNlXqqbRRfX/ePVK/GFDKfnqQ5tn1GTiSutY2xxB77
 6zLzpRPdUFabEnjr7AlH9jXBxH1E0HZa5QE/tbjYkU3dx/cOfSLsuwnv6BZRpCeKWyxW
 rkmFkzZVT99ozaT5BZqnkFVg38cWgwp+5wvrbdQBbDbSEFJYQGj8pxKLXyVbxPrl9hC2
 zT6A==
X-Gm-Message-State: APjAAAXtn5d05KtTRTv9JuhghX80geoV4SHw1baOsQDmtRVnbJVZ4upD
 v+IPh87DQQlZfWdCjqcu7Q3VamX0eTs8Gg==
X-Google-Smtp-Source: APXvYqx/BN9gd9wnGecgzsuw5AVZys9vKpE7J7y8KWWwYF+MuvDWHLJe6Z8KS3fTm+aQ5ooXkcyzYA==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr29301742wrs.159.1576494562698; 
 Mon, 16 Dec 2019 03:09:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/34] aspeed/smc: Add AST2600 timings registers
Date: Mon, 16 Dec 2019 11:08:44 +0000
Message-Id: <20191216110904.30815-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

Each CS has its own Read Timing Compensation Register on newer SoCs.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-13-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/aspeed_smc.h |  1 +
 hw/ssi/aspeed_smc.c         | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 684d16e3361..6fbbb238f15 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -40,6 +40,7 @@ typedef struct AspeedSMCController {
     uint8_t r_ce_ctrl;
     uint8_t r_ctrl0;
     uint8_t r_timings;
+    uint8_t nregs_timings;
     uint8_t conf_enable_w0;
     uint8_t max_slaves;
     const AspeedSegments *segments;
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 86cadbe4cc0..7755eca3497 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -137,7 +137,7 @@
 /* Checksum Calculation Result */
 #define R_DMA_CHECKSUM    (0x90 / 4)
 
-/* Misc Control Register #2 */
+/* Read Timing Compensation Register */
 #define R_TIMINGS         (0x94 / 4)
 
 /* SPI controller registers and bits (AST2400) */
@@ -256,6 +256,7 @@ static const AspeedSMCController controllers[] = {
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
         .r_timings         = R_TIMINGS,
+        .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
         .max_slaves        = 5,
         .segments          = aspeed_segments_legacy,
@@ -271,6 +272,7 @@ static const AspeedSMCController controllers[] = {
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
         .r_timings         = R_TIMINGS,
+        .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
         .max_slaves        = 5,
         .segments          = aspeed_segments_fmc,
@@ -288,6 +290,7 @@ static const AspeedSMCController controllers[] = {
         .r_ce_ctrl         = 0xff,
         .r_ctrl0           = R_SPI_CTRL0,
         .r_timings         = R_SPI_TIMINGS,
+        .nregs_timings     = 1,
         .conf_enable_w0    = SPI_CONF_ENABLE_W0,
         .max_slaves        = 1,
         .segments          = aspeed_segments_spi,
@@ -303,6 +306,7 @@ static const AspeedSMCController controllers[] = {
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
         .r_timings         = R_TIMINGS,
+        .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
         .max_slaves        = 3,
         .segments          = aspeed_segments_ast2500_fmc,
@@ -320,6 +324,7 @@ static const AspeedSMCController controllers[] = {
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
         .r_timings         = R_TIMINGS,
+        .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
         .max_slaves        = 2,
         .segments          = aspeed_segments_ast2500_spi1,
@@ -335,6 +340,7 @@ static const AspeedSMCController controllers[] = {
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
         .r_timings         = R_TIMINGS,
+        .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
         .max_slaves        = 2,
         .segments          = aspeed_segments_ast2500_spi2,
@@ -350,6 +356,7 @@ static const AspeedSMCController controllers[] = {
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
         .r_timings         = R_TIMINGS,
+        .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
         .max_slaves        = 3,
         .segments          = aspeed_segments_ast2600_fmc,
@@ -365,6 +372,7 @@ static const AspeedSMCController controllers[] = {
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
         .r_timings         = R_TIMINGS,
+        .nregs_timings     = 2,
         .conf_enable_w0    = CONF_ENABLE_W0,
         .max_slaves        = 2,
         .segments          = aspeed_segments_ast2600_spi1,
@@ -380,6 +388,7 @@ static const AspeedSMCController controllers[] = {
         .r_ce_ctrl         = R_CE_CTRL,
         .r_ctrl0           = R_CTRL0,
         .r_timings         = R_TIMINGS,
+        .nregs_timings     = 3,
         .conf_enable_w0    = CONF_ENABLE_W0,
         .max_slaves        = 3,
         .segments          = aspeed_segments_ast2600_spi2,
@@ -951,7 +960,8 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
     addr >>= 2;
 
     if (addr == s->r_conf ||
-        addr == s->r_timings ||
+        (addr >= s->r_timings &&
+         addr < s->r_timings + s->ctrl->nregs_timings) ||
         addr == s->r_ce_ctrl ||
         addr == R_INTR_CTRL ||
         addr == R_DUMMY_DATA ||
@@ -1216,7 +1226,8 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
     addr >>= 2;
 
     if (addr == s->r_conf ||
-        addr == s->r_timings ||
+        (addr >= s->r_timings &&
+         addr < s->r_timings + s->ctrl->nregs_timings) ||
         addr == s->r_ce_ctrl) {
         s->regs[addr] = value;
     } else if (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->num_cs) {
-- 
2.20.1


