Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DDAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E32207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rONSTrnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E32207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboXr-0000JZ-Cl
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIU-000336-KJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:54 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:34317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIT-0006Z0-Lc
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:54 -0400
Received: by mail-qk1-x742.google.com with SMTP id 190so7915286qki.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LDQ6XQ/3vPiAN54mt6Pw+hfW8ObudV4rT2qqPEmK+8U=;
 b=rONSTrnGrSZ2PsoIrFLqBFuu6suHGbrMjX8uNyhMJMBGg035NputYOHa8h2uI8xtlF
 LOjjEFaAEKkn8SxHd9pFLcvc+FgVqlAAsvunyS530dGc7thTweLioc3xQRj6myQtUnLx
 CI32Z6rrO3nr72JWTeh6hFju0acnpQvitBwwDOgHgXCgLjooWqJ4mHqlHiphU/eby5at
 k/81cNpVH8haEAfc1pRSpJna3mOqwqfqMr5lAaGKf/+Md/yj69tA2eYbdD1ujFjUAwi8
 Lk08Cku5kOH1EfDrI8KUefdy7IkNzG49rii+8nDLJhIBuDwIXpN4P35dTiCr3dA0cXC1
 DeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LDQ6XQ/3vPiAN54mt6Pw+hfW8ObudV4rT2qqPEmK+8U=;
 b=uGTSVeXZrjtgJ6lS1WsqEVzJkTpf9trALB4MmT+FvLQoY3M9i261vfCyw8y0di2yaQ
 VWob3VglJdPmSjsuaU4g6KxsGUlmvG6jM1i5o8DLCFwD6MiHM2oI++uJoFw7G8hL5Wp+
 nFI0TB3Ts6Yml2oVIPbUx2VBBu6+4TYXklgVnaypDPFFA0CaRE11q6DfLl33iML0Ah0f
 tceeUVHVd1znBrraPni/A4AAYnQ2gX01J+PzLkiFFEcnVmjO4EyhLBGMy/VeRNpDLkOy
 MXfG1suSjgFTuwdcPnok/dFNd6rY/vyDwyAzCRYBhzlraNLPkWKb0jCjZ9otkP7untIj
 3rDw==
X-Gm-Message-State: AOAM531loOJiljYRFHps+dRj+G59Qib0PcirfnkmLMqfGSY1lf/8rNY7
 AbEXlqFJr3jIoQZT9xRBqr/hUdtqfnAL2w==
X-Google-Smtp-Source: ABdhPJxM86RQ5aNqp9UP/nL9z4Vei3jmWAjYFxbehbX9xxreBnli8ioe3TT9J5WNADneK2sbufq+eg==
X-Received: by 2002:a05:620a:634:: with SMTP id
 20mr10169315qkv.15.1590079432542; 
 Thu, 21 May 2020 09:43:52 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:51 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 28/74] xtensa: convert to cpu_halted
Date: Thu, 21 May 2020 12:39:25 -0400
Message-Id: <20200521164011.638-29-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Max Filippov <jcmvbkbc@gmail.com>, cota@braap.org, peter.puhov@linaro.org,
 alex.bennee@linaro.org
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


