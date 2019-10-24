Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F300CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A7F205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maqFf5oD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A7F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgOS-0006jE-Rj
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxY-0006xx-Sh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxX-0000gl-MK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxX-0000gM-G4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id s1so18033243wro.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KG6cHPR+km+P0qCVntKHolnh4Cws12yKWCSVL0d/8TE=;
 b=maqFf5oDHZ4o0OAhwnXBEl+RH9nScIIv5r8lEgPdzE5onANFU0egUkabpiczeWKAzj
 rNhMC+jKutez6LS2nJvYcO2cojsCuefFbQQcw89aQU2MD79zLJ98r/sBu+xGCewELLQS
 /GKinx1TKeaZVEa5yaWQwVv4iDtOeF5qKhTE90+kO3R2MaWEEEkOOPcMF/I+D5H2vb94
 5X5YMukDjXkwPyvj5LHKxGhm6AlJBZJhUnWRbLusDLpp2HTfU9OtPc92xJj/+azwgE1Z
 VJ1x2h8EukwO0HLMswBS2K6jcFp6+AbLi5uhk/cDdyEZyo6gAixT+VehS7P2BrpKxjkL
 WCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KG6cHPR+km+P0qCVntKHolnh4Cws12yKWCSVL0d/8TE=;
 b=JI24Xzbyb5b9hycDF3WtuKtTn/pksbIyEBBarlfEphpyW44Il8dnsFM81WP/NYFGOw
 G0b6zgDBkCqL6IjVFIp8T9Zft7Vett5Y+nktOVmJzPQkLDAH7gFeDPxEZrK52axf8jbK
 PO1cWtsFkJGj4TUayymVIMVw79qMrqVewv3ytneuyz0IZJE9EhVZwCBM16+z7rLWxSM+
 auB0nwQtfV2uydXqekIE/vBJvhSGax2A83TWj1TPKBpwVGC3gqrLdPqltXo2nYwUW4Y1
 PzTYPvG+uVXavSvECBoFj2Kw8toMCNTzZA4sqZq1MzrpK3Wc4DsBWVX1XkZ0HjhQ7gkq
 fmTQ==
X-Gm-Message-State: APjAAAWHDUkuwUgWFSlWDCRe9uTCq/ILKE1Y23Tsb7YhlGPcq8Fu9BhO
 7SYMREKCoczdhGWyBcIp8QTqA8OY1xg=
X-Google-Smtp-Source: APXvYqxS/RBNkeVgmXBxP2szRRrxY2igJaHppI+addhh2X8c/7cp/m+hljlBzt3hCxlmBO+GhrTl9Q==
X-Received: by 2002:adf:f5cc:: with SMTP id k12mr4555214wrp.65.1571934453633; 
 Thu, 24 Oct 2019 09:27:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/51] target/arm: Split out rebuild_hflags_common_32
Date: Thu, 24 Oct 2019 17:26:38 +0100
Message-Id: <20191024162724.31675-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Create a function to compute the values of the TBFLAG_A32 bits
that will be cached, and are used by all profiles.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 69da04786e8..f05d0424745 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11070,6 +11070,15 @@ static uint32_t rebuild_hflags_common(CPUARMState *env, int fp_el,
     return flags;
 }
 
+static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
+                                         ARMMMUIdx mmu_idx, uint32_t flags)
+{
+    flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
+    flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
+
+    return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11141,7 +11150,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
     int current_el = arm_current_el(env);
     int fp_el = fp_exception_el(env, current_el);
-    uint32_t flags = 0;
+    uint32_t flags;
 
     if (is_a64(env)) {
         *pc = env->pc;
@@ -11151,12 +11160,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     } else {
         *pc = env->regs[15];
+        flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
-        flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
-        flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
@@ -11166,8 +11174,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             flags = FIELD_DP32(flags, TBFLAG_A32,
                                XSCALE_CPAR, env->cp15.c15_cpar);
         }
-
-        flags = rebuild_hflags_common(env, fp_el, mmu_idx, flags);
     }
 
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
-- 
2.20.1


