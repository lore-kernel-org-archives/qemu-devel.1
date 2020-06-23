Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE75C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA1F20738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rbzbe3nj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA1F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhOX-0000QO-OX
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGo-0002Rd-I2
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:40091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGm-0003AG-1G
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id f139so1438155wmf.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5MijMronqy/vV6z9QsNci29v72H8pIiba+pqY/e1OtA=;
 b=Rbzbe3njTIPSbn285kti5OfZhGOV3LENJrVreLNokQS4TL6XrDUI4ZzSXJM4TGDMD2
 JZ/D3eixWa/2dZmI3V8Oe76G7FqPmeorNl97AUubshQn6g7RXVRoZhPF206JrAc/Csdm
 4s4whnKj6I83L8xvF23J0V43ADqEYgzhgsIANifKh44hiiPl3mXqOPD8vHm7KIj0gVCr
 b42iimsIHKytkPyRt5A6nmYoU3uY2IqYnsVqjHbbvml/gxxE5dcYH5OFBCOuZUXHid4V
 I6q77O8m7JwHRIjH3XFDesdnbNFWRzmHq91+/bEqNv9483tFvI4MSrEhz5RHHVwvaebe
 sTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5MijMronqy/vV6z9QsNci29v72H8pIiba+pqY/e1OtA=;
 b=R1pA1C9/fQ5Y8+hTAuJvBRg+DA2HX0ovY3ZAiXE30ZhWJtGUrT+LQaXNaHdXFOxMYB
 /kRy1L3hm1N9FYQX3rQuW0aeu7EDd4/mHkFNZ9o5Hf7Dln5p6QzOBp6KV4nGhheZH5lt
 qK7roOi840s4qHWaJcr9K1gkXH6o+LyC6duyl/bsmbYwemXaKzbK6nLbukG3XKkU5XOT
 0KLI3UDN/mZRN8IdCg79EX7rvUq12k9ekfkE3zLyiCk5IH0iqoOcGoM+ZnwLIL1P3uFm
 GcUNzHjGWNmm1rrFXz3OZKZGgMLdPm0DaAZB2ARzgw+UstriNw2O4dV4jmwsZZXqkm1D
 u2RQ==
X-Gm-Message-State: AOAM5327SuVHq7uMjef6+ylpkxOuKfZ/zn9f19o4RDbDizeA5lzVRMtv
 +t+Fe09OmNe+I41X6V8R6h55kvSO+JDSIw==
X-Google-Smtp-Source: ABdhPJxwblUMzcx0GKBob7WRIybPzX7O0GfVHFiG6DPrwegaCNTvYdPHrkTsv+C3pHSCtaoi0LxuSQ==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr23221702wmc.86.1592912354201; 
 Tue, 23 Jun 2020 04:39:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/42] target/arm: Convert Neon 2-reg-misc VSHLL to decodetree
Date: Tue, 23 Jun 2020 12:38:29 +0100
Message-Id: <20200623113904.28805-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VSHLL insn in the 2-reg-misc Neon group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-6-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  2 ++
 target/arm/translate-neon.inc.c | 52 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 35 +---------------------
 3 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 2277b4c7b51..0102aa7254b 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -459,6 +459,8 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     # VQMOVN: signed result, source may be signed (_S) or unsigned (_U)
     VQMOVN_S     1111 001 11 . 11 .. 10 .... 0 0101 0 . 0 .... @2misc_q0
     VQMOVN_U     1111 001 11 . 11 .. 10 .... 0 0101 1 . 0 .... @2misc_q0
+
+    VSHLL        1111 001 11 . 11 .. 10 .... 0 0110 0 . 0 .... @2misc_q0
   ]
 
   # Subgroup for size != 0b11
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index b0620972854..78239ec1c1b 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3302,3 +3302,55 @@ DO_VMOVN(VMOVN, gen_neon_narrow_u)
 DO_VMOVN(VQMOVUN, gen_helper_neon_unarrow_sat)
 DO_VMOVN(VQMOVN_S, gen_helper_neon_narrow_sat_s)
 DO_VMOVN(VQMOVN_U, gen_helper_neon_narrow_sat_u)
+
+static bool trans_VSHLL(DisasContext *s, arg_2misc *a)
+{
+    TCGv_i32 rm0, rm1;
+    TCGv_i64 rd;
+    static NeonGenWidenFn * const widenfns[] = {
+        gen_helper_neon_widen_u8,
+        gen_helper_neon_widen_u16,
+        tcg_gen_extu_i32_i64,
+        NULL,
+    };
+    NeonGenWidenFn *widenfn = widenfns[a->size];
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
+    if (a->vd & 1) {
+        return false;
+    }
+
+    if (!widenfn) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    rd = tcg_temp_new_i64();
+
+    rm0 = neon_load_reg(a->vm, 0);
+    rm1 = neon_load_reg(a->vm, 1);
+
+    widenfn(rd, rm0);
+    tcg_gen_shli_i64(rd, rd, 8 << a->size);
+    neon_store_reg64(rd, a->vd);
+    widenfn(rd, rm1);
+    tcg_gen_shli_i64(rd, rd, 8 << a->size);
+    neon_store_reg64(rd, a->vd + 1);
+
+    tcg_temp_free_i64(rd);
+    tcg_temp_free_i32(rm0);
+    tcg_temp_free_i32(rm1);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8ecae264e15..94d5e34fff4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2975,26 +2975,6 @@ static void gen_neon_trn_u16(TCGv_i32 t0, TCGv_i32 t1)
     tcg_temp_free_i32(rd);
 }
 
-static inline void gen_neon_widen(TCGv_i64 dest, TCGv_i32 src, int size, int u)
-{
-    if (u) {
-        switch (size) {
-        case 0: gen_helper_neon_widen_u8(dest, src); break;
-        case 1: gen_helper_neon_widen_u16(dest, src); break;
-        case 2: tcg_gen_extu_i32_i64(dest, src); break;
-        default: abort();
-        }
-    } else {
-        switch (size) {
-        case 0: gen_helper_neon_widen_s8(dest, src); break;
-        case 1: gen_helper_neon_widen_s16(dest, src); break;
-        case 2: tcg_gen_ext_i32_i64(dest, src); break;
-        default: abort();
-        }
-    }
-    tcg_temp_free_i32(src);
-}
-
 /* Symbolic constants for op fields for Neon 2-register miscellaneous.
  * The values correspond to bits [17:16,10:7]; see the ARM ARM DDI0406B
  * table A7-13.
@@ -4946,6 +4926,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VUZP:
                 case NEON_2RM_VZIP:
                 case NEON_2RM_VMOVN: case NEON_2RM_VQMOVN:
+                case NEON_2RM_VSHLL:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4961,20 +4942,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         goto elementwise;
                     }
                     break;
-                case NEON_2RM_VSHLL:
-                    if (q || (rd & 1)) {
-                        return 1;
-                    }
-                    tmp = neon_load_reg(rm, 0);
-                    tmp2 = neon_load_reg(rm, 1);
-                    for (pass = 0; pass < 2; pass++) {
-                        if (pass == 1)
-                            tmp = tmp2;
-                        gen_neon_widen(cpu_V0, tmp, size, 1);
-                        tcg_gen_shli_i64(cpu_V0, cpu_V0, 8 << size);
-                        neon_store_reg64(cpu_V0, rd + pass);
-                    }
-                    break;
                 case NEON_2RM_VCVT_F16_F32:
                 {
                     TCGv_ptr fpst;
-- 
2.20.1


