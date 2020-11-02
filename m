Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254E6C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:17:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8AC204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACmOFEDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8AC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdSB-00014Q-Dq
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLZ-0000gT-2g
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:21 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:36205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLV-0006Oq-24
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:20 -0500
Received: by mail-wr1-x42c.google.com with SMTP id x7so15519074wrl.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=se50iPWBZuwIiT5vz8iDmMRFw8f3KT3wtFgjmCqpe7k=;
 b=ACmOFEDypReFHoWRcXyLUR3Tw4qCS6bDN5YNGqIQo+8uVkOY2vO83SU2COdnXTRulH
 ZSZcVLVw5hgGGuwPO25W4LZZa116WX/ooIJmxhrGeAZKlHZ6KMwlZckADKfMtkbmiw0s
 wQ9nlaQ5DwrpLETdsUJqV3355bf1u8JZNDwZD+WlFPM1poUpiA339qN2KMfXcHcO1Xt7
 znfM8GKXpWH2YVuj1UoKkL6/scMkN/VPa0j0kZFMzrqaWUBnsZ4fBrbD5E7hrMbGVyve
 UTG2/n32rrHg3dDeO7wzWykLw4GhL8NIaLJK3uv6sKFia7CDUjm9g7udBkgaTEMcjzup
 0zUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=se50iPWBZuwIiT5vz8iDmMRFw8f3KT3wtFgjmCqpe7k=;
 b=F7oxZFBQAVMPU8WH1RLXfI554L0pqBHjTcE+0NAlpFomag5YfcssknA9YFucxFa8Lr
 5VgCj59g8x3Hsm4I8ypFCSaJkiqc+8tGOGhE/Oh7Oz+H1bInqZ/d1sJutbrSUG9N7cqX
 VpH5fpQsaId2uVW8reKCbCFUJxS+wKcJ/wsklGHP4zZPKehnjHZuu/78pj0oEeIcjzdh
 Vyti9nKYjKhWNH98YryLzjL/Z/uWjYM4RPxgMlWlldThQt+D3TZcpkSE2d6yiIM40qG5
 isWA5EwOg6k/1/nzIKFyMtT8lv94gY0M6B3h+yO9JfQmoatGp4YJtP19U+t99/8wTpf6
 uZtg==
X-Gm-Message-State: AOAM5303aU4G8k3VRSIzbhaTXcklG5MwOgzLSAozJ0gLQipynjnA7afE
 Y7fm0bRxtfnmYyiZmjBUWuz5iPOFWYGAzw==
X-Google-Smtp-Source: ABdhPJz0lPYz55FsF/XmnH/qTJLjelhqgfsMP4Vg+I84DzXAdZugEM8emzMzsJ5jgM7y/kfqaqX83Q==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr20581299wrv.69.1604337014893; 
 Mon, 02 Nov 2020 09:10:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/26] target/arm: Add read/write_neon_element32
Date: Mon,  2 Nov 2020 17:09:44 +0000
Message-Id: <20201102171005.30690-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Model these off the aa64 read/write_vec_element functions.
Use it within translate-neon.c.inc.  The new functions do
not allocate or free temps, so this rearranges the calling
code a bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201030022618.785675-6-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c          |  26 ++++
 target/arm/translate-neon.c.inc | 256 ++++++++++++++++++++------------
 2 files changed, 183 insertions(+), 99 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 88ded4ac2c0..0ed9eab0b0d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1165,6 +1165,32 @@ static inline void neon_store_reg32(TCGv_i32 var, int reg)
     tcg_gen_st_i32(var, cpu_env, vfp_reg_offset(false, reg));
 }
 
+static void read_neon_element32(TCGv_i32 dest, int reg, int ele, MemOp size)
+{
+    long off = neon_element_offset(reg, ele, size);
+
+    switch (size) {
+    case MO_32:
+        tcg_gen_ld_i32(dest, cpu_env, off);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void write_neon_element32(TCGv_i32 src, int reg, int ele, MemOp size)
+{
+    long off = neon_element_offset(reg, ele, size);
+
+    switch (size) {
+    case MO_32:
+        tcg_gen_st_i32(src, cpu_env, off);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
 {
     TCGv_ptr ret = tcg_temp_new_ptr();
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 96ab2248fcf..549381703ea 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -956,18 +956,24 @@ static bool do_3same_pair(DisasContext *s, arg_3same *a, NeonGenTwoOpFn *fn)
      * early. Since Q is 0 there are always just two passes, so instead
      * of a complicated loop over each pass we just unroll.
      */
-    tmp = neon_load_reg(a->vn, 0);
-    tmp2 = neon_load_reg(a->vn, 1);
+    tmp = tcg_temp_new_i32();
+    tmp2 = tcg_temp_new_i32();
+    tmp3 = tcg_temp_new_i32();
+
+    read_neon_element32(tmp, a->vn, 0, MO_32);
+    read_neon_element32(tmp2, a->vn, 1, MO_32);
     fn(tmp, tmp, tmp2);
-    tcg_temp_free_i32(tmp2);
 
-    tmp3 = neon_load_reg(a->vm, 0);
-    tmp2 = neon_load_reg(a->vm, 1);
+    read_neon_element32(tmp3, a->vm, 0, MO_32);
+    read_neon_element32(tmp2, a->vm, 1, MO_32);
     fn(tmp3, tmp3, tmp2);
-    tcg_temp_free_i32(tmp2);
 
-    neon_store_reg(a->vd, 0, tmp);
-    neon_store_reg(a->vd, 1, tmp3);
+    write_neon_element32(tmp, a->vd, 0, MO_32);
+    write_neon_element32(tmp3, a->vd, 1, MO_32);
+
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(tmp2);
+    tcg_temp_free_i32(tmp3);
     return true;
 }
 
@@ -1275,7 +1281,7 @@ static bool do_2shift_env_32(DisasContext *s, arg_2reg_shift *a,
      * 2-reg-and-shift operations, size < 3 case, where the
      * helper needs to be passed cpu_env.
      */
-    TCGv_i32 constimm;
+    TCGv_i32 constimm, tmp;
     int pass;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
@@ -1301,12 +1307,14 @@ static bool do_2shift_env_32(DisasContext *s, arg_2reg_shift *a,
      * by immediate using the variable shift operations.
      */
     constimm = tcg_const_i32(dup_const(a->size, a->shift));
+    tmp = tcg_temp_new_i32();
 
     for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
-        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
+        read_neon_element32(tmp, a->vm, pass, MO_32);
         fn(tmp, cpu_env, tmp, constimm);
-        neon_store_reg(a->vd, pass, tmp);
+        write_neon_element32(tmp, a->vd, pass, MO_32);
     }
+    tcg_temp_free_i32(tmp);
     tcg_temp_free_i32(constimm);
     return true;
 }
@@ -1364,21 +1372,21 @@ static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
     constimm = tcg_const_i64(-a->shift);
     rm1 = tcg_temp_new_i64();
     rm2 = tcg_temp_new_i64();
+    rd = tcg_temp_new_i32();
 
     /* Load both inputs first to avoid potential overwrite if rm == rd */
     neon_load_reg64(rm1, a->vm);
     neon_load_reg64(rm2, a->vm + 1);
 
     shiftfn(rm1, rm1, constimm);
-    rd = tcg_temp_new_i32();
     narrowfn(rd, cpu_env, rm1);
-    neon_store_reg(a->vd, 0, rd);
+    write_neon_element32(rd, a->vd, 0, MO_32);
 
     shiftfn(rm2, rm2, constimm);
-    rd = tcg_temp_new_i32();
     narrowfn(rd, cpu_env, rm2);
-    neon_store_reg(a->vd, 1, rd);
+    write_neon_element32(rd, a->vd, 1, MO_32);
 
+    tcg_temp_free_i32(rd);
     tcg_temp_free_i64(rm1);
     tcg_temp_free_i64(rm2);
     tcg_temp_free_i64(constimm);
@@ -1428,10 +1436,14 @@ static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
     constimm = tcg_const_i32(imm);
 
     /* Load all inputs first to avoid potential overwrite */
-    rm1 = neon_load_reg(a->vm, 0);
-    rm2 = neon_load_reg(a->vm, 1);
-    rm3 = neon_load_reg(a->vm + 1, 0);
-    rm4 = neon_load_reg(a->vm + 1, 1);
+    rm1 = tcg_temp_new_i32();
+    rm2 = tcg_temp_new_i32();
+    rm3 = tcg_temp_new_i32();
+    rm4 = tcg_temp_new_i32();
+    read_neon_element32(rm1, a->vm, 0, MO_32);
+    read_neon_element32(rm2, a->vm, 1, MO_32);
+    read_neon_element32(rm3, a->vm, 2, MO_32);
+    read_neon_element32(rm4, a->vm, 3, MO_32);
     rtmp = tcg_temp_new_i64();
 
     shiftfn(rm1, rm1, constimm);
@@ -1441,7 +1453,8 @@ static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
     tcg_temp_free_i32(rm2);
 
     narrowfn(rm1, cpu_env, rtmp);
-    neon_store_reg(a->vd, 0, rm1);
+    write_neon_element32(rm1, a->vd, 0, MO_32);
+    tcg_temp_free_i32(rm1);
 
     shiftfn(rm3, rm3, constimm);
     shiftfn(rm4, rm4, constimm);
@@ -1452,7 +1465,8 @@ static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
 
     narrowfn(rm3, cpu_env, rtmp);
     tcg_temp_free_i64(rtmp);
-    neon_store_reg(a->vd, 1, rm3);
+    write_neon_element32(rm3, a->vd, 1, MO_32);
+    tcg_temp_free_i32(rm3);
     return true;
 }
 
@@ -1553,8 +1567,10 @@ static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
         widen_mask = dup_const(a->size + 1, widen_mask);
     }
 
-    rm0 = neon_load_reg(a->vm, 0);
-    rm1 = neon_load_reg(a->vm, 1);
+    rm0 = tcg_temp_new_i32();
+    rm1 = tcg_temp_new_i32();
+    read_neon_element32(rm0, a->vm, 0, MO_32);
+    read_neon_element32(rm1, a->vm, 1, MO_32);
     tmp = tcg_temp_new_i64();
 
     widenfn(tmp, rm0);
@@ -1808,11 +1824,13 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
     if (src1_wide) {
         neon_load_reg64(rn0_64, a->vn);
     } else {
-        TCGv_i32 tmp = neon_load_reg(a->vn, 0);
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        read_neon_element32(tmp, a->vn, 0, MO_32);
         widenfn(rn0_64, tmp);
         tcg_temp_free_i32(tmp);
     }
-    rm = neon_load_reg(a->vm, 0);
+    rm = tcg_temp_new_i32();
+    read_neon_element32(rm, a->vm, 0, MO_32);
 
     widenfn(rm_64, rm);
     tcg_temp_free_i32(rm);
@@ -1825,11 +1843,13 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
     if (src1_wide) {
         neon_load_reg64(rn1_64, a->vn + 1);
     } else {
-        TCGv_i32 tmp = neon_load_reg(a->vn, 1);
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        read_neon_element32(tmp, a->vn, 1, MO_32);
         widenfn(rn1_64, tmp);
         tcg_temp_free_i32(tmp);
     }
-    rm = neon_load_reg(a->vm, 1);
+    rm = tcg_temp_new_i32();
+    read_neon_element32(rm, a->vm, 1, MO_32);
 
     neon_store_reg64(rn0_64, a->vd);
 
@@ -1922,9 +1942,11 @@ static bool do_narrow_3d(DisasContext *s, arg_3diff *a,
 
     narrowfn(rd1, rn_64);
 
-    neon_store_reg(a->vd, 0, rd0);
-    neon_store_reg(a->vd, 1, rd1);
+    write_neon_element32(rd0, a->vd, 0, MO_32);
+    write_neon_element32(rd1, a->vd, 1, MO_32);
 
+    tcg_temp_free_i32(rd0);
+    tcg_temp_free_i32(rd1);
     tcg_temp_free_i64(rn_64);
     tcg_temp_free_i64(rm_64);
 
@@ -1999,14 +2021,14 @@ static bool do_long_3d(DisasContext *s, arg_3diff *a,
     rd0 = tcg_temp_new_i64();
     rd1 = tcg_temp_new_i64();
 
-    rn = neon_load_reg(a->vn, 0);
-    rm = neon_load_reg(a->vm, 0);
+    rn = tcg_temp_new_i32();
+    rm = tcg_temp_new_i32();
+    read_neon_element32(rn, a->vn, 0, MO_32);
+    read_neon_element32(rm, a->vm, 0, MO_32);
     opfn(rd0, rn, rm);
-    tcg_temp_free_i32(rn);
-    tcg_temp_free_i32(rm);
 
-    rn = neon_load_reg(a->vn, 1);
-    rm = neon_load_reg(a->vm, 1);
+    read_neon_element32(rn, a->vn, 1, MO_32);
+    read_neon_element32(rm, a->vm, 1, MO_32);
     opfn(rd1, rn, rm);
     tcg_temp_free_i32(rn);
     tcg_temp_free_i32(rm);
@@ -2308,16 +2330,16 @@ static void gen_neon_dup_high16(TCGv_i32 var)
 
 static inline TCGv_i32 neon_get_scalar(int size, int reg)
 {
-    TCGv_i32 tmp;
-    if (size == 1) {
-        tmp = neon_load_reg(reg & 7, reg >> 4);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    if (size == MO_16) {
+        read_neon_element32(tmp, reg & 7, reg >> 4, MO_32);
         if (reg & 8) {
             gen_neon_dup_high16(tmp);
         } else {
             gen_neon_dup_low16(tmp);
         }
     } else {
-        tmp = neon_load_reg(reg & 15, reg >> 4);
+        read_neon_element32(tmp, reg & 15, reg >> 4, MO_32);
     }
     return tmp;
 }
@@ -2331,7 +2353,7 @@ static bool do_2scalar(DisasContext *s, arg_2scalar *a,
      * perform an accumulation operation of that result into the
      * destination.
      */
-    TCGv_i32 scalar;
+    TCGv_i32 scalar, tmp;
     int pass;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
@@ -2358,17 +2380,20 @@ static bool do_2scalar(DisasContext *s, arg_2scalar *a,
     }
 
     scalar = neon_get_scalar(a->size, a->vm);
+    tmp = tcg_temp_new_i32();
 
     for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
-        TCGv_i32 tmp = neon_load_reg(a->vn, pass);
+        read_neon_element32(tmp, a->vn, pass, MO_32);
         opfn(tmp, tmp, scalar);
         if (accfn) {
-            TCGv_i32 rd = neon_load_reg(a->vd, pass);
+            TCGv_i32 rd = tcg_temp_new_i32();
+            read_neon_element32(rd, a->vd, pass, MO_32);
             accfn(tmp, rd, tmp);
             tcg_temp_free_i32(rd);
         }
-        neon_store_reg(a->vd, pass, tmp);
+        write_neon_element32(tmp, a->vd, pass, MO_32);
     }
+    tcg_temp_free_i32(tmp);
     tcg_temp_free_i32(scalar);
     return true;
 }
@@ -2523,7 +2548,7 @@ static bool do_vqrdmlah_2sc(DisasContext *s, arg_2scalar *a,
      * performs a kind of fused op-then-accumulate using a helper
      * function that takes all of rd, rn and the scalar at once.
      */
-    TCGv_i32 scalar;
+    TCGv_i32 scalar, rn, rd;
     int pass;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
@@ -2554,14 +2579,17 @@ static bool do_vqrdmlah_2sc(DisasContext *s, arg_2scalar *a,
     }
 
     scalar = neon_get_scalar(a->size, a->vm);
+    rn = tcg_temp_new_i32();
+    rd = tcg_temp_new_i32();
 
     for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
-        TCGv_i32 rn = neon_load_reg(a->vn, pass);
-        TCGv_i32 rd = neon_load_reg(a->vd, pass);
+        read_neon_element32(rn, a->vn, pass, MO_32);
+        read_neon_element32(rd, a->vd, pass, MO_32);
         opfn(rd, cpu_env, rn, scalar, rd);
-        tcg_temp_free_i32(rn);
-        neon_store_reg(a->vd, pass, rd);
+        write_neon_element32(rd, a->vd, pass, MO_32);
     }
+    tcg_temp_free_i32(rn);
+    tcg_temp_free_i32(rd);
     tcg_temp_free_i32(scalar);
 
     return true;
@@ -2628,12 +2656,12 @@ static bool do_2scalar_long(DisasContext *s, arg_2scalar *a,
     scalar = neon_get_scalar(a->size, a->vm);
 
     /* Load all inputs before writing any outputs, in case of overlap */
-    rn = neon_load_reg(a->vn, 0);
+    rn = tcg_temp_new_i32();
+    read_neon_element32(rn, a->vn, 0, MO_32);
     rn0_64 = tcg_temp_new_i64();
     opfn(rn0_64, rn, scalar);
-    tcg_temp_free_i32(rn);
 
-    rn = neon_load_reg(a->vn, 1);
+    read_neon_element32(rn, a->vn, 1, MO_32);
     rn1_64 = tcg_temp_new_i64();
     opfn(rn1_64, rn, scalar);
     tcg_temp_free_i32(rn);
@@ -2857,30 +2885,34 @@ static bool trans_VTBL(DisasContext *s, arg_VTBL *a)
         return false;
     }
     n <<= 3;
+    tmp = tcg_temp_new_i32();
     if (a->op) {
-        tmp = neon_load_reg(a->vd, 0);
+        read_neon_element32(tmp, a->vd, 0, MO_32);
     } else {
-        tmp = tcg_temp_new_i32();
         tcg_gen_movi_i32(tmp, 0);
     }
-    tmp2 = neon_load_reg(a->vm, 0);
+    tmp2 = tcg_temp_new_i32();
+    read_neon_element32(tmp2, a->vm, 0, MO_32);
     ptr1 = vfp_reg_ptr(true, a->vn);
     tmp4 = tcg_const_i32(n);
     gen_helper_neon_tbl(tmp2, tmp2, tmp, ptr1, tmp4);
-    tcg_temp_free_i32(tmp);
+
     if (a->op) {
-        tmp = neon_load_reg(a->vd, 1);
+        read_neon_element32(tmp, a->vd, 1, MO_32);
     } else {
-        tmp = tcg_temp_new_i32();
         tcg_gen_movi_i32(tmp, 0);
     }
-    tmp3 = neon_load_reg(a->vm, 1);
+    tmp3 = tcg_temp_new_i32();
+    read_neon_element32(tmp3, a->vm, 1, MO_32);
     gen_helper_neon_tbl(tmp3, tmp3, tmp, ptr1, tmp4);
+    tcg_temp_free_i32(tmp);
     tcg_temp_free_i32(tmp4);
     tcg_temp_free_ptr(ptr1);
-    neon_store_reg(a->vd, 0, tmp2);
-    neon_store_reg(a->vd, 1, tmp3);
-    tcg_temp_free_i32(tmp);
+
+    write_neon_element32(tmp2, a->vd, 0, MO_32);
+    write_neon_element32(tmp3, a->vd, 1, MO_32);
+    tcg_temp_free_i32(tmp2);
+    tcg_temp_free_i32(tmp3);
     return true;
 }
 
@@ -2913,6 +2945,7 @@ static bool trans_VDUP_scalar(DisasContext *s, arg_VDUP_scalar *a)
 static bool trans_VREV64(DisasContext *s, arg_VREV64 *a)
 {
     int pass, half;
+    TCGv_i32 tmp[2];
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -2936,11 +2969,12 @@ static bool trans_VREV64(DisasContext *s, arg_VREV64 *a)
         return true;
     }
 
-    for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
-        TCGv_i32 tmp[2];
+    tmp[0] = tcg_temp_new_i32();
+    tmp[1] = tcg_temp_new_i32();
 
+    for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
         for (half = 0; half < 2; half++) {
-            tmp[half] = neon_load_reg(a->vm, pass * 2 + half);
+            read_neon_element32(tmp[half], a->vm, pass * 2 + half, MO_32);
             switch (a->size) {
             case 0:
                 tcg_gen_bswap32_i32(tmp[half], tmp[half]);
@@ -2954,9 +2988,12 @@ static bool trans_VREV64(DisasContext *s, arg_VREV64 *a)
                 g_assert_not_reached();
             }
         }
-        neon_store_reg(a->vd, pass * 2, tmp[1]);
-        neon_store_reg(a->vd, pass * 2 + 1, tmp[0]);
+        write_neon_element32(tmp[1], a->vd, pass * 2, MO_32);
+        write_neon_element32(tmp[0], a->vd, pass * 2 + 1, MO_32);
     }
+
+    tcg_temp_free_i32(tmp[0]);
+    tcg_temp_free_i32(tmp[1]);
     return true;
 }
 
@@ -3001,12 +3038,14 @@ static bool do_2misc_pairwise(DisasContext *s, arg_2misc *a,
         rm0_64 = tcg_temp_new_i64();
         rm1_64 = tcg_temp_new_i64();
         rd_64 = tcg_temp_new_i64();
-        tmp = neon_load_reg(a->vm, pass * 2);
+
+        tmp = tcg_temp_new_i32();
+        read_neon_element32(tmp, a->vm, pass * 2, MO_32);
         widenfn(rm0_64, tmp);
-        tcg_temp_free_i32(tmp);
-        tmp = neon_load_reg(a->vm, pass * 2 + 1);
+        read_neon_element32(tmp, a->vm, pass * 2 + 1, MO_32);
         widenfn(rm1_64, tmp);
         tcg_temp_free_i32(tmp);
+
         opfn(rd_64, rm0_64, rm1_64);
         tcg_temp_free_i64(rm0_64);
         tcg_temp_free_i64(rm1_64);
@@ -3219,8 +3258,10 @@ static bool do_vmovn(DisasContext *s, arg_2misc *a,
     narrowfn(rd0, cpu_env, rm);
     neon_load_reg64(rm, a->vm + 1);
     narrowfn(rd1, cpu_env, rm);
-    neon_store_reg(a->vd, 0, rd0);
-    neon_store_reg(a->vd, 1, rd1);
+    write_neon_element32(rd0, a->vd, 0, MO_32);
+    write_neon_element32(rd1, a->vd, 1, MO_32);
+    tcg_temp_free_i32(rd0);
+    tcg_temp_free_i32(rd1);
     tcg_temp_free_i64(rm);
     return true;
 }
@@ -3277,9 +3318,11 @@ static bool trans_VSHLL(DisasContext *s, arg_2misc *a)
     }
 
     rd = tcg_temp_new_i64();
+    rm0 = tcg_temp_new_i32();
+    rm1 = tcg_temp_new_i32();
 
-    rm0 = neon_load_reg(a->vm, 0);
-    rm1 = neon_load_reg(a->vm, 1);
+    read_neon_element32(rm0, a->vm, 0, MO_32);
+    read_neon_element32(rm1, a->vm, 1, MO_32);
 
     widenfn(rd, rm0);
     tcg_gen_shli_i64(rd, rd, 8 << a->size);
@@ -3320,21 +3363,25 @@ static bool trans_VCVT_F16_F32(DisasContext *s, arg_2misc *a)
 
     fpst = fpstatus_ptr(FPST_STD);
     ahp = get_ahp_flag();
-    tmp = neon_load_reg(a->vm, 0);
+    tmp = tcg_temp_new_i32();
+    read_neon_element32(tmp, a->vm, 0, MO_32);
     gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
-    tmp2 = neon_load_reg(a->vm, 1);
+    tmp2 = tcg_temp_new_i32();
+    read_neon_element32(tmp2, a->vm, 1, MO_32);
     gen_helper_vfp_fcvt_f32_to_f16(tmp2, tmp2, fpst, ahp);
     tcg_gen_shli_i32(tmp2, tmp2, 16);
     tcg_gen_or_i32(tmp2, tmp2, tmp);
-    tcg_temp_free_i32(tmp);
-    tmp = neon_load_reg(a->vm, 2);
+    read_neon_element32(tmp, a->vm, 2, MO_32);
     gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
-    tmp3 = neon_load_reg(a->vm, 3);
-    neon_store_reg(a->vd, 0, tmp2);
+    tmp3 = tcg_temp_new_i32();
+    read_neon_element32(tmp3, a->vm, 3, MO_32);
+    write_neon_element32(tmp2, a->vd, 0, MO_32);
+    tcg_temp_free_i32(tmp2);
     gen_helper_vfp_fcvt_f32_to_f16(tmp3, tmp3, fpst, ahp);
     tcg_gen_shli_i32(tmp3, tmp3, 16);
     tcg_gen_or_i32(tmp3, tmp3, tmp);
-    neon_store_reg(a->vd, 1, tmp3);
+    write_neon_element32(tmp3, a->vd, 1, MO_32);
+    tcg_temp_free_i32(tmp3);
     tcg_temp_free_i32(tmp);
     tcg_temp_free_i32(ahp);
     tcg_temp_free_ptr(fpst);
@@ -3369,21 +3416,25 @@ static bool trans_VCVT_F32_F16(DisasContext *s, arg_2misc *a)
     fpst = fpstatus_ptr(FPST_STD);
     ahp = get_ahp_flag();
     tmp3 = tcg_temp_new_i32();
-    tmp = neon_load_reg(a->vm, 0);
-    tmp2 = neon_load_reg(a->vm, 1);
+    tmp2 = tcg_temp_new_i32();
+    tmp = tcg_temp_new_i32();
+    read_neon_element32(tmp, a->vm, 0, MO_32);
+    read_neon_element32(tmp2, a->vm, 1, MO_32);
     tcg_gen_ext16u_i32(tmp3, tmp);
     gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
-    neon_store_reg(a->vd, 0, tmp3);
+    write_neon_element32(tmp3, a->vd, 0, MO_32);
     tcg_gen_shri_i32(tmp, tmp, 16);
     gen_helper_vfp_fcvt_f16_to_f32(tmp, tmp, fpst, ahp);
-    neon_store_reg(a->vd, 1, tmp);
-    tmp3 = tcg_temp_new_i32();
+    write_neon_element32(tmp, a->vd, 1, MO_32);
+    tcg_temp_free_i32(tmp);
     tcg_gen_ext16u_i32(tmp3, tmp2);
     gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
-    neon_store_reg(a->vd, 2, tmp3);
+    write_neon_element32(tmp3, a->vd, 2, MO_32);
+    tcg_temp_free_i32(tmp3);
     tcg_gen_shri_i32(tmp2, tmp2, 16);
     gen_helper_vfp_fcvt_f16_to_f32(tmp2, tmp2, fpst, ahp);
-    neon_store_reg(a->vd, 3, tmp2);
+    write_neon_element32(tmp2, a->vd, 3, MO_32);
+    tcg_temp_free_i32(tmp2);
     tcg_temp_free_i32(ahp);
     tcg_temp_free_ptr(fpst);
 
@@ -3489,6 +3540,7 @@ DO_2M_CRYPTO(SHA256SU0, aa32_sha2, 2)
 
 static bool do_2misc(DisasContext *s, arg_2misc *a, NeonGenOneOpFn *fn)
 {
+    TCGv_i32 tmp;
     int pass;
 
     /* Handle a 2-reg-misc operation by iterating 32 bits at a time */
@@ -3514,11 +3566,13 @@ static bool do_2misc(DisasContext *s, arg_2misc *a, NeonGenOneOpFn *fn)
         return true;
     }
 
+    tmp = tcg_temp_new_i32();
     for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
-        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
+        read_neon_element32(tmp, a->vm, pass, MO_32);
         fn(tmp, tmp);
-        neon_store_reg(a->vd, pass, tmp);
+        write_neon_element32(tmp, a->vd, pass, MO_32);
     }
+    tcg_temp_free_i32(tmp);
 
     return true;
 }
@@ -3871,25 +3925,29 @@ static bool trans_VTRN(DisasContext *s, arg_2misc *a)
         return true;
     }
 
-    if (a->size == 2) {
+    tmp = tcg_temp_new_i32();
+    tmp2 = tcg_temp_new_i32();
+    if (a->size == MO_32) {
         for (pass = 0; pass < (a->q ? 4 : 2); pass += 2) {
-            tmp = neon_load_reg(a->vm, pass);
-            tmp2 = neon_load_reg(a->vd, pass + 1);
-            neon_store_reg(a->vm, pass, tmp2);
-            neon_store_reg(a->vd, pass + 1, tmp);
+            read_neon_element32(tmp, a->vm, pass, MO_32);
+            read_neon_element32(tmp2, a->vd, pass + 1, MO_32);
+            write_neon_element32(tmp2, a->vm, pass, MO_32);
+            write_neon_element32(tmp, a->vd, pass + 1, MO_32);
         }
     } else {
         for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
-            tmp = neon_load_reg(a->vm, pass);
-            tmp2 = neon_load_reg(a->vd, pass);
-            if (a->size == 0) {
+            read_neon_element32(tmp, a->vm, pass, MO_32);
+            read_neon_element32(tmp2, a->vd, pass, MO_32);
+            if (a->size == MO_8) {
                 gen_neon_trn_u8(tmp, tmp2);
             } else {
                 gen_neon_trn_u16(tmp, tmp2);
             }
-            neon_store_reg(a->vm, pass, tmp2);
-            neon_store_reg(a->vd, pass, tmp);
+            write_neon_element32(tmp2, a->vm, pass, MO_32);
+            write_neon_element32(tmp, a->vd, pass, MO_32);
         }
     }
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(tmp2);
     return true;
 }
-- 
2.20.1


