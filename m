Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E9FC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 02:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF10206CB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 02:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6j7qZ9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF10206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTc0S-0001VW-Db
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 22:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTby4-0006qw-JZ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 22:29:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTby2-0007ul-Gi
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 22:29:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id e10so2554585pfj.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 19:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7uoZ/ov1iV24cdkp01wD4WHng15fvh7IXfD1X0fJdkY=;
 b=x6j7qZ9hhQ4HHVOpGPITlHBd1H2NSiGpicBLsYsK+mboCZWGOyEjLtbQ+WB1DLfNv5
 zJEqNAtbccdvXwiTZa7ny3ACiDThTDKBBMpGANvQCFHnY5BDKuaA7lwsVyhzwYDXpWkh
 ySURDCdanWrknY92gUHEazBu9Jf/mQw5vefh8l/ySXZQsdvZWPCClR1JqIHg6n2q0lkW
 4yPcXUSydjn1grUBBePbExGpS+h2ZfqEQoPJJarf8Hq6pBh8z+UTGqLdEdwxn24UIT2r
 CPH+YpvdTuWFxo1QSX7QGIAIfTGO3lzGnQi31eG+97Jua16Kxw5TCC/5pB6mdG6MLcxi
 SanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7uoZ/ov1iV24cdkp01wD4WHng15fvh7IXfD1X0fJdkY=;
 b=TvjQ7W9FxGunnKFGDnr+faJB6EjhQs0vELNg3mqsxt4FoPJiRFauPNdOzN1tPJPpoU
 zpBIKedQ5RcwTcFkdzxskyIV9JMmuoQRDiUAHGxQEpYdOTgGzZ8VBUDP0E9cifd6eJRq
 hsfcpF8eDoaimLdylEkILpXPYlPECdFh7k3DBTA8p4Hexr6Lz3KW9d7b1uQKurX6+CFd
 CJ9iVGrxK+8f3z99SNrI/kMdNCLcMVOJ7jUaxDvB4+wu2732+efw9e0tBAn23jFgvWcT
 lMN4ffHfA8Pn/2cKwPysu3GDzxzXHlYDgmiM05vKC3XmUNQu+Z/6XkXxBpS8Tbuz3Ged
 T3sw==
X-Gm-Message-State: AOAM533fc6As4PNsesCF5Mp4fC+8UxaecqFAmOZds58Sqi+k0FKLqyu0
 Rq4hYxU9mHov7hVC5irJXCoiLnT0nHqLmg==
X-Google-Smtp-Source: ABdhPJx88MvT3vORUWrCvkUg9HNhkbyKLcjljYitxa3HnRXq15ePDNFRxvHuhbQ4L3eXjBqJSNMfgA==
X-Received: by 2002:a63:f343:: with SMTP id t3mr5496864pgj.86.1602901748527;
 Fri, 16 Oct 2020 19:29:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k9sm4150818pgt.72.2020.10.16.19.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 19:29:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] target/s390x: Improve SUB LOGICAL WITH BORROW
Date: Fri, 16 Oct 2020 19:29:01 -0700
Message-Id: <20201017022901.78425-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201017022901.78425-1-richard.henderson@linaro.org>
References: <20201017022901.78425-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that SUB LOGICAL outputs carry, we can use that as input directly.
It also means we can re-use CC_OP_ZC and produce an output carry
directly from SUB LOGICAL WITH BORROW.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    |  2 --
 target/s390x/cc_helper.c   | 32 -----------------
 target/s390x/helper.c      |  2 --
 target/s390x/translate.c   | 74 ++++++++++++++++++++------------------
 target/s390x/insn-data.def |  8 ++---
 5 files changed, 44 insertions(+), 74 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 4077047494..11515bb617 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -172,14 +172,12 @@ enum cc_op {
 
     CC_OP_ADD_64,               /* overflow on add (64bit) */
     CC_OP_SUB_64,               /* overflow on subtraction (64bit) */
-    CC_OP_SUBB_64,              /* overflow on unsigned sub-borrow (64bit) */
     CC_OP_ABS_64,               /* sign eval on abs (64bit) */
     CC_OP_NABS_64,              /* sign eval on nabs (64bit) */
     CC_OP_MULS_64,              /* overflow on signed multiply (64bit) */
 
     CC_OP_ADD_32,               /* overflow on add (32bit) */
     CC_OP_SUB_32,               /* overflow on subtraction (32bit) */
-    CC_OP_SUBB_32,              /* overflow on unsigned sub-borrow (32bit) */
     CC_OP_ABS_32,               /* sign eval on abs (64bit) */
     CC_OP_NABS_32,              /* sign eval on nabs (64bit) */
     CC_OP_MULS_32,              /* overflow on signed multiply (32bit) */
diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index c7728d1225..e7039d0d18 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -164,19 +164,6 @@ static uint32_t cc_calc_sub_64(int64_t a1, int64_t a2, int64_t ar)
     }
 }
 
-static uint32_t cc_calc_subb_64(uint64_t a1, uint64_t a2, uint64_t ar)
-{
-    int borrow_out;
-
-    if (ar != a1 - a2) {	/* difference means borrow-in */
-        borrow_out = (a2 >= a1);
-    } else {
-        borrow_out = (a2 > a1);
-    }
-
-    return (ar != 0) + 2 * !borrow_out;
-}
-
 static uint32_t cc_calc_abs_64(int64_t dst)
 {
     if ((uint64_t)dst == 0x8000000000000000ULL) {
@@ -237,19 +224,6 @@ static uint32_t cc_calc_sub_32(int32_t a1, int32_t a2, int32_t ar)
     }
 }
 
-static uint32_t cc_calc_subb_32(uint32_t a1, uint32_t a2, uint32_t ar)
-{
-    int borrow_out;
-
-    if (ar != a1 - a2) {	/* difference means borrow-in */
-        borrow_out = (a2 >= a1);
-    } else {
-        borrow_out = (a2 > a1);
-    }
-
-    return (ar != 0) + 2 * !borrow_out;
-}
-
 static uint32_t cc_calc_abs_32(int32_t dst)
 {
     if ((uint32_t)dst == 0x80000000UL) {
@@ -450,9 +424,6 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
     case CC_OP_SUB_64:
         r =  cc_calc_sub_64(src, dst, vr);
         break;
-    case CC_OP_SUBB_64:
-        r =  cc_calc_subb_64(src, dst, vr);
-        break;
     case CC_OP_ABS_64:
         r =  cc_calc_abs_64(dst);
         break;
@@ -472,9 +443,6 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
     case CC_OP_SUB_32:
         r =  cc_calc_sub_32(src, dst, vr);
         break;
-    case CC_OP_SUBB_32:
-        r =  cc_calc_subb_32(src, dst, vr);
-        break;
     case CC_OP_ABS_32:
         r =  cc_calc_abs_32(dst);
         break;
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index fa3aa500e5..7678994feb 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -405,12 +405,10 @@ const char *cc_name(enum cc_op cc_op)
         [CC_OP_LTGT0_64]  = "CC_OP_LTGT0_64",
         [CC_OP_ADD_64]    = "CC_OP_ADD_64",
         [CC_OP_SUB_64]    = "CC_OP_SUB_64",
-        [CC_OP_SUBB_64]   = "CC_OP_SUBB_64",
         [CC_OP_ABS_64]    = "CC_OP_ABS_64",
         [CC_OP_NABS_64]   = "CC_OP_NABS_64",
         [CC_OP_ADD_32]    = "CC_OP_ADD_32",
         [CC_OP_SUB_32]    = "CC_OP_SUB_32",
-        [CC_OP_SUBB_32]   = "CC_OP_SUBB_32",
         [CC_OP_ABS_32]    = "CC_OP_ABS_32",
         [CC_OP_NABS_32]   = "CC_OP_NABS_32",
         [CC_OP_COMP_32]   = "CC_OP_COMP_32",
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 48494a86cc..0d8235a5fb 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -601,10 +601,8 @@ static void gen_op_calc_cc(DisasContext *s)
         /* FALLTHRU */
     case CC_OP_ADD_64:
     case CC_OP_SUB_64:
-    case CC_OP_SUBB_64:
     case CC_OP_ADD_32:
     case CC_OP_SUB_32:
-    case CC_OP_SUBB_32:
         local_cc_op = tcg_const_i32(s->cc_op);
         break;
     case CC_OP_CONST0:
@@ -663,10 +661,8 @@ static void gen_op_calc_cc(DisasContext *s)
         break;
     case CC_OP_ADD_64:
     case CC_OP_SUB_64:
-    case CC_OP_SUBB_64:
     case CC_OP_ADD_32:
     case CC_OP_SUB_32:
-    case CC_OP_SUBB_32:
         /* 3 arguments */
         gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, cc_src, cc_dst, cc_vr);
         break;
@@ -4744,29 +4740,49 @@ static DisasJumpType op_subu64(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_subb(DisasContext *s, DisasOps *o)
+/* Compute borrow (0, -1) into cc_src. */
+static void compute_borrow(DisasContext *s)
 {
-    DisasCompare cmp;
-    TCGv_i64 borrow;
-
-    tcg_gen_sub_i64(o->out, o->in1, o->in2);
-
-    /* The !borrow flag is the msb of CC.  Since we want the inverse of
-       that, we ask for a comparison of CC=0 | CC=1 -> mask of 8 | 4.  */
-    disas_jcc(s, &cmp, 8 | 4);
-    borrow = tcg_temp_new_i64();
-    if (cmp.is_64) {
-        tcg_gen_setcond_i64(cmp.cond, borrow, cmp.u.s64.a, cmp.u.s64.b);
-    } else {
-        TCGv_i32 t = tcg_temp_new_i32();
-        tcg_gen_setcond_i32(cmp.cond, t, cmp.u.s32.a, cmp.u.s32.b);
-        tcg_gen_extu_i32_i64(borrow, t);
-        tcg_temp_free_i32(t);
+    switch (s->cc_op) {
+    case CC_OP_SUBU:
+        break;
+    default:
+        gen_op_calc_cc(s);
+        /* fall through */
+    case CC_OP_STATIC:
+        /* The carry flag is the msb of CC; compute into cc_src. */
+        tcg_gen_extu_i32_i64(cc_src, cc_op);
+        tcg_gen_shri_i64(cc_src, cc_src, 1);
+        /* fall through */
+    case CC_OP_ADDU:
+        tcg_gen_subi_i64(cc_src, cc_src, 1);
+        break;
     }
-    free_compare(&cmp);
+}
+
+static DisasJumpType op_subb32(DisasContext *s, DisasOps *o)
+{
+    compute_borrow(s);
+
+    /* Borrow is {0, -1}, so add to subtract. */
+    tcg_gen_add_i64(o->out, o->in1, cc_src);
+    tcg_gen_sub_i64(o->out, o->out, o->in2);
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_subb64(DisasContext *s, DisasOps *o)
+{
+    compute_borrow(s);
+
+    /*
+     * Borrow is {0, -1}, so add to subtract; replicate the
+     * borrow input to produce 128-bit -1 for the addition.
+     */
+    TCGv_i64 zero = tcg_const_i64(0);
+    tcg_gen_add2_i64(o->out, cc_src, o->in1, zero, cc_src, cc_src);
+    tcg_gen_sub2_i64(o->out, cc_src, o->out, cc_src, o->in2, zero);
+    tcg_temp_free_i64(zero);
 
-    tcg_gen_sub_i64(o->out, o->out, borrow);
-    tcg_temp_free_i64(borrow);
     return DISAS_NEXT;
 }
 
@@ -5305,16 +5321,6 @@ static void cout_subu64(DisasContext *s, DisasOps *o)
     gen_op_update2_cc_i64(s, CC_OP_SUBU, cc_src, o->out);
 }
 
-static void cout_subb32(DisasContext *s, DisasOps *o)
-{
-    gen_op_update3_cc_i64(s, CC_OP_SUBB_32, o->in1, o->in2, o->out);
-}
-
-static void cout_subb64(DisasContext *s, DisasOps *o)
-{
-    gen_op_update3_cc_i64(s, CC_OP_SUBB_64, o->in1, o->in2, o->out);
-}
-
 static void cout_tm32(DisasContext *s, DisasOps *o)
 {
     gen_op_update2_cc_i64(s, CC_OP_TM_32, o->in1, o->in2);
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 65ee998484..d91051843c 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -916,10 +916,10 @@
     C(0xc205, SLFI,    RIL_a, EI,  r1_32u, i2_32u, new, r1_32, sub, subu32)
     C(0xc204, SLGFI,   RIL_a, EI,  r1, i2_32u, r1, 0, subu64, subu64)
 /* SUBTRACT LOGICAL WITH BORROW */
-    C(0xb999, SLBR,    RRE,   Z,   r1, r2, new, r1_32, subb, subb32)
-    C(0xb989, SLBGR,   RRE,   Z,   r1, r2, r1, 0, subb, subb64)
-    C(0xe399, SLB,     RXY_a, Z,   r1, m2_32u, new, r1_32, subb, subb32)
-    C(0xe389, SLBG,    RXY_a, Z,   r1, m2_64, r1, 0, subb, subb64)
+    C(0xb999, SLBR,    RRE,   Z,   r1_32u, r2_32u, new, r1_32, subb32, subu32)
+    C(0xb989, SLBGR,   RRE,   Z,   r1, r2, r1, 0, subb64, subu64)
+    C(0xe399, SLB,     RXY_a, Z,   r1_32u, m2_32u, new, r1_32, subb32, subu32)
+    C(0xe389, SLBG,    RXY_a, Z,   r1, m2_64, r1, 0, subb64, subu64)
 
 /* SUPERVISOR CALL */
     C(0x0a00, SVC,     I,     Z,   0, 0, 0, 0, svc, 0)
-- 
2.25.1


