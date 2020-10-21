Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D6DC55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7B32225F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9kPexY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7B32225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIK9-0007Gk-Tj
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3v-0006ZO-7l
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:11 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3j-0006Ry-2O
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:10 -0400
Received: by mail-pf1-x444.google.com with SMTP id 144so1896690pfb.4
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zVLgn+OX/nTD/oUAFauTpXTtA86xiUG6+rSs26rONZM=;
 b=U9kPexY1nq/Hm4lw3Fdn7NfTqK8WOKYh2ekN9hMlZ7HWdAVNSVnYRQV4eoFcIHqxiD
 99qOzJrBn/7FAKZ/M9ioZn9YHz6yEBxJtPb9p8XeBk1dUhsEQOmB7k2lIUciDKQOPNsN
 4id0kXPWtHQVkBXmgQIMXQ6tWXmsmBJ/1m+79VSCmRTlyQvtW15dTMe+73bIwpYpl0ja
 onTzwNsd1SDtYt6v/9wODD+EwFKGbolBH3cQtYMRPc+iUxXDPKZi5FpG35smlttpc+xM
 GN0qpi2EoBpC1Qikn/14VEDZsnQMisSTHYoXYlCdwmmfP8Q3K010kVYbGwdC3OkK1axw
 MmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zVLgn+OX/nTD/oUAFauTpXTtA86xiUG6+rSs26rONZM=;
 b=Vuun4ag1GQ+hAT+qB37i/pwh8l95rQRn5vWadnSagic4Q6TS9H3FM6zufBndE1Sg/j
 P/V4CSh8XE1pRUpEOkvZ08ibz8rdHtjYXu+qB/x2GTn+Q2j5T4+6Mun3q2HGFovrq/fi
 jk+TsY/Dx/lH7Y40UUQ9lMQfEDile273G8GBzyBPWu8GwZYvZVrCubVvUPf/ufyodgJL
 uMNl2E6fWIDLErCDRScnW221ENPhGbCHPXCu90MUghm9oFh74nJajMonSlFk7iWLkdbm
 2USlE0E3MQNuBV7nUu4dQZXpiNaiZ8K/HByRxv5PfKnxMtycJUm4mP0Y3/MC7LnH87hL
 03yQ==
X-Gm-Message-State: AOAM531SThGOAPchhKf+X5oO75j17i4yvSOksR2cPiX1GMlviZrEzOwC
 bLa5Kvt4vzQOpLjAvsj0kBRxJ6UON/gmRQ==
X-Google-Smtp-Source: ABdhPJwCYAERfmWmBaVj8bAcgnZiCEfoD7CoC1O2GHqSRO05H2Q/DzUDKZ2G648fH6l2BVURIT6sjQ==
X-Received: by 2002:a63:160b:: with SMTP id w11mr4365669pgl.110.1603301872971; 
 Wed, 21 Oct 2020 10:37:52 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm2928829pfh.9.2020.10.21.10.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:37:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 01/12] linux-user/aarch64: Reset btype for signals
Date: Wed, 21 Oct 2020 10:37:38 -0700
Message-Id: <20201021173749.111103-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021173749.111103-1-richard.henderson@linaro.org>
References: <20201021173749.111103-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel sets btype for the signal handler as if for a call.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index d50c1ae583..b591790c22 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -506,10 +506,16 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
             + offsetof(struct target_rt_frame_record, tramp);
     }
     env->xregs[0] = usig;
-    env->xregs[31] = frame_addr;
     env->xregs[29] = frame_addr + fr_ofs;
-    env->pc = ka->_sa_handler;
     env->xregs[30] = return_addr;
+    env->xregs[31] = frame_addr;
+    env->pc = ka->_sa_handler;
+
+    /* Invoke the signal handler as if by indirect call.  */
+    if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
+        env->btype = 2;
+    }
+
     if (info) {
         tswap_siginfo(&frame->info, info);
         env->xregs[1] = frame_addr + offsetof(struct target_rt_sigframe, info);
-- 
2.25.1


