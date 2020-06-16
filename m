Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0159C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FB920B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7NtDCKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FB920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlF7Y-0006yO-TP
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF4z-00018D-KM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF4x-0007Ry-41
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so21532175wrr.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v6P61HLrEGFwATqpE9ZgpSDARdlQ3liQ+Dl/YATMb3A=;
 b=B7NtDCKXz7UDIf765cw1aRFTpUM7F2Do82M1zuHF85oNF8rlerS3LBu1sr9TTY8PXu
 99kc3cycko6R0EPcWYre+5z4XcwNrIb5/z4nA1b+2k7mukV/kNtxuV6yA1+0Gwa1Dq6a
 tS/GEfO3u9b4sr4SDiU8C7R5llY0hwTcQGclwVjnGa+iAImrbk5ctX5eszQHgknay9UO
 +/jnv7RUQjOfxYDKRskaBmhBAIKrxVShqYii0puJgrFEax9uXgHzzn6iqGRXigZXWlLn
 1UOv8iRdgyxoxORHHncf7MInpONn6OtfR2CEpNuOLq75Y+0+VePcDieaBoCKlc2kUkFw
 TYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v6P61HLrEGFwATqpE9ZgpSDARdlQ3liQ+Dl/YATMb3A=;
 b=GX9E4iDi3SYQEy6qwfQh9WpdxvrCNiufdEneT1d97WJoISsoky7khRJ8h6pV2X2rjO
 xu/9wnRDo11DTgr+fy7nwWKOfgTcf/kT2Hk4v/NDIOZ1Y1Z+7EThcQA8gMd2l6il/eWl
 N/FOUbUWwDLr2cSeZQsvo/+jSz3lZ66DO92djCoImpEQj3513EVpd2vd4d3yNRSVj6uM
 CGeTYFh25e85JqbR9MOHU+kz4aWn3OvK3GEAWBRsYpvkMS0L3Le8W9smZ/uD8md/FRLk
 /8E2VXZFtSS8F4XXAj+ibsmrhnlQ9GIJPekQxc/NIjSliPIwXfleIYjAbEVdyGp9gxc8
 K8ng==
X-Gm-Message-State: AOAM531d9ugcY+wk/PYh/SP8lb6np29OcnhYnscEdw5IRjd49RQ9wLXX
 2K5IwfhWaF9/znlDR4TeOZh4uA==
X-Google-Smtp-Source: ABdhPJxs0iGnHhHT4iYFZ+qDp7WzpuGZRKOZ4u+g0GHLwzAWA9aBvaSTxTspQPSpAOv2lsyMzCRPpw==
X-Received: by 2002:a5d:500c:: with SMTP id e12mr4101929wrt.359.1592327333725; 
 Tue, 16 Jun 2020 10:08:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:08:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/21] target/arm: Convert Neon narrowing moves to decodetree
Date: Tue, 16 Jun 2020 18:08:27 +0100
Message-Id: <20200616170844.13318-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon narrowing moves VMQNV, VQMOVN, VQMOVUN in the 2-reg-misc
group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  9 ++++
 target/arm/translate-neon.inc.c | 59 ++++++++++++++++++++++++
 target/arm/translate.c          | 81 +--------------------------------
 3 files changed, 70 insertions(+), 79 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index ad9e17fd737..2277b4c7b51 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -439,6 +439,8 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     @2misc       .... ... .. . .. size:2 .. .... . .... q:1 . . .... \
                  &2misc vm=%vm_dp vd=%vd_dp
+    @2misc_q0    .... ... .. . .. size:2 .. .... . .... . . . .... \
+                 &2misc vm=%vm_dp vd=%vd_dp q=0
 
     VREV64       1111 001 11 . 11 .. 00 .... 0 0000 . . 0 .... @2misc
 
@@ -450,6 +452,13 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     VUZP         1111 001 11 . 11 .. 10 .... 0 0010 . . 0 .... @2misc
     VZIP         1111 001 11 . 11 .. 10 .... 0 0011 . . 0 .... @2misc
+
+    VMOVN        1111 001 11 . 11 .. 10 .... 0 0100 0 . 0 .... @2misc_q0
+    # VQMOVUN: unsigned result (source is always signed)
+    VQMOVUN      1111 001 11 . 11 .. 10 .... 0 0100 1 . 0 .... @2misc_q0
+    # VQMOVN: signed result, source may be signed (_S) or unsigned (_U)
+    VQMOVN_S     1111 001 11 . 11 .. 10 .... 0 0101 0 . 0 .... @2misc_q0
+    VQMOVN_U     1111 001 11 . 11 .. 10 .... 0 0101 1 . 0 .... @2misc_q0
   ]
 
   # Subgroup for size != 0b11
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index f4799dd9770..b0620972854 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3243,3 +3243,62 @@ static bool trans_VZIP(DisasContext *s, arg_2misc *a)
     };
     return do_zip_uzp(s, a, fn[a->q][a->size]);
 }
+
+static bool do_vmovn(DisasContext *s, arg_2misc *a,
+                     NeonGenNarrowEnvFn *narrowfn)
+{
+    TCGv_i64 rm;
+    TCGv_i32 rd0, rd1;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->vm & 1) {
+        return false;
+    }
+
+    if (!narrowfn) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    rm = tcg_temp_new_i64();
+    rd0 = tcg_temp_new_i32();
+    rd1 = tcg_temp_new_i32();
+
+    neon_load_reg64(rm, a->vm);
+    narrowfn(rd0, cpu_env, rm);
+    neon_load_reg64(rm, a->vm + 1);
+    narrowfn(rd1, cpu_env, rm);
+    neon_store_reg(a->vd, 0, rd0);
+    neon_store_reg(a->vd, 1, rd1);
+    tcg_temp_free_i64(rm);
+    return true;
+}
+
+#define DO_VMOVN(INSN, FUNC)                                    \
+    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
+    {                                                           \
+        static NeonGenNarrowEnvFn * const narrowfn[] = {        \
+            FUNC##8,                                            \
+            FUNC##16,                                           \
+            FUNC##32,                                           \
+            NULL,                                               \
+        };                                                      \
+        return do_vmovn(s, a, narrowfn[a->size]);               \
+    }
+
+DO_VMOVN(VMOVN, gen_neon_narrow_u)
+DO_VMOVN(VQMOVUN, gen_helper_neon_unarrow_sat)
+DO_VMOVN(VQMOVN_S, gen_helper_neon_narrow_sat_s)
+DO_VMOVN(VQMOVN_U, gen_helper_neon_narrow_sat_u)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 442f287d861..8ecae264e15 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2975,46 +2975,6 @@ static void gen_neon_trn_u16(TCGv_i32 t0, TCGv_i32 t1)
     tcg_temp_free_i32(rd);
 }
 
-static inline void gen_neon_narrow(int size, TCGv_i32 dest, TCGv_i64 src)
-{
-    switch (size) {
-    case 0: gen_helper_neon_narrow_u8(dest, src); break;
-    case 1: gen_helper_neon_narrow_u16(dest, src); break;
-    case 2: tcg_gen_extrl_i64_i32(dest, src); break;
-    default: abort();
-    }
-}
-
-static inline void gen_neon_narrow_sats(int size, TCGv_i32 dest, TCGv_i64 src)
-{
-    switch (size) {
-    case 0: gen_helper_neon_narrow_sat_s8(dest, cpu_env, src); break;
-    case 1: gen_helper_neon_narrow_sat_s16(dest, cpu_env, src); break;
-    case 2: gen_helper_neon_narrow_sat_s32(dest, cpu_env, src); break;
-    default: abort();
-    }
-}
-
-static inline void gen_neon_narrow_satu(int size, TCGv_i32 dest, TCGv_i64 src)
-{
-    switch (size) {
-    case 0: gen_helper_neon_narrow_sat_u8(dest, cpu_env, src); break;
-    case 1: gen_helper_neon_narrow_sat_u16(dest, cpu_env, src); break;
-    case 2: gen_helper_neon_narrow_sat_u32(dest, cpu_env, src); break;
-    default: abort();
-    }
-}
-
-static inline void gen_neon_unarrow_sats(int size, TCGv_i32 dest, TCGv_i64 src)
-{
-    switch (size) {
-    case 0: gen_helper_neon_unarrow_sat8(dest, cpu_env, src); break;
-    case 1: gen_helper_neon_unarrow_sat16(dest, cpu_env, src); break;
-    case 2: gen_helper_neon_unarrow_sat32(dest, cpu_env, src); break;
-    default: abort();
-    }
-}
-
 static inline void gen_neon_widen(TCGv_i64 dest, TCGv_i32 src, int size, int u)
 {
     if (u) {
@@ -3035,24 +2995,6 @@ static inline void gen_neon_widen(TCGv_i64 dest, TCGv_i32 src, int size, int u)
     tcg_temp_free_i32(src);
 }
 
-static void gen_neon_narrow_op(int op, int u, int size,
-                               TCGv_i32 dest, TCGv_i64 src)
-{
-    if (op) {
-        if (u) {
-            gen_neon_unarrow_sats(size, dest, src);
-        } else {
-            gen_neon_narrow(size, dest, src);
-        }
-    } else {
-        if (u) {
-            gen_neon_narrow_satu(size, dest, src);
-        } else {
-            gen_neon_narrow_sats(size, dest, src);
-        }
-    }
-}
-
 /* Symbolic constants for op fields for Neon 2-register miscellaneous.
  * The values correspond to bits [17:16,10:7]; see the ARM ARM DDI0406B
  * table A7-13.
@@ -4994,8 +4936,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     !arm_dc_feature(s, ARM_FEATURE_V8)) {
                     return 1;
                 }
-                if ((op != NEON_2RM_VMOVN && op != NEON_2RM_VQMOVN) &&
-                    q && ((rm | rd) & 1)) {
+                if (q && ((rm | rd) & 1)) {
                     return 1;
                 }
                 switch (op) {
@@ -5004,6 +4945,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VPADAL: case NEON_2RM_VPADAL_U:
                 case NEON_2RM_VUZP:
                 case NEON_2RM_VZIP:
+                case NEON_2RM_VMOVN: case NEON_2RM_VQMOVN:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -5019,25 +4961,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         goto elementwise;
                     }
                     break;
-                case NEON_2RM_VMOVN: case NEON_2RM_VQMOVN:
-                    /* also VQMOVUN; op field and mnemonics don't line up */
-                    if (rm & 1) {
-                        return 1;
-                    }
-                    tmp2 = NULL;
-                    for (pass = 0; pass < 2; pass++) {
-                        neon_load_reg64(cpu_V0, rm + pass);
-                        tmp = tcg_temp_new_i32();
-                        gen_neon_narrow_op(op == NEON_2RM_VMOVN, q, size,
-                                           tmp, cpu_V0);
-                        if (pass == 0) {
-                            tmp2 = tmp;
-                        } else {
-                            neon_store_reg(rd, 0, tmp2);
-                            neon_store_reg(rd, 1, tmp);
-                        }
-                    }
-                    break;
                 case NEON_2RM_VSHLL:
                     if (q || (rd & 1)) {
                         return 1;
-- 
2.20.1


