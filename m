Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDD2C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D946222BA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mIHmdGY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D946222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdWf-0007vh-Ad
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLr-0000vb-Sl
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLl-0006Zu-MZ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:39 -0500
Received: by mail-wm1-x32d.google.com with SMTP id 205so2471593wma.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zPF6mATGfZ3Q00cd72hKcOuI3Yqf5RM33+sscUSh8oA=;
 b=mIHmdGY89oAsL8rM6wXS/HEZu0NUX0HyXPTgBgYVVznyvLYva/z2p0gUFKRp6qjJlV
 2X1Es6ZUwCIIk8Xnt84WHBWyCj8480/o9XOidzyI9Z4UHAbYgLhdCjGrqa9tBhC2gK69
 QISgJDMFNQ5O3KON8B1H/xrL03+aUGtXVrI/jb1Tdq4QNl9BqL/DQDWrytQ60qRrWuJP
 suJF5avIVoSCvk/INjxH2nAwVAErSPy1ZsqB8ir/ZDwK6cw5M1RpsBqWD98++8Var2OK
 GhnXa2xXxgMAPx8F7MZuqfEiuOUTvFseXAbJKs5ijcUhvGnlXZEuW8O4aKSwd4SCNCCC
 JGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zPF6mATGfZ3Q00cd72hKcOuI3Yqf5RM33+sscUSh8oA=;
 b=hlwj9oJLhdFTFwrlZTuA+2TpvIZKjgbsKuvVS+4UGIkBKStIQnFuExx2cyVooOTyPd
 Xt4BF4SZEn4vQdGsG4ww0y1bGUW3C/mLNuAGe/7Y2sicrY7pqm8KQBNbzf/9lO8NOr6K
 Ibz5UpvCxcgpqX0RZyO4KnJnRymBdZiEIE8rCS0l7jkD/7JAPETvcR+NL9RdaBCr67hy
 Cea6erNaxKA3bqqpIfDV5MXGs0DcdItLSkisLR4qAs+TY2mRb2aDKrb5WQSEfC/N8o02
 a12KAA6UXuau8XsJW5gDVQ1Dsdi/vuBCgyP0VagHrRqtLngPx0i0B2l0DuwJG2+nkgYJ
 APxQ==
X-Gm-Message-State: AOAM530D8XMajh3kbgMo14Ccr/KUMrNyCU9FaLO1jULsOIRLu/dwRTtm
 SUpV75pIc4baTDPY8ICXYv2JtcyBK4yamg==
X-Google-Smtp-Source: ABdhPJwBuJbkGdFnFF4IWTOS6NnZGJlwQKxIz9/+xvRxPMFWmGSRERjciLqBHqY0Bu847Wesvqv0xQ==
X-Received: by 2002:a1c:2dc4:: with SMTP id t187mr18371235wmt.53.1604337031860; 
 Mon, 02 Nov 2020 09:10:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/26] target/arm: Fix float16 pairwise Neon ops on big-endian
 hosts
Date: Mon,  2 Nov 2020 17:09:51 +0000
Message-Id: <20201102171005.30690-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

In the neon_padd/pmax/pmin helpers for float16, a cut-and-paste error
meant we were using the H4() address swizzler macro rather than the
H2() which is required for 2-byte data.  This had no effect on
little-endian hosts but meant we put the result data into the
destination Dreg in the wrong order on big-endian hosts.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201028191712.4910-2-peter.maydell@linaro.org
---
 target/arm/vec_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index a973454e4f4..30d76d05beb 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1858,10 +1858,10 @@ DO_ABA(gvec_uaba_d, uint64_t)
         r2 = float16_##OP(m[H2(0)], m[H2(1)], fpst);                    \
         r3 = float16_##OP(m[H2(2)], m[H2(3)], fpst);                    \
                                                                         \
-        d[H4(0)] = r0;                                                  \
-        d[H4(1)] = r1;                                                  \
-        d[H4(2)] = r2;                                                  \
-        d[H4(3)] = r3;                                                  \
+        d[H2(0)] = r0;                                                  \
+        d[H2(1)] = r1;                                                  \
+        d[H2(2)] = r2;                                                  \
+        d[H2(3)] = r3;                                                  \
     }
 
 DO_NEON_PAIRWISE(neon_padd, add)
-- 
2.20.1


