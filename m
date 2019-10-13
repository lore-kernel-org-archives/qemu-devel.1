Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC343C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A657C206A3
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceUz71Zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A657C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmec-00053y-Ti
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJX-00072R-1x
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJV-00011E-A8
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:10 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:45746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJU-00010f-S0
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:09 -0400
Received: by mail-pg1-x52d.google.com with SMTP id r1so7738126pgj.12
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mF2dwYJWcVeNG6LNSvu0FtPI46NJT+aJNqlh22HKVwc=;
 b=ceUz71ZvoOBjtCCepwkDSKuRGlVbn1gpq4saYnsF8mdmwITvmbkmuUfwdn0qGfQcNq
 tCqkS6dWgQtNHQWeHNJOsZLkN3uIHgzVzlXJ5H4fKvbJK6RfhZ4aqAQDU8PJyexvuobf
 7f5Hp1k1bFCK4fN2kH6WpDoGtbNqInzUTNcbIL/bZcR+YygUx4yX7rvzom2tE7X4fMMr
 GRuvas32oDH1/0SKR5gfgvDItZ+bbg1HSWoddMwzD6g6GTFgDG2gmnlQZpwz7UKULUZT
 ooHi5JkgZ5m+4Kl4dOeyWYdMEhGbm1P1sKJ4QgzAZYTH2FP866bxI3kYGX1tBSxdhENe
 zJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mF2dwYJWcVeNG6LNSvu0FtPI46NJT+aJNqlh22HKVwc=;
 b=HFty2ul+KadHsjx1tb8u0T4/HoMjKHlxP1YpvEj6mNyJf+Uvs/g3IDq+UjPiV6NnFV
 hwLYcOYbt+tz6bTsu0nEzrfaLHn6a3O+Yx8vyae5jjUU7WzBaomzU1xJ2tx0XsLK9DjC
 iAcd/XlsFWsiSxfVCcRZWSaOPhVr+YIqDVN6E+fDT80YtxHCeIll8K0CrtWIRmn1Ksyl
 vMgzbRHX2H1l1PdL/5o8C0+raZ64VYUjrTwzBnV6H6KmXlb4m8iFRbyzGe0gXW2Ln5x5
 jS6OoGc/25q28pEC5ovU7eeh3s32lFydnCcv7MF7fp/e8ki2rhjzFjANb5B+0qM29pL/
 r/mA==
X-Gm-Message-State: APjAAAXlKp9fn0wQZJDlTwDadzyJM6DNe+k2ENUVpVy47BMAcX1MCj4z
 QAUjTUKuoLWm9SKZYXjNey7vr2NNnYw=
X-Google-Smtp-Source: APXvYqweMgBKxI0s8kMTRUQcooWY3d2ku+S//JpqQN3iZ/OjXD2xFsy/3iq3D3MT/vRoewnV7ixjog==
X-Received: by 2002:a63:e057:: with SMTP id n23mr28703107pgj.94.1571005567556; 
 Sun, 13 Oct 2019 15:26:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/23] tcg/ppc: Update vector support for VSX
Date: Sun, 13 Oct 2019 15:25:37 -0700
Message-Id: <20191013222544.3679-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
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
Cc: peter.maydell@linaro.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VSX instruction set instructions include double-word loads and
stores, double-word load and splat, double-word permute, and bit
select.  All of which require multiple operations in the Altivec
instruction set.

Because the VSX registers map %vsr32 to %vr0, and we have no current
intention or need to use vector registers outside %vr0-%vr19, force
on the {ax,bx,cx,tx} bits within the added VSX insns so that we don't
have to otherwise modify the VR[TABC] macros.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |  5 ++--
 tcg/ppc/tcg-target.inc.c | 52 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index f50b7f4bac..c974ca274a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -66,6 +66,7 @@ typedef enum {
 
 extern TCGPowerISA have_isa;
 extern bool have_altivec;
+extern bool have_vsx;
 
 #define have_isa_2_06  (have_isa >= tcg_isa_2_06)
 #define have_isa_3_00  (have_isa >= tcg_isa_3_00)
@@ -149,7 +150,7 @@ extern bool have_altivec;
  * instruction and substituting two 32-bit stores makes the generated
  * code quite large.
  */
-#define TCG_TARGET_HAS_v64              0
+#define TCG_TARGET_HAS_v64              have_vsx
 #define TCG_TARGET_HAS_v128             have_altivec
 #define TCG_TARGET_HAS_v256             0
 
@@ -165,7 +166,7 @@ extern bool have_altivec;
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       have_vsx
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
 void flush_icache_range(uintptr_t start, uintptr_t stop);
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index d739f4b605..2388958405 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -67,6 +67,7 @@ static tcg_insn_unit *tb_ret_addr;
 TCGPowerISA have_isa;
 static bool have_isel;
 bool have_altivec;
+bool have_vsx;
 
 #ifndef CONFIG_SOFTMMU
 #define TCG_GUEST_BASE_REG 30
@@ -467,9 +468,12 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define LVEBX      XO31(7)
 #define LVEHX      XO31(39)
 #define LVEWX      XO31(71)
+#define LXSDX      (XO31(588) | 1)  /* v2.06, force tx=1 */
+#define LXVDSX     (XO31(332) | 1)  /* v2.06, force tx=1 */
 
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
+#define STXSDX     (XO31(716) | 1)  /* v2.06, force sx=1 */
 
 #define VADDSBS    VX4(768)
 #define VADDUBS    VX4(512)
@@ -558,6 +562,9 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 
 #define VSLDOI     VX4(44)
 
+#define XXPERMDI   (OPCD(60) | (10 << 3) | 7)  /* v2.06, force ax=bx=tx=1 */
+#define XXSEL      (OPCD(60) | (3 << 4) | 0xf) /* v2.06, force ax=bx=cx=tx=1 */
+
 #define RT(r) ((r)<<21)
 #define RS(r) ((r)<<21)
 #define RA(r) ((r)<<16)
@@ -884,11 +891,21 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
         add = 0;
     }
 
-    load_insn = LVX | VRT(ret) | RB(TCG_REG_TMP1);
-    if (TCG_TARGET_REG_BITS == 64) {
-        new_pool_l2(s, rel, s->code_ptr, add, val, val);
+    if (have_vsx) {
+        load_insn = type == TCG_TYPE_V64 ? LXSDX : LXVDSX;
+        load_insn |= VRT(ret) | RB(TCG_REG_TMP1);
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
@@ -1136,6 +1153,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
         /* fallthru */
     case TCG_TYPE_V64:
         tcg_debug_assert(ret >= TCG_REG_V0);
+        if (have_vsx) {
+            tcg_out_mem_long(s, 0, LXSDX, ret, base, offset);
+            break;
+        }
         tcg_debug_assert((offset & 7) == 0);
         tcg_out_mem_long(s, 0, LVX, ret, base, offset & -16);
         if (offset & 8) {
@@ -1180,6 +1201,10 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         /* fallthru */
     case TCG_TYPE_V64:
         tcg_debug_assert(arg >= TCG_REG_V0);
+        if (have_vsx) {
+            tcg_out_mem_long(s, 0, STXSDX, arg, base, offset);
+            break;
+        }
         tcg_debug_assert((offset & 7) == 0);
         if (offset & 8) {
             tcg_out_vsldoi(s, TCG_VEC_TMP1, arg, arg, 8);
@@ -2899,6 +2924,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
         return vece <= MO_32 ? -1 : 0;
+    case INDEX_op_bitsel_vec:
+        return have_vsx;
     default:
         return 0;
     }
@@ -2925,6 +2952,10 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
         tcg_out32(s, VSPLTW | VRT(dst) | VRB(src) | (1 << 16));
         break;
     case MO_64:
+        if (have_vsx) {
+            tcg_out32(s, XXPERMDI | VRT(dst) | VRA(src) | VRB(src));
+            break;
+        }
         tcg_out_vsldoi(s, TCG_VEC_TMP1, src, src, 8);
         tcg_out_vsldoi(s, dst, TCG_VEC_TMP1, src, 8);
         break;
@@ -2968,6 +2999,10 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
         tcg_out32(s, VSPLTW | VRT(out) | VRB(out) | (elt << 16));
         break;
     case MO_64:
+        if (have_vsx) {
+            tcg_out_mem_long(s, 0, LXVDSX, out, base, offset);
+            break;
+        }
         tcg_debug_assert((offset & 7) == 0);
         tcg_out_mem_long(s, 0, LVX, out, base, offset & -16);
         tcg_out_vsldoi(s, TCG_VEC_TMP1, out, out, 8);
@@ -3102,6 +3137,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_bitsel_vec:
+        tcg_out32(s, XXSEL | VRT(a0) | VRC(a1) | VRB(a2) | VRA(args[3]));
+        return;
+
     case INDEX_op_dup2_vec:
         assert(TCG_TARGET_REG_BITS == 32);
         /* With inputs a1 = xLxx, a2 = xHxx  */
@@ -3497,6 +3536,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st_vec:
     case INDEX_op_dupm_vec:
         return &v_r;
+    case INDEX_op_bitsel_vec:
     case INDEX_op_ppc_msum_vec:
         return &v_v_v_v;
 
@@ -3530,6 +3570,10 @@ static void tcg_target_init(TCGContext *s)
 
     if (hwcap & PPC_FEATURE_HAS_ALTIVEC) {
         have_altivec = true;
+        /* We only care about the portion of VSX that overlaps Altivec. */
+        if (hwcap & PPC_FEATURE_HAS_VSX) {
+            have_vsx = true;
+        }
     }
 
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffff;
-- 
2.17.1


