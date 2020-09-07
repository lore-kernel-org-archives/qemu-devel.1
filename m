Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F6C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46933208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPtdMp7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46933208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLWq-0005KV-BE
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVp-0003hh-Cx
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:05 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVn-0002N3-IM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id 67so8311106pgd.12
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hA0Q3ZvS9ZMt8mExwk35iB2Bwjpw4Nf408fgP9XSgOU=;
 b=rPtdMp7eNJz5keoSP9ZEi4Wvjov67zAX1y66sVpZQJmBcEDLqLW33k13E+ZegVMgJO
 8LIVG81bPdD/rwhqb4mYPU4+Q/vjN2edtfwF4vBR6ZYVWCPnd692socGIcZ0Aw+9bGuF
 Z4TEay5jXhIwuoE4IV5NaoxNu4FM4V4YX42IV+zhR62BY2Q0meokYw6gGkyOsgX/zypP
 NZYlKgZqKo4/sIap6ibr5dy43SI9oOYBoCkfFtupAoaYY7cuxbVmHFmqRuFE/hKBvRbC
 TXlhg4Dd+D9FDKZEySjRklZYG42r1kNvf7XyrNuYvalxyt9flLo0gKtJwERlzWRJrdiG
 RrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hA0Q3ZvS9ZMt8mExwk35iB2Bwjpw4Nf408fgP9XSgOU=;
 b=GXI7OTWE0Fd9gv4tDaHULNz1Tzy/PT3czl/mhnOT4PHlekOcI1iji1Y5GmpbhpIBvK
 ikz2zYIeWe4pDsoZCcTBXS9GyHkTQUPPSMCY6wuco8QFNIGuTGJyv1cXc05U9zjcAKRd
 bTOwYI6u/s8U/EXdC8IZUk4Ae1PrfJXiR2GtxlUQzJ/ogQ9ma3kB8XYuAC8vUyiCHJ4L
 sivkhAj4cNpeyYuuCN/DMwN38+grCYK6CqjrNVEyCw/f5TN/O73IXZjs2SVX1QITqUg8
 c6O4ZhUVpdgpcQolGoCX8FPUl1xzbiPtyqzOKmpjy5+ifbgPXWs85onF81kJf8FJoL+H
 mFuA==
X-Gm-Message-State: AOAM532DZ7y2fAB1ZS7m1QMdRyhLuZmNAEw5tbT2M5oyJet13BAC9sCN
 L5fxeq/DAiEp2XmNmdqDp6REUm8vm+YXmQ==
X-Google-Smtp-Source: ABdhPJx7EZegicwKi+NS0uImtPeBsNWUtIKAp8qlOZxrNtCbVjjdVK37nVKwq/Rf8xaccL7yH3fS+w==
X-Received: by 2002:a63:3ecb:: with SMTP id l194mr2213855pga.394.1599501901561; 
 Mon, 07 Sep 2020 11:05:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v6sm11367768pfi.38.2020.09.07.11.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 11:05:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/19] target/microblaze: Use tcg_gen_lookup_and_goto_ptr
Date: Mon,  7 Sep 2020 11:04:50 -0700
Message-Id: <20200907180459.29025-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907175102.28027-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Normal indirect jumps, or page-crossing direct jumps, can use
tcg_gen_lookup_and_goto_ptr to avoid returning to the main loop
simply to find an existing TB for the next pc.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index da84fdb20b..d98572fab9 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -147,7 +147,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
         tcg_gen_exit_tb(dc->base.tb, n);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_exit_tb(NULL, 0);
+        tcg_gen_lookup_and_goto_ptr();
     }
     dc->base.is_jmp = DISAS_NORETURN;
 }
@@ -1803,7 +1803,7 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         if (unlikely(cs->singlestep_enabled)) {
             gen_raise_exception(dc, EXCP_DEBUG);
         } else {
-            tcg_gen_exit_tb(NULL, 0);
+            tcg_gen_lookup_and_goto_ptr();
         }
         return;
 
-- 
2.25.1


