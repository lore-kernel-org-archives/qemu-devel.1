Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36865C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE80420B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cwqjtvnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE80420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlF9H-00039t-P9
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF50-0001AH-Fk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:58 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF4y-0007SI-J4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:58 -0400
Received: by mail-wr1-x443.google.com with SMTP id b6so2418498wrs.11
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lzfN+/dc2P6ZbMH+0ykRO/LyObijCbdPzmVPKRrgPx0=;
 b=CwqjtvnmJ1ygkEOmUA/LBX04E6Q42eFTXX2Q265sr4NKQML1PNPQtlYUTRKbLd8hiT
 DLC5f73006AvGvllFhnaaQvHUDAhY4W1keJ+t+UlIPiBVGX7Sd27vCIJUyWYCqguaUA3
 UXr9O++b8Cxf29S6oAyrZJSbZ/AR/dAUNWF+yzYIrPZRSprLM6/TvnVKth9OtI0yacjj
 BJtVrBqc78qpRmHBskmojjZa0knt76t3Ki6c9P7LybJDijWJDscE9Y9HHvyud5Y69iLl
 XpnXXBT+v/QuDZC8J0+YNRr71o0gfO1JIv4H/A66mxLIvFXIe6x/+Olbt5RE2yL9nZ27
 IlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lzfN+/dc2P6ZbMH+0ykRO/LyObijCbdPzmVPKRrgPx0=;
 b=hkstJ2dy5EREy7k4GCQsLy4x2ylXh0UNtqoHi23NWHfTrcIZmzUY876PrFMpFzwlc4
 yNrnfJjzhJ/j5S38GXmEUbtUokUDsmpQCDFMuwPgk3uefVeWZVO85kH8E0vZbhGB9Nd6
 1gZ6vAMMi4evtmYy5BbsyVHtftSuKc36WPqSMYdrN/KhWLDRpCrtmFdSDQ1CmhY8FB4x
 HfAQCH08pVqMvfTk1fkBl6oGgAeCHCLYQbWAz6FnmYushWyPuWkCTGFHx2xsyHbKM8DB
 tyWf7SckUPskRdaOffBcPWewLaLzcX4Y2l1bQyqBpEd7zxTOxFz1Tq9xVBMgBxkfgdAj
 IePw==
X-Gm-Message-State: AOAM53041rpZQ0U85PZqvF/7HCBLwSvWHo2XcYiLrFCR3pO5wWXZwMuM
 3/PrcgqApIuj+I+j8D40mDKxuA==
X-Google-Smtp-Source: ABdhPJxFgQR6qx93GfCO+9PH99eWOHr1g2/ttvvF0niX/jTy0btiqK9SWYXYoHsp9hb8jiwO9o7t5g==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr4251775wrt.9.1592327335137;
 Tue, 16 Jun 2020 10:08:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:08:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/21] target/arm: Convert Neon 2-reg-misc VSHLL to decodetree
Date: Tue, 16 Jun 2020 18:08:28 +0100
Message-Id: <20200616170844.13318-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

Convert the VSHLL insn in the 2-reg-misc Neon group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


