Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51AEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A345821841
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOARYgXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A345821841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfPL-0007lW-SW
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE6-0003GF-DH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:06 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:46789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDy-0008V0-5e
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:06 -0400
Received: by mail-qv1-xf41.google.com with SMTP id cv17so1737085qvb.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LDQ6XQ/3vPiAN54mt6Pw+hfW8ObudV4rT2qqPEmK+8U=;
 b=HOARYgXfUN1w6kPg1m35xgFG7+zdTYVR2nuOJfUhF1lcd1PQVx1xDUlhNG6Hho4Xnm
 GVQqebUe69kQxHIcnR24Sc30EfbV8pOtG0ihqc59NGKxF59U8KpvsUePe4H+B+45lQcd
 YiP4zPsVGZ3sDnwGggTRReCkaHSl7oJQ3s0H/Lm1iGqW3LnT4d3va+1FnZKYGSindyty
 cgWN7fmwWXp4UFJQ9xB/E90NSGfALEqNzJLcbDZ/BhOx1q0nUzAirR3s7UK3awqPZvFe
 MUDX10Ii/CF1E3ptvGFYXFft7otsDk0iWDElUiP1f5fMBY181D11SP7vj6XQamALVFLi
 vRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LDQ6XQ/3vPiAN54mt6Pw+hfW8ObudV4rT2qqPEmK+8U=;
 b=e82BMz5uG3hQRVJic3ReEwz4qV6K+jEGolCClFT8cm3MTCFR+d1ZC0roBZr8lXThYT
 D6rRLI6zUtYIkEfMExheivVYkamOcm1/Yw1c5uvL2sy4CgRUiaQHAowlxFIKmfFn3BP0
 A7UvemrbExrpmX3bl1V9KA/7o8zWPWJnEHBru0s8Ti6QYJ+1D5LM83NPpK711cPTUIvM
 3ZQNpaE/osfZqDO3vVEGzUACAbH+sLDHOu/KtQ/+ltfBjP+v8szZryRXNv4sxUioaXDA
 cWmTdAlBW/aIbO8K4+W+8h9RPz6Ldr0TDjMmibKCscGTTdLsKf/SgLotMtKJeTeqRu2q
 gM1Q==
X-Gm-Message-State: AOAM531sPCO9dUULror8NWCXxVa3e0ysqRse8W+adKzOFL4V+aK8zkI6
 OKHJwBJjgd0h1pdQcCx+jX+KHxgsTzA42A==
X-Google-Smtp-Source: ABdhPJxCw0A9I66SY7k9zYJkAvR/W4PwZLJQu2LBYzBCkZsdUh3HOeVhFNqoj/obmC4VuPjji0+Vzg==
X-Received: by 2002:ad4:46a9:: with SMTP id br9mr554986qvb.246.1592427835455; 
 Wed, 17 Jun 2020 14:03:55 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:54 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 27/73] xtensa: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:45 -0400
Message-Id: <20200617210231.4393-28-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/xtensa/cpu.c        | 2 +-
 target/xtensa/exc_helper.c | 2 +-
 target/xtensa/helper.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 82c2ee0679..fda4a73722 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -102,7 +102,7 @@ static void xtensa_cpu_reset(DeviceState *dev)
 
 #ifndef CONFIG_USER_ONLY
     reset_mmu(env);
-    s->halted = env->runstall;
+    cpu_halted_set(s, env->runstall);
 #endif
 }
 
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 601341d13a..01d1e56feb 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -115,7 +115,7 @@ void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
         return;
     }
 
-    cpu->halted = 1;
+    cpu_halted_set(cpu, 1);
     HELPER(exception)(env, EXCP_HLT);
 }
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 7073381f03..031a14cf86 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -328,7 +328,7 @@ void xtensa_runstall(CPUXtensaState *env, bool runstall)
     CPUState *cpu = env_cpu(env);
 
     env->runstall = runstall;
-    cpu->halted = runstall;
+    cpu_halted_set(cpu, runstall);
     if (runstall) {
         cpu_interrupt(cpu, CPU_INTERRUPT_HALT);
     } else {
-- 
2.17.1


