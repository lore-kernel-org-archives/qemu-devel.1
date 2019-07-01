Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2358DC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCFA216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psNUuIla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCFA216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8PL-0006eG-U4
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60212)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4fA-0001jQ-KX
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4f6-0005ah-RF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:20:38 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:36713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4f5-0005Oj-9C
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:20:36 -0400
Received: by mail-wm1-f41.google.com with SMTP id u8so1136707wmm.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZMrqkHkBcxi0ttxgCOY8UHzzFSmivWvG6v3OYeb/MfM=;
 b=psNUuIlaJiNnRjrcJvR6FYbx9Q+lXkqw9w60Qr2zvsK/kpaaljXSX2uKaW+lWHai/v
 1LlyBTmYCH53gjVituGG204mtGiSiG05QEGWHULVZcLOY5hYQTOzhU/StnY1z1OAg1/K
 lKOpMSB7xOhr02TZp/2FDNmU8kE8YVgCbjvAQm894KqoobgpoGed53qS8OpxSP74jEmU
 PT/Cot+jUY8I7oyKBF/b3L0Dzn4L3ILFHFiAzaZpBSVn4arHjPz59HUaOuDnyoLj1CzT
 DO+8tMh4G2L1mpTnLvbiHKMbzU+/FQMrewBN5yA8Dh7U1xq5Eq5M8U8G6srkOIsHl7az
 osSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZMrqkHkBcxi0ttxgCOY8UHzzFSmivWvG6v3OYeb/MfM=;
 b=cwF2dAMW/UCOM0/601k0HrC27hQ05rbD01WEu9gf5giZcEZWeKgd+lqYgWmtF3bsE9
 nfc62o9rudQ9UXx2Da0scAGPHz5NxjwqFyN8+4dSVPNfmRXba1orCgmd+Y8Dhb8cgPkK
 xylsKSBBaA+h3SLszgASXQe35TqLpoDR5fU2KOkEnatW2xIdS4hk/ENsz+4JWSYZP03v
 huE7NRg0AXwS3KzgEqKJcYaFnOPav9Zy6MCr2fjvbEf/oxLmbSWmjuQb+L3C5GzU34Di
 nyJI2VroiB/G46GetrJIAg5K+vTGC4hPGe5buB4FNzF51z/ErVRwfmUlqsrqXiPPz3Jl
 8mpg==
X-Gm-Message-State: APjAAAVTUVbZG6/NuqCJAjSyzvIhmUJoZKJ0AJdpPPsPLv1tJHqu//xq
 CBVZgT9cT4TUGLx6GArweCX3Y7b24wk8Ag==
X-Google-Smtp-Source: APXvYqx23JurnM+ro/0QqE+Fix2mx14PhNMapJnEhNTEbXDFEkfIcz8Fq93eyUBKtDByF9QRP/xAeA==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr114068wmg.65.1561999231515;
 Mon, 01 Jul 2019 09:40:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:38 +0100
Message-Id: <20190701163943.22313-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.41
Subject: [Qemu-devel] [PULL 41/46] target/arm/vfp_helper: Extract
 vfp_set_fpscr_to_host()
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The vfp_set_fpscr() helper contains code specific to the host
floating point implementation (here the SoftFloat library).
Extract this code to vfp_set_fpscr_to_host().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-16-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 127 +++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 61 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index d54e3253240..b19a395b67d 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -81,71 +81,11 @@ static inline int vfp_exceptbits_to_host(int target_bits)
     return host_bits;
 }
 
-uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
-{
-    uint32_t i, fpscr;
-
-    fpscr = env->vfp.xregs[ARM_VFP_FPSCR]
-            | (env->vfp.vec_len << 16)
-            | (env->vfp.vec_stride << 20);
-
-    i = get_float_exception_flags(&env->vfp.fp_status);
-    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
-    /* FZ16 does not generate an input denormal exception.  */
-    i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
-          & ~float_flag_input_denormal);
-    fpscr |= vfp_exceptbits_from_host(i);
-
-    i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
-    fpscr |= i ? FPCR_QC : 0;
-
-    return fpscr;
-}
-
-uint32_t vfp_get_fpscr(CPUARMState *env)
-{
-    return HELPER(vfp_get_fpscr)(env);
-}
-
-void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
+static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
 {
     int i;
     uint32_t changed = env->vfp.xregs[ARM_VFP_FPSCR];
 
-    /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
-    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
-        val &= ~FPCR_FZ16;
-    }
-
-    if (arm_feature(env, ARM_FEATURE_M)) {
-        /*
-         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
-         * and also for the trapped-exception-handling bits IxE.
-         */
-        val &= 0xf7c0009f;
-    }
-
-    /*
-     * We don't implement trapped exception handling, so the
-     * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
-     *
-     * If we exclude the exception flags, IOC|DZC|OFC|UFC|IXC|IDC
-     * (which are stored in fp_status), and the other RES0 bits
-     * in between, then we clear all of the low 16 bits.
-     */
-    env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7c80000;
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
-
     changed ^= val;
     if (changed & (3 << 22)) {
         i = (val >> 22) & 3;
@@ -193,6 +133,71 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
     set_float_exception_flags(0, &env->vfp.standard_fp_status);
 }
 
+uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
+{
+    uint32_t i, fpscr;
+
+    fpscr = env->vfp.xregs[ARM_VFP_FPSCR]
+            | (env->vfp.vec_len << 16)
+            | (env->vfp.vec_stride << 20);
+
+    i = get_float_exception_flags(&env->vfp.fp_status);
+    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
+    /* FZ16 does not generate an input denormal exception.  */
+    i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
+          & ~float_flag_input_denormal);
+    fpscr |= vfp_exceptbits_from_host(i);
+
+    i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
+    fpscr |= i ? FPCR_QC : 0;
+
+    return fpscr;
+}
+
+uint32_t vfp_get_fpscr(CPUARMState *env)
+{
+    return HELPER(vfp_get_fpscr)(env);
+}
+
+void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
+{
+    /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
+    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
+        val &= ~FPCR_FZ16;
+    }
+
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        /*
+         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
+         * and also for the trapped-exception-handling bits IxE.
+         */
+        val &= 0xf7c0009f;
+    }
+
+    /*
+     * We don't implement trapped exception handling, so the
+     * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
+     *
+     * If we exclude the exception flags, IOC|DZC|OFC|UFC|IXC|IDC
+     * (which are stored in fp_status), and the other RES0 bits
+     * in between, then we clear all of the low 16 bits.
+     */
+    env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7c80000;
+    env->vfp.vec_len = (val >> 16) & 7;
+    env->vfp.vec_stride = (val >> 20) & 3;
+
+    /*
+     * The bit we set within fpscr_q is arbitrary; the register as a
+     * whole being zero/non-zero is what counts.
+     */
+    env->vfp.qc[0] = val & FPCR_QC;
+    env->vfp.qc[1] = 0;
+    env->vfp.qc[2] = 0;
+    env->vfp.qc[3] = 0;
+
+    vfp_set_fpscr_to_host(env, val);
+}
+
 void vfp_set_fpscr(CPUARMState *env, uint32_t val)
 {
     HELPER(vfp_set_fpscr)(env, val);
-- 
2.20.1


