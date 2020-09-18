Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E363C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7025922208
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzRt3rp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7025922208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJM4p-0005hG-EP
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHe-0000kv-2a
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:03 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHb-0007C5-0u
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:57 -0400
Received: by mail-pj1-x1041.google.com with SMTP id u3so3459672pjr.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5lA9h6er1TNE/JRaTF1NKAfHTgmAILWUVDozjnr4f8U=;
 b=UzRt3rp31xcbPhPYyEyqXIP6yLfII0C3fx0sL98LinwU2gZ6mYUnP1qL0ReIc4ihIj
 pZu9MnpIUGW3P3+1YBopezQ4hNXXPsQ5nKhpJVNkMxr7KKhiRbaAldkm/c2kbdB+ht8Y
 +bezrmUxMOKxwZx4HW6wRopujzTtkzuJqW1WRnD9SDcs4i9d5V8bymSXqmlBzna+jZbC
 W6h/t0LmmAMIL0t0Tazpp+iM9EJDRD/QEnGZ/DIkHhAn0nKL1/cxhxpquy9XaQdyLjUH
 5Nhq/p1kLWp2uN7J3klqyiBPfaCJha8CDLb5p3NzsEjSj23JDhblgUffTbGRbHDs3ty6
 UhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5lA9h6er1TNE/JRaTF1NKAfHTgmAILWUVDozjnr4f8U=;
 b=ezWmbBqJhj/aNr4eECdKP+ahDau5oZS6Qj/RdUj1OTHlWBMIRbNu3svthWgRUMC+uX
 hdjWENkmfUBa0AvmX/xNKYYZDHr4pvhSvA2kJS7H5C5bDnhFMXZ0avqwmWGUJW8/uIxj
 Qu3/B+wH+//7eiP2R2Zt1eNFkCkHc65vZ34fFSnA5dU5b3jO8LMg68kd1BxTaF2UCWP8
 Ckhqq/Tzt0ykOmdPljZzVaYH8NrEX/PTlKCtsp5PUXSK2dw0xfkpcK7u8Mo+SUwIaKsg
 53oxbXo+IqBztp5vQuHseo8ZJNY3pd80fVxNmetlrKeRrYO2lErLvRobnA97zR/y7dtl
 WGnQ==
X-Gm-Message-State: AOAM5335o+DcScG6X/IwICvkkdznfUp4Myd8YWqgq+sdeMXKPSWYNmaN
 XWU4abBtE+d8Y4yqg9xYZ2gkwiinDQ/zsA==
X-Google-Smtp-Source: ABdhPJw7hmjmM4CzWuTiES7k4fpBtWN7MBHMBboWUAIQRB0blzUbOUn6jJ0kMn6uu85/AaNmtdL5uQ==
X-Received: by 2002:a17:902:c394:b029:d2:4ca:2e22 with SMTP id
 g20-20020a170902c394b02900d204ca2e22mr6316135plg.77.1600454333233; 
 Fri, 18 Sep 2020 11:38:53 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 46/81] target/arm: Implement SVE2 XAR
Date: Fri, 18 Sep 2020 11:37:16 -0700
Message-Id: <20200918183751.2787647-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In addition, use the same vector generator interface for AdvSIMD.
This fixes a bug in which the AdvSIMD insn failed to clear the
high bits of the SVE register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |   4 ++
 target/arm/helper.h        |   2 +
 target/arm/translate-a64.h |   3 ++
 target/arm/sve.decode      |   4 ++
 target/arm/sve_helper.c    |  39 ++++++++++++++
 target/arm/translate-a64.c |  25 ++-------
 target/arm/translate-sve.c | 104 +++++++++++++++++++++++++++++++++++++
 target/arm/vec_helper.c    |  12 +++++
 8 files changed, 172 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 34bbb767ef..d472fc009d 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2558,6 +2558,10 @@ DEF_HELPER_FLAGS_5(sve2_histcnt_d, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_4(sve2_histseg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2_xar_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_xar_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_xar_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/helper.h b/target/arm/helper.h
index c8eb165989..8294055cab 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -940,6 +940,8 @@ DEF_HELPER_FLAGS_5(neon_sqrdmulh_h, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(neon_sqrdmulh_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_xar_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 2e0d16da25..83729d0280 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -122,5 +122,8 @@ bool disas_sve(DisasContext *, uint32_t);
 
 void gen_gvec_rax1(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_xar(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, int64_t shift,
+                  uint32_t opr_sz, uint32_t max_sz);
 
 #endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 0edb72d4fb..a375ce31f1 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -65,6 +65,7 @@
 &rr_dbm         rd rn dbm
 &rrri           rd rn rm imm
 &rri_esz        rd rn imm esz
+&rrri_esz       rd rn rm imm esz
 &rrr_esz        rd rn rm esz
 &rpr_esz        rd pg rn esz
 &rpr_s          rd pg rn s
@@ -384,6 +385,9 @@ ORR_zzz         00000100 01 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 EOR_zzz         00000100 10 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 BIC_zzz         00000100 11 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 
+XAR             00000100 .. 1 ..... 001 101 rm:5  rd:5   &rrri_esz \
+                rn=%reg_movprfx esz=%tszimm16_esz imm=%tszimm16_shr
+
 # SVE2 bitwise ternary operations
 EOR3            00000100 00 1 ..... 001 110 ..... .....         @rdn_ra_rm_e0
 BSL             00000100 00 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fa4848bc5c..e0bd0fbe78 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7219,3 +7219,42 @@ void HELPER(sve2_histseg)(void *vd, void *vn, void *vm, uint32_t desc)
         *(uint64_t *)(vd + i + 8) = out1;
     }
 }
+
+void HELPER(sve2_xar_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    int shr = simd_data(desc);
+    int shl = 8 - shr;
+    uint64_t mask = dup_const(MO_8, 0xff >> shr);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        uint64_t t = n[i] ^ m[i];
+        d[i] = ((t >> shr) & mask) | ((t << shl) & ~mask);
+    }
+}
+
+void HELPER(sve2_xar_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    int shr = simd_data(desc);
+    int shl = 16 - shr;
+    uint64_t mask = dup_const(MO_16, 0xffff >> shr);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        uint64_t t = n[i] ^ m[i];
+        d[i] = ((t >> shr) & mask) | ((t << shl) & ~mask);
+    }
+}
+
+void HELPER(sve2_xar_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 4;
+    int shr = simd_data(desc);
+    uint32_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = ror32(n[i] ^ m[i], shr);
+    }
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7188808341..76e54c1a4e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14368,8 +14368,6 @@ static void disas_crypto_xar(DisasContext *s, uint32_t insn)
     int imm6 = extract32(insn, 10, 6);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    TCGv_i64 tcg_op1, tcg_op2, tcg_res[2];
-    int pass;
 
     if (!dc_isar_feature(aa64_sha3, s)) {
         unallocated_encoding(s);
@@ -14380,25 +14378,10 @@ static void disas_crypto_xar(DisasContext *s, uint32_t insn)
         return;
     }
 
-    tcg_op1 = tcg_temp_new_i64();
-    tcg_op2 = tcg_temp_new_i64();
-    tcg_res[0] = tcg_temp_new_i64();
-    tcg_res[1] = tcg_temp_new_i64();
-
-    for (pass = 0; pass < 2; pass++) {
-        read_vec_element(s, tcg_op1, rn, pass, MO_64);
-        read_vec_element(s, tcg_op2, rm, pass, MO_64);
-
-        tcg_gen_xor_i64(tcg_res[pass], tcg_op1, tcg_op2);
-        tcg_gen_rotri_i64(tcg_res[pass], tcg_res[pass], imm6);
-    }
-    write_vec_element(s, tcg_res[0], rd, 0, MO_64);
-    write_vec_element(s, tcg_res[1], rd, 1, MO_64);
-
-    tcg_temp_free_i64(tcg_op1);
-    tcg_temp_free_i64(tcg_op2);
-    tcg_temp_free_i64(tcg_res[0]);
-    tcg_temp_free_i64(tcg_res[1]);
+    gen_gvec_xar(MO_64, vec_full_reg_offset(s, rd),
+                 vec_full_reg_offset(s, rn),
+                 vec_full_reg_offset(s, rm), imm6, 16,
+                 vec_full_reg_size(s));
 }
 
 /* Crypto three-reg imm2
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4e792c9b9a..0d0e0c3b46 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -340,6 +340,110 @@ static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a)
     return do_zzz_fn(s, a, tcg_gen_gvec_andc);
 }
 
+static void gen_xar8_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    uint64_t mask = dup_const(MO_8, 0xff >> sh);
+
+    tcg_gen_xor_i64(t, n, m);
+    tcg_gen_shri_i64(d, t, sh);
+    tcg_gen_shli_i64(t, t, 8 - sh);
+    tcg_gen_andi_i64(d, d, mask);
+    tcg_gen_andi_i64(t, t, ~mask);
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_xar16_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, int64_t sh)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    uint64_t mask = dup_const(MO_16, 0xffff >> sh);
+
+    tcg_gen_xor_i64(t, n, m);
+    tcg_gen_shri_i64(d, t, sh);
+    tcg_gen_shli_i64(t, t, 16 - sh);
+    tcg_gen_andi_i64(d, d, mask);
+    tcg_gen_andi_i64(t, t, ~mask);
+    tcg_gen_or_i64(d, d, t);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_xar_i32(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, int32_t sh)
+{
+    tcg_gen_xor_i32(d, n, m);
+    tcg_gen_rotri_i32(d, d, sh);
+}
+
+static void gen_xar_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, int64_t sh)
+{
+    tcg_gen_xor_i64(d, n, m);
+    tcg_gen_rotri_i64(d, d, sh);
+}
+
+static void gen_xar_vec(unsigned vece, TCGv_vec d, TCGv_vec n,
+                        TCGv_vec m, int64_t sh)
+{
+    tcg_gen_xor_vec(vece, d, n, m);
+    tcg_gen_rotri_vec(vece, d, d, sh);
+}
+
+void gen_gvec_xar(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                  uint32_t rm_ofs, int64_t shift,
+                  uint32_t opr_sz, uint32_t max_sz)
+{
+    static const TCGOpcode vecop[] = { INDEX_op_rotli_vec, 0 };
+    static const GVecGen3i ops[4] = {
+        { .fni8 = gen_xar8_i64,
+          .fniv = gen_xar_vec,
+          .fno = gen_helper_sve2_xar_b,
+          .opt_opc = vecop,
+          .vece = MO_8 },
+        { .fni8 = gen_xar16_i64,
+          .fniv = gen_xar_vec,
+          .fno = gen_helper_sve2_xar_h,
+          .opt_opc = vecop,
+          .vece = MO_16 },
+        { .fni4 = gen_xar_i32,
+          .fniv = gen_xar_vec,
+          .fno = gen_helper_sve2_xar_s,
+          .opt_opc = vecop,
+          .vece = MO_32 },
+        { .fni8 = gen_xar_i64,
+          .fniv = gen_xar_vec,
+          .fno = gen_helper_gvec_xar_d,
+          .opt_opc = vecop,
+          .vece = MO_64 }
+    };
+    int esize = 8 << vece;
+
+    /* The SVE2 range is 1 .. esize; the AdvSIMD range is 0 .. esize-1. */
+    tcg_debug_assert(shift >= 0);
+    tcg_debug_assert(shift <= esize);
+    shift &= esize - 1;
+
+    if (shift == 0) {
+        /* xar with no rotate devolves to xor. */
+        tcg_gen_gvec_xor(vece, rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz);
+    } else {
+        tcg_gen_gvec_3i(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz,
+                        shift, &ops[vece]);
+    }
+}
+
+static bool trans_XAR(DisasContext *s, arg_rrri_esz *a)
+{
+    if (a->esz < 0 || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        gen_gvec_xar(a->esz, vec_full_reg_offset(s, a->rd),
+                     vec_full_reg_offset(s, a->rn),
+                     vec_full_reg_offset(s, a->rm), a->imm, vsz, vsz);
+    }
+    return true;
+}
+
 static bool do_sve2_zzzz_fn(DisasContext *s, arg_rrrr_esz *a, GVecGen4Fn *fn)
 {
     if (!dc_isar_feature(aa64_sve2, s)) {
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index ed33e1ee36..32a4403256 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -2205,3 +2205,15 @@ void HELPER(gvec_umulh_d)(void *vd, void *vn, void *vm, uint32_t desc)
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_xar_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    int shr = simd_data(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = ror64(n[i] ^ m[i], shr);
+    }
+    clear_tail(d, opr_sz * 8, simd_maxsz(desc));
+}
-- 
2.25.1


