Received: from eggs.gnu.org ([2001:4830:134:3::10]:33585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1eBVmn-0004Jh-0D
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 20:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1eBVmj-00023i-U7
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 20:01:09 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:37236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiang.biao2@zte.com.cn>)
	id 1eBVmj-0001ym-CW
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 20:01:05 -0500
From: Jiang Biao <jiang.biao2@zte.com.cn>
Date: Mon, 6 Nov 2017 08:57:17 +0800
Message-Id: <1509929837-178178-1-git-send-email-jiang.biao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] tcg/mips: remove inline keywords.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aurelien@aurel32.net, rth@twiddle.net
Cc: qemu-devel@nongnu.org, jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn

The compiler will make reasonable default choies for inline
functions, so the inline keywords are redundant. Remove them to
retain consistant code style.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Suggested-by: Richard Henderson <rth@twiddle.net>
---
 tcg/mips/tcg-target.inc.c | 52 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 4b55ab8..77afadc 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -144,7 +144,7 @@ static tcg_insn_unit *bswap32_addr;
 static tcg_insn_unit *bswap32u_addr;
 static tcg_insn_unit *bswap64_addr;
 
-static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
+static uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
     /* Let the compiler perform the right-shift as part of the arithmetic.  */
     ptrdiff_t disp = target - (pc + 1);
@@ -152,18 +152,18 @@ static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
     return disp & 0xffff;
 }
 
-static inline void reloc_pc16(tcg_insn_unit *pc, tcg_insn_unit *target)
+static void reloc_pc16(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
     *pc = deposit32(*pc, 0, 16, reloc_pc16_val(pc, target));
 }
 
-static inline uint32_t reloc_26_val(tcg_insn_unit *pc, tcg_insn_unit *target)
+static uint32_t reloc_26_val(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
     tcg_debug_assert((((uintptr_t)pc ^ (uintptr_t)target) & 0xf0000000) == 0);
     return ((uintptr_t)target >> 2) & 0x3ffffff;
 }
 
-static inline void reloc_26(tcg_insn_unit *pc, tcg_insn_unit *target)
+static void reloc_26(tcg_insn_unit *pc, tcg_insn_unit *target)
 {
     *pc = deposit32(*pc, 0, 26, reloc_26_val(pc, target));
 }
@@ -183,7 +183,7 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define TCG_CT_CONST_N16  0x1000   /* "Negatable" 16-bit: -32767 - 32767 */
 #define TCG_CT_CONST_WSZ  0x2000   /* word size */
 
-static inline bool is_p2m1(tcg_target_long val)
+static bool is_p2m1(tcg_target_long val)
 {
     return val && ((val + 1) & val) == 0;
 }
@@ -248,7 +248,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 }
 
 /* test if a constant matches the constraint */
-static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
+static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                          const TCGArgConstraint *arg_ct)
 {
     int ct;
@@ -419,7 +419,7 @@ typedef enum {
 /*
  * Type reg
  */
-static inline void tcg_out_opc_reg(TCGContext *s, MIPSInsn opc,
+static void tcg_out_opc_reg(TCGContext *s, MIPSInsn opc,
                                    TCGReg rd, TCGReg rs, TCGReg rt)
 {
     int32_t inst;
@@ -434,7 +434,7 @@ static inline void tcg_out_opc_reg(TCGContext *s, MIPSInsn opc,
 /*
  * Type immediate
  */
-static inline void tcg_out_opc_imm(TCGContext *s, MIPSInsn opc,
+static void tcg_out_opc_imm(TCGContext *s, MIPSInsn opc,
                                    TCGReg rt, TCGReg rs, TCGArg imm)
 {
     int32_t inst;
@@ -449,7 +449,7 @@ static inline void tcg_out_opc_imm(TCGContext *s, MIPSInsn opc,
 /*
  * Type bitfield
  */
-static inline void tcg_out_opc_bf(TCGContext *s, MIPSInsn opc, TCGReg rt,
+static void tcg_out_opc_bf(TCGContext *s, MIPSInsn opc, TCGReg rt,
                                   TCGReg rs, int msb, int lsb)
 {
     int32_t inst;
@@ -462,7 +462,7 @@ static inline void tcg_out_opc_bf(TCGContext *s, MIPSInsn opc, TCGReg rt,
     tcg_out32(s, inst);
 }
 
-static inline void tcg_out_opc_bf64(TCGContext *s, MIPSInsn opc, MIPSInsn opm,
+static void tcg_out_opc_bf64(TCGContext *s, MIPSInsn opc, MIPSInsn opm,
                                     MIPSInsn oph, TCGReg rt, TCGReg rs,
                                     int msb, int lsb)
 {
@@ -480,7 +480,7 @@ static inline void tcg_out_opc_bf64(TCGContext *s, MIPSInsn opc, MIPSInsn opm,
 /*
  * Type branch
  */
-static inline void tcg_out_opc_br(TCGContext *s, MIPSInsn opc,
+static void tcg_out_opc_br(TCGContext *s, MIPSInsn opc,
                                   TCGReg rt, TCGReg rs)
 {
     /* We pay attention here to not modify the branch target by reading
@@ -494,7 +494,7 @@ static inline void tcg_out_opc_br(TCGContext *s, MIPSInsn opc,
 /*
  * Type sa
  */
-static inline void tcg_out_opc_sa(TCGContext *s, MIPSInsn opc,
+static void tcg_out_opc_sa(TCGContext *s, MIPSInsn opc,
                                   TCGReg rd, TCGReg rt, TCGArg sa)
 {
     int32_t inst;
@@ -542,27 +542,27 @@ static bool tcg_out_opc_jmp(TCGContext *s, MIPSInsn opc, void *target)
     return true;
 }
 
-static inline void tcg_out_nop(TCGContext *s)
+static void tcg_out_nop(TCGContext *s)
 {
     tcg_out32(s, 0);
 }
 
-static inline void tcg_out_dsll(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
+static void tcg_out_dsll(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
 {
     tcg_out_opc_sa64(s, OPC_DSLL, OPC_DSLL32, rd, rt, sa);
 }
 
-static inline void tcg_out_dsrl(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
+static void tcg_out_dsrl(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
 {
     tcg_out_opc_sa64(s, OPC_DSRL, OPC_DSRL32, rd, rt, sa);
 }
 
-static inline void tcg_out_dsra(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
+static void tcg_out_dsra(TCGContext *s, TCGReg rd, TCGReg rt, TCGArg sa)
 {
     tcg_out_opc_sa64(s, OPC_DSRA, OPC_DSRA32, rd, rt, sa);
 }
 
-static inline void tcg_out_mov(TCGContext *s, TCGType type,
+static void tcg_out_mov(TCGContext *s, TCGType type,
                                TCGReg ret, TCGReg arg)
 {
     /* Simple reg-reg move, optimising out the 'do nothing' case */
@@ -602,7 +602,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
     }
 }
 
-static inline void tcg_out_bswap16(TCGContext *s, TCGReg ret, TCGReg arg)
+static void tcg_out_bswap16(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
         tcg_out_opc_reg(s, OPC_WSBH, ret, 0, arg);
@@ -619,7 +619,7 @@ static inline void tcg_out_bswap16(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
-static inline void tcg_out_bswap16s(TCGContext *s, TCGReg ret, TCGReg arg)
+static void tcg_out_bswap16s(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
         tcg_out_opc_reg(s, OPC_WSBH, ret, 0, arg);
@@ -683,7 +683,7 @@ static void tcg_out_bswap64(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
-static inline void tcg_out_ext8s(TCGContext *s, TCGReg ret, TCGReg arg)
+static void tcg_out_ext8s(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
         tcg_out_opc_reg(s, OPC_SEB, ret, 0, arg);
@@ -693,7 +693,7 @@ static inline void tcg_out_ext8s(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
-static inline void tcg_out_ext16s(TCGContext *s, TCGReg ret, TCGReg arg)
+static void tcg_out_ext16s(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
         tcg_out_opc_reg(s, OPC_SEH, ret, 0, arg);
@@ -703,7 +703,7 @@ static inline void tcg_out_ext16s(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
-static inline void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
+static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
         tcg_out_opc_bf(s, OPC_DEXT, ret, arg, 31, 0);
@@ -727,7 +727,7 @@ static void tcg_out_ldst(TCGContext *s, MIPSInsn opc, TCGReg data,
     tcg_out_opc_imm(s, opc, data, addr, lo);
 }
 
-static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
                               TCGReg arg1, intptr_t arg2)
 {
     MIPSInsn opc = OPC_LD;
@@ -737,7 +737,7 @@ static inline void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
     tcg_out_ldst(s, opc, arg, arg1, arg2);
 }
 
-static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
                               TCGReg arg1, intptr_t arg2)
 {
     MIPSInsn opc = OPC_SD;
@@ -747,7 +747,7 @@ static inline void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
     tcg_out_ldst(s, opc, arg, arg1, arg2);
 }
 
-static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
+static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
                                TCGReg base, intptr_t ofs)
 {
     if (val == 0) {
@@ -1704,7 +1704,7 @@ static void tcg_out_clz(TCGContext *s, MIPSInsn opcv2, MIPSInsn opcv6,
     }
 }
 
-static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
+static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                               const TCGArg *args, const int *const_args)
 {
     MIPSInsn i1, i2;
-- 
2.9.5
