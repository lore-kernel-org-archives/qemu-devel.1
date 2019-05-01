Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4145C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5082321743
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tc4xdyCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5082321743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhW2-0001XQ-Gh
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:10:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRJ-0006LB-UX
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRG-0002pI-Sv
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:53 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRG-0002od-HA
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:50 -0400
Received: by mail-pf1-x441.google.com with SMTP id e67so8129738pfe.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=GftYQH9nPBlQ6g/CwFs3gBqGQ2Yq7FCW48BnBv3/sM4=;
	b=Tc4xdyCWEHTE8yIaT+2uRgyKii3EqVcXXaoctKSvSbvoQypia6lmj56CN+5H2hdvmC
	u8AzMO0hTwsJztJgW00RcmrP7LcrSwEiUsuu28wCnuCaa2mOQ5mTFxvd7urc82gcJIHZ
	8Kl7X+RepVXNboVBj80V3gtkZoj508kQIiNNDc3QEhhlZHDA7oGkBgItzMLVNwdcEpwm
	e57YBLAqUSMRY89Ix6NmjQTd3sTuhjY/0raqHQmDSrS9wBVQoX46HbQGAYHzpbL4XWzg
	/xkyw4n29qMrm2akS3qIyMphKCzu6xcogd3Rw5SkBEzCnX+ZLs6esVuNkUrZN+iR0QLt
	KVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=GftYQH9nPBlQ6g/CwFs3gBqGQ2Yq7FCW48BnBv3/sM4=;
	b=eSkgkJEgsoV0cRIWb6EtsKNDw51htILHxUDYG8o1ukFAM4jwmI0g7ZBx8l6i3MHfek
	SUq4WJ7cPzJFGca6I1n/jIquIUqrlv/V2gajZ1PLlnSnpuDTbWcFiRsWBZmVPgC+9grQ
	ZlH3FPIaF836ey5ucA2MJ8DvGL/XT90fWM+O7s6IWu5K+rwUuDUfG8pulbrNu1KpN2ld
	DGhKM4aK3cWyA87LJVKaN9l3Qc+IrUHVdAK8k3kpUKlQiOFhgSY+kkdvKSDOM4jTvASD
	k842XPBx+ftWmCFE4BZ3ICoMxgtVDCWW/7Hjo9M4CgoESyK+2IwqNQXfITXZx3ko2SWF
	CwKw==
X-Gm-Message-State: APjAAAX9PW3f6vvhW8giNq9W8vlD9L1PIG6zl8oR9tJVRsSFe7cJmIro
	WKOCx5TdmcGMU452E/yD2uu7IhMGVmo=
X-Google-Smtp-Source: APXvYqyktBirSRu18lCEJozXYZcszti6SfNy3OBrgVb200QXzGSOOnuyPzvrUZQYpI9xHB5WODzMog==
X-Received: by 2002:aa7:92c4:: with SMTP id k4mr46144278pfa.183.1556687148660; 
	Tue, 30 Apr 2019 22:05:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:11 -0700
Message-Id: <20190501050536.15580-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 04/29] tcg: Specify optional vector
 requirements with a list
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050511.xXJo8m6wUdmByx1XFOIkUD8W0afidZRssp_TtKCtsTo@z>

Replace the single opcode in .opc with a null-terminated
array in .opt_opc.  We still require that all opcodes be
used with the same .vece.

Validate the contents of this list with CONFIG_DEBUG_TCG.
All tcg_gen_*_vec functions will check any list active
during .fniv expansion.  Swap the active list in and out
as we expand other opcodes, or take control away from the
front-end function.

Convert all existing vector aware front ends.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.h                   |  24 +--
 tcg/tcg.h                           |  20 +++
 target/arm/translate-sve.c          |   9 +-
 target/arm/translate.c              | 123 +++++++++-----
 target/ppc/translate/vmx-impl.inc.c |   7 +-
 tcg/tcg-op-gvec.c                   | 249 ++++++++++++++++------------
 tcg/tcg-op-vec.c                    | 102 ++++++++++++
 7 files changed, 372 insertions(+), 162 deletions(-)

diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index c093243c4c..ac744ff7c9 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -91,8 +91,8 @@ typedef struct {
     void (*fniv)(unsigned, TCGv_vec, TCGv_vec);
     /* Expand out-of-line helper w/descriptor.  */
     gen_helper_gvec_2 *fno;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The data argument to the out-of-line helper.  */
     int32_t data;
     /* The vector element size, if applicable.  */
@@ -112,8 +112,8 @@ typedef struct {
     gen_helper_gvec_2 *fno;
     /* Expand out-of-line helper w/descriptor, data as argument.  */
     gen_helper_gvec_2i *fnoi;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The vector element size, if applicable.  */
     uint8_t vece;
     /* Prefer i64 to v64.  */
@@ -131,8 +131,8 @@ typedef struct {
     void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
     /* Expand out-of-line helper w/descriptor.  */
     gen_helper_gvec_2i *fno;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The data argument to the out-of-line helper.  */
     uint32_t data;
     /* The vector element size, if applicable.  */
@@ -152,8 +152,8 @@ typedef struct {
     void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec);
     /* Expand out-of-line helper w/descriptor.  */
     gen_helper_gvec_3 *fno;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The data argument to the out-of-line helper.  */
     int32_t data;
     /* The vector element size, if applicable.  */
@@ -175,8 +175,8 @@ typedef struct {
     void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, int64_t);
     /* Expand out-of-line helper w/descriptor, data in descriptor.  */
     gen_helper_gvec_3 *fno;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The vector element size, if applicable.  */
     uint8_t vece;
     /* Prefer i64 to v64.  */
@@ -194,8 +194,8 @@ typedef struct {
     void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, TCGv_vec);
     /* Expand out-of-line helper w/descriptor.  */
     gen_helper_gvec_4 *fno;
-    /* The opcode, if any, to which this corresponds.  */
-    TCGOpcode opc;
+    /* The optional opcodes, if any, utilized by .fniv.  */
+    const TCGOpcode *opt_opc;
     /* The data argument to the out-of-line helper.  */
     int32_t data;
     /* The vector element size, if applicable.  */
diff --git a/tcg/tcg.h b/tcg/tcg.h
index cfc57110a1..2c7315da25 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -692,6 +692,7 @@ struct TCGContext {
 #ifdef CONFIG_DEBUG_TCG
     int temps_in_use;
     int goto_tb_issue_mask;
+    const TCGOpcode *vecop_list;
 #endif
 
     /* Code generation.  Note that we specifically do not use tcg_insn_unit
@@ -1492,4 +1493,23 @@ void helper_atomic_sto_le_mmu(CPUArchState *env, target_ulong addr, Int128 val,
 void helper_atomic_sto_be_mmu(CPUArchState *env, target_ulong addr, Int128 val,
                               TCGMemOpIdx oi, uintptr_t retaddr);
 
+#ifdef CONFIG_DEBUG_TCG
+void tcg_assert_listed_vecop(TCGOpcode);
+#else
+static inline void tcg_assert_listed_vecop(TCGOpcode op) { }
+#endif
+
+static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
+{
+#ifdef CONFIG_DEBUG_TCG
+    const TCGOpcode *o = tcg_ctx->vecop_list;
+    tcg_ctx->vecop_list = n;
+    return o;
+#else
+    return NULL;
+#endif
+}
+
+bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);
+
 #endif /* TCG_H */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 245cd82621..0682c0d32b 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3302,29 +3302,30 @@ static bool trans_SUB_zzi(DisasContext *s, arg_rri_esz *a)
 
 static bool trans_SUBR_zzi(DisasContext *s, arg_rri_esz *a)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_sub_vec, 0 };
     static const GVecGen2s op[4] = {
         { .fni8 = tcg_gen_vec_sub8_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_sve_subri_b,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8,
           .scalar_first = true },
         { .fni8 = tcg_gen_vec_sub16_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_sve_subri_h,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16,
           .scalar_first = true },
         { .fni4 = tcg_gen_sub_i32,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_sve_subri_s,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32,
           .scalar_first = true },
         { .fni8 = tcg_gen_sub_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_sve_subri_d,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64,
           .scalar_first = true }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 10bc53f91c..35bd426a3d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5861,27 +5861,31 @@ static void gen_ssra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
     tcg_gen_add_vec(vece, d, d, a);
 }
 
+static const TCGOpcode vecop_list_ssra[] = {
+    INDEX_op_sari_vec, INDEX_op_add_vec, 0
+};
+
 const GVecGen2i ssra_op[4] = {
     { .fni8 = gen_ssra8_i64,
       .fniv = gen_ssra_vec,
       .load_dest = true,
-      .opc = INDEX_op_sari_vec,
+      .opt_opc = vecop_list_ssra,
       .vece = MO_8 },
     { .fni8 = gen_ssra16_i64,
       .fniv = gen_ssra_vec,
       .load_dest = true,
-      .opc = INDEX_op_sari_vec,
+      .opt_opc = vecop_list_ssra,
       .vece = MO_16 },
     { .fni4 = gen_ssra32_i32,
       .fniv = gen_ssra_vec,
       .load_dest = true,
-      .opc = INDEX_op_sari_vec,
+      .opt_opc = vecop_list_ssra,
       .vece = MO_32 },
     { .fni8 = gen_ssra64_i64,
       .fniv = gen_ssra_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .opt_opc = vecop_list_ssra,
       .load_dest = true,
-      .opc = INDEX_op_sari_vec,
       .vece = MO_64 },
 };
 
@@ -5915,27 +5919,31 @@ static void gen_usra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
     tcg_gen_add_vec(vece, d, d, a);
 }
 
+static const TCGOpcode vecop_list_usra[] = {
+    INDEX_op_shri_vec, INDEX_op_add_vec, 0
+};
+
 const GVecGen2i usra_op[4] = {
     { .fni8 = gen_usra8_i64,
       .fniv = gen_usra_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_usra,
       .vece = MO_8, },
     { .fni8 = gen_usra16_i64,
       .fniv = gen_usra_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_usra,
       .vece = MO_16, },
     { .fni4 = gen_usra32_i32,
       .fniv = gen_usra_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_usra,
       .vece = MO_32, },
     { .fni8 = gen_usra64_i64,
       .fniv = gen_usra_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_usra,
       .vece = MO_64, },
 };
 
@@ -5993,27 +6001,29 @@ static void gen_shr_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
     }
 }
 
+static const TCGOpcode vecop_list_sri[] = { INDEX_op_shri_vec, 0 };
+
 const GVecGen2i sri_op[4] = {
     { .fni8 = gen_shr8_ins_i64,
       .fniv = gen_shr_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_sri,
       .vece = MO_8 },
     { .fni8 = gen_shr16_ins_i64,
       .fniv = gen_shr_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_sri,
       .vece = MO_16 },
     { .fni4 = gen_shr32_ins_i32,
       .fniv = gen_shr_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_sri,
       .vece = MO_32 },
     { .fni8 = gen_shr64_ins_i64,
       .fniv = gen_shr_ins_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
       .load_dest = true,
-      .opc = INDEX_op_shri_vec,
+      .opt_opc = vecop_list_sri,
       .vece = MO_64 },
 };
 
@@ -6069,27 +6079,29 @@ static void gen_shl_ins_vec(unsigned vece, TCGv_vec d, TCGv_vec a, int64_t sh)
     }
 }
 
+static const TCGOpcode vecop_list_sli[] = { INDEX_op_shli_vec, 0 };
+
 const GVecGen2i sli_op[4] = {
     { .fni8 = gen_shl8_ins_i64,
       .fniv = gen_shl_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shli_vec,
+      .opt_opc = vecop_list_sli,
       .vece = MO_8 },
     { .fni8 = gen_shl16_ins_i64,
       .fniv = gen_shl_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shli_vec,
+      .opt_opc = vecop_list_sli,
       .vece = MO_16 },
     { .fni4 = gen_shl32_ins_i32,
       .fniv = gen_shl_ins_vec,
       .load_dest = true,
-      .opc = INDEX_op_shli_vec,
+      .opt_opc = vecop_list_sli,
       .vece = MO_32 },
     { .fni8 = gen_shl64_ins_i64,
       .fniv = gen_shl_ins_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
       .load_dest = true,
-      .opc = INDEX_op_shli_vec,
+      .opt_opc = vecop_list_sli,
       .vece = MO_64 },
 };
 
@@ -6156,51 +6168,60 @@ static void gen_mls_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
 /* Note that while NEON does not support VMLA and VMLS as 64-bit ops,
  * these tables are shared with AArch64 which does support them.
  */
+
+static const TCGOpcode vecop_list_mla[] = {
+    INDEX_op_mul_vec, INDEX_op_add_vec, 0
+};
+
+static const TCGOpcode vecop_list_mls[] = {
+    INDEX_op_mul_vec, INDEX_op_sub_vec, 0
+};
+
 const GVecGen3 mla_op[4] = {
     { .fni4 = gen_mla8_i32,
       .fniv = gen_mla_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mla,
       .vece = MO_8 },
     { .fni4 = gen_mla16_i32,
       .fniv = gen_mla_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mla,
       .vece = MO_16 },
     { .fni4 = gen_mla32_i32,
       .fniv = gen_mla_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mla,
       .vece = MO_32 },
     { .fni8 = gen_mla64_i64,
       .fniv = gen_mla_vec,
-      .opc = INDEX_op_mul_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
       .load_dest = true,
+      .opt_opc = vecop_list_mla,
       .vece = MO_64 },
 };
 
 const GVecGen3 mls_op[4] = {
     { .fni4 = gen_mls8_i32,
       .fniv = gen_mls_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mls,
       .vece = MO_8 },
     { .fni4 = gen_mls16_i32,
       .fniv = gen_mls_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mls,
       .vece = MO_16 },
     { .fni4 = gen_mls32_i32,
       .fniv = gen_mls_vec,
-      .opc = INDEX_op_mul_vec,
       .load_dest = true,
+      .opt_opc = vecop_list_mls,
       .vece = MO_32 },
     { .fni8 = gen_mls64_i64,
       .fniv = gen_mls_vec,
-      .opc = INDEX_op_mul_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
       .load_dest = true,
+      .opt_opc = vecop_list_mls,
       .vece = MO_64 },
 };
 
@@ -6226,19 +6247,25 @@ static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
     tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
 }
 
+static const TCGOpcode vecop_list_cmtst[] = { INDEX_op_cmp_vec, 0 };
+
 const GVecGen3 cmtst_op[4] = {
     { .fni4 = gen_helper_neon_tst_u8,
       .fniv = gen_cmtst_vec,
+      .opt_opc = vecop_list_cmtst,
       .vece = MO_8 },
     { .fni4 = gen_helper_neon_tst_u16,
       .fniv = gen_cmtst_vec,
+      .opt_opc = vecop_list_cmtst,
       .vece = MO_16 },
     { .fni4 = gen_cmtst_i32,
       .fniv = gen_cmtst_vec,
+      .opt_opc = vecop_list_cmtst,
       .vece = MO_32 },
     { .fni8 = gen_cmtst_i64,
       .fniv = gen_cmtst_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .opt_opc = vecop_list_cmtst,
       .vece = MO_64 },
 };
 
@@ -6253,26 +6280,30 @@ static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
+static const TCGOpcode vecop_list_uqadd[] = {
+    INDEX_op_usadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+};
+
 const GVecGen4 uqadd_op[4] = {
     { .fniv = gen_uqadd_vec,
       .fno = gen_helper_gvec_uqadd_b,
-      .opc = INDEX_op_usadd_vec,
       .write_aofs = true,
+      .opt_opc = vecop_list_uqadd,
       .vece = MO_8 },
     { .fniv = gen_uqadd_vec,
       .fno = gen_helper_gvec_uqadd_h,
-      .opc = INDEX_op_usadd_vec,
       .write_aofs = true,
+      .opt_opc = vecop_list_uqadd,
       .vece = MO_16 },
     { .fniv = gen_uqadd_vec,
       .fno = gen_helper_gvec_uqadd_s,
-      .opc = INDEX_op_usadd_vec,
       .write_aofs = true,
+      .opt_opc = vecop_list_uqadd,
       .vece = MO_32 },
     { .fniv = gen_uqadd_vec,
       .fno = gen_helper_gvec_uqadd_d,
-      .opc = INDEX_op_usadd_vec,
       .write_aofs = true,
+      .opt_opc = vecop_list_uqadd,
       .vece = MO_64 },
 };
 
@@ -6287,25 +6318,29 @@ static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
+static const TCGOpcode vecop_list_sqadd[] = {
+    INDEX_op_ssadd_vec, INDEX_op_cmp_vec, INDEX_op_add_vec, 0
+};
+
 const GVecGen4 sqadd_op[4] = {
     { .fniv = gen_sqadd_vec,
       .fno = gen_helper_gvec_sqadd_b,
-      .opc = INDEX_op_ssadd_vec,
+      .opt_opc = vecop_list_sqadd,
       .write_aofs = true,
       .vece = MO_8 },
     { .fniv = gen_sqadd_vec,
       .fno = gen_helper_gvec_sqadd_h,
-      .opc = INDEX_op_ssadd_vec,
+      .opt_opc = vecop_list_sqadd,
       .write_aofs = true,
       .vece = MO_16 },
     { .fniv = gen_sqadd_vec,
       .fno = gen_helper_gvec_sqadd_s,
-      .opc = INDEX_op_ssadd_vec,
+      .opt_opc = vecop_list_sqadd,
       .write_aofs = true,
       .vece = MO_32 },
     { .fniv = gen_sqadd_vec,
       .fno = gen_helper_gvec_sqadd_d,
-      .opc = INDEX_op_ssadd_vec,
+      .opt_opc = vecop_list_sqadd,
       .write_aofs = true,
       .vece = MO_64 },
 };
@@ -6321,25 +6356,29 @@ static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
+static const TCGOpcode vecop_list_uqsub[] = {
+    INDEX_op_ussub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+};
+
 const GVecGen4 uqsub_op[4] = {
     { .fniv = gen_uqsub_vec,
       .fno = gen_helper_gvec_uqsub_b,
-      .opc = INDEX_op_ussub_vec,
+      .opt_opc = vecop_list_uqsub,
       .write_aofs = true,
       .vece = MO_8 },
     { .fniv = gen_uqsub_vec,
       .fno = gen_helper_gvec_uqsub_h,
-      .opc = INDEX_op_ussub_vec,
+      .opt_opc = vecop_list_uqsub,
       .write_aofs = true,
       .vece = MO_16 },
     { .fniv = gen_uqsub_vec,
       .fno = gen_helper_gvec_uqsub_s,
-      .opc = INDEX_op_ussub_vec,
+      .opt_opc = vecop_list_uqsub,
       .write_aofs = true,
       .vece = MO_32 },
     { .fniv = gen_uqsub_vec,
       .fno = gen_helper_gvec_uqsub_d,
-      .opc = INDEX_op_ussub_vec,
+      .opt_opc = vecop_list_uqsub,
       .write_aofs = true,
       .vece = MO_64 },
 };
@@ -6355,25 +6394,29 @@ static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
     tcg_temp_free_vec(x);
 }
 
+static const TCGOpcode vecop_list_sqsub[] = {
+    INDEX_op_sssub_vec, INDEX_op_cmp_vec, INDEX_op_sub_vec, 0
+};
+
 const GVecGen4 sqsub_op[4] = {
     { .fniv = gen_sqsub_vec,
       .fno = gen_helper_gvec_sqsub_b,
-      .opc = INDEX_op_sssub_vec,
+      .opt_opc = vecop_list_sqsub,
       .write_aofs = true,
       .vece = MO_8 },
     { .fniv = gen_sqsub_vec,
       .fno = gen_helper_gvec_sqsub_h,
-      .opc = INDEX_op_sssub_vec,
+      .opt_opc = vecop_list_sqsub,
       .write_aofs = true,
       .vece = MO_16 },
     { .fniv = gen_sqsub_vec,
       .fno = gen_helper_gvec_sqsub_s,
-      .opc = INDEX_op_sssub_vec,
+      .opt_opc = vecop_list_sqsub,
       .write_aofs = true,
       .vece = MO_32 },
     { .fniv = gen_sqsub_vec,
       .fno = gen_helper_gvec_sqsub_d,
-      .opc = INDEX_op_sssub_vec,
+      .opt_opc = vecop_list_sqsub,
       .write_aofs = true,
       .vece = MO_64 },
 };
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index bd3ff40e68..6861f4c5b9 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -566,10 +566,15 @@ static void glue(glue(gen_, NAME), _vec)(unsigned vece, TCGv_vec t,     \
 }                                                                       \
 static void glue(gen_, NAME)(DisasContext *ctx)                         \
 {                                                                       \
+    static const TCGOpcode vecop_list[] = {                             \
+        glue(glue(INDEX_op_, NORM), _vec),                              \
+        glue(glue(INDEX_op_, SAT), _vec),                               \
+        INDEX_op_cmp_vec, 0                                             \
+    };                                                                  \
     static const GVecGen4 g = {                                         \
         .fniv = glue(glue(gen_, NAME), _vec),                           \
         .fno = glue(gen_helper_, NAME),                                 \
-        .opc = glue(glue(INDEX_op_, SAT), _vec),                        \
+        .opt_opc = vecop_list,                                          \
         .write_aofs = true,                                             \
         .vece = VECE,                                                   \
     };                                                                  \
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index f831adb4e7..3fcb2352d9 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -26,6 +26,13 @@
 
 #define MAX_UNROLL  4
 
+#ifdef CONFIG_DEBUG_TCG
+static const TCGOpcode vecop_list_empty[1] = { 0 };
+#else
+#define vecop_list_empty NULL
+#endif
+
+
 /* Verify vector size and alignment rules.  OFS should be the OR of all
    of the operand offsets so that we can check them all at once.  */
 static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
@@ -360,31 +367,29 @@ static void gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
  * on elements of size VECE in the selected type.  Do not select V64 if
  * PREFER_I64 is true.  Return 0 if no vector type is selected.
  */
-static TCGType choose_vector_type(TCGOpcode op, unsigned vece, uint32_t size,
-                                  bool prefer_i64)
+static TCGType choose_vector_type(const TCGOpcode *list, unsigned vece,
+                                  uint32_t size, bool prefer_i64)
 {
     if (TCG_TARGET_HAS_v256 && check_size_impl(size, 32)) {
-        if (op == 0) {
-            return TCG_TYPE_V256;
-        }
-        /* Recall that ARM SVE allows vector sizes that are not a
+        /*
+         * Recall that ARM SVE allows vector sizes that are not a
          * power of 2, but always a multiple of 16.  The intent is
          * that e.g. size == 80 would be expanded with 2x32 + 1x16.
          * It is hard to imagine a case in which v256 is supported
          * but v128 is not, but check anyway.
          */
-        if (tcg_can_emit_vec_op(op, TCG_TYPE_V256, vece)
+        if (tcg_can_emit_vecop_list(list, TCG_TYPE_V256, vece)
             && (size % 32 == 0
-                || tcg_can_emit_vec_op(op, TCG_TYPE_V128, vece))) {
+                || tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece))) {
             return TCG_TYPE_V256;
         }
     }
     if (TCG_TARGET_HAS_v128 && check_size_impl(size, 16)
-        && (op == 0 || tcg_can_emit_vec_op(op, TCG_TYPE_V128, vece))) {
+        && tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece)) {
         return TCG_TYPE_V128;
     }
     if (TCG_TARGET_HAS_v64 && !prefer_i64 && check_size_impl(size, 8)
-        && (op == 0 || tcg_can_emit_vec_op(op, TCG_TYPE_V64, vece))) {
+        && tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)) {
         return TCG_TYPE_V64;
     }
     return 0;
@@ -418,7 +423,7 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
     /* Implement inline with a vector type, if possible.
      * Prefer integer when 64-bit host and no variable dup.
      */
-    type = choose_vector_type(0, vece, oprsz,
+    type = choose_vector_type(NULL, vece, oprsz,
                               (TCG_TARGET_REG_BITS == 64 && in_32 == NULL
                                && (in_64 == NULL || vece == MO_64)));
     if (type != 0) {
@@ -991,6 +996,8 @@ static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen2 *g)
 {
+    const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
     TCGType type;
     uint32_t some;
 
@@ -999,7 +1006,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     switch (type) {
     case TCG_TYPE_V256:
@@ -1032,13 +1039,14 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
         } else {
             assert(g->fno != NULL);
             tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
@@ -1049,6 +1057,8 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, int64_t c, const GVecGen2i *g)
 {
+    const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
     TCGType type;
     uint32_t some;
 
@@ -1057,7 +1067,7 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     switch (type) {
     case TCG_TYPE_V256:
@@ -1099,13 +1109,14 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                                     maxsz, c, g->fnoi);
                 tcg_temp_free_i64(tcg_c);
             }
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
@@ -1123,9 +1134,11 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     if (type != 0) {
+        const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
         TCGv_vec t_vec = tcg_temp_new_vec(type);
         uint32_t some;
 
@@ -1163,6 +1176,7 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
             g_assert_not_reached();
         }
         tcg_temp_free_vec(t_vec);
+        tcg_swap_vecop_list(hold_list);
     } else if (g->fni8 && check_size_impl(oprsz, 8)) {
         TCGv_i64 t64 = tcg_temp_new_i64();
 
@@ -1190,6 +1204,8 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
 {
+    const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
     TCGType type;
     uint32_t some;
 
@@ -1198,7 +1214,7 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     switch (type) {
     case TCG_TYPE_V256:
@@ -1236,13 +1252,14 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
             assert(g->fno != NULL);
             tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz,
                                maxsz, g->data, g->fno);
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
@@ -1254,6 +1271,8 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                      uint32_t oprsz, uint32_t maxsz, int64_t c,
                      const GVecGen3i *g)
 {
+    const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
     TCGType type;
     uint32_t some;
 
@@ -1262,7 +1281,7 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     switch (type) {
     case TCG_TYPE_V256:
@@ -1300,13 +1319,14 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
         } else {
             assert(g->fno != NULL);
             tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, c, g->fno);
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
@@ -1317,6 +1337,8 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen4 *g)
 {
+    const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
+    const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
     TCGType type;
     uint32_t some;
 
@@ -1325,7 +1347,7 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
 
     type = 0;
     if (g->fniv) {
-        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+        type = choose_vector_type(g->opt_opc, g->vece, oprsz, g->prefer_i64);
     }
     switch (type) {
     case TCG_TYPE_V256:
@@ -1366,13 +1388,14 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
             assert(g->fno != NULL);
             tcg_gen_gvec_4_ool(dofs, aofs, bofs, cofs,
                                oprsz, maxsz, g->data, g->fno);
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
@@ -1567,6 +1590,8 @@ void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
     tcg_temp_free_i64(t2);
 }
 
+static const TCGOpcode vecop_list_add[] = { INDEX_op_add_vec, 0 };
+
 void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
@@ -1574,22 +1599,22 @@ void tcg_gen_gvec_add(unsigned vece, uint32_t dofs, uint32_t aofs,
         { .fni8 = tcg_gen_vec_add8_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_add8,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_add16_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_add16,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_16 },
         { .fni4 = tcg_gen_add_i32,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_add32,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_32 },
         { .fni8 = tcg_gen_add_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_add64,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1605,22 +1630,22 @@ void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
         { .fni8 = tcg_gen_vec_add8_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_adds8,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_add16_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_adds16,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_16 },
         { .fni4 = tcg_gen_add_i32,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_adds32,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .vece = MO_32 },
         { .fni8 = tcg_gen_add_i64,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_adds64,
-          .opc = INDEX_op_add_vec,
+          .opt_opc = vecop_list_add,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1637,6 +1662,8 @@ void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_temp_free_i64(tmp);
 }
 
+static const TCGOpcode vecop_list_sub[] = { INDEX_op_sub_vec, 0 };
+
 void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
                        TCGv_i64 c, uint32_t oprsz, uint32_t maxsz)
 {
@@ -1644,22 +1671,22 @@ void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
         { .fni8 = tcg_gen_vec_sub8_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_subs8,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_sub16_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_subs16,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_16 },
         { .fni4 = tcg_gen_sub_i32,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_subs32,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_32 },
         { .fni8 = tcg_gen_sub_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_subs64,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1723,22 +1750,22 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
         { .fni8 = tcg_gen_vec_sub8_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_sub8,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_sub16_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_sub16,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_16 },
         { .fni4 = tcg_gen_sub_i32,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_sub32,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .vece = MO_32 },
         { .fni8 = tcg_gen_sub_i64,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_sub64,
-          .opc = INDEX_op_sub_vec,
+          .opt_opc = vecop_list_sub,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1747,27 +1774,29 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
+static const TCGOpcode vecop_list_mul[] = { INDEX_op_mul_vec, 0 };
+
 void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_mul8,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_8 },
         { .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_mul16,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_16 },
         { .fni4 = tcg_gen_mul_i32,
           .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_mul32,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_32 },
         { .fni8 = tcg_gen_mul_i64,
           .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_mul64,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1782,21 +1811,21 @@ void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, uint32_t aofs,
     static const GVecGen2s g[4] = {
         { .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_muls8,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_8 },
         { .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_muls16,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_16 },
         { .fni4 = tcg_gen_mul_i32,
           .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_muls32,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .vece = MO_32 },
         { .fni8 = tcg_gen_mul_i64,
           .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_muls64,
-          .opc = INDEX_op_mul_vec,
+          .opt_opc = vecop_list_mul,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -1816,22 +1845,23 @@ void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_ssadd_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_ssadd_vec,
           .fno = gen_helper_gvec_ssadd8,
-          .opc = INDEX_op_ssadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_ssadd_vec,
           .fno = gen_helper_gvec_ssadd16,
-          .opc = INDEX_op_ssadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fniv = tcg_gen_ssadd_vec,
           .fno = gen_helper_gvec_ssadd32,
-          .opc = INDEX_op_ssadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fniv = tcg_gen_ssadd_vec,
           .fno = gen_helper_gvec_ssadd64,
-          .opc = INDEX_op_ssadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 },
     };
     tcg_debug_assert(vece <= MO_64);
@@ -1841,22 +1871,23 @@ void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_sssub_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_sssub_vec,
           .fno = gen_helper_gvec_sssub8,
-          .opc = INDEX_op_sssub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_sssub_vec,
           .fno = gen_helper_gvec_sssub16,
-          .opc = INDEX_op_sssub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fniv = tcg_gen_sssub_vec,
           .fno = gen_helper_gvec_sssub32,
-          .opc = INDEX_op_sssub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fniv = tcg_gen_sssub_vec,
           .fno = gen_helper_gvec_sssub64,
-          .opc = INDEX_op_sssub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 },
     };
     tcg_debug_assert(vece <= MO_64);
@@ -1882,24 +1913,25 @@ static void tcg_gen_usadd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_usadd_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_usadd_vec,
           .fno = gen_helper_gvec_usadd8,
-          .opc = INDEX_op_usadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_usadd_vec,
           .fno = gen_helper_gvec_usadd16,
-          .opc = INDEX_op_usadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_usadd_i32,
           .fniv = tcg_gen_usadd_vec,
           .fno = gen_helper_gvec_usadd32,
-          .opc = INDEX_op_usadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_usadd_i64,
           .fniv = tcg_gen_usadd_vec,
           .fno = gen_helper_gvec_usadd64,
-          .opc = INDEX_op_usadd_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -1925,24 +1957,25 @@ static void tcg_gen_ussub_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_ussub_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_ussub_vec,
           .fno = gen_helper_gvec_ussub8,
-          .opc = INDEX_op_ussub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_ussub_vec,
           .fno = gen_helper_gvec_ussub16,
-          .opc = INDEX_op_ussub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_ussub_i32,
           .fniv = tcg_gen_ussub_vec,
           .fno = gen_helper_gvec_ussub32,
-          .opc = INDEX_op_ussub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_ussub_i64,
           .fniv = tcg_gen_ussub_vec,
           .fno = gen_helper_gvec_ussub64,
-          .opc = INDEX_op_ussub_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -1952,24 +1985,25 @@ void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_smin_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_smin_vec,
           .fno = gen_helper_gvec_smin8,
-          .opc = INDEX_op_smin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_smin_vec,
           .fno = gen_helper_gvec_smin16,
-          .opc = INDEX_op_smin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_smin_i32,
           .fniv = tcg_gen_smin_vec,
           .fno = gen_helper_gvec_smin32,
-          .opc = INDEX_op_smin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_smin_i64,
           .fniv = tcg_gen_smin_vec,
           .fno = gen_helper_gvec_smin64,
-          .opc = INDEX_op_smin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -1979,24 +2013,25 @@ void tcg_gen_gvec_smin(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_umin_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_umin_vec,
           .fno = gen_helper_gvec_umin8,
-          .opc = INDEX_op_umin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_umin_vec,
           .fno = gen_helper_gvec_umin16,
-          .opc = INDEX_op_umin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_umin_i32,
           .fniv = tcg_gen_umin_vec,
           .fno = gen_helper_gvec_umin32,
-          .opc = INDEX_op_umin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_umin_i64,
           .fniv = tcg_gen_umin_vec,
           .fno = gen_helper_gvec_umin64,
-          .opc = INDEX_op_umin_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -2006,24 +2041,25 @@ void tcg_gen_gvec_umin(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_smax_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_smax_vec,
           .fno = gen_helper_gvec_smax8,
-          .opc = INDEX_op_smax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_smax_vec,
           .fno = gen_helper_gvec_smax16,
-          .opc = INDEX_op_smax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_smax_i32,
           .fniv = tcg_gen_smax_vec,
           .fno = gen_helper_gvec_smax32,
-          .opc = INDEX_op_smax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_smax_i64,
           .fniv = tcg_gen_smax_vec,
           .fno = gen_helper_gvec_smax64,
-          .opc = INDEX_op_smax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -2033,24 +2069,25 @@ void tcg_gen_gvec_smax(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_umax(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_umax_vec, 0 };
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_umax_vec,
           .fno = gen_helper_gvec_umax8,
-          .opc = INDEX_op_umax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fniv = tcg_gen_umax_vec,
           .fno = gen_helper_gvec_umax16,
-          .opc = INDEX_op_umax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_umax_i32,
           .fniv = tcg_gen_umax_vec,
           .fno = gen_helper_gvec_umax32,
-          .opc = INDEX_op_umax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_umax_i64,
           .fniv = tcg_gen_umax_vec,
           .fno = gen_helper_gvec_umax64,
-          .opc = INDEX_op_umax_vec,
+          .opt_opc = vecop_list,
           .vece = MO_64 }
     };
     tcg_debug_assert(vece <= MO_64);
@@ -2104,26 +2141,27 @@ void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 b)
 void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_neg_vec, 0 };
     static const GVecGen2 g[4] = {
         { .fni8 = tcg_gen_vec_neg8_i64,
           .fniv = tcg_gen_neg_vec,
           .fno = gen_helper_gvec_neg8,
-          .opc = INDEX_op_neg_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_neg16_i64,
           .fniv = tcg_gen_neg_vec,
           .fno = gen_helper_gvec_neg16,
-          .opc = INDEX_op_neg_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_neg_i32,
           .fniv = tcg_gen_neg_vec,
           .fno = gen_helper_gvec_neg32,
-          .opc = INDEX_op_neg_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_neg_i64,
           .fniv = tcg_gen_neg_vec,
           .fno = gen_helper_gvec_neg64,
-          .opc = INDEX_op_neg_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -2139,7 +2177,6 @@ void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_and_i64,
         .fniv = tcg_gen_and_vec,
         .fno = gen_helper_gvec_and,
-        .opc = INDEX_op_and_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
 
@@ -2157,7 +2194,6 @@ void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_or_i64,
         .fniv = tcg_gen_or_vec,
         .fno = gen_helper_gvec_or,
-        .opc = INDEX_op_or_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
 
@@ -2175,7 +2211,6 @@ void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_xor_i64,
         .fniv = tcg_gen_xor_vec,
         .fno = gen_helper_gvec_xor,
-        .opc = INDEX_op_xor_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
 
@@ -2193,7 +2228,6 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_andc_i64,
         .fniv = tcg_gen_andc_vec,
         .fno = gen_helper_gvec_andc,
-        .opc = INDEX_op_andc_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
 
@@ -2211,7 +2245,6 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_orc_i64,
         .fniv = tcg_gen_orc_vec,
         .fno = gen_helper_gvec_orc,
-        .opc = INDEX_op_orc_vec,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
 
@@ -2277,7 +2310,6 @@ static const GVecGen2s gop_ands = {
     .fni8 = tcg_gen_and_i64,
     .fniv = tcg_gen_and_vec,
     .fno = gen_helper_gvec_ands,
-    .opc = INDEX_op_and_vec,
     .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     .vece = MO_64
 };
@@ -2303,7 +2335,6 @@ static const GVecGen2s gop_xors = {
     .fni8 = tcg_gen_xor_i64,
     .fniv = tcg_gen_xor_vec,
     .fno = gen_helper_gvec_xors,
-    .opc = INDEX_op_xor_vec,
     .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     .vece = MO_64
 };
@@ -2329,7 +2360,6 @@ static const GVecGen2s gop_ors = {
     .fni8 = tcg_gen_or_i64,
     .fniv = tcg_gen_or_vec,
     .fno = gen_helper_gvec_ors,
-    .opc = INDEX_op_or_vec,
     .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     .vece = MO_64
 };
@@ -2368,26 +2398,27 @@ void tcg_gen_vec_shl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_shli_vec, 0 };
     static const GVecGen2i g[4] = {
         { .fni8 = tcg_gen_vec_shl8i_i64,
           .fniv = tcg_gen_shli_vec,
           .fno = gen_helper_gvec_shl8i,
-          .opc = INDEX_op_shli_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_shl16i_i64,
           .fniv = tcg_gen_shli_vec,
           .fno = gen_helper_gvec_shl16i,
-          .opc = INDEX_op_shli_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_shli_i32,
           .fniv = tcg_gen_shli_vec,
           .fno = gen_helper_gvec_shl32i,
-          .opc = INDEX_op_shli_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_shli_i64,
           .fniv = tcg_gen_shli_vec,
           .fno = gen_helper_gvec_shl64i,
-          .opc = INDEX_op_shli_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -2418,26 +2449,27 @@ void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_shri_vec, 0 };
     static const GVecGen2i g[4] = {
         { .fni8 = tcg_gen_vec_shr8i_i64,
           .fniv = tcg_gen_shri_vec,
           .fno = gen_helper_gvec_shr8i,
-          .opc = INDEX_op_shri_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_shr16i_i64,
           .fniv = tcg_gen_shri_vec,
           .fno = gen_helper_gvec_shr16i,
-          .opc = INDEX_op_shri_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_shri_i32,
           .fniv = tcg_gen_shri_vec,
           .fno = gen_helper_gvec_shr32i,
-          .opc = INDEX_op_shri_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_shri_i64,
           .fniv = tcg_gen_shri_vec,
           .fno = gen_helper_gvec_shr64i,
-          .opc = INDEX_op_shri_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -2482,26 +2514,27 @@ void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
 void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode vecop_list[] = { INDEX_op_sari_vec, 0 };
     static const GVecGen2i g[4] = {
         { .fni8 = tcg_gen_vec_sar8i_i64,
           .fniv = tcg_gen_sari_vec,
           .fno = gen_helper_gvec_sar8i,
-          .opc = INDEX_op_sari_vec,
+          .opt_opc = vecop_list,
           .vece = MO_8 },
         { .fni8 = tcg_gen_vec_sar16i_i64,
           .fniv = tcg_gen_sari_vec,
           .fno = gen_helper_gvec_sar16i,
-          .opc = INDEX_op_sari_vec,
+          .opt_opc = vecop_list,
           .vece = MO_16 },
         { .fni4 = tcg_gen_sari_i32,
           .fniv = tcg_gen_sari_vec,
           .fno = gen_helper_gvec_sar32i,
-          .opc = INDEX_op_sari_vec,
+          .opt_opc = vecop_list,
           .vece = MO_32 },
         { .fni8 = tcg_gen_sari_i64,
           .fniv = tcg_gen_sari_vec,
           .fno = gen_helper_gvec_sar64i,
-          .opc = INDEX_op_sari_vec,
+          .opt_opc = vecop_list,
           .prefer_i64 = TCG_TARGET_REG_BITS == 64,
           .vece = MO_64 },
     };
@@ -2574,6 +2607,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
                       uint32_t aofs, uint32_t bofs,
                       uint32_t oprsz, uint32_t maxsz)
 {
+    static const TCGOpcode cmp_list[] = { INDEX_op_cmp_vec, 0 };
     static gen_helper_gvec_3 * const eq_fn[4] = {
         gen_helper_gvec_eq8, gen_helper_gvec_eq16,
         gen_helper_gvec_eq32, gen_helper_gvec_eq64
@@ -2606,6 +2640,8 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
         [TCG_COND_LTU] = ltu_fn,
         [TCG_COND_LEU] = leu_fn,
     };
+
+    const TCGOpcode *hold_list;
     TCGType type;
     uint32_t some;
 
@@ -2618,10 +2654,12 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
         return;
     }
 
-    /* Implement inline with a vector type, if possible.
+    /*
+     * Implement inline with a vector type, if possible.
      * Prefer integer when 64-bit host and 64-bit comparison.
      */
-    type = choose_vector_type(INDEX_op_cmp_vec, vece, oprsz,
+    hold_list = tcg_swap_vecop_list(cmp_list);
+    type = choose_vector_type(cmp_list, vece, oprsz,
                               TCG_TARGET_REG_BITS == 64 && vece == MO_64);
     switch (type) {
     case TCG_TYPE_V256:
@@ -2663,13 +2701,14 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
                 assert(fn != NULL);
             }
             tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, fn[vece]);
-            return;
+            oprsz = maxsz;
         }
         break;
 
     default:
         g_assert_not_reached();
     }
+    tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
         expand_clr(dofs + oprsz, maxsz - oprsz);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index cfb18682b1..914fe42b1e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -34,6 +34,90 @@ extern TCGv_i32 TCGV_HIGH_link_error(TCGv_i64);
 #define TCGV_HIGH TCGV_HIGH_link_error
 #endif
 
+/*
+ * Vector optional opcode tracking.
+ * Except for the basic logical operations (and, or, xor), and
+ * data movement (mov, ld, st, dupi), many vector opcodes are
+ * optional and may not be supported on the host.  Thank Intel
+ * for the irregularity in their instruction set.
+ *
+ * The gvec expanders allow custom vector operations to be composed,
+ * generally via the .fniv callback in the GVecGen* structures.  At
+ * the same time, in deciding whether to use this hook we need to
+ * know if the host supports the required operations.  This is
+ * presented as an array of opcodes, terminated by 0.  Each opcode
+ * is assumed to be expanded with the given VECE.
+ *
+ * For debugging, we want to validate this array.  Therefore, when
+ * tcg_ctx->vec_opt_opc is non-NULL, the tcg_gen_*_vec expanders
+ * will validate that their opcode is present in the list.
+ */
+#ifdef CONFIG_DEBUG_TCG
+void tcg_assert_listed_vecop(TCGOpcode op)
+{
+    const TCGOpcode *p = tcg_ctx->vecop_list;
+    if (p) {
+        for (; *p; ++p) {
+            if (*p == op) {
+                return;
+            }
+        }
+        g_assert_not_reached();
+    }
+}
+#endif
+
+bool tcg_can_emit_vecop_list(const TCGOpcode *list,
+                             TCGType type, unsigned vece)
+{
+    if (list == NULL) {
+        return true;
+    }
+
+    for (; *list; ++list) {
+        TCGOpcode opc = *list;
+
+#ifdef CONFIG_DEBUG_TCG
+        switch (opc) {
+        case INDEX_op_and_vec:
+        case INDEX_op_or_vec:
+        case INDEX_op_xor_vec:
+        case INDEX_op_mov_vec:
+        case INDEX_op_dup_vec:
+        case INDEX_op_dupi_vec:
+        case INDEX_op_dup2_vec:
+        case INDEX_op_ld_vec:
+        case INDEX_op_st_vec:
+            /* These opcodes are mandatory and should not be listed.  */
+            g_assert_not_reached();
+        default:
+            break;
+        }
+#endif
+
+        if (tcg_can_emit_vec_op(opc, type, vece)) {
+            continue;
+        }
+
+        /*
+         * The opcode list is created by front ends based on what they
+         * actually invoke.  We must mirror the logic in the routines
+         * below for generic expansions using other opcodes.
+         */
+        switch (opc) {
+        case INDEX_op_neg_vec:
+            if (tcg_can_emit_vec_op(INDEX_op_sub_vec, type, vece)) {
+                continue;
+            }
+            break;
+        default:
+            break;
+        }
+        return false;
+    }
+    return true;
+}
+
 void vec_gen_2(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r, TCGArg a)
 {
     TCGOp *op = tcg_emit_op(opc);
@@ -296,11 +380,14 @@ static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
     int can;
 
     tcg_debug_assert(at->base_type >= type);
+    tcg_assert_listed_vecop(opc);
     can = tcg_can_emit_vec_op(opc, type, vece);
     if (can > 0) {
         vec_gen_2(opc, type, vece, ri, ai);
     } else if (can < 0) {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
         tcg_expand_vec_op(opc, type, vece, ri, ai);
+        tcg_swap_vecop_list(hold_list);
     } else {
         return false;
     }
@@ -318,11 +405,17 @@ void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
+    const TCGOpcode *hold_list;
+
+    tcg_assert_listed_vecop(INDEX_op_neg_vec);
+    hold_list = tcg_swap_vecop_list(NULL);
+
     if (!TCG_TARGET_HAS_neg_vec || !do_op2(vece, r, a, INDEX_op_neg_vec)) {
         TCGv_vec t = tcg_const_zeros_vec_matching(r);
         tcg_gen_sub_vec(vece, r, t, a);
         tcg_temp_free_vec(t);
     }
+    tcg_swap_vecop_list(hold_list);
 }
 
 static void do_shifti(TCGOpcode opc, unsigned vece,
@@ -337,6 +430,7 @@ static void do_shifti(TCGOpcode opc, unsigned vece,
 
     tcg_debug_assert(at->base_type == type);
     tcg_debug_assert(i >= 0 && i < (8 << vece));
+    tcg_assert_listed_vecop(opc);
 
     if (i == 0) {
         tcg_gen_mov_vec(r, a);
@@ -350,8 +444,10 @@ static void do_shifti(TCGOpcode opc, unsigned vece,
         /* We leave the choice of expansion via scalar or vector shift
            to the target.  Often, but not always, dupi can feed a vector
            shift easier than a scalar.  */
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
         tcg_debug_assert(can < 0);
         tcg_expand_vec_op(opc, type, vece, ri, ai, i);
+        tcg_swap_vecop_list(hold_list);
     }
 }
 
@@ -384,12 +480,15 @@ void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
 
     tcg_debug_assert(at->base_type >= type);
     tcg_debug_assert(bt->base_type >= type);
+    tcg_assert_listed_vecop(INDEX_op_cmp_vec);
     can = tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece);
     if (can > 0) {
         vec_gen_4(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
     } else {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
         tcg_debug_assert(can < 0);
         tcg_expand_vec_op(INDEX_op_cmp_vec, type, vece, ri, ai, bi, cond);
+        tcg_swap_vecop_list(hold_list);
     }
 }
 
@@ -407,12 +506,15 @@ static void do_op3(unsigned vece, TCGv_vec r, TCGv_vec a,
 
     tcg_debug_assert(at->base_type >= type);
     tcg_debug_assert(bt->base_type >= type);
+    tcg_assert_listed_vecop(opc);
     can = tcg_can_emit_vec_op(opc, type, vece);
     if (can > 0) {
         vec_gen_3(opc, type, vece, ri, ai, bi);
     } else {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
         tcg_debug_assert(can < 0);
         tcg_expand_vec_op(opc, type, vece, ri, ai, bi);
+        tcg_swap_vecop_list(hold_list);
     }
 }
 
-- 
2.17.1


