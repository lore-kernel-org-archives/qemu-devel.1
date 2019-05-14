Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADD9C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D2620862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJgj0Cp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D2620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36685 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQL5z-0000ei-IV
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:15:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxx-0001cp-9n
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxJ-0003JG-Dq
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:43 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:44629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxH-0003A8-1d
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:05 -0400
Received: by mail-pf1-x430.google.com with SMTP id g9so8049069pfo.11
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=0NdT1vVANH/LILN+5zIlMLc6x66kLizQd46/eOmSl1E=;
	b=qJgj0Cp/yzh1EqAXRHprOCB4uWc3vLts5t1IFUt7gi0k8AnJidw/0gU89SbIl6ixa1
	l/RTl2bNsAou5h5pNH8ro0moWW3G2ngLMtfiyRC++Z+DnViC1v9T+G/M96pQwrVMf4es
	TQLmGfn9caejrtn5U1kqAPq81dhpVodASx5URG0cO9TyUY00eeNLZ2U4hPls9FdIIMAO
	M9Z7C2chVQaoEO4r9kygRO1sb4xikbt8qkDM7ssoHatwbcUpo2NGGJwlPF9dyAr/21IP
	JGa9Ut8G7ZncPFw0xRV9MjbXHPALEFaMzI7eUeQ8OnPNQyHbX/nlxAiqE5gDe0MKOV/o
	HobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=0NdT1vVANH/LILN+5zIlMLc6x66kLizQd46/eOmSl1E=;
	b=qaDM5ZMemh/bTAR/1iGZ4+EYo3l/ovuOf49nE0QbEO/gaEfIi/aNfLdDwTqzbFzDBL
	UqpE7PowX9zMbDZWFb+YKJ431PtgvlWJIEjFz1MCVrZxRN4vmHkIS7yOOjxo0cTlngIG
	tGNTrUWwgxhqh3yL6fziEz6Htw1oPsjvfE2M8D+frhosmszBAoJ4DOS2zyFtfMFE7OMB
	oFz1IEFsHvw2MhVrnAzIDdbvlrus2uCz+GJ9IQ/UvEnV7qMjvevJznlqgCXjHBkB6iRI
	rZiHuPhBrfMWY4rNs2VYJV+5gQYpUj/YoOgCADJWjUWi7fDezd8nj+hlLnJHWW2cqDDI
	+Mzw==
X-Gm-Message-State: APjAAAWEbEUREM7QMuqpmWOdV4IUX7bUxkbZSFC/q9gvNn6wPLYAR+ZM
	r8KRAlN2w5Lu5fA1mwigWKfviRiBLI4=
X-Google-Smtp-Source: APXvYqz8YcwGwgea4PgaCT1l3TTBgJoYUG8dA9tR2KdXU/dpbEyNJno7yWw7fPxaM2SV95oJIaJBlg==
X-Received: by 2002:a63:1d09:: with SMTP id d9mr34888764pgd.289.1557792356771; 
	Mon, 13 May 2019 17:05:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.05.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:05:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:19 -0700
Message-Id: <20190514000540.4313-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::430
Subject: [Qemu-devel] [PULL 10/31] tcg: Manually expand INDEX_op_dup_vec
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This case is similar to INDEX_op_mov_* in that we need to do
different things depending on the current location of the source.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Added some commentary to the tcg_reg_alloc_* functions.
---
 tcg/aarch64/tcg-target.inc.c |   9 ++-
 tcg/i386/tcg-target.inc.c    |   8 +--
 tcg/tcg.c                    | 111 +++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 10 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index e443b5df23..3cefdd1e43 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2108,10 +2108,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_mov_vec:
     case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_movi_i64:
-    case INDEX_op_dupi_vec:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         g_assert_not_reached();
@@ -2208,9 +2206,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_not_vec:
         tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a1);
         break;
-    case INDEX_op_dup_vec:
-        tcg_out_dup_vec(s, type, vece, a0, a1);
-        break;
     case INDEX_op_shli_vec:
         tcg_out_insn(s, 3614, SHL, is_q, a0, a1, a2 + (8 << vece));
         break;
@@ -2254,6 +2249,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
             }
         }
         break;
+
+    case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
+    case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 0d621670c7..3c8229d413 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2603,10 +2603,8 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
-    case INDEX_op_mov_vec:
     case INDEX_op_movi_i32: /* Always emitted via tcg_out_movi.  */
     case INDEX_op_movi_i64:
-    case INDEX_op_dupi_vec:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     default:
         tcg_abort();
@@ -2795,9 +2793,6 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_st_vec:
         tcg_out_st(s, type, a0, a1, a2);
         break;
-    case INDEX_op_dup_vec:
-        tcg_out_dup_vec(s, type, vece, a0, a1);
-        break;
 
     case INDEX_op_x86_shufps_vec:
         insn = OPC_SHUFPS;
@@ -2839,6 +2834,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out8(s, a2);
         break;
 
+    case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_dupi_vec: /* Always emitted via tcg_out_movi.  */
+    case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3ef4d3478d..2b715bf099 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3284,6 +3284,9 @@ static void tcg_reg_alloc_bb_end(TCGContext *s, TCGRegSet allocated_regs)
     save_globals(s, allocated_regs);
 }
 
+/*
+ * Specialized code generation for INDEX_op_movi_*.
+ */
 static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
                                   tcg_target_ulong val, TCGLifeData arg_life,
                                   TCGRegSet preferred_regs)
@@ -3313,6 +3316,9 @@ static void tcg_reg_alloc_movi(TCGContext *s, const TCGOp *op)
     tcg_reg_alloc_do_movi(s, ots, val, op->life, op->output_pref[0]);
 }
 
+/*
+ * Specialized code generation for INDEX_op_mov_*.
+ */
 static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
 {
     const TCGLifeData arg_life = op->life;
@@ -3407,6 +3413,108 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     }
 }
 
+/*
+ * Specialized code generation for INDEX_op_dup_vec.
+ */
+static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
+{
+    const TCGLifeData arg_life = op->life;
+    TCGRegSet dup_out_regs, dup_in_regs;
+    TCGTemp *its, *ots;
+    TCGType itype, vtype;
+    unsigned vece;
+    bool ok;
+
+    ots = arg_temp(op->args[0]);
+    its = arg_temp(op->args[1]);
+
+    /* ENV should not be modified.  */
+    tcg_debug_assert(!ots->fixed_reg);
+
+    itype = its->type;
+    vece = TCGOP_VECE(op);
+    vtype = TCGOP_VECL(op) + TCG_TYPE_V64;
+
+    if (its->val_type == TEMP_VAL_CONST) {
+        /* Propagate constant via movi -> dupi.  */
+        tcg_target_ulong val = its->val;
+        if (IS_DEAD_ARG(1)) {
+            temp_dead(s, its);
+        }
+        tcg_reg_alloc_do_movi(s, ots, val, arg_life, op->output_pref[0]);
+        return;
+    }
+
+    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].u.regs;
+    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].u.regs;
+
+    /* Allocate the output register now.  */
+    if (ots->val_type != TEMP_VAL_REG) {
+        TCGRegSet allocated_regs = s->reserved_regs;
+
+        if (!IS_DEAD_ARG(1) && its->val_type == TEMP_VAL_REG) {
+            /* Make sure to not spill the input register. */
+            tcg_regset_set_reg(allocated_regs, its->reg);
+        }
+        ots->reg = tcg_reg_alloc(s, dup_out_regs, allocated_regs,
+                                 op->output_pref[0], ots->indirect_base);
+        ots->val_type = TEMP_VAL_REG;
+        ots->mem_coherent = 0;
+        s->reg_to_temp[ots->reg] = ots;
+    }
+
+    switch (its->val_type) {
+    case TEMP_VAL_REG:
+        /*
+         * The dup constriaints must be broad, covering all possible VECE.
+         * However, tcg_op_dup_vec() gets to see the VECE and we allow it
+         * to fail, indicating that extra moves are required for that case.
+         */
+        if (tcg_regset_test_reg(dup_in_regs, its->reg)) {
+            if (tcg_out_dup_vec(s, vtype, vece, ots->reg, its->reg)) {
+                goto done;
+            }
+            /* Try again from memory or a vector input register.  */
+        }
+        if (!its->mem_coherent) {
+            /*
+             * The input register is not synced, and so an extra store
+             * would be required to use memory.  Attempt an integer-vector
+             * register move first.  We do not have a TCGRegSet for this.
+             */
+            if (tcg_out_mov(s, itype, ots->reg, its->reg)) {
+                break;
+            }
+            /* Sync the temp back to its slot and load from there.  */
+            temp_sync(s, its, s->reserved_regs, 0, 0);
+        }
+        /* fall through */
+
+    case TEMP_VAL_MEM:
+        /* TODO: dup from memory */
+        tcg_out_ld(s, itype, ots->reg, its->mem_base->reg, its->mem_offset);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    /* We now have a vector input register, so dup must succeed. */
+    ok = tcg_out_dup_vec(s, vtype, vece, ots->reg, ots->reg);
+    tcg_debug_assert(ok);
+
+ done:
+    if (IS_DEAD_ARG(1)) {
+        temp_dead(s, its);
+    }
+    if (NEED_SYNC_ARG(0)) {
+        temp_sync(s, ots, s->reserved_regs, 0, 0);
+    }
+    if (IS_DEAD_ARG(0)) {
+        temp_dead(s, ots);
+    }
+}
+
 static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 {
     const TCGLifeData arg_life = op->life;
@@ -3981,6 +4089,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
         case INDEX_op_dupi_vec:
             tcg_reg_alloc_movi(s, op);
             break;
+        case INDEX_op_dup_vec:
+            tcg_reg_alloc_dup(s, op);
+            break;
         case INDEX_op_insn_start:
             if (num_insns >= 0) {
                 size_t off = tcg_current_code_size(s);
-- 
2.17.1


