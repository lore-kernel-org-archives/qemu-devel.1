Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68416C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BAF20821
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJlrEG1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BAF20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36691 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGO2Y-000772-9y
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:22:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfc-0005BB-PC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfa-0001Y1-KF
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfY-0001Ty-M4
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id s15so26896593wra.12
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=KKWm6gZFAyj+LJquTLC2CU4eM0/C0INvFXmEW6XbIt4=;
	b=fJlrEG1PxldDdz0NpNggkqwEfZxZmidN4DaNYt9JKqKYa8fKa9u3Ecav8KXq8slLAs
	j71jJw62HJKieu/mYH1Xx9QvhhHiZfnjkVWGikmSqMJxzcn8BrmvdLNSvNooy4p3uaOf
	/jmonvoFhuxWo/jJibtwZm0ZLw/yEbxndldo0Nu5HdWTeIyqGCseDjUE50JjFCjACEKk
	RJX81OZK7gM5Tx251r7F1l4ZCfUCuBla2OyhsDu6ytu0SNQcf8s9tgK6voxuA/Ielvwt
	TYPbc7MCIqXI1DwKL5/BvEcjrX5uDP0V62SQ0e23mvL/sx8rznq1ZUuVYxjO2K0AEIHL
	CdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=KKWm6gZFAyj+LJquTLC2CU4eM0/C0INvFXmEW6XbIt4=;
	b=tk3ENkd16em7vYQN6uXN47AV3dETPEcVEDOj1L2Q46cOmr4zZ65HL8rm+gsaK8bNCt
	/TC+0Zv3k5nJFmrS2KP24d/oHsLJrOJ/p9mi/TdpfmZ6SnH3dUGoO/ItJHnazvvxtgTG
	qsW7quwBcoKLxV6J5rFTUYoVYso6ONrZvV8yAs4/0KxIcbjPIFkpyfegk0RaSwJU5a8R
	LuAz0WeF8nYN4RdN9Mip/+2Oam//+cUFlbvG0jyzQdVUrZGuZ2eR8lzqOA8oTGUuNVH2
	J08bt5wSVvw8Uy6MiQqmjkayu9h/l0D+KTkgnpHg3LKbuRPjAbbeEkRMVwLZhwVjqOcA
	wvog==
X-Gm-Message-State: APjAAAVupRZJfpJvuinHEhg4wbGRze+NWn9sPSAidEEYWtWcUt3W/5eX
	nmmqNBslr9DQZ5iTS/5MW7ksCsvpdso=
X-Google-Smtp-Source: APXvYqwapI6gh5Kacfojabhk4iwQ2LAMxgPRpTvsyqCn+6xNv9ewOyhEkyCZ3bvQhfT2iRh4uy/npA==
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr50715615wre.55.1555419512552; 
	Tue, 16 Apr 2019 05:58:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:42 +0100
Message-Id: <20190416125744.27770-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 24/26] target/arm: Implement VLSTM for v7M CPUs
 with an FPU
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
Message-ID: <20190416125742.m2qMgwmuXCsTehap0ZFswHUr-UVeCgnSWiIqvWFiMWc@z>

Implement the VLSTM instruction for v7M for the FPU present case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  2 +
 target/arm/helper.h    |  2 +
 target/arm/helper.c    | 84 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate.c | 15 +++++++-
 4 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8fd6551c6cd..eac194b4d5f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -58,6 +58,8 @@
 #define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
 #define EXCP_STKOF          19   /* v8M STKOF UsageFault */
 #define EXCP_LAZYFP         20   /* v7M fault during lazy FP stacking */
+#define EXCP_LSERR          21   /* v8M LSERR SecureFault */
+#define EXCP_UNALIGNED      22   /* v7M UNALIGNED UsageFault */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
 #define ARMV7M_EXCP_RESET   1
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0a3a80528c7..62051ae6d51 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -71,6 +71,8 @@ DEF_HELPER_3(v7m_tt, i32, env, i32, i32)
 
 DEF_HELPER_1(v7m_preserve_fp_state, void, env)
 
+DEF_HELPER_2(v7m_vlstm, void, env, i32)
+
 DEF_HELPER_2(v8m_stackcheck, void, env, i32)
 
 DEF_HELPER_4(access_check_cp_reg, void, env, ptr, i32, i32)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c56746aafa2..ad049b2d9bc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7389,6 +7389,12 @@ void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
     g_assert_not_reached();
 }
 
+void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
+{
+    /* translate.c should never generate calls here in user-only mode */
+    g_assert_not_reached();
+}
+
 uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
 {
     /* The TT instructions can be used by unprivileged code, but in
@@ -8405,6 +8411,74 @@ static void v7m_update_fpccr(CPUARMState *env, uint32_t frameptr,
     }
 }
 
+void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
+{
+    /* fptr is the value of Rn, the frame pointer we store the FP regs to */
+    bool s = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
+    bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
+
+    assert(env->v7m.secure);
+
+    if (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)) {
+        return;
+    }
+
+    /* Check access to the coprocessor is permitted */
+    if (!v7m_cpacr_pass(env, true, arm_current_el(env) != 0)) {
+        raise_exception_ra(env, EXCP_NOCP, 0, 1, GETPC());
+    }
+
+    if (lspact) {
+        /* LSPACT should not be active when there is active FP state */
+        raise_exception_ra(env, EXCP_LSERR, 0, 1, GETPC());
+    }
+
+    if (fptr & 7) {
+        raise_exception_ra(env, EXCP_UNALIGNED, 0, 1, GETPC());
+    }
+
+    /*
+     * Note that we do not use v7m_stack_write() here, because the
+     * accesses should not set the FSR bits for stacking errors if they
+     * fail. (In pseudocode terms, they are AccType_NORMAL, not AccType_STACK
+     * or AccType_LAZYFP). Faults in cpu_stl_data() will throw exceptions
+     * and longjmp out.
+     */
+    if (!(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPEN_MASK)) {
+        bool ts = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_TS_MASK;
+        int i;
+
+        for (i = 0; i < (ts ? 32 : 16); i += 2) {
+            uint64_t dn = *aa32_vfp_dreg(env, i / 2);
+            uint32_t faddr = fptr + 4 * i;
+            uint32_t slo = extract64(dn, 0, 32);
+            uint32_t shi = extract64(dn, 32, 32);
+
+            if (i >= 16) {
+                faddr += 8; /* skip the slot for the FPSCR */
+            }
+            cpu_stl_data(env, faddr, slo);
+            cpu_stl_data(env, faddr + 4, shi);
+        }
+        cpu_stl_data(env, fptr + 0x40, vfp_get_fpscr(env));
+
+        /*
+         * If TS is 0 then s0 to s15 and FPSCR are UNKNOWN; we choose to
+         * leave them unchanged, matching our choice in v7m_preserve_fp_state.
+         */
+        if (ts) {
+            for (i = 0; i < 32; i += 2) {
+                *aa32_vfp_dreg(env, i / 2) = 0;
+            }
+            vfp_set_fpscr(env, 0);
+        }
+    } else {
+        v7m_update_fpccr(env, fptr, false);
+    }
+
+    env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
+}
+
 static bool v7m_push_stack(ARMCPU *cpu)
 {
     /* Do the "set up stack frame" part of exception entry,
@@ -9165,6 +9239,8 @@ static void arm_log_exception(int idx)
             [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
             [EXCP_STKOF] = "v8M STKOF UsageFault",
             [EXCP_LAZYFP] = "v7M exception during lazy FP stacking",
+            [EXCP_LSERR] = "v8M LSERR UsageFault",
+            [EXCP_UNALIGNED] = "v7M UNALIGNED UsageFault",
         };
 
         if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
@@ -9339,6 +9415,14 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_STKOF_MASK;
         break;
+    case EXCP_LSERR:
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
+        env->v7m.sfsr |= R_V7M_SFSR_LSERR_MASK;
+        break;
+    case EXCP_UNALIGNED:
+        armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
+        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_UNALIGNED_MASK;
+        break;
     case EXCP_SWI:
         /* The PC already points to the next instruction.  */
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SVC, env->v7m.secure);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 04988efca7c..db478b779a9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11817,7 +11817,20 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 if (!s->v8m_secure || (insn & 0x0040f0ff)) {
                     goto illegal_op;
                 }
-                /* Just NOP since FP support is not implemented */
+
+                if (arm_dc_feature(s, ARM_FEATURE_VFP)) {
+                    TCGv_i32 fptr = load_reg(s, rn);
+
+                    if (extract32(insn, 20, 1)) {
+                        /* VLLDM */
+                    } else {
+                        gen_helper_v7m_vlstm(cpu_env, fptr);
+                    }
+                    tcg_temp_free_i32(fptr);
+
+                    /* End the TB, because we have updated FP control bits */
+                    s->base.is_jmp = DISAS_UPDATE;
+                }
                 break;
             }
             if (arm_dc_feature(s, ARM_FEATURE_VFP) &&
-- 
2.20.1


