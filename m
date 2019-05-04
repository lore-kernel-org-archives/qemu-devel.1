Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6186C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0DA20675
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iZETl0ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0DA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51658 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMngQ-0002tk-LH
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 01:58:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbk-0007hC-Jm
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbj-00049G-7S
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:12 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbj-00046t-0k
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:11 -0400
Received: by mail-pg1-x541.google.com with SMTP id z3so59852pgp.8
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=AEWllDC9QOtFQnoRVEZxCBNwIaVzx46hUstbb9Zao4Q=;
	b=iZETl0exm2mwe37YJSYauOjqSn2X1yX7gYox/nsBAMwiKJdQ9pM2nw8TjCt0Zqp/dg
	akRinFecWNg3d7cuAhreaDiKKfc2h4ukjbnJmt5jtIuQ4qzRMsc+MKhwYV6jahXy4/B+
	M3dTd5QPc+6ppPJmWKL1HvWk4BWpdXklZvoNrfBu3AplA8KOfAATbO93vu8HF73P6kkt
	MYgDCr87pn70ZT3nlC8TIQRGrzvuiONNcCWGnu940VZQUAtwFMrd0V/+60rqgKNcKrGI
	V6+BnsDa0dVIgHHNOiSgIZwlH9D6EVamgXpjtjV1ScqyUhkul93RZPEDB8WxhZNy6X7F
	rbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=AEWllDC9QOtFQnoRVEZxCBNwIaVzx46hUstbb9Zao4Q=;
	b=YSbIO6z2t46i4MivprlyOgGny5UMKY33bf6gTQQmEcKMQVXolq6QicfFvzP72gYmiu
	VYEoCcY/Q2Qx5k3jAiYJk2NZzI4683i5g9t2cyTKYzAjQz94QyZ0/MibUZzdTbwkTzb4
	EBVkWHGLg1DzHbA5/TYx83e12QB5M2nrFTizKDfyxd3tSYlNRsJDcoFZCmN3mffodu+b
	leOlvgacdjdxQl7YKld42O5T8mNPLFWGkiSzfvl+rkMvD8IDPQdbqhcfeFd7nNrb/v7o
	cl9zpArggWcBJFmL021cOHeaoG1J279XYOPt9CTah0/hbBrhGaM8VeGJQ/719YuM7XST
	efYw==
X-Gm-Message-State: APjAAAVRrBqLe75MgUB5ivRNHZTPehYcVvlKdn6MexmRFVebqzl1q6Za
	DTNx8Bt+iKpAzlevbyLi1IIJVAyG2tA=
X-Google-Smtp-Source: APXvYqxyNam82B17U5fIQry01SAviFw62+/q8QdMgU7+zsS6hmAw00m+afLnLZV6XfW13MASfkehZQ==
X-Received: by 2002:a62:570a:: with SMTP id l10mr6751866pfb.151.1556949188537; 
	Fri, 03 May 2019 22:53:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:34 -0700
Message-Id: <20190504055300.18426-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 05/31] tcg: Assert fixed_reg is read-only
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504055234.JHkNrT4M8oYbh2XGDlGNWxbfIVP_qJMtAzP9PDoPoME@z>

The only fixed_reg is cpu_env, and it should not be modified
during any TB.  Therefore code that tries to special-case moves
into a fixed_reg is dead.  Remove it.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 87 +++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index f7bef51de8..70ca113c26 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3274,11 +3274,8 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
                                   tcg_target_ulong val, TCGLifeData arg_life,
                                   TCGRegSet preferred_regs)
 {
-    if (ots->fixed_reg) {
-        /* For fixed registers, we do not do any constant propagation.  */
-        tcg_out_movi(s, ots->type, ots->reg, val);
-        return;
-    }
+    /* ENV should not be modified.  */
+    tcg_debug_assert(!ots->fixed_reg);
 
     /* The movi is not explicitly generated here.  */
     if (ots->val_type == TEMP_VAL_REG) {
@@ -3314,6 +3311,9 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     ots = arg_temp(op->args[0]);
     ts = arg_temp(op->args[1]);
 
+    /* ENV should not be modified.  */
+    tcg_debug_assert(!ots->fixed_reg);
+
     /* Note that otype != itype for no-op truncation.  */
     otype = ots->type;
     itype = ts->type;
@@ -3338,7 +3338,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     }
 
     tcg_debug_assert(ts->val_type == TEMP_VAL_REG);
-    if (IS_DEAD_ARG(0) && !ots->fixed_reg) {
+    if (IS_DEAD_ARG(0)) {
         /* mov to a non-saved dead register makes no sense (even with
            liveness analysis disabled). */
         tcg_debug_assert(NEED_SYNC_ARG(0));
@@ -3351,7 +3351,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
         }
         temp_dead(s, ots);
     } else {
-        if (IS_DEAD_ARG(1) && !ts->fixed_reg && !ots->fixed_reg) {
+        if (IS_DEAD_ARG(1) && !ts->fixed_reg) {
             /* the mov can be suppressed */
             if (ots->val_type == TEMP_VAL_REG) {
                 s->reg_to_temp[ots->reg] = NULL;
@@ -3504,6 +3504,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             arg = op->args[i];
             arg_ct = &def->args_ct[i];
             ts = arg_temp(arg);
+
+            /* ENV should not be modified.  */
+            tcg_debug_assert(!ts->fixed_reg);
+
             if ((arg_ct->ct & TCG_CT_ALIAS)
                 && !const_args[arg_ct->alias_index]) {
                 reg = new_args[arg_ct->alias_index];
@@ -3512,29 +3516,21 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                                     i_allocated_regs | o_allocated_regs,
                                     op->output_pref[k], ts->indirect_base);
             } else {
-                /* if fixed register, we try to use it */
-                reg = ts->reg;
-                if (ts->fixed_reg &&
-                    tcg_regset_test_reg(arg_ct->u.regs, reg)) {
-                    goto oarg_end;
-                }
                 reg = tcg_reg_alloc(s, arg_ct->u.regs, o_allocated_regs,
                                     op->output_pref[k], ts->indirect_base);
             }
             tcg_regset_set_reg(o_allocated_regs, reg);
-            /* if a fixed register is used, then a move will be done afterwards */
-            if (!ts->fixed_reg) {
-                if (ts->val_type == TEMP_VAL_REG) {
-                    s->reg_to_temp[ts->reg] = NULL;
-                }
-                ts->val_type = TEMP_VAL_REG;
-                ts->reg = reg;
-                /* temp value is modified, so the value kept in memory is
-                   potentially not the same */
-                ts->mem_coherent = 0;
-                s->reg_to_temp[reg] = ts;
+            if (ts->val_type == TEMP_VAL_REG) {
+                s->reg_to_temp[ts->reg] = NULL;
             }
-        oarg_end:
+            ts->val_type = TEMP_VAL_REG;
+            ts->reg = reg;
+            /*
+             * Temp value is modified, so the value kept in memory is
+             * potentially not the same.
+             */
+            ts->mem_coherent = 0;
+            s->reg_to_temp[reg] = ts;
             new_args[i] = reg;
         }
     }
@@ -3550,10 +3546,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     /* move the outputs in the correct register if needed */
     for(i = 0; i < nb_oargs; i++) {
         ts = arg_temp(op->args[i]);
-        reg = new_args[i];
-        if (ts->fixed_reg && ts->reg != reg) {
-            tcg_out_mov(s, ts->type, ts->reg, reg);
-        }
+
+        /* ENV should not be modified.  */
+        tcg_debug_assert(!ts->fixed_reg);
+
         if (NEED_SYNC_ARG(i)) {
             temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
         } else if (IS_DEAD_ARG(i)) {
@@ -3674,26 +3670,23 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
     for(i = 0; i < nb_oargs; i++) {
         arg = op->args[i];
         ts = arg_temp(arg);
+
+        /* ENV should not be modified.  */
+        tcg_debug_assert(!ts->fixed_reg);
+
         reg = tcg_target_call_oarg_regs[i];
         tcg_debug_assert(s->reg_to_temp[reg] == NULL);
-
-        if (ts->fixed_reg) {
-            if (ts->reg != reg) {
-                tcg_out_mov(s, ts->type, ts->reg, reg);
-            }
-        } else {
-            if (ts->val_type == TEMP_VAL_REG) {
-                s->reg_to_temp[ts->reg] = NULL;
-            }
-            ts->val_type = TEMP_VAL_REG;
-            ts->reg = reg;
-            ts->mem_coherent = 0;
-            s->reg_to_temp[reg] = ts;
-            if (NEED_SYNC_ARG(i)) {
-                temp_sync(s, ts, allocated_regs, 0, IS_DEAD_ARG(i));
-            } else if (IS_DEAD_ARG(i)) {
-                temp_dead(s, ts);
-            }
+        if (ts->val_type == TEMP_VAL_REG) {
+            s->reg_to_temp[ts->reg] = NULL;
+        }
+        ts->val_type = TEMP_VAL_REG;
+        ts->reg = reg;
+        ts->mem_coherent = 0;
+        s->reg_to_temp[reg] = ts;
+        if (NEED_SYNC_ARG(i)) {
+            temp_sync(s, ts, allocated_regs, 0, IS_DEAD_ARG(i));
+        } else if (IS_DEAD_ARG(i)) {
+            temp_dead(s, ts);
         }
     }
 }
-- 
2.17.1


