Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588CCC072B1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D692083D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2/sjQdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D692083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSDUx-0007QL-9c
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 00:32:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSDSl-0005d1-Ki
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSDEV-0004oI-7w
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:15:37 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSDEU-0004nk-Vj
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:15:35 -0400
Received: by mail-pl1-x644.google.com with SMTP id c5so5127253pll.11
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 21:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=oKgfkKq1+9tZLjqz20VcCB7egfqrJKKXg2fY4UFHrI4=;
	b=j2/sjQdBHABD4UhA4Rt83wxenWjCDpCr3kp5JLoxI0wKq5DBew1u7hU1T1M/uFGknB
	gBpgzzcqyiTs0PxVRquvA3I6gRiu7a1QOM9tG1crnBtDXGXO+Dw8oqIahq4XBXlb6enQ
	GEu5hUgjj7TZGNWEQtErvCsVZ7KQjeAXwS1mQfy1vFr6jAa0J0h6W4c4o26v9agILssN
	NpyPMOmnNvfHyQahAaFaAZRr78hbHHvPH5coR8tkro6+ShyIO2oGuXjfJ3yxA/0mR3iJ
	SzR86GsNbcMNNwfXNKJwvIRJTWUkPOtDI4RJg8QWX9MEqJ1JrG3yZANGuxG0WVtahdeW
	nK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=oKgfkKq1+9tZLjqz20VcCB7egfqrJKKXg2fY4UFHrI4=;
	b=KYCP9jaACAC42vC4ceMnVpxjKz178YYHGbiJCmlWcWRZ+o9hIBo7/FnsgEIa8x/O23
	OtwM+OAe8JLhIeKOZdeaCjJWC/wBAYaQ633x263lKpgqn6qjpTASBimxlCpZl3aLsX14
	vZfYiXPKFcLrnUEc0Pe+7a6PDJaKU55a2JKG7XcSp46pJu4Edf9bUID9pwK6Z83LEIue
	gHwS1A/NAJmtTdJyNXc9uMm1CtwpT240HNCKAM1NP9wzPCc4+msk1P5Oau12hwdbxb9t
	NsyNgW12A+UeLEyOBfB9fv3TOwuS60OnxSm4kgNJShQv0vSREOXDPwjCFm5Z0rVr7Ld3
	D0wQ==
X-Gm-Message-State: APjAAAWFc+nUodrxkZAPxKxbe2CBE1hCzclB2KoqEwK4zqHBU8hpgVNt
	pGsS3IiWjKM4fN4JF3aClOj0cUd5YdU=
X-Google-Smtp-Source: APXvYqwmPvaUfTzwZS7fsSR1I+N3fr7LAxdDMLx8ggWBmR07vYERZ5h5osT/xN+HoYs1bgbIf6NK1Q==
X-Received: by 2002:a17:902:294a:: with SMTP id
	g68mr42807780plb.169.1558239333373; 
	Sat, 18 May 2019 21:15:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	k63sm19381200pfb.108.2019.05.18.21.15.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 21:15:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 21:15:22 -0700
Message-Id: <20190519041522.12327-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519041522.12327-1-richard.henderson@linaro.org>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v4 7/7] tcg/ppc: Update vector support to v3.00
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
Cc: mark.cave-ayland@ilande.co.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes vector load/store with immediate offset, some extra
move and splat insns, compare ne, and negate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index dedf0de04d..4ee77df178 100644
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
@@ -2986,6 +3018,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
         return vece <= MO_32 || have_isa_2_07_vsx ? -1 : 0;
+    case INDEX_op_neg_vec:
+        return vece >= MO_32 && have_isa_3_00_vsx;
     case INDEX_op_mul_vec:
         switch (vece) {
         case MO_8:
@@ -3006,7 +3040,22 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
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
@@ -3045,7 +3094,11 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
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
@@ -3054,7 +3107,11 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
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
@@ -3062,6 +3119,10 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
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
@@ -3101,7 +3162,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const uint32_t
         add_op[4] = { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
         sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
+        neg_op[4] = { 0, 0, VNEGW, VNEGD },
         eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
+        ne_op[4]  = { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
         gts_op[4] = { VCMPGTSB, VCMPGTSH, VCMPGTSW, VCMPGTSD },
         gtu_op[4] = { VCMPGTUB, VCMPGTUH, VCMPGTUW, VCMPGTUD },
         ssadd_op[4] = { VADDSBS, VADDSHS, VADDSWS, 0 },
@@ -3143,6 +3206,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -3205,6 +3273,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         case TCG_COND_EQ:
             insn = eq_op[vece];
             break;
+        case TCG_COND_NE:
+            insn = ne_op[vece];
+            break;
         case TCG_COND_GT:
             insn = gts_op[vece];
             break;
@@ -3287,6 +3358,10 @@ static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
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
@@ -3442,6 +3517,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef sub2
         = { .args_ct_str = { "r", "r", "rI", "rZM", "r", "r" } };
     static const TCGTargetOpDef v_r = { .args_ct_str = { "v", "r" } };
+    static const TCGTargetOpDef v_vr = { .args_ct_str = { "v", "vr" } };
     static const TCGTargetOpDef v_v = { .args_ct_str = { "v", "v" } };
     static const TCGTargetOpDef v_v_v = { .args_ct_str = { "v", "v", "v" } };
     static const TCGTargetOpDef v_v_v_v
@@ -3610,8 +3686,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
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
@@ -3647,6 +3725,9 @@ static void tcg_target_init(TCGContext *s)
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


