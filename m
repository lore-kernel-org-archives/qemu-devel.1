Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A890EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6981920738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8Uu8iDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6981920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgMG-00047v-JE
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3X-0007kU-3v
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:36 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3Q-0001nR-Ks
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:33 -0400
Received: by mail-pg1-x541.google.com with SMTP id g1so3877987pgm.9
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vRHfeWYe4t2JOdjOnGDnZu1tFFPEQawCvJ5AdLU8/XA=;
 b=B8Uu8iDoxOG0+lWySO7Vk2GvwdOBihkCDODrs9X9UigfE4Vv0JHSggtZGBbSCYZexa
 w5AqSeJSQWg1CcRuZRI5naiMxdfY9MrJOVLe+DX8/1JiLWkkTUp55Se7GFTlO+ROPXM3
 UJvVvDF81tPiMVO1m7odPomrnssmnd9RJ9QlGHgtOYl3WW6of41q5ECbyz7pcmy1hPUL
 gEpZWK2upfkYY+R6mVNSqOEB2w3z7nUtZEEZPvkEqJ+LAK63pvh4BngYyBUq2J+4HdvZ
 kaapqEnoP3pIz96euGL1+bglT7bAQRWd0apfClM4MT1P1sf6SgqWnrztbJQKS/CNw12b
 EiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vRHfeWYe4t2JOdjOnGDnZu1tFFPEQawCvJ5AdLU8/XA=;
 b=mqtLwGG9blg7fIFyxGJ/vXQK2oCX4bhlTWUyKaSXWsg+19B4bWipCiKxLZt9KJRD8W
 /i0JXW1xu5brCoWU5J/zw27zwKBcBd9i/V7Mi81UGAAsqljHsaFD3Mbm290PG6igamj/
 WYHkQR81o/1X3rDOP+s91rhYosCeGnm84er/aj2c2ODh9xjXadKeEvivO7r31Tg8kZ5w
 LoDwP5oSC68I7/MuAjtGU64zFyIr92QJgjAzqsmcDV6w5OPFvG0jpmjYGw7y/AhmLRlz
 yC3SMf6nZaZHhATiS0ReyTha5kkfDK3Dp464XQlStnll5ZizufMQsjmQDaZeoAYFlTUf
 EwNA==
X-Gm-Message-State: AOAM532sbC9e+NII1Q+CVEaqeKODnSixMoCr+jFxbGFLAyrsEmApk18B
 HTRS6dJth7LvYuDF8EmXaqeyd2dDWm315g==
X-Google-Smtp-Source: ABdhPJw9V17b6eydCwKxrg3p7YnuUnuRDWWIegdCFgcNGFMjeACimgbU9XifywY6F3behHrJAoTkuQ==
X-Received: by 2002:a63:4859:: with SMTP id x25mr8122986pgk.422.1598389226851; 
 Tue, 25 Aug 2020 14:00:26 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/77] target/microblaze: Check singlestep_enabled in
 gen_goto_tb
Date: Tue, 25 Aug 2020 13:59:00 -0700
Message-Id: <20200825205950.730499-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not use goto_tb if we're single-stepping.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 53ca0bfb38..7d5b96c38b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -140,7 +140,12 @@ static inline bool use_goto_tb(DisasContext *dc, target_ulong dest)
 
 static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
 {
-    if (use_goto_tb(dc, dest)) {
+    if (dc->singlestep_enabled) {
+        TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
+        tcg_gen_movi_i64(cpu_SR[SR_PC], dest);
+        gen_helper_raise_exception(cpu_env, tmp);
+        tcg_temp_free_i32(tmp);
+    } else if (use_goto_tb(dc, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_i32(cpu_pc, dest);
         tcg_gen_exit_tb(dc->tb, n);
-- 
2.25.1


