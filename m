Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3AEC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79EC20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOnRmYN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79EC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04vo-0004iU-TG
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hv-0000X2-VC
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hu-00030a-Od
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:11 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hu-0002yV-I9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:10 -0500
Received: by mail-wr1-x42a.google.com with SMTP id z3so2975100wru.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rxcmSjc94icr6+uwtwHt09u/0NyBfMXfDwhxl/QyRPs=;
 b=wOnRmYN2spVT95sm8UnUWSL5Lh2jyGti/u4uaT9lFw42cRxQ8CB02ivZVygueoScMd
 Wso/uqst1kA4Dv1Sb60z+VLsh54Sh1haJ/BjyDUl3u//TJKgt1NZ6gj5H6xJDKv+xLFp
 l/CNSMjKq4JQ/I9XIsl0wAuwLwBOiXcwSqUe+8JY6HgwOJyScdudcYawdDGAsiWWRDbn
 qcLUvYFYLmQ4dRV4HtYBxC8tBF5EoMA4Uz4h1hYeGonuzb2wfbdwl36lCqOd0RCrYEhW
 FKn1NwoY5vdNfSq/YPN7s0jDXT02HTeGtL7zyaSTtH5xM73PzUM4CbR7YiDasjDOrDOw
 yJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rxcmSjc94icr6+uwtwHt09u/0NyBfMXfDwhxl/QyRPs=;
 b=HVaDULt2e/4XO5FrG+xI7x3AI4gqC8uoYUh0VDBm3aTLvSjpS4/cnWcv4d8/KoD1/y
 JqSiYxz/iRN690jHcJu6rSq0+mVTBJ3p1t8+EOHpH9ubg9MtNex+fMrov+FT2rEYg2iJ
 SmiyEUzd9UPaCPlTDlCO09rGCSWSBpxIO0JWd1Kzc5PgQMnMZlDmBlUpXLuQMEM3/ILw
 KO7HsIeHU7KPXfXDgvafSwaWmghzbipiEsTF36p1xAjfIGhrlL9jWrVFsqA5+gFY3kxb
 1eCglS/ELVTT1a1xeeBJDUIZOZZmaJeUrZzczboJCME0Cjviv5S0XdjK9uSM5E5JSjCy
 Je5A==
X-Gm-Message-State: APjAAAX+2cJVYzMCayecNu+nXxkY34Bjxvsfh28nTw3ZHmhBVsQy94+w
 rFj70wPF3lrgaXA8OQcMbRcmusD0vLw=
X-Google-Smtp-Source: APXvYqyI95Y6fizM43nsb4Ul/yXd0iTpSov43lgotfVsJFUb64I8g1aoHMOWfeEkyhlmTUNIm+9T8w==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr5299970wrt.229.1581086049334; 
 Fri, 07 Feb 2020 06:34:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/48] target/arm: Update arm_mmu_idx for VHE
Date: Fri,  7 Feb 2020 14:33:17 +0000
Message-Id: <20200207143343.30322-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

From: Richard Henderson <richard.henderson@linaro.org>

Return the indexes for the EL2&0 regime when the appropriate bits
are set within HCR_EL2.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f7bc7f1a8de..9f8d7ca1f36 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11318,12 +11318,16 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
+    /* See ARM pseudo-function ELIsInHost.  */
     switch (el) {
     case 0:
-        /* TODO: ARMv8.1-VHE */
         if (arm_is_secure_below_el3(env)) {
             return ARMMMUIdx_SE10_0;
         }
+        if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)
+            && arm_el_is_aa64(env, 2)) {
+            return ARMMMUIdx_E20_0;
+        }
         return ARMMMUIdx_E10_0;
     case 1:
         if (arm_is_secure_below_el3(env)) {
@@ -11331,8 +11335,11 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         }
         return ARMMMUIdx_E10_1;
     case 2:
-        /* TODO: ARMv8.1-VHE */
         /* TODO: ARMv8.4-SecEL2 */
+        /* Note that TGE does not apply at EL2.  */
+        if ((env->cp15.hcr_el2 & HCR_E2H) && arm_el_is_aa64(env, 2)) {
+            return ARMMMUIdx_E20_2;
+        }
         return ARMMMUIdx_E2;
     case 3:
         return ARMMMUIdx_SE3;
-- 
2.20.1


