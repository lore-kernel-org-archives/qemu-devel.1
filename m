Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B45DC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED842173C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sw3c6Arf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED842173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZke-00049B-2F
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:30:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZip-0002wN-Up
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZin-0007Jx-Ru
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:31 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:37122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZim-0007Iq-CV
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:29 -0400
Received: by mail-yb1-xb41.google.com with SMTP id z12so1502448ybr.4
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LKqluvSgNgObFg/5PCh55olLBZ6qvjIouGnoyC1zOlQ=;
	b=sw3c6Arf3Uux9PJbvYUEXbIpRViToybYPIkYQAysB+fOYdl1D4VKACLZxvNeDqET4I
	OTopyWF8BsqeFlkcznpjS0tb7YJmftV8h6q9acFPj8oxAhbqJwp2arrZs/E1vbJEBOl5
	yaZIO61Xt4eo0aPc6/vd1wzVLWfgAG4mHWIQ1e0Mi81UQDuIs57/XdrahuBC2fhgNt1t
	7euFsNr+uCdlnEDK9+VLfCzux+NZPFY7qnIqo50B7zYVFzGpVeUnNHxlvJHwh6ktlhPt
	Tjtb1nRaz4StLplIYkzAEMaPASEUkYFniG4vMr+GCN5TUnC12dONiq900NOwPd+zMeQg
	qRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=LKqluvSgNgObFg/5PCh55olLBZ6qvjIouGnoyC1zOlQ=;
	b=XDc3Qv/BcfcSKGkwPPDCvTWDETZ0myJrfGhQwBGtGlSqoM2DeGQEAV8iV4qibVQ6tm
	V0xd5Gba+N9yjsbVcjmD+okzqryf22+CJaF8SbLkABo8MeYM2FuzdrfjwW9ykolcGsuw
	FHQQJLtYArDpQrcO6K9xut6yhWJD+okvUIiLUVl04D4ilnB4F1sxHn2LyssHnCJqIFBu
	jJYnIISQXfBW50r0vYmk6IrRnQORF6Zn+TeicP/KAFY2UQuMkzqdOur2ekWH0oaQFIlH
	P1tugoe5FvvYohOPnA1d0FEUcX22ivPKUHyirmqrHCik2Ne7DUuRxrvrXtOvUDpIbu6t
	R6mw==
X-Gm-Message-State: APjAAAUby58CS1M16/SMXLOi5pcuClkxIjkA0WJCJE8dGQRY3y/TgudD
	ze+Ha7GJ5++xraAtbcGBRdKEV6iqkHU=
X-Google-Smtp-Source: APXvYqxkEd4pNmQeFfHpbI79fKOaKWbTYXwqP7vVmI+1Z5tKzL5LUfFayh8orbBnguK2sjT/lLTmiQ==
X-Received: by 2002:a25:4d07:: with SMTP id a7mr40846887ybb.176.1558564107426; 
	Wed, 22 May 2019 15:28:27 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:08 -0400
Message-Id: <20190522222821.23850-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [PULL 03/16] tcg: Add support for vector bitwise select
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

This operation performs d = (b & a) | (c & ~a), and is present
on a majority of host vector units.  Include gvec expanders.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  2 ++
 tcg/aarch64/tcg-target.h     |  1 +
 tcg/i386/tcg-target.h        |  1 +
 tcg/tcg-op-gvec.h            |  7 +++++++
 tcg/tcg-op.h                 |  3 +++
 tcg/tcg-opc.h                |  2 ++
 tcg/tcg.h                    |  1 +
 accel/tcg/tcg-runtime-gvec.c | 14 ++++++++++++++
 tcg/tcg-op-gvec.c            | 23 +++++++++++++++++++++++
 tcg/tcg-op-vec.c             | 26 ++++++++++++++++++++++++++
 tcg/tcg.c                    |  2 ++
 tcg/README                   |  4 ++++
 12 files changed, 86 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 6d73dc2d65..4fa61b49b4 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -303,3 +303,5 @@ DEF_HELPER_FLAGS_4(gvec_leu8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_leu16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_leu32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_leu64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_bitsel, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index e43554c3c7..52ee66424f 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -140,6 +140,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       0
 
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 66f16fbe3c..08a0386433 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -190,6 +190,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       0
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 52a398c190..2a9e0c7c0a 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -342,6 +342,13 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
                       uint32_t aofs, uint32_t bofs,
                       uint32_t oprsz, uint32_t maxsz);
 
+/*
+ * Perform vector bit select: d = (b & a) | (c & ~a).
+ */
+void tcg_gen_gvec_bitsel(unsigned vece, uint32_t dofs, uint32_t aofs,
+                         uint32_t bofs, uint32_t cofs,
+                         uint32_t oprsz, uint32_t maxsz);
+
 /*
  * 64-bit vector operations.  Use these when the register has been allocated
  * with tcg_global_mem_new_i64, and so we cannot also address it via pointer.
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 660fe205d0..268860ed2f 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1000,6 +1000,9 @@ void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                      TCGv_vec a, TCGv_vec b);
 
+void tcg_gen_bitsel_vec(unsigned vece, TCGv_vec r, TCGv_vec a,
+                        TCGv_vec b, TCGv_vec c);
+
 void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 4a2dd116eb..c05b71427c 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -256,6 +256,8 @@ DEF(sarv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 
 DEF(cmp_vec, 1, 2, 1, IMPLVEC)
 
+DEF(bitsel_vec, 1, 3, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_bitsel_vec))
+
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #if TCG_TARGET_MAYBE_vec
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 0e01a70d66..72f9f6c70b 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -187,6 +187,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_mul_vec          0
 #define TCG_TARGET_HAS_sat_vec          0
 #define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 0f09e0ef38..3b6052fe97 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -1444,3 +1444,17 @@ void HELPER(gvec_umax64)(void *d, void *a, void *b, uint32_t desc)
     }
     clear_high(d, oprsz, desc);
 }
+
+void HELPER(gvec_bitsel)(void *d, void *a, void *b, void *c, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        vec64 aa = *(vec64 *)(a + i);
+        vec64 bb = *(vec64 *)(b + i);
+        vec64 cc = *(vec64 *)(c + i);
+        *(vec64 *)(d + i) = (bb & aa) | (cc & ~aa);
+    }
+    clear_high(d, oprsz, desc);
+}
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index bbf70e3cd9..f18464cf07 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -3195,3 +3195,26 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
         expand_clr(dofs + oprsz, maxsz - oprsz);
     }
 }
+
+static void tcg_gen_bitsel_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_and_i64(t, b, a);
+    tcg_gen_andc_i64(d, c, a);
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+void tcg_gen_gvec_bitsel(unsigned vece, uint32_t dofs, uint32_t aofs,
+                         uint32_t bofs, uint32_t cofs,
+                         uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen4 g = {
+        .fni8 = tcg_gen_bitsel_i64,
+        .fniv = tcg_gen_bitsel_vec,
+        .fno = gen_helper_gvec_bitsel,
+    };
+
+    tcg_gen_gvec_4(dofs, aofs, bofs, cofs, oprsz, maxsz, &g);
+}
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 543508d545..99cbf29e0b 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -88,6 +88,7 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
         case INDEX_op_dup2_vec:
         case INDEX_op_ld_vec:
         case INDEX_op_st_vec:
+        case INDEX_op_bitsel_vec:
             /* These opcodes are mandatory and should not be listed.  */
             g_assert_not_reached();
         default:
@@ -691,3 +692,28 @@ void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
 {
     do_shifts(vece, r, a, b, INDEX_op_sars_vec, INDEX_op_sarv_vec);
 }
+
+void tcg_gen_bitsel_vec(unsigned vece, TCGv_vec r, TCGv_vec a,
+                        TCGv_vec b, TCGv_vec c)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGTemp *bt = tcgv_vec_temp(b);
+    TCGTemp *ct = tcgv_vec_temp(c);
+    TCGType type = rt->base_type;
+
+    tcg_debug_assert(at->base_type >= type);
+    tcg_debug_assert(bt->base_type >= type);
+    tcg_debug_assert(ct->base_type >= type);
+
+    if (TCG_TARGET_HAS_bitsel_vec) {
+        vec_gen_4(INDEX_op_bitsel_vec, type, MO_8,
+                  temp_arg(rt), temp_arg(at), temp_arg(bt), temp_arg(ct));
+    } else {
+        TCGv_vec t = tcg_temp_new_vec(type);
+        tcg_gen_and_vec(MO_8, t, a, b);
+        tcg_gen_andc_vec(MO_8, r, c, a);
+        tcg_gen_or_vec(MO_8, r, r, t);
+        tcg_temp_free_vec(t);
+    }
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 24083b8c00..5d947dbcb0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1646,6 +1646,8 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_smax_vec:
     case INDEX_op_umax_vec:
         return have_vec && TCG_TARGET_HAS_minmax_vec;
+    case INDEX_op_bitsel_vec:
+        return have_vec && TCG_TARGET_HAS_bitsel_vec;
 
     default:
         tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
diff --git a/tcg/README b/tcg/README
index cbdfd3b6bc..76057ab59f 100644
--- a/tcg/README
+++ b/tcg/README
@@ -627,6 +627,10 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
 
   Compare vectors by element, storing -1 for true and 0 for false.
 
+* bitsel_vec v0, v1, v2, v3
+
+  Bitwise select, v0 = (v2 & v1) | (v3 & ~v1), across the entire vector.
+
 *********
 
 Note 1: Some shortcuts are defined when the last operand is known to be
-- 
2.17.1


