Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61953C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290902173B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ej0UQFe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290902173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36192 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOwIP-0008UF-GS
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:34:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBw-00031X-1V
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOwBv-0001T7-90
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:24 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOwBv-0001Sw-3g
	for qemu-devel@nongnu.org; Thu, 09 May 2019 23:27:23 -0400
Received: by mail-pf1-x441.google.com with SMTP id t87so2423003pfa.2
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 20:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=rcqQ5gZYdNhdYCOJ+I4S1mR1Qz6k+Xi4o1Wh52SYzeo=;
	b=ej0UQFe4T0IG8uCDEXGBKcgijTK5WJKqQYejGlybedav4ebsRY+aX/qjh8fu5SBdvp
	PfLyPTBTBk/34NeOPt70DCH5+5vl9xRVvtFox+XhVzl0IPjGzrTJSvEH0Z70Lzx9/YbO
	yDzdsaPMa4ZMiI+KiZK3/sN4ghV5qXD669tjbfGrzDDjw2w7/D1rmdwvMumVa7jq9HGH
	h91vAGxPZbQJlq1ZImU/oh2wMjyv60HI33I9WYUXPzs6N7mHHzncZ9GedjfyZ5WdAwc0
	zQ82TBEds158PmuEuTEWcjLqFcZiAImCT6rHf0j2AjAbwlK4xrQmY1Av0adXTsFUEvry
	vUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=rcqQ5gZYdNhdYCOJ+I4S1mR1Qz6k+Xi4o1Wh52SYzeo=;
	b=V/wKb9dRmXD+s5NtLM5ye5kS865h/Ylf/X34r/y4NGorSJRmGoDHXMjarXpWO80Zgu
	tthCWXPyXytinNs2amBRmm79uJirNPIa/6Z0c1ILy5t7burUHTcGvrUC0xgJgJJEZd1H
	9AudL7l4wRH9OOXxdmCsikXtLqVuztK1dvR4S/iS3sZQyFshx/NOBJ1E4aCuiFXxYuuC
	eGN4EUiG+Wt7DKdC1CYFpKEwz5ujHTvjPVysEYQi8qbzewZm4LWMogFHK82Yy0Xv+GRC
	8rOnG2tcdSxNchZhZpnvjGLrRTcoYhcwc6AgcBldpweJnYziBnxQZ93Mx5OP7XErGrNQ
	EcFA==
X-Gm-Message-State: APjAAAXGyZesn3WF6/N8humBMEqz2t9a4Km2xhlUMcKseha1ePekvS7j
	+MWJUNjvqUPkU+Rsifh4/sQaay1GZn8=
X-Google-Smtp-Source: APXvYqx/VWcPw43nD+s3P1bGuPfv7IkCz9Z43BTGEJ9Y4sXENIT/zBxqPUEYExdpRXK5wDqcTIF0IA==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr10647385pfm.191.1557458841783; 
	Thu, 09 May 2019 20:27:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	t26sm6259695pgk.62.2019.05.09.20.27.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 20:27:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 20:27:09 -0700
Message-Id: <20190510032710.23910-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510032710.23910-1-richard.henderson@linaro.org>
References: <20190510032710.23910-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v2 7/8] linux-user/sparc: Flush register
 windows before clone
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As seen as the very first instruction of sys_clone in the kernel.

Ideally this would be done in or before cpu_copy, and not with a
separate explicit test vs the syscall number, but this is a more
minimal solution.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/cpu_loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 9e357229c0..ff04f67847 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -169,6 +169,9 @@ void cpu_loop (CPUSPARCState *env)
         case 0x110:
         case 0x16d:
 #endif
+            if (env->gregs[1] == TARGET_NR_clone) {
+                flush_windows(env);
+            }
             ret = do_syscall (env, env->gregs[1],
                               env->regwptr[0], env->regwptr[1],
                               env->regwptr[2], env->regwptr[3],
-- 
2.17.1


