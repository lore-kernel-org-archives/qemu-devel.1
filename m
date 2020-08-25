Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6A9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75192206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyLDZy3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75192206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgfq-0007mG-Po
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4K-0000cC-6v
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:24 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4G-00022X-UH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:23 -0400
Received: by mail-pg1-x544.google.com with SMTP id m34so7663753pgl.11
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kCj2p6cdsHJiVaOy7fcU1XDToXHd7PgB9wDLfRyOeOo=;
 b=iyLDZy3wBLwPhZmiHBAYc/WrUacj+U3Brb76I1xPjhUvDlp9NIc9mko/K4JhM74Y6j
 FvB6t30ElGJlmryON6dyfr5f9a5XEopyPKgyg0bLoodaalqiHWt/dGdGDfN4OxRkharH
 BlgGu0mm35zhLxrAST9aXjbGC3W7N3DRsm20AA2HKYmg2yFCzooVveQdkaHoVCI9X2F0
 I1cw2S/PHQs9koepRJ/vBQ74BbsBuj8pQt2r+FFvrmfjG8xs3/WmcnO4geEmJTM7VLZ0
 8pVI1jqBeSIbkzhvmIhMTEuWvyEZxmd6vjplebwbtsc15yEhNNGCy1CFGghtpUYtEC48
 hrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kCj2p6cdsHJiVaOy7fcU1XDToXHd7PgB9wDLfRyOeOo=;
 b=WgoAP2hQ3l41bz9PR/zLbdY9+onD15q1KWwdpdvZMmV1pnE3jGGuRk1kOJNU10fk3S
 vGLBih1em7e2u9b/BnBg+OGYBIh+JKYSjSYwbSh/KLZ3dUo4ZXCw2w6/YqQGwelHXtbR
 X+pOHc7P7GaE6/Pb5RUrhNiND8fOXwoffqlWdVq9+vcBQ71xBVK1zB9T1KMXsVaAt6N+
 2G3FPDnJ6BxdzTo+wVhqOp+bcQjiU/SMStCOm+S+gV5lENFr8d6YIuebHq0S7AuUAj1c
 P1YO/rBVPVnBzb7OPKr3INU+zbORMXGsKxpCiNPUKhDl4xDuOwjxhLVoYs5bBrGhr9L1
 dIng==
X-Gm-Message-State: AOAM532ZO7BJmwCikYfzS1nbmr0ySpn9ooKL2x788BumXCD7hsdT3Nm1
 Iu4aBp/Rj3Z9run5K/ikIX/VD2dQG8Iqtg==
X-Google-Smtp-Source: ABdhPJwPCYJbW1/+LoAXnWfKCZI6Ymk1YvtMFB0pqSX6Jv9Dc74iQ1U56/OpCzYhp/n8f24R4ZzKwQ==
X-Received: by 2002:aa7:9ec4:: with SMTP id r4mr9368631pfq.48.1598389279162;
 Tue, 25 Aug 2020 14:01:19 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 66/77] target/microblaze: Use tcg_gen_lookup_and_goto_ptr
Date: Tue, 25 Aug 2020 13:59:39 -0700
Message-Id: <20200825205950.730499-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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

When goto_tb cannot be used due to branch page crossing,
or due to indirect jumping, tcg_gen_lookup_and_goto_ptr
can be used instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6f9b20d391..5bd771671b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -152,7 +152,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
         tcg_gen_exit_tb(dc->base.tb, n);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_exit_tb(NULL, 0);
+        tcg_gen_lookup_and_goto_ptr();
     }
     dc->base.is_jmp = DISAS_NORETURN;
 }
@@ -1811,7 +1811,7 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
         if (unlikely(cs->singlestep_enabled)) {
             gen_raise_exception(dc, EXCP_DEBUG);
         } else {
-            tcg_gen_exit_tb(NULL, 0);
+            tcg_gen_lookup_and_goto_ptr();
         }
         return;
 
-- 
2.25.1


