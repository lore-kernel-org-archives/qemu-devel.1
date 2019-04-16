Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9305FC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAAE20675
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFSebnJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAAE20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36417 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNpS-0004ww-FP
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:08:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf9-0004dL-52
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf7-0001CQ-9B
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:11 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNf6-00013V-R3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id r4so26905548wrq.8
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=aQ6wGPLx3WRt+frxzRIZZzBI6Q8JRULb0Aj0I2glCjQ=;
	b=SFSebnJUN/iho+FW5EGiA9RNR+U2xEAyxH+PqywlPZ6RuQZA+uj8OamWP0T0+JSy/x
	1K8xn131gaWUzhse5YsoPxHFyoz94XWqQCIkLOdryUMd/LnJ0Qx+Gg5J1zmlp0pp/dlB
	48+qqlDaotJGJbGYllYWY+BrLsBSGIAme/wRSF37wQXVPmA9seipxy95ZCjmoXKY+JOH
	5G/FHS+wqj/hbgdseEXE0+MnakC8Hw7PQyWYrIhd0oDGOjiGblljgHKbfNy2k4hvP/FX
	1nmCQ3D95FhGwjE7+jAfLzIQNeD9airzZHOvEiBaQCZjck6eJtwa5EOvax4FFreuOVcT
	nQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=aQ6wGPLx3WRt+frxzRIZZzBI6Q8JRULb0Aj0I2glCjQ=;
	b=LU8VYB2j+CPVVdL3zh0mbL96QdLcpRtwhBGkjHSeHD+MdJhS4AYKu6x4uKDW2J/B90
	1k68St3so5wCUaOspQ6BAiDOXOGnRw2InEFbgekaUcxtyhHTm1aoqIVFU+6MWag9+5Pu
	gskhpDof4EkZxnUjs5Yt11Z254rlmAbBdT/VDKtjvSDxwQUodcS1qXUW0HeC056KKKRp
	E3Wfegh7M7NZa9Qgzva6RaRjOxHB00GFem6+K+WYoiXvv1AyGImlldecb9YfAi9BUp5H
	99KImIZqWdp7g7LQofqG7UNVnX0OZv3sQWLA1M5K2mdIuflDZILu5Bs3c6vNn0z2ANAD
	un6w==
X-Gm-Message-State: APjAAAVQ7qCm4e5MmqlUYPeq7oG8FR/i3X54tuTjmB+U6o4KN/LJwRZP
	xtrdYZWFPP54F3yIcYiF6Zxz9A==
X-Google-Smtp-Source: APXvYqz7h1pvT/Dlfv5dqqti7wugzUL4Gl0MpCjw2NO6V91Kj5zU9eKqoi4YaOlPoV2AYbeLDihasw==
X-Received: by 2002:adf:efc1:: with SMTP id i1mr51644628wrp.199.1555419476820; 
	Tue, 16 Apr 2019 05:57:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.57.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:57:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:23 +0100
Message-Id: <20190416125744.27770-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 05/26] target/arm: Honour M-profile FP enable
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
Message-ID: <20190416125723.WTPz0kiEwNnv2z9Jqy2jZBSXuBf0dc_MXiVlMhBVm3E@z>

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
---
 target/arm/helper.c    | 55 +++++++++++++++++++++++++++++++++++++++---
 target/arm/translate.c | 10 ++++++--
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a36f4b3d699..27e5f98bc73 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7561,6 +7561,25 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
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
@@ -8820,9 +8839,23 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
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
@@ -12756,6 +12789,22 @@ int fp_exception_el(CPUARMState *env, int cur_el)
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
@@ -12943,7 +12992,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         flags = FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
         flags = FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
-            || arm_el_is_aa64(env, 1)) {
+            || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
         }
         flags = FIELD_DP32(flags, TBFLAG_A32, XSCALE_CPAR, env->cp15.c15_cpar);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d56488ec847..bb539111179 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3398,8 +3398,14 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
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


