Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188B6C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B131020866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOTFoYWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B131020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhea-0000vd-TV
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:19:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRZ-0006YJ-BH
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRV-0002wg-M9
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:09 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRT-0002uz-Ut
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:05 -0400
Received: by mail-pg1-x542.google.com with SMTP id f6so7859774pgs.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=sCQms03lBEjNEnoZ94CmHhqyqEk2oJU56MWCHZv2ODM=;
	b=VOTFoYWJr4zpFovHfEA8y+T0OJYiM8kb5ei5vt72we66mwWzYxoLvfqNYrJebXABaA
	Vx8xo7il14yhfMDMc+gk2pCX1yI1HjhR8Oh8y8z6Sj7YhMfW1DCda2hEeTIOEorpIHgt
	kGNoL6OLh6/LuN6CySObHa85RMZLWiBgVUHR+d5IR3b6Y+kwYebpTilI8w845KLKSgap
	YOx8rZ1U8SkcJ0npVPiN/i5zDhTnnGV8aSWM7nJl+eQx7LnEKHfrvPpH4oDcn7QMeJnN
	A7ebZ8hPp8/zoHMNdoQyum3Y93y294mWimwQI5gHIRX8q1NJi2e9W/lqXMBTUpTkIwuI
	eXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=sCQms03lBEjNEnoZ94CmHhqyqEk2oJU56MWCHZv2ODM=;
	b=julPS6Z97ymZHAFdMMGsarumrdM7+hk4nofh50vLXIN49lWDL5XOUeV2WYzjJ3nUsI
	J0Dbeu6MuxS47smlxi+KtRD4Xf0QycflWT1PT0EwkJY0fewBJgK6w+QdaQTN7chs26ai
	D6hIRiuq8CEf5XmWUDeK5EIjiTAGLuO5pJno1F5/xHftn/56Nfahphd9mXAMTR7jQaGZ
	8XVwY1wminTkho3bWvE69BMeYgW/ljkdeT8YJuO5F16o0uMJ1BjvDn48h3mPkYX5eob7
	mRQ6IFH8oEZxZI8XGy7p4TJ+LpcqNwFjxtBOvOGB3hNYvDpQsg+JWLfU1IzshB7zs9AR
	csjA==
X-Gm-Message-State: APjAAAXkx31hvEMj9cBmeJ6uRuVTX2UsYu/VmYHuKzsqOck4k0oXiHF/
	hSAmpYpa901ZmqdL1qGxPppCT+g7U8k=
X-Google-Smtp-Source: APXvYqzI7Oa7O0S4y7fAus5F1gu12XqE/WQ5k+QeKKpoIE/y2fSmypOM5Lfkl+c1QxzAeEJqu63gJA==
X-Received: by 2002:aa7:8190:: with SMTP id g16mr30425323pfi.92.1556687160907; 
	Tue, 30 Apr 2019 22:06:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:21 -0700
Message-Id: <20190501050536.15580-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v2 14/29] tcg: Add gvec expanders for variable
 shift
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
Message-ID: <20190501050521.cYfPSAxMrzFxL4eEyQKewTojCrpjxeuJ9lp55y9txe4@z>

The gvec expanders perform a modulo on the shift count.  If the target
requires alternate behaviour, then it cannot use the generic gvec
expanders anyway, and will have to have its own custom code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  15 +++
 tcg/tcg-op-gvec.h            |  11 ++
 tcg/tcg-op.h                 |   4 +
 accel/tcg/tcg-runtime-gvec.c | 144 ++++++++++++++++++++++++++
 tcg/tcg-op-gvec.c            | 195 +++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  15 +++
 6 files changed, 384 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index dfe325625c..ed3ce5fd91 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -254,6 +254,21 @@ DEF_HELPER_FLAGS_3(gvec_sar16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sar32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sar64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_shl8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shl16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shl32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shl64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_shr8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shr16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shr32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shr64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_sar8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sar16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sar32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sar64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_eq8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_eq16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_eq32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index ac744ff7c9..84a6247b16 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -318,6 +318,17 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 
+/*
+ * Perform vector shift by vector element, modulo the element size.
+ * E.g.  D[i] = A[i] << (B[i] % (8 << vece)).
+ */
+void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+
 void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
                       uint32_t aofs, uint32_t bofs,
                       uint32_t oprsz, uint32_t maxsz);
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 9fff9864f6..833c6330b5 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -986,6 +986,10 @@ void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 
+void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                      TCGv_vec a, TCGv_vec b);
 
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index e2c6f24262..2152fb6903 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -725,6 +725,150 @@ void HELPER(gvec_sar64i)(void *d, void *a, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_shl8v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        uint8_t sh = *(uint8_t *)(b + i) & 7;
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) << sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shl16v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        uint8_t sh = *(uint16_t *)(b + i) & 15;
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) << sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shl32v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        uint8_t sh = *(uint32_t *)(b + i) & 31;
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) << sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shl64v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint8_t sh = *(uint64_t *)(b + i) & 63;
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) << sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr8v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        uint8_t sh = *(uint8_t *)(b + i) & 7;
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) >> sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr16v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        uint8_t sh = *(uint16_t *)(b + i) & 15;
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) >> sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr32v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        uint8_t sh = *(uint32_t *)(b + i) & 31;
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) >> sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr64v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint8_t sh = *(uint64_t *)(b + i) & 63;
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) >> sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar8v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        uint8_t sh = *(uint8_t *)(b + i) & 7;
+        *(int8_t *)(d + i) = *(int8_t *)(a + i) >> sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar16v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        uint8_t sh = *(uint16_t *)(b + i) & 15;
+        *(int16_t *)(d + i) = *(int16_t *)(a + i) >> sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar32v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        uint8_t sh = *(uint32_t *)(b + i) & 31;
+        *(int32_t *)(d + i) = *(int32_t *)(a + i) >> sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar64v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        uint8_t sh = *(uint64_t *)(b + i) & 63;
+        *(int64_t *)(d + i) = *(int64_t *)(a + i) >> sh;
+    }
+    clear_high(d, oprsz, desc);
+}
+
 /* If vectors are enabled, the compiler fills in -1 for true.
    Otherwise, we must take care of this by hand.  */
 #ifdef CONFIG_VECTOR16
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 35ebc5a201..061ef329f1 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2555,6 +2555,201 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
     }
 }
 
+/*
+ * Expand D = A << (B % element bits)
+ *
+ * Unlike scalar shifts, where it is easy for the target front end
+ * to include the modulo as part of the expansion.  If the target
+ * naturally includes the modulo as part of the operation, great!
+ * If the target has some other behaviour from out-of-range shifts,
+ * then it could not use this function anyway, and would need to
+ * do it's own expansion with custom functions.
+ */
+static void tcg_gen_shlv_mod_vec(unsigned vece, TCGv_vec d,
+                                 TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
+    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_shlv_vec(vece, d, a, t);
+    tcg_temp_free_vec(t);
+}
+
+static void tcg_gen_shl_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_andi_i32(t, b, 31);
+    tcg_gen_shl_i32(d, a, t);
+    tcg_temp_free_i32(t);
+}
+
+static void tcg_gen_shl_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(t, b, 63);
+    tcg_gen_shl_i64(d, a, t);
+    tcg_temp_free_i64(t);
+}
+
+void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_shlv_vec, 0 };
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_shlv_mod_vec,
+          .fno = gen_helper_gvec_shl8v,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_shlv_mod_vec,
+          .fno = gen_helper_gvec_shl16v,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_shl_mod_i32,
+          .fniv = tcg_gen_shlv_mod_vec,
+          .fno = gen_helper_gvec_shl32v,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_shl_mod_i64,
+          .fniv = tcg_gen_shlv_mod_vec,
+          .fno = gen_helper_gvec_shl64v,
+          .opt_opc = vecop_list,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
+/*
+ * Similarly for logical right shifts.
+ */
+
+static void tcg_gen_shrv_mod_vec(unsigned vece, TCGv_vec d,
+                                 TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
+    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_shrv_vec(vece, d, a, t);
+    tcg_temp_free_vec(t);
+}
+
+static void tcg_gen_shr_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_andi_i32(t, b, 31);
+    tcg_gen_shr_i32(d, a, t);
+    tcg_temp_free_i32(t);
+}
+
+static void tcg_gen_shr_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(t, b, 63);
+    tcg_gen_shr_i64(d, a, t);
+    tcg_temp_free_i64(t);
+}
+
+void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_shrv_vec, 0 };
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_shrv_mod_vec,
+          .fno = gen_helper_gvec_shr8v,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_shrv_mod_vec,
+          .fno = gen_helper_gvec_shr16v,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_shr_mod_i32,
+          .fniv = tcg_gen_shrv_mod_vec,
+          .fno = gen_helper_gvec_shr32v,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_shr_mod_i64,
+          .fniv = tcg_gen_shrv_mod_vec,
+          .fno = gen_helper_gvec_shr64v,
+          .opt_opc = vecop_list,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
+/*
+ * Similarly for arithmetic right shifts.
+ */
+
+static void tcg_gen_sarv_mod_vec(unsigned vece, TCGv_vec d,
+                                 TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
+    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_sarv_vec(vece, d, a, t);
+    tcg_temp_free_vec(t);
+}
+
+static void tcg_gen_sar_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_andi_i32(t, b, 31);
+    tcg_gen_sar_i32(d, a, t);
+    tcg_temp_free_i32(t);
+}
+
+static void tcg_gen_sar_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(t, b, 63);
+    tcg_gen_sar_i64(d, a, t);
+    tcg_temp_free_i64(t);
+}
+
+void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_sarv_vec, 0 };
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_sarv_mod_vec,
+          .fno = gen_helper_gvec_sar8v,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_sarv_mod_vec,
+          .fno = gen_helper_gvec_sar16v,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_sar_mod_i32,
+          .fniv = tcg_gen_sarv_mod_vec,
+          .fno = gen_helper_gvec_sar32v,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_sar_mod_i64,
+          .fniv = tcg_gen_sarv_mod_vec,
+          .fno = gen_helper_gvec_sar64v,
+          .opt_opc = vecop_list,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
 static void expand_cmp_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                            uint32_t oprsz, TCGCond cond)
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 213d2e22aa..96317dbd10 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -583,3 +583,18 @@ void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
     do_op3(vece, r, a, b, INDEX_op_umax_vec);
 }
+
+void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_shlv_vec);
+}
+
+void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_shrv_vec);
+}
+
+void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_sarv_vec);
+}
-- 
2.17.1


