Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420F7C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9070422247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afJQHmT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9070422247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuE7-00059u-IC
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1H-0005WI-BJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1D-0003xE-Bs
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id 13so2340750wmf.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uyEwIt2mg5JkbXvyiGTkqHRg5zYJZwzlbNrkrnMgxtg=;
 b=afJQHmT9Ni6S4be+PKiH8C8N/xKG93yKBoObSbCpQ8pRzfHxMAEmVQYIy5N4w7nx5l
 92QS0zrwN4kHvI27MMrki5+YUoz/X5JQlE+fzM5R/KK6YkS8KaLazOOrEh3lrK3jJyj6
 lEAJLQyExJeCREbGEuiqFcw2pWBgZZzy8d1u5oH3g6geqL0nL18SYWMFuoOaJnjIrYSy
 UtmOECvX6IELIsqPQ9xFBkvnIOndTuozGcCvYk50mnB1TNAX5Sq2IpfajJocRCNWOTWA
 WCpv/XIs8vURF85tdWMFhcuR1souB4QeT2NUoC3Mqc3aLnaHQZaJkCdeYSqzJmSD7WGH
 9kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uyEwIt2mg5JkbXvyiGTkqHRg5zYJZwzlbNrkrnMgxtg=;
 b=PZJcOxiXEDve7+oL8TP60KJNBmCtOQvBER+EP5cR3v6MgIQ/XOmJONn7s7cDytDGup
 YPY0VRc6E0OloPj4H0LgIddJEP6skOTtkB6vpzD+FYERRfOHikvK+9wUDTWMZXerc3xz
 4ctOvVB5j3/YeFOHu5a8BdC77NIKmVXWekV61Zryj0OB/cEbTQWKBZdYljZeEO7wxqU8
 32zY5ZocLqaLvNF+7JQC5CVEf/4CcyFg4BT5+9Gs9QiCUj9wBo4j62+ZbU+VUCmAE7bu
 cZVMmew31HUNENjVcGKC3vbqs+424PSYjb9Ab1WCRXIp71kI7bsoNz7U2QscBLyBuBMC
 kljw==
X-Gm-Message-State: AOAM532doWdA7PFIBxkIeThbK31tRlIt4bPYemQcS96iWIyUB5oHKinb
 i/5mquy5hsKni4uvM0acHxL/8wgNx2tyhg==
X-Google-Smtp-Source: ABdhPJw9Iti8CF7NkgwkzybBsEy7qyNpF6vbNjAHP7gZyCBenXbexJX0F/L67oMmyAkaHLfp/77aGg==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr3659843wmk.88.1603209464484; 
 Tue, 20 Oct 2020 08:57:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/41] linux-user/aarch64: Reset btype for signals
Date: Tue, 20 Oct 2020 16:56:45 +0100
Message-Id: <20201020155656.8045-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The kernel sets btype for the signal handler as if for a call.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201016184207.786698-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/signal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index d50c1ae5838..b591790c22e 100644
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
2.20.1


