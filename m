Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94988C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C323620671
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkNaAgio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C323620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYuMR-0006U6-GX
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJd-0003kz-H4
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:33:05 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:39570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJb-00022u-Pz
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:33:05 -0400
Received: by mail-pj1-x1033.google.com with SMTP id e6so11215716pjt.4
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NLb4rJjMwiMsLgfx7HOV1muKPW0Fe0mWL0pQOnLqixs=;
 b=NkNaAgio82eDYKGidh/r6DIupdurwkx5r0sGeI4ArSShWcmRGwUn+Dwggugz0zm3ll
 Cd/OwvEARRuDLGIk+ECRooxJdqYp773SvmSf8IJm+7STjs7EE6D8NDDIRg/7RUBNfe5q
 MVz+rdMyRwyh1UU0uzqEKDphrFRw0TGFpaH2PxFoAj3gsTTspLPthpr2Jj9dAsowdHuK
 dTE1miExlgD0gI1nJaE2Of2qk6K1zUAl8ikiaFEcqWiBciLTlYLj2JxfxyDwChSThirX
 y/QwkSu5s5DXW2wcC5TgDYL+pDapC3+mz5LKryzTAmnYDOUxnguqMKK+LpBQIuTHgMc8
 Cp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NLb4rJjMwiMsLgfx7HOV1muKPW0Fe0mWL0pQOnLqixs=;
 b=sgveRowXBzsGP17IMN6JZ52qkv/vhNR2okY4TNmnrZWp+HjfLwAHEaFP9FqModiAU3
 TMSwzQzNjjovy+KyPatCyw9ithU6VrbaZTB4tInG+oCi4hPlWTVJgOb7DmzNbgtpxngF
 CU9yJy976HqZlOzw51OFSYoF9F92IAcp7Lz02FqyvDkNtxRLbs3CQLp4wlzlHggKil1a
 CCCKlBcFRKxBEWXWUEQdzFwhEKMmXaCmwyDklkxPL2mBpMqen5HGFsOLi+C2SCu9fEgW
 WewH6zwfUp4UnEqMbF4ltqgANtH7q8A0fUmlQhZPIxGXmlExMpSB5+BXa1gIilgp/gs0
 eiWw==
X-Gm-Message-State: AGi0PuZZdOqXgf8f3XTawrSkLVtjzahzolOLJs+PZ9QaPny9n3fXtKyN
 AzHa6fB9hP3NPHhFBqWlj1myZ+OqZnM=
X-Google-Smtp-Source: APiQypJkNDOizqmwiiXR0NMaOU6D5KVd7kNjfZ+TT7CIJcUcFT4trR0Xli1AnoU4Bem3L2YeO+X/2Q==
X-Received: by 2002:a17:90a:154e:: with SMTP id
 y14mr36596197pja.180.1589387581810; 
 Wed, 13 May 2020 09:33:01 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b11sm158025pgq.50.2020.05.13.09.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 09:33:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/16] target/arm: Remove fp_status from helper_{recpe,
 rsqrte}_u32
Date: Wed, 13 May 2020 09:32:40 -0700
Message-Id: <20200513163245.17915-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513163245.17915-1-richard.henderson@linaro.org>
References: <20200513163245.17915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These operations do not touch fp_status.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  4 ++--
 target/arm/translate-a64.c |  5 ++---
 target/arm/translate.c     | 12 ++----------
 target/arm/vfp_helper.c    |  5 ++---
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 33c76192d2..aed3050965 100644
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
index ea5f6ceadc..367fa403ae 100644
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
index 7eb30cde60..391a09b439 100644
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
index 930d6e747f..ec007fce25 100644
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


