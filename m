Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6C3C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA36218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyROPe9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA36218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSF4-0006r2-6V
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXSBv-0003JJ-Sv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:51:24 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:34708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXSBs-0004RV-NW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:51:23 -0400
Received: by mail-pj1-x1036.google.com with SMTP id i3so194175pju.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FtSerDr+mVNWKALcskLCjbwxaDT2P8IL1JFsGYyWdws=;
 b=kyROPe9FrbRXhBLLMpI0OcoItkuaDwFzyLJCunkky+D2rRFglVf2JpsKOOoSHL5uiL
 Zv+li1bvOlO8Hnd/5zu0PBCRbKRN8q2VXlCtaBrG5eGGmuLlADusSwLyxg8BOtTk9zJP
 HuLjAWj4cSrXpQXoT9Ejt+MASANwS7FpJ1sjBh/4uefFfZr4BlcAM2N7FjZMjcdrof73
 x3z8Nbe2S508ruXrHQvxZlX8gc6lzQ8PlMn6PdKQXmT1ogt7EVzgKu4Ieygu8qf9NNht
 8FaviIjYJ2m3UqoN/P1+yMfr+sRZZwEuvm4lmmpOxiPenUCv3mA1L3zOgE5iSDs7Hlfq
 KEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FtSerDr+mVNWKALcskLCjbwxaDT2P8IL1JFsGYyWdws=;
 b=s99VYhyPaQHqiLLSohM/tMvdEUrPkRSmIg0xywY3/tlYEYnEvmYPLdoH4L9yLytAt3
 mp7/Ojw9TpuiOWSniZNqYkIdklS1dJqU+0JH+TuWfToDnoZGNnOx0hTuBQ4Ty1z2jTHB
 v2FQnxfCJyySYIvk3/KYxpIxNFxQa7AEUsrYu+7DXlsL59T1pdh4/BhQvCdejWCsPQ9Q
 fXeNmemuJPk3eDCyec9+YyZputnRO2Z+jUzU1TFoDj9hOYz8UZhxaTm29d6aoGD1DV39
 cTNU0MEkcVb5kXgiSYsoy8TQQwVpj2hk6lU7CntcFIdC0dXPNob6A0aLOLmjOwvUdrpk
 qPQg==
X-Gm-Message-State: AOAM533Tbe8dQ0HckjSe1nCuGbz9XqHmkK3AjvTWsSI0CaxdINHvDkeD
 Dg3CRzY4/Ic6AC3rO28c1S+fX0d815Qc8w==
X-Google-Smtp-Source: ABdhPJx92/586tQyLeBYKM1/7kgi4UT7uV5ewRtBTkCldqS6aE23SzDix+8muyD6etNT7enKyhaG3w==
X-Received: by 2002:a17:902:a503:b029:d6:d9d:f901 with SMTP id
 s3-20020a170902a503b02900d60d9df901mr3591781plq.54.1603817478598; 
 Tue, 27 Oct 2020 09:51:18 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q16sm2955283pfj.117.2020.10.27.09.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 09:51:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] tcg: Do not kill globals at conditional branches
Date: Tue, 27 Oct 2020 09:51:12 -0700
Message-Id: <20201027165114.71508-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027165114.71508-1-richard.henderson@linaro.org>
References: <20201027165114.71508-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can easily register allocate the entire extended basic block
(in this case, the set of blocks connected by fallthru), simply
by not discarding the register state at the branch.

This does not help blocks starting with a label, as they are
reached via a taken branch, and that would require saving the
complete register state at the branch.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h |  7 +++---
 include/tcg/tcg.h     |  4 +++-
 tcg/tcg.c             | 55 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index e3929b80d2..67092e82c6 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -81,7 +81,7 @@ DEF(extract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_extract_i32))
 DEF(sextract_i32, 1, 1, 2, IMPL(TCG_TARGET_HAS_sextract_i32))
 DEF(extract2_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_extract2_i32))
 
-DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END)
+DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 
 DEF(add2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_add2_i32))
 DEF(sub2_i32, 2, 4, 0, IMPL(TCG_TARGET_HAS_sub2_i32))
@@ -89,7 +89,8 @@ DEF(mulu2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_mulu2_i32))
 DEF(muls2_i32, 2, 2, 0, IMPL(TCG_TARGET_HAS_muls2_i32))
 DEF(muluh_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_muluh_i32))
 DEF(mulsh_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_mulsh_i32))
-DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | IMPL(TCG_TARGET_REG_BITS == 32))
+DEF(brcond2_i32, 0, 4, 2,
+    TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | IMPL(TCG_TARGET_REG_BITS == 32))
 DEF(setcond2_i32, 1, 4, 1, IMPL(TCG_TARGET_REG_BITS == 32))
 
 DEF(ext8s_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext8s_i32))
@@ -159,7 +160,7 @@ DEF(extrh_i64_i32, 1, 1, 0,
     IMPL(TCG_TARGET_HAS_extrh_i64_i32)
     | (TCG_TARGET_REG_BITS == 32 ? TCG_OPF_NOT_PRESENT : 0))
 
-DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | IMPL64)
+DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | IMPL64)
 DEF(ext8s_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext8s_i64))
 DEF(ext16s_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext16s_i64))
 DEF(ext32s_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_ext32s_i64))
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 8804a8c4a2..8ff9dad4ef 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -990,7 +990,7 @@ typedef struct TCGArgConstraint {
 
 #define TCG_MAX_OP_ARGS 16
 
-/* Bits for TCGOpDef->flags, 8 bits available.  */
+/* Bits for TCGOpDef->flags, 8 bits available, all used.  */
 enum {
     /* Instruction exits the translation block.  */
     TCG_OPF_BB_EXIT      = 0x01,
@@ -1008,6 +1008,8 @@ enum {
     TCG_OPF_NOT_PRESENT  = 0x20,
     /* Instruction operands are vectors.  */
     TCG_OPF_VECTOR       = 0x40,
+    /* Instruction is a conditional branch. */
+    TCG_OPF_COND_BRANCH  = 0x80
 };
 
 typedef struct TCGOpDef {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a8c28440e2..f49f1a7f35 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2519,6 +2519,28 @@ static void la_global_sync(TCGContext *s, int ng)
     }
 }
 
+/*
+ * liveness analysis: conditional branch: all temps are dead,
+ * globals and local temps should be synced.
+ */
+static void la_bb_sync(TCGContext *s, int ng, int nt)
+{
+    la_global_sync(s, ng);
+
+    for (int i = ng; i < nt; ++i) {
+        if (s->temps[i].temp_local) {
+            int state = s->temps[i].state;
+            s->temps[i].state = state | TS_MEM;
+            if (state != TS_DEAD) {
+                continue;
+            }
+        } else {
+            s->temps[i].state = TS_DEAD;
+        }
+        la_reset_pref(&s->temps[i]);
+    }
+}
+
 /* liveness analysis: sync globals back to memory and kill.  */
 static void la_global_kill(TCGContext *s, int ng)
 {
@@ -2795,6 +2817,8 @@ static void liveness_pass_1(TCGContext *s)
             /* If end of basic block, update.  */
             if (def->flags & TCG_OPF_BB_EXIT) {
                 la_func_end(s, nb_globals, nb_temps);
+            } else if (def->flags & TCG_OPF_COND_BRANCH) {
+                la_bb_sync(s, nb_globals, nb_temps);
             } else if (def->flags & TCG_OPF_BB_END) {
                 la_bb_end(s, nb_globals, nb_temps);
             } else if (def->flags & TCG_OPF_SIDE_EFFECTS) {
@@ -2907,7 +2931,10 @@ static bool liveness_pass_2(TCGContext *s)
             nb_oargs = def->nb_oargs;
 
             /* Set flags similar to how calls require.  */
-            if (def->flags & TCG_OPF_BB_END) {
+            if (def->flags & TCG_OPF_COND_BRANCH) {
+                /* Like reading globals: sync_globals */
+                call_flags = TCG_CALL_NO_WRITE_GLOBALS;
+            } else if (def->flags & TCG_OPF_BB_END) {
                 /* Like writing globals: save_globals */
                 call_flags = 0;
             } else if (def->flags & TCG_OPF_SIDE_EFFECTS) {
@@ -3379,6 +3406,28 @@ static void tcg_reg_alloc_bb_end(TCGContext *s, TCGRegSet allocated_regs)
     save_globals(s, allocated_regs);
 }
 
+/*
+ * At a conditional branch, we assume all temporaries are dead and
+ * all globals and local temps are synced to their location.
+ */
+static void tcg_reg_alloc_cbranch(TCGContext *s, TCGRegSet allocated_regs)
+{
+    sync_globals(s, allocated_regs);
+
+    for (int i = s->nb_globals; i < s->nb_temps; i++) {
+        TCGTemp *ts = &s->temps[i];
+        /*
+         * The liveness analysis already ensures that temps are dead.
+         * Keep tcg_debug_asserts for safety.
+         */
+        if (ts->temp_local) {
+            tcg_debug_assert(ts->val_type != TEMP_VAL_REG || ts->mem_coherent);
+        } else {
+            tcg_debug_assert(ts->val_type == TEMP_VAL_DEAD);
+        }
+    }
+}
+
 /*
  * Specialized code generation for INDEX_op_movi_*.
  */
@@ -3730,7 +3779,9 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
     }
 
-    if (def->flags & TCG_OPF_BB_END) {
+    if (def->flags & TCG_OPF_COND_BRANCH) {
+        tcg_reg_alloc_cbranch(s, i_allocated_regs);
+    } else if (def->flags & TCG_OPF_BB_END) {
         tcg_reg_alloc_bb_end(s, i_allocated_regs);
     } else {
         if (def->flags & TCG_OPF_CALL_CLOBBER) {
-- 
2.25.1


