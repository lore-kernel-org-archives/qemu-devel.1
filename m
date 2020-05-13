Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD18AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5492065D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRs8eg+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5492065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYuSe-0001Wc-LV
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJU-0003er-SG
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:32:56 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJT-00020N-Ud
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:32:56 -0400
Received: by mail-pl1-x644.google.com with SMTP id u22so32501plq.12
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aEeapnyAaYV0er6LNsDf+nnur14ggqXJIcqCiWufNK0=;
 b=wRs8eg+qSjJsDO8X2oJuG5+dH7gxjcvKT4uab5YBXDLX89wjresuGcN7A1b6i3M+WC
 pPLWUu65KgafJCrNNdsCNaQyHEQEVLjuYdoX0bnKp4DXVjeIe8cv2adWaapMvHsTeCTe
 Ctel7rknCZFVfUQGMjSEr0rxL4DNxHtpddXznhmTV0iogjYodGHOVoHPyv7bJYMj4HhB
 rRc97A4caKXU6jDYiOQRzSzBQQvVGTZ4jg592TlXW5uW4wUBvmdfeXqvfQemVVOFd9gA
 DHhVCohWLgth+9fGopg+ndgQQq0ArZxgcEsc+C/c6hdR4BqW2lxPKXybH+RUCHEb6tXr
 pW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aEeapnyAaYV0er6LNsDf+nnur14ggqXJIcqCiWufNK0=;
 b=VVVjJRbrt6oGMfKBPvWx9HOS7EAjEqvDJtJgpJdqTOQyNjuIr4DPx+wC6egkbqgmwP
 S2I0/LM/2VsZKOkDo6/DgDaaZiuGgplUjP5t2tiJoiWNLMVUFgbMdc4QdNWK7JvqW9p4
 ZM6QSAgSYSMBJck6rWDDAHgPcJGXBxSWXNWsFS3Ykw+OHXezENR+7ER2vl3OIP6eFYfe
 Fk33y2zVXyOvww7VGwnnoN6ksMIBcAALMIIh+s4liXSBdKUm+wDD7wqaYK5ZnHX11mhX
 xPxL2ByWptmsMJcox1rAQ7TLB+M9jfR/z9NXslRHtTEA2WMFDn2TPzCmxshrE4KIMFOj
 SVPQ==
X-Gm-Message-State: AOAM531B8Mfr+CUvopq6We6xUjxYRip3seSQpGnO47ObCe6yp1X9hPlq
 SSa5l5GaSYXtfvNRJ1mCkM4IsRHcZBA=
X-Google-Smtp-Source: ABdhPJwMx6q1zmbly3hq2pgVVP2rF807pecfA3UQQQHpWJCF1dfzvkZjEMITe8PVRFGYD2iKOhDbrQ==
X-Received: by 2002:a17:902:b7cc:: with SMTP id v12mr31525plz.39.1589387574244; 
 Wed, 13 May 2020 09:32:54 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b11sm158025pgq.50.2020.05.13.09.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 09:32:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/16] target/arm: Tidy handle_vec_simd_shri
Date: Wed, 13 May 2020 09:32:34 -0700
Message-Id: <20200513163245.17915-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513163245.17915-1-richard.henderson@linaro.org>
References: <20200513163245.17915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

Now that we've converted all cases to gvec, there is quite a bit
of dead code at the end of the function.  Remove it.

Sink the call to gen_gvec_fn2i to the end, loading a function
pointer within the switch statement.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 56 ++++++++++----------------------------
 1 file changed, 14 insertions(+), 42 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2d7dad6c3f..d5e77f34a7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10155,16 +10155,7 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
     int size = 32 - clz32(immh) - 1;
     int immhb = immh << 3 | immb;
     int shift = 2 * (8 << size) - immhb;
-    bool accumulate = false;
-    int dsize = is_q ? 128 : 64;
-    int esize = 8 << size;
-    int elements = dsize/esize;
-    MemOp memop = size | (is_u ? 0 : MO_SIGN);
-    TCGv_i64 tcg_rn = new_tmp_a64(s);
-    TCGv_i64 tcg_rd = new_tmp_a64(s);
-    TCGv_i64 tcg_round;
-    uint64_t round_const;
-    int i;
+    GVecGen2iFn *gvec_fn;
 
     if (extract32(immh, 3, 1) && !is_q) {
         unallocated_encoding(s);
@@ -10178,13 +10169,12 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
 
     switch (opcode) {
     case 0x02: /* SSRA / USRA (accumulate) */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift,
-                      is_u ? gen_gvec_usra : gen_gvec_ssra, size);
-        return;
+        gvec_fn = is_u ? gen_gvec_usra : gen_gvec_ssra;
+        break;
 
     case 0x08: /* SRI */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift, gen_gvec_sri, size);
-        return;
+        gvec_fn = gen_gvec_sri;
+        break;
 
     case 0x00: /* SSHR / USHR */
         if (is_u) {
@@ -10192,49 +10182,31 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
                 /* Shift count the same size as element size produces zero.  */
                 tcg_gen_gvec_dup_imm(size, vec_full_reg_offset(s, rd),
                                      is_q ? 16 : 8, vec_full_reg_size(s), 0);
-            } else {
-                gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shri, size);
+                return;
             }
+            gvec_fn = tcg_gen_gvec_shri;
         } else {
             /* Shift count the same size as element size produces all sign.  */
             if (shift == 8 << size) {
                 shift -= 1;
             }
-            gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_sari, size);
+            gvec_fn = tcg_gen_gvec_sari;
         }
-        return;
+        break;
 
     case 0x04: /* SRSHR / URSHR (rounding) */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift,
-                      is_u ? gen_gvec_urshr : gen_gvec_srshr, size);
-        return;
+        gvec_fn = is_u ? gen_gvec_urshr : gen_gvec_srshr;
+        break;
 
     case 0x06: /* SRSRA / URSRA (accum + rounding) */
-        gen_gvec_fn2i(s, is_q, rd, rn, shift,
-                      is_u ? gen_gvec_ursra : gen_gvec_srsra, size);
-        return;
+        gvec_fn = is_u ? gen_gvec_ursra : gen_gvec_srsra;
+        break;
 
     default:
         g_assert_not_reached();
     }
 
-    round_const = 1ULL << (shift - 1);
-    tcg_round = tcg_const_i64(round_const);
-
-    for (i = 0; i < elements; i++) {
-        read_vec_element(s, tcg_rn, rn, i, memop);
-        if (accumulate) {
-            read_vec_element(s, tcg_rd, rd, i, memop);
-        }
-
-        handle_shri_with_rndacc(tcg_rd, tcg_rn, tcg_round,
-                                accumulate, is_u, size, shift);
-
-        write_vec_element(s, tcg_rd, rd, i, size);
-    }
-    tcg_temp_free_i64(tcg_round);
-
-    clear_vec_high(s, is_q, rd);
+    gen_gvec_fn2i(s, is_q, rd, rn, shift, gvec_fn, size);
 }
 
 /* SHL/SLI - Vector shift left */
-- 
2.20.1


