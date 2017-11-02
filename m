Received: from eggs.gnu.org ([2001:4830:134:3::10]:48865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1eACju-0006MH-Ny
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1eACjr-0000fh-L9
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:28:46 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:37572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiang.biao2@zte.com.cn>)
	id 1eACjr-0000YG-9m
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:28:43 -0400
From: Jiang Biao <jiang.biao2@zte.com.cn>
Date: Thu, 2 Nov 2017 18:26:15 +0800
Message-Id: <1509618375-164238-1-git-send-email-jiang.biao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] tcg/mips: make some functions inline.
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

Make some functions inline.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 tcg/mips/tcg-target.inc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 4b55ab8..f83a8ec 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -168,7 +168,7 @@ static inline void reloc_26(tcg_insn_unit *pc, tcg_insn_unit *target)
     *pc = deposit32(*pc, 0, 26, reloc_26_val(pc, target));
 }
 
-static void patch_reloc(tcg_insn_unit *code_ptr, int type,
+static inline void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
     tcg_debug_assert(type == R_MIPS_PC16);
@@ -507,7 +507,7 @@ static inline void tcg_out_opc_sa(TCGContext *s, MIPSInsn opc,
 
 }
 
-static void tcg_out_opc_sa64(TCGContext *s, MIPSInsn opc1, MIPSInsn opc2,
+static inline void tcg_out_opc_sa64(TCGContext *s, MIPSInsn opc1, MIPSInsn opc2,
                              TCGReg rd, TCGReg rt, TCGArg sa)
 {
     int32_t inst;
@@ -637,13 +637,13 @@ static inline void tcg_out_bswap16s(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
-static void tcg_out_bswap_subr(TCGContext *s, tcg_insn_unit *sub)
+static inline void tcg_out_bswap_subr(TCGContext *s, tcg_insn_unit *sub)
 {
     bool ok = tcg_out_opc_jmp(s, OPC_JAL, sub);
     tcg_debug_assert(ok);
 }
 
-static void tcg_out_bswap32(TCGContext *s, TCGReg ret, TCGReg arg)
+static inline void tcg_out_bswap32(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
         tcg_out_opc_reg(s, OPC_WSBH, ret, 0, arg);
@@ -656,7 +656,7 @@ static void tcg_out_bswap32(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
-static void tcg_out_bswap32u(TCGContext *s, TCGReg ret, TCGReg arg)
+static inline void tcg_out_bswap32u(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
         tcg_out_opc_reg(s, OPC_DSBH, ret, 0, arg);
@@ -670,7 +670,7 @@ static void tcg_out_bswap32u(TCGContext *s, TCGReg ret, TCGReg arg)
     }
 }
 
-static void tcg_out_bswap64(TCGContext *s, TCGReg ret, TCGReg arg)
+static inline void tcg_out_bswap64(TCGContext *s, TCGReg ret, TCGReg arg)
 {
     if (use_mips32r2_instructions) {
         tcg_out_opc_reg(s, OPC_DSBH, ret, 0, arg);
@@ -1103,7 +1103,7 @@ static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
     }
 }
 
-static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
+static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
 {
     tcg_out_call_int(s, arg, false);
     tcg_out_nop(s);
@@ -1661,7 +1661,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
 #endif
 }
 
-static void tcg_out_mb(TCGContext *s, TCGArg a0)
+static inline void tcg_out_mb(TCGContext *s, TCGArg a0)
 {
     static const MIPSInsn sync[] = {
         /* Note that SYNC_MB is a slightly weaker than SYNC 0,
@@ -2433,7 +2433,7 @@ static void tcg_target_detect_isa(void)
     sigaction(SIGILL, &sa_old, NULL);
 }
 
-static tcg_insn_unit *align_code_ptr(TCGContext *s)
+static inline tcg_insn_unit *align_code_ptr(TCGContext *s)
 {
     uintptr_t p = (uintptr_t)s->code_ptr;
     if (p & 15) {
-- 
2.9.5
