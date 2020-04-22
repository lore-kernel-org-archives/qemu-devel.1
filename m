Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87AFC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8133E206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eepeh7l3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8133E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38753 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR48I-0005ky-LW
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41G-0001Pi-NG
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41G-0001hR-4x
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:42 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41F-0001eN-Mx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:41 -0400
Received: by mail-pj1-x1041.google.com with SMTP id np7so161265pjb.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/fduq7+z5S6wjChMKi9oJb/vmTzyRgenbcyuQtF0AWE=;
 b=eepeh7l3HyUvBzT1ZPXSW34WY1k+DFmtIsHfZZ7I5nvoOr7OnMFU3YjdPr6GYXYqoy
 c9tIrsdw8a3tkDgb3kTnwa0ITB14lWUGW1hssACq+ig5JGeUCFNPnLoA2zEpIrwbptk2
 aPBQVmM7DozoBlRIAELDKzMp1O3i0Gj9XldEqa3+bFPTIQXd7RXDfvrMr8SSpKm767Pr
 z4afFFHInEQfP6ufaw9Tr6s9yk+6+gMgaxnnXmEehlsIHty5OUbbNsb/BDdC8sjRr8Ud
 G7Udl6z/ZNBCswye0rIy9KHJr10NyFCtpEwmZnhJ6qeA2KPfXBtx55JM6Pbebmr1KBTu
 qElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/fduq7+z5S6wjChMKi9oJb/vmTzyRgenbcyuQtF0AWE=;
 b=eee5yeexsVuOlcSYDo0kfMdpuHQoJAvK2mPROtay138bN1qSN5KJR8EeRZ5jz9WrOX
 Ip2c3zFuRtwu72vwGPhYkxzIRwRWgCW7L0OR5Nb4d2cGHLRPRXUimJNj1e6CDmfyBhL6
 yqvEvImil2RnUsDfVbX50OigLb8m8UYXaCaCVxAFO7/a2mfQYhcSsBL9MgPY2jdhjEvL
 VPbDBe7z/cTgCH5vpxhtR62X2VY9zDCgx/f8T/itfSP4ctaknQW6NF3UPkkxDkkML4m5
 7ko3JOXnAN5iz6/esBH/lIu+liviqYijZLc/tdsXl0cMVqHJzijEdxC1U8TmwxfVL72N
 tvAw==
X-Gm-Message-State: AGi0PubOTriFOAE19ZpAdoR2DH74T/SF2f33il+7ozmzMnh1qINBKn0V
 kKj3glvKrydk18THYbm8ZjW13iZ+z3U=
X-Google-Smtp-Source: APiQypJe8mOZ0NjiNaLRsLik3PphXJlynuK1S4JOND1OIk7XBpr00ATvBSjanygf3W4EAfAqwpLDtQ==
X-Received: by 2002:a17:902:aa43:: with SMTP id
 c3mr12411135plr.7.1587518259985; 
 Tue, 21 Apr 2020 18:17:39 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/36] tcg: Use tcg_constant_i32 with icount expander
Date: Tue, 21 Apr 2020 18:16:58 -0700
Message-Id: <20200422011722.13287-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1041
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


