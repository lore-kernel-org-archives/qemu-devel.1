Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A4AC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB73F2077C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB73F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hItle-0007Jt-2J
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:39:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItdc-0001eY-Kx
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hItda-0005Ya-II
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:31:00 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45025 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hItda-0005WZ-5E
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:30:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 9F0B71A243C;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 72C6B1A242D;
	Tue, 23 Apr 2019 13:29:53 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 13:29:41 +0200
Message-Id: <1556018982-3715-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 7/8] target/mips: Fix some space checkpatch
 errors in translate.c
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423112941.3J4IZokxoPjtDCx71bFwJES12g8CPXgzGd3U-sBOGLU@z>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove several space-related checkpatch warnings.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 126 +++++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 61 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 797f090..fb4ff0b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2616,7 +2616,7 @@ static const char * const mxuregnames[] = {
     } while (0)
 
 /* General purpose registers moves. */
-static inline void gen_load_gpr (TCGv t, int reg)
+static inline void gen_load_gpr(TCGv t, int reg)
 {
     if (reg == 0)
         tcg_gen_movi_tl(t, 0);
@@ -2624,14 +2624,14 @@ static inline void gen_load_gpr (TCGv t, int reg)
         tcg_gen_mov_tl(t, cpu_gpr[reg]);
 }
 
-static inline void gen_store_gpr (TCGv t, int reg)
+static inline void gen_store_gpr(TCGv t, int reg)
 {
     if (reg != 0)
         tcg_gen_mov_tl(cpu_gpr[reg], t);
 }
 
 /* Moves to/from shadow registers. */
-static inline void gen_load_srsgpr (int from, int to)
+static inline void gen_load_srsgpr(int from, int to)
 {
     TCGv t0 = tcg_temp_new();
 
@@ -2838,7 +2838,7 @@ static void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
     }
 }
 
-static inline int get_fp_bit (int cc)
+static inline int get_fp_bit(int cc)
 {
     if (cc)
         return 24 + cc;
@@ -2847,7 +2847,8 @@ static inline int get_fp_bit (int cc)
 }
 
 /* Addresses computation */
-static inline void gen_op_addr_add (DisasContext *ctx, TCGv ret, TCGv arg0, TCGv arg1)
+static inline void gen_op_addr_add(DisasContext *ctx, TCGv ret, TCGv arg0,
+                                   TCGv arg1)
 {
     tcg_gen_add_tl(ret, arg0, arg1);
 
@@ -3327,8 +3328,8 @@ OP_LD_ATOMIC(lld,ld64);
 #endif
 #undef OP_LD_ATOMIC
 
-static void gen_base_offset_addr (DisasContext *ctx, TCGv addr,
-                                  int base, int offset)
+static void gen_base_offset_addr(DisasContext *ctx, TCGv addr,
+                                 int base, int offset)
 {
     if (base == 0) {
         tcg_gen_movi_tl(addr, offset);
@@ -3340,7 +3341,7 @@ static void gen_base_offset_addr (DisasContext *ctx, TCGv addr,
     }
 }
 
-static target_ulong pc_relative_pc (DisasContext *ctx)
+static target_ulong pc_relative_pc(DisasContext *ctx)
 {
     target_ulong pc = ctx->base.pc_next;
 
@@ -3577,8 +3578,8 @@ static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
 }
 
 /* Store */
-static void gen_st (DisasContext *ctx, uint32_t opc, int rt,
-                    int base, int offset)
+static void gen_st(DisasContext *ctx, uint32_t opc, int rt,
+                   int base, int offset)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
@@ -3716,8 +3717,8 @@ static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
 }
 
 /* Load and store */
-static void gen_flt_ldst (DisasContext *ctx, uint32_t opc, int ft,
-                          TCGv t0)
+static void gen_flt_ldst(DisasContext *ctx, uint32_t opc, int ft,
+                         TCGv t0)
 {
     /* Don't do NOP if destination is zero: we must perform the actual
        memory access. */
@@ -5131,8 +5132,8 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t1);
 }
 
-static void gen_mul_vr54xx (DisasContext *ctx, uint32_t opc,
-                            int rd, int rs, int rt)
+static void gen_mul_vr54xx(DisasContext *ctx, uint32_t opc,
+                           int rd, int rs, int rt)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
@@ -5195,8 +5196,8 @@ static void gen_mul_vr54xx (DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t1);
 }
 
-static void gen_cl (DisasContext *ctx, uint32_t opc,
-                    int rd, int rs)
+static void gen_cl(DisasContext *ctx, uint32_t opc,
+                   int rd, int rs)
 {
     TCGv t0;
 
@@ -6187,8 +6188,8 @@ static void gen_compute_branch_nm(DisasContext *ctx, uint32_t opc,
 
 
 /* special3 bitfield operations */
-static void gen_bitops (DisasContext *ctx, uint32_t opc, int rt,
-                        int rs, int lsb, int msb)
+static void gen_bitops(DisasContext *ctx, uint32_t opc, int rt,
+                       int rs, int lsb, int msb)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
@@ -6258,7 +6259,7 @@ fail:
     tcg_temp_free(t1);
 }
 
-static void gen_bshfl (DisasContext *ctx, uint32_t op2, int rt, int rd)
+static void gen_bshfl(DisasContext *ctx, uint32_t op2, int rt, int rd)
 {
     TCGv t0;
 
@@ -6501,7 +6502,7 @@ static inline void gen_mfhc0_load64(TCGv arg, target_ulong off, int shift)
     tcg_temp_free_i64(t0);
 }
 
-static inline void gen_mfc0_load32 (TCGv arg, target_ulong off)
+static inline void gen_mfc0_load32(TCGv arg, target_ulong off)
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
 
@@ -6510,13 +6511,13 @@ static inline void gen_mfc0_load32 (TCGv arg, target_ulong off)
     tcg_temp_free_i32(t0);
 }
 
-static inline void gen_mfc0_load64 (TCGv arg, target_ulong off)
+static inline void gen_mfc0_load64(TCGv arg, target_ulong off)
 {
     tcg_gen_ld_tl(arg, cpu_env, off);
     tcg_gen_ext32s_tl(arg, arg);
 }
 
-static inline void gen_mtc0_store32 (TCGv arg, target_ulong off)
+static inline void gen_mtc0_store32(TCGv arg, target_ulong off)
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
 
@@ -10076,7 +10077,8 @@ die:
     generate_exception_end(ctx, EXCP_RI);
 }
 
-static void gen_cp0 (CPUMIPSState *env, DisasContext *ctx, uint32_t opc, int rt, int rd)
+static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
+                    int rt, int rd)
 {
     const char *opn = "ldst";
 
@@ -10632,7 +10634,8 @@ enum r6_f_cmp_op {
     R6_OPC_CMP_SUNE_D = FOP(26, FMT_L),
     R6_OPC_CMP_SNE_D  = FOP(27, FMT_L),
 };
-static void gen_cp1 (DisasContext *ctx, uint32_t opc, int rt, int fs)
+
+static void gen_cp1(DisasContext *ctx, uint32_t opc, int rt, int fs)
 {
     TCGv t0 = tcg_temp_new();
 
@@ -10713,7 +10716,7 @@ static void gen_cp1 (DisasContext *ctx, uint32_t opc, int rt, int fs)
     tcg_temp_free(t0);
 }
 
-static void gen_movci (DisasContext *ctx, int rd, int rs, int cc, int tf)
+static void gen_movci(DisasContext *ctx, int rd, int rs, int cc, int tf)
 {
     TCGLabel *l1;
     TCGCond cond;
@@ -10762,7 +10765,8 @@ static inline void gen_movcf_s(DisasContext *ctx, int fs, int fd, int cc,
     tcg_temp_free_i32(t0);
 }
 
-static inline void gen_movcf_d (DisasContext *ctx, int fs, int fd, int cc, int tf)
+static inline void gen_movcf_d(DisasContext *ctx, int fs, int fd, int cc,
+                               int tf)
 {
     int cond;
     TCGv_i32 t0 = tcg_temp_new_i32();
@@ -10885,8 +10889,8 @@ static void gen_sel_d(DisasContext *ctx, enum fopcode op1, int fd, int ft,
     tcg_temp_free_i64(t1);
 }
 
-static void gen_farith (DisasContext *ctx, enum fopcode op1,
-                        int ft, int fs, int fd, int cc)
+static void gen_farith(DisasContext *ctx, enum fopcode op1,
+                       int ft, int fs, int fd, int cc)
 {
     uint32_t func = ctx->opcode & 0x3f;
     switch (op1) {
@@ -12313,8 +12317,8 @@ static void gen_farith (DisasContext *ctx, enum fopcode op1,
 }
 
 /* Coprocessor 3 (FPU) */
-static void gen_flt3_ldst (DisasContext *ctx, uint32_t opc,
-                           int fd, int fs, int base, int index)
+static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
+                          int fd, int fs, int base, int index)
 {
     TCGv t0 = tcg_temp_new();
 
@@ -12393,8 +12397,8 @@ static void gen_flt3_ldst (DisasContext *ctx, uint32_t opc,
     tcg_temp_free(t0);
 }
 
-static void gen_flt3_arith (DisasContext *ctx, uint32_t opc,
-                            int fd, int fr, int fs, int ft)
+static void gen_flt3_arith(DisasContext *ctx, uint32_t opc,
+                           int fd, int fr, int fs, int ft)
 {
     switch (opc) {
     case OPC_ALNV_PS:
@@ -13156,17 +13160,17 @@ enum {
   RR_RY_CNVT_SEW = 0x6,
 };
 
-static int xlat (int r)
+static int xlat(int r)
 {
   static int map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
 
   return map[r];
 }
 
-static void gen_mips16_save (DisasContext *ctx,
-                             int xsregs, int aregs,
-                             int do_ra, int do_s0, int do_s1,
-                             int framesize)
+static void gen_mips16_save(DisasContext *ctx,
+                            int xsregs, int aregs,
+                            int do_ra, int do_s0, int do_s1,
+                            int framesize)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
@@ -13321,10 +13325,10 @@ static void gen_mips16_save (DisasContext *ctx,
     tcg_temp_free(t2);
 }
 
-static void gen_mips16_restore (DisasContext *ctx,
-                                int xsregs, int aregs,
-                                int do_ra, int do_s0, int do_s1,
-                                int framesize)
+static void gen_mips16_restore(DisasContext *ctx,
+                               int xsregs, int aregs,
+                               int do_ra, int do_s0, int do_s1,
+                               int framesize)
 {
     int astatic;
     TCGv t0 = tcg_temp_new();
@@ -13427,8 +13431,8 @@ static void gen_mips16_restore (DisasContext *ctx,
     tcg_temp_free(t2);
 }
 
-static void gen_addiupc (DisasContext *ctx, int rx, int imm,
-                         int is_64_bit, int extended)
+static void gen_addiupc(DisasContext *ctx, int rx, int imm,
+                        int is_64_bit, int extended)
 {
     TCGv t0;
 
@@ -13458,9 +13462,9 @@ static void gen_cache_operation(DisasContext *ctx, uint32_t op, int base,
 }
 
 #if defined(TARGET_MIPS64)
-static void decode_i64_mips16 (DisasContext *ctx,
-                               int ry, int funct, int16_t offset,
-                               int extended)
+static void decode_i64_mips16(DisasContext *ctx,
+                              int ry, int funct, int16_t offset,
+                              int extended)
 {
     switch (funct) {
     case I64_LDSP:
@@ -13519,7 +13523,7 @@ static void decode_i64_mips16 (DisasContext *ctx,
 }
 #endif
 
-static int decode_extended_mips16_opc (CPUMIPSState *env, DisasContext *ctx)
+static int decode_extended_mips16_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     int extend = cpu_lduw_code(env, ctx->base.pc_next + 2);
     int op, rx, ry, funct, sa;
@@ -13725,7 +13729,7 @@ static inline bool is_uhi(int sdbbp_code)
 #endif
 }
 
-static int decode_mips16_opc (CPUMIPSState *env, DisasContext *ctx)
+static int decode_mips16_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     int rx, ry;
     int sa;
@@ -13948,7 +13952,7 @@ static int decode_mips16_opc (CPUMIPSState *env, DisasContext *ctx)
     case M16_OPC_LWPC:
         gen_ld(ctx, OPC_LWPC, rx, 0, ((uint8_t)ctx->opcode) << 2);
         break;
-#if defined (TARGET_MIPS64)
+#if defined(TARGET_MIPS64)
     case M16_OPC_LWU:
         check_insn(ctx, ISA_MIPS3);
         check_mips_64(ctx);
@@ -14052,7 +14056,7 @@ static int decode_mips16_opc (CPUMIPSState *env, DisasContext *ctx)
         case RR_SRAV:
             gen_shift(ctx, OPC_SRAV, ry, rx, ry);
             break;
-#if defined (TARGET_MIPS64)
+#if defined(TARGET_MIPS64)
         case RR_DSRL:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
@@ -14115,7 +14119,7 @@ static int decode_mips16_opc (CPUMIPSState *env, DisasContext *ctx)
         case RR_MFLO:
             gen_HILO(ctx, OPC_MFLO, 0, rx);
             break;
-#if defined (TARGET_MIPS64)
+#if defined(TARGET_MIPS64)
         case RR_DSRA:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
@@ -14149,7 +14153,7 @@ static int decode_mips16_opc (CPUMIPSState *env, DisasContext *ctx)
         case RR_DIVU:
             gen_muldiv(ctx, OPC_DIVU, 0, rx, ry);
             break;
-#if defined (TARGET_MIPS64)
+#if defined(TARGET_MIPS64)
         case RR_DMULT:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
@@ -14793,7 +14797,7 @@ enum {
     ADDIUR1SP = 0x1
 };
 
-static int mmreg (int r)
+static int mmreg(int r)
 {
     static const int map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
 
@@ -14801,7 +14805,7 @@ static int mmreg (int r)
 }
 
 /* Used for 16-bit store instructions.  */
-static int mmreg2 (int r)
+static int mmreg2(int r)
 {
     static const int map[] = { 0, 17, 2, 3, 4, 5, 6, 7 };
 
@@ -14876,8 +14880,8 @@ static void gen_andi16(DisasContext *ctx)
     gen_logic_imm(ctx, OPC_ANDI, rd, rs, decoded_imm[encoded]);
 }
 
-static void gen_ldst_multiple (DisasContext *ctx, uint32_t opc, int reglist,
-                               int base, int16_t offset)
+static void gen_ldst_multiple(DisasContext *ctx, uint32_t opc, int reglist,
+                              int base, int16_t offset)
 {
     TCGv t0, t1;
     TCGv_i32 t2;
@@ -15150,7 +15154,7 @@ static void gen_pool16c_r6_insn(DisasContext *ctx)
     }
 }
 
-static void gen_ldxs (DisasContext *ctx, int base, int index, int rd)
+static void gen_ldxs(DisasContext *ctx, int base, int index, int rd)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
@@ -15170,8 +15174,8 @@ static void gen_ldxs (DisasContext *ctx, int base, int index, int rd)
     tcg_temp_free(t1);
 }
 
-static void gen_ldst_pair (DisasContext *ctx, uint32_t opc, int rd,
-                           int base, int16_t offset)
+static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
+                          int base, int16_t offset)
 {
     TCGv t0, t1;
 
@@ -15261,7 +15265,7 @@ static void gen_sync(int stype)
     tcg_gen_mb(tcg_mo);
 }
 
-static void gen_pool32axf (CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
+static void gen_pool32axf(CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
 {
     int extension = (ctx->opcode >> 6) & 0x3f;
     int minor = (ctx->opcode >> 12) & 0xf;
@@ -17225,7 +17229,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
-static int decode_micromips_opc (CPUMIPSState *env, DisasContext *ctx)
+static int decode_micromips_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t op;
 
-- 
2.7.4


