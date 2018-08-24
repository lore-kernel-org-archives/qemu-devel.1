Received: from eggs.gnu.org ([2001:4830:134:3::10]:35756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UI-0007er-Ta
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UG-0004lq-EU
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8UE-0004eK-ID
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8UC-0006dG-Cu
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:32 +0100
Message-Id: <20180824093343.11346-42-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 41/52] target/arm: Untabify translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Untabify the arm translate.c. This affects only some lines,
mostly comments, in the iwMMXt code. We've never touched
that code in years, so it's not going to get fixed up
by our "change when touched" process, and a bulk change
is not going to be too disruptive.

This commit was produced using Emacs "untabify"; it is
a whitespace-only change.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180821165215.29069-2-peter.maydell@linaro.org
---
 target/arm/translate.c | 122 ++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index bcfc29c5a6a..c6a5d2ac444 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1627,7 +1627,7 @@ static inline void gen_mov_vreg_F0(int dp, int reg)
         tcg_gen_st_f32(cpu_F0s, cpu_env, vfp_reg_offset(dp, reg));
 }
 
-#define ARM_CP_RW_BIT	(1 << 20)
+#define ARM_CP_RW_BIT   (1 << 20)
 
 static inline void iwmmxt_load_reg(TCGv_i64 var, int reg)
 {
@@ -1861,12 +1861,12 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
             wrd = insn & 0xf;
             rdlo = (insn >> 12) & 0xf;
             rdhi = (insn >> 16) & 0xf;
-            if (insn & ARM_CP_RW_BIT) {			/* TMRRC */
+            if (insn & ARM_CP_RW_BIT) {                         /* TMRRC */
                 iwmmxt_load_reg(cpu_V0, wrd);
                 tcg_gen_extrl_i64_i32(cpu_R[rdlo], cpu_V0);
                 tcg_gen_shri_i64(cpu_V0, cpu_V0, 32);
                 tcg_gen_extrl_i64_i32(cpu_R[rdhi], cpu_V0);
-            } else {					/* TMCRR */
+            } else {                                    /* TMCRR */
                 tcg_gen_concat_i32_i64(cpu_V0, cpu_R[rdlo], cpu_R[rdhi]);
                 iwmmxt_store_reg(cpu_V0, wrd);
                 gen_op_iwmmxt_set_mup();
@@ -1881,25 +1881,25 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
         if (insn & ARM_CP_RW_BIT) {
-            if ((insn >> 28) == 0xf) {			/* WLDRW wCx */
+            if ((insn >> 28) == 0xf) {                  /* WLDRW wCx */
                 tmp = tcg_temp_new_i32();
                 gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
                 iwmmxt_store_creg(wrd, tmp);
             } else {
                 i = 1;
                 if (insn & (1 << 8)) {
-                    if (insn & (1 << 22)) {		/* WLDRD */
+                    if (insn & (1 << 22)) {             /* WLDRD */
                         gen_aa32_ld64(s, cpu_M0, addr, get_mem_index(s));
                         i = 0;
-                    } else {				/* WLDRW wRd */
+                    } else {                            /* WLDRW wRd */
                         tmp = tcg_temp_new_i32();
                         gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
                     }
                 } else {
                     tmp = tcg_temp_new_i32();
-                    if (insn & (1 << 22)) {		/* WLDRH */
+                    if (insn & (1 << 22)) {             /* WLDRH */
                         gen_aa32_ld16u(s, tmp, addr, get_mem_index(s));
-                    } else {				/* WLDRB */
+                    } else {                            /* WLDRB */
                         gen_aa32_ld8u(s, tmp, addr, get_mem_index(s));
                     }
                 }
@@ -1910,24 +1910,24 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
                 gen_op_iwmmxt_movq_wRn_M0(wrd);
             }
         } else {
-            if ((insn >> 28) == 0xf) {			/* WSTRW wCx */
+            if ((insn >> 28) == 0xf) {                  /* WSTRW wCx */
                 tmp = iwmmxt_load_creg(wrd);
                 gen_aa32_st32(s, tmp, addr, get_mem_index(s));
             } else {
                 gen_op_iwmmxt_movq_M0_wRn(wrd);
                 tmp = tcg_temp_new_i32();
                 if (insn & (1 << 8)) {
-                    if (insn & (1 << 22)) {		/* WSTRD */
+                    if (insn & (1 << 22)) {             /* WSTRD */
                         gen_aa32_st64(s, cpu_M0, addr, get_mem_index(s));
-                    } else {				/* WSTRW wRd */
+                    } else {                            /* WSTRW wRd */
                         tcg_gen_extrl_i64_i32(tmp, cpu_M0);
                         gen_aa32_st32(s, tmp, addr, get_mem_index(s));
                     }
                 } else {
-                    if (insn & (1 << 22)) {		/* WSTRH */
+                    if (insn & (1 << 22)) {             /* WSTRH */
                         tcg_gen_extrl_i64_i32(tmp, cpu_M0);
                         gen_aa32_st16(s, tmp, addr, get_mem_index(s));
-                    } else {				/* WSTRB */
+                    } else {                            /* WSTRB */
                         tcg_gen_extrl_i64_i32(tmp, cpu_M0);
                         gen_aa32_st8(s, tmp, addr, get_mem_index(s));
                     }
@@ -1943,7 +1943,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         return 1;
 
     switch (((insn >> 12) & 0xf00) | ((insn >> 4) & 0xff)) {
-    case 0x000:						/* WOR */
+    case 0x000:                                                 /* WOR */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 0) & 0xf;
         rd1 = (insn >> 16) & 0xf;
@@ -1954,7 +1954,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x011:						/* TMCR */
+    case 0x011:                                                 /* TMCR */
         if (insn & 0xf)
             return 1;
         rd = (insn >> 12) & 0xf;
@@ -1985,7 +1985,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
         break;
-    case 0x100:						/* WXOR */
+    case 0x100:                                                 /* WXOR */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 0) & 0xf;
         rd1 = (insn >> 16) & 0xf;
@@ -1996,7 +1996,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x111:						/* TMRC */
+    case 0x111:                                                 /* TMRC */
         if (insn & 0xf)
             return 1;
         rd = (insn >> 12) & 0xf;
@@ -2004,7 +2004,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         tmp = iwmmxt_load_creg(wrd);
         store_reg(s, rd, tmp);
         break;
-    case 0x300:						/* WANDN */
+    case 0x300:                                                 /* WANDN */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 0) & 0xf;
         rd1 = (insn >> 16) & 0xf;
@@ -2016,7 +2016,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x200:						/* WAND */
+    case 0x200:                                                 /* WAND */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 0) & 0xf;
         rd1 = (insn >> 16) & 0xf;
@@ -2027,7 +2027,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x810: case 0xa10:				/* WMADD */
+    case 0x810: case 0xa10:                             /* WMADD */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 0) & 0xf;
         rd1 = (insn >> 16) & 0xf;
@@ -2039,7 +2039,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
-    case 0x10e: case 0x50e: case 0x90e: case 0xd0e:	/* WUNPCKIL */
+    case 0x10e: case 0x50e: case 0x90e: case 0xd0e:     /* WUNPCKIL */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
@@ -2061,7 +2061,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x10c: case 0x50c: case 0x90c: case 0xd0c:	/* WUNPCKIH */
+    case 0x10c: case 0x50c: case 0x90c: case 0xd0c:     /* WUNPCKIH */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
@@ -2083,7 +2083,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x012: case 0x112: case 0x412: case 0x512:	/* WSAD */
+    case 0x012: case 0x112: case 0x412: case 0x512:     /* WSAD */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
@@ -2097,7 +2097,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
-    case 0x010: case 0x110: case 0x210: case 0x310:	/* WMUL */
+    case 0x010: case 0x110: case 0x210: case 0x310:     /* WMUL */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
@@ -2116,7 +2116,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
-    case 0x410: case 0x510: case 0x610: case 0x710:	/* WMAC */
+    case 0x410: case 0x510: case 0x610: case 0x710:     /* WMAC */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
@@ -2132,7 +2132,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
-    case 0x006: case 0x406: case 0x806: case 0xc06:	/* WCMPEQ */
+    case 0x006: case 0x406: case 0x806: case 0xc06:     /* WCMPEQ */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
@@ -2154,7 +2154,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x800: case 0x900: case 0xc00: case 0xd00:	/* WAVG2 */
+    case 0x800: case 0x900: case 0xc00: case 0xd00:     /* WAVG2 */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
@@ -2174,7 +2174,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x802: case 0x902: case 0xa02: case 0xb02:	/* WALIGNR */
+    case 0x802: case 0x902: case 0xa02: case 0xb02:     /* WALIGNR */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
@@ -2187,7 +2187,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
-    case 0x601: case 0x605: case 0x609: case 0x60d:	/* TINSR */
+    case 0x601: case 0x605: case 0x609: case 0x60d:     /* TINSR */
         if (((insn >> 6) & 3) == 3)
             return 1;
         rd = (insn >> 12) & 0xf;
@@ -2218,7 +2218,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
-    case 0x107: case 0x507: case 0x907: case 0xd07:	/* TEXTRM */
+    case 0x107: case 0x507: case 0x907: case 0xd07:     /* TEXTRM */
         rd = (insn >> 12) & 0xf;
         wrd = (insn >> 16) & 0xf;
         if (rd == 15 || ((insn >> 22) & 3) == 3)
@@ -2251,7 +2251,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         }
         store_reg(s, rd, tmp);
         break;
-    case 0x117: case 0x517: case 0x917: case 0xd17:	/* TEXTRC */
+    case 0x117: case 0x517: case 0x917: case 0xd17:     /* TEXTRC */
         if ((insn & 0x000ff008) != 0x0003f000 || ((insn >> 22) & 3) == 3)
             return 1;
         tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
@@ -2270,7 +2270,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_set_nzcv(tmp);
         tcg_temp_free_i32(tmp);
         break;
-    case 0x401: case 0x405: case 0x409: case 0x40d:	/* TBCST */
+    case 0x401: case 0x405: case 0x409: case 0x40d:     /* TBCST */
         if (((insn >> 6) & 3) == 3)
             return 1;
         rd = (insn >> 12) & 0xf;
@@ -2291,7 +2291,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
-    case 0x113: case 0x513: case 0x913: case 0xd13:	/* TANDC */
+    case 0x113: case 0x513: case 0x913: case 0xd13:     /* TANDC */
         if ((insn & 0x000ff00f) != 0x0003f000 || ((insn >> 22) & 3) == 3)
             return 1;
         tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
@@ -2319,7 +2319,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         tcg_temp_free_i32(tmp2);
         tcg_temp_free_i32(tmp);
         break;
-    case 0x01c: case 0x41c: case 0x81c: case 0xc1c:	/* WACC */
+    case 0x01c: case 0x41c: case 0x81c: case 0xc1c:     /* WACC */
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
@@ -2339,7 +2339,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
-    case 0x115: case 0x515: case 0x915: case 0xd15:	/* TORC */
+    case 0x115: case 0x515: case 0x915: case 0xd15:     /* TORC */
         if ((insn & 0x000ff00f) != 0x0003f000 || ((insn >> 22) & 3) == 3)
             return 1;
         tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
@@ -2367,7 +2367,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         tcg_temp_free_i32(tmp2);
         tcg_temp_free_i32(tmp);
         break;
-    case 0x103: case 0x503: case 0x903: case 0xd03:	/* TMOVMSK */
+    case 0x103: case 0x503: case 0x903: case 0xd03:     /* TMOVMSK */
         rd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         if ((insn & 0xf) != 0 || ((insn >> 22) & 3) == 3)
@@ -2387,7 +2387,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         }
         store_reg(s, rd, tmp);
         break;
-    case 0x106: case 0x306: case 0x506: case 0x706:	/* WCMPGT */
+    case 0x106: case 0x306: case 0x506: case 0x706:     /* WCMPGT */
     case 0x906: case 0xb06: case 0xd06: case 0xf06:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
@@ -2419,7 +2419,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x00e: case 0x20e: case 0x40e: case 0x60e:	/* WUNPCKEL */
+    case 0x00e: case 0x20e: case 0x40e: case 0x60e:     /* WUNPCKEL */
     case 0x80e: case 0xa0e: case 0xc0e: case 0xe0e:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
@@ -2450,7 +2450,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x00c: case 0x20c: case 0x40c: case 0x60c:	/* WUNPCKEH */
+    case 0x00c: case 0x20c: case 0x40c: case 0x60c:     /* WUNPCKEH */
     case 0x80c: case 0xa0c: case 0xc0c: case 0xe0c:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
@@ -2481,7 +2481,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x204: case 0x604: case 0xa04: case 0xe04:	/* WSRL */
+    case 0x204: case 0x604: case 0xa04: case 0xe04:     /* WSRL */
     case 0x214: case 0x614: case 0xa14: case 0xe14:
         if (((insn >> 22) & 3) == 0)
             return 1;
@@ -2509,7 +2509,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x004: case 0x404: case 0x804: case 0xc04:	/* WSRA */
+    case 0x004: case 0x404: case 0x804: case 0xc04:     /* WSRA */
     case 0x014: case 0x414: case 0x814: case 0xc14:
         if (((insn >> 22) & 3) == 0)
             return 1;
@@ -2537,7 +2537,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x104: case 0x504: case 0x904: case 0xd04:	/* WSLL */
+    case 0x104: case 0x504: case 0x904: case 0xd04:     /* WSLL */
     case 0x114: case 0x514: case 0x914: case 0xd14:
         if (((insn >> 22) & 3) == 0)
             return 1;
@@ -2565,7 +2565,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x304: case 0x704: case 0xb04: case 0xf04:	/* WROR */
+    case 0x304: case 0x704: case 0xb04: case 0xf04:     /* WROR */
     case 0x314: case 0x714: case 0xb14: case 0xf14:
         if (((insn >> 22) & 3) == 0)
             return 1;
@@ -2601,7 +2601,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x116: case 0x316: case 0x516: case 0x716:	/* WMIN */
+    case 0x116: case 0x316: case 0x516: case 0x716:     /* WMIN */
     case 0x916: case 0xb16: case 0xd16: case 0xf16:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
@@ -2632,7 +2632,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
-    case 0x016: case 0x216: case 0x416: case 0x616:	/* WMAX */
+    case 0x016: case 0x216: case 0x416: case 0x616:     /* WMAX */
     case 0x816: case 0xa16: case 0xc16: case 0xe16:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
@@ -2663,7 +2663,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
-    case 0x002: case 0x102: case 0x202: case 0x302:	/* WALIGNI */
+    case 0x002: case 0x102: case 0x202: case 0x302:     /* WALIGNI */
     case 0x402: case 0x502: case 0x602: case 0x702:
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
@@ -2676,7 +2676,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
-    case 0x01a: case 0x11a: case 0x21a: case 0x31a:	/* WSUB */
+    case 0x01a: case 0x11a: case 0x21a: case 0x31a:     /* WSUB */
     case 0x41a: case 0x51a: case 0x61a: case 0x71a:
     case 0x81a: case 0x91a: case 0xa1a: case 0xb1a:
     case 0xc1a: case 0xd1a: case 0xe1a: case 0xf1a:
@@ -2719,7 +2719,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x01e: case 0x11e: case 0x21e: case 0x31e:	/* WSHUFH */
+    case 0x01e: case 0x11e: case 0x21e: case 0x31e:     /* WSHUFH */
     case 0x41e: case 0x51e: case 0x61e: case 0x71e:
     case 0x81e: case 0x91e: case 0xa1e: case 0xb1e:
     case 0xc1e: case 0xd1e: case 0xe1e: case 0xf1e:
@@ -2733,7 +2733,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x018: case 0x118: case 0x218: case 0x318:	/* WADD */
+    case 0x018: case 0x118: case 0x218: case 0x318:     /* WADD */
     case 0x418: case 0x518: case 0x618: case 0x718:
     case 0x818: case 0x918: case 0xa18: case 0xb18:
     case 0xc18: case 0xd18: case 0xe18: case 0xf18:
@@ -2776,7 +2776,7 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         gen_op_iwmmxt_set_cup();
         break;
-    case 0x008: case 0x108: case 0x208: case 0x308:	/* WPACK */
+    case 0x008: case 0x108: case 0x208: case 0x308:     /* WPACK */
     case 0x408: case 0x508: case 0x608: case 0x708:
     case 0x808: case 0x908: case 0xa08: case 0xb08:
     case 0xc08: case 0xd08: case 0xe08: case 0xf08:
@@ -2823,13 +2823,13 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         tmp = load_reg(s, rd0);
         tmp2 = load_reg(s, rd1);
         switch ((insn >> 16) & 0xf) {
-        case 0x0:					/* TMIA */
+        case 0x0:                                       /* TMIA */
             gen_helper_iwmmxt_muladdsl(cpu_M0, cpu_M0, tmp, tmp2);
             break;
-        case 0x8:					/* TMIAPH */
+        case 0x8:                                       /* TMIAPH */
             gen_helper_iwmmxt_muladdsw(cpu_M0, cpu_M0, tmp, tmp2);
             break;
-        case 0xc: case 0xd: case 0xe: case 0xf:		/* TMIAxy */
+        case 0xc: case 0xd: case 0xe: case 0xf:                 /* TMIAxy */
             if (insn & (1 << 16))
                 tcg_gen_shri_i32(tmp, tmp, 16);
             if (insn & (1 << 17))
@@ -2872,16 +2872,16 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
         tmp = load_reg(s, rd0);
         tmp2 = load_reg(s, rd1);
         switch ((insn >> 16) & 0xf) {
-        case 0x0:					/* MIA */
+        case 0x0:                                       /* MIA */
             gen_helper_iwmmxt_muladdsl(cpu_M0, cpu_M0, tmp, tmp2);
             break;
-        case 0x8:					/* MIAPH */
+        case 0x8:                                       /* MIAPH */
             gen_helper_iwmmxt_muladdsw(cpu_M0, cpu_M0, tmp, tmp2);
             break;
-        case 0xc:					/* MIABB */
-        case 0xd:					/* MIABT */
-        case 0xe:					/* MIATB */
-        case 0xf:					/* MIATT */
+        case 0xc:                                       /* MIABB */
+        case 0xd:                                       /* MIABT */
+        case 0xe:                                       /* MIATB */
+        case 0xf:                                       /* MIATT */
             if (insn & (1 << 16))
                 tcg_gen_shri_i32(tmp, tmp, 16);
             if (insn & (1 << 17))
@@ -2907,13 +2907,13 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
         if (acc != 0)
             return 1;
 
-        if (insn & ARM_CP_RW_BIT) {			/* MRA */
+        if (insn & ARM_CP_RW_BIT) {                     /* MRA */
             iwmmxt_load_reg(cpu_V0, acc);
             tcg_gen_extrl_i64_i32(cpu_R[rdlo], cpu_V0);
             tcg_gen_shri_i64(cpu_V0, cpu_V0, 32);
             tcg_gen_extrl_i64_i32(cpu_R[rdhi], cpu_V0);
             tcg_gen_andi_i32(cpu_R[rdhi], cpu_R[rdhi], (1 << (40 - 32)) - 1);
-        } else {					/* MAR */
+        } else {                                        /* MAR */
             tcg_gen_concat_i32_i64(cpu_V0, cpu_R[rdlo], cpu_R[rdhi]);
             iwmmxt_store_reg(cpu_V0, acc);
         }
-- 
2.18.0
