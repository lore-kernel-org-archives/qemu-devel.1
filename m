Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F138C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 02:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A732073A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 02:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1SPbKLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A732073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTc1l-000354-PO
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 22:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTby3-0006pS-UX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 22:29:11 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:43212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTby1-0007uf-Js
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 22:29:11 -0400
Received: by mail-pl1-x635.google.com with SMTP id o9so2206493plx.10
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 19:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HwBhEtwUMo2n1jlgRpkoHJK7IbT+pEwOIJ1XBIp7rtA=;
 b=J1SPbKLnf+qNxRU7TXHF/uasSM8DAgKYYEJTvfwPKeAq6KxBgAvPfralqEHJZ1iWyn
 dExM10CUqxvQJqTxLAM6CL/Hw1L2BKFWlL8zya7cDXgQkYh3GKzpCoIa6SVG/oQlP1R4
 62cz2NI+qoutubNuBCHcLivyUgePP/kOnjIQKF5jtKHlMsfb1P2NouVl+u6C9Pt/x69L
 oDOpsE3ahLTqjsUZ1uDWgsWqmgNVBDwhNImyU30A+l44QFCl9ebql1DB5C19/ZUVPEC6
 V27zVs+it7CsyluuAcIPrnjG3QLfDxFTVxgwDlTY/gwZPhChT/DCnBYSBG5U66JfMomg
 +kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HwBhEtwUMo2n1jlgRpkoHJK7IbT+pEwOIJ1XBIp7rtA=;
 b=f5N0GeHpvVdSj2oAyLPn+O2Y36mbjfX3Kgkmzt2NZIRGXT6vuNF2HMWnEiemtGraf7
 RRmb9kccDWNavD4g4eCmAeWkhULOUMsFMpRnmxXJH9LbEnpfh+qManWGpuaj6yOt6RjH
 RyWqBK7hssv/y//NOjyPeYaFFa+ZzKwvgWTqS8dzW2g8jthJubQMlUVsIczr6FFI7Q6s
 ERXglPWHBEuydGtCLRAWd5ct59yC/DdPj3nUehU2qHztGNv9GEFmgNETicW2As8inrtE
 oC4qH9FUaDO+gRkBl5yFfcWoluRYlnccB5yKNQGl3i1Nmu+/ylohEMxQeCE84O2zb7F5
 tJCQ==
X-Gm-Message-State: AOAM531S/HBcdaUv26hdi7cTXhqe+UmIORTElqjvgeDreEu9GRgLvxG3
 nPDdax3Oo/JxGDeAw95NjyxjqiKOduNXBw==
X-Google-Smtp-Source: ABdhPJyQjCAnT0jzu6OBdCN/eO7bGGr/uXfaDSzstybxyntz0KFH5TRvzMK3GXaUfDCjWsLA9F7rPQ==
X-Received: by 2002:a17:90a:a394:: with SMTP id
 x20mr6906694pjp.213.1602901747477; 
 Fri, 16 Oct 2020 19:29:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k9sm4150818pgt.72.2020.10.16.19.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 19:29:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] target/s390x: Improve cc computation for SUBTRACT LOGICAL
Date: Fri, 16 Oct 2020 19:29:00 -0700
Message-Id: <20201017022901.78425-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201017022901.78425-1-richard.henderson@linaro.org>
References: <20201017022901.78425-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

The resulting cc is only dependent on the result and the
borrow-out.  So save those things rather than the inputs.

Borrow-out for 64-bit inputs is had via tcg_gen_sub2_i64 directly
into cc_src.  Borrow-out for 32-bit inputs is had via extraction
from a normal 64-bit sub (with zero-extended inputs).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    |  3 +--
 target/s390x/cc_helper.c   | 40 ++++++---------------------
 target/s390x/helper.c      |  3 +--
 target/s390x/translate.c   | 55 +++++++++++++++-----------------------
 target/s390x/insn-data.def | 24 ++++++++---------
 5 files changed, 43 insertions(+), 82 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index f5f3ae063e..4077047494 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -161,6 +161,7 @@ enum cc_op {
 
     CC_OP_NZ,                   /* env->cc_dst != 0 */
     CC_OP_ADDU,                 /* dst != 0, src = carry out (0,1) */
+    CC_OP_SUBU,                 /* dst != 0, src = borrow out (0,-1) */
 
     CC_OP_LTGT_32,              /* signed less/greater than (32bit) */
     CC_OP_LTGT_64,              /* signed less/greater than (64bit) */
@@ -171,7 +172,6 @@ enum cc_op {
 
     CC_OP_ADD_64,               /* overflow on add (64bit) */
     CC_OP_SUB_64,               /* overflow on subtraction (64bit) */
-    CC_OP_SUBU_64,              /* overflow on unsigned subtraction (64bit) */
     CC_OP_SUBB_64,              /* overflow on unsigned sub-borrow (64bit) */
     CC_OP_ABS_64,               /* sign eval on abs (64bit) */
     CC_OP_NABS_64,              /* sign eval on nabs (64bit) */
@@ -179,7 +179,6 @@ enum cc_op {
 
     CC_OP_ADD_32,               /* overflow on add (32bit) */
     CC_OP_SUB_32,               /* overflow on subtraction (32bit) */
-    CC_OP_SUBU_32,              /* overflow on unsigned subtraction (32bit) */
     CC_OP_SUBB_32,              /* overflow on unsigned sub-borrow (32bit) */
     CC_OP_ABS_32,               /* sign eval on abs (64bit) */
     CC_OP_NABS_32,              /* sign eval on nabs (64bit) */
diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index cd2c5c4b39..c7728d1225 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -129,6 +129,11 @@ static uint32_t cc_calc_addu(uint64_t carry_out, uint64_t result)
     return (result != 0) + 2 * carry_out;
 }
 
+static uint32_t cc_calc_subu(uint64_t borrow_out, uint64_t result)
+{
+    return cc_calc_addu(borrow_out + 1, result);
+}
+
 static uint32_t cc_calc_add_64(int64_t a1, int64_t a2, int64_t ar)
 {
     if ((a1 > 0 && a2 > 0 && ar < 0) || (a1 < 0 && a2 < 0 && ar > 0)) {
@@ -159,19 +164,6 @@ static uint32_t cc_calc_sub_64(int64_t a1, int64_t a2, int64_t ar)
     }
 }
 
-static uint32_t cc_calc_subu_64(uint64_t a1, uint64_t a2, uint64_t ar)
-{
-    if (ar == 0) {
-        return 2;
-    } else {
-        if (a2 > a1) {
-            return 1;
-        } else {
-            return 3;
-        }
-    }
-}
-
 static uint32_t cc_calc_subb_64(uint64_t a1, uint64_t a2, uint64_t ar)
 {
     int borrow_out;
@@ -245,19 +237,6 @@ static uint32_t cc_calc_sub_32(int32_t a1, int32_t a2, int32_t ar)
     }
 }
 
-static uint32_t cc_calc_subu_32(uint32_t a1, uint32_t a2, uint32_t ar)
-{
-    if (ar == 0) {
-        return 2;
-    } else {
-        if (a2 > a1) {
-            return 1;
-        } else {
-            return 3;
-        }
-    }
-}
-
 static uint32_t cc_calc_subb_32(uint32_t a1, uint32_t a2, uint32_t ar)
 {
     int borrow_out;
@@ -462,15 +441,15 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
     case CC_OP_ADDU:
         r = cc_calc_addu(src, dst);
         break;
+    case CC_OP_SUBU:
+        r = cc_calc_subu(src, dst);
+        break;
     case CC_OP_ADD_64:
         r =  cc_calc_add_64(src, dst, vr);
         break;
     case CC_OP_SUB_64:
         r =  cc_calc_sub_64(src, dst, vr);
         break;
-    case CC_OP_SUBU_64:
-        r =  cc_calc_subu_64(src, dst, vr);
-        break;
     case CC_OP_SUBB_64:
         r =  cc_calc_subb_64(src, dst, vr);
         break;
@@ -493,9 +472,6 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
     case CC_OP_SUB_32:
         r =  cc_calc_sub_32(src, dst, vr);
         break;
-    case CC_OP_SUBU_32:
-        r =  cc_calc_subu_32(src, dst, vr);
-        break;
     case CC_OP_SUBB_32:
         r =  cc_calc_subb_32(src, dst, vr);
         break;
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 4f4561bc64..fa3aa500e5 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -396,6 +396,7 @@ const char *cc_name(enum cc_op cc_op)
         [CC_OP_STATIC]    = "CC_OP_STATIC",
         [CC_OP_NZ]        = "CC_OP_NZ",
         [CC_OP_ADDU]      = "CC_OP_ADDU",
+        [CC_OP_SUBU]      = "CC_OP_SUBU",
         [CC_OP_LTGT_32]   = "CC_OP_LTGT_32",
         [CC_OP_LTGT_64]   = "CC_OP_LTGT_64",
         [CC_OP_LTUGTU_32] = "CC_OP_LTUGTU_32",
@@ -404,13 +405,11 @@ const char *cc_name(enum cc_op cc_op)
         [CC_OP_LTGT0_64]  = "CC_OP_LTGT0_64",
         [CC_OP_ADD_64]    = "CC_OP_ADD_64",
         [CC_OP_SUB_64]    = "CC_OP_SUB_64",
-        [CC_OP_SUBU_64]   = "CC_OP_SUBU_64",
         [CC_OP_SUBB_64]   = "CC_OP_SUBB_64",
         [CC_OP_ABS_64]    = "CC_OP_ABS_64",
         [CC_OP_NABS_64]   = "CC_OP_NABS_64",
         [CC_OP_ADD_32]    = "CC_OP_ADD_32",
         [CC_OP_SUB_32]    = "CC_OP_SUB_32",
-        [CC_OP_SUBU_32]   = "CC_OP_SUBU_32",
         [CC_OP_SUBB_32]   = "CC_OP_SUBB_32",
         [CC_OP_ABS_32]    = "CC_OP_ABS_32",
         [CC_OP_NABS_32]   = "CC_OP_NABS_32",
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 570b3c88c8..48494a86cc 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -601,11 +601,9 @@ static void gen_op_calc_cc(DisasContext *s)
         /* FALLTHRU */
     case CC_OP_ADD_64:
     case CC_OP_SUB_64:
-    case CC_OP_SUBU_64:
     case CC_OP_SUBB_64:
     case CC_OP_ADD_32:
     case CC_OP_SUB_32:
-    case CC_OP_SUBU_32:
     case CC_OP_SUBB_32:
         local_cc_op = tcg_const_i32(s->cc_op);
         break;
@@ -656,6 +654,7 @@ static void gen_op_calc_cc(DisasContext *s)
     case CC_OP_TM_64:
     case CC_OP_SLA_32:
     case CC_OP_SLA_64:
+    case CC_OP_SUBU:
     case CC_OP_NZ_F128:
     case CC_OP_VC:
     case CC_OP_MULS_64:
@@ -664,11 +663,9 @@ static void gen_op_calc_cc(DisasContext *s)
         break;
     case CC_OP_ADD_64:
     case CC_OP_SUB_64:
-    case CC_OP_SUBU_64:
     case CC_OP_SUBB_64:
     case CC_OP_ADD_32:
     case CC_OP_SUB_32:
-    case CC_OP_SUBU_32:
     case CC_OP_SUBB_32:
         /* 3 arguments */
         gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, cc_src, cc_dst, cc_vr);
@@ -843,6 +840,7 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
         break;
 
     case CC_OP_ADDU:
+    case CC_OP_SUBU:
         switch (mask) {
         case 8 | 2: /* result == 0 */
             cond = TCG_COND_EQ;
@@ -850,33 +848,11 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
         case 4 | 1: /* result != 0 */
             cond = TCG_COND_NE;
             break;
-        case 8 | 4: /* no carry */
-            cond = TCG_COND_EQ;
+        case 8 | 4: /* !carry (borrow) */
+            cond = old_cc_op == CC_OP_ADDU ? TCG_COND_EQ : TCG_COND_NE;
             break;
-        case 2 | 1: /* carry */
-            cond = TCG_COND_NE;
-            break;
-        default:
-            goto do_dynamic;
-        }
-        account_inline_branch(s, old_cc_op);
-        break;
-
-    case CC_OP_SUBU_32:
-    case CC_OP_SUBU_64:
-        /* Note that CC=0 is impossible; treat it as dont-care.  */
-        switch (mask & 7) {
-        case 2: /* zero -> op1 == op2 */
-            cond = TCG_COND_EQ;
-            break;
-        case 4 | 1: /* !zero -> op1 != op2 */
-            cond = TCG_COND_NE;
-            break;
-        case 4: /* borrow (!carry) -> op1 < op2 */
-            cond = TCG_COND_LTU;
-            break;
-        case 2 | 1: /* !borrow (carry) -> op1 >= op2 */
-            cond = TCG_COND_GEU;
+        case 2 | 1: /* carry (!borrow) */
+            cond = old_cc_op == CC_OP_ADDU ? TCG_COND_NE : TCG_COND_EQ;
             break;
         default:
             goto do_dynamic;
@@ -911,7 +887,6 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
         break;
     case CC_OP_LTGT_32:
     case CC_OP_LTUGTU_32:
-    case CC_OP_SUBU_32:
         c->is_64 = false;
         c->u.s32.a = tcg_temp_new_i32();
         tcg_gen_extrl_i64_i32(c->u.s32.a, cc_src);
@@ -928,7 +903,6 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
         break;
     case CC_OP_LTGT_64:
     case CC_OP_LTUGTU_64:
-    case CC_OP_SUBU_64:
         c->u.s64.a = cc_src;
         c->u.s64.b = cc_dst;
         c->g1 = c->g2 = true;
@@ -943,6 +917,7 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
         break;
 
     case CC_OP_ADDU:
+    case CC_OP_SUBU:
         c->is_64 = true;
         c->u.s64.b = tcg_const_i64(0);
         c->g1 = true;
@@ -1444,6 +1419,9 @@ static void compute_carry(DisasContext *s)
     switch (s->cc_op) {
     case CC_OP_ADDU:
         break;
+    case CC_OP_SUBU:
+        tcg_gen_addi_i64(cc_src, cc_src, 1);
+        break;
     default:
         gen_op_calc_cc(s);
         /* fall through */
@@ -4759,6 +4737,13 @@ static DisasJumpType op_sub(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_subu64(DisasContext *s, DisasOps *o)
+{
+    tcg_gen_movi_i64(cc_src, 0);
+    tcg_gen_sub2_i64(o->out, cc_src, o->in1, cc_src, o->in2, cc_src);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_subb(DisasContext *s, DisasOps *o)
 {
     DisasCompare cmp;
@@ -5310,12 +5295,14 @@ static void cout_subs64(DisasContext *s, DisasOps *o)
 
 static void cout_subu32(DisasContext *s, DisasOps *o)
 {
-    gen_op_update3_cc_i64(s, CC_OP_SUBU_32, o->in1, o->in2, o->out);
+    tcg_gen_sari_i64(cc_src, o->out, 32);
+    tcg_gen_ext32u_i64(cc_dst, o->out);
+    gen_op_update2_cc_i64(s, CC_OP_SUBU, cc_src, cc_dst);
 }
 
 static void cout_subu64(DisasContext *s, DisasOps *o)
 {
-    gen_op_update3_cc_i64(s, CC_OP_SUBU_64, o->in1, o->in2, o->out);
+    gen_op_update2_cc_i64(s, CC_OP_SUBU, cc_src, o->out);
 }
 
 static void cout_subb32(DisasContext *s, DisasOps *o)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d9e65a0380..65ee998484 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -900,21 +900,21 @@
     C(0xb9c9, SHHHR,   RRF_a, HW,  r2_sr32, r3_sr32, new, r1_32h, sub, subs32)
     C(0xb9d9, SHHLR,   RRF_a, HW,  r2_sr32, r3, new, r1_32h, sub, subs32)
 /* SUBTRACT LOGICAL */
-    C(0x1f00, SLR,     RR_a,  Z,   r1, r2, new, r1_32, sub, subu32)
-    C(0xb9fb, SLRK,    RRF_a, DO,  r2, r3, new, r1_32, sub, subu32)
-    C(0x5f00, SL,      RX_a,  Z,   r1, m2_32u, new, r1_32, sub, subu32)
-    C(0xe35f, SLY,     RXY_a, LD,  r1, m2_32u, new, r1_32, sub, subu32)
-    C(0xb90b, SLGR,    RRE,   Z,   r1, r2, r1, 0, sub, subu64)
-    C(0xb91b, SLGFR,   RRE,   Z,   r1, r2_32u, r1, 0, sub, subu64)
-    C(0xb9eb, SLGRK,   RRF_a, DO,  r2, r3, r1, 0, sub, subu64)
-    C(0xe30b, SLG,     RXY_a, Z,   r1, m2_64, r1, 0, sub, subu64)
-    C(0xe31b, SLGF,    RXY_a, Z,   r1, m2_32u, r1, 0, sub, subu64)
+    C(0x1f00, SLR,     RR_a,  Z,   r1_32u, r2_32u, new, r1_32, sub, subu32)
+    C(0xb9fb, SLRK,    RRF_a, DO,  r2_32u, r3_32u, new, r1_32, sub, subu32)
+    C(0x5f00, SL,      RX_a,  Z,   r1_32u, m2_32u, new, r1_32, sub, subu32)
+    C(0xe35f, SLY,     RXY_a, LD,  r1_32u, m2_32u, new, r1_32, sub, subu32)
+    C(0xb90b, SLGR,    RRE,   Z,   r1, r2, r1, 0, subu64, subu64)
+    C(0xb91b, SLGFR,   RRE,   Z,   r1, r2_32u, r1, 0, subu64, subu64)
+    C(0xb9eb, SLGRK,   RRF_a, DO,  r2, r3, r1, 0, subu64, subu64)
+    C(0xe30b, SLG,     RXY_a, Z,   r1, m2_64, r1, 0, subu64, subu64)
+    C(0xe31b, SLGF,    RXY_a, Z,   r1, m2_32u, r1, 0, subu64, subu64)
 /* SUBTRACT LOCICAL HIGH */
     C(0xb9cb, SLHHHR,  RRF_a, HW,  r2_sr32, r3_sr32, new, r1_32h, sub, subu32)
-    C(0xb9db, SLHHLR,  RRF_a, HW,  r2_sr32, r3, new, r1_32h, sub, subu32)
+    C(0xb9db, SLHHLR,  RRF_a, HW,  r2_sr32, r3_32u, new, r1_32h, sub, subu32)
 /* SUBTRACT LOGICAL IMMEDIATE */
-    C(0xc205, SLFI,    RIL_a, EI,  r1, i2_32u, new, r1_32, sub, subu32)
-    C(0xc204, SLGFI,   RIL_a, EI,  r1, i2_32u, r1, 0, sub, subu64)
+    C(0xc205, SLFI,    RIL_a, EI,  r1_32u, i2_32u, new, r1_32, sub, subu32)
+    C(0xc204, SLGFI,   RIL_a, EI,  r1, i2_32u, r1, 0, subu64, subu64)
 /* SUBTRACT LOGICAL WITH BORROW */
     C(0xb999, SLBR,    RRE,   Z,   r1, r2, new, r1_32, subb, subb32)
     C(0xb989, SLBGR,   RRE,   Z,   r1, r2, r1, 0, subb, subb64)
-- 
2.25.1


