Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3C4206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJzYrLGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3C4206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc99T-0002sU-NR
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 10:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc95A-00029W-OT
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc959-0006TR-EY
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:55:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id h17so10430149wrc.8
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zsvrpi2W2w+CDxMMfrv5ax6LeBleFK4iIcwBhd1+Ups=;
 b=IJzYrLGOfOTR9Y6ohcHuQcJZ1VHr6vuKN3670am8vP65TJ4gWnNpOG5MWp+GTQkmXq
 pgu2VOfjDWetYZLpvunnfg4HByOiXBT7iPkiz7cjjdJNVFY2lB3zlRz66fVUXzlqyU1s
 EeYdGsMkS9paGHO53verfWGl6tzESjK9IARpfg3cij0CVDjm+NCXGXZHAEIpSybbBUvu
 1smeRFtjAw/b9FOrg7eCFhTNayugqwX37JwO2T/vsYUcbKtMf3XTJ/IbAA9I/vQid+U6
 KvbIAh8B0uWFygxZWXgd24trxbOPFHi8ledhA2yIXDiZjUowo85pYIQpcVH7VDrNs0ij
 kkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zsvrpi2W2w+CDxMMfrv5ax6LeBleFK4iIcwBhd1+Ups=;
 b=q4ossNdw+UajiCk3kggRQl7qJ5wQjwXW/RNfot+9n2FciRGNEEkyb4t+BFeKg8G7+x
 KFQ6DOwqsIkND66rsScn/eQn8UZn4EZdQ8Y2qpjF/JseXaRllCcYMn9e6KBY5PzRqAvm
 ozrjb7su3nmZcGd2JyZBJ5pmt8optAtaOONxnX5lwNxKh++Z7lTZY3ySfFHja7G1ZICM
 f6dOj6/STIFUDtF7/MCYiIetG0qV5n0fy5trZYJsqRJGVFez8888V1ruaPQjr7fMhEGj
 z5E5IGQons2qzXgg7iSZVRzA8ctDBSIvRcF51GKjaijEhaUaKc5LYW5PMZ8S3DCKjcTo
 U2Gg==
X-Gm-Message-State: AOAM531ATyqOtzm7O3MS2pqb44ccWlMhUZaWmmJZ1aZ0ZB04iCIDVFO2
 d7ERmBWKtYAEfRn+7vUpEquNWQ==
X-Google-Smtp-Source: ABdhPJwNNAPvy2luqRFp4lOyFtRtWNy6TQ8pd4yfX+RtKxNxu0PbLX7/IdDLNPYgOc9ENOP9rqkKkQ==
X-Received: by 2002:a5d:640f:: with SMTP id z15mr3714754wru.24.1590159329966; 
 Fri, 22 May 2020 07:55:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y8sm1100561wmc.37.2020.05.22.07.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 07:55:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] target/arm: Convert Neon narrowing shifts with op==9
 to decodetree
Date: Fri, 22 May 2020 15:55:17 +0100
Message-Id: <20200522145520.6778-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522145520.6778-1-peter.maydell@linaro.org>
References: <20200522145520.6778-1-peter.maydell@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the remaining Neon narrowing shifts to decodetree:
  * VQSHRN
  * VQRSHRN

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  20 ++++++
 target/arm/translate-neon.inc.c |  15 +++++
 target/arm/translate.c          | 110 +-------------------------------
 3 files changed, 37 insertions(+), 108 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 01887240b4a..43db393cf76 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -326,3 +326,23 @@ VQSHRUN_16_2sh   1111 001 1 1 . ...... .... 1000 . 0 . 1 .... @2reg_shrn_h
 VQRSHRUN_64_2sh  1111 001 1 1 . ...... .... 1000 . 1 . 1 .... @2reg_shrn_d
 VQRSHRUN_32_2sh  1111 001 1 1 . ...... .... 1000 . 1 . 1 .... @2reg_shrn_s
 VQRSHRUN_16_2sh  1111 001 1 1 . ...... .... 1000 . 1 . 1 .... @2reg_shrn_h
+
+# VQSHRN with signed input
+VQSHRN_S64_2sh   1111 001 0 1 . ...... .... 1001 . 0 . 1 .... @2reg_shrn_d
+VQSHRN_S32_2sh   1111 001 0 1 . ...... .... 1001 . 0 . 1 .... @2reg_shrn_s
+VQSHRN_S16_2sh   1111 001 0 1 . ...... .... 1001 . 0 . 1 .... @2reg_shrn_h
+
+# VQRSHRN with signed input
+VQRSHRN_S64_2sh  1111 001 0 1 . ...... .... 1001 . 1 . 1 .... @2reg_shrn_d
+VQRSHRN_S32_2sh  1111 001 0 1 . ...... .... 1001 . 1 . 1 .... @2reg_shrn_s
+VQRSHRN_S16_2sh  1111 001 0 1 . ...... .... 1001 . 1 . 1 .... @2reg_shrn_h
+
+# VQSHRN with unsigned input
+VQSHRN_U64_2sh   1111 001 1 1 . ...... .... 1001 . 0 . 1 .... @2reg_shrn_d
+VQSHRN_U32_2sh   1111 001 1 1 . ...... .... 1001 . 0 . 1 .... @2reg_shrn_s
+VQSHRN_U16_2sh   1111 001 1 1 . ...... .... 1001 . 0 . 1 .... @2reg_shrn_h
+
+# VQRSHRN with unsigned input
+VQRSHRN_U64_2sh  1111 001 1 1 . ...... .... 1001 . 1 . 1 .... @2reg_shrn_d
+VQRSHRN_U32_2sh  1111 001 1 1 . ...... .... 1001 . 1 . 1 .... @2reg_shrn_s
+VQRSHRN_U16_2sh  1111 001 1 1 . ...... .... 1001 . 1 . 1 .... @2reg_shrn_h
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 18ea7255e38..9a75a69a4f5 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1672,3 +1672,18 @@ DO_2SN_32(VQSHRUN_16, gen_helper_neon_shl_s16, gen_helper_neon_unarrow_sat8)
 DO_2SN_64(VQRSHRUN_64, gen_helper_neon_rshl_s64, gen_helper_neon_unarrow_sat32)
 DO_2SN_32(VQRSHRUN_32, gen_helper_neon_rshl_s32, gen_helper_neon_unarrow_sat16)
 DO_2SN_32(VQRSHRUN_16, gen_helper_neon_rshl_s16, gen_helper_neon_unarrow_sat8)
+DO_2SN_64(VQSHRN_S64, gen_sshl_i64, gen_helper_neon_narrow_sat_s32)
+DO_2SN_32(VQSHRN_S32, gen_sshl_i32, gen_helper_neon_narrow_sat_s16)
+DO_2SN_32(VQSHRN_S16, gen_helper_neon_shl_s16, gen_helper_neon_narrow_sat_s8)
+
+DO_2SN_64(VQRSHRN_S64, gen_helper_neon_rshl_s64, gen_helper_neon_narrow_sat_s32)
+DO_2SN_32(VQRSHRN_S32, gen_helper_neon_rshl_s32, gen_helper_neon_narrow_sat_s16)
+DO_2SN_32(VQRSHRN_S16, gen_helper_neon_rshl_s16, gen_helper_neon_narrow_sat_s8)
+
+DO_2SN_64(VQSHRN_U64, gen_ushl_i64, gen_helper_neon_narrow_sat_u32)
+DO_2SN_32(VQSHRN_U32, gen_ushl_i32, gen_helper_neon_narrow_sat_u16)
+DO_2SN_32(VQSHRN_U16, gen_helper_neon_shl_u16, gen_helper_neon_narrow_sat_u8)
+
+DO_2SN_64(VQRSHRN_U64, gen_helper_neon_rshl_u64, gen_helper_neon_narrow_sat_u32)
+DO_2SN_32(VQRSHRN_U32, gen_helper_neon_rshl_u32, gen_helper_neon_narrow_sat_u16)
+DO_2SN_32(VQRSHRN_U16, gen_helper_neon_rshl_u16, gen_helper_neon_narrow_sat_u8)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f884db535b4..f728231b198 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3201,40 +3201,6 @@ static inline void gen_neon_unarrow_sats(int size, TCGv_i32 dest, TCGv_i64 src)
     }
 }
 
-static inline void gen_neon_shift_narrow(int size, TCGv_i32 var, TCGv_i32 shift,
-                                         int q, int u)
-{
-    if (q) {
-        if (u) {
-            switch (size) {
-            case 1: gen_helper_neon_rshl_u16(var, var, shift); break;
-            case 2: gen_helper_neon_rshl_u32(var, var, shift); break;
-            default: abort();
-            }
-        } else {
-            switch (size) {
-            case 1: gen_helper_neon_rshl_s16(var, var, shift); break;
-            case 2: gen_helper_neon_rshl_s32(var, var, shift); break;
-            default: abort();
-            }
-        }
-    } else {
-        if (u) {
-            switch (size) {
-            case 1: gen_helper_neon_shl_u16(var, var, shift); break;
-            case 2: gen_ushl_i32(var, var, shift); break;
-            default: abort();
-            }
-        } else {
-            switch (size) {
-            case 1: gen_helper_neon_shl_s16(var, var, shift); break;
-            case 2: gen_sshl_i32(var, var, shift); break;
-            default: abort();
-            }
-        }
-    }
-}
-
 static inline void gen_neon_widen(TCGv_i64 dest, TCGv_i32 src, int size, int u)
 {
     if (u) {
@@ -5281,6 +5247,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             case 6: /* VQSHLU */
             case 7: /* VQSHL */
             case 8: /* VSHRN, VRSHRN, VQSHRUN, VQRSHRUN */
+            case 9: /* VQSHRN, VQRSHRN */
                 return 1; /* handled by decodetree */
             default:
                 break;
@@ -5298,80 +5265,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     size--;
             }
             shift = (insn >> 16) & ((1 << (3 + size)) - 1);
-            if (op < 10) {
-                /* Shift by immediate and narrow:
-                   VSHRN, VRSHRN, VQSHRN, VQRSHRN.  */
-                int input_unsigned = (op == 8) ? !u : u;
-                if (rm & 1) {
-                    return 1;
-                }
-                shift = shift - (1 << (size + 3));
-                size++;
-                if (size == 3) {
-                    tmp64 = tcg_const_i64(shift);
-                    neon_load_reg64(cpu_V0, rm);
-                    neon_load_reg64(cpu_V1, rm + 1);
-                    for (pass = 0; pass < 2; pass++) {
-                        TCGv_i64 in;
-                        if (pass == 0) {
-                            in = cpu_V0;
-                        } else {
-                            in = cpu_V1;
-                        }
-                        if (q) {
-                            if (input_unsigned) {
-                                gen_helper_neon_rshl_u64(cpu_V0, in, tmp64);
-                            } else {
-                                gen_helper_neon_rshl_s64(cpu_V0, in, tmp64);
-                            }
-                        } else {
-                            if (input_unsigned) {
-                                gen_ushl_i64(cpu_V0, in, tmp64);
-                            } else {
-                                gen_sshl_i64(cpu_V0, in, tmp64);
-                            }
-                        }
-                        tmp = tcg_temp_new_i32();
-                        gen_neon_narrow_op(op == 8, u, size - 1, tmp, cpu_V0);
-                        neon_store_reg(rd, pass, tmp);
-                    } /* for pass */
-                    tcg_temp_free_i64(tmp64);
-                } else {
-                    if (size == 1) {
-                        imm = (uint16_t)shift;
-                        imm |= imm << 16;
-                    } else {
-                        /* size == 2 */
-                        imm = (uint32_t)shift;
-                    }
-                    tmp2 = tcg_const_i32(imm);
-                    tmp4 = neon_load_reg(rm + 1, 0);
-                    tmp5 = neon_load_reg(rm + 1, 1);
-                    for (pass = 0; pass < 2; pass++) {
-                        if (pass == 0) {
-                            tmp = neon_load_reg(rm, 0);
-                        } else {
-                            tmp = tmp4;
-                        }
-                        gen_neon_shift_narrow(size, tmp, tmp2, q,
-                                              input_unsigned);
-                        if (pass == 0) {
-                            tmp3 = neon_load_reg(rm, 1);
-                        } else {
-                            tmp3 = tmp5;
-                        }
-                        gen_neon_shift_narrow(size, tmp3, tmp2, q,
-                                              input_unsigned);
-                        tcg_gen_concat_i32_i64(cpu_V0, tmp, tmp3);
-                        tcg_temp_free_i32(tmp);
-                        tcg_temp_free_i32(tmp3);
-                        tmp = tcg_temp_new_i32();
-                        gen_neon_narrow_op(op == 8, u, size - 1, tmp, cpu_V0);
-                        neon_store_reg(rd, pass, tmp);
-                    } /* for pass */
-                    tcg_temp_free_i32(tmp2);
-                }
-            } else if (op == 10) {
+            if (op == 10) {
                 /* VSHLL, VMOVL */
                 if (q || (rd & 1)) {
                     return 1;
-- 
2.20.1


