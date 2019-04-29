Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5E4C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CDB20675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNoAkVBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CDB20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60758 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9q4-0006EQ-G5
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:13:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eo-0004pj-31
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9em-0006iu-Ck
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:33 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9ej-0006Ul-24
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id t17so17057979wrw.13
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Y4C5w6/Db1LmG76galdQjy2nSXocsVdE6jJGAF1IatQ=;
	b=ZNoAkVBOkxZGhs6L30olMYcaz8GVjoWJ/4WY1zFEUSSGUa8LJ+5KrWnlvlIBjWCxx5
	GrKLsuCvjh0o57H1CRaCyf2ciZsgFmjKeqRoro6L28uWO07BKj6YeSHzQcnZg0TUF8Vo
	pZf/++7mu3T8gcZg/iW/MZi4lY7CqdCU05iM695fFgeO4dyQNFELW2h/ZnqGk4TIc054
	P2RtU/Iwn51HibUH0S8zKGXIbs+B632kpbhUD4TMIh86hSIng/mLBq09Lxu80e4DClB9
	nT40cUC4W73akvObErQnVPIkxf2zyDSS9V1F39SnY7rfRvV8dImpTlae3d3ifU+CfmWI
	afIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Y4C5w6/Db1LmG76galdQjy2nSXocsVdE6jJGAF1IatQ=;
	b=Fy4Ksji+Aa9qqYGR6fe/nA7GxmK+Tn6QZDTntEHVCSJPJjbr2KdvhnfWGIuDAle+6W
	zU2BMJAzTJVmgstKBfkyVYjDXSV1d8+Q6Egr+9179dm+3WSvtvPZlNtIioNaKInjSvl0
	b0CpHMIRa43fZ3YZ+cwU+cekQoxdYtMLapMilAjDI83wp4qqUg2TofXH/GN9hf6amMDT
	yZ6sGvZWGE7boIcOzpowhjmBGv22A46jU10P2Dop7ot4xhcENkF0zqs7g0UERV2PWhHn
	n5lJLO3zRQvqfFfwXdvnmiuCNIiy9WoBur+kcz9W6GpkgBb8C2L9wX6BnXy947epDOi4
	Vaug==
X-Gm-Message-State: APjAAAVW7ISEdtY1w2ijPLsk490XYQsfhWvOa/qaxoqezSfQdO/Pqwz6
	q7Bk3l4RWg7FbeqUw1J0h14KJgDOtuM=
X-Google-Smtp-Source: APXvYqzOq9DHnATOpPmenF7y0ItEYI6idclmn8+HmKh2m9yqVZ7wvn+A8vacgxERp8pMN4hWyz2MQQ==
X-Received: by 2002:adf:80ec:: with SMTP id 99mr32850268wrl.55.1556557260376; 
	Mon, 29 Apr 2019 10:01:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.59
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:10 +0100
Message-Id: <20190429170030.11323-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 22/42] target/arm: Activate M-profile floating
 point context when FPCCR.ASPEN is set
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
Message-ID: <20190429170010.cQ5SPigdKFFZE7Lu7XYK9p9QBlayZavDFM94-nAJZxw@z>

The M-profile FPCCR.ASPEN bit indicates that automatic floating-point
context preservation is enabled. Before executing any floating-point
instruction, if FPCCR.ASPEN is set and the CONTROL FPCA/SFPA bits
indicate that there is no active floating point context then we
must create a new context (by initializing FPSCR and setting
FPCA/SFPA to indicate that the context is now active). In the
pseudocode this is handled by ExecuteFPCheck().

Implement this with a new TB flag which tracks whether we
need to create a new FP context.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-20-peter.maydell@linaro.org
---
 target/arm/cpu.h       |  2 ++
 target/arm/translate.h |  1 +
 target/arm/helper.c    | 13 +++++++++++++
 target/arm/translate.c | 29 +++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a2cf9aae3a1..d4996a4d204 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3153,6 +3153,8 @@ FIELD(TBFLAG_A32, NS, 6, 1)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
+/* For M profile only, set if we must create a new FP context */
+FIELD(TBFLAG_A32, NEW_FP_CTXT_NEEDED, 19, 1)
 /* For M profile only, set if FPCCR.S does not match current security state */
 FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1)
 /* For M profile only, Handler (ie not Thread) mode */
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 93abff645ad..ed8ae2e7e3b 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -41,6 +41,7 @@ typedef struct DisasContext {
     bool v8m_secure; /* true if v8M and we're in Secure mode */
     bool v8m_stackcheck; /* true if we need to perform v8M stack limit checks */
     bool v8m_fpccr_s_wrong; /* true if v8M FPCCR.S != v8m_secure */
+    bool v7m_new_fp_ctxt_needed; /* ASPEN set but no active FP context */
     /* Immediate value in AArch32 SVC insn; must be set if is_jmp == DISAS_SWI
      * so that top level loop can generate correct syndrome information.
      */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8290f56c658..84e3790a9de 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13422,6 +13422,19 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         flags = FIELD_DP32(flags, TBFLAG_A32, FPCCR_S_WRONG, 1);
     }
 
+    if (arm_feature(env, ARM_FEATURE_M) &&
+        (env->v7m.fpccr[env->v7m.secure] & R_V7M_FPCCR_ASPEN_MASK) &&
+        (!(env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK) ||
+         (env->v7m.secure &&
+          !(env->v7m.control[M_REG_S] & R_V7M_CONTROL_SFPA_MASK)))) {
+        /*
+         * ASPEN is set, but FPCA/SFPA indicate that there is no active
+         * FP context; we must create a new FP context before executing
+         * any FP insn.
+         */
+        flags = FIELD_DP32(flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED, 1);
+    }
+
     *pflags = flags;
     *cs_base = 0;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f0332ac19ec..edb66e7be8e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3438,6 +3438,33 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             /* Don't need to do this for any further FP insns in this TB */
             s->v8m_fpccr_s_wrong = false;
         }
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
     }
 
     if (extract32(insn, 28, 4) == 0xf) {
@@ -13361,6 +13388,8 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         regime_is_secure(env, dc->mmu_idx);
     dc->v8m_stackcheck = FIELD_EX32(tb_flags, TBFLAG_A32, STACKCHECK);
     dc->v8m_fpccr_s_wrong = FIELD_EX32(tb_flags, TBFLAG_A32, FPCCR_S_WRONG);
+    dc->v7m_new_fp_ctxt_needed =
+        FIELD_EX32(tb_flags, TBFLAG_A32, NEW_FP_CTXT_NEEDED);
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
-- 
2.20.1


