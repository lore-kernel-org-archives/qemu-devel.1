Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2465CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9875921872
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVn2di/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9875921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuV2-00031y-7V
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGp-0002iB-Ve
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGn-0001IB-R9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:18 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGm-0001HS-RP
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:17 -0400
Received: by mail-wm1-x344.google.com with SMTP id v9so267265wml.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Cu6oVuHK3bWpUoid4fFJqnNglUadyF8qdViMi5V1xKs=;
 b=LVn2di/BNa2vu6y7WhBud6rPOAWCz0uS3cPic64rAfLNaiYTZO92xSBdxcL/4CDpqt
 Hv6yNrMC4scKLh8UX8cdCEbWzEliuuwQ1cUyOL48vO3mlUi+lHT5JsQOadQ0ZoadW8cN
 +FTFUISa4NuI+ldXPuoSUSwKSJA0S/tP6g9k01kNFUellTxYCAW/dXRYnHonFYjWfGOY
 OdoyaasLNhVLY3cjx8AS3Mwz6LotIZ0B2PWPjJnw+BQXEI/Of3mbF0Qq3R6yieo/HPia
 is5feOWP5jl6cOo4NxR9LCUzniJyEq2/9ZCAyh71Rk78/289IRj+fqeOJzkmrrgCShFO
 GBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cu6oVuHK3bWpUoid4fFJqnNglUadyF8qdViMi5V1xKs=;
 b=KbSmvHXWhoC5yHMeMzTOC8b4EbbGLJnRSxFql460BeAaC5HOVSLDvTQ+T1yLkI1Dcr
 AL+wurpU1R0o0Al5kYDse9Fu9BCLGCYHdwDyUdtjPJzruxS0DD2SZVZ9DhbbeBDcDv1N
 npSe95ijpi1nipzO+q0gERorXXzsFdrkJvXmitDHxVcF/xugYJ9FHelzcaU/M2ftRm8A
 bmOHI2GzIrSscvKvGZfiwaKcuEYjnRHJt4xt6nQAvsmTuIRWqcol4FcfPUQT08bwRDCM
 I0mcUDkZJOs0vd5pTQ83MfSEAziJNTelQBOkopDwnyCKDU0+lB5u2/h9IK465vV8vcKK
 Fz/g==
X-Gm-Message-State: APjAAAXPfkbAJi/JUWOlXVqNky2D9IbbC4voylJmhqcTvGypNbOuLIIf
 eqnjmBZJmQgGHefFV+nyoEFHtLGlbgE=
X-Google-Smtp-Source: APXvYqyKUmYClStP9dI4I5TJWsHxjD8p2hK/GdOdRM2aJGMcP9SFjtofrjbXYilOicfWZUHO862qdA==
X-Received: by 2002:a7b:c631:: with SMTP id p17mr3130570wmk.5.1571751135352;
 Tue, 22 Oct 2019 06:32:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/41] target/arm: Split out rebuild_hflags_m32
Date: Tue, 22 Oct 2019 14:31:08 +0100
Message-Id: <20191022133134.14487-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
that will be cached, and are used by M-profile.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191018174431.1784-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4c65476d936..d4303420daf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11083,6 +11083,29 @@ static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
+                                   ARMMMUIdx mmu_idx)
+{
+    uint32_t flags = 0;
+
+    if (arm_v7m_is_handler_mode(env)) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
+    }
+
+    /*
+     * v8M always applies stack limit checks unless CCR.STKOFHFNMIGN
+     * is suppressing them because the requested execution priority
+     * is less than 0.
+     */
+    if (arm_feature(env, ARM_FEATURE_V8) &&
+        !((mmu_idx & ARM_MMU_IDX_M_NEGPRI) &&
+          (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))) {
+        flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
+    }
+
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11168,7 +11191,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     } else {
         *pc = env->regs[15];
-        flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+
+        if (arm_feature(env, ARM_FEATURE_M)) {
+            flags = rebuild_hflags_m32(env, fp_el, mmu_idx);
+        } else {
+            flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+        }
+
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
         flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
@@ -11204,20 +11233,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     }
 
-    if (arm_v7m_is_handler_mode(env)) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);
-    }
-
-    /* v8M always applies stack limit checks unless CCR.STKOFHFNMIGN is
-     * suppressing them because the requested execution priority is less than 0.
-     */
-    if (arm_feature(env, ARM_FEATURE_V8) &&
-        arm_feature(env, ARM_FEATURE_M) &&
-        !((mmu_idx  & ARM_MMU_IDX_M_NEGPRI) &&
-          (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, STACKCHECK, 1);
-    }
-
     if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
         FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S) != env->v7m.secure) {
         flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
-- 
2.20.1


