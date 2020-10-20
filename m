Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0429C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D6D2222C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Asr3XxFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D6D2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUwqy-00060G-NG
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUwnN-0001oV-Cc
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:55:41 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUwnK-0004F3-Rf
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:55:41 -0400
Received: by mail-pf1-x441.google.com with SMTP id h7so1710291pfn.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 11:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TdTtgrLWi5g5hjo7Ta/4e2djDapwCt1WyQaLtP6zvj0=;
 b=Asr3XxFT5iCu+C4Zcm9Srjv3CNHeGam9N8relYsNWxzZ3WmKfGJQ+myW2MZhfscwjB
 odruS/y6EMd8jCKbhmg0pCPRCAVCX3W3GOMDNGs6FygDpYXa6SvXE43Mxii+LrXH9stz
 Fq25WpHcaul5Dd1NkQFuK6twUkr0I1E7DHxzZEKBaiKwSGPDWSsOR2OpU5B8OvKjXdds
 /tYe7Dk3yFdpnqmvvO4I2kXClWR9HDQd/Df/Uf96mOKVVOJdKtjcqCcV05CAFejwkCm/
 4pYsk4pikE5wpLBufdadzZGzBhtMOH9wCqaePkiwCL2X6fR7yFg536UKBEXGx2fj5PkK
 o+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TdTtgrLWi5g5hjo7Ta/4e2djDapwCt1WyQaLtP6zvj0=;
 b=ql9cohjJszNpCMiG30ohNQ+RBIM2swrj4urXBRuWn866m4tDjTJlXYWpNodOYWoFOP
 lwrKRaHjEPUC1Tz+J3ExLorlh52SW8ClDluiCBYqWEVM9akKKiSA3SlUyGueHoa9s4Yk
 OKdT7pm0OdLldxXgfo2KQKtWBFplnjbY2Cx9pBdH+6E0KIMP99B2EP73SOInM38Av82v
 Si7NfKi2ZUsrNnG4ZoeyM9GZ7TnvmiTPmOQk9jnABrgtTQdccp9itZIJaivdS5h+yt/i
 STGhc7bpPhkKdBE1+g4Pzmp15yflgcEEVTHgia9tnZIdvWbRWe3Qm3TVbB+p68B78c7B
 2Rkg==
X-Gm-Message-State: AOAM53112qVVtcYcfQpfJ5l5IcteStz6yT6/wzlgONoy4OTgPLNkhqb7
 Nc9iBd31C0uXWHwnyWCuGmd3az0vQiFL9w==
X-Google-Smtp-Source: ABdhPJwTXYpv8xEDSapqzg5IcJ6nJL6D6ooxYy25XerUy59hnEVXGqOijRxE7sFwZAZiHD4cn5KxRA==
X-Received: by 2002:a65:5c43:: with SMTP id v3mr3999563pgr.271.1603220136453; 
 Tue, 20 Oct 2020 11:55:36 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y22sm2988962pgj.27.2020.10.20.11.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 11:55:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] target/s390x: Improve cc computation for ADD LOGICAL
Date: Tue, 20 Oct 2020 11:55:30 -0700
Message-Id: <20201020185533.1508487-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201020185533.1508487-1-richard.henderson@linaro.org>
References: <20201020185533.1508487-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
carry-out.  So save those things rather than the inputs.

Carry-out for 64-bit inputs is had via tcg_gen_add2_i64 directly
into cc_src.  Carry-out for 32-bit inputs is had via extraction
from a normal 64-bit add (with zero-extended inputs).

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    |   4 +-
 target/s390x/cc_helper.c   |  25 ++++-----
 target/s390x/helper.c      |   3 +-
 target/s390x/translate.c   | 103 ++++++++++++++++++++++++-------------
 target/s390x/insn-data.def |  36 ++++++-------
 5 files changed, 97 insertions(+), 74 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 64602660ae..55c5442102 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -160,6 +160,8 @@ enum cc_op {
     CC_OP_STATIC,               /* CC value is env->cc_op */
 
     CC_OP_NZ,                   /* env->cc_dst != 0 */
+    CC_OP_ADDU,                 /* dst != 0, src = carry out (0,1) */
+
     CC_OP_LTGT_32,              /* signed less/greater than (32bit) */
     CC_OP_LTGT_64,              /* signed less/greater than (64bit) */
     CC_OP_LTUGTU_32,            /* unsigned less/greater than (32bit) */
@@ -168,7 +170,6 @@ enum cc_op {
     CC_OP_LTGT0_64,             /* signed less/greater than 0 (64bit) */
 
     CC_OP_ADD_64,               /* overflow on add (64bit) */
-    CC_OP_ADDU_64,              /* overflow on unsigned add (64bit) */
     CC_OP_ADDC_64,              /* overflow on unsigned add-carry (64bit) */
     CC_OP_SUB_64,               /* overflow on subtraction (64bit) */
     CC_OP_SUBU_64,              /* overflow on unsigned subtraction (64bit) */
@@ -178,7 +179,6 @@ enum cc_op {
     CC_OP_MULS_64,              /* overflow on signed multiply (64bit) */
 
     CC_OP_ADD_32,               /* overflow on add (32bit) */
-    CC_OP_ADDU_32,              /* overflow on unsigned add (32bit) */
     CC_OP_ADDC_32,              /* overflow on unsigned add-carry (32bit) */
     CC_OP_SUB_32,               /* overflow on subtraction (32bit) */
     CC_OP_SUBU_32,              /* overflow on unsigned subtraction (32bit) */
diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
index 5432aeeed4..59da4d1cc2 100644
--- a/target/s390x/cc_helper.c
+++ b/target/s390x/cc_helper.c
@@ -123,6 +123,12 @@ static uint32_t cc_calc_nz(uint64_t dst)
     return !!dst;
 }
 
+static uint32_t cc_calc_addu(uint64_t carry_out, uint64_t result)
+{
+    g_assert(carry_out <= 1);
+    return (result != 0) + 2 * carry_out;
+}
+
 static uint32_t cc_calc_add_64(int64_t a1, int64_t a2, int64_t ar)
 {
     if ((a1 > 0 && a2 > 0 && ar < 0) || (a1 < 0 && a2 < 0 && ar > 0)) {
@@ -138,11 +144,6 @@ static uint32_t cc_calc_add_64(int64_t a1, int64_t a2, int64_t ar)
     }
 }
 
-static uint32_t cc_calc_addu_64(uint64_t a1, uint64_t a2, uint64_t ar)
-{
-    return (ar != 0) + 2 * (ar < a1);
-}
-
 static uint32_t cc_calc_addc_64(uint64_t a1, uint64_t a2, uint64_t ar)
 {
     /* Recover a2 + carry_in.  */
@@ -239,11 +240,6 @@ static uint32_t cc_calc_add_32(int32_t a1, int32_t a2, int32_t ar)
     }
 }
 
-static uint32_t cc_calc_addu_32(uint32_t a1, uint32_t a2, uint32_t ar)
-{
-    return (ar != 0) + 2 * (ar < a1);
-}
-
 static uint32_t cc_calc_addc_32(uint32_t a1, uint32_t a2, uint32_t ar)
 {
     /* Recover a2 + carry_in.  */
@@ -483,12 +479,12 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
     case CC_OP_NZ:
         r =  cc_calc_nz(dst);
         break;
+    case CC_OP_ADDU:
+        r = cc_calc_addu(src, dst);
+        break;
     case CC_OP_ADD_64:
         r =  cc_calc_add_64(src, dst, vr);
         break;
-    case CC_OP_ADDU_64:
-        r =  cc_calc_addu_64(src, dst, vr);
-        break;
     case CC_OP_ADDC_64:
         r =  cc_calc_addc_64(src, dst, vr);
         break;
@@ -517,9 +513,6 @@ static uint32_t do_calc_cc(CPUS390XState *env, uint32_t cc_op,
     case CC_OP_ADD_32:
         r =  cc_calc_add_32(src, dst, vr);
         break;
-    case CC_OP_ADDU_32:
-        r =  cc_calc_addu_32(src, dst, vr);
-        break;
     case CC_OP_ADDC_32:
         r =  cc_calc_addc_32(src, dst, vr);
         break;
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index b877690845..db87a62a57 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -395,6 +395,7 @@ const char *cc_name(enum cc_op cc_op)
         [CC_OP_DYNAMIC]   = "CC_OP_DYNAMIC",
         [CC_OP_STATIC]    = "CC_OP_STATIC",
         [CC_OP_NZ]        = "CC_OP_NZ",
+        [CC_OP_ADDU]      = "CC_OP_ADDU",
         [CC_OP_LTGT_32]   = "CC_OP_LTGT_32",
         [CC_OP_LTGT_64]   = "CC_OP_LTGT_64",
         [CC_OP_LTUGTU_32] = "CC_OP_LTUGTU_32",
@@ -402,7 +403,6 @@ const char *cc_name(enum cc_op cc_op)
         [CC_OP_LTGT0_32]  = "CC_OP_LTGT0_32",
         [CC_OP_LTGT0_64]  = "CC_OP_LTGT0_64",
         [CC_OP_ADD_64]    = "CC_OP_ADD_64",
-        [CC_OP_ADDU_64]   = "CC_OP_ADDU_64",
         [CC_OP_ADDC_64]   = "CC_OP_ADDC_64",
         [CC_OP_SUB_64]    = "CC_OP_SUB_64",
         [CC_OP_SUBU_64]   = "CC_OP_SUBU_64",
@@ -410,7 +410,6 @@ const char *cc_name(enum cc_op cc_op)
         [CC_OP_ABS_64]    = "CC_OP_ABS_64",
         [CC_OP_NABS_64]   = "CC_OP_NABS_64",
         [CC_OP_ADD_32]    = "CC_OP_ADD_32",
-        [CC_OP_ADDU_32]   = "CC_OP_ADDU_32",
         [CC_OP_ADDC_32]   = "CC_OP_ADDC_32",
         [CC_OP_SUB_32]    = "CC_OP_SUB_32",
         [CC_OP_SUBU_32]   = "CC_OP_SUBU_32",
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ac10f42f10..9bf4c14f66 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -600,13 +600,11 @@ static void gen_op_calc_cc(DisasContext *s)
         dummy = tcg_const_i64(0);
         /* FALLTHRU */
     case CC_OP_ADD_64:
-    case CC_OP_ADDU_64:
     case CC_OP_ADDC_64:
     case CC_OP_SUB_64:
     case CC_OP_SUBU_64:
     case CC_OP_SUBB_64:
     case CC_OP_ADD_32:
-    case CC_OP_ADDU_32:
     case CC_OP_ADDC_32:
     case CC_OP_SUB_32:
     case CC_OP_SUBU_32:
@@ -650,6 +648,7 @@ static void gen_op_calc_cc(DisasContext *s)
         /* 1 argument */
         gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, dummy, cc_dst, dummy);
         break;
+    case CC_OP_ADDU:
     case CC_OP_ICM:
     case CC_OP_LTGT_32:
     case CC_OP_LTGT_64:
@@ -666,13 +665,11 @@ static void gen_op_calc_cc(DisasContext *s)
         gen_helper_calc_cc(cc_op, cpu_env, local_cc_op, cc_src, cc_dst, dummy);
         break;
     case CC_OP_ADD_64:
-    case CC_OP_ADDU_64:
     case CC_OP_ADDC_64:
     case CC_OP_SUB_64:
     case CC_OP_SUBU_64:
     case CC_OP_SUBB_64:
     case CC_OP_ADD_32:
-    case CC_OP_ADDU_32:
     case CC_OP_ADDC_32:
     case CC_OP_SUB_32:
     case CC_OP_SUBU_32:
@@ -849,20 +846,19 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
         account_inline_branch(s, old_cc_op);
         break;
 
-    case CC_OP_ADDU_32:
-    case CC_OP_ADDU_64:
+    case CC_OP_ADDU:
         switch (mask) {
-        case 8 | 2: /* vr == 0 */
+        case 8 | 2: /* result == 0 */
             cond = TCG_COND_EQ;
             break;
-        case 4 | 1: /* vr != 0 */
+        case 4 | 1: /* result != 0 */
             cond = TCG_COND_NE;
             break;
-        case 8 | 4: /* no carry -> vr >= src */
-            cond = TCG_COND_GEU;
+        case 8 | 4: /* no carry */
+            cond = TCG_COND_EQ;
             break;
-        case 2 | 1: /* carry -> vr < src */
-            cond = TCG_COND_LTU;
+        case 2 | 1: /* carry */
+            cond = TCG_COND_NE;
             break;
         default:
             goto do_dynamic;
@@ -950,26 +946,21 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
         tcg_gen_and_i64(c->u.s64.a, cc_src, cc_dst);
         break;
 
-    case CC_OP_ADDU_32:
-        c->is_64 = false;
-        c->u.s32.a = tcg_temp_new_i32();
-        c->u.s32.b = tcg_temp_new_i32();
-        tcg_gen_extrl_i64_i32(c->u.s32.a, cc_vr);
-        if (cond == TCG_COND_EQ || cond == TCG_COND_NE) {
-            tcg_gen_movi_i32(c->u.s32.b, 0);
-        } else {
-            tcg_gen_extrl_i64_i32(c->u.s32.b, cc_src);
-        }
-        break;
-
-    case CC_OP_ADDU_64:
-        c->u.s64.a = cc_vr;
+    case CC_OP_ADDU:
+        c->is_64 = true;
+        c->u.s64.b = tcg_const_i64(0);
         c->g1 = true;
-        if (cond == TCG_COND_EQ || cond == TCG_COND_NE) {
-            c->u.s64.b = tcg_const_i64(0);
-        } else {
-            c->u.s64.b = cc_src;
-            c->g2 = true;
+        switch (mask) {
+        case 8 | 2:
+        case 4 | 1: /* result */
+            c->u.s64.a = cc_dst;
+            break;
+        case 8 | 4:
+        case 2 | 1: /* carry */
+            c->u.s64.a = cc_src;
+            break;
+        default:
+            g_assert_not_reached();
         }
         break;
 
@@ -1444,6 +1435,13 @@ static DisasJumpType op_add(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_addu64(DisasContext *s, DisasOps *o)
+{
+    tcg_gen_movi_i64(cc_src, 0);
+    tcg_gen_add2_i64(o->out, cc_src, o->in1, cc_src, o->in2, cc_src);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_addc(DisasContext *s, DisasOps *o)
 {
     DisasCompare cmp;
@@ -1473,9 +1471,10 @@ static DisasJumpType op_addc(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_asi(DisasContext *s, DisasOps *o)
 {
-    o->in1 = tcg_temp_new_i64();
+    bool non_atomic = !s390_has_feat(S390_FEAT_STFLE_45);
 
-    if (!s390_has_feat(S390_FEAT_STFLE_45)) {
+    o->in1 = tcg_temp_new_i64();
+    if (non_atomic) {
         tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
     } else {
         /* Perform the atomic addition in memory. */
@@ -1486,7 +1485,30 @@ static DisasJumpType op_asi(DisasContext *s, DisasOps *o)
     /* Recompute also for atomic case: needed for setting CC. */
     tcg_gen_add_i64(o->out, o->in1, o->in2);
 
-    if (!s390_has_feat(S390_FEAT_STFLE_45)) {
+    if (non_atomic) {
+        tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
+    }
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_asiu64(DisasContext *s, DisasOps *o)
+{
+    bool non_atomic = !s390_has_feat(S390_FEAT_STFLE_45);
+
+    o->in1 = tcg_temp_new_i64();
+    if (non_atomic) {
+        tcg_gen_qemu_ld_tl(o->in1, o->addr1, get_mem_index(s), s->insn->data);
+    } else {
+        /* Perform the atomic addition in memory. */
+        tcg_gen_atomic_fetch_add_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
+                                     s->insn->data);
+    }
+
+    /* Recompute also for atomic case: needed for setting CC. */
+    tcg_gen_movi_i64(cc_src, 0);
+    tcg_gen_add2_i64(o->out, cc_src, o->in1, cc_src, o->in2, cc_src);
+
+    if (non_atomic) {
         tcg_gen_qemu_st_tl(o->out, o->addr1, get_mem_index(s), s->insn->data);
     }
     return DISAS_NEXT;
@@ -5184,12 +5206,14 @@ static void cout_adds64(DisasContext *s, DisasOps *o)
 
 static void cout_addu32(DisasContext *s, DisasOps *o)
 {
-    gen_op_update3_cc_i64(s, CC_OP_ADDU_32, o->in1, o->in2, o->out);
+    tcg_gen_shri_i64(cc_src, o->out, 32);
+    tcg_gen_ext32u_i64(cc_dst, o->out);
+    gen_op_update2_cc_i64(s, CC_OP_ADDU, cc_src, cc_dst);
 }
 
 static void cout_addu64(DisasContext *s, DisasOps *o)
 {
-    gen_op_update3_cc_i64(s, CC_OP_ADDU_64, o->in1, o->in2, o->out);
+    gen_op_update2_cc_i64(s, CC_OP_ADDU, cc_src, o->out);
 }
 
 static void cout_addc32(DisasContext *s, DisasOps *o)
@@ -5636,6 +5660,13 @@ static void in1_r2_sr32(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in1_r2_sr32 0
 
+static void in1_r2_32u(DisasContext *s, DisasOps *o)
+{
+    o->in1 = tcg_temp_new_i64();
+    tcg_gen_ext32u_i64(o->in1, regs[get_field(s, r2)]);
+}
+#define SPEC_in1_r2_32u 0
+
 static void in1_r3(DisasContext *s, DisasOps *o)
 {
     o->in1 = load_reg(get_field(s, r3));
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d3bcdfd67b..b9ca9aeff5 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -58,29 +58,29 @@
     C(0xa70b, AGHI,    RI_a,  Z,   r1, i2, r1, 0, add, adds64)
 
 /* ADD LOGICAL */
-    C(0x1e00, ALR,     RR_a,  Z,   r1, r2, new, r1_32, add, addu32)
-    C(0xb9fa, ALRK,    RRF_a, DO,  r2, r3, new, r1_32, add, addu32)
-    C(0x5e00, AL,      RX_a,  Z,   r1, m2_32u, new, r1_32, add, addu32)
-    C(0xe35e, ALY,     RXY_a, LD,  r1, m2_32u, new, r1_32, add, addu32)
-    C(0xb90a, ALGR,    RRE,   Z,   r1, r2, r1, 0, add, addu64)
-    C(0xb91a, ALGFR,   RRE,   Z,   r1, r2_32u, r1, 0, add, addu64)
-    C(0xb9ea, ALGRK,   RRF_a, DO,  r2, r3, r1, 0, add, addu64)
-    C(0xe30a, ALG,     RXY_a, Z,   r1, m2_64, r1, 0, add, addu64)
-    C(0xe31a, ALGF,    RXY_a, Z,   r1, m2_32u, r1, 0, add, addu64)
+    C(0x1e00, ALR,     RR_a,  Z,   r1_32u, r2_32u, new, r1_32, add, addu32)
+    C(0xb9fa, ALRK,    RRF_a, DO,  r2_32u, r3_32u, new, r1_32, add, addu32)
+    C(0x5e00, AL,      RX_a,  Z,   r1_32u, m2_32u, new, r1_32, add, addu32)
+    C(0xe35e, ALY,     RXY_a, LD,  r1_32u, m2_32u, new, r1_32, add, addu32)
+    C(0xb90a, ALGR,    RRE,   Z,   r1, r2, r1, 0, addu64, addu64)
+    C(0xb91a, ALGFR,   RRE,   Z,   r1, r2_32u, r1, 0, addu64, addu64)
+    C(0xb9ea, ALGRK,   RRF_a, DO,  r2, r3, r1, 0, addu64, addu64)
+    C(0xe30a, ALG,     RXY_a, Z,   r1, m2_64, r1, 0, addu64, addu64)
+    C(0xe31a, ALGF,    RXY_a, Z,   r1, m2_32u, r1, 0, addu64, addu64)
 /* ADD LOGICAL HIGH */
     C(0xb9ca, ALHHHR,  RRF_a, HW,  r2_sr32, r3_sr32, new, r1_32h, add, addu32)
-    C(0xb9da, ALHHLR,  RRF_a, HW,  r2_sr32, r3, new, r1_32h, add, addu32)
+    C(0xb9da, ALHHLR,  RRF_a, HW,  r2_sr32, r3_32u, new, r1_32h, add, addu32)
 /* ADD LOGICAL IMMEDIATE */
-    C(0xc20b, ALFI,    RIL_a, EI,  r1, i2_32u, new, r1_32, add, addu32)
-    C(0xc20a, ALGFI,   RIL_a, EI,  r1, i2_32u, r1, 0, add, addu64)
+    C(0xc20b, ALFI,    RIL_a, EI,  r1_32u, i2_32u, new, r1_32, add, addu32)
+    C(0xc20a, ALGFI,   RIL_a, EI,  r1, i2_32u, r1, 0, addu64, addu64)
 /* ADD LOGICAL WITH SIGNED IMMEDIATE */
-    D(0xeb6e, ALSI,    SIY,   GIE, la1, i2, new, 0, asi, addu32, MO_TEUL)
-    C(0xecda, ALHSIK,  RIE_d, DO,  r3, i2, new, r1_32, add, addu32)
-    D(0xeb7e, ALGSI,   SIY,   GIE, la1, i2, new, 0, asi, addu64, MO_TEQ)
-    C(0xecdb, ALGHSIK, RIE_d, DO,  r3, i2, r1, 0, add, addu64)
+    D(0xeb6e, ALSI,    SIY,   GIE, la1, i2_32u, new, 0, asi, addu32, MO_TEUL)
+    C(0xecda, ALHSIK,  RIE_d, DO,  r3_32u, i2_32u, new, r1_32, add, addu32)
+    C(0xeb7e, ALGSI,   SIY,   GIE, la1, i2, r1, 0, asiu64, addu64)
+    C(0xecdb, ALGHSIK, RIE_d, DO,  r3, i2, r1, 0, addu64, addu64)
 /* ADD LOGICAL WITH SIGNED IMMEDIATE HIGH */
-    C(0xcc0a, ALSIH,   RIL_a, HW,  r1_sr32, i2, new, r1_32h, add, addu32)
-    C(0xcc0b, ALSIHN,  RIL_a, HW,  r1_sr32, i2, new, r1_32h, add, 0)
+    C(0xcc0a, ALSIH,   RIL_a, HW,  r1_sr32, i2_32u, new, r1_32h, add, addu32)
+    C(0xcc0b, ALSIHN,  RIL_a, HW,  r1_sr32, i2_32u, new, r1_32h, add, 0)
 /* ADD LOGICAL WITH CARRY */
     C(0xb998, ALCR,    RRE,   Z,   r1, r2, new, r1_32, addc, addc32)
     C(0xb988, ALCGR,   RRE,   Z,   r1, r2, r1, 0, addc, addc64)
-- 
2.25.1


