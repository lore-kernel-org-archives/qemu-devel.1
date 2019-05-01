Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D1C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1CB20866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xivpR5MH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1CB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36223 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhTG-0007eT-Hj
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:07:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRL-0006Lm-MG
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRI-0002pp-Km
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:55 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRI-0002pT-CJ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:52 -0400
Received: by mail-pl1-x643.google.com with SMTP id b3so7749326plr.7
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=qiiPM6Lpw8c2dEQtxX+Nb/J/c5fJDmZyk5OYGy8I6xw=;
	b=xivpR5MHUxC+bP+6h6AauntNVtEeoZZlPCRU2ysbFn+WHY+jOdVfhN7f/HO+Pcdoy8
	UKexga8QJLcNFrOrZQgBcsZdxQnrQldGZgpldoBWt+x6L6XKm+/57UtM62ymRwDCNKSZ
	yNpB1fj7VT91GxkEEfhueFMyAbZcTO3PehyOABkNlCQ7fYoJMcudT0rvveSjKbd/721L
	aGqTW5N/IsuOuJUU28Otp0uUTP7ZKyO1Fv6eBxJgdv9KARTGc7DqWnhXjxm9oYey1b0p
	qZ7Bt1Vpmk3Omsg+mA+UMvq/v8WBcsOHMSO/VV56CRFRF8KV8EP0X5mzAU389dzRdMre
	Vjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=qiiPM6Lpw8c2dEQtxX+Nb/J/c5fJDmZyk5OYGy8I6xw=;
	b=Q27b3um/S/JS+Jn/br4Xt8OgPqz2n/GV+E9JaAqWO508h20rbBb5kf3gRsP1aBs5UX
	vxYSQJQwhhbFQT1PPYXMG0TbqMYIKAa4D3oW/UCs93NTXY5NbDy5+mLSRf3BMu5UYRQO
	5ukGm6welfi2uncWRuU1VMR5l9tjrLt49Xw9dYDF4ylpEjp4x96v/xDwqOuEtYDKuq+k
	H+wJHoejg9pRxOfeEZNVTogjKoHv3dOiiF1Pt+wjaFxEfj6uIXyBqMfWk5P6zsMqSN3T
	j6D83OYh5w9m0G87/ByibRJ3Rxqzdlg6iHq1S5Nhicpiv0Gqd7p3kPWLecpamFYM4N/t
	IheQ==
X-Gm-Message-State: APjAAAWOMBkrdeuj09zMaUQAcigjowxukHgyQ440+NYoErm356Z6M2yL
	YoPlO7hk4ZgmshouCHaZ3Qkd48jXr9s=
X-Google-Smtp-Source: APXvYqwUA+zeh1KLO1S4261ojcyAjaWu8QJoju0z4rSKxlQSQ/iOK4G+55x7o/u3c/wmrRldxUy/Mw==
X-Received: by 2002:a17:902:b28:: with SMTP id
	37mr73531641plq.322.1556687150941; 
	Tue, 30 Apr 2019 22:05:50 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.49 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:13 -0700
Message-Id: <20190501050536.15580-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v2 06/29] tcg: Return bool success from
 tcg_out_mov
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
Message-ID: <20190501050513.gXdJ3pXtdmSx4UY-Foq9dEnLs0yALrOrCsDYW7mapN8@z>

This patch merely changes the interface, aborting on all failures,
of which there are currently none.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
index eefa929948..ee89734318 100644
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
index abf0c444b4..dab93f7872 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -2264,10 +2264,13 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
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
index d5ed9f1ffd..1198c76392 100644
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
index 412cacdcb9..7cafd4a790 100644
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
index 36b4791707..30c095d3d5 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -559,12 +559,13 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
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
index 2932505094..6497a4dab2 100644
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
index 3d6150b10e..331d51852c 100644
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
index 70ca113c26..8ed7cb8654 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -103,7 +103,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
                                            const char *ct_str, TCGType type);
 static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
                        intptr_t arg2);
-static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg);
 static void tcg_out_movi(TCGContext *s, TCGType type,
                          TCGReg ret, tcg_target_long arg);
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
@@ -3367,7 +3367,9 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
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
@@ -3467,7 +3469,9 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
@@ -3626,7 +3630,9 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
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


