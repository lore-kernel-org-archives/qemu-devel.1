Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017E9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFA62065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 21:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krucVGRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFA62065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZLVS-0004iv-Vb
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 17:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZLPH-0004ES-7p
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:28:43 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZLPG-0004bx-0v
 for qemu-devel@nongnu.org; Thu, 14 May 2020 17:28:42 -0400
Received: by mail-pj1-x1042.google.com with SMTP id hi11so23346pjb.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 14:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eFKOT9NBLVT8m1oyDedlD+LWCS/9nf6l8OhFQLOWEa4=;
 b=krucVGRF0glUTFFSPDYGzufm0exr2jnYcheom56wcdCqfsA0G3DmzA3MCkOTOlVOZi
 MXtcTI4F/gfMfMzYo9vr2zXBbH4eMHgLFVFx4/8c4X4vANtdAkYVruzg2GBvXSzOEdu/
 khTJWm5sU+l1k0u/SGWxhYIwqn+1FdBUNCzOKnS8Cay50TIhf4Hr5o0sv2LMm0GNUR41
 RceojQuQyWeOCHFZYWXXRG8Qu/iddSf3uslAuWz8OhU7xs6v7ul4vrR1LKmGksDyUH1U
 KpWkSrZSd9bAm+4BHdkjYk7uLTk5LIag4ZZh5h0iTx8I37U2hetaFH9Gr1n9Ani3v8KS
 e0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eFKOT9NBLVT8m1oyDedlD+LWCS/9nf6l8OhFQLOWEa4=;
 b=nHmJON7t8aULsDPo9/Od8iVu+FMbIjX95ZGLXDWO9N480NbTYoCdkJlVhR/bm8XY5z
 32xdtAx4St6dOIYfSxHXlXkXHmqQax8qvXX5TIseBVjWRu5pnW55d9VPFSqGhbYhyhlZ
 Y/m9sEx7pzlaGAAFeDWPIvp7TiKrvYcSUnnxDADUrK/wGSw30ew9fPIMkBabpKNjfJ3j
 aQYKf67kagqSHBsYHhPR83fc7Ut9zypRvhkaj4S0GmlZCp/AmOcPCnFgTo5vI5GqGym/
 MVLpkJc7uVVTzswS2EJUbNnVVg8sHqyfRe1L4pfOjy/ewOICKW2xV8Qj3IOeX/WI7Xnf
 fI4A==
X-Gm-Message-State: AOAM5328cGunrJWfeW4KBa0orV0XvM65K63/eg/Kbw7Pm6qNOtrCwW5N
 EKYE7hP2GTVcrKiaRA217ADQPL43Hxc=
X-Google-Smtp-Source: ABdhPJzctXb2zGeei3sZiPqaIiiYVQ3GBURIADKJBkuUwWbVMNt/5y/C+VHCZRM+tFFLAnjpTOR1eg==
X-Received: by 2002:a17:90a:28e5:: with SMTP id f92mr9662pjd.38.1589491720183; 
 Thu, 14 May 2020 14:28:40 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i7sm4986pjj.33.2020.05.14.14.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 14:28:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] target/arm: Split helper_crypto_sha1_3reg
Date: Thu, 14 May 2020 14:28:30 -0700
Message-Id: <20200514212831.31248-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514212831.31248-1-richard.henderson@linaro.org>
References: <20200514212831.31248-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than passing an opcode to a helper, fully decode the
operation at translate time.  Use clear_tail_16 to zap the
balance of the SVE register with the AdvSIMD write.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |  5 +-
 target/arm/neon-dp.decode       |  6 +-
 target/arm/crypto_helper.c      | 99 +++++++++++++++++++++------------
 target/arm/translate-a64.c      | 29 ++++------
 target/arm/translate-neon.inc.c | 46 ++++-----------
 5 files changed, 93 insertions(+), 92 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index cee23adbfc..13475ecf81 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -513,7 +513,10 @@ DEF_HELPER_FLAGS_2(neon_qzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_4(crypto_sha1_3reg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha1su0, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha1c, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha1p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha1m, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_sha1h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_sha1su1, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 5b2fc65d72..8af7c53d8b 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -168,8 +168,10 @@ VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
 @3same_crypto    .... .... .... .... .... .... .... .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=0 q=1
 
-SHA1_3s          1111 001 0 0 . optype:2 .... .... 1100 . 1 . 0 .... \
-                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
+SHA1C_3s         1111 001 0 0 . 00 .... .... 1100 . 1 . 0 .... @3same_crypto
+SHA1P_3s         1111 001 0 0 . 01 .... .... 1100 . 1 . 0 .... @3same_crypto
+SHA1M_3s         1111 001 0 0 . 10 .... .... 1100 . 1 . 0 .... @3same_crypto
+SHA1SU0_3s       1111 001 0 0 . 11 .... .... 1100 . 1 . 0 .... @3same_crypto
 SHA256H_3s       1111 001 1 0 . 00 .... .... 1100 . 1 . 0 .... @3same_crypto
 SHA256H2_3s      1111 001 1 0 . 01 .... .... 1100 . 1 . 0 .... @3same_crypto
 SHA256SU1_3s     1111 001 1 0 . 10 .... .... 1100 . 1 . 0 .... @3same_crypto
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 7124745c32..636683d0f1 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -24,11 +24,11 @@ union CRYPTO_STATE {
 };
 
 #ifdef HOST_WORDS_BIGENDIAN
-#define CR_ST_BYTE(state, i)   (state.bytes[(15 - (i)) ^ 8])
-#define CR_ST_WORD(state, i)   (state.words[(3 - (i)) ^ 2])
+#define CR_ST_BYTE(state, i)   ((state).bytes[(15 - (i)) ^ 8])
+#define CR_ST_WORD(state, i)   ((state).words[(3 - (i)) ^ 2])
 #else
-#define CR_ST_BYTE(state, i)   (state.bytes[i])
-#define CR_ST_WORD(state, i)   (state.words[i])
+#define CR_ST_BYTE(state, i)   ((state).bytes[i])
+#define CR_ST_WORD(state, i)   ((state).words[i])
 #endif
 
 /*
@@ -258,49 +258,74 @@ static uint32_t maj(uint32_t x, uint32_t y, uint32_t z)
     return (x & y) | ((x | y) & z);
 }
 
-void HELPER(crypto_sha1_3reg)(void *vd, void *vn, void *vm, uint32_t op)
+void HELPER(crypto_sha1su0)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint64_t d0, d1;
+
+    d0 = d[1] ^ d[0] ^ m[0];
+    d1 = n[0] ^ d[1] ^ m[1];
+    d[0] = d0;
+    d[1] = d1;
+
+    clear_tail_16(vd, desc);
+}
+
+static inline void crypto_sha1_3reg(uint64_t *rd, uint64_t *rn,
+                                    uint64_t *rm, uint32_t desc,
+                                    uint32_t (*fn)(union CRYPTO_STATE *d))
 {
-    uint64_t *rd = vd;
-    uint64_t *rn = vn;
-    uint64_t *rm = vm;
     union CRYPTO_STATE d = { .l = { rd[0], rd[1] } };
     union CRYPTO_STATE n = { .l = { rn[0], rn[1] } };
     union CRYPTO_STATE m = { .l = { rm[0], rm[1] } };
+    int i;
 
-    if (op == 3) { /* sha1su0 */
-        d.l[0] ^= d.l[1] ^ m.l[0];
-        d.l[1] ^= n.l[0] ^ m.l[1];
-    } else {
-        int i;
+    for (i = 0; i < 4; i++) {
+        uint32_t t = fn(&d);
 
-        for (i = 0; i < 4; i++) {
-            uint32_t t;
+        t += rol32(CR_ST_WORD(d, 0), 5) + CR_ST_WORD(n, 0)
+             + CR_ST_WORD(m, i);
 
-            switch (op) {
-            case 0: /* sha1c */
-                t = cho(CR_ST_WORD(d, 1), CR_ST_WORD(d, 2), CR_ST_WORD(d, 3));
-                break;
-            case 1: /* sha1p */
-                t = par(CR_ST_WORD(d, 1), CR_ST_WORD(d, 2), CR_ST_WORD(d, 3));
-                break;
-            case 2: /* sha1m */
-                t = maj(CR_ST_WORD(d, 1), CR_ST_WORD(d, 2), CR_ST_WORD(d, 3));
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            t += rol32(CR_ST_WORD(d, 0), 5) + CR_ST_WORD(n, 0)
-                 + CR_ST_WORD(m, i);
-
-            CR_ST_WORD(n, 0) = CR_ST_WORD(d, 3);
-            CR_ST_WORD(d, 3) = CR_ST_WORD(d, 2);
-            CR_ST_WORD(d, 2) = ror32(CR_ST_WORD(d, 1), 2);
-            CR_ST_WORD(d, 1) = CR_ST_WORD(d, 0);
-            CR_ST_WORD(d, 0) = t;
-        }
+        CR_ST_WORD(n, 0) = CR_ST_WORD(d, 3);
+        CR_ST_WORD(d, 3) = CR_ST_WORD(d, 2);
+        CR_ST_WORD(d, 2) = ror32(CR_ST_WORD(d, 1), 2);
+        CR_ST_WORD(d, 1) = CR_ST_WORD(d, 0);
+        CR_ST_WORD(d, 0) = t;
     }
     rd[0] = d.l[0];
     rd[1] = d.l[1];
+
+    clear_tail_16(rd, desc);
+}
+
+static uint32_t do_sha1c(union CRYPTO_STATE *d)
+{
+    return cho(CR_ST_WORD(*d, 1), CR_ST_WORD(*d, 2), CR_ST_WORD(*d, 3));
+}
+
+void HELPER(crypto_sha1c)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    crypto_sha1_3reg(vd, vn, vm, desc, do_sha1c);
+}
+
+static uint32_t do_sha1p(union CRYPTO_STATE *d)
+{
+    return par(CR_ST_WORD(*d, 1), CR_ST_WORD(*d, 2), CR_ST_WORD(*d, 3));
+}
+
+void HELPER(crypto_sha1p)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    crypto_sha1_3reg(vd, vn, vm, desc, do_sha1p);
+}
+
+static uint32_t do_sha1m(union CRYPTO_STATE *d)
+{
+    return maj(CR_ST_WORD(*d, 1), CR_ST_WORD(*d, 2), CR_ST_WORD(*d, 3));
+}
+
+void HELPER(crypto_sha1m)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    crypto_sha1_3reg(vd, vn, vm, desc, do_sha1m);
 }
 
 void HELPER(crypto_sha1h)(void *vd, void *vm, uint32_t desc)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d3094d5dfd..49ca7ac76e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13470,10 +13470,19 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
 
     switch (opcode) {
     case 0: /* SHA1C */
+        genfn = gen_helper_crypto_sha1c;
+        feature = dc_isar_feature(aa64_sha1, s);
+        break;
     case 1: /* SHA1P */
+        genfn = gen_helper_crypto_sha1p;
+        feature = dc_isar_feature(aa64_sha1, s);
+        break;
     case 2: /* SHA1M */
+        genfn = gen_helper_crypto_sha1m;
+        feature = dc_isar_feature(aa64_sha1, s);
+        break;
     case 3: /* SHA1SU0 */
-        genfn = NULL;
+        genfn = gen_helper_crypto_sha1su0;
         feature = dc_isar_feature(aa64_sha1, s);
         break;
     case 4: /* SHA256H */
@@ -13501,23 +13510,7 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
     if (!fp_access_check(s)) {
         return;
     }
-
-    if (genfn) {
-        gen_gvec_op3_ool(s, true, rd, rn, rm, 0, genfn);
-    } else {
-        TCGv_i32 tcg_opcode = tcg_const_i32(opcode);
-        TCGv_ptr tcg_rd_ptr = vec_full_reg_ptr(s, rd);
-        TCGv_ptr tcg_rn_ptr = vec_full_reg_ptr(s, rn);
-        TCGv_ptr tcg_rm_ptr = vec_full_reg_ptr(s, rm);
-
-        gen_helper_crypto_sha1_3reg(tcg_rd_ptr, tcg_rn_ptr,
-                                    tcg_rm_ptr, tcg_opcode);
-
-        tcg_temp_free_i32(tcg_opcode);
-        tcg_temp_free_ptr(tcg_rd_ptr);
-        tcg_temp_free_ptr(tcg_rn_ptr);
-        tcg_temp_free_ptr(tcg_rm_ptr);
-    }
+    gen_gvec_op3_ool(s, true, rd, rn, rm, 0, genfn);
 }
 
 /* Crypto two-reg SHA
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 205877ca48..7b19753c8c 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -693,42 +693,20 @@ static bool trans_VMUL_p_3s(DisasContext *s, arg_3same *a)
 DO_VQRDMLAH(VQRDMLAH, gen_gvec_sqrdmlah_qc)
 DO_VQRDMLAH(VQRDMLSH, gen_gvec_sqrdmlsh_qc)
 
-static bool trans_SHA1_3s(DisasContext *s, arg_SHA1_3s *a)
-{
-    TCGv_ptr ptr1, ptr2, ptr3;
-    TCGv_i32 tmp;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON) ||
-        !dc_isar_feature(aa32_sha1, s)) {
-        return false;
+#define DO_SHA1(NAME, FUNC)                                             \
+    WRAP_OOL_FN(gen_##NAME##_3s, FUNC)                                  \
+    static bool trans_##NAME##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        if (!dc_isar_feature(aa32_sha1, s)) {                           \
+            return false;                                               \
+        }                                                               \
+        return do_3same(s, a, gen_##NAME##_3s);                         \
     }
 
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if ((a->vn | a->vm | a->vd) & 1) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    ptr1 = vfp_reg_ptr(true, a->vd);
-    ptr2 = vfp_reg_ptr(true, a->vn);
-    ptr3 = vfp_reg_ptr(true, a->vm);
-    tmp = tcg_const_i32(a->optype);
-    gen_helper_crypto_sha1_3reg(ptr1, ptr2, ptr3, tmp);
-    tcg_temp_free_i32(tmp);
-    tcg_temp_free_ptr(ptr1);
-    tcg_temp_free_ptr(ptr2);
-    tcg_temp_free_ptr(ptr3);
-
-    return true;
-}
+DO_SHA1(SHA1C, gen_helper_crypto_sha1c)
+DO_SHA1(SHA1P, gen_helper_crypto_sha1p)
+DO_SHA1(SHA1M, gen_helper_crypto_sha1m)
+DO_SHA1(SHA1SU0, gen_helper_crypto_sha1su0)
 
 #define DO_SHA2(NAME, FUNC)                                             \
     WRAP_OOL_FN(gen_##NAME##_3s, FUNC)                                  \
-- 
2.20.1


