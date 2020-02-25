Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDBC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF34206E6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sv0jYyvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF34206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6eeR-0003tE-Tk
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6edL-0002C9-21
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6edI-0004F9-Nf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:38 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6edI-0004DH-DJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:08:36 -0500
Received: by mail-pf1-x444.google.com with SMTP id 4so7593847pfz.9
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DwAs9/rYNqhhr3pFyNf/EdZW6lZM71lcIqrzETrYP1w=;
 b=sv0jYyvuypkYelj8nyHQnFZhbmkV0C3Y51Hp+84NBywENmG9FOJqZpyxMBvmY6JObX
 3xMPn1LO2kVhRZDU/8woSGQwOAN7vLjYedwybPuEjYMCZwOmFlAS3Z6Gror50uZdqIZC
 BQg3VrcA0y8/vkepUeeRPPL8XHVTzV7XqEYLiWbxW9hS89xigBv/hzSVPkbrfrd8nDC0
 VEFB9NaI9fU9d0KsemigWMyV6lacmFg8Io86QvuuBYLwY30uOwRfXHljp/H4Fci69kSy
 MiqvWypLm8jDCnzu5ItM7ry3ZX6Kg/FbvCU6kzgKtU0hgle2ELdTI3oL5113Gdc0SGt+
 3Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DwAs9/rYNqhhr3pFyNf/EdZW6lZM71lcIqrzETrYP1w=;
 b=GlGYvIt8agfc63OPAl+sEHNVLtUZ8U2JfZlzFDvsYzYoNdoDbiQpLKE2jin/I1alIv
 l6UWKtYFW7A0fq1oDw0Gs8+mgXYgBxu6bInvvUxKcIshEHwmUP8hnxZIJM8JP1sx102u
 U8SbP/hCfqjwpCEOB6eWjw7JGX0FK37LWYVKrgux0sxjWGD5fNtYnxPwEvx/TmAIXcvv
 wkvEkMLILhZlblF3lfo/Q9go4M/0LupA94oS/z/+dxylWKRlJ/ot9AIUWlzmd95SyXzN
 xSeIQaGd4US25mFwFNapelO6w6vaeLqn/x3BcjKc865dLPYM7HdBHFNCqlcFtDh/Ej9A
 Krgg==
X-Gm-Message-State: APjAAAW78s1vvQU0XUmIAiTDhGJ5Ej4+7hn8ysrspiwHpblLt+DzuoqE
 5RNFTvmkDm2Qeg9OPmnT7vZWmY9JP8o=
X-Google-Smtp-Source: APXvYqwqjp1Pi/GF/m+jA4uzHk4f283yPO7JuVZDrVe36OKhk6U/x2yTCpsYbN0JU3vJrhG7FbpKGw==
X-Received: by 2002:a62:446:: with SMTP id 67mr55553627pfe.109.1582654114693; 
 Tue, 25 Feb 2020 10:08:34 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id d69sm19069704pfd.72.2020.02.25.10.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 10:08:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/7] target/arm: Improve masking of HCR RES0 bits
Date: Tue, 25 Feb 2020 10:08:25 -0800
Message-Id: <20200225180831.26078-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225180831.26078-1-richard.henderson@linaro.org>
References: <20200225180831.26078-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Don't merely start with v8.0, handle v7VE as well.
Notice writes from aarch32 mode, and the bits that
ought not be settable from there.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 79db169e04..d65160fdb3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5089,8 +5089,13 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[] = {
 static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
-    /* Begin with bits defined in base ARMv8.0.  */
-    uint64_t valid_mask = MAKE_64BIT_MASK(0, 34);
+    uint64_t valid_mask;
+
+    if (arm_feature(env, ARM_FEATURE_V8)) {
+        valid_mask = MAKE_64BIT_MASK(0, 34);  /* ARMv8.0 */
+    } else {
+        valid_mask = MAKE_64BIT_MASK(0, 28);  /* ARMv7VE */
+    }
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
         valid_mask &= ~HCR_HCD;
@@ -5114,6 +5119,14 @@ static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         valid_mask |= HCR_API | HCR_APK;
     }
 
+    if (ri->state == ARM_CP_STATE_AA32) {
+        /*
+         * Writes from aarch32 mode have more RES0 bits.
+         * This includes TDZ, RW, E2H, and more.
+         */
+        valid_mask &= ~0xff80ff8c90000000ull;
+    }
+
     /* Clear RES0 bits.  */
     value &= valid_mask;
 
-- 
2.20.1


