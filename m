Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C04C282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0B020652
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPNr4aeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0B020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38103 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkay-0003dj-SB
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:39:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWR-0008KO-Ur
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWQ-0007em-HA
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:51 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWQ-0007eQ-B4
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:50 -0400
Received: by mail-pg1-x544.google.com with SMTP id l18so3459315pgj.6
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mMJwBlVyB/MmlQKnXsB2p1E0fVeRhNBVAwRu1nQHFzg=;
	b=xPNr4aeDIXraWxpq6k+ZDGDaWZnuC5X6I6f8DabSDFMELVOOPuhhmNsOWUiuvvwb4Y
	DOSy9m8+tQK6cZLeZXA1kYlNZ5ZcMTxb7JWq+1j7qQxuTlv6+KkrKrEj/+78BaGcFanW
	dfNbT8Aa0PQvi5q5QVJjyfTb4TSpM8xfDu6vhC6s4qG8KlVGDkvO1s3fDUxep8SqRc02
	I3IBFwTRm5UuQHolV6cNXzbozSrxVNj6XmBuMM7kaijbQepeqHj1zgBFtOOS8P4eGkIP
	csrSy8rASzSsPedbbOHkAmOtv/0bitSTAzdCWv4f4DrUcC8dswMtH/QB/kDp/OfOou6L
	z9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mMJwBlVyB/MmlQKnXsB2p1E0fVeRhNBVAwRu1nQHFzg=;
	b=JJmStUq7fLHiJ41nFBc4aDGoVK3d00DSkNYXRc7qmcFA/Ty4ygsMEzjlKwcLKs5Vew
	OtvKoc+UIBQNsJCGfC6VJr/WYg8rwrF88MNMPssA19kR329hPAps8xcCNi3YoFUuZloV
	i0m3mjVuRFU0QKHQgCD+4aFb1hP2OKnNPRmfcpkx09s5IalRZfnzEH0YTOOP50G/59ML
	Xtif4sUsQMuRuJOzn/toZL2GV7niHBZDQfyLuMYheRgTm9/In9ArpWmuvTJn7iv+OYW+
	ntG6hJ513uCyw+iOPp40zU2HpqMctL5IwEfq+H+DjdBJQaArDgYV1jKAkdT/S5s9DpO2
	az2w==
X-Gm-Message-State: APjAAAW5u9OmaFxxcSxW9ZMyNuny0OYbMhJskb24FHMgoU93l4RqTZIr
	LEzSAYXJDSrXT2Kc6kTQK1ehfqpPzsE=
X-Google-Smtp-Source: APXvYqyMtQ2BeezvlDW/qxAauSwZUNnDPx6iLPifuMHTRWgJzu5KGf6NWNnhKAGEdS3JsjTFrW5gxA==
X-Received: by 2002:a65:5106:: with SMTP id f6mr8135741pgq.253.1555745689102; 
	Sat, 20 Apr 2019 00:34:49 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.34.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:34:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:06 -1000
Message-Id: <20190420073442.7488-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 02/38] tcg: Assert fixed_reg is read-only
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073406.WKklw0kBpublKLeKmANKsaO1DA92_xeBthU2eksq8SA@z>

The only fixed_reg is cpu_env, and it should not be modified
during any TB.  Therefore code that tries to special-case moves
into a fixed_reg is dead.  Remove it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 85 +++++++++++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 47 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ade6050982..4f77a957b0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3279,11 +3279,8 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
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
@@ -3319,6 +3316,9 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     ots = arg_temp(op->args[0]);
     ts = arg_temp(op->args[1]);
 
+    /* ENV should not be modified.  */
+    tcg_debug_assert(!ots->fixed_reg);
+
     /* Note that otype != itype for no-op truncation.  */
     otype = ots->type;
     itype = ts->type;
@@ -3343,7 +3343,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     }
 
     tcg_debug_assert(ts->val_type == TEMP_VAL_REG);
-    if (IS_DEAD_ARG(0) && !ots->fixed_reg) {
+    if (IS_DEAD_ARG(0)) {
         /* mov to a non-saved dead register makes no sense (even with
            liveness analysis disabled). */
         tcg_debug_assert(NEED_SYNC_ARG(0));
@@ -3356,7 +3356,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
         }
         temp_dead(s, ots);
     } else {
-        if (IS_DEAD_ARG(1) && !ts->fixed_reg && !ots->fixed_reg) {
+        if (IS_DEAD_ARG(1) && !ts->fixed_reg) {
             /* the mov can be suppressed */
             if (ots->val_type == TEMP_VAL_REG) {
                 s->reg_to_temp[ots->reg] = NULL;
@@ -3509,6 +3509,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
@@ -3517,29 +3521,19 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
+            /* temp value is modified, so the value kept in memory is
+               potentially not the same */
+            ts->mem_coherent = 0;
+            s->reg_to_temp[reg] = ts;
             new_args[i] = reg;
         }
     }
@@ -3555,10 +3549,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
@@ -3679,26 +3673,23 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
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


