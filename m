Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F333C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D7620866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1dJFdQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D7620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36311 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhYw-0004Lh-Cx
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:13:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRL-0006Li-JK
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRI-0002pj-I4
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:55 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRI-0002ow-Be
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:52 -0400
Received: by mail-pg1-x543.google.com with SMTP id e6so7869095pgc.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=U3BnDe65BmJP00y5pZ+7ayWPkWBbMA/WJCdscz/OiAE=;
	b=p1dJFdQdU92z34tSiyC7YBzzcn/BuZrBM9bO6xb3PFlOzaRo6+xjz0CAuv2RkHOsYM
	vTQplNZoX4p6E+oB6PO6QkKKEOnhGqkqyPAX3ZU/R7eYL1E9qsSKwDuekeOqG0eyoll1
	rPIX6wCAJXQ/dj6L7uDpRUDoAytb5eE4mfzEk9uS9aXn0cMeI/i6NVWqHKwGFTypmWm4
	efjMlqh1MCnDzVFSqRXfse50dIzd/pARJAgGHWuBFQaDPArH1tOKEJ3MWgp60qM99vWR
	B00c2UI4jaD+NVLx6+vRDybXlwRDU4ZrGxARQ+r5IOopPbB1vnU3c4iVxwRuU475hkUP
	Yjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=U3BnDe65BmJP00y5pZ+7ayWPkWBbMA/WJCdscz/OiAE=;
	b=ukOo1gyW+7yRdckxPNgkzI3lsw6LMJ8cI/8qNAwRQVPk4WO4fhVltk1WUUskklvmxD
	5GrBwJ3PMe8iI6+qQ934/kIdfDsVToreRIqaGI/XbVkEVmy650qL9MiNYLnYHMM/V6F6
	M+i9vr4ScW8W59o1QJY9oNqEmuRbrw0fBPf4cIVQOn+BD5HM8alHNKlOscFC8tUQ9RJE
	nRnCe0ePbJRqBJP3ZzIrsrqxxoa84DzFyUs8bEqd2wsI09t6sJdOLuJk0f6EHCB8p2kR
	4oStoYqP5hv9Q5lmo1deVeCVNCwj7RPHhKld1ASABID9NjlvMWtAsqgltAirAgtRjSn6
	tw+g==
X-Gm-Message-State: APjAAAUyquZMyRZZS+NcO92k9bOa6EjYjKQQ+l7svmZ5FLmJX6/9hfOY
	AUPHqLR2PyrEqhM51EivA0vRKDgADhs=
X-Google-Smtp-Source: APXvYqxZuWsUYzm5+mSeFrIQDn/dI/oNMbuUgJdjG+C3WOvJ3mX2kK8saXBVteVMpXb5S9da088zCA==
X-Received: by 2002:a63:ee15:: with SMTP id e21mr43206964pgi.180.1556687149735;
	Tue, 30 Apr 2019 22:05:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:12 -0700
Message-Id: <20190501050536.15580-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v2 05/29] tcg: Assert fixed_reg is read-only
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050512.FR2Qs30fa2BSSmoR-hhqP0uBz7_k8LXh8m6PPx1cIKo@z>

The only fixed_reg is cpu_env, and it should not be modified
during any TB.  Therefore code that tries to special-case moves
into a fixed_reg is dead.  Remove it.

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


