Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5FCC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBF52070B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTUaQkn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBF52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Ure-0003G3-Cn
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR6-0000p6-RB
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR3-00078t-Ea
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:16 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:45505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UR3-00073S-6V
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:13 -0400
Received: by mail-yb1-xb41.google.com with SMTP id u32so1326322ybi.12
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b12E1NzLfXOoLi68dls/QS9gB062z+8UHoCI55OSbHE=;
 b=OTUaQkn9/4aXRg43zGkaqo+cAWT92rLyehPeJYx5HvjHLn4EsSMtJPAxMJaPR3891+
 LpsnrfFAkb3Fu5MRq4oZFwHLrpXj2rjdu7DKuZEY0ivr1ITlz28KO9dYVwaAhbF3K35V
 INH/vAt1IU+kRZViBsmE+lWI4m5Go775qp3vdj6NoTLb9WTlmzJvz0RXhUQRNOe6CCvH
 to9WeQqm/oR04artZ24p5gDRIxE5We3lCjTIzVeHBX/4ZwStzkcjpBtvcptG2iX5VHHa
 o+nRc02X9qrlbUhWWku51/eUVV+zumMW8bti7Do2LX+CgrZuDBV55Fy9GdqOJqehyexX
 MTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b12E1NzLfXOoLi68dls/QS9gB062z+8UHoCI55OSbHE=;
 b=pTVkr5rw7lbtwz5UqB4bkx2uPYJW8O8fzvGC+D332uXvHljW11WgI9COac27CsmFNV
 aYfY1jVygPTEkMttL+ZurLouzLf2vMBWj3//eDzURS39gt448aZ4oqaNV2XFpGXLDO3K
 wciyDH0b7eECNdi+uASyMo1qaV3+48f3b7LlmE0jpO+Pegy4a6irWc5HubuZEel8YGYz
 indv0X7nq7BPuR27sta3cKqWMucdVFPBsFw9JkAr7lNCiKQ7csjh/TG1sjicUPs6h0hT
 j+sDvOFp6YFtsUu7AYPEIA4S4fvSMPrrYlOe38YhUMsaNMfprXdKEhcxyP5LI5pu3YAC
 aLmw==
X-Gm-Message-State: APjAAAV0Guqhi9GXblmgpgN0DDd1B4jURXZMABq8SY4tUvfv38ifnZJr
 eDSGbH+YJ/imcdwgZiYHQPsiorHl
X-Google-Smtp-Source: APXvYqxbfhCnwOdniI2JEnCv089djytI3PD6TpqRvmiJ6axNj06rRRmFVUQEg4WcxmhuFdl+G0ZQXg==
X-Received: by 2002:a25:888a:: with SMTP id d10mr24838321ybl.308.1566408608553; 
 Wed, 21 Aug 2019 10:30:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:07 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:43 -0400
Message-Id: <20190821172951.15333-8-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v4 07/75] target/i386: use pc_start from
 DisasContext
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The variable pc_start is already a member of DisasContext. Remove the
superfluous local variable.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 131 ++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 66 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index b067323962..62cce20735 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4664,9 +4664,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     TCGMemOp ot;
     int modrm, reg, rm, mod, op, opreg, val;
     target_ulong next_eip, tval;
-    target_ulong pc_start = s->base.pc_next;
 
-    s->pc_start = s->pc = pc_start;
+    s->pc_start = s->pc = s->base.pc_next;
     if (sigsetjmp(s->jmpbuf, 0) != 0) {
         gen_exception(s, EXCP0D_GPF);
         return s->pc;
@@ -6371,7 +6370,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xa5:
         ot = mo_b_d(b, s->dflag);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_movs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_repz_movs(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_movs(s, ot);
         }
@@ -6381,7 +6380,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xab:
         ot = mo_b_d(b, s->dflag);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_stos(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_repz_stos(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_stos(s, ot);
         }
@@ -6390,7 +6389,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xad:
         ot = mo_b_d(b, s->dflag);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_lods(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_repz_lods(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_lods(s, ot);
         }
@@ -6399,9 +6398,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xaf:
         ot = mo_b_d(b, s->dflag);
         if (s->prefix & PREFIX_REPNZ) {
-            gen_repz_scas(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 1);
+            gen_repz_scas(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base, 1);
         } else if (s->prefix & PREFIX_REPZ) {
-            gen_repz_scas(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 0);
+            gen_repz_scas(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base, 0);
         } else {
             gen_scas(s, ot);
         }
@@ -6411,9 +6410,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xa7:
         ot = mo_b_d(b, s->dflag);
         if (s->prefix & PREFIX_REPNZ) {
-            gen_repz_cmps(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 1);
+            gen_repz_cmps(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base, 1);
         } else if (s->prefix & PREFIX_REPZ) {
-            gen_repz_cmps(s, ot, pc_start - s->cs_base, s->pc - s->cs_base, 0);
+            gen_repz_cmps(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base, 0);
         } else {
             gen_cmps(s, ot);
         }
@@ -6422,10 +6421,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x6d:
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
-        gen_check_io(s, ot, pc_start - s->cs_base, 
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(s->prefix) | 4);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_ins(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_repz_ins(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_ins(s, ot);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -6437,10 +6436,10 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x6f:
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
-        gen_check_io(s, ot, pc_start - s->cs_base,
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      svm_is_rep(s->prefix) | 4);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-            gen_repz_outs(s, ot, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_repz_outs(s, ot, s->pc_start - s->cs_base, s->pc - s->cs_base);
         } else {
             gen_outs(s, ot);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
@@ -6457,7 +6456,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         ot = mo_b_d32(b, s->dflag);
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
-        gen_check_io(s, ot, pc_start - s->cs_base,
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(s->prefix));
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
@@ -6475,7 +6474,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         ot = mo_b_d32(b, s->dflag);
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T0, val);
-        gen_check_io(s, ot, pc_start - s->cs_base,
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      svm_is_rep(s->prefix));
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
 
@@ -6494,7 +6493,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xed:
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
-        gen_check_io(s, ot, pc_start - s->cs_base,
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      SVM_IOIO_TYPE_MASK | svm_is_rep(s->prefix));
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
@@ -6511,7 +6510,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0xef:
         ot = mo_b_d32(b, s->dflag);
         tcg_gen_ext16u_tl(s->T0, cpu_regs[R_EDX]);
-        gen_check_io(s, ot, pc_start - s->cs_base,
+        gen_check_io(s, ot, s->pc_start - s->cs_base,
                      svm_is_rep(s->prefix));
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
 
@@ -6551,7 +6550,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     do_lret:
         if (s->pe && !s->vm86) {
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_lret_protected(cpu_env, tcg_const_i32(s->dflag - 1),
                                       tcg_const_i32(val));
         } else {
@@ -6574,7 +6573,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         val = 0;
         goto do_lret;
     case 0xcf: /* iret */
-        gen_svm_check_intercept(s, pc_start, SVM_EXIT_IRET);
+        gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_IRET);
         if (!s->pe) {
             /* real mode */
             gen_helper_iret_real(cpu_env, tcg_const_i32(s->dflag - 1));
@@ -6701,7 +6700,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         /************************/
         /* flags */
     case 0x9c: /* pushf */
-        gen_svm_check_intercept(s, pc_start, SVM_EXIT_PUSHF);
+        gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_PUSHF);
         if (s->vm86 && s->iopl != 3) {
             gen_exception(s, EXCP0D_GPF);
         } else {
@@ -6711,7 +6710,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0x9d: /* popf */
-        gen_svm_check_intercept(s, pc_start, SVM_EXIT_POPF);
+        gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_POPF);
         if (s->vm86 && s->iopl != 3) {
             gen_exception(s, EXCP0D_GPF);
         } else {
@@ -7056,8 +7055,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         if (s->prefix & PREFIX_REPZ) {
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
-            gen_helper_pause(cpu_env, tcg_const_i32(s->pc - pc_start));
+            gen_jmp_im(s, s->pc_start - s->cs_base);
+            gen_helper_pause(cpu_env, tcg_const_i32(s->pc - s->pc_start));
             s->base.is_jmp = DISAS_NORETURN;
         }
         break;
@@ -7070,27 +7069,27 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
     case 0xcc: /* int3 */
-        gen_interrupt(s, EXCP03_INT3, pc_start - s->cs_base, s->pc - s->cs_base);
+        gen_interrupt(s, EXCP03_INT3, s->pc_start - s->cs_base, s->pc - s->cs_base);
         break;
     case 0xcd: /* int N */
         val = x86_ldub_code(env, s);
         if (s->vm86 && s->iopl != 3) {
             gen_exception(s, EXCP0D_GPF);
         } else {
-            gen_interrupt(s, val, pc_start - s->cs_base, s->pc - s->cs_base);
+            gen_interrupt(s, val, s->pc_start - s->cs_base, s->pc - s->cs_base);
         }
         break;
     case 0xce: /* into */
         if (CODE64(s))
             goto illegal_op;
         gen_update_cc_op(s);
-        gen_jmp_im(s, pc_start - s->cs_base);
-        gen_helper_into(cpu_env, tcg_const_i32(s->pc - pc_start));
+        gen_jmp_im(s, s->pc_start - s->cs_base);
+        gen_helper_into(cpu_env, tcg_const_i32(s->pc - s->pc_start));
         break;
 #ifdef WANT_ICEBP
     case 0xf1: /* icebp (undocumented, exits to external debugger) */
-        gen_svm_check_intercept(s, pc_start, SVM_EXIT_ICEBP);
-        gen_debug(s, pc_start - s->cs_base);
+        gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_ICEBP);
+        gen_debug(s, s->pc_start - s->cs_base);
         break;
 #endif
     case 0xfa: /* cli */
@@ -7210,7 +7209,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_exception(s, EXCP0D_GPF);
         } else {
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             if (b & 2) {
                 gen_helper_rdmsr(cpu_env);
             } else {
@@ -7220,7 +7219,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x131: /* rdtsc */
         gen_update_cc_op(s);
-        gen_jmp_im(s, pc_start - s->cs_base);
+        gen_jmp_im(s, s->pc_start - s->cs_base);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
@@ -7231,7 +7230,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x133: /* rdpmc */
         gen_update_cc_op(s);
-        gen_jmp_im(s, pc_start - s->cs_base);
+        gen_jmp_im(s, s->pc_start - s->cs_base);
         gen_helper_rdpmc(cpu_env);
         break;
     case 0x134: /* sysenter */
@@ -7260,8 +7259,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x105: /* syscall */
         /* XXX: is it usable in real mode ? */
         gen_update_cc_op(s);
-        gen_jmp_im(s, pc_start - s->cs_base);
-        gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));
+        gen_jmp_im(s, s->pc_start - s->cs_base);
+        gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - s->pc_start));
         /* TF handling for the syscall insn is different. The TF bit is  checked
            after the syscall insn completes. This allows #DB to not be
            generated after one has entered CPL0 if TF is set in FMASK.  */
@@ -7286,7 +7285,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 #endif
     case 0x1a2: /* cpuid */
         gen_update_cc_op(s);
-        gen_jmp_im(s, pc_start - s->cs_base);
+        gen_jmp_im(s, s->pc_start - s->cs_base);
         gen_helper_cpuid(cpu_env);
         break;
     case 0xf4: /* hlt */
@@ -7294,8 +7293,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_exception(s, EXCP0D_GPF);
         } else {
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
-            gen_helper_hlt(cpu_env, tcg_const_i32(s->pc - pc_start));
+            gen_jmp_im(s, s->pc_start - s->cs_base);
+            gen_helper_hlt(cpu_env, tcg_const_i32(s->pc - s->pc_start));
             s->base.is_jmp = DISAS_NORETURN;
         }
         break;
@@ -7307,7 +7306,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         case 0: /* sldt */
             if (!s->pe || s->vm86)
                 goto illegal_op;
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_READ);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_LDTR_READ);
             tcg_gen_ld32u_tl(s->T0, cpu_env,
                              offsetof(CPUX86State, ldt.selector));
             ot = mod == 3 ? s->dflag : MO_16;
@@ -7319,7 +7318,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (s->cpl != 0) {
                 gen_exception(s, EXCP0D_GPF);
             } else {
-                gen_svm_check_intercept(s, pc_start, SVM_EXIT_LDTR_WRITE);
+                gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_LDTR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_lldt(cpu_env, s->tmp2_i32);
@@ -7328,7 +7327,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         case 1: /* str */
             if (!s->pe || s->vm86)
                 goto illegal_op;
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_READ);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_TR_READ);
             tcg_gen_ld32u_tl(s->T0, cpu_env,
                              offsetof(CPUX86State, tr.selector));
             ot = mod == 3 ? s->dflag : MO_16;
@@ -7340,7 +7339,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (s->cpl != 0) {
                 gen_exception(s, EXCP0D_GPF);
             } else {
-                gen_svm_check_intercept(s, pc_start, SVM_EXIT_TR_WRITE);
+                gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_TR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_ltr(cpu_env, s->tmp2_i32);
@@ -7368,7 +7367,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         modrm = x86_ldub_code(env, s);
         switch (modrm) {
         CASE_MODRM_MEM_OP(0): /* sgdt */
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_GDTR_READ);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_GDTR_READ);
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(s->T0,
                              cpu_env, offsetof(CPUX86State, gdt.limit));
@@ -7386,7 +7385,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             tcg_gen_mov_tl(s->A0, cpu_regs[R_EAX]);
             gen_extu(s->aflag, s->A0);
             gen_add_A0_ds_seg(s);
@@ -7398,8 +7397,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
-            gen_helper_mwait(cpu_env, tcg_const_i32(s->pc - pc_start));
+            gen_jmp_im(s, s->pc_start - s->cs_base);
+            gen_helper_mwait(cpu_env, tcg_const_i32(s->pc - s->pc_start));
             gen_eob(s);
             break;
 
@@ -7424,7 +7423,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
 
         CASE_MODRM_MEM_OP(1): /* sidt */
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_READ);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_IDTR_READ);
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(s->T0, cpu_env, offsetof(CPUX86State, idt.limit));
             gen_op_st_v(s, MO_16, s->T0, s->A0);
@@ -7475,9 +7474,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_vmrun(cpu_env, tcg_const_i32(s->aflag - 1),
-                             tcg_const_i32(s->pc - pc_start));
+                             tcg_const_i32(s->pc - s->pc_start));
             tcg_gen_exit_tb(NULL, 0);
             s->base.is_jmp = DISAS_NORETURN;
             break;
@@ -7487,7 +7486,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_vmmcall(cpu_env);
             break;
 
@@ -7500,7 +7499,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_vmload(cpu_env, tcg_const_i32(s->aflag - 1));
             break;
 
@@ -7513,7 +7512,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_vmsave(cpu_env, tcg_const_i32(s->aflag - 1));
             break;
 
@@ -7542,7 +7541,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_clgi(cpu_env);
             break;
 
@@ -7553,7 +7552,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_skinit(cpu_env);
             break;
 
@@ -7566,7 +7565,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_helper_invlpga(cpu_env, tcg_const_i32(s->aflag - 1));
             break;
 
@@ -7575,7 +7574,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_exception(s, EXCP0D_GPF);
                 break;
             }
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_GDTR_WRITE);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_GDTR_WRITE);
             gen_lea_modrm(env, s, modrm);
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
@@ -7592,7 +7591,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_exception(s, EXCP0D_GPF);
                 break;
             }
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_IDTR_WRITE);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_IDTR_WRITE);
             gen_lea_modrm(env, s, modrm);
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
@@ -7605,7 +7604,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             break;
 
         CASE_MODRM_OP(4): /* smsw */
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_CR0);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_READ_CR0);
             tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, cr[0]));
             if (CODE64(s)) {
                 mod = (modrm >> 6) & 3;
@@ -7637,7 +7636,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 gen_exception(s, EXCP0D_GPF);
                 break;
             }
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_WRITE_CR0);
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
             gen_helper_lmsw(cpu_env, s->T0);
             gen_jmp_im(s, s->pc - s->cs_base);
@@ -7650,7 +7649,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             gen_lea_modrm(env, s, modrm);
             gen_helper_invlpg(cpu_env, s->A0);
             gen_jmp_im(s, s->pc - s->cs_base);
@@ -7679,7 +7678,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(s, pc_start - s->cs_base);
+            gen_jmp_im(s, s->pc_start - s->cs_base);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                 gen_io_start();
             }
@@ -7699,7 +7698,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->cpl != 0) {
             gen_exception(s, EXCP0D_GPF);
         } else {
-            gen_svm_check_intercept(s, pc_start, (b & 2) ? SVM_EXIT_INVD : SVM_EXIT_WBINVD);
+            gen_svm_check_intercept(s, s->pc_start, (b & 2) ? SVM_EXIT_INVD : SVM_EXIT_WBINVD);
             /* nothing to do */
         }
         break;
@@ -8046,7 +8045,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             case 4:
             case 8:
                 gen_update_cc_op(s);
-                gen_jmp_im(s, pc_start - s->cs_base);
+                gen_jmp_im(s, s->pc_start - s->cs_base);
                 if (b & 2) {
                     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
                         gen_io_start();
@@ -8093,14 +8092,14 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 goto illegal_op;
             }
             if (b & 2) {
-                gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_DR0 + reg);
+                gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_WRITE_DR0 + reg);
                 gen_op_mov_v_reg(s, ot, s->T0, rm);
                 tcg_gen_movi_i32(s->tmp2_i32, reg);
                 gen_helper_set_dr(cpu_env, s->tmp2_i32, s->T0);
                 gen_jmp_im(s, s->pc - s->cs_base);
                 gen_eob(s);
             } else {
-                gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_DR0 + reg);
+                gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_READ_DR0 + reg);
                 tcg_gen_movi_i32(s->tmp2_i32, reg);
                 gen_helper_get_dr(s->T0, cpu_env, s->tmp2_i32);
                 gen_op_mov_reg_v(s, ot, rm, s->T0);
@@ -8111,7 +8110,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         if (s->cpl != 0) {
             gen_exception(s, EXCP0D_GPF);
         } else {
-            gen_svm_check_intercept(s, pc_start, SVM_EXIT_WRITE_CR0);
+            gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_WRITE_CR0);
             gen_helper_clts(cpu_env);
             /* abort block because static cpu state changed */
             gen_jmp_im(s, s->pc - s->cs_base);
@@ -8337,7 +8336,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_nop_modrm(env, s, modrm);
         break;
     case 0x1aa: /* rsm */
-        gen_svm_check_intercept(s, pc_start, SVM_EXIT_RSM);
+        gen_svm_check_intercept(s, s->pc_start, SVM_EXIT_RSM);
         if (!(s->flags & HF_SMM_MASK))
             goto illegal_op;
         gen_update_cc_op(s);
-- 
2.20.1


