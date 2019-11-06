Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596C0C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3BA2077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zuhqa6i1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3BA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJj3-0007h0-FS
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZF-0003r6-W5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSJZE-0007XO-T4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:41 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSJZE-0007Wz-LS
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:40 -0500
Received: by mail-wr1-x441.google.com with SMTP id a15so25308597wrf.9
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IVSeU2YymNYXOyhPXUxygRNjnXLwpMxT3U8QoAvH9WU=;
 b=zuhqa6i1JcfxMozKdU9Vz39Ff8WWwcfwM7HuPl8NWOxwyGxFIMX2v07aLdiOKDrYK6
 Bw1eMEzcEcsrl7CudvQG0CQMDwgl8xpj3Idshc6cnO9EJ0IuXk40kQEy92OtVKYMR5fD
 iZBCuh65FE6NSwkkB0MpYTRvjRUZlMpcKxA1HE7XCnLcSKlZJoHEvhgQXKsWGvFaWzvM
 +R8HLqs7xuFRMWX4gd8aV2I9kiL+c51F6Khf8OWcLQxOeB7kKHBBN8U3o+Habzq5VYVg
 Alui0h2qyAHrrTBqz7f5nPWa3Rr4xoK+ebtrBt4RNXZIrJ4bMz3WTDrc+5TAI6GRurQw
 xFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IVSeU2YymNYXOyhPXUxygRNjnXLwpMxT3U8QoAvH9WU=;
 b=AubpekPJWs3NB7BhAPAkGS6IFbc/If/ct+yvExDYlDIwaG3rVKfU6HVutLNKh2kAbA
 GkS0COgto3xyngCL34mPaKyInBT4k2Iaad7UCMwcDJgAHDZb1CpQg6Ph9wxX1roKO4MI
 oRLMXzNmG72ocCb2nhaybckSa/UKv11f2V+w5qj/10Ct5BNIT3lfeOw35TBaVSxkmT7t
 94/gi0JIaaAMvQZDwxu75utkfxu+NK+PHMicyiY0oSi5QoDLOOx4vhVQ/i93fE5ZTRhp
 R08/THUifEh622RYkhPDBm40o5PzWsfqUwZXUMcRxojgJ23Rh+BtczriFoI2zkneG3Dq
 ExxA==
X-Gm-Message-State: APjAAAW5fRE0TpqAUKPmyfPQuulh/XLWxTTZWgdcxNam1m0b/sEqpXDE
 KamOvlQzhStnqWIshfAg+1PZW6Wk3IPInw==
X-Google-Smtp-Source: APXvYqwIwmJLNCDSkOJrMOIM/fZTbs32qRHkyvdAm5nBOBHpwlGREKBoMJiQ8J/GfDbVOTDi6udZtQ==
X-Received: by 2002:a5d:55ce:: with SMTP id i14mr2146865wrw.169.1573040019516; 
 Wed, 06 Nov 2019 03:33:39 -0800 (PST)
Received: from localhost.localdomain
 (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id q124sm1776907wme.13.2019.11.06.03.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/12] linux-user/sparc: Fix WREG usage in setup_frame
Date: Wed,  6 Nov 2019 12:33:13 +0100
Message-Id: <20191106113318.10226-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
References: <20191106113318.10226-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use WREG_I0 not WREG_O0 in order to properly save the "ins".
The "outs" were saved separately in setup___siginfo.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191025113921.9412-8-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index e05693f204..238d0ba00c 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -192,7 +192,7 @@ void setup_frame(int sig, struct target_sigaction *ka,
         __put_user(env->regwptr[i + WREG_L0], &sf->ss.locals[i]);
     }
     for (i = 0; i < 8; i++) {
-        __put_user(env->regwptr[i + WREG_O0], &sf->ss.ins[i]);
+        __put_user(env->regwptr[i + WREG_I0], &sf->ss.ins[i]);
     }
     if (err)
         goto sigsegv;
-- 
2.17.1


