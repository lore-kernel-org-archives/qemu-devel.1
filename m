Received: from eggs.gnu.org ([2001:4830:134:3::10]:56998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIY-0001x4-2r
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIT-0003hk-5q
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:27 +1000
Message-Id: <20170424015927.8933-48-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 47/47] target/ppc: Style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

This makes a small step fixing one of many style problems that exist in
the older ppc code.  This removes spaces between function (or macro) name
and the following '('.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 372 ++++++++++++++++++++++----------------------
 1 file changed, 186 insertions(+), 186 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 0ecf541..e82e3e6 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -66,7 +66,7 @@ static void spr_store_dump_spr(int sprn)
 #endif
 }
 
-static void spr_write_generic (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_generic(DisasContext *ctx, int sprn, int gprn)
 {
     gen_store_spr(sprn, cpu_gpr[gprn]);
     spr_store_dump_spr(sprn);
@@ -86,7 +86,7 @@ static void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
 #endif
 }
 
-static void spr_write_clear (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_clear(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
@@ -106,47 +106,47 @@ static void spr_access_nop(DisasContext *ctx, int sprn, int gprn)
 
 /* SPR common to all PowerPC */
 /* XER */
-static void spr_read_xer (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_xer(DisasContext *ctx, int gprn, int sprn)
 {
     gen_read_xer(ctx, cpu_gpr[gprn]);
 }
 
-static void spr_write_xer (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_xer(DisasContext *ctx, int sprn, int gprn)
 {
     gen_write_xer(cpu_gpr[gprn]);
 }
 
 /* LR */
-static void spr_read_lr (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_lr(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_mov_tl(cpu_gpr[gprn], cpu_lr);
 }
 
-static void spr_write_lr (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_lr(DisasContext *ctx, int sprn, int gprn)
 {
     tcg_gen_mov_tl(cpu_lr, cpu_gpr[gprn]);
 }
 
 /* CFAR */
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
-static void spr_read_cfar (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_cfar(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_mov_tl(cpu_gpr[gprn], cpu_cfar);
 }
 
-static void spr_write_cfar (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_cfar(DisasContext *ctx, int sprn, int gprn)
 {
     tcg_gen_mov_tl(cpu_cfar, cpu_gpr[gprn]);
 }
 #endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
 
 /* CTR */
-static void spr_read_ctr (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_ctr(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_mov_tl(cpu_gpr[gprn], cpu_ctr);
 }
 
-static void spr_write_ctr (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_ctr(DisasContext *ctx, int sprn, int gprn)
 {
     tcg_gen_mov_tl(cpu_ctr, cpu_gpr[gprn]);
 }
@@ -157,7 +157,7 @@ static void spr_write_ctr (DisasContext *ctx, int sprn, int gprn)
 /* UPMCx */
 /* USIA */
 /* UDECR */
-static void spr_read_ureg (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_ureg(DisasContext *ctx, int gprn, int sprn)
 {
     gen_load_spr(cpu_gpr[gprn], sprn + 0x10);
 }
@@ -172,7 +172,7 @@ static void spr_write_ureg(DisasContext *ctx, int sprn, int gprn)
 /* SPR common to all non-embedded PowerPC */
 /* DECR */
 #if !defined(CONFIG_USER_ONLY)
-static void spr_read_decr (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
         gen_io_start();
@@ -184,7 +184,7 @@ static void spr_read_decr (DisasContext *ctx, int gprn, int sprn)
     }
 }
 
-static void spr_write_decr (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
         gen_io_start();
@@ -199,7 +199,7 @@ static void spr_write_decr (DisasContext *ctx, int sprn, int gprn)
 
 /* SPR common to all non-embedded PowerPC, except 601 */
 /* Time base */
-static void spr_read_tbl (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_tbl(DisasContext *ctx, int gprn, int sprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
         gen_io_start();
@@ -211,7 +211,7 @@ static void spr_read_tbl (DisasContext *ctx, int gprn, int sprn)
     }
 }
 
-static void spr_read_tbu (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_tbu(DisasContext *ctx, int gprn, int sprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
         gen_io_start();
@@ -224,19 +224,19 @@ static void spr_read_tbu (DisasContext *ctx, int gprn, int sprn)
 }
 
 __attribute__ (( unused ))
-static void spr_read_atbl (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_atbl(DisasContext *ctx, int gprn, int sprn)
 {
     gen_helper_load_atbl(cpu_gpr[gprn], cpu_env);
 }
 
 __attribute__ (( unused ))
-static void spr_read_atbu (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_atbu(DisasContext *ctx, int gprn, int sprn)
 {
     gen_helper_load_atbu(cpu_gpr[gprn], cpu_env);
 }
 
 #if !defined(CONFIG_USER_ONLY)
-static void spr_write_tbl (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
         gen_io_start();
@@ -248,7 +248,7 @@ static void spr_write_tbl (DisasContext *ctx, int sprn, int gprn)
     }
 }
 
-static void spr_write_tbu (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_tbu(DisasContext *ctx, int sprn, int gprn)
 {
     if (ctx->tb->cflags & CF_USE_ICOUNT) {
         gen_io_start();
@@ -261,20 +261,20 @@ static void spr_write_tbu (DisasContext *ctx, int sprn, int gprn)
 }
 
 __attribute__ (( unused ))
-static void spr_write_atbl (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_atbl(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_atbl(cpu_env, cpu_gpr[gprn]);
 }
 
 __attribute__ (( unused ))
-static void spr_write_atbu (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_atbu(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_atbu(cpu_env, cpu_gpr[gprn]);
 }
 
 #if defined(TARGET_PPC64)
 __attribute__ (( unused ))
-static void spr_read_purr (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
 {
     gen_helper_load_purr(cpu_gpr[gprn], cpu_env);
 }
@@ -310,38 +310,38 @@ static void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
 #if !defined(CONFIG_USER_ONLY)
 /* IBAT0U...IBAT0U */
 /* IBAT0L...IBAT7L */
-static void spr_read_ibat (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_ibat(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, IBAT[sprn & 1][(sprn - SPR_IBAT0U) / 2]));
 }
 
-static void spr_read_ibat_h (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_ibat_h(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, IBAT[sprn & 1][((sprn - SPR_IBAT4U) / 2) + 4]));
 }
 
-static void spr_write_ibatu (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_ibatu(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32((sprn - SPR_IBAT0U) / 2);
     gen_helper_store_ibatu(cpu_env, t0, cpu_gpr[gprn]);
     tcg_temp_free_i32(t0);
 }
 
-static void spr_write_ibatu_h (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_ibatu_h(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32(((sprn - SPR_IBAT4U) / 2) + 4);
     gen_helper_store_ibatu(cpu_env, t0, cpu_gpr[gprn]);
     tcg_temp_free_i32(t0);
 }
 
-static void spr_write_ibatl (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_ibatl(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32((sprn - SPR_IBAT0L) / 2);
     gen_helper_store_ibatl(cpu_env, t0, cpu_gpr[gprn]);
     tcg_temp_free_i32(t0);
 }
 
-static void spr_write_ibatl_h (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_ibatl_h(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32(((sprn - SPR_IBAT4L) / 2) + 4);
     gen_helper_store_ibatl(cpu_env, t0, cpu_gpr[gprn]);
@@ -350,38 +350,38 @@ static void spr_write_ibatl_h (DisasContext *ctx, int sprn, int gprn)
 
 /* DBAT0U...DBAT7U */
 /* DBAT0L...DBAT7L */
-static void spr_read_dbat (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_dbat(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, DBAT[sprn & 1][(sprn - SPR_DBAT0U) / 2]));
 }
 
-static void spr_read_dbat_h (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_dbat_h(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, DBAT[sprn & 1][((sprn - SPR_DBAT4U) / 2) + 4]));
 }
 
-static void spr_write_dbatu (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_dbatu(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32((sprn - SPR_DBAT0U) / 2);
     gen_helper_store_dbatu(cpu_env, t0, cpu_gpr[gprn]);
     tcg_temp_free_i32(t0);
 }
 
-static void spr_write_dbatu_h (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_dbatu_h(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32(((sprn - SPR_DBAT4U) / 2) + 4);
     gen_helper_store_dbatu(cpu_env, t0, cpu_gpr[gprn]);
     tcg_temp_free_i32(t0);
 }
 
-static void spr_write_dbatl (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_dbatl(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32((sprn - SPR_DBAT0L) / 2);
     gen_helper_store_dbatl(cpu_env, t0, cpu_gpr[gprn]);
     tcg_temp_free_i32(t0);
 }
 
-static void spr_write_dbatl_h (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_dbatl_h(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32(((sprn - SPR_DBAT4L) / 2) + 4);
     gen_helper_store_dbatl(cpu_env, t0, cpu_gpr[gprn]);
@@ -389,7 +389,7 @@ static void spr_write_dbatl_h (DisasContext *ctx, int sprn, int gprn)
 }
 
 /* SDR1 */
-static void spr_write_sdr1 (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_sdr1(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_sdr1(cpu_env, cpu_gpr[gprn]);
 }
@@ -402,12 +402,12 @@ static void spr_write_pidr(DisasContext *ctx, int sprn, int gprn)
     gen_helper_store_pidr(cpu_env, cpu_gpr[gprn]);
 }
 
-static void spr_read_hior (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_hior(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, excp_prefix));
 }
 
-static void spr_write_hior (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_hior(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv t0 = tcg_temp_new();
     tcg_gen_andi_tl(t0, cpu_gpr[gprn], 0x3FFFFF00000ULL);
@@ -419,28 +419,28 @@ static void spr_write_hior (DisasContext *ctx, int sprn, int gprn)
 
 /* PowerPC 601 specific registers */
 /* RTC */
-static void spr_read_601_rtcl (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_601_rtcl(DisasContext *ctx, int gprn, int sprn)
 {
     gen_helper_load_601_rtcl(cpu_gpr[gprn], cpu_env);
 }
 
-static void spr_read_601_rtcu (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_601_rtcu(DisasContext *ctx, int gprn, int sprn)
 {
     gen_helper_load_601_rtcu(cpu_gpr[gprn], cpu_env);
 }
 
 #if !defined(CONFIG_USER_ONLY)
-static void spr_write_601_rtcu (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_601_rtcu(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_601_rtcu(cpu_env, cpu_gpr[gprn]);
 }
 
-static void spr_write_601_rtcl (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_601_rtcl(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_601_rtcl(cpu_env, cpu_gpr[gprn]);
 }
 
-static void spr_write_hid0_601 (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_hid0_601(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_hid0_601(cpu_env, cpu_gpr[gprn]);
     /* Must stop the translation as endianness may have changed */
@@ -450,19 +450,19 @@ static void spr_write_hid0_601 (DisasContext *ctx, int sprn, int gprn)
 
 /* Unified bats */
 #if !defined(CONFIG_USER_ONLY)
-static void spr_read_601_ubat (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_601_ubat(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, IBAT[sprn & 1][(sprn - SPR_IBAT0U) / 2]));
 }
 
-static void spr_write_601_ubatu (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_601_ubatu(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32((sprn - SPR_IBAT0U) / 2);
     gen_helper_store_601_batl(cpu_env, t0, cpu_gpr[gprn]);
     tcg_temp_free_i32(t0);
 }
 
-static void spr_write_601_ubatl (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_601_ubatl(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32((sprn - SPR_IBAT0U) / 2);
     gen_helper_store_601_batu(cpu_env, t0, cpu_gpr[gprn]);
@@ -472,34 +472,34 @@ static void spr_write_601_ubatl (DisasContext *ctx, int sprn, int gprn)
 
 /* PowerPC 40x specific registers */
 #if !defined(CONFIG_USER_ONLY)
-static void spr_read_40x_pit (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_40x_pit(DisasContext *ctx, int gprn, int sprn)
 {
     gen_helper_load_40x_pit(cpu_gpr[gprn], cpu_env);
 }
 
-static void spr_write_40x_pit (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_40x_pit(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_40x_pit(cpu_env, cpu_gpr[gprn]);
 }
 
-static void spr_write_40x_dbcr0 (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_40x_dbcr0(cpu_env, cpu_gpr[gprn]);
     /* We must stop translation as we may have rebooted */
     gen_stop_exception(ctx);
 }
 
-static void spr_write_40x_sler (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_40x_sler(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_40x_sler(cpu_env, cpu_gpr[gprn]);
 }
 
-static void spr_write_booke_tcr (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_booke_tcr(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_booke_tcr(cpu_env, cpu_gpr[gprn]);
 }
 
-static void spr_write_booke_tsr (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_booke_tsr(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_store_booke_tsr(cpu_env, cpu_gpr[gprn]);
 }
@@ -508,19 +508,19 @@ static void spr_write_booke_tsr (DisasContext *ctx, int sprn, int gprn)
 /* PowerPC 403 specific registers */
 /* PBL1 / PBU1 / PBL2 / PBU2 */
 #if !defined(CONFIG_USER_ONLY)
-static void spr_read_403_pbr (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_403_pbr(DisasContext *ctx, int gprn, int sprn)
 {
     tcg_gen_ld_tl(cpu_gpr[gprn], cpu_env, offsetof(CPUPPCState, pb[sprn - SPR_403_PBL1]));
 }
 
-static void spr_write_403_pbr (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_403_pbr(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32(sprn - SPR_403_PBL1);
     gen_helper_store_403_pbr(cpu_env, t0, cpu_gpr[gprn]);
     tcg_temp_free_i32(t0);
 }
 
-static void spr_write_pir (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_pir(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv t0 = tcg_temp_new();
     tcg_gen_andi_tl(t0, cpu_gpr[gprn], 0xF);
@@ -530,7 +530,7 @@ static void spr_write_pir (DisasContext *ctx, int sprn, int gprn)
 #endif
 
 /* SPE specific registers */
-static void spr_read_spefscr (DisasContext *ctx, int gprn, int sprn)
+static void spr_read_spefscr(DisasContext *ctx, int gprn, int sprn)
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
     tcg_gen_ld_i32(t0, cpu_env, offsetof(CPUPPCState, spe_fscr));
@@ -538,7 +538,7 @@ static void spr_read_spefscr (DisasContext *ctx, int gprn, int sprn)
     tcg_temp_free_i32(t0);
 }
 
-static void spr_write_spefscr (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_spefscr(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
     tcg_gen_trunc_tl_i32(t0, cpu_gpr[gprn]);
@@ -548,7 +548,7 @@ static void spr_write_spefscr (DisasContext *ctx, int sprn, int gprn)
 
 #if !defined(CONFIG_USER_ONLY)
 /* Callback used to write the exception vector base */
-static void spr_write_excp_prefix (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_excp_prefix(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv t0 = tcg_temp_new();
     tcg_gen_ld_tl(t0, cpu_env, offsetof(CPUPPCState, ivpr_mask));
@@ -558,7 +558,7 @@ static void spr_write_excp_prefix (DisasContext *ctx, int sprn, int gprn)
     tcg_temp_free(t0);
 }
 
-static void spr_write_excp_vector (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_excp_vector(DisasContext *ctx, int sprn, int gprn)
 {
     int sprn_offs;
 
@@ -584,7 +584,7 @@ static void spr_write_excp_vector (DisasContext *ctx, int sprn, int gprn)
 }
 #endif
 
-static inline void vscr_init (CPUPPCState *env, uint32_t val)
+static inline void vscr_init(CPUPPCState *env, uint32_t val)
 {
     env->vscr = val;
     /* Altivec always uses round-to-nearest */
@@ -685,7 +685,7 @@ static inline void _spr_register(CPUPPCState *env, int num,
 }
 
 /* Generic PowerPC SPRs */
-static void gen_spr_generic (CPUPPCState *env)
+static void gen_spr_generic(CPUPPCState *env)
 {
     /* Integer processing */
     spr_register(env, SPR_XER, "XER",
@@ -770,7 +770,7 @@ static void gen_spr_sdr1(CPUPPCState *env)
 }
 
 /* BATs 0-3 */
-static void gen_low_BATs (CPUPPCState *env)
+static void gen_low_BATs(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     spr_register(env, SPR_IBAT0U, "IBAT0U",
@@ -842,7 +842,7 @@ static void gen_low_BATs (CPUPPCState *env)
 }
 
 /* BATs 4-7 */
-static void gen_high_BATs (CPUPPCState *env)
+static void gen_high_BATs(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     spr_register(env, SPR_IBAT4U, "IBAT4U",
@@ -914,7 +914,7 @@ static void gen_high_BATs (CPUPPCState *env)
 }
 
 /* Generic PowerPC time base */
-static void gen_tbl (CPUPPCState *env)
+static void gen_tbl(CPUPPCState *env)
 {
     spr_register(env, SPR_VTBL,  "TBL",
                  &spr_read_tbl, SPR_NOACCESS,
@@ -935,7 +935,7 @@ static void gen_tbl (CPUPPCState *env)
 }
 
 /* Softare table search registers */
-static void gen_6xx_7xx_soft_tlb (CPUPPCState *env, int nb_tlbs, int nb_ways)
+static void gen_6xx_7xx_soft_tlb(CPUPPCState *env, int nb_tlbs, int nb_ways)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = nb_tlbs;
@@ -974,7 +974,7 @@ static void gen_6xx_7xx_soft_tlb (CPUPPCState *env, int nb_tlbs, int nb_ways)
 }
 
 /* SPR common to MPC755 and G2 */
-static void gen_spr_G2_755 (CPUPPCState *env)
+static void gen_spr_G2_755(CPUPPCState *env)
 {
     /* SGPRs */
     spr_register(env, SPR_SPRG4, "SPRG4",
@@ -996,7 +996,7 @@ static void gen_spr_G2_755 (CPUPPCState *env)
 }
 
 /* SPR common to all 7xx PowerPC implementations */
-static void gen_spr_7xx (CPUPPCState *env)
+static void gen_spr_7xx(CPUPPCState *env)
 {
     /* Breakpoints */
     /* XXX : not implemented */
@@ -1241,7 +1241,7 @@ static void spr_read_thrm(DisasContext *ctx, int gprn, int sprn)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static void gen_spr_thrm (CPUPPCState *env)
+static void gen_spr_thrm(CPUPPCState *env)
 {
     /* Thermal management */
     /* XXX : not implemented */
@@ -1262,7 +1262,7 @@ static void gen_spr_thrm (CPUPPCState *env)
 }
 
 /* SPR specific to PowerPC 604 implementation */
-static void gen_spr_604 (CPUPPCState *env)
+static void gen_spr_604(CPUPPCState *env)
 {
     /* Processor identification */
     spr_register(env, SPR_PIR, "PIR",
@@ -1315,7 +1315,7 @@ static void gen_spr_604 (CPUPPCState *env)
 }
 
 /* SPR specific to PowerPC 603 implementation */
-static void gen_spr_603 (CPUPPCState *env)
+static void gen_spr_603(CPUPPCState *env)
 {
     /* External access control */
     /* XXX : not implemented */
@@ -1333,7 +1333,7 @@ static void gen_spr_603 (CPUPPCState *env)
 }
 
 /* SPR specific to PowerPC G2 implementation */
-static void gen_spr_G2 (CPUPPCState *env)
+static void gen_spr_G2(CPUPPCState *env)
 {
     /* Memory base address */
     /* MBAR */
@@ -1385,7 +1385,7 @@ static void gen_spr_G2 (CPUPPCState *env)
 }
 
 /* SPR specific to PowerPC 602 implementation */
-static void gen_spr_602 (CPUPPCState *env)
+static void gen_spr_602(CPUPPCState *env)
 {
     /* ESA registers */
     /* XXX : not implemented */
@@ -1433,7 +1433,7 @@ static void gen_spr_602 (CPUPPCState *env)
 }
 
 /* SPR specific to PowerPC 601 implementation */
-static void gen_spr_601 (CPUPPCState *env)
+static void gen_spr_601(CPUPPCState *env)
 {
     /* Multiplication/division register */
     /* MQ */
@@ -1509,7 +1509,7 @@ static void gen_spr_601 (CPUPPCState *env)
 #endif
 }
 
-static void gen_spr_74xx (CPUPPCState *env)
+static void gen_spr_74xx(CPUPPCState *env)
 {
     /* Processor identification */
     spr_register(env, SPR_PIR, "PIR",
@@ -1561,7 +1561,7 @@ static void gen_spr_74xx (CPUPPCState *env)
     vscr_init(env, 0x00010000);
 }
 
-static void gen_l3_ctrl (CPUPPCState *env)
+static void gen_l3_ctrl(CPUPPCState *env)
 {
     /* L3CR */
     /* XXX : not implemented */
@@ -1583,7 +1583,7 @@ static void gen_l3_ctrl (CPUPPCState *env)
                  0x00000000);
 }
 
-static void gen_74xx_soft_tlb (CPUPPCState *env, int nb_tlbs, int nb_ways)
+static void gen_74xx_soft_tlb(CPUPPCState *env, int nb_tlbs, int nb_ways)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->nb_tlb = nb_tlbs;
@@ -1609,7 +1609,7 @@ static void gen_74xx_soft_tlb (CPUPPCState *env, int nb_tlbs, int nb_ways)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-static void spr_write_e500_l1csr0 (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_e500_l1csr0(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv t0 = tcg_temp_new();
 
@@ -1627,12 +1627,12 @@ static void spr_write_e500_l1csr1(DisasContext *ctx, int sprn, int gprn)
     tcg_temp_free(t0);
 }
 
-static void spr_write_booke206_mmucsr0 (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_booke206_mmucsr0(DisasContext *ctx, int sprn, int gprn)
 {
     gen_helper_booke206_tlbflush(cpu_env, cpu_gpr[gprn]);
 }
 
-static void spr_write_booke_pid (DisasContext *ctx, int sprn, int gprn)
+static void spr_write_booke_pid(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t0 = tcg_const_i32(sprn);
     gen_helper_booke_setpid(cpu_env, t0, cpu_gpr[gprn]);
@@ -1640,7 +1640,7 @@ static void spr_write_booke_pid (DisasContext *ctx, int sprn, int gprn)
 }
 #endif
 
-static void gen_spr_usprg3 (CPUPPCState *env)
+static void gen_spr_usprg3(CPUPPCState *env)
 {
     spr_register(env, SPR_USPRG3, "USPRG3",
                  &spr_read_ureg, SPR_NOACCESS,
@@ -1648,7 +1648,7 @@ static void gen_spr_usprg3 (CPUPPCState *env)
                  0x00000000);
 }
 
-static void gen_spr_usprgh (CPUPPCState *env)
+static void gen_spr_usprgh(CPUPPCState *env)
 {
     spr_register(env, SPR_USPRG4, "USPRG4",
                  &spr_read_ureg, SPR_NOACCESS,
@@ -1669,7 +1669,7 @@ static void gen_spr_usprgh (CPUPPCState *env)
 }
 
 /* PowerPC BookE SPR */
-static void gen_spr_BookE (CPUPPCState *env, uint64_t ivor_mask)
+static void gen_spr_BookE(CPUPPCState *env, uint64_t ivor_mask)
 {
     const char *ivor_names[64] = {
         "IVOR0",  "IVOR1",  "IVOR2",  "IVOR3",
@@ -1921,7 +1921,7 @@ static void gen_spr_BookE206(CPUPPCState *env, uint32_t mas_mask,
 }
 
 /* SPR specific to PowerPC 440 implementation */
-static void gen_spr_440 (CPUPPCState *env)
+static void gen_spr_440(CPUPPCState *env)
 {
     /* Cache control */
     /* XXX : not implemented */
@@ -2062,7 +2062,7 @@ static void gen_spr_440 (CPUPPCState *env)
 }
 
 /* SPR shared between PowerPC 40x implementations */
-static void gen_spr_40x (CPUPPCState *env)
+static void gen_spr_40x(CPUPPCState *env)
 {
     /* Cache */
     /* not emulated, as QEMU do not emulate caches */
@@ -2117,7 +2117,7 @@ static void gen_spr_40x (CPUPPCState *env)
 }
 
 /* SPR specific to PowerPC 405 implementation */
-static void gen_spr_405 (CPUPPCState *env)
+static void gen_spr_405(CPUPPCState *env)
 {
     /* MMU */
     spr_register(env, SPR_40x_PID, "PID",
@@ -2223,7 +2223,7 @@ static void gen_spr_405 (CPUPPCState *env)
 }
 
 /* SPR shared between PowerPC 401 & 403 implementations */
-static void gen_spr_401_403 (CPUPPCState *env)
+static void gen_spr_401_403(CPUPPCState *env)
 {
     /* Time base */
     spr_register(env, SPR_403_VTBL,  "TBL",
@@ -2251,7 +2251,7 @@ static void gen_spr_401_403 (CPUPPCState *env)
 }
 
 /* SPR specific to PowerPC 401 implementation */
-static void gen_spr_401 (CPUPPCState *env)
+static void gen_spr_401(CPUPPCState *env)
 {
     /* Debug interface */
     /* XXX : not implemented */
@@ -2293,7 +2293,7 @@ static void gen_spr_401 (CPUPPCState *env)
                  0x00000000);
 }
 
-static void gen_spr_401x2 (CPUPPCState *env)
+static void gen_spr_401x2(CPUPPCState *env)
 {
     gen_spr_401(env);
     spr_register(env, SPR_40x_PID, "PID",
@@ -2307,7 +2307,7 @@ static void gen_spr_401x2 (CPUPPCState *env)
 }
 
 /* SPR specific to PowerPC 403 implementation */
-static void gen_spr_403 (CPUPPCState *env)
+static void gen_spr_403(CPUPPCState *env)
 {
     /* Debug interface */
     /* XXX : not implemented */
@@ -2343,7 +2343,7 @@ static void gen_spr_403 (CPUPPCState *env)
                  0x00000000);
 }
 
-static void gen_spr_403_real (CPUPPCState *env)
+static void gen_spr_403_real(CPUPPCState *env)
 {
     spr_register(env, SPR_403_PBL1,  "PBL1",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -2363,7 +2363,7 @@ static void gen_spr_403_real (CPUPPCState *env)
                  0x00000000);
 }
 
-static void gen_spr_403_mmu (CPUPPCState *env)
+static void gen_spr_403_mmu(CPUPPCState *env)
 {
     /* MMU */
     spr_register(env, SPR_40x_PID, "PID",
@@ -2377,7 +2377,7 @@ static void gen_spr_403_mmu (CPUPPCState *env)
 }
 
 /* SPR specific to PowerPC compression coprocessor extension */
-static void gen_spr_compress (CPUPPCState *env)
+static void gen_spr_compress(CPUPPCState *env)
 {
     /* XXX : not implemented */
     spr_register(env, SPR_401_SKR, "SKR",
@@ -2386,7 +2386,7 @@ static void gen_spr_compress (CPUPPCState *env)
                  0x00000000);
 }
 
-static void gen_spr_5xx_8xx (CPUPPCState *env)
+static void gen_spr_5xx_8xx(CPUPPCState *env)
 {
     /* Exception processing */
     spr_register_kvm(env, SPR_DSISR, "DSISR",
@@ -2504,7 +2504,7 @@ static void gen_spr_5xx_8xx (CPUPPCState *env)
                  0x00000000);
 }
 
-static void gen_spr_5xx (CPUPPCState *env)
+static void gen_spr_5xx(CPUPPCState *env)
 {
     /* XXX : not implemented */
     spr_register(env, SPR_RCPU_MI_GRA, "MI_GRA",
@@ -2613,7 +2613,7 @@ static void gen_spr_5xx (CPUPPCState *env)
                  0x00000000);
 }
 
-static void gen_spr_8xx (CPUPPCState *env)
+static void gen_spr_8xx(CPUPPCState *env)
 {
     /* XXX : not implemented */
     spr_register(env, SPR_MPC_IC_CST, "IC_CST",
@@ -2775,7 +2775,7 @@ static void gen_spr_8xx (CPUPPCState *env)
 
 /*****************************************************************************/
 /* Exception vectors models                                                  */
-static void init_excp_4xx_real (CPUPPCState *env)
+static void init_excp_4xx_real(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_CRITICAL] = 0x00000100;
@@ -2795,7 +2795,7 @@ static void init_excp_4xx_real (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_4xx_softmmu (CPUPPCState *env)
+static void init_excp_4xx_softmmu(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_CRITICAL] = 0x00000100;
@@ -2819,7 +2819,7 @@ static void init_excp_4xx_softmmu (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_MPC5xx (CPUPPCState *env)
+static void init_excp_MPC5xx(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -2844,7 +2844,7 @@ static void init_excp_MPC5xx (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_MPC8xx (CPUPPCState *env)
+static void init_excp_MPC8xx(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -2875,7 +2875,7 @@ static void init_excp_MPC8xx (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_G2 (CPUPPCState *env)
+static void init_excp_G2(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -2930,7 +2930,7 @@ static void init_excp_e200(CPUPPCState *env, target_ulong ivpr_mask)
 #endif
 }
 
-static void init_excp_BookE (CPUPPCState *env)
+static void init_excp_BookE(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_CRITICAL] = 0x00000000;
@@ -2956,7 +2956,7 @@ static void init_excp_BookE (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_601 (CPUPPCState *env)
+static void init_excp_601(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -2976,7 +2976,7 @@ static void init_excp_601 (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_602 (CPUPPCState *env)
+static void init_excp_602(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     /* XXX: exception prefix has a special behavior on 602 */
@@ -3003,7 +3003,7 @@ static void init_excp_602 (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_603 (CPUPPCState *env)
+static void init_excp_603(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -3027,7 +3027,7 @@ static void init_excp_603 (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_604 (CPUPPCState *env)
+static void init_excp_604(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -3049,7 +3049,7 @@ static void init_excp_604 (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_7x0 (CPUPPCState *env)
+static void init_excp_7x0(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -3072,7 +3072,7 @@ static void init_excp_7x0 (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_750cl (CPUPPCState *env)
+static void init_excp_750cl(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -3094,7 +3094,7 @@ static void init_excp_750cl (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_750cx (CPUPPCState *env)
+static void init_excp_750cx(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -3117,7 +3117,7 @@ static void init_excp_750cx (CPUPPCState *env)
 }
 
 /* XXX: Check if this is correct */
-static void init_excp_7x5 (CPUPPCState *env)
+static void init_excp_7x5(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -3143,7 +3143,7 @@ static void init_excp_7x5 (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_7400 (CPUPPCState *env)
+static void init_excp_7400(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -3168,7 +3168,7 @@ static void init_excp_7400 (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_7450 (CPUPPCState *env)
+static void init_excp_7450(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -3195,8 +3195,8 @@ static void init_excp_7450 (CPUPPCState *env)
 #endif
 }
 
-#if defined (TARGET_PPC64)
-static void init_excp_970 (CPUPPCState *env)
+#if defined(TARGET_PPC64)
+static void init_excp_970(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -3224,7 +3224,7 @@ static void init_excp_970 (CPUPPCState *env)
 #endif
 }
 
-static void init_excp_POWER7 (CPUPPCState *env)
+static void init_excp_POWER7(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000100;
@@ -3269,17 +3269,17 @@ static void init_excp_POWER8(CPUPPCState *env)
 
 /*****************************************************************************/
 /* Power management enable checks                                            */
-static int check_pow_none (CPUPPCState *env)
+static int check_pow_none(CPUPPCState *env)
 {
     return 0;
 }
 
-static int check_pow_nocheck (CPUPPCState *env)
+static int check_pow_nocheck(CPUPPCState *env)
 {
     return 1;
 }
 
-static int check_pow_hid0 (CPUPPCState *env)
+static int check_pow_hid0(CPUPPCState *env)
 {
     if (env->spr[SPR_HID0] & 0x00E00000)
         return 1;
@@ -3287,7 +3287,7 @@ static int check_pow_hid0 (CPUPPCState *env)
     return 0;
 }
 
-static int check_pow_hid0_74xx (CPUPPCState *env)
+static int check_pow_hid0_74xx(CPUPPCState *env)
 {
     if (env->spr[SPR_HID0] & 0x00600000)
         return 1;
@@ -3332,7 +3332,7 @@ static bool ppc_cpu_interrupts_big_endian_lpcr(PowerPCCPU *cpu)
                                                                             \
     static void glue(glue(ppc_, _name), _cpu_family_class_init)
 
-static void init_proc_401 (CPUPPCState *env)
+static void init_proc_401(CPUPPCState *env)
 {
     gen_spr_40x(env);
     gen_spr_401_403(env);
@@ -3378,7 +3378,7 @@ POWERPC_FAMILY(401)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_401x2 (CPUPPCState *env)
+static void init_proc_401x2(CPUPPCState *env)
 {
     gen_spr_40x(env);
     gen_spr_401_403(env);
@@ -3436,7 +3436,7 @@ POWERPC_FAMILY(401x2)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_401x3 (CPUPPCState *env)
+static void init_proc_401x3(CPUPPCState *env)
 {
     gen_spr_40x(env);
     gen_spr_401_403(env);
@@ -3489,7 +3489,7 @@ POWERPC_FAMILY(401x3)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_IOP480 (CPUPPCState *env)
+static void init_proc_IOP480(CPUPPCState *env)
 {
     gen_spr_40x(env);
     gen_spr_401_403(env);
@@ -3547,7 +3547,7 @@ POWERPC_FAMILY(IOP480)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_403 (CPUPPCState *env)
+static void init_proc_403(CPUPPCState *env)
 {
     gen_spr_40x(env);
     gen_spr_401_403(env);
@@ -3594,7 +3594,7 @@ POWERPC_FAMILY(403)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_403GCX (CPUPPCState *env)
+static void init_proc_403GCX(CPUPPCState *env)
 {
     gen_spr_40x(env);
     gen_spr_401_403(env);
@@ -3661,7 +3661,7 @@ POWERPC_FAMILY(403GCX)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_405 (CPUPPCState *env)
+static void init_proc_405(CPUPPCState *env)
 {
     /* Time base */
     gen_tbl(env);
@@ -3727,7 +3727,7 @@ POWERPC_FAMILY(405)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_440EP (CPUPPCState *env)
+static void init_proc_440EP(CPUPPCState *env)
 {
     /* Time base */
     gen_tbl(env);
@@ -3831,7 +3831,7 @@ POWERPC_FAMILY(440EP)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_440GP (CPUPPCState *env)
+static void init_proc_440GP(CPUPPCState *env)
 {
     /* Time base */
     gen_tbl(env);
@@ -3914,7 +3914,7 @@ POWERPC_FAMILY(440GP)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_440x4 (CPUPPCState *env)
+static void init_proc_440x4(CPUPPCState *env)
 {
     /* Time base */
     gen_tbl(env);
@@ -3997,7 +3997,7 @@ POWERPC_FAMILY(440x4)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_440x5 (CPUPPCState *env)
+static void init_proc_440x5(CPUPPCState *env)
 {
     /* Time base */
     gen_tbl(env);
@@ -4243,7 +4243,7 @@ POWERPC_FAMILY(460)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_460F (CPUPPCState *env)
+static void init_proc_460F(CPUPPCState *env)
 {
     /* Time base */
     gen_tbl(env);
@@ -4353,7 +4353,7 @@ POWERPC_FAMILY(460F)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_MPC5xx (CPUPPCState *env)
+static void init_proc_MPC5xx(CPUPPCState *env)
 {
     /* Time base */
     gen_tbl(env);
@@ -4397,7 +4397,7 @@ POWERPC_FAMILY(MPC5xx)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_MPC8xx (CPUPPCState *env)
+static void init_proc_MPC8xx(CPUPPCState *env)
 {
     /* Time base */
     gen_tbl(env);
@@ -4442,7 +4442,7 @@ POWERPC_FAMILY(MPC8xx)(ObjectClass *oc, void *data)
 
 /* Freescale 82xx cores (aka PowerQUICC-II)                                  */
 
-static void init_proc_G2 (CPUPPCState *env)
+static void init_proc_G2(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -4521,7 +4521,7 @@ POWERPC_FAMILY(G2)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_G2LE (CPUPPCState *env)
+static void init_proc_G2LE(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -4603,7 +4603,7 @@ POWERPC_FAMILY(G2LE)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_e200 (CPUPPCState *env)
+static void init_proc_e200(CPUPPCState *env)
 {
     /* Time base */
     gen_tbl(env);
@@ -4757,7 +4757,7 @@ POWERPC_FAMILY(e200)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_e300 (CPUPPCState *env)
+static void init_proc_e300(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -4889,7 +4889,7 @@ enum fsl_e500_version {
     fsl_e5500,
 };
 
-static void init_proc_e500 (CPUPPCState *env, int version)
+static void init_proc_e500(CPUPPCState *env, int version)
 {
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
     uint32_t tlbncfg[2];
@@ -5258,7 +5258,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, void *data)
 
 #define POWERPC_MSRR_601     (0x0000000000001040ULL)
 
-static void init_proc_601 (CPUPPCState *env)
+static void init_proc_601(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -5331,7 +5331,7 @@ POWERPC_FAMILY(601)(ObjectClass *oc, void *data)
 
 #define POWERPC_MSRR_601v    (0x0000000000001040ULL)
 
-static void init_proc_601v (CPUPPCState *env)
+static void init_proc_601v(CPUPPCState *env)
 {
     init_proc_601(env);
     /* XXX : not implemented */
@@ -5373,7 +5373,7 @@ POWERPC_FAMILY(601v)(ObjectClass *oc, void *data)
     pcc->flags = POWERPC_FLAG_SE | POWERPC_FLAG_RTC_CLK;
 }
 
-static void init_proc_602 (CPUPPCState *env)
+static void init_proc_602(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -5443,7 +5443,7 @@ POWERPC_FAMILY(602)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_603 (CPUPPCState *env)
+static void init_proc_603(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -5510,7 +5510,7 @@ POWERPC_FAMILY(603)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_603E (CPUPPCState *env)
+static void init_proc_603E(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -5577,7 +5577,7 @@ POWERPC_FAMILY(603E)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BE | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_604 (CPUPPCState *env)
+static void init_proc_604(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -5641,7 +5641,7 @@ POWERPC_FAMILY(604)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_604E (CPUPPCState *env)
+static void init_proc_604E(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -5725,7 +5725,7 @@ POWERPC_FAMILY(604E)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_740 (CPUPPCState *env)
+static void init_proc_740(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -5796,7 +5796,7 @@ POWERPC_FAMILY(740)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_750 (CPUPPCState *env)
+static void init_proc_750(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -5875,7 +5875,7 @@ POWERPC_FAMILY(750)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_750cl (CPUPPCState *env)
+static void init_proc_750cl(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -6077,7 +6077,7 @@ POWERPC_FAMILY(750cl)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_750cx (CPUPPCState *env)
+static void init_proc_750cx(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -6160,7 +6160,7 @@ POWERPC_FAMILY(750cx)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_750fx (CPUPPCState *env)
+static void init_proc_750fx(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -6248,7 +6248,7 @@ POWERPC_FAMILY(750fx)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_750gx (CPUPPCState *env)
+static void init_proc_750gx(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -6336,7 +6336,7 @@ POWERPC_FAMILY(750gx)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_745 (CPUPPCState *env)
+static void init_proc_745(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -6412,7 +6412,7 @@ POWERPC_FAMILY(745)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_755 (CPUPPCState *env)
+static void init_proc_755(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -6499,7 +6499,7 @@ POWERPC_FAMILY(755)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_7400 (CPUPPCState *env)
+static void init_proc_7400(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -6578,7 +6578,7 @@ POWERPC_FAMILY(7400)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_7410 (CPUPPCState *env)
+static void init_proc_7410(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -6663,7 +6663,7 @@ POWERPC_FAMILY(7410)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_7440 (CPUPPCState *env)
+static void init_proc_7440(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -6771,7 +6771,7 @@ POWERPC_FAMILY(7440)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_7450 (CPUPPCState *env)
+static void init_proc_7450(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -6905,7 +6905,7 @@ POWERPC_FAMILY(7450)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_7445 (CPUPPCState *env)
+static void init_proc_7445(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -7042,7 +7042,7 @@ POWERPC_FAMILY(7445)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_7455 (CPUPPCState *env)
+static void init_proc_7455(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -7181,7 +7181,7 @@ POWERPC_FAMILY(7455)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_7457 (CPUPPCState *env)
+static void init_proc_7457(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -7344,7 +7344,7 @@ POWERPC_FAMILY(7457)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-static void init_proc_e600 (CPUPPCState *env)
+static void init_proc_e600(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
     gen_spr_sdr1(env);
@@ -7486,7 +7486,7 @@ POWERPC_FAMILY(e600)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_BUS_CLK;
 }
 
-#if defined (TARGET_PPC64)
+#if defined(TARGET_PPC64)
 #if defined(CONFIG_USER_ONLY)
 #define POWERPC970_HID5_INIT 0x00000080
 #else
@@ -7545,7 +7545,7 @@ static void spr_write_prev_upper32(DisasContext *ctx, int sprn, int gprn)
     tcg_temp_free(spr);
 }
 
-static int check_pow_970 (CPUPPCState *env)
+static int check_pow_970(CPUPPCState *env)
 {
     if (env->spr[SPR_HID0] & (HID0_DEEPNAP | HID0_DOZE | HID0_NAP)) {
         return 1;
@@ -8513,7 +8513,7 @@ static const struct ppc_segment_page_sizes POWER7_POWER8_sps = {
 };
 #endif /* CONFIG_SOFTMMU */
 
-static void init_proc_POWER7 (CPUPPCState *env)
+static void init_proc_POWER7(CPUPPCState *env)
 {
     /* Common Registers */
     init_proc_book3s_common(env);
@@ -9079,7 +9079,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 
 #endif /* !defined(CONFIG_USER_ONLY) */
 
-#endif /* defined (TARGET_PPC64) */
+#endif /* defined(TARGET_PPC64) */
 
 /*****************************************************************************/
 /* Generic CPU instantiation routine                                         */
@@ -9250,7 +9250,7 @@ static void init_ppc_proc(PowerPCCPU *cpu)
 }
 
 #if defined(PPC_DUMP_CPU)
-static void dump_ppc_sprs (CPUPPCState *env)
+static void dump_ppc_sprs(CPUPPCState *env)
 {
     ppc_spr_t *spr;
 #if !defined(CONFIG_USER_ONLY)
@@ -9299,7 +9299,7 @@ enum {
 
 #define PPC_OPCODE_MASK 0x3
 
-static inline int is_indirect_opcode (void *handler)
+static inline int is_indirect_opcode(void *handler)
 {
     return ((uintptr_t)handler & PPC_OPCODE_MASK) == PPC_INDIRECT;
 }
@@ -9311,7 +9311,7 @@ static inline opc_handler_t **ind_table(void *handler)
 
 /* Instruction table creation */
 /* Opcodes tables creation */
-static void fill_new_table (opc_handler_t **table, int len)
+static void fill_new_table(opc_handler_t **table, int len)
 {
     int i;
 
@@ -9319,7 +9319,7 @@ static void fill_new_table (opc_handler_t **table, int len)
         table[i] = &invalid_handler;
 }
 
-static int create_new_table (opc_handler_t **table, unsigned char idx)
+static int create_new_table(opc_handler_t **table, unsigned char idx)
 {
     opc_handler_t **tmp;
 
@@ -9330,7 +9330,7 @@ static int create_new_table (opc_handler_t **table, unsigned char idx)
     return 0;
 }
 
-static int insert_in_table (opc_handler_t **table, unsigned char idx,
+static int insert_in_table(opc_handler_t **table, unsigned char idx,
                             opc_handler_t *handler)
 {
     if (table[idx] != &invalid_handler)
@@ -9340,8 +9340,8 @@ static int insert_in_table (opc_handler_t **table, unsigned char idx,
     return 0;
 }
 
-static int register_direct_insn (opc_handler_t **ppc_opcodes,
-                                 unsigned char idx, opc_handler_t *handler)
+static int register_direct_insn(opc_handler_t **ppc_opcodes,
+                                unsigned char idx, opc_handler_t *handler)
 {
     if (insert_in_table(ppc_opcodes, idx, handler) < 0) {
         printf("*** ERROR: opcode %02x already assigned in main "
@@ -9356,9 +9356,9 @@ static int register_direct_insn (opc_handler_t **ppc_opcodes,
     return 0;
 }
 
-static int register_ind_in_table (opc_handler_t **table,
-                                  unsigned char idx1, unsigned char idx2,
-                                  opc_handler_t *handler)
+static int register_ind_in_table(opc_handler_t **table,
+                                 unsigned char idx1, unsigned char idx2,
+                                 opc_handler_t *handler)
 {
     if (table[idx1] == &invalid_handler) {
         if (create_new_table(table, idx1) < 0) {
@@ -9391,16 +9391,16 @@ static int register_ind_in_table (opc_handler_t **table,
     return 0;
 }
 
-static int register_ind_insn (opc_handler_t **ppc_opcodes,
-                              unsigned char idx1, unsigned char idx2,
-                              opc_handler_t *handler)
+static int register_ind_insn(opc_handler_t **ppc_opcodes,
+                             unsigned char idx1, unsigned char idx2,
+                             opc_handler_t *handler)
 {
     return register_ind_in_table(ppc_opcodes, idx1, idx2, handler);
 }
 
-static int register_dblind_insn (opc_handler_t **ppc_opcodes,
-                                 unsigned char idx1, unsigned char idx2,
-                                 unsigned char idx3, opc_handler_t *handler)
+static int register_dblind_insn(opc_handler_t **ppc_opcodes,
+                                unsigned char idx1, unsigned char idx2,
+                                unsigned char idx3, opc_handler_t *handler)
 {
     if (register_ind_in_table(ppc_opcodes, idx1, idx2, NULL) < 0) {
         printf("*** ERROR: unable to join indirect table idx "
@@ -9443,7 +9443,7 @@ static int register_trplind_insn(opc_handler_t **ppc_opcodes,
     }
     return 0;
 }
-static int register_insn (opc_handler_t **ppc_opcodes, opcode_t *insn)
+static int register_insn(opc_handler_t **ppc_opcodes, opcode_t *insn)
 {
     if (insn->opc2 != 0xFF) {
         if (insn->opc3 != 0xFF) {
@@ -9471,7 +9471,7 @@ static int register_insn (opc_handler_t **ppc_opcodes, opcode_t *insn)
     return 0;
 }
 
-static int test_opcode_table (opc_handler_t **table, int len)
+static int test_opcode_table(opc_handler_t **table, int len)
 {
     int i, count, tmp;
 
@@ -9498,7 +9498,7 @@ static int test_opcode_table (opc_handler_t **table, int len)
     return count;
 }
 
-static void fix_opcode_tables (opc_handler_t **ppc_opcodes)
+static void fix_opcode_tables(opc_handler_t **ppc_opcodes)
 {
     if (test_opcode_table(ppc_opcodes, PPC_CPU_OPCODES_LEN) == 0)
         printf("*** WARNING: no opcode defined !\n");
@@ -9529,7 +9529,7 @@ static void create_ppc_opcodes(PowerPCCPU *cpu, Error **errp)
 }
 
 #if defined(PPC_DUMP_CPU)
-static void dump_ppc_insns (CPUPPCState *env)
+static void dump_ppc_insns(CPUPPCState *env)
 {
     opc_handler_t **table, *handler;
     const char *p, *q;
@@ -9943,7 +9943,7 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
         case POWERPC_MMU_601:
             mmu_model = "PowerPC 601";
             break;
-#if defined (TARGET_PPC64)
+#if defined(TARGET_PPC64)
         case POWERPC_MMU_64B:
             mmu_model = "PowerPC 64";
             break;
@@ -9986,7 +9986,7 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
         case POWERPC_EXCP_BOOKE:
             excp_model = "PowerPC BookE";
             break;
-#if defined (TARGET_PPC64)
+#if defined(TARGET_PPC64)
         case POWERPC_EXCP_970:
             excp_model = "PowerPC 970";
             break;
@@ -10011,7 +10011,7 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
         case PPC_FLAGS_INPUT_RCPU:
             bus_model = "RCPU / MPC8xx";
             break;
-#if defined (TARGET_PPC64)
+#if defined(TARGET_PPC64)
         case PPC_FLAGS_INPUT_970:
             bus_model = "PowerPC 970";
             break;
-- 
2.9.3
