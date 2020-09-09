Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10859C2BC11
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EB62177B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDMoKmOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EB62177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnyo-0001xu-Km
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnne-00004v-1e
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnc-0002GQ-4Y
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:21 -0400
Received: by mail-pj1-x1041.google.com with SMTP id jw11so439080pjb.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mEMZJyAsz2pya7wCS7q3Y/mkN8EK0RWNbiEA9tVJa2o=;
 b=hDMoKmOZUUGjVln1k5ny28MW96Qbh1XTQSp25eRLt+a78DImCkAPiJQgIN2hcVVDfv
 xmcvps+GOLKl1faGvT4WTqnivlv2yBgxbFSmf5rTj1BS5hKosDSI2wn0JyUaQE63yRB9
 cw8Ot+FYm1klluQTT31LqBYNdNBbzaRQzJ92Po23qva4Z1VZ5RIRohmn4s2Q7wppnXf7
 td7oKvhzO9bq38+AzDJDWFOexMDf1KCaoQQnsmvtMPVilWybzKxKa0AXbD0K7c9k5iha
 iULI1fhNgAZp9CKyBePgcudI6R0rrDM0/qTzGRpPfc7DKkNgrINFG42w0SGVk0yTPkBs
 +GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mEMZJyAsz2pya7wCS7q3Y/mkN8EK0RWNbiEA9tVJa2o=;
 b=MSlQkxwda2HqwzKkQ87r7FyYQ/WxMCAox2V3870geRrDubRVQOzS6xryXPu54+icKt
 AT+0HngjIkcSxbKyNXG6Mr4MGUPGHQdXIQiW/Uxp0xBUS9OpRf5Zy0KfRLQtdYIb697Z
 OK1AM2mC0i6WxpjlEGEgzc4Yo4c+6i1RtuGBkvNrq6IOmdwegX5N0WGKApADBDSY6MvW
 y2DM7MwIZbm7OhoNo0BVmHlsh0BErDkiRHD2/CfScfOMKzzBh1iBNg/28PkKd75Db7eI
 axdG7ElfHZoQ4z/FY+vhvlSSVHSPmlOgWtmp9MM8MTGD2n82xDsUVp/+U1UmrIgKGuin
 Xh3Q==
X-Gm-Message-State: AOAM533iYMN5s1N2Y5gyg/xcG67KfCl5TYiXOEJ7kfMenHa5PCHeOeNP
 Io0KbLam/USAhbMVJ0hBlxB/HpWl616ysg==
X-Google-Smtp-Source: ABdhPJwbpkwH/Ey5v5/dI/eAejll310wRfj6G6iNTTLbdeF/3HdJIFg+8gOK6mkathsSiQ2VB5A3Aw==
X-Received: by 2002:a17:90b:715:: with SMTP id
 s21mr1128445pjz.113.1599610638255; 
 Tue, 08 Sep 2020 17:17:18 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/43] tcg: Use tcg_constant_i32 with icount expander
Date: Tue,  8 Sep 2020 17:16:27 -0700
Message-Id: <20200909001647.532249-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must do this before we adjust tcg_out_movi_i32, lest the
under-the-hood poking that we do for icount be broken.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gen-icount.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 822c43cfd3..404732518a 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -34,7 +34,7 @@ static inline void gen_io_end(void)
 
 static inline void gen_tb_start(TranslationBlock *tb)
 {
-    TCGv_i32 count, imm;
+    TCGv_i32 count;
 
     tcg_ctx->exitreq_label = gen_new_label();
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
@@ -48,15 +48,13 @@ static inline void gen_tb_start(TranslationBlock *tb)
                    offsetof(ArchCPU, env));
 
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
-        imm = tcg_temp_new_i32();
-        /* We emit a movi with a dummy immediate argument. Keep the insn index
-         * of the movi so that we later (when we know the actual insn count)
-         * can update the immediate argument with the actual insn count.  */
-        tcg_gen_movi_i32(imm, 0xdeadbeef);
+        /*
+         * We emit a sub with a dummy immediate argument. Keep the insn index
+         * of the sub so that we later (when we know the actual insn count)
+         * can update the argument with the actual insn count.
+         */
+        tcg_gen_sub_i32(count, count, tcg_constant_i32(0));
         icount_start_insn = tcg_last_op();
-
-        tcg_gen_sub_i32(count, count, imm);
-        tcg_temp_free_i32(imm);
     }
 
     tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
@@ -74,9 +72,12 @@ static inline void gen_tb_start(TranslationBlock *tb)
 static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
 {
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
-        /* Update the num_insn immediate parameter now that we know
-         * the actual insn count.  */
-        tcg_set_insn_param(icount_start_insn, 1, num_insns);
+        /*
+         * Update the num_insn immediate parameter now that we know
+         * the actual insn count.
+         */
+        tcg_set_insn_param(icount_start_insn, 2,
+                           tcgv_i32_arg(tcg_constant_i32(num_insns)));
     }
 
     gen_set_label(tcg_ctx->exitreq_label);
-- 
2.25.1


