Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD70C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24626214C6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaG4Tcz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24626214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36771 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQLBD-00050S-8m
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:20:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQL1y-0004h8-LP
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxB-00038Q-7K
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:10:54 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKx6-00031J-Tm
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:05:54 -0400
Received: by mail-pg1-x544.google.com with SMTP id z16so7585036pgv.11
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=AEWllDC9QOtFQnoRVEZxCBNwIaVzx46hUstbb9Zao4Q=;
	b=WaG4Tcz0PifdCR9WqNBKm4vpR6FCXO1PZsGdFXNeAI7otYI79ilijuObYWH6hj9dc+
	nxwjfNt3iCs2mdi/im7S2z8bstp9G0XjUgX/W+tKxPzKXaH42kbEVExtvpgx99LYV2/1
	EupqpCUEoVEV6+8Ujm49yDHHYrgINfF3Lc5hy8p2SlFnxhDDO27/VTaw3uyt9LJl69Ru
	zG9RleIxkr+VwZB/AEyy94C4RunGMCRtABk9jw7cCG/6glbaddrybl3BvHotdc0ph8vj
	gR9NpFSPgn9XtKHlRAqRuDaFvIcLydZDdZCTitGhIk1ew5Hh02o20gRMy1jTmTqpV4gN
	cMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=AEWllDC9QOtFQnoRVEZxCBNwIaVzx46hUstbb9Zao4Q=;
	b=gJcuSgFK0QH2nl1aKzSq0CZbd/YT/h+W+7yE1QtkO2ysSMwL1PuJpVL/+71Ztfc2P2
	9SymOBHMeNbNMriJfqlPpYzfav11A181FpU3ORwBX1qzTsCsAEdhqnuOavAFy4kGWTpw
	lFM5iGIuZYMiVZs2XuQLS/muJcpwCYaZ21MLLxRXlG8TYkL/MHGXmeN+xt8iMIwfwsCx
	iw0YZQHQ/XIBhj/gI3jMtG1QMf7H1XPn7wcgnMGIuzxR8U4NgYBRanUEkpB6Jvm7zNo9
	HEWpZQdRcHEJB0y4mCD3fMD9vsJtZIaW2bGHjeEJyjkzlpDhiqdQI2afOSzjIRL4f+kb
	CiPw==
X-Gm-Message-State: APjAAAWddzncdbJ210mVszailiMmSQQ49VZceZIHVUDw/FjS4fAZLVzn
	F7rRjSUSOC9utEwz51dbckYmPnnDqw0=
X-Google-Smtp-Source: APXvYqxzgymhRZeLTGd+uTDPLklKkVSdcN9v4CX05PWWnk6IT6Z5uVryFmn2XnQ172UOe98e99TZMw==
X-Received: by 2002:a63:db10:: with SMTP id e16mr34890976pgg.142.1557792350421;
	Mon, 13 May 2019 17:05:50 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.05.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:05:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:14 -0700
Message-Id: <20190514000540.4313-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PULL 05/31] tcg: Assert fixed_reg is read-only
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


