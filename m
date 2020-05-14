Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97EDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D842070A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnEAAMaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D842070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEsK-0003A5-0h
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkJ-0003FC-Dn
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:54794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkI-0005Vc-Cb
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id h4so30638749wmb.4
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vGNBvzWQnNyeSUZbCzkD8+xeY/qtiNaKHPkdz0TpHjQ=;
 b=xnEAAMajvhoYrbPd5sh6U4mogeRCThq/TFpyEWTOXYOx1QPulDpGlNstolnAAhojP0
 VTtH1WwlwmwlfX5t+wnAV8NavTsRPeEpqgXmzkuUERsBWu5L8OK+vlxUySVtxS0TFwqp
 g2Ax0NGDn3Two84/spRUBMVM2v/F0Vg92LNhWomw0gYQiFAoPr5/vkoSRaiflnTRUVLX
 63Ay1CVtNrJpPUYcZTjc6eMGvopA4Aqxxo9Z1VpnvtFPwN3+pBA1G9dC24zlkIfPnCJx
 SOWHufkAiIKPxkgXEGq6/6IzJBWzh4AIS6MhDn0PtsSmhzvEujZnL4dtMdTRO2JCxeOp
 C9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vGNBvzWQnNyeSUZbCzkD8+xeY/qtiNaKHPkdz0TpHjQ=;
 b=YLsF7RGBNH++KhBUfcCQYf5ru0rD5cBwccn6ruF8aQUh+npkgs+1KUVHJhgmN1VDcw
 z5DjF7sUlO3oonEoD+TKLF5Vv16kzK58HTwHC1NXaEgyRhpaX6jN2NCfT8njHB5T+YnG
 hkNs5cpfXZM7er3YhZ2W8yoKP4NFg7nEoPdc8u7TKYcdh87AOPtGDPMJ+SDmKXuPcWln
 uS1uz2nt1Jy1RJm7srgmMaAENzI0NlWxwiSZvHL+YQPqdZB+xFrvv1fMC2H5YBfKdhOU
 TlzqG8sZmbnqMVYqXr7Mw6SmCYElCbVlqO93LHsJaqUEYyS+AEd30hEIAi+5hIP9MnY9
 qyTA==
X-Gm-Message-State: AOAM531AvzItt7z2rNWTCz9d3HLF6mCg6N4kkE3qibQC6NzwcJfGbhwC
 lazEYCghxzNxuS/+Erhz0zcgQWKgHKQqbQ==
X-Google-Smtp-Source: ABdhPJwS3DWKRJ0qDNvv71+dzZ8UFoQEDNs8orEHIhNA7nc4L2RlJw3Qty+9WAzTpLoqk1D9Y6Nk3Q==
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr13901351wmi.37.1589466116722; 
 Thu, 14 May 2020 07:21:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.21.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:21:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/45] target/arm: Remove fp_status from helper_{recpe,
 rsqrte}_u32
Date: Thu, 14 May 2020 15:21:05 +0100
Message-Id: <20200514142138.20875-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

These operations do not touch fp_status.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200513163245.17915-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |  4 ++--
 target/arm/translate-a64.c |  5 ++---
 target/arm/translate.c     | 12 ++----------
 target/arm/vfp_helper.c    |  5 ++---
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 33c76192d20..aed30509655 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -211,8 +211,8 @@ DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f16, TCG_CALL_NO_RWG, f16, f16, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, ptr)
 DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, ptr)
-DEF_HELPER_2(recpe_u32, i32, i32, ptr)
-DEF_HELPER_FLAGS_2(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32, ptr)
+DEF_HELPER_FLAGS_1(recpe_u32, TCG_CALL_NO_RWG, i32, i32)
+DEF_HELPER_FLAGS_1(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32)
 DEF_HELPER_FLAGS_4(neon_tbl, TCG_CALL_NO_RWG, i32, i32, i32, ptr, i32)
 
 DEF_HELPER_3(shl_cc, i32, env, i32, i32)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ea5f6ceadcb..367fa403ae2 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9699,7 +9699,7 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
 
             switch (opcode) {
             case 0x3c: /* URECPE */
-                gen_helper_recpe_u32(tcg_res, tcg_op, fpst);
+                gen_helper_recpe_u32(tcg_res, tcg_op);
                 break;
             case 0x3d: /* FRECPE */
                 gen_helper_recpe_f32(tcg_res, tcg_op, fpst);
@@ -12244,7 +12244,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 return;
             }
-            need_fpstatus = true;
             break;
         case 0x1e: /* FRINT32Z */
         case 0x1f: /* FRINT64Z */
@@ -12412,7 +12411,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     gen_helper_rints_exact(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 case 0x7c: /* URSQRTE */
-                    gen_helper_rsqrte_u32(tcg_res, tcg_op, tcg_fpstatus);
+                    gen_helper_rsqrte_u32(tcg_res, tcg_op);
                     break;
                 case 0x1e: /* FRINT32Z */
                 case 0x5e: /* FRINT32X */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7eb30cde600..391a09b4398 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6875,19 +6875,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             break;
                         }
                         case NEON_2RM_VRECPE:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_recpe_u32(tmp, tmp, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
+                            gen_helper_recpe_u32(tmp, tmp);
                             break;
-                        }
                         case NEON_2RM_VRSQRTE:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_rsqrte_u32(tmp, tmp, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
+                            gen_helper_rsqrte_u32(tmp, tmp);
                             break;
-                        }
                         case NEON_2RM_VRECPE_F:
                         {
                             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 930d6e747f6..ec007fce255 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1023,9 +1023,8 @@ float64 HELPER(rsqrte_f64)(float64 input, void *fpstp)
     return make_float64(val);
 }
 
-uint32_t HELPER(recpe_u32)(uint32_t a, void *fpstp)
+uint32_t HELPER(recpe_u32)(uint32_t a)
 {
-    /* float_status *s = fpstp; */
     int input, estimate;
 
     if ((a & 0x80000000) == 0) {
@@ -1038,7 +1037,7 @@ uint32_t HELPER(recpe_u32)(uint32_t a, void *fpstp)
     return deposit32(0, (32 - 9), 9, estimate);
 }
 
-uint32_t HELPER(rsqrte_u32)(uint32_t a, void *fpstp)
+uint32_t HELPER(rsqrte_u32)(uint32_t a)
 {
     int estimate;
 
-- 
2.20.1


