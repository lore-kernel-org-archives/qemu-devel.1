Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8006C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDF3224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4gQ6IwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDF3224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2ZL-0002pG-PW
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B7-0004tO-Ap
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2B3-0005jw-NE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:53 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:42435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2B3-0005jY-FV
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:49 -0400
Received: by mail-pf1-x42c.google.com with SMTP id q12so6221002pff.9
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mF2dwYJWcVeNG6LNSvu0FtPI46NJT+aJNqlh22HKVwc=;
 b=U4gQ6IwUT23InWA7cEkUV5NB2VXgScWEeFdPu0kmbdtT8rYuXAgBJ2wo8RmuJSTayb
 A+Y3OKkNPwl6Pdbfo1GqMGvJNAmFTzhy5MLQ0PkEhPz15bF67xFvIANRCq0JgFCxPX+I
 ZC3RtxGVIpFsv4okD4mBsQpCMWDOyV4l/CESfGTasO9DLrZI8FEdpKIl9Xx4MYjVrBQF
 MBG4TnVXyQHdOBQIfM4QcPSbNryTcLrJ5fK2t2L8zBFfKDqqnCDE2huV5RdmBn3ix6Cy
 R4oiBsnWOT+YiwL3gN0R9MXtVvK24rpLkhOj7pP7OigldrMtROLQqQ6RJNn3FoEJjeSm
 5Oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mF2dwYJWcVeNG6LNSvu0FtPI46NJT+aJNqlh22HKVwc=;
 b=ANcIkez/w8ihlJX6kAk9p0ZyjZu+WtDNjb2nQGxSl7pTNVo7VtMiWtA53pfl3gtriy
 9VWpxlh3RVQC+GBDaol1e+ajTTf6l2YN8bXqw762gadVZhh+7H+xkCos0nUIy/yoiHpr
 pKU/1IR6pZVacJWTlcZOsC8+R3F2mFDeA6OdxC8KGYE0B1KobF6CLqjmhRUuN0Pz223g
 rG9QgMbNc8RB3JLNMmz+/kpRns66hLOjpPgYm9yAhKspvuoYXt50y5gdt5PhcV0imA4K
 sV3okPQ2FQvVnKraVQSq3xHHN1Iyb5HN9VUzHtEcTeE/HlDAuoyKp9dYNeDAI0pmwtP0
 /OJA==
X-Gm-Message-State: APjAAAXLQoNJnG/iVOrtmEYCcuLTeN/VRFAFgmo8m4VUxc7N+qlcse3g
 rGPvIamxnuZG1ou37YrYno0KHP9k6+c=
X-Google-Smtp-Source: APXvYqyjCma6AmATAr5SXyiOAyHHImY03mcsbEQYtCJLMN15YK7n3UFxWigCz0Meb+8k0JNUCCRnZw==
X-Received: by 2002:a65:64d0:: with SMTP id t16mr26765607pgv.0.1569874907792; 
 Mon, 30 Sep 2019 13:21:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 16/22] tcg/ppc: Update vector support for VSX
Date: Mon, 30 Sep 2019 13:21:19 -0700
Message-Id: <20190930202125.21064-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42c
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


