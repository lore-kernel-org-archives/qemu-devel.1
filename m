Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F46BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C50F22249
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGeWpeBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C50F22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuGC-0008IA-EH
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1C-0005Tm-0X
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu19-0003ww-JX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id k18so2510943wmj.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XUl/ktQBgt0jm/lkqBECj09xhOXM9wD4kdunxxEyOrg=;
 b=TGeWpeBWpQIt21r3HA9OMxIUIYAV0voUbizywSWhsUvu24t+lBxYGO46JcegAKeTxo
 h0mBipeTaH14Tx+R7Di9P366jJHzM9VBa1IaY9rfwiu+voYglG+fS4cNqtlCrpEOjoUN
 fwvj1CH9eS3jJezoG8N3bJTa7EADRbIEN0ETsb8WS3p9vDVz1U1URa7Np+kN/SnrvyG8
 9yHvU2SayeCgPmYIfTpkX1oIcYHJbYRVkMUyAo6xnSXG+cy4QavVimAJo38vLdEWuucM
 cp/CuWMREJHXmBExgX/xxqQydQE/VUVVr7uchJr9KpGj+sRDMXawEqrJwaZSzPCewXd0
 umUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XUl/ktQBgt0jm/lkqBECj09xhOXM9wD4kdunxxEyOrg=;
 b=eNVrhj3+m7PdHaz6i/+uCv53ReIRM8MupReyi0i5dytix7D2EYNw9JU0YfolNhApVr
 youvzmVc8TrgfQzWV4Akce+omX9SVcfZ3mcrkMbzEVZYgxrVT+oKg70Kfi5kXWV9w6gs
 R65YCc1Kd8hWtYV7FjPmJPzdRnorr89LiG5WdkDg2eeIOdFj0wuAOsUrokoRNSzP9hQh
 JGhjNlMV8wkDFTjCN3PBxvGdwxZmqx2i55Poto3eqyH1QuJKBnbtfoayTkYo6+8KwOvR
 zVqh18zpETdsxtmLvrD7znMPGPn/kCXCxb8BWRhXZ2OoNf7i/KJlhlCLbau7uBUO/k44
 Z9hw==
X-Gm-Message-State: AOAM530CObvd359EF1R6HN2YGCgiPC+yAx79TfoVvaMWNAudZ7fzT6Y8
 5Da2MRtDq+9pNGZGL2zbuZ58iJusRh5BvA==
X-Google-Smtp-Source: ABdhPJzm5Qt/Eo+t/TowNDHrlj4TRJcIXt13obYLPJ2YdnA/FvmFPK9tJRvNO65calbwFjsQqALlEg==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr3593511wmr.179.1603209461453; 
 Tue, 20 Oct 2020 08:57:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/41] target/arm: Allow M-profile CPUs with FP16 to set
 FPSCR.FP16
Date: Tue, 20 Oct 2020 16:56:43 +0100
Message-Id: <20201020155656.8045-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

M-profile CPUs with half-precision floating point support should
be able to write to FPSCR.FZ16, but an M-profile specific masking
of the value at the top of vfp_set_fpscr() currently prevents that.
This is not yet an active bug because we have no M-profile
FP16 CPUs, but needs to be fixed before we can add any.

The bits that the masking is effectively preventing from being
set are the A-profile only short-vector Len and Stride fields,
plus the Neon QC bit. Rearrange the order of the function so
that those fields are handled earlier and only under a suitable
guard; this allows us to drop the M-profile specific masking,
making FZ16 writeable.

This change also makes the QC bit correctly RAZ/WI for older
no-Neon A-profile cores.

This refactoring also paves the way for the low-overhead-branch
LTPSIZE field, which uses some of the bits that are used for
A-profile Stride and Len.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201019151301.2046-10-peter.maydell@linaro.org
---
 target/arm/vfp_helper.c | 47 ++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index abfdb6a8e23..364856498c4 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -194,36 +194,45 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         val &= ~FPCR_FZ16;
     }
 
-    if (arm_feature(env, ARM_FEATURE_M)) {
+    vfp_set_fpscr_to_host(env, val);
+
+    if (!arm_feature(env, ARM_FEATURE_M)) {
         /*
-         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
-         * and also for the trapped-exception-handling bits IxE.
+         * Short-vector length and stride; on M-profile these bits
+         * are used for different purposes.
+         * We can't make this conditional be "if MVFR0.FPShVec != 0",
+         * because in v7A no-short-vector-support cores still had to
+         * allow Stride/Len to be written with the only effect that
+         * some insns are required to UNDEF if the guest sets them.
+         *
+         * TODO: if M-profile MVE implemented, set LTPSIZE.
          */
-        val &= 0xf7c0009f;
+        env->vfp.vec_len = extract32(val, 16, 3);
+        env->vfp.vec_stride = extract32(val, 20, 2);
     }
 
-    vfp_set_fpscr_to_host(env, val);
+    if (arm_feature(env, ARM_FEATURE_NEON)) {
+        /*
+         * The bit we set within fpscr_q is arbitrary; the register as a
+         * whole being zero/non-zero is what counts.
+         * TODO: M-profile MVE also has a QC bit.
+         */
+        env->vfp.qc[0] = val & FPCR_QC;
+        env->vfp.qc[1] = 0;
+        env->vfp.qc[2] = 0;
+        env->vfp.qc[3] = 0;
+    }
 
     /*
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
      *
-     * If we exclude the exception flags, IOC|DZC|OFC|UFC|IXC|IDC
-     * (which are stored in fp_status), and the other RES0 bits
-     * in between, then we clear all of the low 16 bits.
+     * The exception flags IOC|DZC|OFC|UFC|IXC|IDC are stored in
+     * fp_status; QC, Len and Stride are stored separately earlier.
+     * Clear out all of those and the RES0 bits: only NZCV, AHP, DN,
+     * FZ, RMode and FZ16 are kept in vfp.xregs[FPSCR].
      */
     env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7c80000;
-    env->vfp.vec_len = (val >> 16) & 7;
-    env->vfp.vec_stride = (val >> 20) & 3;
-
-    /*
-     * The bit we set within fpscr_q is arbitrary; the register as a
-     * whole being zero/non-zero is what counts.
-     */
-    env->vfp.qc[0] = val & FPCR_QC;
-    env->vfp.qc[1] = 0;
-    env->vfp.qc[2] = 0;
-    env->vfp.qc[3] = 0;
 }
 
 void vfp_set_fpscr(CPUARMState *env, uint32_t val)
-- 
2.20.1


