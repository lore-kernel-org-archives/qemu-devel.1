Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966A2C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622A8215A4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXJu9jxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622A8215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8HT-0002Yz-Hs
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83V-0007go-W1
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:38425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83T-0006B2-0I
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id g4so1494420wrs.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qVZKGDuV7weq1Ktip41I9hvIFb2ezHDdQUs1dhfhQkc=;
 b=wXJu9jxqdOQaZ/K2jzhVjpAK7tNoHZbVw1+QWto1oqlbs7/HUhMxkPWwbVaKNC8HsK
 gfS0mkOq+LeBzwBJgauC2FR6PlhDJmIyJhSuHF1Qs06GsgTHHCxZCqUMgkE30SD72EYe
 9h/OoYcpAky9BCKxY75lspNnNsJ7vQmAHbt+t2qRNOL1SUW+Z9kEcRwuRCBCqJnFWDe4
 TkwjVlGdUNCGHs3mzCPTq96JAcfgtQ/AjryljZEOQ0xHxavJ8xHclTzt1LOLVYFSpZwG
 IQx3BulGkPbTxUc9D8uUfXqvUZxS/O4+PzM5R52en2ZMjJNNsRq5Jm5gh9pTs82Pfp2X
 OG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qVZKGDuV7weq1Ktip41I9hvIFb2ezHDdQUs1dhfhQkc=;
 b=Z+wnhChbXkzcb9UtpDM+cIAH3fzXaoG3KtykjBJFkKAZICvx9jwLVZGi9q2SMvI5G1
 hX53WYlfhS4GUQ2H/gJxJA2LFheaHqLxliP7FX4RQxVkcnLN795wjDYFre90+5N1602U
 d9M9RB7cK8wrstnUISEjHmHYyWsWhlQij96heat1W/e4d0ZYx9VQL3S6r0Wc+/459jXZ
 l49zIrDnFZAqPjiTlL9E1WkU0bbzGXwXHfxjC29hbx5b3Ggk3uJUVOGlQKd7fsUCGH5n
 lZ7rvnGp56tldaVKTLxgoYEm6Y80fxCaESXTXNArc2078bXblW9bmom6mTu8sM9trOnZ
 a8AQ==
X-Gm-Message-State: AOAM532ZYgvuid9xEH6pG1qOMClBkuAVjuzM3smlEa7p8rRWTVN0AEEb
 D8jSXXLxnYZqT9YCY13lJw3sOWj5syhipIGS
X-Google-Smtp-Source: ABdhPJzWASdlVAoaU+fnQ+UHSpmLsUt8sDNkvxAgKZEDuSDdoxc+TvcUtWAUNYEfbAZFydWgTzwFQg==
X-Received: by 2002:a5d:4bcf:: with SMTP id l15mr2424509wrt.384.1598973517180; 
 Tue, 01 Sep 2020 08:18:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/47] target/arm: Implement VFP fp16 for VABS, VNEG, VSQRT
Date: Tue,  1 Sep 2020 16:17:44 +0100
Message-Id: <20200901151823.29785-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Implement VFP fp16 for VABS, VNEG and VSQRT. This is all
the fp16 insns that use the DO_VFP_2OP macro, because there
is no fp16 version of VMOV_reg.

Notes:
 * the gen_helper_vfp_negh already exists as we needed to create
   it for the fp16 multiply-add insns
 * as usual we need to use the f16 version of the fp_status;
   this is only relevant for VSQRT

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-9-peter.maydell@linaro.org
---
 target/arm/helper.h            |  2 ++
 target/arm/vfp.decode          |  3 +++
 target/arm/vfp_helper.c        | 10 +++++++++
 target/arm/translate-vfp.c.inc | 40 ++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 538b1a20ce5..37739b0e788 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -128,8 +128,10 @@ DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
 DEF_HELPER_1(vfp_negh, f16, f16)
 DEF_HELPER_1(vfp_negs, f32, f32)
 DEF_HELPER_1(vfp_negd, f64, f64)
+DEF_HELPER_1(vfp_absh, f16, f16)
 DEF_HELPER_1(vfp_abss, f32, f32)
 DEF_HELPER_1(vfp_absd, f64, f64)
+DEF_HELPER_2(vfp_sqrth, f16, f16, env)
 DEF_HELPER_2(vfp_sqrts, f32, f32, env)
 DEF_HELPER_2(vfp_sqrtd, f64, f64, env)
 DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index af4829e201b..5c64701dde0 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -162,12 +162,15 @@ VMOV_imm_dp  ---- 1110 1.11 .... .... 1011 0000 .... \
 VMOV_reg_sp  ---- 1110 1.11 0000 .... 1010 01.0 ....        @vfp_dm_ss
 VMOV_reg_dp  ---- 1110 1.11 0000 .... 1011 01.0 ....        @vfp_dm_dd
 
+VABS_hp      ---- 1110 1.11 0000 .... 1001 11.0 ....        @vfp_dm_ss
 VABS_sp      ---- 1110 1.11 0000 .... 1010 11.0 ....        @vfp_dm_ss
 VABS_dp      ---- 1110 1.11 0000 .... 1011 11.0 ....        @vfp_dm_dd
 
+VNEG_hp      ---- 1110 1.11 0001 .... 1001 01.0 ....        @vfp_dm_ss
 VNEG_sp      ---- 1110 1.11 0001 .... 1010 01.0 ....        @vfp_dm_ss
 VNEG_dp      ---- 1110 1.11 0001 .... 1011 01.0 ....        @vfp_dm_dd
 
+VSQRT_hp     ---- 1110 1.11 0001 .... 1001 11.0 ....        @vfp_dm_ss
 VSQRT_sp     ---- 1110 1.11 0001 .... 1010 11.0 ....        @vfp_dm_ss
 VSQRT_dp     ---- 1110 1.11 0001 .... 1011 11.0 ....        @vfp_dm_dd
 
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 579ca3832d1..cc7fb6ddb6a 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -276,6 +276,11 @@ float64 VFP_HELPER(neg, d)(float64 a)
     return float64_chs(a);
 }
 
+dh_ctype_f16 VFP_HELPER(abs, h)(dh_ctype_f16 a)
+{
+    return float16_abs(a);
+}
+
 float32 VFP_HELPER(abs, s)(float32 a)
 {
     return float32_abs(a);
@@ -286,6 +291,11 @@ float64 VFP_HELPER(abs, d)(float64 a)
     return float64_abs(a);
 }
 
+dh_ctype_f16 VFP_HELPER(sqrt, h)(dh_ctype_f16 a, CPUARMState *env)
+{
+    return float16_sqrt(a, &env->vfp.fp_status_f16);
+}
+
 float32 VFP_HELPER(sqrt, s)(float32 a, CPUARMState *env)
 {
     return float32_sqrt(a, &env->vfp.fp_status);
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index f891d860bb9..99b722b75bd 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -1469,6 +1469,38 @@ static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
     return true;
 }
 
+static bool do_vfp_2op_hp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
+{
+    /*
+     * Do a half-precision operation. Functionally this is
+     * the same as do_vfp_2op_sp(), except:
+     *  - it doesn't need the VFP vector handling (fp16 is a
+     *    v8 feature, and in v8 VFP vectors don't exist)
+     *  - it does the aa32_fp16_arith feature test
+     */
+    TCGv_i32 f0;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (s->vec_len != 0 || s->vec_stride != 0) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    f0 = tcg_temp_new_i32();
+    neon_load_reg32(f0, vm);
+    fn(f0, f0);
+    neon_store_reg32(f0, vd);
+    tcg_temp_free_i32(f0);
+
+    return true;
+}
+
 static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
 {
     uint32_t delta_m = 0;
@@ -2244,12 +2276,19 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 DO_VFP_2OP(VMOV_reg, sp, tcg_gen_mov_i32)
 DO_VFP_2OP(VMOV_reg, dp, tcg_gen_mov_i64)
 
+DO_VFP_2OP(VABS, hp, gen_helper_vfp_absh)
 DO_VFP_2OP(VABS, sp, gen_helper_vfp_abss)
 DO_VFP_2OP(VABS, dp, gen_helper_vfp_absd)
 
+DO_VFP_2OP(VNEG, hp, gen_helper_vfp_negh)
 DO_VFP_2OP(VNEG, sp, gen_helper_vfp_negs)
 DO_VFP_2OP(VNEG, dp, gen_helper_vfp_negd)
 
+static void gen_VSQRT_hp(TCGv_i32 vd, TCGv_i32 vm)
+{
+    gen_helper_vfp_sqrth(vd, vm, cpu_env);
+}
+
 static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
 {
     gen_helper_vfp_sqrts(vd, vm, cpu_env);
@@ -2260,6 +2299,7 @@ static void gen_VSQRT_dp(TCGv_i64 vd, TCGv_i64 vm)
     gen_helper_vfp_sqrtd(vd, vm, cpu_env);
 }
 
+DO_VFP_2OP(VSQRT, hp, gen_VSQRT_hp)
 DO_VFP_2OP(VSQRT, sp, gen_VSQRT_sp)
 DO_VFP_2OP(VSQRT, dp, gen_VSQRT_dp)
 
-- 
2.20.1


