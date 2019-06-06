Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A76C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8CD20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKi1snmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8CD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36061 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwfN-0006UV-4B
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:59:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU6-0004Sl-L8
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU3-000456-Ki
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU2-0002o5-9k
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id f9so3304478wre.12
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=YpYRRdgRhzNXtTHb+mlZtWZev3S3aQYGhaPt/SJ1b1I=;
	b=gKi1snmKy4Du8yZDDRmsAPTqxKvAbH4j66UKxuqbpP0XrRL2VbyXez1X0eNijJ3sDA
	AHlTREQaLlHL+KI+v21xQs5Wj5PXgk1vV1DKLB/BCiW/1t+V1PhG0okrXjCwvO3YgRZJ
	uXkM4Dxm9bCXDUdmJtJQpzsJiuT9CPGAyQV35sAiXUE6lgkNsktx33PtjkEgIc3hf+kO
	qq6v/55NcRzuHWnx0itBEcvRl0TPi2kEGtoTjEPrH7yfB134f7RXVMUyuks0ZOHrNZz+
	xGN8GWnWajI2lYlfWahdEnQGyujFxYHeCE3qlntVczegbxZ9g7/v6+FvRPCKmHzC1c0W
	42Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=YpYRRdgRhzNXtTHb+mlZtWZev3S3aQYGhaPt/SJ1b1I=;
	b=D8zFLEmSRU4EsXEIBvXuRAzyBLZj9QYXmaVm8pLTaRI9goPxYEQZ0aseQzg5lHColc
	KmKhimlG9G1Dz5TTcbD0WDLAjLz5AqobtNSCw0A3zpkKm6o5Ww8sTCpXx3nM8i8k32eT
	//EtXU9Jk1ChmbQTd1axIur0IhwGg+oc2q59JJEZ4/SXscvoth92fQNmpAzMtjnrQGYQ
	zUJQ+VXhfxx5oYhj4ma+wAZWI2U9e2V72YPnVQDQ2F0L/aPcsoXuG88NGnvzfIcsvrId
	s3DCwzMDYAtgGMyi/3cxUJHMrJSTytGjg1N/pf7iVNZOTgJoJDkrsP+oCo/f72o1KjD/
	EmEQ==
X-Gm-Message-State: APjAAAVOuopKciUHbVhy1M1vjOxRxIfMTbIJfWINOQdUo9NCIYz9VT4E
	nmggS6fHrIB+ucWQo8vdZcbUXg==
X-Google-Smtp-Source: APXvYqwtaUfxCvQq5eW/5WYzq20VtJfbpdRYWJ46oFBxm2Pm/r3HFC19j64qjgPZdH+0Td4hgc/Afw==
X-Received: by 2002:a5d:53d2:: with SMTP id a18mr3579999wrw.98.1559843174729; 
	Thu, 06 Jun 2019 10:46:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:30 +0100
Message-Id: <20190606174609.20487-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 03/42] target/arm: Factor out VFP access
 checking code
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Factor out the VFP access checking code so that we can use it in the
leaf functions of the decodetree decoder.

We call the function full_vfp_access_check() so we can keep
the more natural vfp_access_check() for a version which doesn't
have the 'ignore_vfp_enabled' flag -- that way almost all VFP
insns will be able to use vfp_access_check(s) and only the
special-register access function will have to use
full_vfp_access_check(s, ignore_vfp_enabled).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 100 ++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 101 +++++----------------------------
 2 files changed, 113 insertions(+), 88 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 3447b3e6466..cf3d7febaa7 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -29,3 +29,103 @@
 /* Include the generated VFP decoder */
 #include "decode-vfp.inc.c"
 #include "decode-vfp-uncond.inc.c"
+
+/*
+ * Check that VFP access is enabled. If it is, do the necessary
+ * M-profile lazy-FP handling and then return true.
+ * If not, emit code to generate an appropriate exception and
+ * return false.
+ * The ignore_vfp_enabled argument specifies that we should ignore
+ * whether VFP is enabled via FPEXC[EN]: this should be true for FMXR/FMRX
+ * accesses to FPSID, FPEXC, MVFR0, MVFR1, MVFR2, and false for all other insns.
+ */
+static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
+{
+    if (s->fp_excp_el) {
+        if (arm_dc_feature(s, ARM_FEATURE_M)) {
+            gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
+                               s->fp_excp_el);
+        } else {
+            gen_exception_insn(s, 4, EXCP_UDEF,
+                               syn_fp_access_trap(1, 0xe, false),
+                               s->fp_excp_el);
+        }
+        return false;
+    }
+
+    if (!s->vfp_enabled && !ignore_vfp_enabled) {
+        assert(!arm_dc_feature(s, ARM_FEATURE_M));
+        gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+                           default_exception_el(s));
+        return false;
+    }
+
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        /* Handle M-profile lazy FP state mechanics */
+
+        /* Trigger lazy-state preservation if necessary */
+        if (s->v7m_lspact) {
+            /*
+             * Lazy state saving affects external memory and also the NVIC,
+             * so we must mark it as an IO operation for icount.
+             */
+            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+                gen_io_start();
+            }
+            gen_helper_v7m_preserve_fp_state(cpu_env);
+            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+                gen_io_end();
+            }
+            /*
+             * If the preserve_fp_state helper doesn't throw an exception
+             * then it will clear LSPACT; we don't need to repeat this for
+             * any further FP insns in this TB.
+             */
+            s->v7m_lspact = false;
+        }
+
+        /* Update ownership of FP context: set FPCCR.S to match current state */
+        if (s->v8m_fpccr_s_wrong) {
+            TCGv_i32 tmp;
+
+            tmp = load_cpu_field(v7m.fpccr[M_REG_S]);
+            if (s->v8m_secure) {
+                tcg_gen_ori_i32(tmp, tmp, R_V7M_FPCCR_S_MASK);
+            } else {
+                tcg_gen_andi_i32(tmp, tmp, ~R_V7M_FPCCR_S_MASK);
+            }
+            store_cpu_field(tmp, v7m.fpccr[M_REG_S]);
+            /* Don't need to do this for any further FP insns in this TB */
+            s->v8m_fpccr_s_wrong = false;
+        }
+
+        if (s->v7m_new_fp_ctxt_needed) {
+            /*
+             * Create new FP context by updating CONTROL.FPCA, CONTROL.SFPA
+             * and the FPSCR.
+             */
+            TCGv_i32 control, fpscr;
+            uint32_t bits = R_V7M_CONTROL_FPCA_MASK;
+
+            fpscr = load_cpu_field(v7m.fpdscr[s->v8m_secure]);
+            gen_helper_vfp_set_fpscr(cpu_env, fpscr);
+            tcg_temp_free_i32(fpscr);
+            /*
+             * We don't need to arrange to end the TB, because the only
+             * parts of FPSCR which we cache in the TB flags are the VECLEN
+             * and VECSTRIDE, and those don't exist for M-profile.
+             */
+
+            if (s->v8m_secure) {
+                bits |= R_V7M_CONTROL_SFPA_MASK;
+            }
+            control = load_cpu_field(v7m.control[M_REG_S]);
+            tcg_gen_ori_i32(control, control, bits);
+            store_cpu_field(control, v7m.control[M_REG_S]);
+            /* Don't need to do this for any further FP insns in this TB */
+            s->v7m_new_fp_ctxt_needed = false;
+        }
+    }
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ca9e0bfd99e..6088ffdc6ee 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3373,8 +3373,10 @@ static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
     return 1;
 }
 
-/* Disassemble a VFP instruction.  Returns nonzero if an error occurred
-   (ie. an undefined instruction).  */
+/*
+ * Disassemble a VFP instruction.  Returns nonzero if an error occurred
+ * (ie. an undefined instruction).
+ */
 static int disas_vfp_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t rd, rn, rm, op, i, n, offset, delta_d, delta_m, bank_mask;
@@ -3382,6 +3384,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
     TCGv_i32 addr;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
+    bool ignore_vfp_enabled = false;
 
     if (!arm_dc_feature(s, ARM_FEATURE_VFP)) {
         return 1;
@@ -3403,98 +3406,20 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
         }
     }
 
-    /* FIXME: this access check should not take precedence over UNDEF
+    /*
+     * FIXME: this access check should not take precedence over UNDEF
      * for invalid encodings; we will generate incorrect syndrome information
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
      */
-    if (s->fp_excp_el) {
-        if (arm_dc_feature(s, ARM_FEATURE_M)) {
-            gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
-                               s->fp_excp_el);
-        } else {
-            gen_exception_insn(s, 4, EXCP_UDEF,
-                               syn_fp_access_trap(1, 0xe, false),
-                               s->fp_excp_el);
-        }
-        return 0;
-    }
-
-    if (!s->vfp_enabled) {
-        /* VFP disabled.  Only allow fmxr/fmrx to/from some control regs.  */
-        if ((insn & 0x0fe00fff) != 0x0ee00a10)
-            return 1;
+    if ((insn & 0x0fe00fff) == 0x0ee00a10) {
         rn = (insn >> 16) & 0xf;
-        if (rn != ARM_VFP_FPSID && rn != ARM_VFP_FPEXC && rn != ARM_VFP_MVFR2
-            && rn != ARM_VFP_MVFR1 && rn != ARM_VFP_MVFR0) {
-            return 1;
+        if (rn == ARM_VFP_FPSID || rn == ARM_VFP_FPEXC || rn == ARM_VFP_MVFR2
+            || rn == ARM_VFP_MVFR1 || rn == ARM_VFP_MVFR0) {
+            ignore_vfp_enabled = true;
         }
     }
-
-    if (arm_dc_feature(s, ARM_FEATURE_M)) {
-        /* Handle M-profile lazy FP state mechanics */
-
-        /* Trigger lazy-state preservation if necessary */
-        if (s->v7m_lspact) {
-            /*
-             * Lazy state saving affects external memory and also the NVIC,
-             * so we must mark it as an IO operation for icount.
-             */
-            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                gen_io_start();
-            }
-            gen_helper_v7m_preserve_fp_state(cpu_env);
-            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                gen_io_end();
-            }
-            /*
-             * If the preserve_fp_state helper doesn't throw an exception
-             * then it will clear LSPACT; we don't need to repeat this for
-             * any further FP insns in this TB.
-             */
-            s->v7m_lspact = false;
-        }
-
-        /* Update ownership of FP context: set FPCCR.S to match current state */
-        if (s->v8m_fpccr_s_wrong) {
-            TCGv_i32 tmp;
-
-            tmp = load_cpu_field(v7m.fpccr[M_REG_S]);
-            if (s->v8m_secure) {
-                tcg_gen_ori_i32(tmp, tmp, R_V7M_FPCCR_S_MASK);
-            } else {
-                tcg_gen_andi_i32(tmp, tmp, ~R_V7M_FPCCR_S_MASK);
-            }
-            store_cpu_field(tmp, v7m.fpccr[M_REG_S]);
-            /* Don't need to do this for any further FP insns in this TB */
-            s->v8m_fpccr_s_wrong = false;
-        }
-
-        if (s->v7m_new_fp_ctxt_needed) {
-            /*
-             * Create new FP context by updating CONTROL.FPCA, CONTROL.SFPA
-             * and the FPSCR.
-             */
-            TCGv_i32 control, fpscr;
-            uint32_t bits = R_V7M_CONTROL_FPCA_MASK;
-
-            fpscr = load_cpu_field(v7m.fpdscr[s->v8m_secure]);
-            gen_helper_vfp_set_fpscr(cpu_env, fpscr);
-            tcg_temp_free_i32(fpscr);
-            /*
-             * We don't need to arrange to end the TB, because the only
-             * parts of FPSCR which we cache in the TB flags are the VECLEN
-             * and VECSTRIDE, and those don't exist for M-profile.
-             */
-
-            if (s->v8m_secure) {
-                bits |= R_V7M_CONTROL_SFPA_MASK;
-            }
-            control = load_cpu_field(v7m.control[M_REG_S]);
-            tcg_gen_ori_i32(control, control, bits);
-            store_cpu_field(control, v7m.control[M_REG_S]);
-            /* Don't need to do this for any further FP insns in this TB */
-            s->v7m_new_fp_ctxt_needed = false;
-        }
+    if (!full_vfp_access_check(s, ignore_vfp_enabled)) {
+        return 0;
     }
 
     if (extract32(insn, 28, 4) == 0xf) {
-- 
2.20.1


