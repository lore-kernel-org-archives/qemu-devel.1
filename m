Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2452C5B57A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52782054F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDkVTD+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52782054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhDH4-0007Gc-TU
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41348)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCyE-0007zg-9W
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy9-0003dH-CR
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:46 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy8-0003WJ-O4
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:41 -0400
Received: by mail-wr1-x42b.google.com with SMTP id v14so8992528wrr.4
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=O9+kGCJTKEbp04vSZRDnF2OhKTQZTSbfZfx7x3RBRQg=;
 b=nDkVTD+/zmFS1UGtvQEhULI3bGtiiH20OhiC3bFnx+Uij7oudwEHnqd+UNIaM7OxE+
 GiOvjKUDqDaN0KhIqhDynClM5gHMUBkVOpizK9cQ7Ot1Lf+sk9l96tN22/8/JaP7JWO2
 hlqEvaKdywOjyoUZuWH2+Pep1Mh9dU4rF8OkQwxGcEbN11EoNyi0mwyF+zWWWuOrx8dM
 oT3UB8RxHHNmDcTuk1QgX60wQW1PuuzJyUmmCq6qR6kN5fhrFbUwtKG6EoJv9tzi9OoZ
 guivWrNl40pajZ+8PA4y5mFltmBgUr7oMFrFIbhVz0AvQWqKPTlcj9CkCy7vliNJ8tgn
 rNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=O9+kGCJTKEbp04vSZRDnF2OhKTQZTSbfZfx7x3RBRQg=;
 b=V+uI3Hz2LD3szwqWRsKio90jQL60k0A7s4Af7PnWDnxba+rf+khCmj2y9jUBzF99Q0
 x9KPZN5VE33yxw5Rr7OJwdkx960IWn8dnE6eYx0wovhWIwf4inisDeyhZjy6Pl82L4ZT
 9NTgoD/Fxwaw0dvmxAEPa3xp5fYPwBot18CSB/7sB/IPIQ1grOpazBXn1O0mYaEGRMlN
 IRRVz3kMpFQ54IXK+WBdnYSAHnF+VzVoQ8V7Eu1DmpYQ/B4DWPdMdy+mQra1+R+4RkA+
 zGSwuBVayTKzHaCRrOJffl+/MiO7NNTz6dYduaOjq7R3dlM6sGmPKIRIeAdTopd6Uuck
 L+Dg==
X-Gm-Message-State: APjAAAVMB4pWHscV5EiYqputHr6fmJ9FE95otSDkyiutPaGYrrY/9kBD
 v8utlhtOVnkgbewwjNI6gvScKmlV+kgwQA==
X-Google-Smtp-Source: APXvYqyRNje0/14b1Bqx9gnzGgqUHv8y367Buv+MRDb5T+vfFdnYLshmlIny6CZriyZoE8J38k+rCQ==
X-Received: by 2002:adf:fa0d:: with SMTP id m13mr1502609wrr.176.1561813235161; 
 Sat, 29 Jun 2019 06:00:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:17 +0200
Message-Id: <20190629130017.2973-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PATCH v6 16/16] tcg/ppc: Update vector support to
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes vector load/store with immediate offset, some extra
move and splat insns, compare ne, and negate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |   3 +-
 tcg/ppc/tcg-target.inc.c | 103 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index b8355d0a56..533f0ef510 100644
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
index af86ab07dd..6715f29d4a 100644
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
@@ -924,6 +939,10 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
             return;
         }
     }
+    if (have_isa_3_00_vsx && val == (tcg_target_long)dup_const(MO_8, val)) {
+        tcg_out32(s, XXSPLTIB | VRT(ret) | ((val & 0xff) << 11) | 1);
+        return;
+    }
 
     /*
      * Otherwise we must load the value from the constant pool.
@@ -1112,7 +1131,7 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
                              TCGReg base, tcg_target_long offset)
 {
     tcg_target_long orig = offset, l0, l1, extra = 0, align = 0;
-    bool is_store = false;
+    bool is_int_store = false;
     TCGReg rs = TCG_REG_TMP1;
 
     switch (opi) {
@@ -1125,11 +1144,20 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
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
 
@@ -1138,7 +1166,7 @@ static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
         if (rs == base) {
             rs = TCG_REG_R0;
         }
-        tcg_debug_assert(!is_store || rs != rt);
+        tcg_debug_assert(!is_int_store || rs != rt);
         tcg_out_movi(s, TCG_TYPE_PTR, rs, orig);
         tcg_out32(s, opx | TAB(rt & 31, base, rs));
         return;
@@ -1203,7 +1231,8 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
     case TCG_TYPE_V64:
         tcg_debug_assert(ret >= TCG_REG_V0);
         if (have_isa_2_06_vsx) {
-            tcg_out_mem_long(s, 0, LXSDX | 1, ret, base, offset);
+            tcg_out_mem_long(s, have_isa_3_00_vsx ? LXSD : 0, LXSDX | 1,
+                             ret, base, offset);
             break;
         }
         assert((offset & 7) == 0);
@@ -1215,7 +1244,8 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
     case TCG_TYPE_V128:
         tcg_debug_assert(ret >= TCG_REG_V0);
         assert((offset & 15) == 0);
-        tcg_out_mem_long(s, 0, LVX, ret, base, offset);
+        tcg_out_mem_long(s, have_isa_3_00_vsx ? LXV | 8 : 0, LVX,
+                         ret, base, offset);
         break;
     default:
         g_assert_not_reached();
@@ -1255,7 +1285,8 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
     case TCG_TYPE_V64:
         tcg_debug_assert(arg >= TCG_REG_V0);
         if (have_isa_2_06_vsx) {
-            tcg_out_mem_long(s, 0, STXSDX | 1, arg, base, offset);
+            tcg_out_mem_long(s, have_isa_3_00_vsx ? STXSD : 0,
+                             STXSDX | 1, arg, base, offset);
             break;
         }
         assert((offset & 7) == 0);
@@ -1268,7 +1299,8 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         break;
     case TCG_TYPE_V128:
         tcg_debug_assert(arg >= TCG_REG_V0);
-        tcg_out_mem_long(s, 0, STVX, arg, base, offset);
+        tcg_out_mem_long(s, have_isa_3_00_vsx ? STXV | 8 : 0, STVX,
+                         arg, base, offset);
         break;
     default:
         g_assert_not_reached();
@@ -2979,6 +3011,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
         return vece <= MO_32 || have_isa_2_07_vsx ? -1 : 0;
+    case INDEX_op_neg_vec:
+        return vece >= MO_32 && have_isa_3_00_vsx;
     case INDEX_op_mul_vec:
         switch (vece) {
         case MO_8:
@@ -2999,7 +3033,22 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src)
 {
     tcg_debug_assert(dst >= TCG_REG_V0);
-    tcg_debug_assert(src >= TCG_REG_V0);
+
+    /* Splat from integer reg allowed via constraints for v3.00.  */
+    if (src < TCG_REG_V0) {
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
@@ -3037,7 +3086,11 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
     tcg_debug_assert(out >= TCG_REG_V0);
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
@@ -3046,7 +3099,11 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
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
@@ -3054,6 +3111,10 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
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
@@ -3093,7 +3154,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const uint32_t
         add_op[4] = { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
         sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
+        neg_op[4] = { 0, 0, VNEGW, VNEGD },
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
+        ne_op[4]  = { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
         gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, VCMPGTSD },
         gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, VCMPGTUD },
         ssadd_op[4] = { VADDSBS, VADDSHS, VADDSWS, 0 },
@@ -3135,6 +3198,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -3197,6 +3265,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         case TCG_COND_EQ:
             insn = eq_op[vece];
             break;
+        case TCG_COND_NE:
+            insn = ne_op[vece];
+            break;
         case TCG_COND_GT:
             insn = gts_op[vece];
             break;
@@ -3279,6 +3350,10 @@ static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
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
@@ -3434,6 +3509,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef sub2
         = { .args_ct_str = { "r", "r", "rI", "rZM", "r", "r" } };
     static const TCGTargetOpDef v_r = { .args_ct_str = { "v", "r" } };
+    static const TCGTargetOpDef v_vr = { .args_ct_str = { "v", "vr" } };
     static const TCGTargetOpDef v_v = { .args_ct_str = { "v", "v" } };
     static const TCGTargetOpDef v_v_v = { .args_ct_str = { "v", "v", "v" } };
     static const TCGTargetOpDef v_v_v_v
@@ -3602,8 +3678,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
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
@@ -3639,6 +3717,9 @@ static void tcg_target_init(TCGContext *s)
 #ifdef PPC_FEATURE2_ARCH_3_00
     if (hwcap2 & PPC_FEATURE2_ARCH_3_00) {
         have_isa_3_00 = true;
+        if (hwcap & PPC_FEATURE_HAS_VSX) {
+            have_isa_3_00_vsx = true;
+        }
     }
 #endif
 
-- 
2.17.1


