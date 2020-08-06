Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B18C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF52204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAgic/E0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF52204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dRa-0001Su-I1
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3dOV-0005RC-K3
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:45:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3dON-0007IC-6R
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:45:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id 3so9208907wmi.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EBNgN0Ja5rLk0wiwhZEL7X9U+oNVZQP7Ug0lGIXEnsw=;
 b=qAgic/E0PzHMgdaHqUsev9rZXzmrTXo+0CO0tOYkhIqaucdtEJyTzeD7Q40Q6B2J03
 akfrZp4+sbgQ4RsHFfvuqM6tafQiXaPDCJVqSbx+u7nP+hwPfHejVlcTX3wFVajYRKEZ
 /nEWgc+c8g4/hHfopfV7ezOd0759rNSI35Rs7j4/6sE2sZGlCnDnNCh552GMPeBqvQ1P
 LPvxINerOQmotf8RicScKy0czPmN44uBlDiGB15TwM+0I7VAw/PUPasqc5MuItSB5iSb
 CAWEhzwe0DaqIuHSxqfzgS78I11mv0v8/oEUNvW10k9nuLThFnxGXJ3t/XSR6tdUTNbE
 engA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EBNgN0Ja5rLk0wiwhZEL7X9U+oNVZQP7Ug0lGIXEnsw=;
 b=MszmI7jq4Yr07idjfEqEUsQwyRLD01aDvAt9OVh6mUK1RbL0tfxFRojHG2zfy9PaT7
 hdH692Je7LOGj2i2mvHZxKRx7+ra6QYFogmAfDxefXgYUx1k2fLdU7vfxCErDXhuhk/U
 eARZqwFfOgrBuETfwCkmTVfkITrLJLD7caTyk+gZziqBiHRGTSzlghwZtUFkwFDA94XT
 tCtDeuI+5+6cx7U6du3OBSpfdNhpWt/QOYD33DAAjCMsBCKuM3BEPkbqEZi6ecuU1PBq
 Qh878tTmyvYiPtYEWpfjFVy7/l6KqISsjtez+T5SE7QdnBPvaWko+pIKqf4pksGGLHDc
 X9/Q==
X-Gm-Message-State: AOAM530sn/p0idMxw+kCramPit72LebOJac8Y3+yVdTibl3Cpr09I3eX
 AHo42LwNw+Vr6nW33791DifEgeF/ffKngQ==
X-Google-Smtp-Source: ABdhPJyekN98lFLZ5b+vTaCG0lonlqpVc6X2kRiFfnINumgg2ub+O2s3asD+jEVsvAbb86MNAgoiqg==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr7811325wmc.9.1596710697109;
 Thu, 06 Aug 2020 03:44:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a10sm6042189wrx.15.2020.08.06.03.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:44:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/4] target/arm: Replace A64 get_fpstatus_ptr() with generic
 fpstatus_ptr()
Date: Thu,  6 Aug 2020 11:44:50 +0100
Message-Id: <20200806104453.30393-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200806104453.30393-1-peter.maydell@linaro.org>
References: <20200806104453.30393-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

We currently have two versions of get_fpstatus_ptr(), which both take
an effectively boolean argument:
 * the one for A64 takes "bool is_f16" to distinguish fp16 from other ops
 * the one for A32/T32 takes "int neon" to distinguish Neon from other ops

This is confusing, and to implement ARMv8.2-FP16 the A32/T32 one will
need to make a four-way distinction between "non-Neon, FP16",
"non-Neon, single/double", "Neon, FP16" and "Neon, single/double".
The A64 version will then be a strict subset of the A32/T32 version.

To clean this all up, we want to go to a single implementation which
takes an enum argument with values FPST_FPCR, FPST_STD,
FPST_FPCR_F16, and FPST_STD_F16.  We rename the function to
fpstatus_ptr() so that unconverted code gets a compilation error
rather than silently passing the wrong thing to the new function.

This commit implements that new API, and converts A64 to use it:
 get_fpstatus_ptr(false) -> fpstatus_ptr(FPST_FPCR)
 get_fpstatus_ptr(true) -> fpstatus_ptr(FPST_FPCR_F16)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This patch has a handful of 83-character lines; I felt they
were better than the ugly linewrap that would be needed.
All the callsite changes were done with editor search-and-replace.
---
 target/arm/translate-a64.h |  1 -
 target/arm/translate.h     | 51 ++++++++++++++++++++++
 target/arm/translate-a64.c | 89 +++++++++++++++-----------------------
 target/arm/translate-sve.c | 34 +++++++--------
 4 files changed, 103 insertions(+), 72 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 647f0c74f62..2e0d16da259 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -37,7 +37,6 @@ TCGv_i64 cpu_reg_sp(DisasContext *s, int reg);
 TCGv_i64 read_cpu_reg(DisasContext *s, int reg, int sf);
 TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int sf);
 void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v);
-TCGv_ptr get_fpstatus_ptr(bool);
 bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
                             unsigned int imms, unsigned int immr);
 bool sve_access_check(DisasContext *s);
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 16f2699ad72..e3680e65479 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -393,4 +393,55 @@ typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
 typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
 typedef void AtomicThreeOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, MemOp);
 
+/*
+ * Enum for argument to fpstatus_ptr().
+ */
+typedef enum ARMFPStatusFlavour {
+    FPST_FPCR,
+    FPST_FPCR_F16,
+    FPST_STD,
+    FPST_STD_F16,
+} ARMFPStatusFlavour;
+
+/**
+ * fpstatus_ptr: return TCGv_ptr to the specified fp_status field
+ *
+ * We have multiple softfloat float_status fields in the Arm CPU state struct
+ * (see the comment in cpu.h for details). Return a TCGv_ptr which has
+ * been set up to point to the requested field in the CPU state struct.
+ * The options are:
+ *
+ * FPST_FPCR
+ *   for non-FP16 operations controlled by the FPCR
+ * FPST_FPCR_F16
+ *   for operations controlled by the FPCR where FPCR.FZ16 is to be used
+ * FPST_STD
+ *   for A32/T32 Neon operations using the "standard FPSCR value"
+ * FPST_STD_F16
+ *   as FPST_STD, but where FPCR.FZ16 is to be used
+ */
+static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
+{
+    TCGv_ptr statusptr = tcg_temp_new_ptr();
+    int offset;
+
+    switch (flavour) {
+    case FPST_FPCR:
+        offset = offsetof(CPUARMState, vfp.fp_status);
+        break;
+    case FPST_FPCR_F16:
+        offset = offsetof(CPUARMState, vfp.fp_status_f16);
+        break;
+    case FPST_STD:
+        offset = offsetof(CPUARMState, vfp.standard_fp_status);
+        break;
+    case FPST_STD_F16:
+        /* Not yet used or implemented: fall through to assert */
+    default:
+        g_assert_not_reached();
+    }
+    tcg_gen_addi_ptr(statusptr, cpu_env, offset);
+    return statusptr;
+}
+
 #endif /* TARGET_ARM_TRANSLATE_H */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8c0764957c8..676fbd90e08 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -609,25 +609,6 @@ static void write_fp_sreg(DisasContext *s, int reg, TCGv_i32 v)
     tcg_temp_free_i64(tmp);
 }
 
-TCGv_ptr get_fpstatus_ptr(bool is_f16)
-{
-    TCGv_ptr statusptr = tcg_temp_new_ptr();
-    int offset;
-
-    /* In A64 all instructions (both FP and Neon) use the FPCR; there
-     * is no equivalent of the A32 Neon "standard FPSCR value".
-     * However half-precision operations operate under a different
-     * FZ16 flag and use vfp.fp_status_f16 instead of vfp.fp_status.
-     */
-    if (is_f16) {
-        offset = offsetof(CPUARMState, vfp.fp_status_f16);
-    } else {
-        offset = offsetof(CPUARMState, vfp.fp_status);
-    }
-    tcg_gen_addi_ptr(statusptr, cpu_env, offset);
-    return statusptr;
-}
-
 /* Expand a 2-operand AdvSIMD vector operation using an expander function.  */
 static void gen_gvec_fn2(DisasContext *s, bool is_q, int rd, int rn,
                          GVecGen2Fn *gvec_fn, int vece)
@@ -689,7 +670,7 @@ static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
                               int rm, bool is_fp16, int data,
                               gen_helper_gvec_3_ptr *fn)
 {
-    TCGv_ptr fpst = get_fpstatus_ptr(is_fp16);
+    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR);
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm), fpst,
@@ -5896,7 +5877,7 @@ static void handle_fp_compare(DisasContext *s, int size,
                               bool cmp_with_zero, bool signal_all_nans)
 {
     TCGv_i64 tcg_flags = tcg_temp_new_i64();
-    TCGv_ptr fpst = get_fpstatus_ptr(size == MO_16);
+    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
 
     if (size == MO_64) {
         TCGv_i64 tcg_vn, tcg_vm;
@@ -6155,7 +6136,7 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
         tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
         break;
     case 0x3: /* FSQRT */
-        fpst = get_fpstatus_ptr(true);
+        fpst = fpstatus_ptr(FPST_FPCR_F16);
         gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
         break;
     case 0x8: /* FRINTN */
@@ -6165,7 +6146,7 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
     case 0xc: /* FRINTA */
     {
         TCGv_i32 tcg_rmode = tcg_const_i32(arm_rmode_to_sf(opcode & 7));
-        fpst = get_fpstatus_ptr(true);
+        fpst = fpstatus_ptr(FPST_FPCR_F16);
 
         gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
         gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
@@ -6175,11 +6156,11 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
         break;
     }
     case 0xe: /* FRINTX */
-        fpst = get_fpstatus_ptr(true);
+        fpst = fpstatus_ptr(FPST_FPCR_F16);
         gen_helper_advsimd_rinth_exact(tcg_res, tcg_op, fpst);
         break;
     case 0xf: /* FRINTI */
-        fpst = get_fpstatus_ptr(true);
+        fpst = fpstatus_ptr(FPST_FPCR_F16);
         gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
         break;
     default:
@@ -6251,7 +6232,7 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
         g_assert_not_reached();
     }
 
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     if (rmode >= 0) {
         TCGv_i32 tcg_rmode = tcg_const_i32(rmode);
         gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
@@ -6328,7 +6309,7 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
         g_assert_not_reached();
     }
 
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     if (rmode >= 0) {
         TCGv_i32 tcg_rmode = tcg_const_i32(rmode);
         gen_helper_set_rmode(tcg_rmode, tcg_rmode, fpst);
@@ -6363,7 +6344,7 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
             /* Single to half */
             TCGv_i32 tcg_rd = tcg_temp_new_i32();
             TCGv_i32 ahp = get_ahp_flag();
-            TCGv_ptr fpst = get_fpstatus_ptr(false);
+            TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
 
             gen_helper_vfp_fcvt_f32_to_f16(tcg_rd, tcg_rn, fpst, ahp);
             /* write_fp_sreg is OK here because top half of tcg_rd is zero */
@@ -6383,7 +6364,7 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
             /* Double to single */
             gen_helper_vfp_fcvtsd(tcg_rd, tcg_rn, cpu_env);
         } else {
-            TCGv_ptr fpst = get_fpstatus_ptr(false);
+            TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
             TCGv_i32 ahp = get_ahp_flag();
             /* Double to half */
             gen_helper_vfp_fcvt_f64_to_f16(tcg_rd, tcg_rn, fpst, ahp);
@@ -6399,7 +6380,7 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
     case 0x3:
     {
         TCGv_i32 tcg_rn = read_fp_sreg(s, rn);
-        TCGv_ptr tcg_fpst = get_fpstatus_ptr(false);
+        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_FPCR);
         TCGv_i32 tcg_ahp = get_ahp_flag();
         tcg_gen_ext16u_i32(tcg_rn, tcg_rn);
         if (dtype == 0) {
@@ -6516,7 +6497,7 @@ static void handle_fp_2src_single(DisasContext *s, int opcode,
     TCGv_ptr fpst;
 
     tcg_res = tcg_temp_new_i32();
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     tcg_op1 = read_fp_sreg(s, rn);
     tcg_op2 = read_fp_sreg(s, rm);
 
@@ -6569,7 +6550,7 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
     TCGv_ptr fpst;
 
     tcg_res = tcg_temp_new_i64();
-    fpst = get_fpstatus_ptr(false);
+    fpst = fpstatus_ptr(FPST_FPCR);
     tcg_op1 = read_fp_dreg(s, rn);
     tcg_op2 = read_fp_dreg(s, rm);
 
@@ -6622,7 +6603,7 @@ static void handle_fp_2src_half(DisasContext *s, int opcode,
     TCGv_ptr fpst;
 
     tcg_res = tcg_temp_new_i32();
-    fpst = get_fpstatus_ptr(true);
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
     tcg_op1 = read_fp_hreg(s, rn);
     tcg_op2 = read_fp_hreg(s, rm);
 
@@ -6721,7 +6702,7 @@ static void handle_fp_3src_single(DisasContext *s, bool o0, bool o1,
 {
     TCGv_i32 tcg_op1, tcg_op2, tcg_op3;
     TCGv_i32 tcg_res = tcg_temp_new_i32();
-    TCGv_ptr fpst = get_fpstatus_ptr(false);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
 
     tcg_op1 = read_fp_sreg(s, rn);
     tcg_op2 = read_fp_sreg(s, rm);
@@ -6759,7 +6740,7 @@ static void handle_fp_3src_double(DisasContext *s, bool o0, bool o1,
 {
     TCGv_i64 tcg_op1, tcg_op2, tcg_op3;
     TCGv_i64 tcg_res = tcg_temp_new_i64();
-    TCGv_ptr fpst = get_fpstatus_ptr(false);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
 
     tcg_op1 = read_fp_dreg(s, rn);
     tcg_op2 = read_fp_dreg(s, rm);
@@ -6797,7 +6778,7 @@ static void handle_fp_3src_half(DisasContext *s, bool o0, bool o1,
 {
     TCGv_i32 tcg_op1, tcg_op2, tcg_op3;
     TCGv_i32 tcg_res = tcg_temp_new_i32();
-    TCGv_ptr fpst = get_fpstatus_ptr(true);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_F16);
 
     tcg_op1 = read_fp_hreg(s, rn);
     tcg_op2 = read_fp_hreg(s, rm);
@@ -6943,7 +6924,7 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
     TCGv_i32 tcg_shift, tcg_single;
     TCGv_i64 tcg_double;
 
-    tcg_fpstatus = get_fpstatus_ptr(type == 3);
+    tcg_fpstatus = fpstatus_ptr(type == 3 ? FPST_FPCR_F16 : FPST_FPCR);
 
     tcg_shift = tcg_const_i32(64 - scale);
 
@@ -7231,7 +7212,7 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
 static void handle_fjcvtzs(DisasContext *s, int rd, int rn)
 {
     TCGv_i64 t = read_fp_dreg(s, rn);
-    TCGv_ptr fpstatus = get_fpstatus_ptr(false);
+    TCGv_ptr fpstatus = fpstatus_ptr(FPST_FPCR);
 
     gen_helper_fjcvtzs(t, t, fpstatus);
 
@@ -7845,7 +7826,7 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
          * Note that correct NaN propagation requires that we do these
          * operations in exactly the order specified by the pseudocode.
          */
-        TCGv_ptr fpst = get_fpstatus_ptr(size == MO_16);
+        TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         int fpopcode = opcode | is_min << 4 | is_u << 5;
         int vmap = (1 << elements) - 1;
         TCGv_i32 tcg_res32 = do_reduction_op(s, fpopcode, rn, esize,
@@ -8357,7 +8338,7 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
             return;
         }
 
-        fpst = get_fpstatus_ptr(size == MO_16);
+        fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         break;
     default:
         unallocated_encoding(s);
@@ -8870,7 +8851,7 @@ static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
                                    int fracbits, int size)
 {
-    TCGv_ptr tcg_fpst = get_fpstatus_ptr(size == MO_16);
+    TCGv_ptr tcg_fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
     TCGv_i32 tcg_shift = NULL;
 
     MemOp mop = size | (is_signed ? MO_SIGN : 0);
@@ -9051,7 +9032,7 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
     assert(!(is_scalar && is_q));
 
     tcg_rmode = tcg_const_i32(arm_rmode_to_sf(FPROUNDING_ZERO));
-    tcg_fpstatus = get_fpstatus_ptr(size == MO_16);
+    tcg_fpstatus = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
     gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
     fracbits = (16 << size) - immhb;
     tcg_shift = tcg_const_i32(fracbits);
@@ -9390,7 +9371,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                                int fpopcode, int rd, int rn, int rm)
 {
     int pass;
-    TCGv_ptr fpst = get_fpstatus_ptr(false);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
 
     for (pass = 0; pass < elements; pass++) {
         if (size) {
@@ -9783,7 +9764,7 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
         return;
     }
 
-    fpst = get_fpstatus_ptr(true);
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
 
     tcg_op1 = read_fp_hreg(s, rn);
     tcg_op2 = read_fp_hreg(s, rm);
@@ -10036,7 +10017,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
         return;
     }
 
-    fpst = get_fpstatus_ptr(size == MO_16);
+    fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
 
     if (is_double) {
         TCGv_i64 tcg_op = tcg_temp_new_i64();
@@ -10166,7 +10147,7 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
                                     int size, int rn, int rd)
 {
     bool is_double = (size == 3);
-    TCGv_ptr fpst = get_fpstatus_ptr(false);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
 
     if (is_double) {
         TCGv_i64 tcg_op = tcg_temp_new_i64();
@@ -10307,7 +10288,7 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
             } else {
                 TCGv_i32 tcg_lo = tcg_temp_new_i32();
                 TCGv_i32 tcg_hi = tcg_temp_new_i32();
-                TCGv_ptr fpst = get_fpstatus_ptr(false);
+                TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
                 TCGv_i32 ahp = get_ahp_flag();
 
                 tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, tcg_op);
@@ -10569,7 +10550,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
 
     if (is_fcvt) {
         tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
-        tcg_fpstatus = get_fpstatus_ptr(false);
+        tcg_fpstatus = fpstatus_ptr(FPST_FPCR);
         gen_helper_set_rmode(tcg_rmode, tcg_rmode, tcg_fpstatus);
     } else {
         tcg_rmode = NULL;
@@ -11394,7 +11375,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
 
     /* Floating point operations need fpst */
     if (opcode >= 0x58) {
-        fpst = get_fpstatus_ptr(false);
+        fpst = fpstatus_ptr(FPST_FPCR);
     } else {
         fpst = NULL;
     }
@@ -11992,7 +11973,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         break;
     }
 
-    fpst = get_fpstatus_ptr(true);
+    fpst = fpstatus_ptr(FPST_FPCR_F16);
 
     if (pairwise) {
         int maxpass = is_q ? 8 : 4;
@@ -12285,7 +12266,7 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
         /* 16 -> 32 bit fp conversion */
         int srcelt = is_q ? 4 : 0;
         TCGv_i32 tcg_res[4];
-        TCGv_ptr fpst = get_fpstatus_ptr(false);
+        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
         TCGv_i32 ahp = get_ahp_flag();
 
         for (pass = 0; pass < 4; pass++) {
@@ -12757,7 +12738,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 
     if (need_fpstatus || need_rmode) {
-        tcg_fpstatus = get_fpstatus_ptr(false);
+        tcg_fpstatus = fpstatus_ptr(FPST_FPCR);
     } else {
         tcg_fpstatus = NULL;
     }
@@ -13147,7 +13128,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     }
 
     if (need_rmode || need_fpst) {
-        tcg_fpstatus = get_fpstatus_ptr(true);
+        tcg_fpstatus = fpstatus_ptr(FPST_FPCR_F16);
     }
 
     if (need_rmode) {
@@ -13456,7 +13437,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     if (is_fp) {
-        fpst = get_fpstatus_ptr(is_fp16);
+        fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR);
     } else {
         fpst = NULL;
     }
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 88a2fb271d1..ef0671bbdaa 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3470,7 +3470,7 @@ static bool trans_FMLA_zzxz(DisasContext *s, arg_FMLA_zzxz *a)
 
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3496,7 +3496,7 @@ static bool trans_FMUL_zzx(DisasContext *s, arg_FMUL_zzx *a)
 
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3528,7 +3528,7 @@ static void do_reduce(DisasContext *s, arg_rpr_esz *a,
 
     tcg_gen_addi_ptr(t_zn, cpu_env, vec_full_reg_offset(s, a->rn));
     tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, a->pg));
-    status = get_fpstatus_ptr(a->esz == MO_16);
+    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
 
     fn(temp, t_zn, t_pg, status, t_desc);
     tcg_temp_free_ptr(t_zn);
@@ -3570,7 +3570,7 @@ DO_VPZ(FMAXV, fmaxv)
 static void do_zz_fp(DisasContext *s, arg_rr_esz *a, gen_helper_gvec_2_ptr *fn)
 {
     unsigned vsz = vec_full_reg_size(s);
-    TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+    TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
 
     tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->rd),
                        vec_full_reg_offset(s, a->rn),
@@ -3618,7 +3618,7 @@ static void do_ppz_fp(DisasContext *s, arg_rpr_esz *a,
                       gen_helper_gvec_3_ptr *fn)
 {
     unsigned vsz = vec_full_reg_size(s);
-    TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+    TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
 
     tcg_gen_gvec_3_ptr(pred_full_reg_offset(s, a->rd),
                        vec_full_reg_offset(s, a->rn),
@@ -3670,7 +3670,7 @@ static bool trans_FTMAD(DisasContext *s, arg_FTMAD *a)
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3710,7 +3710,7 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
     t_pg = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_rm, cpu_env, vec_full_reg_offset(s, a->rm));
     tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, a->pg));
-    t_fpst = get_fpstatus_ptr(a->esz == MO_16);
+    t_fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
     t_desc = tcg_const_i32(simd_desc(vsz, vsz, 0));
 
     fns[a->esz - 1](t_val, t_val, t_rm, t_pg, t_fpst, t_desc);
@@ -3737,7 +3737,7 @@ static bool do_zzz_fp(DisasContext *s, arg_rrr_esz *a,
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3779,7 +3779,7 @@ static bool do_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3831,7 +3831,7 @@ static void do_fp_scalar(DisasContext *s, int zd, int zn, int pg, bool is_fp16,
     tcg_gen_addi_ptr(t_zn, cpu_env, vec_full_reg_offset(s, zn));
     tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
 
-    status = get_fpstatus_ptr(is_fp16);
+    status = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR);
     desc = tcg_const_i32(simd_desc(vsz, vsz, 0));
     fn(t_zd, t_zn, t_pg, scalar, status, desc);
 
@@ -3895,7 +3895,7 @@ static bool do_fp_cmp(DisasContext *s, arg_rprr_esz *a,
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         tcg_gen_gvec_4_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3939,7 +3939,7 @@ static bool trans_FCADD(DisasContext *s, arg_FCADD *a)
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3958,7 +3958,7 @@ static bool do_fmla(DisasContext *s, arg_rprrr_esz *a,
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         tcg_gen_gvec_5_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -4001,7 +4001,7 @@ static bool trans_FCMLA_zpzzz(DisasContext *s, arg_FCMLA_zpzzz *a)
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         tcg_gen_gvec_5_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -4024,7 +4024,7 @@ static bool trans_FCMLA_zzxz(DisasContext *s, arg_FCMLA_zzxz *a)
     tcg_debug_assert(a->rd == a->ra);
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -4045,7 +4045,7 @@ static bool do_zpz_ptr(DisasContext *s, int rd, int rn, int pg,
 {
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = get_fpstatus_ptr(is_fp16);
+        TCGv_ptr status = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR);
         tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
                            vec_full_reg_offset(s, rn),
                            pred_full_reg_offset(s, pg),
@@ -4191,7 +4191,7 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a, int mode)
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
         TCGv_i32 tmode = tcg_const_i32(mode);
-        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
 
         gen_helper_set_rmode(tmode, tmode, status);
 
-- 
2.20.1


