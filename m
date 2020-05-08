Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B85C47255
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F56218AC
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6SPl4BA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F56218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7iq-0008MR-JG
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7ha-0006gA-IO
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:26 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hZ-0005lv-Kb
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:26 -0400
Received: by mail-pj1-x1042.google.com with SMTP id a7so4658775pju.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wot8cVjNfhYdwjbPEb/DRxN+VrYjwXPiNxtZudeESRQ=;
 b=a6SPl4BAn/u6jCrm6XqJHdrAHjpVXFoAQcKB2decqWsbG3SmEhgTtoYyGLJVOUYglj
 Q06YUEOE9nOdaJaklkLVw+2iE1vzXyPI0EkKxbfgTneQMMWSQ8VIF1ERemA0jkuARDYg
 azypeJjQfCpAfTBvFE9SR3WREJORrNuzxTPwOGD0w1fijgDPhMX1KFbotw9kH3NlR+D1
 qMEGZMjfCQKUa3G40TN2k951xRebs7jHvH3IsqDb3fQh3QVZjf5QZlpP+G3+vjcUmAi1
 jiLsW+8FW3fvkSwgK6AyfgpLwsntr4PrhjjQqxPfJr1ww9A/RTfoiCc/VZm6eobztx3n
 XZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wot8cVjNfhYdwjbPEb/DRxN+VrYjwXPiNxtZudeESRQ=;
 b=N2e/gU/TCMkZkK3ovRaCfHfOgqQMVNC93MWxG2Ynt2XZ1lqcL8KWLRnh/8PBtdB5wS
 jC+GuwnayQmGSTeOq1nPNhONbVQ5QYJ72NJsg8+VVMHKQh31ia8ybLI+Hrp0fJ8SoJju
 bWOOhXU7j54BroDiPTzDiXVbSj8CxX7ISuTki0XbNispCPaYx2vOvvA26SAshIr3wog6
 MhrUMA2SBtF2Q2Wl/kDFi9jwI2jwpUekS3vQ7ujtMUEbgeFJpjeG0Eusd5BkXYvV7yad
 j+aZ0Sxds1mqXoWp0vig5dDtgtHfS7pTsrbCDv+20gNIpYodO5lj3Vo6H5+SWvvqZa6T
 qAlQ==
X-Gm-Message-State: AGi0PuZa+vUeD2P09KFwymm2dTf2shyKRJZPLYVfuBS6DzFnkrgnYijI
 z4h3NC/lQ/Eq64wqskmvOmrldZAouW4=
X-Google-Smtp-Source: APiQypI86jPdYE9Pn22G47h9KQzRHGzUjAmUfjOcKMUrfk8CoEhwVFVxiXElF1h38xDv/EB4w/00QA==
X-Received: by 2002:a17:90a:20e2:: with SMTP id
 f89mr6773438pjg.205.1588962383862; 
 Fri, 08 May 2020 11:26:23 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/19] tcg: Use tcg_constant_i32 with icount expander
Date: Fri,  8 May 2020 11:26:01 -0700
Message-Id: <20200508182616.18318-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508182616.18318-1-richard.henderson@linaro.org>
References: <20200508182616.18318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must do this before we adjust how tcg_out_movi_i32,
lest the under-the-hood poking that we do be broken.

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
2.20.1


