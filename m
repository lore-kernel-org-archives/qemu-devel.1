Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97090C83003
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51959208E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 02:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bi8D1jZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51959208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTycK-0003M7-H0
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 22:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyYx-0006yT-TR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jTyXh-0004jy-Pj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:04:31 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jTyXh-0004jZ-CD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 22:03:13 -0400
Received: by mail-pg1-x541.google.com with SMTP id n11so1993858pgl.9
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 19:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IVR+Pu37fpOVwf26ZZgBarhOf00fJmv9hlEtbY+xKbU=;
 b=Bi8D1jZ2iBLKBH23sgPuhJh6OPDKl1fqp0d2t7n44joH5QL3/1R2oktREjcH6xUtfX
 82Cba/D7YBAGKww8rST+RE2GuxhgZe1s7QT7aJzuZpIs44h4eivzvil52aT1y1ovqgn/
 FAbjuYB/YJi0ybsWInkjRYjIaYOCENFkeUhX+y+B35pgWkYzYLi3iScd25bT7q0b2qfO
 VJkCuf7UnrN3zzP/u7qgXPSpehO0R1KDvZz3Hw4LpdCyziW5s9NE1a+CelQSubnPvEV7
 a2i1u17JQ2CQzVFwMB4vtkrx3NT69LmHU6e/m0nYEVbYIan8+MtIjj0zw+Huv4hCmpc5
 IJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IVR+Pu37fpOVwf26ZZgBarhOf00fJmv9hlEtbY+xKbU=;
 b=Dd/TJHOX1VB0KYHQri4SZ0m+FMO5Sm48CYOkF6A45rtEtmVYRp8BvvrJmNqB8iZfYT
 syVfLKu2r1SV3Kp9XaTXH+fG9qoyJQIT+MPhe9Fa/AByopZxNg1PNAsxVunBGwuSqQYW
 1XRG6g3/0YGkR0FTTjj7MxUWkESnH1q/VqJT+E9osH6SsxFEm3KSUm2X4A3et1fGT7ch
 dTIxgXm84IslaR2QRsZXf1VB/Zo9DfMZzt8V0EpN/XqE/mRGmX8b9UfxwMwlPZnhqwiS
 bOxfqmgBhVxZhCxhvH0STyPX5n1AurJuNQgHCEwROGss7gAYYzooPMvy+O576BaE/Lio
 0akQ==
X-Gm-Message-State: AGi0PuZH98jCqlb9VHf1AgqW2jGAKk8Kw2XZL1d+mvT6t8xSo9qXfBdO
 IU4WCTnclit9om0df9d/iq+ywGg5i4Q=
X-Google-Smtp-Source: APiQypKCL/Uv3sB360vEqMXo6WVMMcMt5AZZhlyWwnaKDQajZi54wrM4TOuM3Ql3OdVZ8BMXh/TAyg==
X-Received: by 2002:a62:5c6:: with SMTP id 189mr1145273pff.39.1588212191346;
 Wed, 29 Apr 2020 19:03:11 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y3sm409284pjb.41.2020.04.29.19.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 19:03:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/9] target/arm: Split helper_crypto_sha1_3reg
Date: Wed, 29 Apr 2020 19:02:59 -0700
Message-Id: <20200430020303.20264-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430020303.20264-1-richard.henderson@linaro.org>
References: <20200430020303.20264-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than passing an opcode to a helper, fully decode the
operation at translate time.  Use clear_tail_16 to zap the
balance of the SVE register with the AdvSIMD write.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  5 +-
 target/arm/crypto_helper.c | 99 ++++++++++++++++++++++++--------------
 target/arm/translate-a64.c | 29 +++++------
 target/arm/translate.c     | 70 +++++++++++++++------------
 4 files changed, 116 insertions(+), 87 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 07466ddc6c..24aca28a05 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -516,7 +516,10 @@ DEF_HELPER_FLAGS_2(neon_qzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_4(crypto_sha1_3reg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha1su0, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha1c, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha1p, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_sha1m, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_sha1h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_sha1su1, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
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
index 48f71e01e4..81ad287811 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14527,10 +14527,19 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
 
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
@@ -14558,23 +14567,7 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
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
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 517048e982..34ea5e53e7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5305,7 +5305,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int vec_size;
     uint32_t imm;
     TCGv_i32 tmp, tmp2, tmp3, tmp4, tmp5;
-    TCGv_ptr ptr1, ptr2, ptr3;
+    TCGv_ptr ptr1;
     TCGv_i64 tmp64;
 
     /* FIXME: this access check should not take precedence over UNDEF
@@ -5353,38 +5353,46 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
              */
             if (!q) {
                 return 1;
-            }
-            if (!u) { /* SHA-1 */
-                if (!dc_isar_feature(aa32_sha1, s)) {
-                    return 1;
-                }
-                ptr1 = vfp_reg_ptr(true, rd);
-                ptr2 = vfp_reg_ptr(true, rn);
-                ptr3 = vfp_reg_ptr(true, rm);
-                tmp4 = tcg_const_i32(size);
-                gen_helper_crypto_sha1_3reg(ptr1, ptr2, ptr3, tmp4);
-                tcg_temp_free_i32(tmp4);
-                tcg_temp_free_ptr(ptr1);
-                tcg_temp_free_ptr(ptr2);
-                tcg_temp_free_ptr(ptr3);
-            } else { /* SHA-256 */
+            } else {
                 gen_helper_gvec_3 *fn;
 
-                if (!dc_isar_feature(aa32_sha2, s)) {
-                    return 1;
-                }
-                switch (size) {
-                case 0:
-                    fn = gen_helper_crypto_sha256h;
-                    break;
-                case 1:
-                    fn = gen_helper_crypto_sha256h2;
-                    break;
-                case 2:
-                    fn = gen_helper_crypto_sha256su1;
-                    break;
-                default:
-                    return 1;
+                if (!u) { /* SHA-1 */
+                    if (!dc_isar_feature(aa32_sha1, s)) {
+                        return 1;
+                    }
+                    switch (size) {
+                    case 0:
+                        fn = gen_helper_crypto_sha1c;
+                        break;
+                    case 1:
+                        fn = gen_helper_crypto_sha1p;
+                        break;
+                    case 2:
+                        fn = gen_helper_crypto_sha1m;
+                        break;
+                    case 3:
+                        fn = gen_helper_crypto_sha1su0;
+                        break;
+                    default:
+                        g_assert_not_reached();
+                    }
+                } else { /* SHA-256 */
+                    if (!dc_isar_feature(aa32_sha2, s)) {
+                        return 1;
+                    }
+                    switch (size) {
+                    case 0:
+                        fn = gen_helper_crypto_sha256h;
+                        break;
+                    case 1:
+                        fn = gen_helper_crypto_sha256h2;
+                        break;
+                    case 2:
+                        fn = gen_helper_crypto_sha256su1;
+                        break;
+                    default:
+                        return 1;
+                    }
                 }
                 tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, 16, 16, 0, fn);
             }
-- 
2.20.1


