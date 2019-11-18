Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C648C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF390219F6
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNb874vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF390219F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWn2a-0006oO-2g
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 14:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWn1o-00069d-U3
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWn1l-0001Qm-BL
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:49:39 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWn1l-0001Ps-0L
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:49:37 -0500
Received: by mail-wr1-x443.google.com with SMTP id a15so20979034wrf.9
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 11:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=hy8AwwwRhcrOoH/uMIh484CtIC6iFhWhD40R46HV2o0=;
 b=vNb874vrVy4qrqGytpsNoMu1YStU8ZbVlsm8sQKr0Hl3lr4rrl+lR2tP7b8kJfBNu0
 IuNPmgIvcfRwTfnlfTenKaoBg4+BqHUWyIcnA20gUv/dVVp+HkL+8RaBomHQV0Qqt93B
 6LaOHwmL7Bcv5siaTkfHsVYjqGccDbQ5hp6iw+XMD+zsbhgdZ1bgxa7GyQTaqfdAyrKS
 NelDm5aqR3fcNxF63cEzjbhRZsLAfuhOEN22fiN85Avj8vsXjaMpi7j8kmfjPsxCxL2S
 WmpTMDl0ZBW7vOz0W1we7bYeCsQ4jliH5z6CEYvRjeke7uo2iC8rtVp2dBsfzxbG9M7r
 T6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=hy8AwwwRhcrOoH/uMIh484CtIC6iFhWhD40R46HV2o0=;
 b=J9riGzanrrdBMppsqIYWRsDIX4ZHS861Gc6Gggj1RJiYOOzBifdTUqO2+fPGwVu5ZN
 ZzmqfKDAk0+37yhSWjXTyeKG57l+DNwYnL0escLQRkq+3wwdXtl2QZ5KywJpVGHpO78r
 w4XNT2zxykCHNL92Cgz5EdV6BEzqpHyOqYZha0825GpCO0GUCxFj9lchAaEAitlmYXmH
 cab900vDEN6C8rwq/Xj/YlqBWUY/qjJv7y/7uCXmvnVSouwR1y2RJPmnzVDkU59MBgrI
 53fPzrGz08OIM+OxwEy2vO2UwSfdYYAK5iNkbzXnhs+1suIcLAzHBnaiNBdoi0aJ3kt+
 jEag==
X-Gm-Message-State: APjAAAUV3/ToIFZROddR5rzHoHg/m+1ptG50nBkKNEqd2HRWakdMGlQ6
 fqI+9ZCBtmBcmODO05IduTkjQqYtbBLOTg==
X-Google-Smtp-Source: APXvYqxYpft5v7ph+TbXwp88Y7mjzoBVdqvQ9HHS4p7Ej+03XbbISBo24W+J5wru0WNlAo8H41PfUg==
X-Received: by 2002:a5d:4445:: with SMTP id x5mr34510879wrr.341.1574106573135; 
 Mon, 18 Nov 2019 11:49:33 -0800 (PST)
Received: from localhost.localdomain (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id h205sm468305wmf.35.2019.11.18.11.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 11:49:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-4.2] target/arm: Support EL0 v7m msr/mrs for
 CONFIG_USER_ONLY
Date: Mon, 18 Nov 2019 20:49:16 +0100
Message-Id: <20191118194916.3670-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org, christophe.lyon@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simply moving the non-stub helper_v7m_mrs/msr outside of
!CONFIG_USER_ONLY is not an option, because of all of the
other system-mode helpers that are called.

But we can split out a few subroutines to handle the few
EL0 accessible registers without duplicating code.

Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h      |   2 +
 target/arm/m_helper.c | 110 ++++++++++++++++++++++++++----------------
 2 files changed, 70 insertions(+), 42 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e1a66a2d1c..81f5b5b75f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1317,6 +1317,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
     if (mask & XPSR_GE) {
         env->GE = (val & XPSR_GE) >> 16;
     }
+#ifndef CONFIG_USER_ONLY
     if (mask & XPSR_T) {
         env->thumb = ((val & XPSR_T) != 0);
     }
@@ -1332,6 +1333,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
         /* Note that this only happens on exception exit */
         write_v7m_exception(env, val & XPSR_EXCP);
     }
+#endif
 }
 
 #define HCR_VM        (1ULL << 0)
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index f2512e448e..7c7e8eb62c 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -33,22 +33,80 @@
 #include "exec/cpu_ldst.h"
 #endif
 
+static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
+                         uint32_t reg, uint32_t val)
+{
+    /* Only APSR is actually writable */
+    if (!(reg & 4)) {
+        uint32_t apsrmask = 0;
+
+        if (mask & 8) {
+            apsrmask |= XPSR_NZCV | XPSR_Q;
+        }
+        if ((mask & 4) && arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
+            apsrmask |= XPSR_GE;
+        }
+        xpsr_write(env, val, apsrmask);
+    }
+}
+
+static uint32_t v7m_mrs_xpsr(CPUARMState *env, uint32_t reg, unsigned el)
+{
+    uint32_t mask = 0;
+
+    if ((reg & 1) && el) {
+        mask |= XPSR_EXCP; /* IPSR (unpriv. reads as zero) */
+    }
+    if (!(reg & 4)) {
+        mask |= XPSR_NZCV | XPSR_Q; /* APSR */
+        if (arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
+            mask |= XPSR_GE;
+        }
+    }
+    /* EPSR reads as zero */
+    return xpsr_read(env) & mask;
+}
+
+static uint32_t v7m_mrs_control(CPUARMState *env, uint32_t secure)
+{
+    uint32_t value = env->v7m.control[secure];
+
+    if (!secure) {
+        /* SFPA is RAZ/WI from NS; FPCA is stored in the M_REG_S bank */
+        value |= env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK;
+    }
+    return value;
+}
+
 #ifdef CONFIG_USER_ONLY
 
 /* These should probably raise undefined insn exceptions.  */
-void HELPER(v7m_msr)(CPUARMState *env, uint32_t reg, uint32_t val)
+void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
 {
-    ARMCPU *cpu = env_archcpu(env);
+    uint32_t mask = extract32(maskreg, 8, 4);
+    uint32_t reg = extract32(maskreg, 0, 8);
 
-    cpu_abort(CPU(cpu), "v7m_msr %d\n", reg);
+    switch (reg) {
+    case 0 ... 7: /* xPSR sub-fields */
+        v7m_msr_xpsr(env, mask, reg, val);
+        break;
+    case 20: /* CONTROL */
+        /* There are no sub-fields that are actually writable from EL0. */
+        break;
+    }
 }
 
 uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
 {
-    ARMCPU *cpu = env_archcpu(env);
-
-    cpu_abort(CPU(cpu), "v7m_mrs %d\n", reg);
-    return 0;
+    switch (reg) {
+    case 0 ... 7: /* xPSR sub-fields */
+        return v7m_mrs_xpsr(env, reg, 0);
+    case 20: /* CONTROL */
+        return v7m_mrs_control(env, 0);
+    default:
+        /* Unprivileged reads others as zero.  */
+        return 0;
+    }
 }
 
 void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
@@ -2196,35 +2254,14 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
 
 uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
 {
-    uint32_t mask;
     unsigned el = arm_current_el(env);
 
     /* First handle registers which unprivileged can read */
-
     switch (reg) {
     case 0 ... 7: /* xPSR sub-fields */
-        mask = 0;
-        if ((reg & 1) && el) {
-            mask |= XPSR_EXCP; /* IPSR (unpriv. reads as zero) */
-        }
-        if (!(reg & 4)) {
-            mask |= XPSR_NZCV | XPSR_Q; /* APSR */
-            if (arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
-                mask |= XPSR_GE;
-            }
-        }
-        /* EPSR reads as zero */
-        return xpsr_read(env) & mask;
-        break;
+        return v7m_mrs_xpsr(env, reg, el);
     case 20: /* CONTROL */
-    {
-        uint32_t value = env->v7m.control[env->v7m.secure];
-        if (!env->v7m.secure) {
-            /* SFPA is RAZ/WI from NS; FPCA is stored in the M_REG_S bank */
-            value |= env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK;
-        }
-        return value;
-    }
+        return v7m_mrs_control(env, env->v7m.secure);
     case 0x94: /* CONTROL_NS */
         /*
          * We have to handle this here because unprivileged Secure code
@@ -2454,18 +2491,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
 
     switch (reg) {
     case 0 ... 7: /* xPSR sub-fields */
-        /* only APSR is actually writable */
-        if (!(reg & 4)) {
-            uint32_t apsrmask = 0;
-
-            if (mask & 8) {
-                apsrmask |= XPSR_NZCV | XPSR_Q;
-            }
-            if ((mask & 4) && arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
-                apsrmask |= XPSR_GE;
-            }
-            xpsr_write(env, val, apsrmask);
-        }
+        v7m_msr_xpsr(env, mask, reg, val);
         break;
     case 8: /* MSP */
         if (v7m_using_psp(env)) {
-- 
2.17.1


