Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5200C072AF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7093D2083D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdJ3zGHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7093D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43686 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSDUw-0007Pm-Jw
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 00:32:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSDSn-0005d1-GE
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSDES-0004nE-Pm
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:15:34 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSDES-0004mV-JB
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:15:32 -0400
Received: by mail-pl1-x643.google.com with SMTP id p15so5159286pll.4
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 21:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6/HEiycpcQzccLPdSh6Q1zLPpis03yT1JpL1zJXm4b0=;
	b=fdJ3zGHJnlYXhGiSCivxYWc9TGJ7t9NbClEplviwFo1xVeA4u1izeHTczpY1HH6z0S
	k6GlzuWbUbdGbMSBR6qJ75RNfS3cjKKUUtnGqrmE+XJb5lPx8snw48UJdMGfB6wKyG7y
	w82rw6KClCZM79ggifzPCD+Efq25wB7DrYoFHGVZD6/H8Vuj/GDKT1BDHOGSL5uy4tON
	pFnRcjzq0WUDMe5KnO9nBbr/Ih+eWtspjqj0vIS1BOs5LVZaWmUWiTKU8/SNCI74/DRW
	uPt0OYIQbUo5tuE/aV2DdoigjYA3Wh4rfzYv4/Vzd1hqaKtYm4+U3e8qT7PVX7sgAKG6
	483g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=6/HEiycpcQzccLPdSh6Q1zLPpis03yT1JpL1zJXm4b0=;
	b=c/x8+1jjgUL1o1yzqKZPhy80s7uwUcyTpbRHolcLMAWyHUx1eHjf6+qKhHgf3igMdf
	7/+LuHNsH1Q6AMZ3rZjZ70P1Hmw2T1WkgcJ+u/VwttX5JVan3+IQ/oK4MJEjigjTyAiC
	D6PQ/q1RoLd+I4Wx9pC3v6NLMI9EaznJmpFIuHTD6u/MTFu+cF1IKBGHN2slCy0Cd5Dt
	lFpDucOoWzN+dj7pyENl8d3balQDk1h1UsUkDLVS+Ov4LB0rGqWDJ+ee0HufgTb5zG5s
	VCSHtdL5pqF4bD3jQdl51aWeU67LE6xAkelBp/Ixz0mQqv6klS4EbxHw177X4ihMklxk
	EsEw==
X-Gm-Message-State: APjAAAWbSHj6PWuZvuJHc8OCbDwb0NQAaABPlYljFghaWPkzBV64XT9v
	oiDeWCsz/V5td1NSwlcRjTHr9OrN9wE=
X-Google-Smtp-Source: APXvYqxKPIQlzM6cA0cHX1S82Hwrzd9Gfd1TiH34r1sxEXeZWWhcmHSNaT/MUVDmYkNjOYWjVY1K/g==
X-Received: by 2002:a17:902:2947:: with SMTP id
	g65mr48803059plb.115.1558239330846; 
	Sat, 18 May 2019 21:15:30 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	k63sm19381200pfb.108.2019.05.18.21.15.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 21:15:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 21:15:20 -0700
Message-Id: <20190519041522.12327-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519041522.12327-1-richard.henderson@linaro.org>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v4 5/7] tcg/ppc: Update vector support to v2.06
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

This includes double-word loads and stores, double-word load and splat,
double-word permute, and bit select.  All of which require multiple
operations in the base Altivec instruction set.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.h     |  5 ++--
 tcg/ppc/tcg-target.inc.c | 51 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index a130192cbd..40544f996d 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -60,6 +60,7 @@ typedef enum {
 
 extern bool have_isa_altivec;
 extern bool have_isa_2_06;
+extern bool have_isa_2_06_vsx;
 extern bool have_isa_3_00;
 
 /* optional instructions automatically implemented */
@@ -141,7 +142,7 @@ extern bool have_isa_3_00;
  * instruction and substituting two 32-bit stores makes the generated
  * code quite large.
  */
-#define TCG_TARGET_HAS_v64              0
+#define TCG_TARGET_HAS_v64              have_isa_2_06_vsx
 #define TCG_TARGET_HAS_v128             have_isa_altivec
 #define TCG_TARGET_HAS_v256             0
 
@@ -157,7 +158,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       have_isa_2_06_vsx
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
 void flush_icache_range(uintptr_t start, uintptr_t stop);
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 3219df2e90..6cb8c8f0eb 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -66,6 +66,7 @@ static tcg_insn_unit *tb_ret_addr;
 
 bool have_isa_altivec;
 bool have_isa_2_06;
+bool have_isa_2_06_vsx;
 bool have_isa_3_00;
 
 #define HAVE_ISA_2_06  have_isa_2_06
@@ -470,9 +471,12 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define LVEBX      XO31(7)
 #define LVEHX      XO31(39)
 #define LVEWX      XO31(71)
+#define LXSDX      XO31(588)      /* v2.06 */
+#define LXVDSX     XO31(332)      /* v2.06 */
 
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
+#define STXSDX     XO31(716)      /* v2.06 */
 
 #define VADDSBS    VX4(768)
 #define VADDUBS    VX4(512)
@@ -561,6 +565,9 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 
 #define VSLDOI     VX4(44)
 
+#define XXPERMDI   (OPCD(60) | (10 << 3))   /* v2.06 */
+#define XXSEL      (OPCD(60) | (3 << 4))    /* v2.06 */
+
 #define RT(r) ((r)<<21)
 #define RS(r) ((r)<<21)
 #define RA(r) ((r)<<16)
@@ -887,11 +894,21 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
         add = 0;
     }
 
-    load_insn = LVX | VRT(ret) | RB(TCG_REG_TMP1);
-    if (TCG_TARGET_REG_BITS == 64) {
-        new_pool_l2(s, rel, s->code_ptr, add, val, val);
+    if (have_isa_2_06_vsx) {
+        load_insn = type == TCG_TYPE_V64 ? LXSDX : LXVDSX;
+        load_insn |= VRT(ret) | RB(TCG_REG_TMP1) | 1;
+        if (TCG_TARGET_REG_BITS == 64) {
+            new_pool_label(s, val, rel, s->code_ptr, add);
+        } else {
+            new_pool_l2(s, rel, s->code_ptr, add, val, val);
+        }
     } else {
-        new_pool_l4(s, rel, s->code_ptr, add, val, val, val, val);
+        load_insn = LVX | VRT(ret) | RB(TCG_REG_TMP1);
+        if (TCG_TARGET_REG_BITS == 64) {
+            new_pool_l2(s, rel, s->code_ptr, add, val, val);
+        } else {
+            new_pool_l4(s, rel, s->code_ptr, add, val, val, val, val);
+        }
     }
 
     if (USE_REG_TB) {
@@ -1138,6 +1155,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
         /* fallthru */
     case TCG_TYPE_V64:
         tcg_debug_assert(ret >= 32);
+        if (have_isa_2_06_vsx) {
+            tcg_out_mem_long(s, 0, LXSDX | 1, ret & 31, base, offset);
+            break;
+        }
         assert((offset & 7) == 0);
         tcg_out_mem_long(s, 0, LVX, ret & 31, base, offset & -16);
         if (offset & 8) {
@@ -1181,6 +1202,10 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         /* fallthru */
     case TCG_TYPE_V64:
         tcg_debug_assert(arg >= 32);
+        if (have_isa_2_06_vsx) {
+            tcg_out_mem_long(s, 0, STXSDX | 1, arg & 31, base, offset);
+            break;
+        }
         assert((offset & 7) == 0);
         if (offset & 8) {
             tcg_out_vsldoi(s, TCG_VEC_TMP1, arg, arg, 8);
@@ -2916,6 +2941,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
         return vece <= MO_32 ? -1 : 0;
+    case INDEX_op_bitsel_vec:
+        return have_isa_2_06_vsx;
     default:
         return 0;
     }
@@ -2942,6 +2969,10 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
         tcg_out32(s, VSPLTW | VRT(dst) | VRB(src) | (1 << 16));
         break;
     case MO_64:
+        if (have_isa_2_06_vsx) {
+            tcg_out32(s, XXPERMDI | 7 | VRT(dst) | VRA(src) | VRB(src));
+            break;
+        }
         tcg_out_vsldoi(s, TCG_VEC_TMP1, src, src, 8);
         tcg_out_vsldoi(s, dst, TCG_VEC_TMP1, src, 8);
         break;
@@ -2986,6 +3017,10 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
         tcg_out32(s, VSPLTW | VRT(out) | VRB(out) | (elt << 16));
         break;
     case MO_64:
+        if (have_isa_2_06_vsx) {
+            tcg_out_mem_long(s, 0, LXVDSX | 1, out, base, offset);
+            break;
+        }
         assert((offset & 7) == 0);
         tcg_out_mem_long(s, 0, LVX, out, base, offset & -16);
         tcg_out_vsldoi(s, TCG_VEC_TMP1, out, out, 8);
@@ -3120,6 +3155,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_bitsel_vec:
+        tcg_out32(s, XXSEL | 0xf | VRT(a0) | VRC(a1) | VRB(a2) | VRA(args[3]));
+        return;
+
     case INDEX_op_dup2_vec:
         assert(TCG_TARGET_REG_BITS == 32);
         /* With inputs a1 = xLxx, a2 = xHxx  */
@@ -3515,6 +3554,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st_vec:
     case INDEX_op_dupm_vec:
         return &v_r;
+    case INDEX_op_bitsel_vec:
     case INDEX_op_ppc_msum_vec:
         return &v_v_v_v;
 
@@ -3533,6 +3573,9 @@ static void tcg_target_init(TCGContext *s)
     }
     if (hwcap & PPC_FEATURE_ARCH_2_06) {
         have_isa_2_06 = true;
+        if (hwcap & PPC_FEATURE_HAS_VSX) {
+            have_isa_2_06_vsx = true;
+        }
     }
 #ifdef PPC_FEATURE2_ARCH_3_00
     if (hwcap2 & PPC_FEATURE2_ARCH_3_00) {
-- 
2.17.1


