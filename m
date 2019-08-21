Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E15FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26ABE216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzsBqYpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26ABE216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VRf-0006wA-14
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URv-0001ns-Mx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URm-0008Ks-FK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:07 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:46163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URi-0007vD-Kk
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:56 -0400
Received: by mail-yb1-xb43.google.com with SMTP id x10so1325687ybs.13
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pU4OjXMQdfhpu4voemk/g2dOGLQZu6Z3EM3QJS/y5Hk=;
 b=XzsBqYpXhI4blTRF6DoUtl6ZqPW27AuRBHgg4vanGvR9eDQH7yOc3fp/9Ghb432OCV
 r8kgt9MwnNlWQdwG37acuEm3O2EqNDuw/Tol1W8revGD1NEttQRZMqWdbhGGFni0aCZi
 vxHcxxYWEL+sP9RadLmW4Fwh384iPaKJexWfIzUro0YKDr/c4I+ep/JGhvbSXOsoY/x5
 n1MUKS/e24AkGyplz3eIqHNa2rcSh3ofWjqurB/VD22S7GleXjf/WdCzaQv/WouZLWaE
 1DexHLsMULwQfcDySdapkIshjXuyaaz5f6GTgzW2KqE2AB/upOMveTZvjHz4F1zk8Rya
 bUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pU4OjXMQdfhpu4voemk/g2dOGLQZu6Z3EM3QJS/y5Hk=;
 b=mpLEjwVKWt+nHKEAGOz6dKU5hfhdtbv59yilzA0obakHa5fsPLuq9Mtilhv8QLklzk
 ty/ol4BJJksQpzzsoCKOsjFSZ1n0GQHLvjigBEk+k4M+gc67TZLflYdb3FaDM6ng9kTT
 KZV4YeIl1ZF3D5N0CAn3n8QL6umuL62yJzLGIoAZbnG+8W1lwSf8fcnXQPrw/SgSq5OL
 8YgF9Em1wuPrVOdw74hmYkw0ot1pIsdeb9CnVGwT7Qw3VqoQ44XU5PG6Cx4y29AZ7rOf
 rjYAAZ5+ADSCvr6huQsGrOrtP7YaoHLiBb0VtZUTSROACGOy6mICnuqQz8eWduiANq51
 qUqQ==
X-Gm-Message-State: APjAAAWdzaIjWwoy2fCQNhVZODVeQJHa5AcgZRRH4v7n24IIEPYZaBiB
 8izVVLF+KbZLjR2bKJkzPQfAg5IX
X-Google-Smtp-Source: APXvYqz6Ollxe0RId96LARzICEKPANZRL4e+IS8Wl1wNvUpW/uE4lVJ9sKdezpfpEFhnXvFyhHvGiQ==
X-Received: by 2002:a5b:cc2:: with SMTP id e2mr23826057ybr.288.1566408642934; 
 Wed, 21 Aug 2019 10:30:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:42 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:19 -0400
Message-Id: <20190821172951.15333-44-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 43/75] target/i386: introduce SSE2 code
 generators
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce code generators required by SSE2 instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 427 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 425 insertions(+), 2 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 43917edc76..3445b4cff1 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5563,6 +5563,7 @@ INSNOP_LDST(xmm, Mhq)
     }
 
 GEN_INSN2(movq, Pq, Eq);        /* forward declaration */
+GEN_INSN2(movq, Vdq, Eq);       /* forward declaration */
 GEN_INSN2(movd, Pq, Ed)
 {
     const insnop_arg_t(Eq) arg2_r64 = tcg_temp_new_i64();
@@ -5574,6 +5575,17 @@ GEN_INSN2(movd, Ed, Pq)
 {
     tcg_gen_ld_i32(arg1, cpu_env, arg2 + offsetof(MMXReg, MMX_L(0)));
 }
+GEN_INSN2(movd, Vdq, Ed)
+{
+    const insnop_arg_t(Eq) arg2_r64 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(arg2_r64, arg2);
+    gen_insn2(movq, Vdq, Eq)(env, s, arg1, arg2_r64);
+    tcg_temp_free_i64(arg2_r64);
+}
+GEN_INSN2(movd, Ed, Vdq)
+{
+    tcg_gen_ld_i32(arg1, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(0)));
+}
 
 GEN_INSN2(movq, Pq, Eq)
 {
@@ -5583,13 +5595,45 @@ GEN_INSN2(movq, Eq, Pq)
 {
     tcg_gen_ld_i64(arg1, cpu_env, arg2 + offsetof(MMXReg, MMX_Q(0)));
 }
+GEN_INSN2(movq, Vdq, Eq)
+{
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+    tcg_gen_st_i64(arg2, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_movi_i64(r64, 0);
+    tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+    tcg_temp_free_i64(r64);
+}
+GEN_INSN2(movq, Eq, Vdq)
+{
+    tcg_gen_ld_i64(arg1, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(0)));
+}
 
 DEF_GEN_INSN2_GVEC(movq, Pq, Qq, mov, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movq, Qq, Pq, mov, MM_OPRSZ, MM_MAXSZ, MO_64)
+GEN_INSN2(movq, Vdq, Wq)
+{
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+    tcg_gen_ld_i64(r64, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(0)));
+    gen_insn2(movq, Vdq, Eq)(env, s, arg1, r64);
+    tcg_temp_free_i64(r64);
+}
+GEN_INSN2(movq, UdqMq, Vq)
+{
+    gen_insn2(movq, Vdq, Wq)(env, s, arg1, arg2);
+}
+
 DEF_GEN_INSN2_GVEC(movaps, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movaps, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movapd, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movapd, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movdqa, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movdqa, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movups, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movups, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movupd, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movupd, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movdqu, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movdqu, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 
 GEN_INSN4(movss, Vdq, Vdq, Wd, modrm_mod)
 {
@@ -5621,6 +5665,46 @@ GEN_INSN2(movss, Wd, Vd)
     gen_insn4(movss, Vdq, Vdq, Wd, modrm_mod)(env, s, arg1, arg1, arg2, 3);
 }
 
+GEN_INSN4(movsd, Vdq, Vdq, Wq, modrm_mod)
+{
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+    tcg_gen_ld_i64(r64, cpu_env, arg3 + offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+    if (arg4 == 3) {
+        /* merging movsd */
+        if (arg1 != arg2) {
+            tcg_gen_ld_i64(r64, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(1)));
+            tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+        }
+    } else {
+        /* zero-extending movsd */
+        tcg_gen_movi_i64(r64, 0);
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+    }
+    tcg_temp_free_i64(r64);
+}
+GEN_INSN2(movsd, Wq, Vq)
+{
+    gen_insn4(movsd, Vdq, Vdq, Wq, modrm_mod)(env, s, arg1, arg1, arg2, 3);
+}
+
+GEN_INSN2(movq2dq, Vdq, Nq)
+{
+    const insnop_arg_t(Vdq) dofs = offsetof(ZMMReg, ZMM_Q(0));
+    const insnop_arg_t(Nq) aofs = offsetof(MMXReg, MMX_Q(0));
+    gen_op_movq(s, arg1 + dofs, arg2 + aofs);
+
+    const TCGv_i64 r64z = tcg_const_i64(0);
+    tcg_gen_st_i64(r64z, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+    tcg_temp_free_i64(r64z);
+}
+GEN_INSN2(movdq2q, Pq, Uq)
+{
+    const insnop_arg_t(Pq) dofs = offsetof(MMXReg, MMX_Q(0));
+    const insnop_arg_t(Uq) aofs = offsetof(ZMMReg, ZMM_Q(0));
+    gen_op_movq(s, arg1 + dofs, arg2 + aofs);
+}
+
 GEN_INSN3(movhlps, Vdq, Vdq, UdqMhq)
 {
     const TCGv_i64 r64 = tcg_temp_new_i64();
@@ -5637,6 +5721,21 @@ GEN_INSN2(movlps, Mq, Vq)
     insnop_ldst(xmm, Mq)(env, s, 1, arg2, arg1);
 }
 
+GEN_INSN3(movlpd, Vdq, Vdq, Mq)
+{
+    insnop_ldst(xmm, Mq)(env, s, 0, arg1, arg3);
+    if (arg1 != arg2) {
+        const TCGv_i64 r64 = tcg_temp_new_i64();
+        tcg_gen_ld_i64(r64, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(1)));
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+        tcg_temp_free_i64(r64);
+    }
+}
+GEN_INSN2(movlpd, Mq, Vq)
+{
+    insnop_ldst(xmm, Mq)(env, s, 1, arg2, arg1);
+}
+
 GEN_INSN3(movlhps, Vdq, Vq, Wq)
 {
     const TCGv_i64 r64 = tcg_temp_new_i64();
@@ -5653,6 +5752,21 @@ GEN_INSN2(movhps, Mq, Vdq)
     insnop_ldst(xmm, Mhq)(env, s, 1, arg2, arg1);
 }
 
+GEN_INSN3(movhpd, Vdq, Vq, Mq)
+{
+    if (arg1 != arg2) {
+        const TCGv_i64 r64 = tcg_temp_new_i64();
+        tcg_gen_ld_i64(r64, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(0)));
+        tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+        tcg_temp_free_i64(r64);
+    }
+    insnop_ldst(xmm, Mhq)(env, s, 0, arg1, arg3);
+}
+GEN_INSN2(movhpd, Mq, Vdq)
+{
+    insnop_ldst(xmm, Mhq)(env, s, 1, arg2, arg1);
+}
+
 DEF_GEN_INSN2_HELPER_DEP(pmovmskb, pmovmskb_mmx, Gd, Nq)
 GEN_INSN2(pmovmskb, Gq, Nq)
 {
@@ -5661,6 +5775,14 @@ GEN_INSN2(pmovmskb, Gq, Nq)
     tcg_gen_extu_i32_i64(arg1, arg1_r32);
     tcg_temp_free_i32(arg1_r32);
 }
+DEF_GEN_INSN2_HELPER_DEP(pmovmskb, pmovmskb_xmm, Gd, Udq)
+GEN_INSN2(pmovmskb, Gq, Udq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(pmovmskb, Gd, Udq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
 
 DEF_GEN_INSN2_HELPER_DEP(movmskps, movmskps, Gd, Udq)
 GEN_INSN2(movmskps, Gq, Udq)
@@ -5671,78 +5793,154 @@ GEN_INSN2(movmskps, Gq, Udq)
     tcg_temp_free_i32(arg1_r32);
 }
 
+DEF_GEN_INSN2_HELPER_DEP(movmskpd, movmskpd, Gd, Udq)
+GEN_INSN2(movmskpd, Gq, Udq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(movmskpd, Gd, Udq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
+
 DEF_GEN_INSN3_GVEC(paddb, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(paddb, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddw, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(paddw, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddd, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(paddd, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(paddq, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(paddq, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(paddsb, Pq, Pq, Qq, ssadd, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(paddsb, Vdq, Vdq, Wdq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddsw, Pq, Pq, Qq, ssadd, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(paddsw, Vdq, Vdq, Wdq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddusb, Pq, Pq, Qq, usadd, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(paddusb, Vdq, Vdq, Wdq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddusw, Pq, Pq, Qq, usadd, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(paddusw, Vdq, Vdq, Wdq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(addps, addps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(addpd, addpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(addss, addss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(addsd, addsd, Vq, Vq, Wq)
 
 DEF_GEN_INSN3_GVEC(psubb, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(psubb, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubw, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(psubw, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubd, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(psubd, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(psubq, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(psubq, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(psubsb, Pq, Pq, Qq, sssub, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(psubsb, Vdq, Vdq, Wdq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubsw, Pq, Pq, Qq, sssub, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(psubsw, Vdq, Vdq, Wdq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubusb, Pq, Pq, Qq, ussub, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(psubusb, Vdq, Vdq, Wdq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubusw, Pq, Pq, Qq, ussub, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(psubusw, Vdq, Vdq, Wdq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(subps, subps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(subpd, subpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(subss, subss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(subsd, subsd, Vq, Vq, Wq)
 
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(mulps, mulps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(mulpd, mulpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(mulss, mulss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(mulsd, mulsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_xmm, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_EPP(divps, divps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(divpd, divpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(divss, divss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(divsd, divsd, Vq, Vq, Wq)
 
 DEF_GEN_INSN2_HELPER_EPP(rcpps, rcpps, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(rcpss, rcpss, Vd, Wd)
 DEF_GEN_INSN2_HELPER_EPP(sqrtps, sqrtps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(sqrtpd, sqrtpd, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(sqrtss, sqrtss, Vd, Wd)
+DEF_GEN_INSN2_HELPER_EPP(sqrtsd, sqrtsd, Vq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(rsqrtps, rsqrtps, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(rsqrtss, rsqrtss, Vd, Wd)
 
 DEF_GEN_INSN3_GVEC(pminub, Pq, Pq, Qq, umin, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(pminub, Vdq, Vdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pminsw, Pq, Pq, Qq, smin, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(pminsw, Vdq, Vdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(minps, minps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(minpd, minpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(minss, minss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(minsd, minsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_GVEC(pmaxub, Pq, Pq, Qq, umax, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(pmaxub, Vdq, Vdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pmaxsw, Pq, Pq, Qq, smax, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(pmaxsw, Vdq, Vdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(maxps, maxps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(maxpd, maxpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(maxss, maxss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(maxsd, maxsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_xmm, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_GVEC(pcmpeqb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(pcmpeqb, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(pcmpeqw, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(pcmpeqd, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpgtb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(pcmpgtb, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(pcmpgtw, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(pcmpgtd, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_GT)
 
 DEF_GEN_INSN3_HELPER_EPP(cmpeqps, cmpeqps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpeqpd, cmpeqpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpeqss, cmpeqss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpeqsd, cmpeqsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpltps, cmpltps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpltpd, cmpltpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpltss, cmpltss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpltsd, cmpltsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpleps, cmpleps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmplepd, cmplepd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpless, cmpless, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmplesd, cmplesd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpunordps, cmpunordps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpunordpd, cmpunordpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpunordss, cmpunordss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpunordsd, cmpunordsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpneqps, cmpneqps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpneqpd, cmpneqpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpneqss, cmpneqss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpneqsd, cmpneqsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnltps, cmpnltps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpnltpd, cmpnltpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnltss, cmpnltss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpnltsd, cmpnltsd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnleps, cmpnleps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpnlepd, cmpnlepd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnless, cmpnless, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpnlesd, cmpnlesd, Vq, Vq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpordps, cmpordps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(cmpordpd, cmpordpd, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(cmpordss, cmpordss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(cmpordsd, cmpordsd, Vq, Vq, Wq)
 
 GEN_INSN4(cmpps, Vdq, Vdq, Wdq, Ib)
 {
@@ -5776,6 +5974,38 @@ GEN_INSN4(cmpps, Vdq, Vdq, Wdq, Ib)
     g_assert_not_reached();
 }
 
+GEN_INSN4(cmppd, Vdq, Vdq, Wdq, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(cmpeqpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(cmpltpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(cmplepd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(cmpunordpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(cmpneqpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(cmpnltpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(cmpnlepd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(cmpordpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
 GEN_INSN4(cmpss, Vd, Vd, Wd, Ib)
 {
     switch (arg4 & 7) {
@@ -5808,26 +6038,78 @@ GEN_INSN4(cmpss, Vd, Vd, Wd, Ib)
     g_assert_not_reached();
 }
 
+GEN_INSN4(cmpsd, Vq, Vq, Wq, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(cmpeqsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(cmpltsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(cmplesd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(cmpunordsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(cmpneqsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(cmpnltsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(cmpnlesd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(cmpordsd, Vq, Vq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
 DEF_GEN_INSN2_HELPER_EPP(comiss, comiss, Vd, Wd)
+DEF_GEN_INSN2_HELPER_EPP(comisd, comisd, Vq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(ucomiss, ucomiss, Vd, Wd)
+DEF_GEN_INSN2_HELPER_EPP(ucomisd, ucomisd, Vq, Wq)
 
 DEF_GEN_INSN3_GVEC(pand, Pq, Pq, Qq, and, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(pand, Vdq, Vdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(andps, Vdq, Vdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(andpd, Vdq, Vdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pandn, Pq, Pq, Qq, andn, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(pandn, Vdq, Vdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(andnps, Vdq, Vdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(andnpd, Vdq, Vdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(por, Pq, Pq, Qq, or, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(por, Vdq, Vdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(orps, Vdq, Vdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(orpd, Vdq, Vdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pxor, Pq, Pq, Qq, xor, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(pxor, Vdq, Vdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(xorps, Vdq, Vdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(xorpd, Vdq, Vdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 
 DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psllq, psllq_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psllq, psllq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(pslldq, pslldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrlw, psrlw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrlw, psrlw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrld, psrld_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrld, psrld_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrlq, psrlq_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrlq, psrlq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(psrldq, psrldq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psraw, psraw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psraw, psraw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_xmm, Vdq, Vdq, Wdq)
 
 #define DEF_GEN_PSHIFT_IMM_MM(mnem, opT1, opT2)                         \
     GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
@@ -5841,31 +6123,70 @@ DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_mmx, Pq, Pq, Qq)
         gen_insn2(movq, Pq, Eq)(env, s, arg3_mm, arg3_r64);             \
         gen_insn3(mnem, Pq, Pq, Qq)(env, s, arg1, arg2, arg3_mm);       \
     }
+#define DEF_GEN_PSHIFT_IMM_XMM(mnem, opT1, opT2)                        \
+    GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
+    {                                                                   \
+        const uint64_t arg3_ui64 = (uint8_t)arg3;                       \
+        const insnop_arg_t(Eq) arg3_r64 = s->tmp1_i64;                  \
+        const insnop_arg_t(Wdq) arg3_xmm =                              \
+            offsetof(CPUX86State, xmm_t0.ZMM_Q(0));                     \
+                                                                        \
+        tcg_gen_movi_i64(arg3_r64, arg3_ui64);                          \
+        gen_insn2(movq, Vdq, Eq)(env, s, arg3_xmm, arg3_r64);           \
+        gen_insn3(mnem, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3_xmm);   \
+    }
 
 DEF_GEN_PSHIFT_IMM_MM(psllw, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psllw, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(pslld, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(pslld, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psllq, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psllq, Udq, Udq)
+DEF_GEN_PSHIFT_IMM_XMM(pslldq, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrlw, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psrlw, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrld, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psrld, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrlq, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psrlq, Udq, Udq)
+DEF_GEN_PSHIFT_IMM_XMM(psrldq, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psraw, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psraw, Udq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrad, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_XMM(psrad, Udq, Udq)
 
 DEF_GEN_INSN3_HELPER_EPP(packsswb, packsswb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(packsswb, packsswb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(packuswb, packuswb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(packuswb, packuswb_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklbw, punpcklbw_mmx, Pq, Pq, Qd)
+DEF_GEN_INSN3_HELPER_EPP(punpcklbw, punpcklbw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklwd, punpcklwd_mmx, Pq, Pq, Qd)
+DEF_GEN_INSN3_HELPER_EPP(punpcklwd, punpcklwd_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckldq, punpckldq_mmx, Pq, Pq, Qd)
+DEF_GEN_INSN3_HELPER_EPP(punpckldq, punpckldq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(punpcklqdq, punpcklqdq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhbw, punpckhbw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(punpckhbw, punpckhbw_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhwd, punpckhwd_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(punpckhwd, punpckhwd_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhdq, punpckhdq_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(punpckhdq, punpckhdq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(punpckhqdq, punpckhqdq_xmm, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_EPP(unpcklps, punpckldq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(unpcklpd, punpcklqdq_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(unpckhps, punpckhdq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(unpckhpd, punpckhqdq_xmm, Vdq, Vdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_PPI(pshufw, pshufw_mmx, Pq, Qq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(pshuflw, pshuflw_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(pshufhw, pshufhw_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(pshufd, pshufd_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_PPI(shufps, shufps, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_PPI(shufpd, shufpd, Vdq, Vdq, Wdq, Ib)
 
 GEN_INSN4(pinsrw, Pq, Pq, RdMw, Ib)
 {
@@ -5874,6 +6195,13 @@ GEN_INSN4(pinsrw, Pq, Pq, RdMw, Ib)
     const size_t ofs = offsetof(MMXReg, MMX_W(arg4 & 3));
     tcg_gen_st16_i32(arg3, cpu_env, arg1 + ofs);
 }
+GEN_INSN4(pinsrw, Vdq, Vdq, RdMw, Ib)
+{
+    assert(arg1 == arg2);
+
+    const size_t ofs = offsetof(ZMMReg, ZMM_W(arg4 & 7));
+    tcg_gen_st16_i32(arg3, cpu_env, arg1 + ofs);
+}
 
 GEN_INSN3(pextrw, Gd, Nq, Ib)
 {
@@ -5885,16 +6213,46 @@ GEN_INSN3(pextrw, Gq, Nq, Ib)
     const size_t ofs = offsetof(MMXReg, MMX_W(arg3 & 3));
     tcg_gen_ld16u_i64(arg1, cpu_env, arg2 + ofs);
 }
+GEN_INSN3(pextrw, Gd, Udq, Ib)
+{
+    const size_t ofs = offsetof(ZMMReg, ZMM_W(arg3 & 7));
+    tcg_gen_ld16u_i32(arg1, cpu_env, arg2 + ofs);
+}
+GEN_INSN3(pextrw, Gq, Udq, Ib)
+{
+    const size_t ofs = offsetof(ZMMReg, ZMM_W(arg3 & 7));
+    tcg_gen_ld16u_i64(arg1, cpu_env, arg2 + ofs);
+}
 
 DEF_GEN_INSN2_HELPER_EPP(cvtpi2ps, cvtpi2ps, Vdq, Qq)
 DEF_GEN_INSN2_HELPER_EPD(cvtsi2ss, cvtsi2ss, Vd, Ed)
 DEF_GEN_INSN2_HELPER_EPQ(cvtsi2ss, cvtsq2ss, Vd, Eq)
+DEF_GEN_INSN2_HELPER_EPP(cvtpi2pd, cvtpi2pd, Vdq, Qq)
+DEF_GEN_INSN2_HELPER_EPD(cvtsi2sd, cvtsi2sd, Vq, Ed)
+DEF_GEN_INSN2_HELPER_EPQ(cvtsi2sd, cvtsq2sd, Vq, Eq)
 DEF_GEN_INSN2_HELPER_EPP(cvtps2pi, cvtps2pi, Pq, Wq)
 DEF_GEN_INSN2_HELPER_DEP(cvtss2si, cvtss2si, Gd, Wd)
 DEF_GEN_INSN2_HELPER_QEP(cvtss2si, cvtss2sq, Gq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(cvtpd2pi, cvtpd2pi, Pq, Wdq)
+DEF_GEN_INSN2_HELPER_DEP(cvtsd2si, cvtsd2si, Gd, Wq)
+DEF_GEN_INSN2_HELPER_QEP(cvtsd2si, cvtsd2sq, Gq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(cvttps2pi, cvttps2pi, Pq, Wq)
 DEF_GEN_INSN2_HELPER_DEP(cvttss2si, cvttss2si, Gd, Wd)
 DEF_GEN_INSN2_HELPER_QEP(cvttss2si, cvttss2sq, Gq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(cvttpd2pi, cvttpd2pi, Pq, Wdq)
+DEF_GEN_INSN2_HELPER_DEP(cvttsd2si, cvttsd2si, Gd, Wq)
+DEF_GEN_INSN2_HELPER_QEP(cvttsd2si, cvttsd2sq, Gq, Wq)
+
+DEF_GEN_INSN2_HELPER_EPP(cvtpd2dq, cvtpd2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(cvttpd2dq, cvttpd2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(cvtdq2pd, cvtdq2pd, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(cvtps2pd, cvtps2pd, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(cvtpd2ps, cvtpd2ps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(cvtss2sd, cvtss2sd, Vq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(cvtsd2ss, cvtsd2ss, Vd, Wq)
+DEF_GEN_INSN2_HELPER_EPP(cvtdq2ps, cvtdq2ps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(cvtps2dq, cvtps2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(cvttps2dq, cvttps2dq, Vdq, Wdq)
 
 GEN_INSN2(maskmovq, Pq, Nq)
 {
@@ -5912,25 +6270,90 @@ GEN_INSN2(maskmovq, Pq, Nq)
     tcg_temp_free_ptr(arg1_ptr);
     tcg_temp_free_ptr(arg2_ptr);
 }
+GEN_INSN2(maskmovdqu, Vdq, Udq)
+{
+    const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();
+    const TCGv_ptr arg2_ptr = tcg_temp_new_ptr();
+
+    tcg_gen_mov_tl(s->A0, cpu_regs[R_EDI]);
+    gen_extu(s->aflag, s->A0);
+    gen_add_A0_ds_seg(s);
+
+    tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);
+    tcg_gen_addi_ptr(arg2_ptr, cpu_env, arg2);
+    gen_helper_maskmov_xmm(cpu_env, arg1_ptr, arg2_ptr, s->A0);
+
+    tcg_temp_free_ptr(arg1_ptr);
+    tcg_temp_free_ptr(arg2_ptr);
+}
 
 GEN_INSN2(movntps, Mdq, Vdq)
 {
     insnop_ldst(xmm, Mdq)(env, s, 1, arg2, arg1);
 }
+GEN_INSN2(movntpd, Mdq, Vdq)
+{
+    insnop_ldst(xmm, Mdq)(env, s, 1, arg2, arg1);
+}
+
+GEN_INSN2(movnti, Md, Gd)
+{
+    insnop_ldst(tcg_i32, Md)(env, s, 1, arg2, arg1);
+}
+GEN_INSN2(movnti, Mq, Gq)
+{
+    insnop_ldst(tcg_i64, Mq)(env, s, 1, arg2, arg1);
+}
 
 GEN_INSN2(movntq, Mq, Pq)
 {
     insnop_ldst(mm, Mq)(env, s, 1, arg2, arg1);
 }
+GEN_INSN2(movntdq, Mdq, Vdq)
+{
+    insnop_ldst(xmm, Mdq)(env, s, 1, arg2, arg1);
+}
+
+GEN_INSN0(pause)
+{
+    /* handled in disas_insn at the moment */
+    g_assert_not_reached();
+}
 
 DEF_GEN_INSN0_HELPER(emms, emms)
 
-GEN_INSN0(sfence)
+GEN_INSN2(sfence_clflush, modrm_mod, modrm)
+{
+    if (arg1 == 3) {
+        /* sfence */
+        if (s->prefix & PREFIX_LOCK) {
+            gen_illegal_opcode(s);
+        } else {
+            tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
+        }
+    } else {
+        /* clflush */
+        if (!check_cpuid(env, s, CHECK_CPUID_CLFLUSH)) {
+            gen_illegal_opcode(s);
+        } else {
+            gen_nop_modrm(env, s, arg2);
+        }
+    }
+}
+GEN_INSN0(lfence)
+{
+    if (s->prefix & PREFIX_LOCK) {
+        gen_illegal_opcode(s);
+    } else {
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_BAR_SC);
+    }
+}
+GEN_INSN0(mfence)
 {
     if (s->prefix & PREFIX_LOCK) {
         gen_illegal_opcode(s);
     } else {
-        tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
     }
 }
 
-- 
2.20.1


