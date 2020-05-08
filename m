Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55547C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FEE2192A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8N6GidX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FEE2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7qi-0004b2-8G
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7ho-0006xR-4p
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:40 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hl-0006ys-8y
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:39 -0400
Received: by mail-pg1-x542.google.com with SMTP id a4so1247707pgc.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g5L9isOBYf4t1bYKYYa8jot/bpntevMJTimjPXglsCc=;
 b=z8N6GidXnDv4va+/x5sOC2f7/fT8uShaVhsQ8/yrbXO2btauZ0TyKYmY7uBOeTv9Iy
 teX3dYCe0B+f8gZ+E5gp7ABYTnJBhaCKQDnfbIxtPHAKV4QVEYAVYfdj5zrrTn37Xun+
 AnLsO+3xh14v2jVKK1I4cCJJprXqu3mLoz2ZdSUMOr3W+5PVYY1Pe09eYHiiIMTgGzAy
 Uxw5y/VdP3w9R8yycB6uvwaoOMiCbbDOPZFo1h1puOw8OkHMiN+b1k/Hnw0Y1q2sXGn1
 q0VX24+bB+HOwBuJPwoCYvpc2ym8eqy/VBv3WLOxgE+W5IMic3tJZ/KTIBEK7cZyBxEH
 6z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g5L9isOBYf4t1bYKYYa8jot/bpntevMJTimjPXglsCc=;
 b=WH10xLclPpmCh3fAhs1xqIXmznTupM+9IGL+De2u7mBizvSVGoPp1oYF6uhl/2n806
 8FSzwAEne76Ds1PHIJ5WfNFOnjeocbAIrkhQI+vB9jJQGboF392r1HCAc3tFeHc1H1Kv
 BunPRXYwEGSyjdd/9jgOoQx1Zzj9m6bxyXE/TQVkw4jPH8ohanNWCzFYdLOse9wVY9e+
 vTjSu1zgmo50R3rolsHhFsnuTIXcdQYR4sNB1evqHsm/bg/3CmVz8nS5I6RPYH/8107I
 E9nhTZAHGj2rrfwVy+B0n0KJoklNF6Mnit2SRAEDw0H3CG1LrODjrvNoYJH139UXN0Ak
 0Z9w==
X-Gm-Message-State: AGi0PuZcVSOi767Ge4CvGqqNHC+gsMlVFoGlidKo1qPVus6MkhAOgUif
 k9f3Xtbb3WjvAXwMzXxycZ977vOw3+A=
X-Google-Smtp-Source: APiQypIL+d62EifAyJt4sZYPFoWFt/aYBHSb5PZkVHvfez3+mT/pyMudemTZhZYIRkxhWVMe9kKsCA==
X-Received: by 2002:a62:4ec8:: with SMTP id c191mr4372377pfb.30.1588962394566; 
 Fri, 08 May 2020 11:26:34 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/19] tcg/optimize: Use tcg_constant_internal with
 constant folding
Date: Fri,  8 May 2020 11:26:09 -0700
Message-Id: <20200508182616.18318-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508182616.18318-1-richard.henderson@linaro.org>
References: <20200508182616.18318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 106 ++++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 58 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d36d7e1d7f..dd5187be31 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -178,37 +178,6 @@ static bool args_are_copies(TCGArg arg1, TCGArg arg2)
     return ts_are_copies(arg_temp(arg1), arg_temp(arg2));
 }
 
-static void tcg_opt_gen_movi(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg val)
-{
-    const TCGOpDef *def;
-    TCGOpcode new_op;
-    tcg_target_ulong mask;
-    TempOptInfo *di = arg_info(dst);
-
-    def = &tcg_op_defs[op->opc];
-    if (def->flags & TCG_OPF_VECTOR) {
-        new_op = INDEX_op_dupi_vec;
-    } else if (def->flags & TCG_OPF_64BIT) {
-        new_op = INDEX_op_movi_i64;
-    } else {
-        new_op = INDEX_op_movi_i32;
-    }
-    op->opc = new_op;
-    /* TCGOP_VECL and TCGOP_VECE remain unchanged.  */
-    op->args[0] = dst;
-    op->args[1] = val;
-
-    reset_temp(dst);
-    di->is_const = true;
-    di->val = val;
-    mask = val;
-    if (TCG_TARGET_REG_BITS > 32 && new_op == INDEX_op_movi_i32) {
-        /* High bits of the destination are now garbage.  */
-        mask |= ~0xffffffffull;
-    }
-    di->mask = mask;
-}
-
 static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
 {
     TCGTemp *dst_ts = arg_temp(dst);
@@ -259,6 +228,27 @@ static void tcg_opt_gen_mov(TCGContext *s, TCGOp *op, TCGArg dst, TCGArg src)
     }
 }
 
+static void tcg_opt_gen_movi(TCGContext *s, TCGTempSet *temps_used,
+                             TCGOp *op, TCGArg dst, TCGArg val)
+{
+    const TCGOpDef *def = &tcg_op_defs[op->opc];
+    TCGType type;
+    TCGTemp *tv;
+
+    if (def->flags & TCG_OPF_VECTOR) {
+        type = TCGOP_VECL(op) + TCG_TYPE_V64;
+    } else if (def->flags & TCG_OPF_64BIT) {
+        type = TCG_TYPE_I64;
+    } else {
+        type = TCG_TYPE_I32;
+    }
+
+    /* Convert movi to mov with constant temp. */
+    tv = tcg_constant_internal(type, val);
+    init_ts_info(temps_used, tv);
+    tcg_opt_gen_mov(s, op, dst, temp_arg(tv));
+}
+
 static TCGArg do_constant_folding_2(TCGOpcode op, TCGArg x, TCGArg y)
 {
     uint64_t l64, h64;
@@ -621,7 +611,7 @@ void tcg_optimize(TCGContext *s)
     nb_temps = s->nb_temps;
     nb_globals = s->nb_globals;
 
-    bitmap_zero(temps_used.l, nb_temps);
+    memset(&temps_used, 0, sizeof(temps_used));
     for (i = 0; i < nb_temps; ++i) {
         s->temps[i].state_ptr = NULL;
     }
@@ -727,7 +717,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(rotr):
             if (arg_is_const(op->args[1])
                 && arg_info(op->args[1])->val == 0) {
-                tcg_opt_gen_movi(s, op, op->args[0], 0);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], 0);
                 continue;
             }
             break;
@@ -1050,7 +1040,7 @@ void tcg_optimize(TCGContext *s)
 
         if (partmask == 0) {
             tcg_debug_assert(nb_oargs == 1);
-            tcg_opt_gen_movi(s, op, op->args[0], 0);
+            tcg_opt_gen_movi(s, &temps_used, op, op->args[0], 0);
             continue;
         }
         if (affected == 0) {
@@ -1067,7 +1057,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(mulsh):
             if (arg_is_const(op->args[2])
                 && arg_info(op->args[2])->val == 0) {
-                tcg_opt_gen_movi(s, op, op->args[0], 0);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], 0);
                 continue;
             }
             break;
@@ -1094,7 +1084,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64_VEC(sub):
         CASE_OP_32_64_VEC(xor):
             if (args_are_copies(op->args[1], op->args[2])) {
-                tcg_opt_gen_movi(s, op, op->args[0], 0);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], 0);
                 continue;
             }
             break;
@@ -1111,14 +1101,14 @@ void tcg_optimize(TCGContext *s)
             break;
         CASE_OP_32_64(movi):
         case INDEX_op_dupi_vec:
-            tcg_opt_gen_movi(s, op, op->args[0], op->args[1]);
+            tcg_opt_gen_movi(s, &temps_used, op, op->args[0], op->args[1]);
             break;
 
         case INDEX_op_dup_vec:
             if (arg_is_const(op->args[1])) {
                 tmp = arg_info(op->args[1])->val;
                 tmp = dup_const(TCGOP_VECE(op), tmp);
-                tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
@@ -1141,7 +1131,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_extrh_i64_i32:
             if (arg_is_const(op->args[1])) {
                 tmp = do_constant_folding(opc, arg_info(op->args[1])->val, 0);
-                tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
@@ -1171,7 +1161,7 @@ void tcg_optimize(TCGContext *s)
             if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
                 tmp = do_constant_folding(opc, arg_info(op->args[1])->val,
                                           arg_info(op->args[2])->val);
-                tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
@@ -1182,7 +1172,7 @@ void tcg_optimize(TCGContext *s)
                 TCGArg v = arg_info(op->args[1])->val;
                 if (v != 0) {
                     tmp = do_constant_folding(opc, v, 0);
-                    tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                    tcg_opt_gen_movi(s, &temps_used, op, op->args[0], tmp);
                 } else {
                     tcg_opt_gen_mov(s, op, op->args[0], op->args[2]);
                 }
@@ -1195,7 +1185,7 @@ void tcg_optimize(TCGContext *s)
                 tmp = deposit64(arg_info(op->args[1])->val,
                                 op->args[3], op->args[4],
                                 arg_info(op->args[2])->val);
-                tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
@@ -1204,7 +1194,7 @@ void tcg_optimize(TCGContext *s)
             if (arg_is_const(op->args[1])) {
                 tmp = extract64(arg_info(op->args[1])->val,
                                 op->args[2], op->args[3]);
-                tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
@@ -1213,7 +1203,7 @@ void tcg_optimize(TCGContext *s)
             if (arg_is_const(op->args[1])) {
                 tmp = sextract64(arg_info(op->args[1])->val,
                                  op->args[2], op->args[3]);
-                tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
@@ -1229,7 +1219,7 @@ void tcg_optimize(TCGContext *s)
                     tmp = (int32_t)(((uint32_t)v1 >> op->args[3]) |
                                     ((uint32_t)v2 << (32 - op->args[3])));
                 }
-                tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
@@ -1238,7 +1228,7 @@ void tcg_optimize(TCGContext *s)
             tmp = do_constant_folding_cond(opc, op->args[1],
                                            op->args[2], op->args[3]);
             if (tmp != 2) {
-                tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], tmp);
                 break;
             }
             goto do_default;
@@ -1248,7 +1238,7 @@ void tcg_optimize(TCGContext *s)
                                            op->args[1], op->args[2]);
             if (tmp != 2) {
                 if (tmp) {
-                    bitmap_zero(temps_used.l, nb_temps);
+                    memset(&temps_used, 0, sizeof(temps_used));
                     op->opc = INDEX_op_br;
                     op->args[0] = op->args[3];
                 } else {
@@ -1293,7 +1283,7 @@ void tcg_optimize(TCGContext *s)
                 uint64_t a = ((uint64_t)ah << 32) | al;
                 uint64_t b = ((uint64_t)bh << 32) | bl;
                 TCGArg rl, rh;
-                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32);
+                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_mov_i32);
 
                 if (opc == INDEX_op_add2_i32) {
                     a += b;
@@ -1303,8 +1293,8 @@ void tcg_optimize(TCGContext *s)
 
                 rl = op->args[0];
                 rh = op->args[1];
-                tcg_opt_gen_movi(s, op, rl, (int32_t)a);
-                tcg_opt_gen_movi(s, op2, rh, (int32_t)(a >> 32));
+                tcg_opt_gen_movi(s, &temps_used, op, rl, (int32_t)a);
+                tcg_opt_gen_movi(s, &temps_used, op2, rh, (int32_t)(a >> 32));
                 break;
             }
             goto do_default;
@@ -1315,12 +1305,12 @@ void tcg_optimize(TCGContext *s)
                 uint32_t b = arg_info(op->args[3])->val;
                 uint64_t r = (uint64_t)a * b;
                 TCGArg rl, rh;
-                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_movi_i32);
+                TCGOp *op2 = tcg_op_insert_before(s, op, INDEX_op_mov_i32);
 
                 rl = op->args[0];
                 rh = op->args[1];
-                tcg_opt_gen_movi(s, op, rl, (int32_t)r);
-                tcg_opt_gen_movi(s, op2, rh, (int32_t)(r >> 32));
+                tcg_opt_gen_movi(s, &temps_used, op, rl, (int32_t)r);
+                tcg_opt_gen_movi(s, &temps_used, op2, rh, (int32_t)(r >> 32));
                 break;
             }
             goto do_default;
@@ -1331,7 +1321,7 @@ void tcg_optimize(TCGContext *s)
             if (tmp != 2) {
                 if (tmp) {
             do_brcond_true:
-                    bitmap_zero(temps_used.l, nb_temps);
+                    memset(&temps_used, 0, sizeof(temps_used));
                     op->opc = INDEX_op_br;
                     op->args[0] = op->args[5];
                 } else {
@@ -1347,7 +1337,7 @@ void tcg_optimize(TCGContext *s)
                 /* Simplify LT/GE comparisons vs zero to a single compare
                    vs the high word of the input.  */
             do_brcond_high:
-                bitmap_zero(temps_used.l, nb_temps);
+                memset(&temps_used, 0, sizeof(temps_used));
                 op->opc = INDEX_op_brcond_i32;
                 op->args[0] = op->args[1];
                 op->args[1] = op->args[3];
@@ -1373,7 +1363,7 @@ void tcg_optimize(TCGContext *s)
                     goto do_default;
                 }
             do_brcond_low:
-                bitmap_zero(temps_used.l, nb_temps);
+                memset(&temps_used, 0, sizeof(temps_used));
                 op->opc = INDEX_op_brcond_i32;
                 op->args[1] = op->args[2];
                 op->args[2] = op->args[4];
@@ -1408,7 +1398,7 @@ void tcg_optimize(TCGContext *s)
                                             op->args[5]);
             if (tmp != 2) {
             do_setcond_const:
-                tcg_opt_gen_movi(s, op, op->args[0], tmp);
+                tcg_opt_gen_movi(s, &temps_used, op, op->args[0], tmp);
             } else if ((op->args[5] == TCG_COND_LT
                         || op->args[5] == TCG_COND_GE)
                        && arg_is_const(op->args[3])
@@ -1493,7 +1483,7 @@ void tcg_optimize(TCGContext *s)
                block, otherwise we only trash the output args.  "mask" is
                the non-zero bits mask for the first output arg.  */
             if (def->flags & TCG_OPF_BB_END) {
-                bitmap_zero(temps_used.l, nb_temps);
+                memset(&temps_used, 0, sizeof(temps_used));
             } else {
         do_reset_output:
                 for (i = 0; i < nb_oargs; i++) {
-- 
2.20.1


