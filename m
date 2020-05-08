Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D859AC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A559B21582
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kP9vfsS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A559B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4rM-0007yV-Kv
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lA-0005gS-I4
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:17:56 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4l9-0002r4-Jz
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:17:56 -0400
Received: by mail-pl1-x643.google.com with SMTP id t16so844274plo.7
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/fduq7+z5S6wjChMKi9oJb/vmTzyRgenbcyuQtF0AWE=;
 b=kP9vfsS6mU+w+/s0cHojKrgYZX0+o6QqwSBs8wunPn1MvkbWx2387Cz4cDvLwauMap
 LBHILrwniX35YH5+itqWily8s7m51BF1PHCM2eSRs15TnXW/hTK19rfLjdlgAXdxJD5T
 XlI3g6uygR9ugyFmJz6W4tR1BI5jn7FTn2S/i51eOfvM8bdhf4amXiP7QNX6zi52xhvP
 GabF3XYSLjHhEFj4YZ3r0y7KyuNZcGxrn69Bd6sOyZxd3lh1JYKGQ+zn/mYgjgTA46uu
 v6FXauhDUW5UC4XuUknEU4jnzxhLbfXIqmoD7dpyjUzkPs5L2pE0eeTrqhuW7YBo2WyQ
 1z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/fduq7+z5S6wjChMKi9oJb/vmTzyRgenbcyuQtF0AWE=;
 b=PAWSsoG0jh/0U8UpQlBMXp2d46ZsIEoGWNYuK2WALBJtHKkRccHpNWp2DCCrku5U47
 1UQ+ceroGQDVO3GoJnXJuwdIrRDPhMHsYjYSqARILESQo42h8EvjKvHkcoqWBm4+s7co
 3MdFMnBohdQf9twYOdqAYE2UPtJCC/0u3UYA/x4/BFP3UkgJ/uhmoWBadcBpVLhRvsAm
 +brFLY8oDCOY6VYkx+0YB4Xe7hnqln0QFcQNK3QUx2kJtwhp9uB6XRc2lv+iUwTzeprz
 smOLbqqDKdoNHFZQ1nWgjIJC86ZplrhPhWG25YbMdNm+YrCsZ7BJWEvVWMhIdn4aBUKH
 38Lw==
X-Gm-Message-State: AGi0PuZ6F1xUcXwRvw2MrvrQAALqJMtwJI6Kc9sgLqrgjK/dad9aBN9A
 pD2GA8y4SrJdoDHWprJ0yG+5nzAZgYA=
X-Google-Smtp-Source: APiQypJDjSCpIafh6/81aN+t0Bn+jtlPZ6co2pCf9FpSgDf2WRBoA/JjT/OvtpRZrOA0G3Q1rIFV/g==
X-Received: by 2002:a17:90b:8c8:: with SMTP id
 ds8mr6546551pjb.164.1588951073860; 
 Fri, 08 May 2020 08:17:53 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b5sm2125933pfb.190.2020.05.08.08.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:17:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/19] tcg: Use tcg_constant_i32 with icount expander
Date: Fri,  8 May 2020 08:17:32 -0700
Message-Id: <20200508151747.6166-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151747.6166-1-richard.henderson@linaro.org>
References: <20200508151747.6166-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must do this before we adjust how tcg_out_movi_i32,
lest the under-the-hood poking that we do be broken.

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


