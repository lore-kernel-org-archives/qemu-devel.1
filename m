Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48E4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9684D20872
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEexihwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9684D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbSXG-0004UR-QL
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 13:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbSVl-0001mD-EY
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:28:09 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbSVj-0004JB-Gq
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:28:09 -0400
Received: by mail-pf1-x444.google.com with SMTP id x13so1880900pfn.11
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=btSVOHjKygqtDtrb1dFrs4ZFhT9VU5bMtTLVHWgmpDQ=;
 b=IEexihwJhok6sSzixqByIreJXkjn5IhkGZ88k+gM3aw2vVfJKUyExUVNx6v1VW5WM0
 nLtYfm1S4DtjJNX6SdfyI8B+6j88A5yR6JDlDxSdGe8iN47zv5K6mU6JPhxwF8YTcz1n
 oSkbiYceIvrfbUHWzBRQU2ecQxjez3VnSFPhVMXg1/PBuctO5egGfF+r27MSflCm5l+d
 Bv7gS1RgWLhSr8BdtSGr2fSVxDAoCNxPca9fjhaKKydJG3gewT601AJKgFZfYjh4afVN
 7lsQ9uDjLC9+lbXGBEoS1hTapWluNDP8WV6tqe9KfGGxJ1gQEMZ3xWzQhbSqD8iGbYwO
 pNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=btSVOHjKygqtDtrb1dFrs4ZFhT9VU5bMtTLVHWgmpDQ=;
 b=OOdVpRcp4Hqft4O21hZuOkwc+o6EJpekqFu9U1o9idbvJ+U0jtqyOsuUasy00g1/n4
 q00m4aXCTyKxhNM5rm7lp6Pv6HfWRKBlL0Kos7EnQnn6Ll4ftUBd45Q58hcDJtU3GzgT
 IIjz4BA+3FLyZR4GzlPBKNCOJjOtyZxbVtAhIBnOwqgulAwPrKGhrswyGukczqE6m7Xt
 +1QUe968G+oDHiOF++UBxBAR5RAUbMbnhkUgK46bIUYRWCHSUnVvIxGQ1p0gxSWsAo8b
 71HssbvBduxVI3YtRx2e+8XvekaRZHSzW1grk7FCW7YP9pluGAKHP8ze8e5pXI9gaFh7
 a2oA==
X-Gm-Message-State: AOAM531zgXUOnVcasdrjEcCwOTwPvRsMxeXq+3QNVeSUt7iDtnrb4mRp
 FfiDfwsGs5Dr0aFzPqqNAF4SHC9bb9A=
X-Google-Smtp-Source: ABdhPJxcIGcJ7KmfWlS44oZQBEJTuhFKAsvLYU3nS5QefUJrP07lBVvX477CTWwm3jV3ZivzlpZThg==
X-Received: by 2002:a62:1681:: with SMTP id 123mr164618pfw.306.1589995683431; 
 Wed, 20 May 2020 10:28:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k18sm2643672pfg.217.2020.05.20.10.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 10:28:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 1/5] linux-user/aarch64: Reset btype for signals
Date: Wed, 20 May 2020 10:27:56 -0700
Message-Id: <20200520172800.8499-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520172800.8499-1-richard.henderson@linaro.org>
References: <20200520172800.8499-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel sets btype for the signal handler as if for a call.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index cd521ee42d..2c596a7088 100644
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


