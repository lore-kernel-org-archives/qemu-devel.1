Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EBCC4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01DE207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIxev3lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01DE207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVVe-0005Hu-Al
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 08:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTr-0003X2-O4
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:11 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36]:46412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTp-0001ww-2Q
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:11 -0400
Received: by mail-oo1-xc36.google.com with SMTP id c25so773303ooe.13
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g33TexuYH6rB4UUNBCMbt8mxbFAKdagQmJ2x4vq5KFk=;
 b=TIxev3lwvlWSPm1EMQ8UgETGgLXhHkSHIFVRbKF8hhLHg3kp6r3zLR1nyd3jq6DEqp
 qypVasmIXheXV9bMQAvDkUOsQweARJmu6Ct/OBCsaXGyBPII8kbI3XJ9onqfNYaMfHPj
 JkaGo2Zs6gp9BWSMVo9S/WcTjNTlro30LY1kZtqynkHRCShxVwxJd57DOOu6Vr9ue69r
 Gqyc9Veh8cBHM7bTq1AsujpBhhZYKdAICEh71P5kc1eZrCbNtdx8/pttILxIEN5KvVvs
 LpJ+YQyBQ7B5ceMp1tQe7GfWOmA4tsD3oBPwITRU6peZJJLeUV/MBNi2vDngoMsPRxA7
 ryeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g33TexuYH6rB4UUNBCMbt8mxbFAKdagQmJ2x4vq5KFk=;
 b=LPC6ZqL05iV1EH6d/wO6Iu4Xz2iYMGf2r7FrOVY6oI6DQQT4BiTYMMBShJR5aGd68h
 PQtlNIff/IMDxcNCAAaKq0YRqlpCj//ipPHhfwMUn90vbay+/eDHra4D6CXOH4wZQWtN
 jvekytQvX8eLmhB5kcBYj0MPIIr5VhYqqy8O7xyR1b+uRucdMZe3u4DeDS3G/XV426No
 meH6Y6qesCRiG5JW/dvzgV+djSKxo4ezk6BrrN1oDBAPJJaNQu78Upz+ejljxAPg7bWx
 17KUWbhKaPvgtlHXj2WgW+VI4YiPKkkPcGVClFIC2tH/xkf1R51whT1/ygyoHQ1+/XqQ
 zWMA==
X-Gm-Message-State: AOAM530RjMR+rgctq9EjtZlwqb8wKiEv2fi/VcdhGtinrwFSxlr5q1Kx
 +DkJt29T+LmtXtn+qn4KX8cKE83zueiRW5ch
X-Google-Smtp-Source: ABdhPJx2eW6e8uQYHKNs/yDikF0v7ho+E3u4oOeLx9fLbc+St33dhqLI4WOWcUCoW0V/m5kxREC3cw==
X-Received: by 2002:a4a:7055:: with SMTP id b21mr5325917oof.26.1602161826711; 
 Thu, 08 Oct 2020 05:57:06 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id w64sm4701933oig.31.2020.10.08.05.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 05:57:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] tcg: Drop union from TCGArgConstraint
Date: Thu,  8 Oct 2020 07:56:50 -0500
Message-Id: <20201008125659.49857-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
References: <20201008125659.49857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The union is unused; let "regs" appear in the main structure
without the "u.regs" wrapping.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h            |  4 +---
 tcg/tcg.c                    | 22 +++++++++++-----------
 tcg/aarch64/tcg-target.c.inc | 14 +++++++-------
 tcg/arm/tcg-target.c.inc     | 26 +++++++++++++-------------
 tcg/i386/tcg-target.c.inc    | 26 +++++++++++++-------------
 tcg/mips/tcg-target.c.inc    | 18 +++++++++---------
 tcg/ppc/tcg-target.c.inc     | 24 ++++++++++++------------
 tcg/riscv/tcg-target.c.inc   | 14 +++++++-------
 tcg/s390/tcg-target.c.inc    | 18 +++++++++---------
 tcg/sparc/tcg-target.c.inc   | 16 ++++++++--------
 tcg/tci/tcg-target.c.inc     |  2 +-
 11 files changed, 91 insertions(+), 93 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 53ce94c2c5..a5a0ea4ada 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -985,9 +985,7 @@ void tcg_dump_op_count(void);
 typedef struct TCGArgConstraint {
     uint16_t ct;
     uint8_t alias_index;
-    union {
-        TCGRegSet regs;
-    } u;
+    TCGRegSet regs;
 } TCGArgConstraint;
 
 #define TCG_MAX_OP_ARGS 16
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 164a141d74..8e0df353ec 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2210,7 +2210,7 @@ static int get_constraint_priority(const TCGOpDef *def, int k)
             return 0;
         n = 0;
         for(i = 0; i < TCG_TARGET_NB_REGS; i++) {
-            if (tcg_regset_test_reg(arg_ct->u.regs, i))
+            if (tcg_regset_test_reg(arg_ct->regs, i))
                 n++;
         }
     }
@@ -2268,7 +2268,7 @@ static void process_op_defs(TCGContext *s)
             /* Incomplete TCGTargetOpDef entry. */
             tcg_debug_assert(ct_str != NULL);
 
-            def->args_ct[i].u.regs = 0;
+            def->args_ct[i].regs = 0;
             def->args_ct[i].ct = 0;
             while (*ct_str != '\0') {
                 switch(*ct_str) {
@@ -2855,13 +2855,13 @@ static void liveness_pass_1(TCGContext *s)
                     pset = la_temp_pref(ts);
                     set = *pset;
 
-                    set &= ct->u.regs;
+                    set &= ct->regs;
                     if (ct->ct & TCG_CT_IALIAS) {
                         set &= op->output_pref[ct->alias_index];
                     }
                     /* If the combination is not possible, restart.  */
                     if (set == 0) {
-                        set = ct->u.regs;
+                        set = ct->regs;
                     }
                     *pset = set;
                 }
@@ -3551,8 +3551,8 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
         return;
     }
 
-    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].u.regs;
-    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].u.regs;
+    dup_out_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[0].regs;
+    dup_in_regs = tcg_op_defs[INDEX_op_dup_vec].args_ct[1].regs;
 
     /* Allocate the output register now.  */
     if (ots->val_type != TEMP_VAL_REG) {
@@ -3706,10 +3706,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             }
         }
 
-        temp_load(s, ts, arg_ct->u.regs, i_allocated_regs, i_preferred_regs);
+        temp_load(s, ts, arg_ct->regs, i_allocated_regs, i_preferred_regs);
         reg = ts->reg;
 
-        if (tcg_regset_test_reg(arg_ct->u.regs, reg)) {
+        if (tcg_regset_test_reg(arg_ct->regs, reg)) {
             /* nothing to do : the constraint is satisfied */
         } else {
         allocate_in_reg:
@@ -3717,7 +3717,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                and move the temporary register into it */
             temp_load(s, ts, tcg_target_available_regs[ts->type],
                       i_allocated_regs, 0);
-            reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
+            reg = tcg_reg_alloc(s, arg_ct->regs, i_allocated_regs,
                                 o_preferred_regs, ts->indirect_base);
             if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
                 /*
@@ -3772,11 +3772,11 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                 && !const_args[arg_ct->alias_index]) {
                 reg = new_args[arg_ct->alias_index];
             } else if (arg_ct->ct & TCG_CT_NEWREG) {
-                reg = tcg_reg_alloc(s, arg_ct->u.regs,
+                reg = tcg_reg_alloc(s, arg_ct->regs,
                                     i_allocated_regs | o_allocated_regs,
                                     op->output_pref[k], ts->indirect_base);
             } else {
-                reg = tcg_reg_alloc(s, arg_ct->u.regs, o_allocated_regs,
+                reg = tcg_reg_alloc(s, arg_ct->regs, o_allocated_regs,
                                     op->output_pref[k], ts->indirect_base);
             }
             tcg_regset_set_reg(o_allocated_regs, reg);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 2607fe4ab9..dbe5c6a14c 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -129,22 +129,22 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     switch (*ct_str++) {
     case 'r': /* general registers */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs |= 0xffffffffu;
+        ct->regs |= 0xffffffffu;
         break;
     case 'w': /* advsimd registers */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs |= 0xffffffff00000000ull;
+        ct->regs |= 0xffffffff00000000ull;
         break;
     case 'l': /* qemu_ld / qemu_st address, data_reg */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffffu;
+        ct->regs = 0xffffffffu;
 #ifdef CONFIG_SOFTMMU
         /* x0 and x1 will be overwritten when reading the tlb entry,
            and x2, and x3 for helper args, better to avoid using them. */
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_X0);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_X1);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_X2);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_X3);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_X0);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_X1);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_X2);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_X3);
 #endif
         break;
     case 'A': /* Valid for arithmetic immediate (positive or negative).  */
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index bc1e1b5a71..978eb1dd70 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -254,40 +254,40 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 
     case 'r':
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffff;
+        ct->regs = 0xffff;
         break;
 
     /* qemu_ld address */
     case 'l':
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffff;
+        ct->regs = 0xffff;
 #ifdef CONFIG_SOFTMMU
         /* r0-r2,lr will be overwritten when reading the tlb entry,
            so don't use these. */
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R0);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R1);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R2);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R14);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R0);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R1);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R2);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R3);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R14);
 #endif
         break;
 
     /* qemu_st address & data */
     case 's':
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffff;
+        ct->regs = 0xffff;
         /* r0-r2 will be overwritten when reading the tlb entry (softmmu only)
            and r0-r1 doing the byte swapping, so don't use these. */
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R0);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R1);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R0);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R1);
 #if defined(CONFIG_SOFTMMU)
         /* Avoid clashes with registers being used for helper args */
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R2);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R2);
 #if TARGET_LONG_BITS == 64
         /* Avoid clashes with registers being used for helper args */
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R3);
 #endif
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R14);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R14);
 #endif
         break;
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0155c0691c..8661ec3393 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -209,42 +209,42 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     switch(*ct_str++) {
     case 'a':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set_reg(ct->u.regs, TCG_REG_EAX);
+        tcg_regset_set_reg(ct->regs, TCG_REG_EAX);
         break;
     case 'b':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set_reg(ct->u.regs, TCG_REG_EBX);
+        tcg_regset_set_reg(ct->regs, TCG_REG_EBX);
         break;
     case 'c':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set_reg(ct->u.regs, TCG_REG_ECX);
+        tcg_regset_set_reg(ct->regs, TCG_REG_ECX);
         break;
     case 'd':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set_reg(ct->u.regs, TCG_REG_EDX);
+        tcg_regset_set_reg(ct->regs, TCG_REG_EDX);
         break;
     case 'S':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set_reg(ct->u.regs, TCG_REG_ESI);
+        tcg_regset_set_reg(ct->regs, TCG_REG_ESI);
         break;
     case 'D':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set_reg(ct->u.regs, TCG_REG_EDI);
+        tcg_regset_set_reg(ct->regs, TCG_REG_EDI);
         break;
     case 'q':
         /* A register that can be used as a byte operand.  */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xf;
+        ct->regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xf;
         break;
     case 'Q':
         /* A register with an addressable second byte (e.g. %ah).  */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xf;
+        ct->regs = 0xf;
         break;
     case 'r':
         /* A general register.  */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs |= ALL_GENERAL_REGS;
+        ct->regs |= ALL_GENERAL_REGS;
         break;
     case 'W':
         /* With TZCNT/LZCNT, we can have operand-size as an input.  */
@@ -253,15 +253,15 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'x':
         /* A vector register.  */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs |= ALL_VECTOR_REGS;
+        ct->regs |= ALL_VECTOR_REGS;
         break;
 
         /* qemu_ld/st address constraint */
     case 'L':
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xff;
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_L0);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_L1);
+        ct->regs = TCG_TARGET_REG_BITS == 64 ? 0xffff : 0xff;
+        tcg_regset_reset_reg(ct->regs, TCG_REG_L0);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_L1);
         break;
 
     case 'e':
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 7aa2073520..aae4fd187b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -196,28 +196,28 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     switch(*ct_str++) {
     case 'r':
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
+        ct->regs = 0xffffffff;
         break;
     case 'L': /* qemu_ld input arg constraint */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_A0);
+        ct->regs = 0xffffffff;
+        tcg_regset_reset_reg(ct->regs, TCG_REG_A0);
 #if defined(CONFIG_SOFTMMU)
         if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
-            tcg_regset_reset_reg(ct->u.regs, TCG_REG_A2);
+            tcg_regset_reset_reg(ct->regs, TCG_REG_A2);
         }
 #endif
         break;
     case 'S': /* qemu_st constraint */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_A0);
+        ct->regs = 0xffffffff;
+        tcg_regset_reset_reg(ct->regs, TCG_REG_A0);
 #if defined(CONFIG_SOFTMMU)
         if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
-            tcg_regset_reset_reg(ct->u.regs, TCG_REG_A2);
-            tcg_regset_reset_reg(ct->u.regs, TCG_REG_A3);
+            tcg_regset_reset_reg(ct->regs, TCG_REG_A2);
+            tcg_regset_reset_reg(ct->regs, TCG_REG_A3);
         } else {
-            tcg_regset_reset_reg(ct->u.regs, TCG_REG_A1);
+            tcg_regset_reset_reg(ct->regs, TCG_REG_A1);
         }
 #endif
         break;
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 7cb40b0466..0bd947b788 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -225,33 +225,33 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     switch (*ct_str++) {
     case 'A': case 'B': case 'C': case 'D':
         ct->ct |= TCG_CT_REG;
-        tcg_regset_set_reg(ct->u.regs, 3 + ct_str[0] - 'A');
+        tcg_regset_set_reg(ct->regs, 3 + ct_str[0] - 'A');
         break;
     case 'r':
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
+        ct->regs = 0xffffffff;
         break;
     case 'v':
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff00000000ull;
+        ct->regs = 0xffffffff00000000ull;
         break;
     case 'L':                   /* qemu_ld constraint */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
+        ct->regs = 0xffffffff;
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R3);
 #ifdef CONFIG_SOFTMMU
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R4);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R5);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R4);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R5);
 #endif
         break;
     case 'S':                   /* qemu_st constraint */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
+        ct->regs = 0xffffffff;
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R3);
 #ifdef CONFIG_SOFTMMU
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R4);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R5);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R6);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R4);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R5);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R6);
 #endif
         break;
     case 'I':
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 2dfb07e247..0a69839adb 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -138,19 +138,19 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     switch (*ct_str++) {
     case 'r':
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
+        ct->regs = 0xffffffff;
         break;
     case 'L':
         /* qemu_ld/qemu_st constraint */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
+        ct->regs = 0xffffffff;
         /* qemu_ld/qemu_st uses TCG_REG_TMP0 */
 #if defined(CONFIG_SOFTMMU)
-        tcg_regset_reset_reg(ct->u.regs, tcg_target_call_iarg_regs[0]);
-        tcg_regset_reset_reg(ct->u.regs, tcg_target_call_iarg_regs[1]);
-        tcg_regset_reset_reg(ct->u.regs, tcg_target_call_iarg_regs[2]);
-        tcg_regset_reset_reg(ct->u.regs, tcg_target_call_iarg_regs[3]);
-        tcg_regset_reset_reg(ct->u.regs, tcg_target_call_iarg_regs[4]);
+        tcg_regset_reset_reg(ct->regs, tcg_target_call_iarg_regs[0]);
+        tcg_regset_reset_reg(ct->regs, tcg_target_call_iarg_regs[1]);
+        tcg_regset_reset_reg(ct->regs, tcg_target_call_iarg_regs[2]);
+        tcg_regset_reset_reg(ct->regs, tcg_target_call_iarg_regs[3]);
+        tcg_regset_reset_reg(ct->regs, tcg_target_call_iarg_regs[4]);
 #endif
         break;
     case 'I':
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index 985115acfb..9cd266a2d0 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -409,24 +409,24 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     switch (*ct_str++) {
     case 'r':                  /* all registers */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffff;
+        ct->regs = 0xffff;
         break;
     case 'L':                  /* qemu_ld/st constraint */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffff;
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R2);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R3);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_R4);
+        ct->regs = 0xffff;
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R2);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R3);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_R4);
         break;
     case 'a':                  /* force R2 for division */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0;
-        tcg_regset_set_reg(ct->u.regs, TCG_REG_R2);
+        ct->regs = 0;
+        tcg_regset_set_reg(ct->regs, TCG_REG_R2);
         break;
     case 'b':                  /* force R3 for division */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0;
-        tcg_regset_set_reg(ct->u.regs, TCG_REG_R3);
+        ct->regs = 0;
+        tcg_regset_set_reg(ct->regs, TCG_REG_R3);
         break;
     case 'A':
         ct->ct |= TCG_CT_CONST_S33;
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index 40bc12290c..e2de749af7 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -326,27 +326,27 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     switch (*ct_str++) {
     case 'r':
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
+        ct->regs = 0xffffffff;
         break;
     case 'R':
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = ALL_64;
+        ct->regs = ALL_64;
         break;
     case 'A': /* qemu_ld/st address constraint */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = TARGET_LONG_BITS == 64 ? ALL_64 : 0xffffffff;
+        ct->regs = TARGET_LONG_BITS == 64 ? ALL_64 : 0xffffffff;
     reserve_helpers:
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_O0);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_O1);
-        tcg_regset_reset_reg(ct->u.regs, TCG_REG_O2);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_O0);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_O1);
+        tcg_regset_reset_reg(ct->regs, TCG_REG_O2);
         break;
     case 's': /* qemu_st data 32-bit constraint */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = 0xffffffff;
+        ct->regs = 0xffffffff;
         goto reserve_helpers;
     case 'S': /* qemu_st data 64-bit constraint */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = ALL_64;
+        ct->regs = ALL_64;
         goto reserve_helpers;
     case 'I':
         ct->ct |= TCG_CT_CONST_S11;
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 992d50cb1e..a7215f346f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -393,7 +393,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'L':                   /* qemu_ld constraint */
     case 'S':                   /* qemu_st constraint */
         ct->ct |= TCG_CT_REG;
-        ct->u.regs = BIT(TCG_TARGET_NB_REGS) - 1;
+        ct->regs = BIT(TCG_TARGET_NB_REGS) - 1;
         break;
     default:
         return NULL;
-- 
2.25.1


