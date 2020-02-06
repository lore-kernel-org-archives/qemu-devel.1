Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ECE820659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1pxkHgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECE820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izeqw-00006h-GR
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeo9-0002mA-Fi
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeo8-0005wx-HF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:53 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeo8-0005qg-Ai
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:52 -0500
Received: by mail-wr1-x444.google.com with SMTP id t3so6559384wru.7
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QYKU+SD8NVKPGAhIlG5/BkNy77M1mMPU6YzTLu1/WC0=;
 b=H1pxkHgYU34fqQAzGYt0D56hRIMd8D5gSrHAIOIUUpg2VUIALLgLpBgsqb5fYWnOdL
 nWwKARUdmDYe5smYTGKijAnvoHxV6HvO6bDFwPMW5hrSJcPAtV8Jw29D5sHRetejm6Rf
 xaLcSUZ0rOj/a4tCxLNntvKhZhwaOdspAk+F/U+ElRGjROMLl4i9pd4eYaBabvEu/oEq
 W/DJTnjYBmXF2kC7yQH3gEX6boc/FFhsHwIKpZN3VuC4kxsKtJh9CwYruzU2kwZ2tNGm
 ISSKUoJskMdqYbX6P3ugnsLJ9KYhKKfU7me/GzjSvrJLePhEty4gkrWb9PbAXhqGAbqb
 O3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYKU+SD8NVKPGAhIlG5/BkNy77M1mMPU6YzTLu1/WC0=;
 b=B4zdu5Y3UhBEH+CtzeoPcKc2feX3fawwDD60T3SObOqBReVggHOPvNAbLFXPKm8M5M
 jFKFOVkPiGcK9Io5YpPHePhtkw3cimJ4Cfo7ZWsJoYsrWV4Jy2cwAtJcmJflGiLsJSzn
 PJt5J620DnFWDNMOKM4tY5lDCnt+28ahG0hjLCHDmOqxo9HXav6lBQOAZhIj6S9w+8kr
 ukEF6HWqx9cvqN79mDNzy8gRH/n/lKKhenK3AfPo70c3Kc5R+sBvoyp+UJqtpgTT/0+3
 AEYR68P8Z1/U4LL+yi5gMVaLHSD0pb4TUzs3rTAB5C0MatDBgDGS2DwgxEJiNcd4DZCa
 Q0aQ==
X-Gm-Message-State: APjAAAXimPWjONqMqbafmBdeTgKUsi0mCWCrT6XlKiJlh6bVa1uGbXpQ
 MG8GbWmqsTyJ0zgWHsEOEkW+JdS/qA1hrQ==
X-Google-Smtp-Source: APXvYqwdTNfzPJI48JYTwYJmd3G7q5gA4OGdcZzDog8FnuU/f5/nMErlPSNhfqBIdbCTtkpL6N0GMw==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr3116671wrh.49.1580986491024;
 Thu, 06 Feb 2020 02:54:51 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:54:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/41] target/arm: Enable HCR_E2H for VHE
Date: Thu,  6 Feb 2020 10:54:09 +0000
Message-Id: <20200206105448.4726-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 7 -------
 target/arm/helper.c | 6 +++++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2a53f5d09b..0e68704a90 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1424,13 +1424,6 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_ATA       (1ULL << 56)
 #define HCR_DCT       (1ULL << 57)
 
-/*
- * When we actually implement ARMv8.1-VHE we should add HCR_E2H to
- * HCR_MASK and then clear it again if the feature bit is not set in
- * hcr_write().
- */
-#define HCR_MASK      ((1ULL << 34) - 1)
-
 #define SCR_NS                (1U << 0)
 #define SCR_IRQ               (1U << 1)
 #define SCR_FIQ               (1U << 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19a57a17da..f5ce05fdf3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4721,7 +4721,8 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
-    uint64_t valid_mask = HCR_MASK;
+    /* Begin with bits defined in base ARMv8.0.  */
+    uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
@@ -4735,6 +4736,9 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
          */
         valid_mask &= ~HCR_TSC;
     }
+    if (cpu_isar_feature(aa64_vh, cpu)) {
+        valid_mask |= HCR_E2H;
+    }
     if (cpu_isar_feature(aa64_lor, cpu)) {
         valid_mask |= HCR_TLOR;
     }
-- 
2.20.1


