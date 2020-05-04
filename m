Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CC0C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF7F20707
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7W5FY2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF7F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVgiM-00037F-6D
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 15:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVggz-0001VN-Mk
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:23:54 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVggy-0005yX-GN
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:23:53 -0400
Received: by mail-pl1-x643.google.com with SMTP id x10so158681plr.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 12:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c3OBmdqjWHi93YqiLmZoZH4s0E/AFDrL/k2Mh8jPufY=;
 b=q7W5FY2C0QYokknteHr8slty/pobMtz7m5eY2mf/XP/RzNOirkHn9tNLjRIAn4lNt7
 jYP8AS8+7OmOB1yQJLeC6lTL0RQDdNRu/gIBg+e1n4ONt7nL3pDXXmVqhBhQLDGn7UH6
 8uKlfIZEPh2VW4jLevXD6SMheiJabk8XgTWM+lWGuKz/YGr13LgbmKlm0KoYPjUe9K+1
 ZT1HO9BUNQezmuWc+8+VwzFwOAN73OI6YqByL9zoQzZfT3ABLK49ON0XWk0U/dFPIK5a
 vlAAOFhjuq5D4kFd29TtTjL+ubBvO73BYZjWWU8ZApTOmkfE8j1sGnQ4S9X3py+RzJQG
 PSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c3OBmdqjWHi93YqiLmZoZH4s0E/AFDrL/k2Mh8jPufY=;
 b=SnUs+4snttP6VZbdqflXJYtI1gw9lrwOQPWLyweBZG71TVJIGyGmIgXGXiBn598gh/
 dxppnavKBX6xeEhjIrwa9e9iY24mkEJX3GLOLSDSeihY6z+vQEgil92a1LLBH5ryCRBi
 Et2LkWVZIixI0kTkCvW7BZTCBdBA7Ep5A3S7MG2ZrJHYD9SVuwlEnZ2utbxrnkW7bSw2
 i6fHcqDe7+IWZ+Qc+dkemDzWu3FbRvQMsnLu8W4F8Fh53X+r7PtVe3B+DtBJ0DfKz+hp
 ajzz7aBMvy8RjBvYt2uOJH+VtMnXIsas+weJnNM9Oz9H0y/uA0mRUs/8WWozYFl2ka8e
 ZHwg==
X-Gm-Message-State: AGi0PubO6NKM0zQ2lIerhNNeaDSaEZM59kR/tMSXSbUFsz95a637dnxW
 Ul3JNfXcUd5FnLtjKaOnci3ggnnnq7I=
X-Google-Smtp-Source: APiQypI0URcFGyTqybBj/pg/0B3CnTtdsk+GZLZpn0QO89FjQkCH1yYsaZ92T5YIm/rrspr1lUv9zQ==
X-Received: by 2002:a17:90a:fd94:: with SMTP id
 cx20mr552247pjb.157.1588620229754; 
 Mon, 04 May 2020 12:23:49 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b9sm9407364pfp.12.2020.05.04.12.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 12:23:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] target/arm: Use clear_vec_high more effectively
Date: Mon,  4 May 2020 12:23:44 -0700
Message-Id: <20200504192344.13404-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504192344.13404-1-richard.henderson@linaro.org>
References: <20200504192344.13404-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not explicitly store zero to the NEON high part
when we can pass !is_q to clear_vec_high.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 59 +++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 729e746e25..d1c9150c4f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -939,11 +939,10 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
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
@@ -961,12 +960,13 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
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
@@ -6960,8 +6960,8 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
         return;
     }
 
-    tcg_resh = tcg_temp_new_i64();
     tcg_resl = tcg_temp_new_i64();
+    tcg_resh = NULL;
 
     /* Vd gets bits starting at pos bits into Vm:Vn. This is
      * either extracting 128 bits from a 128:128 concatenation, or
@@ -6973,7 +6973,6 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
             read_vec_element(s, tcg_resh, rm, 0, MO_64);
             do_ext64(s, tcg_resh, tcg_resl, pos);
         }
-        tcg_gen_movi_i64(tcg_resh, 0);
     } else {
         TCGv_i64 tcg_hh;
         typedef struct {
@@ -6988,6 +6987,7 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
             pos -= 64;
         }
 
+        tcg_resh = tcg_temp_new_i64();
         read_vec_element(s, tcg_resl, elt->reg, elt->elt, MO_64);
         elt++;
         read_vec_element(s, tcg_resh, elt->reg, elt->elt, MO_64);
@@ -7003,9 +7003,12 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
 
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
 
 /* TBL/TBX
@@ -7042,17 +7045,21 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
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
@@ -7072,9 +7079,12 @@ static void disas_simd_tb(DisasContext *s, uint32_t insn)
 
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
@@ -7111,7 +7121,7 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
     }
 
     tcg_resl = tcg_const_i64(0);
-    tcg_resh = tcg_const_i64(0);
+    tcg_resh = is_q ? tcg_const_i64(0) : NULL;
     tcg_res = tcg_temp_new_i64();
 
     for (i = 0; i < elements; i++) {
@@ -7162,9 +7172,12 @@ static void disas_simd_zip_trn(DisasContext *s, uint32_t insn)
 
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


