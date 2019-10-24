Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9DECA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9F9205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USm43yl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9F9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48123 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgQB-0001cK-1E
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxd-00075g-R6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxb-0000hx-IL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxb-0000hi-Bv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id t16so21670601wrr.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0lnGCVKOKwt9P46Q56BLi+6ul/rpICS/xFMS4taRSZM=;
 b=USm43yl0wezCuR9HjbviXTDsNchFPo8hWLe8HV2XKY+xt7ZXiF+EU/r8BrPe57h3Mm
 deDCifSxU+3xZ+JHkzVIRvsyz20ciMWArSNauCZcychT75hIKRM1cpB5XvH9l47adVd+
 475pIAzLqYkG6U1X+Ch2hEOGQnZmmapQJV2svoqb4EW2mG3w+xKzyck90OC3b/wJQi59
 vrPITMd5RTDkbMn802RAoxIdm2CghFHw+Zt4Cv5/e5XxomtxLrrf2585arWKh9IDyWiL
 MAQBWUyL0yLG6Cgci5kVDFjKpqNjhyp8JH21p6sbaowVcZKh4twFI4oCZ7nEiraT6gxL
 bGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0lnGCVKOKwt9P46Q56BLi+6ul/rpICS/xFMS4taRSZM=;
 b=ZkY+DPRxzxUEGlx7ImkKPqXz0c0xYbAMdueShIv3n0FZ2KKpPd31EGmaIPAcJRxUy6
 L206GBehKtrWYvwe7UdghRMWf47c3eHnejAXPzJaPtFh+9/QycGbA/dj6t+9+dAIQkfL
 cFf3uCuEo01W7/rl1jhFzK92ymDXyDra19/XwfyOqC3VrNCs0rfM1UUfSjG0jG4034pa
 Vs7MB0z3VDJO1BHUHicLH50Oy6NJ60RhZIL4qwwQxLnJWCBSAlNJVINiALQwEHtzcub9
 FYBpNZshoGDiEIuRxxji2nut8julPgHr1C2fJW9g9m/EZ6bCDEdVCCNWebakm49WqBBf
 T78A==
X-Gm-Message-State: APjAAAWvOexPLrN9ycr3f3o/03FqJchbW7WYVomUaegEo6viQFKGSEm5
 tGyKkAKciYSOf9/pXtrPomd6UTEHRS0=
X-Google-Smtp-Source: APXvYqz+iZUbx0yMYMltTC8Pqf3WR58x8Oq1l/R0fVCeKecFs/8xez22gniQxx3ApkFSvi4Lj5YEuQ==
X-Received: by 2002:adf:e850:: with SMTP id d16mr4456370wrn.251.1571934457275; 
 Thu, 24 Oct 2019 09:27:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/51] target/arm: Reduce tests vs M-profile in
 cpu_get_tb_cpu_state
Date: Thu, 24 Oct 2019 17:26:41 +0100
Message-Id: <20191024162724.31675-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Hoist the computation of some TBFLAG_A32 bits that only apply to
M-profile under a single test for ARM_FEATURE_M.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 49 +++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d4303420daf..296a4b2232c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11194,6 +11194,29 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
         if (arm_feature(env, ARM_FEATURE_M)) {
             flags = rebuild_hflags_m32(env, fp_el, mmu_idx);
+
+            if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
+                FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S)
+                != env->v7m.secure) {
+                flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
+            }
+
+            if ((env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
+                (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) ||
+                 (env->v7m.secure &&
+                  !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)))) {
+                /*
+                 * ASPEN is set, but FPCA/SFPA indicate that there is no
+                 * active FP context; we must create a new FP context before
+                 * executing any FP insn.
+                 */
+                flags = FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
+            }
+
+            bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
+            if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
+                flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
+            }
         } else {
             flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
         }
@@ -11233,32 +11256,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     }
 
-    if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
-        FIELD_EX32(env->v7m.fpccr[M_REG_S], V7M_FPCCR, S) != env->v7m.secure) {
-        flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
-    }
-
-    if (arm_feature(env, ARM_FEATURE_M) &&
-        (env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
-        (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) ||
-         (env->v7m.secure &&
-          !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)))) {
-        /*
-         * ASPEN is set, but FPCA/SFPA indicate that there is no active
-         * FP context; we must create a new FP context before executing
-         * any FP insn.
-         */
-        flags = FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
-    }
-
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        bool is_secure = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
-
-        if (env->v7m.fpccr[is_secure] & R_V7M_FPCCR_LSPACT_MASK) {
-            flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
-        }
-    }
-
     if (!arm_feature(env, ARM_FEATURE_M)) {
         int target_el = arm_debug_target_el(env);
 
-- 
2.20.1


