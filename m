Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230E8C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09962082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9FCGohS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09962082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60657 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNiRL-0001OA-4Y
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 14:34:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNiN4-0007Fj-P2
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNiN3-0000L4-5v
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:50 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:38041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNiN2-0000K7-Tg
	for qemu-devel@nongnu.org; Mon, 06 May 2019 14:29:49 -0400
Received: by mail-pf1-x433.google.com with SMTP id 10so7214511pfo.5
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=5O+OzCYzy78V1uswfGstaXgkM49gQkBz6dXALOrBXUQ=;
	b=o9FCGohSaa3uY9gJvsV/1F1r67O1Gx5jG+5cC4IomQbKBWy+ZX8UjmHhInX8hYGYKm
	GX+A1HK/MoBIlWQBte1BarAdtbsoiAYbnXbk1UMil9CfldhC+V/HDoOlY6/8RcLWk/Sa
	sHw3PK7nW25yc6zJUKi0LUmCxnDOoxZjYE071EEKnob53ZfQpGxxc3tqN75j4EydjHy5
	fWJDcFfSf29XCasK0TZFaNfa7yokv85A8hYDMoLefAhzeVrsXxe1mLQca9k9iYu6m2DO
	aN6BC4btjFq3ck1ujWcBuJhkalQ9vC8RqXxBYnFiHcKdmOxi+BBTZKStGds1LVumLd3A
	/LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=5O+OzCYzy78V1uswfGstaXgkM49gQkBz6dXALOrBXUQ=;
	b=fKyoW1ICiWwuEkp0LEhW/mhaFOaFa8/V34FxNUSHRXr+vk7Upal2IZl8AYIKkB9SJI
	nMwaqJ8jN4vvINVgRq7HprU5rj6GpzMkS6pFVue7w8FIKO9AAZd20jlkxs9+SkKEcHR4
	+CFDbF5VZXZC07SFY+nCM3JwNxbz96n5WQnFiI68xGZnDVXn81w58iQr3pFmP9dB3rJ0
	yU5R35ZYvjfkTv8MY3DlFkm0zrN6L42dU8huTYQl4YP73iF00wCz/6JDGKJPCXGGbpvk
	hZIX+t3QrpxUqvDS9DWT3YExzhJtZvIlZSgIr6jM6cujKrTDOj+9+256PJRiZz833eJF
	CGHQ==
X-Gm-Message-State: APjAAAXi9rEHbanJVxjZcUKtw/Wxcy+J+vPjwBa35JdKC6J8p/Er02Um
	zJdhqXnuyighcK8EIA6PiodW0nECS4s=
X-Google-Smtp-Source: APXvYqyIDU5tdKrz+kIgV6fPgzBZb1MpHEMy0TZSm8VsDPejHVBsbt/zhO34WYoy6XQgu/pnY7lzFg==
X-Received: by 2002:a63:f754:: with SMTP id f20mr33240247pgk.162.1557167387307;
	Mon, 06 May 2019 11:29:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j32sm12909924pgi.73.2019.05.06.11.29.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 11:29:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 11:29:40 -0700
Message-Id: <20190506182940.2200-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506182940.2200-1-richard.henderson@linaro.org>
References: <20190506182940.2200-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::433
Subject: [Qemu-devel] [PULL 3/3] decodetree: Add DisasContext argument to
 !function expanders
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This does require adjusting all existing users.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c              | 24 ++++++++++++------------
 target/hppa/translate.c                 | 16 ++++++++--------
 target/riscv/insn_trans/trans_rvc.inc.c | 10 +++++-----
 target/riscv/translate.c                |  4 ++--
 scripts/decodetree.py                   |  9 +++++----
 5 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 245cd82621..80645db508 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -54,35 +54,35 @@ typedef void gen_helper_gvec_mem_scatter(TCGv_env, TCGv_ptr, TCGv_ptr,
 /* See e.g. ASR (immediate, predicated).
  * Returns -1 for unallocated encoding; diagnose later.
  */
-static int tszimm_esz(int x)
+static int tszimm_esz(DisasContext *s, int x)
 {
     x >>= 3;  /* discard imm3 */
     return 31 - clz32(x);
 }
 
-static int tszimm_shr(int x)
+static int tszimm_shr(DisasContext *s, int x)
 {
-    return (16 << tszimm_esz(x)) - x;
+    return (16 << tszimm_esz(s, x)) - x;
 }
 
 /* See e.g. LSL (immediate, predicated).  */
-static int tszimm_shl(int x)
+static int tszimm_shl(DisasContext *s, int x)
 {
-    return x - (8 << tszimm_esz(x));
+    return x - (8 << tszimm_esz(s, x));
 }
 
-static inline int plus1(int x)
+static inline int plus1(DisasContext *s, int x)
 {
     return x + 1;
 }
 
 /* The SH bit is in bit 8.  Extract the low 8 and shift.  */
-static inline int expand_imm_sh8s(int x)
+static inline int expand_imm_sh8s(DisasContext *s, int x)
 {
     return (int8_t)x << (x & 0x100 ? 8 : 0);
 }
 
-static inline int expand_imm_sh8u(int x)
+static inline int expand_imm_sh8u(DisasContext *s, int x)
 {
     return (uint8_t)x << (x & 0x100 ? 8 : 0);
 }
@@ -90,7 +90,7 @@ static inline int expand_imm_sh8u(int x)
 /* Convert a 2-bit memory size (msz) to a 4-bit data type (dtype)
  * with unsigned data.  C.f. SVE Memory Contiguous Load Group.
  */
-static inline int msz_dtype(int msz)
+static inline int msz_dtype(DisasContext *s, int msz)
 {
     static const uint8_t dtype[4] = { 0, 5, 10, 15 };
     return dtype[msz];
@@ -4834,7 +4834,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
     int desc, poff;
 
     /* Load the first quadword using the normal predicated load helpers.  */
-    desc = sve_memopidx(s, msz_dtype(msz));
+    desc = sve_memopidx(s, msz_dtype(s, msz));
     desc |= zt << MEMOPIDX_SHIFT;
     desc = simd_desc(16, 16, desc);
     t_desc = tcg_const_i32(desc);
@@ -5016,7 +5016,7 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         fn = fn_multiple[be][nreg - 1][msz];
     }
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, msz_dtype(msz), fn);
+    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), fn);
 }
 
 static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
@@ -5065,7 +5065,7 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
     TCGv_i32 t_desc;
     int desc;
 
-    desc = sve_memopidx(s, msz_dtype(msz));
+    desc = sve_memopidx(s, msz_dtype(s, msz));
     desc |= scale << MEMOPIDX_SHIFT;
     desc = simd_desc(vsz, vsz, desc);
     t_desc = tcg_const_i32(desc);
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e1febdfea1..188fe688cb 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -279,7 +279,7 @@ typedef struct DisasContext {
 } DisasContext;
 
 /* Note that ssm/rsm instructions number PSW_W and PSW_E differently.  */
-static int expand_sm_imm(int val)
+static int expand_sm_imm(DisasContext *ctx, int val)
 {
     if (val & PSW_SM_E) {
         val = (val & ~PSW_SM_E) | PSW_E;
@@ -291,43 +291,43 @@ static int expand_sm_imm(int val)
 }
 
 /* Inverted space register indicates 0 means sr0 not inferred from base.  */
-static int expand_sr3x(int val)
+static int expand_sr3x(DisasContext *ctx, int val)
 {
     return ~val;
 }
 
 /* Convert the M:A bits within a memory insn to the tri-state value
    we use for the final M.  */
-static int ma_to_m(int val)
+static int ma_to_m(DisasContext *ctx, int val)
 {
     return val & 2 ? (val & 1 ? -1 : 1) : 0;
 }
 
 /* Convert the sign of the displacement to a pre or post-modify.  */
-static int pos_to_m(int val)
+static int pos_to_m(DisasContext *ctx, int val)
 {
     return val ? 1 : -1;
 }
 
-static int neg_to_m(int val)
+static int neg_to_m(DisasContext *ctx, int val)
 {
     return val ? -1 : 1;
 }
 
 /* Used for branch targets and fp memory ops.  */
-static int expand_shl2(int val)
+static int expand_shl2(DisasContext *ctx, int val)
 {
     return val << 2;
 }
 
 /* Used for fp memory ops.  */
-static int expand_shl3(int val)
+static int expand_shl3(DisasContext *ctx, int val)
 {
     return val << 3;
 }
 
 /* Used for assemble_21.  */
-static int expand_shl11(int val)
+static int expand_shl11(DisasContext *ctx, int val)
 {
     return val << 11;
 }
diff --git a/target/riscv/insn_trans/trans_rvc.inc.c b/target/riscv/insn_trans/trans_rvc.inc.c
index ebcd977b2f..3e5d6fd5ea 100644
--- a/target/riscv/insn_trans/trans_rvc.inc.c
+++ b/target/riscv/insn_trans/trans_rvc.inc.c
@@ -48,13 +48,13 @@ static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a)
     REQUIRE_EXT(ctx, RVF);
 
     arg_c_lw tmp;
-    decode_insn16_extract_cl_w(&tmp, ctx->opcode);
+    decode_insn16_extract_cl_w(ctx, &tmp, ctx->opcode);
     arg_flw arg = { .rd = tmp.rd, .rs1 = tmp.rs1, .imm = tmp.uimm };
     return trans_flw(ctx, &arg);
 #else
     /* C.LD ( RV64C/RV128C-only ) */
     arg_c_fld tmp;
-    decode_insn16_extract_cl_d(&tmp, ctx->opcode);
+    decode_insn16_extract_cl_d(ctx, &tmp, ctx->opcode);
     arg_ld arg = { .rd = tmp.rd, .rs1 = tmp.rs1, .imm = tmp.uimm };
     return trans_ld(ctx, &arg);
 #endif
@@ -80,13 +80,13 @@ static bool trans_c_fsw_sd(DisasContext *ctx, arg_c_fsw_sd *a)
     REQUIRE_EXT(ctx, RVF);
 
     arg_c_sw tmp;
-    decode_insn16_extract_cs_w(&tmp, ctx->opcode);
+    decode_insn16_extract_cs_w(ctx, &tmp, ctx->opcode);
     arg_fsw arg = { .rs1 = tmp.rs1, .rs2 = tmp.rs2, .imm = tmp.uimm };
     return trans_fsw(ctx, &arg);
 #else
     /* C.SD ( RV64C/RV128C-only ) */
     arg_c_fsd tmp;
-    decode_insn16_extract_cs_d(&tmp, ctx->opcode);
+    decode_insn16_extract_cs_d(ctx, &tmp, ctx->opcode);
     arg_sd arg = { .rs1 = tmp.rs1, .rs2 = tmp.rs2, .imm = tmp.uimm };
     return trans_sd(ctx, &arg);
 #endif
@@ -107,7 +107,7 @@ static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a)
 #ifdef TARGET_RISCV32
     /* C.JAL */
     arg_c_j tmp;
-    decode_insn16_extract_cj(&tmp, ctx->opcode);
+    decode_insn16_extract_cj(ctx, &tmp, ctx->opcode);
     arg_jal arg = { .rd = 1, .imm = tmp.imm };
     return trans_jal(ctx, &arg);
 #else
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 967eac7bc3..2ff6b49487 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -517,7 +517,7 @@ static void decode_RV32_64C(DisasContext *ctx)
 }
 
 #define EX_SH(amount) \
-    static int ex_shift_##amount(int imm) \
+    static int ex_shift_##amount(DisasContext *ctx, int imm) \
     {                                         \
         return imm << amount;                 \
     }
@@ -533,7 +533,7 @@ EX_SH(12)
     }                              \
 } while (0)
 
-static int ex_rvc_register(int reg)
+static int ex_rvc_register(DisasContext *ctx, int reg)
 {
     return 8 + reg;
 }
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 4536e3a63d..81874e22cc 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -256,7 +256,7 @@ class FunctionField:
         return self.func + '(' + str(self.base) + ')'
 
     def str_extract(self):
-        return self.func + '(' + self.base.str_extract() + ')'
+        return self.func + '(ctx, ' + self.base.str_extract() + ')'
 
     def __eq__(self, other):
         return self.func == other.func and self.base == other.base
@@ -318,7 +318,7 @@ class Format(General):
         return decode_function + '_extract_' + self.name
 
     def output_extract(self):
-        output('static void ', self.extract_name(), '(',
+        output('static void ', self.extract_name(), '(DisasContext *ctx, ',
                self.base.struct_name(), ' *a, ', insntype, ' insn)\n{\n')
         for n, f in self.fields.items():
             output('    a->', n, ' = ', f.str_extract(), ';\n')
@@ -343,7 +343,8 @@ class Pattern(General):
         arg = self.base.base.name
         output(ind, '/* ', self.file, ':', str(self.lineno), ' */\n')
         if not extracted:
-            output(ind, self.base.extract_name(), '(&u.f_', arg, ', insn);\n')
+            output(ind, self.base.extract_name(),
+                   '(ctx, &u.f_', arg, ', insn);\n')
         for n, f in self.fields.items():
             output(ind, 'u.f_', arg, '.', n, ' = ', f.str_extract(), ';\n')
         output(ind, 'if (', translate_prefix, '_', self.name,
@@ -894,7 +895,7 @@ class Tree:
         # extract the fields now.
         if not extracted and self.base:
             output(ind, self.base.extract_name(),
-                   '(&u.f_', self.base.base.name, ', insn);\n')
+                   '(ctx, &u.f_', self.base.base.name, ', insn);\n')
             extracted = True
 
         # Attempt to aid the compiler in producing compact switch statements.
-- 
2.17.1


