Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61714C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD702224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNpp+dS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD702224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuMd-00018K-Ib
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0x-0004wX-AJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0v-0003ue-Fv
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id i1so2798468wro.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FowuUdgPQYyMq4aZYTGoaCziepWA2LAbbAYSLaMy7xQ=;
 b=pNpp+dS3ZiyI+fdLUaV6f3Hw6HhMIc/4VL/LNTCDCdWgemUBdBZaJnVznVNItm9zTX
 AjP584Lu2N89OEJD74v71dIiRLnp8AkdROjSatHiEMvs7wy5wKHHDm88F61oMCT7VZIc
 NI2puEatX5uJe5x9g3ClHKagqt6gDR8YsghYZxlOLUqnSjJJ99wiHrQbrfY9fUasn9oV
 42bZtgmP2zc4jEcfmumTuDHw6ikJVhNssdk3oYDIbLShoyIldB5UrjcCLjOTbY+D+aN2
 Gj1f3ZFcUsUZe5nnLnh3E5UoMNy80O+0R/KH5F1KsHE227uAGKgfvUkPNXXMeIlTfiaD
 ui9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FowuUdgPQYyMq4aZYTGoaCziepWA2LAbbAYSLaMy7xQ=;
 b=a6tr8Qq8i3Tfo0+6hX4J5VduZOxIyEpsWd0bAEcyptWztZOmJS48zPQr06s/RqCqHp
 sZOsH5pKZQX/Ef8eqajDYtX3K6kbnl9XA+GtdY2J+YoAlqPOfZBeLO5cVuFPKd6mtnYK
 TRgPbu1pzmy9VEnEkylLU/q/Nkj9gBlMwMk94AjSYvYTLZH0nYKFMHt3glY+pe97hMLV
 HyWvCtZTRE566zkTuaeCOk6Viw8d/CZSzXHhbwKjianeAuSkU4euPJbTpl28AzsoihZL
 gma3VVuw3+T4i/x9r1x+qhk7N0KXIuFk4qArcDuVqzi7Qr7nBG2M/01vVfoumQW0n5TL
 aDsw==
X-Gm-Message-State: AOAM531RFELbnbl+CfAw+HrnqEOSZtgW280MuUlGwNEePn00ReK/j+/X
 kEKBD8/wcfd4v6lnXgpDTDDyqcf1l2aXyg==
X-Google-Smtp-Source: ABdhPJwWTqz1HMYPevrosE9msjy2s0ezWFwmQ0ohm17UrD6oKnSTxhSxIkrEwZGOHwh+6oqufDoLkA==
X-Received: by 2002:a05:6000:1084:: with SMTP id
 y4mr4074898wrw.138.1603209447264; 
 Tue, 20 Oct 2020 08:57:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/41] target/arm: Ignore HCR_EL2.ATA when {E2H,TGE} != 11
Date: Tue, 20 Oct 2020 16:56:32 +0100
Message-Id: <20201020155656.8045-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Unlike many other bits in HCR_EL2, the description for this
bit does not contain the phrase "if ... this field behaves
as 0 for all purposes other than", so do not squash the bit
in arm_hcr_el2_eff.

Instead, replicate the E2H+TGE test in the two places that
require it.

Reported-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-id: 20201008162155.161886-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 9 +++++----
 target/arm/helper.c    | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index ae99725d2b5..5460678756d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1252,10 +1252,11 @@ static inline bool allocation_tag_access_enabled(CPUARMState *env, int el,
         && !(env->cp15.scr_el3 & SCR_ATA)) {
         return false;
     }
-    if (el < 2
-        && arm_feature(env, ARM_FEATURE_EL2)
-        && !(arm_hcr_el2_eff(env) & HCR_ATA)) {
-        return false;
+    if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+        if (!(hcr & HCR_ATA) && (!(hcr & HCR_E2H) || !(hcr & HCR_TGE))) {
+            return false;
+        }
     }
     sctlr &= (el == 0 ? SCTLR_ATA0 : SCTLR_ATA);
     return sctlr != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f49b045d366..97bb6b8c01b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6906,10 +6906,11 @@ static CPAccessResult access_mte(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     int el = arm_current_el(env);
 
-    if (el < 2 &&
-        arm_feature(env, ARM_FEATURE_EL2) &&
-        !(arm_hcr_el2_eff(env) & HCR_ATA)) {
-        return CP_ACCESS_TRAP_EL2;
+    if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+        if (!(hcr & HCR_ATA) && (!(hcr & HCR_E2H) || !(hcr & HCR_TGE))) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
     if (el < 3 &&
         arm_feature(env, ARM_FEATURE_EL3) &&
-- 
2.20.1


