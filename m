Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638F7CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D39B2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdRulk7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D39B2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgUv-0000L7-FA
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxk-0007LB-Ts
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxj-0000mx-Kw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:48 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxj-0000mH-Dw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id g7so3535725wmk.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8v8h1OzrhCqLBFglLP5BbJjU1xr59SgzwhT/B4w8jqg=;
 b=pdRulk7Bgy7FfwfzpjIUgenzQhQ3N9sJvbVZkPjHIQPNuSqOqLSukBzq2JoRqhmZZq
 Ew1VYhiK7X82EQgcXstcuNKWsuRk31vwzDfZ60HV8yiHrOXm6ozfuk8nKFtXsQrOauRh
 I4wrUhlMOrjRi260eHoBfR5bGIdwQvBm/j2fxYs6nr6ONqiXPNdtziwNwX7dGIwAon1W
 mlXVr+ZbJlepl1MqkTFAnuLJ3CUgWPxJ2S/1WPB3GgeiatvI19KfUUb30m9uSg3aUK43
 1KbDtpItEznxh/0m1ZQgXyVOXUpxeF6pCCyPlbmZOwRCOv7/lGwnawNJ4+43Wd3otpH9
 vY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8v8h1OzrhCqLBFglLP5BbJjU1xr59SgzwhT/B4w8jqg=;
 b=qWYD7tr+1FddjCN0euDUdJxhbbgqAZ5GGWIrP7QftbxGx970xGJFMfW+Q6r+fg34Ap
 W509DJF/eRUTAR8NzFp2UF5oAR/+bpIrDHzJ66zjOlJk6OHTEsxPJRZ97SZJ1ZZsj+dR
 ILkWhHZaS94zAm50/ntmSpT0gIjjzK8LOF05Q46p0itvDbFFi6xy6RY5hW8Q42Yo1+sW
 cD22PuxWQuFbeI51GmKKFoL1uklmzuUHrTph/5F4blCEN4mzLI18KmHWZvEcjvN/yrO4
 NFkFaq2j+GOE2NP7JzkMZ5NfPryspv1wcYQMypzoa06mPbL3Vlmk1UUPdEpwsX65R+Ic
 Ym8w==
X-Gm-Message-State: APjAAAXoiszbJF7r+yS6ar6I1yEGah07JwtcFfCCTx7KBe+UhCaJQzgL
 gFWL0I+3rwkXZUwxR0USEb4f+Q7JaYo=
X-Google-Smtp-Source: APXvYqw5FPDxXpTrbZDTkBFM6OS9QnHUfYwd5sBGfYXySDhCGonExhvYoiNuvJe1gLoeJU9qzZ1ySQ==
X-Received: by 2002:a1c:f709:: with SMTP id v9mr6023816wmh.62.1571934465909;
 Thu, 24 Oct 2019 09:27:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/51] target/arm: Split out arm_mmu_idx_el
Date: Thu, 24 Oct 2019 17:26:48 +0100
Message-Id: <20191024162724.31675-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

Avoid calling arm_current_el() twice.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  9 +++++++++
 target/arm/helper.c    | 12 +++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 232d9638753..f5313dd3d42 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -949,6 +949,15 @@ void arm_cpu_update_virq(ARMCPU *cpu);
  */
 void arm_cpu_update_vfiq(ARMCPU *cpu);
 
+/**
+ * arm_mmu_idx_el:
+ * @env: The cpu environment
+ * @el: The EL to use.
+ *
+ * Return the full ARMMMUIdx for the translation regime for EL.
+ */
+ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el);
+
 /**
  * arm_mmu_idx:
  * @env: The cpu environment
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 85de96d071a..3f7d3f257d8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11026,15 +11026,12 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 }
 #endif
 
-ARMMMUIdx arm_mmu_idx(CPUARMState *env)
+ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
 {
-    int el;
-
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
-    el = arm_current_el(env);
     if (el < 2 && arm_is_secure_below_el3(env)) {
         return ARMMMUIdx_S1SE0 + el;
     } else {
@@ -11042,6 +11039,11 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     }
 }
 
+ARMMMUIdx arm_mmu_idx(CPUARMState *env)
+{
+    return arm_mmu_idx_el(env, arm_current_el(env));
+}
+
 int cpu_mmu_index(CPUARMState *env, bool ifetch)
 {
     return arm_to_core_mmu_idx(arm_mmu_idx(env));
@@ -11202,7 +11204,7 @@ static uint32_t rebuild_hflags_internal(CPUARMState *env)
 {
     int el = arm_current_el(env);
     int fp_el = fp_exception_el(env, el);
-    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, el);
 
     if (is_a64(env)) {
         return rebuild_hflags_a64(env, el, fp_el, mmu_idx);
-- 
2.20.1


