Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79007C282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35354208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irBPPWdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35354208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38077 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkYQ-0001WV-Av
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:36:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWU-0008MX-9A
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWS-0007gC-K6
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:54 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWS-0007fa-CN
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:52 -0400
Received: by mail-pl1-x644.google.com with SMTP id d1so3532485plj.8
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=++rfimdjNhvgXJCPSNhLZGoRFxyZo6MTZOKY7rGkHAA=;
	b=irBPPWdMGVBtZIMgKyrAIyngAAQWT+BE5Qh+J5Bj5eZUSpbGS1Q++zkg85QeJ5Zb1X
	2TovKtr1xwa1zFbWIWiiRB+8RI6PKHh/DVM18EywuowGvYRWJCaIvT1pZQIiwDB+Bjmm
	cOh8F6OiHdYU4qsxxdra3DEwILaum41jOY5m36R4wtdFNVIXsnPPVTC3PlRo3h6PCvTF
	EkAEbbZiLOqk7+8ijHP0kwyRDwa2snGEpohJpKo7YP47cYh0DlYy67vktVCB9mq+f0Hq
	l/wPyUEJScIyU4+XWCiAsJiaeBXDED3TvpoH59SHvFLafP40obAAIYfozgqALA9pU3W7
	22IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=++rfimdjNhvgXJCPSNhLZGoRFxyZo6MTZOKY7rGkHAA=;
	b=DHL2qRU1x4Xtwaof+Gy0JK7I50D3gviwZsPj79bBjiPZmuD4eDSbsX2MyFblo2cD3F
	Hl6Nn4E2HsQT+QsCAcxs0fO1O6XTNcVX+Tq5mFRcleTP7t/JLVZa+AMtToPqS7UQrwTb
	43OyJzSYdJ0hji0sp9MYQP6TuK9b0bwvs3wz7ofVo8HoktHGok6rFEQdxrAUhJo4E0mj
	Qbp5pCB/q8BCdK+wC9ZSVJQOztXgSgN3lV8iUphzfDNWD7RPxg1I2LS+KURuEqcBUMfC
	Sbm6r7BzMypmFCvkmsIlCO5gO4J6aR9P3yy12BhQN+eK//IrOHDoBAAfQPIoXugC+Cc4
	mSGQ==
X-Gm-Message-State: APjAAAVIXAmHTgtKqs+/000cewOM/if3KfksQXS9OM2rbSJ4EmAPJs+6
	OI5nyFmd69N+Rc9+cDGiKRI8kUhuQl4=
X-Google-Smtp-Source: APXvYqyPGAEcqGXcr/iGF+fYeRI6v/cd6TRp0mxYiT3ZmRqmwdLY5OP41WTj/2BN0tAyXmumxpH7Iw==
X-Received: by 2002:a17:902:b210:: with SMTP id
	t16mr8282405plr.84.1555745690904; 
	Sat, 20 Apr 2019 00:34:50 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.34.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:34:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:07 -1000
Message-Id: <20190420073442.7488-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 03/38] tcg: Return bool success from tcg_out_mov
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
Message-ID: <20190420073407.E1IBnp9FFnbfb_g8ZGXUiLiRYiG9zZceDHdu8nC6lGE@z>

This patch merely changes the interface, aborting on all failures,
of which there are currently none.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c |  5 +++--
 tcg/arm/tcg-target.inc.c     |  7 +++++--
 tcg/i386/tcg-target.inc.c    |  5 +++--
 tcg/mips/tcg-target.inc.c    |  3 ++-
 tcg/ppc/tcg-target.inc.c     |  3 ++-
 tcg/riscv/tcg-target.inc.c   |  5 +++--
 tcg/s390/tcg-target.inc.c    |  3 ++-
 tcg/sparc/tcg-target.inc.c   |  3 ++-
 tcg/tcg.c                    | 14 ++++++++++----
 tcg/tci/tcg-target.inc.c     |  3 ++-
 10 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 8b93598bce..b2d3f9c0a5 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -938,10 +938,10 @@ static void tcg_out_ldst(TCGContext *s, AArch64Insn insn, TCGReg rd,
     tcg_out_ldst_r(s, insn, rd, rn, TCG_TYPE_I64, TCG_REG_TMP);
 }
 
-static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
     if (ret == arg) {
-        return;
+        return true;
     }
     switch (type) {
     case TCG_TYPE_I32:
@@ -970,6 +970,7 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     default:
         g_assert_not_reached();
     }
+    return true;
 }
 
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 6873b0cf95..34e6652142 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -2275,10 +2275,13 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
-static inline void tcg_out_mov(TCGContext *s, TCGType type,
+static inline bool tcg_out_mov(TCGContext *s, TCGType type,
                                TCGReg ret, TCGReg arg)
 {
-    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, ret, 0, arg, SHIFT_IMM_LSL(0));
+    if (ret != arg) {
+        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, ret, 0, arg, SHIFT_IMM_LSL(0));
+    }
+    return true;
 }
 
 static inline void tcg_out_movi(TCGContext *s, TCGType type,
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 1fa833840e..817a167767 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -809,12 +809,12 @@ static inline void tgen_arithr(TCGContext *s, int subop, int dest, int src)
     tcg_out_modrm(s, OPC_ARITH_GvEv + (subop << 3) + ext, dest, src);
 }
 
-static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
     int rexw = 0;
 
     if (arg == ret) {
-        return;
+        return true;
     }
     switch (type) {
     case TCG_TYPE_I64:
@@ -852,6 +852,7 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     default:
         g_assert_not_reached();
     }
+    return true;
 }
 
 static void tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 8a92e916dd..f31ebb43bf 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -558,13 +558,14 @@ static inline void tcg_out_dsra(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
     tcg_out_opc_sa64(s, OPC_DSRA, OPC_DSRA32, rd, rt, sa);
 }
 
-static inline void tcg_out_mov(TCGContext *s, TCGType type,
+static inline bool tcg_out_mov(TCGContext *s, TCGType type,
                                TCGReg ret, TCGReg arg)
 {
     /* Simple reg-reg move, optimising out the 'do nothing' case */
     if (ret != arg) {
         tcg_out_opc_reg(s, OPC_OR, ret, arg, TCG_REG_ZERO);
     }
+    return true;
 }
 
 static void tcg_out_movi(TCGContext *s, TCGType type,
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 773690f1d9..ec8e336be8 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -566,12 +566,13 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
                              TCGReg base, tcg_target_long offset);
 
-static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
     if (ret != arg) {
         tcg_out32(s, OR | SAB(arg, ret, arg));
     }
+    return true;
 }
 
 static inline void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index b785f4acb7..e2bf1c2c6e 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -515,10 +515,10 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
  * TCG intrinsics
  */
 
-static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
     if (ret == arg) {
-        return;
+        return true;
     }
     switch (type) {
     case TCG_TYPE_I32:
@@ -528,6 +528,7 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     default:
         g_assert_not_reached();
     }
+    return true;
 }
 
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 7db90b3bae..eb22188d1d 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -548,7 +548,7 @@ static void tcg_out_sh32(TCGContext* s, S390Opcode op, TCGReg dest,
     tcg_out_insn_RS(s, op, dest, sh_reg, 0, sh_imm);
 }
 
-static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
 {
     if (src != dst) {
         if (type == TCG_TYPE_I32) {
@@ -557,6 +557,7 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
             tcg_out_insn(s, RRE, LGR, dst, src);
         }
     }
+    return true;
 }
 
 static const S390Opcode lli_insns[4] = {
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 7a61839dc1..83295955a7 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -407,12 +407,13 @@ static void tcg_out_arithc(TCGContext *s, TCGReg rd, TCGReg rs1,
               | (val2const ? INSN_IMM13(val2) : INSN_RS2(val2)));
 }
 
-static inline void tcg_out_mov(TCGContext *s, TCGType type,
+static inline bool tcg_out_mov(TCGContext *s, TCGType type,
                                TCGReg ret, TCGReg arg)
 {
     if (ret != arg) {
         tcg_out_arith(s, ret, arg, TCG_REG_G0, ARITH_OR);
     }
+    return true;
 }
 
 static inline void tcg_out_sethi(TCGContext *s, TCGReg ret, uint32_t arg)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4f77a957b0..b083faacd2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -102,7 +102,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type);
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
                        intptr_t arg2);
-static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
 static void tcg_out_movi(TCGContext *s, TCGType type,
                          TCGReg ret, tcg_target_long arg);
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
@@ -3372,7 +3372,9 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
                                          allocated_regs, preferred_regs,
                                          ots->indirect_base);
             }
-            tcg_out_mov(s, otype, ots->reg, ts->reg);
+            if (!tcg_out_mov(s, otype, ots->reg, ts->reg)) {
+                abort();
+            }
         }
         ots->val_type = TEMP_VAL_REG;
         ots->mem_coherent = 0;
@@ -3472,7 +3474,9 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                       i_allocated_regs, 0);
             reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
                                 o_preferred_regs, ts->indirect_base);
-            tcg_out_mov(s, ts->type, reg, ts->reg);
+            if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
+                abort();
+            }
         }
         new_args[i] = reg;
         const_args[i] = 0;
@@ -3629,7 +3633,9 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
             if (ts->val_type == TEMP_VAL_REG) {
                 if (ts->reg != reg) {
                     tcg_reg_free(s, reg, allocated_regs);
-                    tcg_out_mov(s, ts->type, reg, ts->reg);
+                    if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
+                        abort();
+                    }
                 }
             } else {
                 TCGRegSet arg_set = 0;
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 0015a98485..992d50cb1e 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -509,7 +509,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
     old_code_ptr[1] = s->code_ptr - old_code_ptr;
 }
 
-static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
     uint8_t *old_code_ptr = s->code_ptr;
     tcg_debug_assert(ret != arg);
@@ -521,6 +521,7 @@ static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     tcg_out_r(s, ret);
     tcg_out_r(s, arg);
     old_code_ptr[1] = s->code_ptr - old_code_ptr;
+    return true;
 }
 
 static void tcg_out_movi(TCGContext *s, TCGType type,
-- 
2.17.1


