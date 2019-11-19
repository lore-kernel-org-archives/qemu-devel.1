Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA8DC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F1720409
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNTTqbjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F1720409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3kY-0002pz-8G
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bs-0003S5-Vo
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3br-0004Dh-ET
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:32:00 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36462)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX3br-0004DP-7n
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:59 -0500
Received: by mail-wm1-x342.google.com with SMTP id c22so3642273wmd.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 05:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RUy3/jS4gGvA/21v++FuloKSRPT5gl3lim3IGVoqAk0=;
 b=iNTTqbjTDV2rliOXYgQ5d8VYGvFqB56R24OD01Z/xwfdp+BS+DO8SfkxNjsPrgrSvD
 a16N1JV5PycCUJeEBv5eiqXz8idURzYxUH8Su2WLs5Wxao7Eczve6NjZ+vtj/cALirEi
 k/8voQu+zGOKGjcNJFy+XS0m56m6GQwY7p04SZdxVwTnH0F3o5ahS4lby1a08QdH5cf+
 8IHevVYXzXRH24ubnTNUvCxEX4HCVGwdt5KTy+AbZAoBYDo08FHps+0P2aMpVUYqrYOV
 8hqDHqg0x0QIfi7gbY6noHGibiHGowRkF/7EFlO41Gxd2zwmh46mbVNhKFw2ChlkGd75
 XwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RUy3/jS4gGvA/21v++FuloKSRPT5gl3lim3IGVoqAk0=;
 b=SVnFyJslSpfj0fbfBHoDmM0eHau2uV1RG36uVh+ZwBbYjr39OIKSc6oTWXlxqLdnEV
 8MrGgPMUs2ntVFeHrNFfA9qProlzJfYNA2vibniLC6hWbpgtT7iPHR70aSopTUf6TmpN
 UZFAR4uzMg+36CB7Mgegwu0aoC0RwmmCx1EaC8S1IPuQHuSzDXqnsBKnrkcfqHqCTlYl
 rhiinFUhCkuwc9gX+rT2Rxe+kzAxAxAfi1jxPTu1JpL4mxHfLAQ9cP6Lp7+wff/kT9vw
 teFQixk04plQsonj4QL0RkZXE+GrBydlAg1QYTeAbxrhmdi1Do/EYgORYAKVP8o0N+cZ
 rDDA==
X-Gm-Message-State: APjAAAWzQTOUqF0oPqTuqLQulSlOBl5A0zVqmzxIioBLyhso35O8Uk/z
 STZIYoSsx5RcqxEKvIdhMhCS44jS+7mdOw==
X-Google-Smtp-Source: APXvYqwajMwh5hvVfo2dtijfk3XgyKWe9Vtk8ztxPWWr4aRHlScwXX7uIUS3PGXaZMRCSuHWE+uRDw==
X-Received: by 2002:a7b:cf0e:: with SMTP id l14mr5877718wmg.149.1574170317880; 
 Tue, 19 Nov 2019 05:31:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g8sm3094905wmk.23.2019.11.19.05.31.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 05:31:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] target/arm: Support EL0 v7m msr/mrs for CONFIG_USER_ONLY
Date: Tue, 19 Nov 2019 13:31:45 +0000
Message-Id: <20191119133145.31466-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119133145.31466-1-peter.maydell@linaro.org>
References: <20191119133145.31466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Simply moving the non-stub helper_v7m_mrs/msr outside of
!CONFIG_USER_ONLY is not an option, because of all of the
other system-mode helpers that are called.

But we can split out a few subroutines to handle the few
EL0 accessible registers without duplicating code.

Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191118194916.3670-1-richard.henderson@linaro.org
[PMM: deleted now-redundant comment; added a default case
 to switch in v7m_msr helper]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      |   2 +
 target/arm/m_helper.c | 114 ++++++++++++++++++++++++++----------------
 2 files changed, 73 insertions(+), 43 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 47d24a53758..83a809d4bac 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1314,6 +1314,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
     if (mask & XPSR_GE) {
         env->GE = (val & XPSR_GE) >> 16;
     }
+#ifndef CONFIG_USER_ONLY
     if (mask & XPSR_T) {
         env->thumb = ((val & XPSR_T) != 0);
     }
@@ -1329,6 +1330,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
         /* Note that this only happens on exception exit */
         write_v7m_exception(env, val & XPSR_EXCP);
     }
+#endif
 }
 
 #define HCR_VM        (1ULL << 0)
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index f2512e448e2..4a48b792520 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -33,22 +33,82 @@
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
 
-/* These should probably raise undefined insn exceptions.  */
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
+    default:
+        /* Unprivileged writes to other registers are ignored */
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
@@ -2196,35 +2256,14 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
 
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
@@ -2454,18 +2493,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
 
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
2.20.1


