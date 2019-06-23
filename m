Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD213C43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945CF2073F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945CF2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf6Dn-0007it-OK
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 13:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34344)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hf5wk-0001oN-TO
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hf5wg-0004rl-UM
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41132 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hf5wc-0004JZ-2Z
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:24 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id EAD8E1A1DEC;
 Sun, 23 Jun 2019 19:05:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id B8C0D1A1DDA;
 Sun, 23 Jun 2019 19:05:45 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Sun, 23 Jun 2019 19:04:49 +0200
Message-Id: <1561309489-16146-17-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561309489-16146-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561309489-16146-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v5 16/16] tcg/ppc: Update vector support to
 v3.00
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
Cc: richard.henderson@linaro.org,
 "David Gibson --cc=amarkovic @ wavecomp . com"
 <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This includes vector load/store with immediate offset, some extra
move and splat insns, compare ne, and negate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |   3 +-
 tcg/ppc/tcg-target.inc.c | 103 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index b8355d0..533f0ef 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -63,6 +63,7 @@ extern bool have_isa_2_06;
 extern bool have_isa_2_06_vsx;
 extern bool have_isa_2_07_vsx;
 extern bool have_isa_3_00;
+extern bool have_isa_3_00_vsx;
 
 /* optional instructions automatically implemented */
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
@@ -150,7 +151,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_andc_vec         1
 #define TCG_TARGET_HAS_orc_vec          have_isa_2_07_vsx
 #define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_neg_vec          have_isa_3_00_vsx
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index badbe2c..6cc56cf 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -69,6 +69,7 @@ bool have_isa_2_06;
 bool have_isa_2_06_vsx;
 bool have_isa_2_07_vsx;
 bool have_isa_3_00;
+bool have_isa_3_00_vsx;
 
 #define HAVE_ISA_2_06  have_isa_2_06
 #define HAVE_ISEL      have_isa_2_06
@@ -475,11 +476,16 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define LXSDX      XO31(588)      /* v2.06 */
 #define LXVDSX     XO31(332)      /* v2.06 */
 #define LXSIWZX    XO31(12)       /* v2.07 */
+#define LXV        (OPCD(61) | 1) /* v3.00 */
+#define LXSD       (OPCD(57) | 2) /* v3.00 */
+#define LXVWSX     XO31(364)      /* v3.00 */
 
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
 #define STXSDX     XO31(716)      /* v2.06 */
 #define STXSIWX    XO31(140)      /* v2.07 */
+#define STXV       (OPCD(61) | 5) /* v3.00 */
+#define STXSD      (OPCD(61) | 2) /* v3.00 */
 
 #define VADDSBS    VX4(768)
 #define VADDUBS    VX4(512)
@@ -503,6 +509,9 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VSUBUWM    VX4(1152)
 #define VSUBUDM    VX4(1216)      /* v2.07 */
 
+#define VNEGW      (VX4(1538) | (6 << 16))  /* v3.00 */
+#define VNEGD      (VX4(1538) | (7 << 16))  /* v3.00 */
+
 #define VMAXSB     VX4(258)
 #define VMAXSH     VX4(322)
 #define VMAXSW     VX4(386)
@@ -532,6 +541,9 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VCMPGTUH   VX4(582)
 #define VCMPGTUW   VX4(646)
 #define VCMPGTUD   VX4(711)       /* v2.07 */
+#define VCMPNEB    VX4(7)         /* v3.00 */
+#define VCMPNEH    VX4(71)        /* v3.00 */
+#define VCMPNEW    VX4(135)       /* v3.00 */
 
 #define VSLB       VX4(260)
 #define VSLH       VX4(324)
@@ -589,11 +601,14 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 
 #define XXPERMDI   (OPCD(60) | (10 << 3))   /* v2.06 */
 #define XXSEL      (OPCD(60) | (3 << 4))    /* v2.06 */
+#define XXSPLTIB   (OPCD(60) | (360 << 1))  /* v3.00 */
 
 #define MFVSRD     XO31(51)       /* v2.07 */
 #define MFVSRWZ    XO31(115)      /* v2.07 */
 #define MTVSRD     XO31(179)      /* v2.07 */
 #define MTVSRWZ    XO31(179)      /* v2.07 */
+#define MTVSRDD    XO31(435)      /* v3.00 */
+#define MTVSRWS    XO31(403)      /* v3.00 */
 
 #define RT(r) ((r)<<21)
 #define RS(r) ((r)<<21)
@@ -917,6 +932,10 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
             return;
         }
     }
+    if (have_isa_3_00_vsx && val == (tcg_target_long)dup_const(MO_8, val)) {
+        tcg_out32(s, XXSPLTIB | VRT(ret) | ((val & 0xff) << 11) | 1);
+        return;
+    }
 
     /*
      * Otherwise we must load the value from the constant pool.
@@ -1105,7 +1124,7 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
                              TCGReg base, tcg_target_long offset)
 {
     tcg_target_long orig = offset, l0, l1, extra = 0, align = 0;
-    bool is_store = false;
+    bool is_int_store = false;
     TCGReg rs = TCG_REG_TMP1;
 
     switch (opi) {
@@ -1118,11 +1137,20 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
             break;
         }
         break;
+    case LXSD:
+    case STXSD:
+        align = 3;
+        break;
+    case LXV: case LXV | 8:
+    case STXV: case STXV | 8:
+        /* The |8 cases force altivec registers.  */
+        align = 15;
+        break;
     case STD:
         align = 3;
         /* FALLTHRU */
     case STB: case STH: case STW:
-        is_store = true;
+        is_int_store = true;
         break;
     }
 
@@ -1131,7 +1159,7 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
         if (rs == base) {
             rs = TCG_REG_R0;
         }
-        tcg_debug_assert(!is_store || rs != rt);
+        tcg_debug_assert(!is_int_store || rs != rt);
         tcg_out_movi(s, TCG_TYPE_PTR, rs, orig);
         tcg_out32(s, opx | TAB(rt, base, rs));
         return;
@@ -1195,7 +1223,8 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
     case TCG_TYPE_V64:
         tcg_debug_assert(ret >= 32);
         if (have_isa_2_06_vsx) {
-            tcg_out_mem_long(s, 0, LXSDX | 1, ret & 31, base, offset);
+            tcg_out_mem_long(s, have_isa_3_00_vsx ? LXSD : 0, LXSDX | 1,
+                             ret & 31, base, offset);
             break;
         }
         assert((offset & 7) == 0);
@@ -1207,7 +1236,8 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
     case TCG_TYPE_V128:
         tcg_debug_assert(ret >= 32);
         assert((offset & 15) == 0);
-        tcg_out_mem_long(s, 0, LVX, ret & 31, base, offset);
+        tcg_out_mem_long(s, have_isa_3_00_vsx ? LXV | 8 : 0, LVX,
+                         ret & 31, base, offset);
         break;
     default:
         g_assert_not_reached();
@@ -1246,7 +1276,8 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
     case TCG_TYPE_V64:
         tcg_debug_assert(arg >= 32);
         if (have_isa_2_06_vsx) {
-            tcg_out_mem_long(s, 0, STXSDX | 1, arg & 31, base, offset);
+            tcg_out_mem_long(s, have_isa_3_00_vsx ? STXSD : 0,
+                             STXSDX | 1, arg & 31, base, offset);
             break;
         }
         assert((offset & 7) == 0);
@@ -1259,7 +1290,8 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         break;
     case TCG_TYPE_V128:
         tcg_debug_assert(arg >= 32);
-        tcg_out_mem_long(s, 0, STVX, arg & 31, base, offset);
+        tcg_out_mem_long(s, have_isa_3_00_vsx ? STXV | 8 : 0, STVX,
+                         arg & 31, base, offset);
         break;
     default:
         g_assert_not_reached();
@@ -2970,6 +3002,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
         return vece <= MO_32 || have_isa_2_07_vsx ? -1 : 0;
+    case INDEX_op_neg_vec:
+        return vece >= MO_32 && have_isa_3_00_vsx;
     case INDEX_op_mul_vec:
         switch (vece) {
         case MO_8:
@@ -2990,7 +3024,22 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src)
 {
     tcg_debug_assert(dst >= 32);
-    tcg_debug_assert(src >= 32);
+
+    /* Splat from integer reg allowed via constraints for v3.00.  */
+    if (src < 32) {
+        tcg_debug_assert(have_isa_3_00_vsx);
+        switch (vece) {
+        case MO_64:
+            tcg_out32(s, MTVSRDD | 1 | VRT(dst) | RA(src) | RB(src));
+            return true;
+        case MO_32:
+            tcg_out32(s, MTVSRWS | 1 | VRT(dst) | RA(src));
+            return true;
+        default:
+            /* Fail, so that we fall back on either dupm or mov+dup.  */
+            return false;
+        }
+    }
 
     /*
      * Recall we use (or emulate) VSX integer loads, so the integer is
@@ -3029,7 +3078,11 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
     out &= 31;
     switch (vece) {
     case MO_8:
-        tcg_out_mem_long(s, 0, LVEBX, out, base, offset);
+        if (have_isa_3_00_vsx) {
+            tcg_out_mem_long(s, LXV | 8, LVX, out, base, offset & -16);
+        } else {
+            tcg_out_mem_long(s, 0, LVEBX, out, base, offset);
+        }
         elt = extract32(offset, 0, 4);
 #ifndef HOST_WORDS_BIGENDIAN
         elt ^= 15;
@@ -3038,7 +3091,11 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
         break;
     case MO_16:
         assert((offset & 1) == 0);
-        tcg_out_mem_long(s, 0, LVEHX, out, base, offset);
+        if (have_isa_3_00_vsx) {
+            tcg_out_mem_long(s, LXV | 8, LVX, out, base, offset & -16);
+        } else {
+            tcg_out_mem_long(s, 0, LVEHX, out, base, offset);
+        }
         elt = extract32(offset, 1, 3);
 #ifndef HOST_WORDS_BIGENDIAN
         elt ^= 7;
@@ -3046,6 +3103,10 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
         tcg_out32(s, VSPLTH | VRT(out) | VRB(out) | (elt << 16));
         break;
     case MO_32:
+        if (have_isa_3_00_vsx) {
+            tcg_out_mem_long(s, 0, LXVWSX | 1, out, base, offset);
+            break;
+        }
         assert((offset & 3) == 0);
         tcg_out_mem_long(s, 0, LVEWX, out, base, offset);
         elt = extract32(offset, 2, 2);
@@ -3085,7 +3146,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const uint32_t
         add_op[4] = { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
         sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
+        neg_op[4] = { 0, 0, VNEGW, VNEGD },
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
+        ne_op[4]  = { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
         gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, VCMPGTSD },
         gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, VCMPGTUD },
         ssadd_op[4] = { VADDSBS, VADDSHS, VADDSWS, 0 },
@@ -3127,6 +3190,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sub_vec:
         insn = sub_op[vece];
         break;
+    case INDEX_op_neg_vec:
+        insn = neg_op[vece];
+        a2 = a1;
+        a1 = 0;
+        break;
     case INDEX_op_mul_vec:
         tcg_debug_assert(vece == MO_32 && have_isa_2_07_vsx);
         insn = VMULUWM;
@@ -3189,6 +3257,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         case TCG_COND_EQ:
             insn = eq_op[vece];
             break;
+        case TCG_COND_NE:
+            insn = ne_op[vece];
+            break;
         case TCG_COND_GT:
             insn = gts_op[vece];
             break;
@@ -3271,6 +3342,10 @@ static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
     case TCG_COND_GTU:
         break;
     case TCG_COND_NE:
+        if (have_isa_3_00_vsx && vece <= MO_32) {
+            break;
+        }
+        /* fall through */
     case TCG_COND_LE:
     case TCG_COND_LEU:
         need_inv = true;
@@ -3426,6 +3501,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef sub2
         = { .args_ct_str = { "r", "r", "rI", "rZM", "r", "r" } };
     static const TCGTargetOpDef v_r = { .args_ct_str = { "v", "r" } };
+    static const TCGTargetOpDef v_vr = { .args_ct_str = { "v", "vr" } };
     static const TCGTargetOpDef v_v = { .args_ct_str = { "v", "v" } };
     static const TCGTargetOpDef v_v_v = { .args_ct_str = { "v", "v", "v" } };
     static const TCGTargetOpDef v_v_v_v
@@ -3594,8 +3670,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dup2_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
-    case INDEX_op_dup_vec:
+    case INDEX_op_neg_vec:
         return &v_v;
+    case INDEX_op_dup_vec:
+        return have_isa_3_00_vsx ? &v_vr : &v_v;
     case INDEX_op_ld_vec:
     case INDEX_op_st_vec:
     case INDEX_op_dupm_vec:
@@ -3631,6 +3709,9 @@ static void tcg_target_init(TCGContext *s)
 #ifdef PPC_FEATURE2_ARCH_3_00
     if (hwcap2 & PPC_FEATURE2_ARCH_3_00) {
         have_isa_3_00 = true;
+        if (hwcap & PPC_FEATURE_HAS_VSX) {
+            have_isa_3_00_vsx = true;
+        }
     }
 #endif
 
-- 
2.7.4


