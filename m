Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BDEC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5916E2089C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5916E2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiN7O-000267-DE
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50487)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiLlQ-0003AJ-Te
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiLlL-0000Ue-R9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:36:16 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59851 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hiLlH-0007q1-UR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:36:09 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id F089E1A224D;
 Tue,  2 Jul 2019 18:35:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id A150C1A21AB;
 Tue,  2 Jul 2019 18:35:33 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 18:35:25 +0200
Message-Id: <1562085328-5126-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562085328-5126-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1562085328-5126-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 09/12] target/mips: Correct comments in
 translate.c
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix some checkpatch comment-related warnings.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1562068213-11307-5-git-send-email-aleksandar.markovic@rt-rk.=
com>
---
 target/mips/translate.c | 497 ++++++++++++++++++++++++++++++------------=
------
 1 file changed, 314 insertions(+), 183 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e3a0f08..f96f141 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -259,8 +259,10 @@ enum {
     OPC_SPECIAL3D_RESERVED =3D 0x3D | OPC_SPECIAL,
 };
=20
-/* R6 Multiply and Divide instructions have the same Opcode
-   and function field as legacy OPC_MULT[U]/OPC_DIV[U] */
+/*
+ * R6 Multiply and Divide instructions have the same opcode
+ * and function field as legacy OPC_MULT[U]/OPC_DIV[U]
+ */
 #define MASK_R6_MULDIV(op)   (MASK_SPECIAL(op) | (op & (0x7ff)))
=20
 enum {
@@ -2923,10 +2925,11 @@ static inline void check_cp1_enabled(DisasContext=
 *ctx)
     }
 }
=20
-/* Verify that the processor is running with COP1X instructions enabled.
-   This is associated with the nabla symbol in the MIPS32 and MIPS64
-   opcode tables.  */
-
+/*
+ * Verify that the processor is running with COP1X instructions enabled.
+ * This is associated with the nabla symbol in the MIPS32 and MIPS64
+ * opcode tables.
+ */
 static inline void check_cop1x(DisasContext *ctx)
 {
     if (unlikely(!(ctx->hflags & MIPS_HFLAG_COP1X))) {
@@ -2934,9 +2937,10 @@ static inline void check_cop1x(DisasContext *ctx)
     }
 }
=20
-/* Verify that the processor is running with 64-bit floating-point
-   operations enabled.  */
-
+/*
+ * Verify that the processor is running with 64-bit floating-point
+ * operations enabled.
+ */
 static inline void check_cp1_64bitmode(DisasContext *ctx)
 {
     if (unlikely(~ctx->hflags & (MIPS_HFLAG_F64 | MIPS_HFLAG_COP1X))) {
@@ -2962,10 +2966,10 @@ static inline void check_cp1_registers(DisasConte=
xt *ctx, int regs)
     }
 }
=20
-/* Verify that the processor is running with DSP instructions enabled.
-   This is enabled by CP0 Status register MX(24) bit.
+/*
+ * Verify that the processor is running with DSP instructions enabled.
+ * This is enabled by CP0 Status register MX(24) bit.
  */
-
 static inline void check_dsp(DisasContext *ctx)
 {
     if (unlikely(!(ctx->hflags & MIPS_HFLAG_DSP))) {
@@ -2999,8 +3003,10 @@ static inline void check_dsp_r3(DisasContext *ctx)
     }
 }
=20
-/* This code generates a "reserved instruction" exception if the
-   CPU does not support the instruction set corresponding to flags. */
+/*
+ * This code generates a "reserved instruction" exception if the
+ * CPU does not support the instruction set corresponding to flags.
+ */
 static inline void check_insn(DisasContext *ctx, uint64_t flags)
 {
     if (unlikely(!(ctx->insn_flags & flags))) {
@@ -3008,9 +3014,11 @@ static inline void check_insn(DisasContext *ctx, u=
int64_t flags)
     }
 }
=20
-/* This code generates a "reserved instruction" exception if the
-   CPU has corresponding flag set which indicates that the instruction
-   has been removed. */
+/*
+ * This code generates a "reserved instruction" exception if the
+ * CPU has corresponding flag set which indicates that the instruction
+ * has been removed.
+ */
 static inline void check_insn_opc_removed(DisasContext *ctx, uint64_t fl=
ags)
 {
     if (unlikely(ctx->insn_flags & flags)) {
@@ -3033,8 +3041,10 @@ static inline void check_insn_opc_user_only(DisasC=
ontext *ctx, uint64_t flags)
 #endif
 }
=20
-/* This code generates a "reserved instruction" exception if the
-   CPU does not support 64-bit paired-single (PS) floating point data ty=
pe */
+/*
+ * This code generates a "reserved instruction" exception if the
+ * CPU does not support 64-bit paired-single (PS) floating point data ty=
pe.
+ */
 static inline void check_ps(DisasContext *ctx)
 {
     if (unlikely(!ctx->ps)) {
@@ -3044,8 +3054,10 @@ static inline void check_ps(DisasContext *ctx)
 }
=20
 #ifdef TARGET_MIPS64
-/* This code generates a "reserved instruction" exception if 64-bit
-   instructions are not enabled. */
+/*
+ * This code generates a "reserved instruction" exception if 64-bit
+ * instructions are not enabled.
+ */
 static inline void check_mips_64(DisasContext *ctx)
 {
     if (unlikely(!(ctx->hflags & MIPS_HFLAG_64))) {
@@ -3157,10 +3169,12 @@ static inline void check_eva(DisasContext *ctx)
 }
=20
=20
-/* Define small wrappers for gen_load_fpr* so that we have a uniform
-   calling interface for 32 and 64-bit FPRs.  No sense in changing
-   all callers for gen_load_fpr32 when we need the CTX parameter for
-   this one use.  */
+/*
+ * Define small wrappers for gen_load_fpr* so that we have a uniform
+ * calling interface for 32 and 64-bit FPRs.  No sense in changing
+ * all callers for gen_load_fpr32 when we need the CTX parameter for
+ * this one use.
+ */
 #define gen_ldcmp_fpr32(ctx, x, y) gen_load_fpr32(ctx, x, y)
 #define gen_ldcmp_fpr64(ctx, x, y) gen_load_fpr64(ctx, x, y)
 #define FOP_CONDS(type, abs, fmt, ifmt, bits)                           =
      \
@@ -3405,9 +3419,11 @@ static void gen_ld(DisasContext *ctx, uint32_t opc=
,
     int mem_idx =3D ctx->mem_idx;
=20
     if (rt =3D=3D 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSO=
N2F)) {
-        /* Loongson CPU uses a load to zero register for prefetch.
-           We emulate it as a NOP. On other CPU we must perform the
-           actual memory access. */
+        /*
+         * Loongson CPU uses a load to zero register for prefetch.
+         * We emulate it as a NOP. On other CPU we must perform the
+         * actual memory access.
+         */
         return;
     }
=20
@@ -3433,8 +3449,10 @@ static void gen_ld(DisasContext *ctx, uint32_t opc=
,
         break;
     case OPC_LDL:
         t1 =3D tcg_temp_new();
-        /* Do a byte access to possibly trigger a page
-           fault with the unaligned address.  */
+        /*
+         * Do a byte access to possibly trigger a page
+         * fault with the unaligned address.
+         */
         tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
         tcg_gen_andi_tl(t1, t0, 7);
 #ifndef TARGET_WORDS_BIGENDIAN
@@ -3455,8 +3473,10 @@ static void gen_ld(DisasContext *ctx, uint32_t opc=
,
         break;
     case OPC_LDR:
         t1 =3D tcg_temp_new();
-        /* Do a byte access to possibly trigger a page
-           fault with the unaligned address.  */
+        /*
+         * Do a byte access to possibly trigger a page
+         * fault with the unaligned address.
+         */
         tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
         tcg_gen_andi_tl(t1, t0, 7);
 #ifdef TARGET_WORDS_BIGENDIAN
@@ -3534,8 +3554,10 @@ static void gen_ld(DisasContext *ctx, uint32_t opc=
,
         /* fall through */
     case OPC_LWL:
         t1 =3D tcg_temp_new();
-        /* Do a byte access to possibly trigger a page
-           fault with the unaligned address.  */
+        /*
+         * Do a byte access to possibly trigger a page
+         * fault with the unaligned address.
+         */
         tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
         tcg_gen_andi_tl(t1, t0, 3);
 #ifndef TARGET_WORDS_BIGENDIAN
@@ -3560,8 +3582,10 @@ static void gen_ld(DisasContext *ctx, uint32_t opc=
,
         /* fall through */
     case OPC_LWR:
         t1 =3D tcg_temp_new();
-        /* Do a byte access to possibly trigger a page
-           fault with the unaligned address.  */
+        /*
+         * Do a byte access to possibly trigger a page
+         * fault with the unaligned address.
+         */
         tcg_gen_qemu_ld_tl(t1, t0, mem_idx, MO_UB);
         tcg_gen_andi_tl(t1, t0, 3);
 #ifdef TARGET_WORDS_BIGENDIAN
@@ -3762,8 +3786,10 @@ static void gen_scwp(DisasContext *ctx, uint32_t b=
ase, int16_t offset,
 static void gen_flt_ldst(DisasContext *ctx, uint32_t opc, int ft,
                          TCGv t0)
 {
-    /* Don't do NOP if destination is zero: we must perform the actual
-       memory access. */
+    /*
+     * Don't do NOP if destination is zero: we must perform the actual
+     * memory access.
+     */
     switch (opc) {
     case OPC_LWC1:
         {
@@ -3837,8 +3863,10 @@ static void gen_arith_imm(DisasContext *ctx, uint3=
2_t opc,
     target_ulong uimm =3D (target_long)imm; /* Sign extend to 32/64 bits=
 */
=20
     if (rt =3D=3D 0 && opc !=3D OPC_ADDI && opc !=3D OPC_DADDI) {
-        /* If no destination, treat it as a NOP.
-           For addi, we must generate the overflow exception when needed=
. */
+        /*
+         * If no destination, treat it as a NOP.
+         * For addi, we must generate the overflow exception when needed=
.
+         */
         return;
     }
     switch (opc) {
@@ -4064,8 +4092,10 @@ static void gen_arith(DisasContext *ctx, uint32_t =
opc,
 {
     if (rd =3D=3D 0 && opc !=3D OPC_ADD && opc !=3D OPC_SUB
        && opc !=3D OPC_DADD && opc !=3D OPC_DSUB) {
-        /* If no destination, treat it as a NOP.
-           For add & sub, we must generate the overflow exception when n=
eeded. */
+        /*
+         * If no destination, treat it as a NOP.
+         * For add & sub, we must generate the overflow exception when n=
eeded.
+         */
         return;
     }
=20
@@ -4123,7 +4153,10 @@ static void gen_arith(DisasContext *ctx, uint32_t =
opc,
             tcg_temp_free(t2);
             tcg_gen_brcondi_tl(TCG_COND_GE, t1, 0, l1);
             tcg_temp_free(t1);
-            /* operands of different sign, first operand and result diff=
erent sign */
+            /*
+             * operands of different sign, first operand and the result
+             * of different sign
+             */
             generate_exception(ctx, EXCP_OVERFLOW);
             gen_set_label(l1);
             gen_store_gpr(t0, rd);
@@ -4346,8 +4379,10 @@ static void gen_shift(DisasContext *ctx, uint32_t =
opc,
     TCGv t0, t1;
=20
     if (rd =3D=3D 0) {
-        /* If no destination, treat it as a NOP.
-           For add & sub, we must generate the overflow exception when n=
eeded. */
+        /*
+         * If no destination, treat it as a NOP.
+         * For add & sub, we must generate the overflow exception when n=
eeded.
+         */
         return;
     }
=20
@@ -5643,8 +5678,10 @@ static void gen_loongson_multimedia(DisasContext *=
ctx, int rd, int rs, int rt)
             break;
         case OPC_SRA_CP2:
         case OPC_DSRA_CP2:
-            /* Since SRA is UndefinedResult without sign-extended inputs=
,
-               we can treat SRA and DSRA the same.  */
+            /*
+             * Since SRA is UndefinedResult without sign-extended inputs=
,
+             * we can treat SRA and DSRA the same.
+             */
             tcg_gen_sar_i64(t0, t0, t1);
             break;
         case OPC_SRL_CP2:
@@ -5720,8 +5757,10 @@ static void gen_loongson_multimedia(DisasContext *=
ctx, int rd, int rs, int rt)
     case OPC_SLT_CP2:
     case OPC_SLEU_CP2:
     case OPC_SLE_CP2:
-        /* ??? Document is unclear: Set FCC[CC].  Does that mean the
-           FD field is the CC field?  */
+        /*
+         * ??? Document is unclear: Set FCC[CC].  Does that mean the
+         * FD field is the CC field?
+         */
     default:
         MIPS_INVAL("loongson_cp2");
         generate_exception_end(ctx, EXCP_RI);
@@ -5935,8 +5974,10 @@ static void gen_compute_branch (DisasContext *ctx,=
 uint32_t opc,
     case OPC_JALR:
         /* Jump to register */
         if (offset !=3D 0 && offset !=3D 16) {
-            /* Hint =3D 0 is JR/JALR, hint 16 is JR.HB/JALR.HB, the
-               others are reserved. */
+            /*
+             * Hint =3D 0 is JR/JALR, hint 16 is JR.HB/JALR.HB, the
+             * others are reserved.
+             */
             MIPS_INVAL("jump hint");
             generate_exception_end(ctx, EXCP_RI);
             goto out;
@@ -5972,8 +6013,10 @@ static void gen_compute_branch (DisasContext *ctx,=
 uint32_t opc,
             /* Treat as NOP. */
             goto out;
         case OPC_BLTZAL:  /* 0 < 0           */
-            /* Handle as an unconditional branch to get correct delay
-               slot checking.  */
+            /*
+             * Handle as an unconditional branch to get correct delay
+             * slot checking.
+             */
             blink =3D 31;
             btgt =3D ctx->base.pc_next + insn_bytes + delayslot_size;
             ctx->hflags |=3D MIPS_HFLAG_B;
@@ -6151,8 +6194,10 @@ static void gen_compute_branch_nm(DisasContext *ct=
x, uint32_t opc,
     case OPC_JALR:
         /* Jump to register */
         if (offset !=3D 0 && offset !=3D 16) {
-            /* Hint =3D 0 is JR/JALR, hint 16 is JR.HB/JALR.HB, the
-               others are reserved. */
+            /*
+             * Hint =3D 0 is JR/JALR, hint 16 is JR.HB/JALR.HB, the
+             * others are reserved.
+             */
             MIPS_INVAL("jump hint");
             generate_exception_end(ctx, EXCP_RI);
             goto out;
@@ -6249,8 +6294,10 @@ static void gen_bitops(DisasContext *ctx, uint32_t=
 opc, int rt,
         if (msb !=3D 31) {
             tcg_gen_extract_tl(t0, t1, lsb, msb + 1);
         } else {
-            /* The two checks together imply that lsb =3D=3D 0,
-               so this is a simple sign-extension.  */
+            /*
+             * The two checks together imply that lsb =3D=3D 0,
+             * so this is a simple sign-extension.
+             */
             tcg_gen_ext32s_tl(t0, t1);
         }
         break;
@@ -6701,10 +6748,12 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
     case CP0_REGISTER_17:
         switch (sel) {
         case 0:
-            /* LLAddr is read-only (the only exception is bit 0 if LLB i=
s
-               supported); the CP0_LLAddr_rw_bitmask does not seem to be
-               relevant for modern MIPS cores supporting MTHC0, therefor=
e
-               treating MTHC0 to LLAddr as NOP. */
+            /*
+             * LLAddr is read-only (the only exception is bit 0 if LLB i=
s
+             * supported); the CP0_LLAddr_rw_bitmask does not seem to be
+             * relevant for modern MIPS cores supporting MTHC0, therefor=
e
+             * treating MTHC0 to LLAddr as NOP.
+             */
             register_name =3D "LLAddr";
             break;
         case 1:
@@ -6928,7 +6977,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, i=
nt reg, int sel)
             register_name =3D "Context";
             break;
         case 1:
-//            gen_helper_mfc0_contextconfig(arg); /* SmartMIPS ASE */
+            /* gen_helper_mfc0_contextconfig(arg); - SmartMIPS ASE */
             register_name =3D "ContextConfig";
             goto cp0_unimplemented;
         case 2:
@@ -7079,9 +7128,11 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
             if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
                 gen_io_end();
             }
-            /* Break the TB to be able to take timer interrupts immediat=
ely
-               after reading count. DISAS_STOP isn't sufficient, we need=
 to
-               ensure we break completely out of translated code.  */
+            /*
+             * Break the TB to be able to take timer interrupts immediat=
ely
+             * after reading count. DISAS_STOP isn't sufficient, we need=
 to
+             * ensure we break completely out of translated code.
+             */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp =3D DISAS_EXIT;
             register_name =3D "Count";
@@ -7361,31 +7412,31 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
             register_name =3D "Performance0";
             break;
         case 1:
-//            gen_helper_mfc0_performance1(arg);
+            /* gen_helper_mfc0_performance1(arg); */
             register_name =3D "Performance1";
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_mfc0_performance2(arg);
+            /* gen_helper_mfc0_performance2(arg); */
             register_name =3D "Performance2";
             goto cp0_unimplemented;
         case 3:
-//            gen_helper_mfc0_performance3(arg);
+            /* gen_helper_mfc0_performance3(arg); */
             register_name =3D "Performance3";
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_mfc0_performance4(arg);
+            /* gen_helper_mfc0_performance4(arg); */
             register_name =3D "Performance4";
             goto cp0_unimplemented;
         case 5:
-//            gen_helper_mfc0_performance5(arg);
+            /* gen_helper_mfc0_performance5(arg); */
             register_name =3D "Performance5";
             goto cp0_unimplemented;
         case 6:
-//            gen_helper_mfc0_performance6(arg);
+            /* gen_helper_mfc0_performance6(arg); */
             register_name =3D "Performance6";
             goto cp0_unimplemented;
         case 7:
-//            gen_helper_mfc0_performance7(arg);
+            /* gen_helper_mfc0_performance7(arg); */
             register_name =3D "Performance7";
             goto cp0_unimplemented;
         default:
@@ -7877,9 +7928,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
         case 0:
             save_cpu_state(ctx, 1);
             gen_helper_mtc0_cause(cpu_env, arg);
-            /* Stop translation as we may have triggered an interrupt.
+            /*
+             * Stop translation as we may have triggered an interrupt.
              * DISAS_STOP isn't sufficient, we need to ensure we break o=
ut of
-             * translated code to check for pending interrupts.  */
+             * translated code to check for pending interrupts.
+             */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp =3D DISAS_EXIT;
             register_name =3D "Cause";
@@ -8104,31 +8157,31 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
             register_name =3D "Performance0";
             break;
         case 1:
-//            gen_helper_mtc0_performance1(arg);
+            /* gen_helper_mtc0_performance1(arg); */
             register_name =3D "Performance1";
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_mtc0_performance2(arg);
+            /* gen_helper_mtc0_performance2(arg); */
             register_name =3D "Performance2";
             goto cp0_unimplemented;
         case 3:
-//            gen_helper_mtc0_performance3(arg);
+            /* gen_helper_mtc0_performance3(arg); */
             register_name =3D "Performance3";
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_mtc0_performance4(arg);
+            /* gen_helper_mtc0_performance4(arg); */
             register_name =3D "Performance4";
             goto cp0_unimplemented;
         case 5:
-//            gen_helper_mtc0_performance5(arg);
+            /* gen_helper_mtc0_performance5(arg); */
             register_name =3D "Performance5";
             goto cp0_unimplemented;
         case 6:
-//            gen_helper_mtc0_performance6(arg);
+            /* gen_helper_mtc0_performance6(arg); */
             register_name =3D "Performance6";
             goto cp0_unimplemented;
         case 7:
-//            gen_helper_mtc0_performance7(arg);
+            /* gen_helper_mtc0_performance7(arg); */
             register_name =3D "Performance7";
             goto cp0_unimplemented;
         default:
@@ -8240,8 +8293,10 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
     /* For simplicity assume that all writes can cause interrupts.  */
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
-        /* DISAS_STOP isn't sufficient, we need to ensure we break out o=
f
-         * translated code to check for pending interrupts.  */
+        /*
+         * DISAS_STOP isn't sufficient, we need to ensure we break out o=
f
+         * translated code to check for pending interrupts.
+         */
         gen_save_pc(ctx->base.pc_next + 4);
         ctx->base.is_jmp =3D DISAS_EXIT;
     }
@@ -8551,9 +8606,11 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
             if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
                 gen_io_end();
             }
-            /* Break the TB to be able to take timer interrupts immediat=
ely
-               after reading count. DISAS_STOP isn't sufficient, we need=
 to
-               ensure we break completely out of translated code.  */
+            /*
+             * Break the TB to be able to take timer interrupts immediat=
ely
+             * after reading count. DISAS_STOP isn't sufficient, we need=
 to
+             * ensure we break completely out of translated code.
+             */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp =3D DISAS_EXIT;
             register_name =3D "Count";
@@ -8825,31 +8882,31 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
             register_name =3D "Performance0";
             break;
         case 1:
-//            gen_helper_dmfc0_performance1(arg);
+            /* gen_helper_dmfc0_performance1(arg); */
             register_name =3D "Performance1";
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_dmfc0_performance2(arg);
+            /* gen_helper_dmfc0_performance2(arg); */
             register_name =3D "Performance2";
             goto cp0_unimplemented;
         case 3:
-//            gen_helper_dmfc0_performance3(arg);
+            /* gen_helper_dmfc0_performance3(arg); */
             register_name =3D "Performance3";
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_dmfc0_performance4(arg);
+            /* gen_helper_dmfc0_performance4(arg); */
             register_name =3D "Performance4";
             goto cp0_unimplemented;
         case 5:
-//            gen_helper_dmfc0_performance5(arg);
+            /* gen_helper_dmfc0_performance5(arg); */
             register_name =3D "Performance5";
             goto cp0_unimplemented;
         case 6:
-//            gen_helper_dmfc0_performance6(arg);
+            /* gen_helper_dmfc0_performance6(arg); */
             register_name =3D "Performance6";
             goto cp0_unimplemented;
         case 7:
-//            gen_helper_dmfc0_performance7(arg);
+            /* gen_helper_dmfc0_performance7(arg); */
             register_name =3D "Performance7";
             goto cp0_unimplemented;
         default:
@@ -9336,9 +9393,11 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
         case 0:
             save_cpu_state(ctx, 1);
             gen_helper_mtc0_cause(cpu_env, arg);
-            /* Stop translation as we may have triggered an interrupt.
+            /*
+             * Stop translation as we may have triggered an interrupt.
              * DISAS_STOP isn't sufficient, we need to ensure we break o=
ut of
-             * translated code to check for pending interrupts.  */
+             * translated code to check for pending interrupts.
+             */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp =3D DISAS_EXIT;
             register_name =3D "Cause";
@@ -9550,31 +9609,31 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
             register_name =3D "Performance0";
             break;
         case 1:
-//            gen_helper_mtc0_performance1(cpu_env, arg);
+            /* gen_helper_mtc0_performance1(cpu_env, arg); */
             register_name =3D "Performance1";
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_mtc0_performance2(cpu_env, arg);
+            /* gen_helper_mtc0_performance2(cpu_env, arg); */
             register_name =3D "Performance2";
             goto cp0_unimplemented;
         case 3:
-//            gen_helper_mtc0_performance3(cpu_env, arg);
+            /* gen_helper_mtc0_performance3(cpu_env, arg); */
             register_name =3D "Performance3";
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_mtc0_performance4(cpu_env, arg);
+            /* gen_helper_mtc0_performance4(cpu_env, arg); */
             register_name =3D "Performance4";
             goto cp0_unimplemented;
         case 5:
-//            gen_helper_mtc0_performance5(cpu_env, arg);
+            /* gen_helper_mtc0_performance5(cpu_env, arg); */
             register_name =3D "Performance5";
             goto cp0_unimplemented;
         case 6:
-//            gen_helper_mtc0_performance6(cpu_env, arg);
+            /* gen_helper_mtc0_performance6(cpu_env, arg); */
             register_name =3D "Performance6";
             goto cp0_unimplemented;
         case 7:
-//            gen_helper_mtc0_performance7(cpu_env, arg);
+            /* gen_helper_mtc0_performance7(cpu_env, arg); */
             register_name =3D "Performance7";
             goto cp0_unimplemented;
         default:
@@ -9686,8 +9745,10 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
     /* For simplicity assume that all writes can cause interrupts.  */
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
         gen_io_end();
-        /* DISAS_STOP isn't sufficient, we need to ensure we break out o=
f
-         * translated code to check for pending interrupts.  */
+        /*
+         * DISAS_STOP isn't sufficient, we need to ensure we break out o=
f
+         * translated code to check for pending interrupts.
+         */
         gen_save_pc(ctx->base.pc_next + 4);
         ctx->base.is_jmp =3D DISAS_EXIT;
     }
@@ -9933,10 +9994,12 @@ static void gen_mttr(CPUMIPSState *env, DisasCont=
ext *ctx, int rd, int rt,
     if ((env->CP0_VPEConf0 & (1 << CP0VPEC0_MVP)) =3D=3D 0 &&
         ((env->tcs[other_tc].CP0_TCBind & (0xf << CP0TCBd_CurVPE)) !=3D
          (env->active_tc.CP0_TCBind & (0xf << CP0TCBd_CurVPE)))) {
-        /* NOP */ ;
+        /* NOP */
+        ;
     } else if ((env->CP0_VPEControl & (0xff << CP0VPECo_TargTC)) >
              (env->mvp->CP0_MVPConf0 & (0xff << CP0MVPC0_PTC))) {
-        /* NOP */ ;
+        /* NOP */
+        ;
     } else if (u =3D=3D 0) {
         switch (rd) {
         case 1:
@@ -12389,8 +12452,10 @@ static void gen_flt3_ldst(DisasContext *ctx, uin=
t32_t opc,
     } else {
         gen_op_addr_add(ctx, t0, cpu_gpr[base], cpu_gpr[index]);
     }
-    /* Don't do NOP if destination is zero: we must perform the actual
-       memory access. */
+    /*
+     * Don't do NOP if destination is zero: we must perform the actual
+     * memory access.
+     */
     switch (opc) {
     case OPC_LWXC1:
         check_cop1x(ctx);
@@ -12718,8 +12783,10 @@ static void gen_rdhwr(DisasContext *ctx, int rt,=
 int rd, int sel)
     TCGv t0;
=20
 #if !defined(CONFIG_USER_ONLY)
-    /* The Linux kernel will emulate rdhwr if it's not supported nativel=
y.
-       Therefore only check the ISA in system mode.  */
+    /*
+     * The Linux kernel will emulate rdhwr if it's not supported nativel=
y.
+     * Therefore only check the ISA in system mode.
+     */
     check_insn(ctx, ISA_MIPS32R2);
 #endif
     t0 =3D tcg_temp_new();
@@ -12742,9 +12809,11 @@ static void gen_rdhwr(DisasContext *ctx, int rt,=
 int rd, int sel)
             gen_io_end();
         }
         gen_store_gpr(t0, rt);
-        /* Break the TB to be able to take timer interrupts immediately
-           after reading count. DISAS_STOP isn't sufficient, we need to =
ensure
-           we break completely out of translated code.  */
+        /*
+         * Break the TB to be able to take timer interrupts immediately
+         * after reading count. DISAS_STOP isn't sufficient, we need to =
ensure
+         * we break completely out of translated code.
+         */
         gen_save_pc(ctx->base.pc_next + 4);
         ctx->base.is_jmp =3D DISAS_EXIT;
         break;
@@ -12755,7 +12824,8 @@ static void gen_rdhwr(DisasContext *ctx, int rt, =
int rd, int sel)
     case 4:
         check_insn(ctx, ISA_MIPS32R6);
         if (sel !=3D 0) {
-            /* Performance counter registers are not implemented other t=
han
+            /*
+             * Performance counter registers are not implemented other t=
han
              * control register 0.
              */
             generate_exception(ctx, EXCP_RI);
@@ -12799,8 +12869,10 @@ static inline void clear_branch_hflags(DisasCont=
ext *ctx)
     if (ctx->base.is_jmp =3D=3D DISAS_NEXT) {
         save_cpu_state(ctx, 0);
     } else {
-        /* it is not safe to save ctx->hflags as hflags may be changed
-           in execution time by the instruction in delay / forbidden slo=
t. */
+        /*
+         * It is not safe to save ctx->hflags as hflags may be changed
+         * in execution time by the instruction in delay / forbidden slo=
t.
+         */
         tcg_gen_andi_i32(hflags, hflags, ~MIPS_HFLAG_BMASK);
     }
 }
@@ -13599,8 +13671,10 @@ static int decode_extended_mips16_opc(CPUMIPSSta=
te *env, DisasContext *ctx)
                               | ((ctx->opcode >> 21) & 0x3f) << 5
                               | (ctx->opcode & 0x1f));
=20
-    /* The extended opcodes cleverly reuse the opcodes from their 16-bit
-       counterparts.  */
+    /*
+     * The extended opcodes cleverly reuse the opcodes from their 16-bit
+     * counterparts.
+     */
     switch (op) {
     case M16_OPC_ADDIUSP:
         gen_arith_imm(ctx, OPC_ADDIU, rx, 29, imm);
@@ -14099,7 +14173,8 @@ static int decode_mips16_opc(CPUMIPSState *env, D=
isasContext *ctx)
             if (is_uhi(extract32(ctx->opcode, 5, 6))) {
                 gen_helper_do_semihosting(cpu_env);
             } else {
-                /* XXX: not clear which exception should be raised
+                /*
+                 * XXX: not clear which exception should be raised
                  *      when in debug mode...
                  */
                 check_insn(ctx, ISA_MIPS32);
@@ -14407,8 +14482,10 @@ enum {
 /* POOL32A encoding of minor opcode field */
=20
 enum {
-    /* These opcodes are distinguished only by bits 9..6; those bits are
-     * what are recorded below. */
+    /*
+     * These opcodes are distinguished only by bits 9..6; those bits are
+     * what are recorded below.
+     */
     SLL32 =3D 0x0,
     SRL32 =3D 0x1,
     SRA =3D 0x2,
@@ -15056,8 +15133,10 @@ static void gen_pool16c_insn(DisasContext *ctx)
         {
             int reg =3D ctx->opcode & 0x1f;
             gen_compute_branch(ctx, OPC_JR, 2, reg, 0, 0, 0);
-            /* Let normal delay slot handling in our caller take us
-               to the branch target.  */
+            /*
+             * Let normal delay slot handling in our caller take us
+             * to the branch target.
+             */
         }
         break;
     case JALR16 + 0:
@@ -15085,7 +15164,8 @@ static void gen_pool16c_insn(DisasContext *ctx)
         if (is_uhi(extract32(ctx->opcode, 0, 4))) {
             gen_helper_do_semihosting(cpu_env);
         } else {
-            /* XXX: not clear which exception should be raised
+            /*
+             * XXX: not clear which exception should be raised
              *      when in debug mode...
              */
             check_insn(ctx, ISA_MIPS32);
@@ -15098,8 +15178,10 @@ static void gen_pool16c_insn(DisasContext *ctx)
             int imm =3D ZIMM(ctx->opcode, 0, 5);
             gen_compute_branch(ctx, OPC_JR, 2, 31, 0, 0, 0);
             gen_arith_imm(ctx, OPC_ADDIU, 29, 29, imm << 2);
-            /* Let normal delay slot handling in our caller take us
-               to the branch target.  */
+            /*
+             * Let normal delay slot handling in our caller take us
+             * to the branch target.
+             */
         }
         break;
     default:
@@ -15595,8 +15677,10 @@ static void gen_pool32axf(CPUMIPSState *env, Dis=
asContext *ctx, int rt, int rs)
                 save_cpu_state(ctx, 1);
                 gen_helper_ei(t0, cpu_env);
                 gen_store_gpr(t0, rs);
-                /* DISAS_STOP isn't sufficient, we need to ensure we bre=
ak out
-                   of translated code to check for pending interrupts.  =
*/
+                /*
+                 * DISAS_STOP isn't sufficient, we need to ensure we bre=
ak out
+                 * of translated code to check for pending interrupts.
+                 */
                 gen_save_pc(ctx->base.pc_next + 4);
                 ctx->base.is_jmp =3D DISAS_EXIT;
                 tcg_temp_free(t0);
@@ -15676,9 +15760,10 @@ static void gen_pool32axf(CPUMIPSState *env, Dis=
asContext *ctx, int rt, int rs)
     }
 }
=20
-/* Values for microMIPS fmt field.  Variable-width, depending on which
-   formats the instruction supports.  */
-
+/*
+ * Values for microMIPS fmt field.  Variable-width, depending on which
+ * formats the instruction supports.
+ */
 enum {
     FMT_SD_S =3D 0,
     FMT_SD_D =3D 1,
@@ -16751,8 +16836,10 @@ static void decode_micromips32_opc(CPUMIPSState =
*env, DisasContext *ctx)
         case TNEI: /* SYNCI */
             if (ctx->insn_flags & ISA_MIPS32R6) {
                 /* SYNCI */
-                /* Break the TB to be able to sync copied instructions
-                   immediately */
+                /*
+                 * Break the TB to be able to sync copied instructions
+                 * immediately.
+                 */
                 ctx->base.is_jmp =3D DISAS_STOP;
             } else {
                 /* TNEI */
@@ -16772,9 +16859,11 @@ static void decode_micromips32_opc(CPUMIPSState =
*env, DisasContext *ctx)
             check_insn_opc_removed(ctx, ISA_MIPS32R6);
             gen_compute_branch(ctx, minor =3D=3D BNEZC ? OPC_BNE : OPC_B=
EQ,
                                4, rs, 0, imm << 1, 0);
-            /* Compact branches don't have a delay slot, so just let
-               the normal delay slot handling take us to the branch
-               target. */
+            /*
+             * Compact branches don't have a delay slot, so just let
+             * the normal delay slot handling take us to the branch
+             * target.
+             */
             break;
         case LUI:
             check_insn_opc_removed(ctx, ISA_MIPS32R6);
@@ -16782,8 +16871,10 @@ static void decode_micromips32_opc(CPUMIPSState =
*env, DisasContext *ctx)
             break;
         case SYNCI:
             check_insn_opc_removed(ctx, ISA_MIPS32R6);
-            /* Break the TB to be able to sync copied instructions
-               immediately */
+            /*
+             * Break the TB to be able to sync copied instructions
+             * immediately.
+             */
             ctx->base.is_jmp =3D DISAS_STOP;
             break;
         case BC2F:
@@ -17358,7 +17449,8 @@ static int decode_micromips_opc(CPUMIPSState *env=
, DisasContext *ctx)
                 break;
             }
             if (ctx->insn_flags & ISA_MIPS32R6) {
-                /* In the Release 6 the register number location in
+                /*
+                 * In the Release 6, the register number location in
                  * the instruction encoding has changed.
                  */
                 gen_arith(ctx, opc, rs1, rd, rs2);
@@ -21083,9 +21175,11 @@ static int decode_nanomips_32_48_opc(CPUMIPSStat=
e *env, DisasContext *ctx)
                 gen_p_lsx(ctx, rd, rs, rt);
                 break;
             case NM_LSA:
-                /* In nanoMIPS, the shift field directly encodes the shi=
ft
+                /*
+                 * In nanoMIPS, the shift field directly encodes the shi=
ft
                  * amount, meaning that the supported shift values are i=
n
-                 * the range 0 to 3 (instead of 1 to 4 in MIPSR6). */
+                 * the range 0 to 3 (instead of 1 to 4 in MIPSR6).
+                 */
                 gen_lsa(ctx, OPC_LSA, rd, rs, rt,
                         extract32(ctx->opcode, 9, 2) - 1);
                 break;
@@ -21440,8 +21534,10 @@ static int decode_nanomips_32_48_opc(CPUMIPSStat=
e *env, DisasContext *ctx)
             case NM_P_PREFU12:
                 if (rt =3D=3D 31) {
                     /* SYNCI */
-                    /* Break the TB to be able to sync copied instructio=
ns
-                       immediately */
+                    /*
+                     * Break the TB to be able to sync copied instructio=
ns
+                     * immediately.
+                     */
                     ctx->base.is_jmp =3D DISAS_STOP;
                 } else {
                     /* PREF */
@@ -21537,8 +21633,10 @@ static int decode_nanomips_32_48_opc(CPUMIPSStat=
e *env, DisasContext *ctx)
                 case NM_P_PREFS9:
                     if (rt =3D=3D 31) {
                         /* SYNCI */
-                        /* Break the TB to be able to sync copied instru=
ctions
-                           immediately */
+                        /*
+                         * Break the TB to be able to sync copied instru=
ctions
+                         * immediately.
+                         */
                         ctx->base.is_jmp =3D DISAS_STOP;
                     } else {
                         /* PREF */
@@ -21630,8 +21728,10 @@ static int decode_nanomips_32_48_opc(CPUMIPSStat=
e *env, DisasContext *ctx)
                         /* case NM_SYNCIE */
                         check_eva(ctx);
                         check_cp0_enabled(ctx);
-                        /* Break the TB to be able to sync copied instru=
ctions
-                           immediately */
+                        /*
+                         * Break the TB to be able to sync copied instru=
ctions
+                         * immediately.
+                         */
                         ctx->base.is_jmp =3D DISAS_STOP;
                     } else {
                         /* case NM_PREFE */
@@ -23026,8 +23126,10 @@ static void gen_mipsdsp_multiply(DisasContext *c=
tx, uint32_t op1, uint32_t op2,
     gen_load_gpr(v2_t, v2);
=20
     switch (op1) {
-    /* OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
-     * the same mask and op1. */
+    /*
+     * OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
+     * the same mask and op1.
+     */
     case OPC_MULT_G_2E:
         check_dsp_r2(ctx);
         switch (op2) {
@@ -23996,8 +24098,10 @@ static void decode_opc_special_r6(CPUMIPSState *=
env, DisasContext *ctx)
     case R6_OPC_CLO:
     case R6_OPC_CLZ:
         if (rt =3D=3D 0 && sa =3D=3D 1) {
-            /* Major opcode and function field is shared with preR6 MFHI=
/MTHI.
-               We need additionally to check other fields */
+            /*
+             * Major opcode and function field is shared with preR6 MFHI=
/MTHI.
+             * We need additionally to check other fields.
+             */
             gen_cl(ctx, op1, rd, rs);
         } else {
             generate_exception_end(ctx, EXCP_RI);
@@ -24022,8 +24126,10 @@ static void decode_opc_special_r6(CPUMIPSState *=
env, DisasContext *ctx)
     case R6_OPC_DCLO:
     case R6_OPC_DCLZ:
         if (rt =3D=3D 0 && sa =3D=3D 1) {
-            /* Major opcode and function field is shared with preR6 MFHI=
/MTHI.
-               We need additionally to check other fields */
+            /*
+             * Major opcode and function field is shared with preR6 MFHI=
/MTHI.
+             * We need additionally to check other fields.
+             */
             check_mips_64(ctx);
             gen_cl(ctx, op1, rd, rs);
         } else {
@@ -25939,7 +26045,7 @@ static void decode_opc_mxu__pool07(CPUMIPSState *=
env, DisasContext *ctx)
  *  |  SPECIAL2 |    rb   |x|        s12        |  XRa  |MXU__POOL08|
  *  +-----------+---------+-+-------------------+-------+-----------+
  *
-*/
+ */
 static void decode_opc_mxu__pool08(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opcode =3D extract32(ctx->opcode, 20, 1);
@@ -26835,7 +26941,8 @@ static void decode_opc_special2_legacy(CPUMIPSSta=
te *env, DisasContext *ctx)
         if (is_uhi(extract32(ctx->opcode, 6, 20))) {
             gen_helper_do_semihosting(cpu_env);
         } else {
-            /* XXX: not clear which exception should be raised
+            /*
+             * XXX: not clear which exception should be raised
              *      when in debug mode...
              */
             check_insn(ctx, ISA_MIPS32);
@@ -26977,8 +27084,10 @@ static void decode_opc_special3_legacy(CPUMIPSSt=
ate *env, DisasContext *ctx)
     case OPC_MODU_G_2E:
     case OPC_MULT_G_2E:
     case OPC_MULTU_G_2E:
-        /* OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
-         * the same mask and op1. */
+        /*
+         * OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
+         * the same mask and op1.
+         */
         if ((ctx->insn_flags & ASE_DSP_R2) && (op1 =3D=3D OPC_MULT_G_2E)=
) {
             op2 =3D MASK_ADDUH_QB(ctx->opcode);
             switch (op2) {
@@ -29165,8 +29274,10 @@ static void decode_opc(CPUMIPSState *env, DisasC=
ontext *ctx)
             break;
         case OPC_SYNCI:
             check_insn(ctx, ISA_MIPS32R2);
-            /* Break the TB to be able to sync copied instructions
-               immediately */
+            /*
+             * Break the TB to be able to sync copied instructions
+             * immediately.
+             */
             ctx->base.is_jmp =3D DISAS_STOP;
             break;
         case OPC_BPOSGE32:    /* MIPS DSP branch */
@@ -29283,8 +29394,10 @@ static void decode_opc(CPUMIPSState *env, DisasC=
ontext *ctx)
                     save_cpu_state(ctx, 1);
                     gen_helper_di(t0, cpu_env);
                     gen_store_gpr(t0, rt);
-                    /* Stop translation as we may have switched
-                       the execution mode.  */
+                    /*
+                     * Stop translation as we may have switched
+                     * the execution mode.
+                     */
                     ctx->base.is_jmp =3D DISAS_STOP;
                     break;
                 case OPC_EI:
@@ -29292,8 +29405,10 @@ static void decode_opc(CPUMIPSState *env, DisasC=
ontext *ctx)
                     save_cpu_state(ctx, 1);
                     gen_helper_ei(t0, cpu_env);
                     gen_store_gpr(t0, rt);
-                    /* DISAS_STOP isn't sufficient, we need to ensure we=
 break
-                       out of translated code to check for pending inter=
rupts */
+                    /*
+                     * DISAS_STOP isn't sufficient, we need to ensure we=
 break
+                     * out of translated code to check for pending inter=
rupts.
+                     */
                     gen_save_pc(ctx->base.pc_next + 4);
                     ctx->base.is_jmp =3D DISAS_EXIT;
                     break;
@@ -29876,10 +29991,12 @@ static bool mips_tr_breakpoint_check(DisasConte=
xtBase *dcbase, CPUState *cs,
     save_cpu_state(ctx, 1);
     ctx->base.is_jmp =3D DISAS_NORETURN;
     gen_helper_raise_exception_debug(cpu_env);
-    /* The address covered by the breakpoint must be included in
-       [tb->pc, tb->pc + tb->size) in order to for it to be
-       properly cleared -- thus we increment the PC here so that
-       the logic setting tb->size below does the right thing.  */
+    /*
+     * The address covered by the breakpoint must be included in
+     * [tb->pc, tb->pc + tb->size) in order to for it to be
+     * properly cleared -- thus we increment the PC here so that
+     * the logic setting tb->size below does the right thing.
+     */
     ctx->base.pc_next +=3D 4;
     return true;
 }
@@ -29914,14 +30031,18 @@ static void mips_tr_translate_insn(DisasContext=
Base *dcbase, CPUState *cs)
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
         if (!(ctx->hflags & (MIPS_HFLAG_BDS16 | MIPS_HFLAG_BDS32 |
                              MIPS_HFLAG_FBNSLOT))) {
-            /* force to generate branch as there is neither delay nor
-               forbidden slot */
+            /*
+             * Force to generate branch as there is neither delay nor
+             * forbidden slot.
+             */
             is_slot =3D 1;
         }
         if ((ctx->hflags & MIPS_HFLAG_M16) &&
             (ctx->hflags & MIPS_HFLAG_FBNSLOT)) {
-            /* Force to generate branch as microMIPS R6 doesn't restrict
-               branches in the forbidden slot. */
+            /*
+             * Force to generate branch as microMIPS R6 doesn't restrict
+             * branches in the forbidden slot.
+             */
             is_slot =3D 1;
         }
     }
@@ -29933,10 +30054,12 @@ static void mips_tr_translate_insn(DisasContext=
Base *dcbase, CPUState *cs)
     if (ctx->base.is_jmp !=3D DISAS_NEXT) {
         return;
     }
-    /* Execute a branch and its delay slot as a single instruction.
-       This is what GDB expects and is consistent with what the
-       hardware does (e.g. if a delay slot instruction faults, the
-       reported PC is the PC of the branch).  */
+    /*
+     * Execute a branch and its delay slot as a single instruction.
+     * This is what GDB expects and is consistent with what the
+     * hardware does (e.g. if a delay slot instruction faults, the
+     * reported PC is the PC of the branch).
+     */
     if (ctx->base.singlestep_enabled &&
         (ctx->hflags & MIPS_HFLAG_BMASK) =3D=3D 0) {
         ctx->base.is_jmp =3D DISAS_TOO_MANY;
@@ -30088,8 +30211,10 @@ void mips_tcg_init(void)
         int off =3D offsetof(CPUMIPSState, active_fpu.fpr[i].wr.d[0]);
         msa_wr_d[i * 2] =3D
                 tcg_global_mem_new_i64(cpu_env, off, msaregnames[i * 2])=
;
-        /* The scalar floating-point unit (FPU) registers are mapped on
-         * the MSA vector registers. */
+        /*
+         * The scalar floating-point unit (FPU) registers are mapped on
+         * the MSA vector registers.
+         */
         fpu_f64[i] =3D msa_wr_d[i * 2];
         off =3D offsetof(CPUMIPSState, active_fpu.fpr[i].wr.d[1]);
         msa_wr_d[i * 2 + 1] =3D
@@ -30247,8 +30372,10 @@ void cpu_state_reset(CPUMIPSState *env)
     /* Enable 64-bit address mode.  */
     env->CP0_Status |=3D (1 << CP0St_UX);
 # endif
-    /* Enable access to the CPUNum, SYNCI_Step, CC, and CCRes RDHWR
-       hardware registers.  */
+    /*
+     * Enable access to the CPUNum, SYNCI_Step, CC, and CCRes RDHWR
+     * hardware registers.
+     */
     env->CP0_HWREna |=3D 0x0000000F;
     if (env->CP0_Config1 & (1 << CP0C1_FP)) {
         env->CP0_Status |=3D (1 << CP0St_CU1);
@@ -30265,8 +30392,10 @@ void cpu_state_reset(CPUMIPSState *env)
 # endif
 #else
     if (env->hflags & MIPS_HFLAG_BMASK) {
-        /* If the exception was raised from a delay slot,
-           come back to the jump.  */
+        /*
+         * If the exception was raised from a delay slot,
+         * come back to the jump.
+         */
         env->CP0_ErrorEPC =3D (env->active_tc.PC
                              - (env->hflags & MIPS_HFLAG_B16 ? 2 : 4));
     } else {
@@ -30289,8 +30418,10 @@ void cpu_state_reset(CPUMIPSState *env)
     env->CP0_EntryHi_ASID_mask =3D (env->CP0_Config4 & (1 << CP0C4_AE)) =
?
                                  0x3ff : 0xff;
     env->CP0_Status =3D (1 << CP0St_BEV) | (1 << CP0St_ERL);
-    /* vectored interrupts not implemented, timer on int 7,
-       no performance counters. */
+    /*
+     * Vectored interrupts not implemented, timer on int 7,
+     * no performance counters.
+     */
     env->CP0_IntCtl =3D 0xe0000000;
     {
         int i;
--=20
2.7.4



