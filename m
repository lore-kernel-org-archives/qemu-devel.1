Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95F6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3E4207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmGNT/oi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3E4207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqsu-0005YG-UL
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgP-0002y6-N5
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgO-0000V8-JJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id g12so6565931wrw.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6lARWAcGcGM1iXMRMByZiacWi/0jxcclvLVCQpWGN5I=;
 b=BmGNT/oiqmgQpXBq+5fFZcVtx8zi+EP0aBrdQ/tjg5NJYA+tXIU160PYRyXa3tlga6
 MNpmP26aUMzdhrQt4kBApD79zrBHsRIQTngcBFwK1maIjmHaNUBX7FieOLHz5RgF7HgT
 gnhtBp3fBQSSCUunu8QBYB4FLM/Ue7qYe9chKisdqZKe2UYnw++xx9+Ud0qHed0jfjCb
 XeSw+xb5ZEIcRn07MKnPdlHca0to7yWApx64UMCW8YrxoWQrUoX19GyAn4W2cVZNN+R+
 i/1ShZVZrAt70LjT1Up3OQz7ze44K26Nhc5s/ZJ8oD9SMx+sT1lgXX6OdqR5kcBtFGwD
 1RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6lARWAcGcGM1iXMRMByZiacWi/0jxcclvLVCQpWGN5I=;
 b=Si9RkxC0MD34HIPbhsoVNz3yi4iibYXogFrEfHT/mD7MZreK9sqpFMI/yB2rLmgIRU
 AeoJ91caKz8TNCT768sdvhrBdigEJWmRRa6xLL3GD7wYq5Gi9XzgAcopoGX5Dnn3VtLv
 W29ajZEhDPUK4FMJOoOu1AW1jzmSQPLdU8I5XUd5v1HjFGzLkAxMYGmnMWvsMPVDkvS3
 oqAsBDwlCJFRUYh3Is021J/QNRJhEy7/+6KgAW8BTT1pfRKU34Km9IS0eyO4bJeKORXa
 52ZGL1b8Gvx9iIByjLIz/N34kLLmkbJ7xcZWOmvsospaEKIwKtKAwYTOls4HkF3LN3j/
 CFXA==
X-Gm-Message-State: AOAM531KQNBLd9kq7jtUYaOJ0hiuUdzV7IZCCsy0pPDAQvDOJST2ydos
 Oocq/uwsdpnCTx1kLiZmp/5NNdpqV0vI6w==
X-Google-Smtp-Source: ABdhPJwZkvD/5GmyBMITbbHOAWt5nEMrPYHesKQWmwCrc3aV362m1sbOjBvvCONWcMs0bkTBfjzi7A==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr97028wrm.364.1590088602951;
 Thu, 21 May 2020 12:16:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/29] target/arm: Use clear_vec_high more effectively
Date: Thu, 21 May 2020 20:16:07 +0100
Message-Id: <20200521191610.10941-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

Do not explicitly store zero to the NEON high part
when we can pass !is_q to clear_vec_high.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200519212453.28494-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 53 +++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4f6edb28927..874f3eb4f97 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -900,11 +900,10 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
 {
     /* This always zero-extends and writes to a full 128 bit wide vector */
     TCGv_i64 tmplo = tcg_temp_new_i64();
-    TCGv_i64 tmphi;
+    TCGv_i64 tmphi = NULL;
 
     if (size < 4) {
         MemOp memop = s->be_data + size;
-        tmphi = tcg_const_i64(0);
         tcg_gen_qemu_ld_i64(tmplo, tcg_addr, get_mem_index(s), memop);
     } else {
         bool be = s->be_data == MO_BE;
@@ -922,12 +921,13 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
     }
 
     tcg_gen_st_i64(tmplo, cpu_env, fp_reg_offset(s, destidx, MO_64));
-    tcg_gen_st_i64(tmphi, cpu_env, fp_reg_hi_offset(s, destidx));
-
     tcg_temp_free_i64(tmplo);
-    tcg_temp_free_i64(tmphi);
 
-    clear_vec_high(s, true, destidx);
+    if (tmphi) {
+        tcg_gen_st_i64(tmphi, cpu_env, fp_reg_hi_offset(s, destidx));
+        tcg_temp_free_i64(tmphi);
+    }
+    clear_vec_high(s, tmphi != NULL, destidx);
 }
 
 /*
@@ -6934,7 +6934,6 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
             read_vec_element(s, tcg_resh, rm, 0, MO_64);
             do_ext64(s, tcg_resh, tcg_resl, pos);
         }
-        tcg_gen_movi_i64(tcg_resh, 0);
     } else {
         TCGv_i64 tcg_hh;
         typedef struct {
@@ -6964,9 +6963,11 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
 
     write_vec_element(s, tcg_resl, rd, 0, MO_64);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
+    if (is_q) {
+        write_vec_element(s, tcg_resh, rd, 1, MO_64);
+    }
     tcg_temp_free_i64(tcg_resh);
-    clear_vec_high(s, true, rd);
+    clear_vec_high(s, is_q, rd);
 }
 
 /* TBL/TBX
@@ -7003,17 +7004,21 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
      * the input.
      */
     tcg_resl = tcg_temp_new_i64();
-    tcg_resh = tcg_temp_new_i64();
+    tcg_resh = NULL;
 
     if (is_tblx) {
         read_vec_element(s, tcg_resl, rd, 0, MO_64);
     } else {
         tcg_gen_movi_i64(tcg_resl, 0);
     }
-    if (is_tblx && is_q) {
-        read_vec_element(s, tcg_resh, rd, 1, MO_64);
-    } else {
-        tcg_gen_movi_i64(tcg_resh, 0);
+
+    if (is_q) {
+        tcg_resh = tcg_temp_new_i64();
+        if (is_tblx) {
+            read_vec_element(s, tcg_resh, rd, 1, MO_64);
+        } else {
+            tcg_gen_movi_i64(tcg_resh, 0);
+        }
     }
 
     tcg_idx = tcg_temp_new_i64();
@@ -7033,9 +7038,12 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
 
     write_vec_element(s, tcg_resl, rd, 0, MO_64);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
-    tcg_temp_free_i64(tcg_resh);
-    clear_vec_high(s, true, rd);
+
+    if (is_q) {
+        write_vec_element(s, tcg_resh, rd, 1, MO_64);
+        tcg_temp_free_i64(tcg_resh);
+    }
+    clear_vec_high(s, is_q, rd);
 }
 
 /* ZIP/UZP/TRN
@@ -7072,7 +7080,7 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
     }
 
     tcg_resl = tcg_const_i64(0);
-    tcg_resh = tcg_const_i64(0);
+    tcg_resh = is_q ? tcg_const_i64(0) : NULL;
     tcg_res = tcg_temp_new_i64();
 
     for (i = 0; i < elements; i++) {
@@ -7123,9 +7131,12 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
 
     write_vec_element(s, tcg_resl, rd, 0, MO_64);
     tcg_temp_free_i64(tcg_resl);
-    write_vec_element(s, tcg_resh, rd, 1, MO_64);
-    tcg_temp_free_i64(tcg_resh);
-    clear_vec_high(s, true, rd);
+
+    if (is_q) {
+        write_vec_element(s, tcg_resh, rd, 1, MO_64);
+        tcg_temp_free_i64(tcg_resh);
+    }
+    clear_vec_high(s, is_q, rd);
 }
 
 /*
-- 
2.20.1


