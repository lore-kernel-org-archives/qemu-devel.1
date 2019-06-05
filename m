Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FA2C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F312075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoIeqPmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F312075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYd8q-0006Ea-Vm
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:08:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYcyB-0006A4-Lx
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYcyA-00087R-9p
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:15 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYcyA-00085J-5G
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:57:14 -0400
Received: by mail-oi1-x243.google.com with SMTP id y6so59282oix.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=VGvFhyg+EUZksh+VTROd86GaO53VcnzMT3R6u6jPQAY=;
	b=OoIeqPmZjHB3rL9pqVkgC//djxrxRKMbvTLI/lNj/jUKtpVZU24+DJwHFfk8rkB9Et
	7VZQU9GvIwyFNUNQPGcg/9eZOzeoBIBK983oq242StsYqiZ//A15cr/9Afk+f4rxa4XB
	lYxTPX/3mEyYWtPYY23n1eqvuhL/Gxnl7drwrlPsrThBz2/Cdt+0Gbo7+JcSMohL32uc
	KmQOxb9+xAszytdDLr+/TbaKY/r27in9EW5QvLNcH6YJrgzYcKWQbNS8BSXrhoLfzJog
	UvSZaazsPsbp/cpi5i+WyC49uDxok4v9bzoPw685T020BnOWZkmNao9ZCerC8zeR0alH
	8yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=VGvFhyg+EUZksh+VTROd86GaO53VcnzMT3R6u6jPQAY=;
	b=da7zeKHRXv186AJGtKi31/l6LP6uxkKJAxU+xwy2HthsCANmrYOFySs0/jZE07WCrB
	OSAValXkCp/nsv3/2MXF/4KjWjsWH7VOfjmJt0YUqEhveuwErIR77dm+xW2dZlH4BSzX
	Ng+IUlmdASFRE9njkpwpE3loiiPC0k6KgJo30cfyKLpoC5+ICZcMhB43cgI07YAWRE3z
	bwmr1t+rM6m2ECQ/y+sF21WNucp/pczsg2p2Rd8Svfb2+pjZ/I35VmUss9TFKlM5U0CY
	oPi1U//eMYWYtTaFko7SlE+KSIeIRxSDbGqDu944ALjJJi0NWgvjcE3cJPW7zUwWIj2J
	zgvQ==
X-Gm-Message-State: APjAAAWKTAXwM7DdoDm1lea6WWNIqOTnYVgf9v8Xb+JtAhBJQ3Vho9r1
	lqQBFayInSGtsDcZQTyAlZ7ON43a9yulig==
X-Google-Smtp-Source: APXvYqwDZlSJHeOHpiN3BzzPI+pVdj83ZReu7U2U08ZNM1z8tN8XzHbbvjthjb70jMuGvmVjoxaHgA==
X-Received: by 2002:aca:ef43:: with SMTP id n64mr10168835oih.79.1559768233178; 
	Wed, 05 Jun 2019 13:57:13 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id f5sm7414155otl.51.2019.06.05.13.57.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 13:57:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 15:57:01 -0500
Message-Id: <20190605205706.569-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605205706.569-1-richard.henderson@linaro.org>
References: <20190605205706.569-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: [Qemu-devel] [PATCH v6 1/6] linux-user/aarch64: Reset btype for
 syscalls and signals
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The value of btype for syscalls is CONSTRAINED UNPREDICTABLE,
so we need to make sure that the value is 0 before clone,
fork, or syscall return.

The kernel sets btype for the signal handler as if for a call.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c |  7 +++++++
 linux-user/aarch64/signal.c   | 10 ++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 2f2f63e3e8..1f68b13168 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -86,6 +86,13 @@ void cpu_loop(CPUARMState *env)
 
         switch (trapnr) {
         case EXCP_SWI:
+            /*
+             * The state of BTYPE on syscall entry is CONSTRAINED
+             * UNPREDICTABLE.  The real kernel will need to tidy this up
+             * as well.  Do this before syscalls so that the value is
+             * correct on return from syscall (especially clone & fork).
+             */
+            env->btype = 0;
             ret = do_syscall(env,
                              env->xregs[8],
                              env->xregs[0],
diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index f84a9cf28a..5605d404b3 100644
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
+    if (cpu_isar_feature(aa64_bti, arm_env_get_cpu(env))) {
+        env->btype = 2;
+    }
+
     if (info) {
         tswap_siginfo(&frame->info, info);
         env->xregs[1] = frame_addr + offsetof(struct target_rt_sigframe, info);
-- 
2.17.1


