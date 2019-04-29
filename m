Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA9C04AA6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865742147A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzHKH8GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865742147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9wI-0002zQ-Ot
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:19:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ei-0004jG-BK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eb-0006ec-Ju
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:40481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eX-0006Cj-79
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:17 -0400
Received: by mail-wr1-x430.google.com with SMTP id h4so17113350wre.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=P8reak3ogb1Qxpz+d0u/xqb5x//CQHx7bZQj2MKrEhc=;
	b=ZzHKH8GFK5bWapOarjb8h9I+cLEbBFOxKUjSqDGLBOZrNnGFg5qrGMsvfyjBcXp/WC
	IEdX81GF1vG8SVy5U19O9mnUoVCeCsoQMUW0QAA0x9+0lZadkD+a3ksThPEiFZbRTFK6
	HyhpXi+GFFUL0hyQR5NjH8h/KE+qqAcEKw50Mws6WL01ScFfs+rAJ4v287CfdL9WRg3I
	JF0d6xGBctmgMjrxVGC9ME6SEpvx5H/VoA73zakZ6clj6VTw6qmB0eU0vDuhBb4Qd9XR
	m/FPhIzIkdwJPyerqQ/o36kMKTh2kezgWg2JtWw4YwPCxQOtMHyQJ5ar0yPg1u4c7Mjr
	413A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=P8reak3ogb1Qxpz+d0u/xqb5x//CQHx7bZQj2MKrEhc=;
	b=toyxFUTyHdw2gOanFf1ybr6HrlbCY7OovX71q3tXl19bhFXAciDm90d2ttrXRNPBUo
	tW1kYiIgNUrOdI8lYQ23ILFcutPwjRGvO060kt19Z1j+xtHTm0OPd2WIaS/9nSBo1qx5
	LGM7Mm5cA6pAXMQ9yX/Tt+lj00nSSWp5LQm95mr3BpmXmeVQ3HxxT1NSjZXcKZe+XHYX
	4IeARHTQ/alvJVIsgjcNiG4h2ov1J3VJnnOk+Djs/gv5+uDXXcFM3KyUJUVGfKi9ENye
	2dLmvfCiD+2W808FlRZX7/09ImBX57NlxzGvEA/SuGoIGHbLPCNLF4zklvQHnFNonipx
	oyBw==
X-Gm-Message-State: APjAAAUzfdCdQZ9fu61b9ds3s5nSsdoklIYAtQszPRlAzA5RDUOw9kAO
	m/6SL9S0HmiNQY0gNKdLOTpy39XBDyo=
X-Google-Smtp-Source: APXvYqx2xJNnXdrkWNnU+3t7yinzLYX64pExm0dsqA4bNE1wrl/VRpS5J5GAEXi8EoWWFNBKz2jRxw==
X-Received: by 2002:a5d:4989:: with SMTP id r9mr18216781wrq.173.1556557243071; 
	Mon, 29 Apr 2019 10:00:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.41
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 17:59:56 +0100
Message-Id: <20190429170030.11323-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 08/42] target/arm: Honour M-profile FP enable
 bits
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429165956.nkuXxA2wC-hbAT6cylhKwoUrkgK4gBtKXhH3mA87bPA@z>

Like AArch64, M-profile floating point has no FPEXC enable
bit to gate floating point; so always set the VFPEN TB flag.

M-profile also has CPACR and NSACR similar to A-profile;
they behave slightly differently:
 * the CPACR is banked between Secure and Non-Secure
 * if the NSACR forces a trap then this is taken to
   the Secure state, not the Non-Secure state

Honour the CPACR and NSACR settings. The NSACR handling
requires us to borrow the exception.target_el field
(usually meaningless for M profile) to distinguish the
NOCP UsageFault taken to Secure state from the more
usual fault taken to the current security state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-6-peter.maydell@linaro.org
---
 target/arm/helper.c    | 55 +++++++++++++++++++++++++++++++++++++++---
 target/arm/translate.c | 10 ++++++--
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 57ef75b3fcb..c3d5fe09cdc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7556,6 +7556,25 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
     return target_el;
 }
 
+/*
+ * Return true if the v7M CPACR permits access to the FPU for the specified
+ * security state and privilege level.
+ */
+static bool v7m_cpacr_pass(CPUARMState *env, bool is_secure, bool is_priv)
+{
+    switch (extract32(env->v7m.cpacr[is_secure], 20, 2)) {
+    case 0:
+    case 2: /* UNPREDICTABLE: we treat like 0 */
+        return false;
+    case 1:
+        return is_priv;
+    case 3:
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
                             ARMMMUIdx mmu_idx, bool ignfault)
 {
@@ -8815,9 +8834,23 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_UNDEFINSTR_MASK;
         break;
     case EXCP_NOCP:
-        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
-        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_NOCP_MASK;
+    {
+        /*
+         * NOCP might be directed to something other than the current
+         * security state if this fault is because of NSACR; we indicate
+         * the target security state using exception.target_el.
+         */
+        int target_secstate;
+
+        if (env->exception.target_el == 3) {
+            target_secstate = M_REG_S;
+        } else {
+            target_secstate = env->v7m.secure;
+        }
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, target_secstate);
+        env->v7m.cfsr[target_secstate] |= R_V7M_CFSR_NOCP_MASK;
         break;
+    }
     case EXCP_INVSTATE:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVSTATE_MASK;
@@ -12751,6 +12784,22 @@ int fp_exception_el(CPUARMState *env, int cur_el)
         return 0;
     }
 
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        /* CPACR can cause a NOCP UsageFault taken to current security state */
+        if (!v7m_cpacr_pass(env, env->v7m.secure, cur_el != 0)) {
+            return 1;
+        }
+
+        if (arm_feature(env, ARM_FEATURE_M_SECURITY) && !env->v7m.secure) {
+            if (!extract32(env->v7m.nsacr, 10, 1)) {
+                /* FP insns cause a NOCP UsageFault taken to Secure */
+                return 3;
+            }
+        }
+
+        return 0;
+    }
+
     /* The CPACR controls traps to EL1, or PL1 if we're 32 bit:
      * 0, 2 : trap EL0 and EL1/PL1 accesses
      * 1    : trap only EL0 accesses
@@ -12938,7 +12987,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
         flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
-            || arm_el_is_aa64(env, 1)) {
+            || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
         }
         flags = FIELD_DP32(flags, TBFLAG_A32, XSCALE_CPAR, env->cp15.c15_cpar);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a9784535069..6a11921d0b8 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3399,8 +3399,14 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
      */
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
-                           syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
+        if (arm_dc_feature(s, ARM_FEATURE_M)) {
+            gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
+                               s->fp_excp_el);
+        } else {
+            gen_exception_insn(s, 4, EXCP_UDEF,
+                               syn_fp_access_trap(1, 0xe, false),
+                               s->fp_excp_el);
+        }
         return 0;
     }
 
-- 
2.20.1


