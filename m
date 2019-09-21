Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC97FC49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75FA820C01
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpIFQJxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FA820C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBXBW-0000n2-CD
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 00:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX56-0003JV-Gv
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX4z-0006Ph-8w
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:09 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBX4y-0006P0-BZ
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:04 -0400
Received: by mail-pg1-x544.google.com with SMTP id h17so2438035pgb.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 21:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=N9p66J3CyRGSggPL0jEHpJ6N3kmg+tOoU7mSBRlNkcw=;
 b=xpIFQJxm3uzfSkSTraENbc8HtBffhVBVKmU/3hlMOLXFXvjpL6AzMM+qNg189A2EeY
 fdtVTTt8TLNtwvaSJ1/AI5r6bObjANZEVNdC4TgptegNcjnmu8Zm57eTJF168rxlxWmf
 AST4BhMwUUJPcU8SHg3k3AcSkBYU1jjTEwepy/ylmICHZSvvqUQq00qaYHR7jGafC2YP
 muTWddnz9Vf3T/nZCln6ChE26s5D7tFvPhGN+ItauFVjI9gDT6IjAnNyMkSNjHUCsOCw
 tsfrWWTCtyv0BayoYkNMhuPU3OJxzRYv2GwW4s1F+akwwBI0JAqKJDidRC4cuCXHFW3s
 Al6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=N9p66J3CyRGSggPL0jEHpJ6N3kmg+tOoU7mSBRlNkcw=;
 b=YkRdA272t9JxToo0Kc4voe9qdGS9NfS2f4sA1pug/bs2Wgun7FUWBWtzZ4HC4QnE1D
 3rnRQy+UQtflicfZm8Vd1mf6x4MbUsaK0VsaCldHN5lYcuDL7nWQDWz8kcL5MJS6obJy
 +5gO7p+zosvgARfeJGv2/FlAEFkJF0lqjmWDrQlij/CyytCUnSAnQ2ti/PFlQS3RWBIj
 ktY/kHBRrEuzPrdJAVbJViU5k3KkBqYxzVdSGlP2HgvsbAibfg7jBe8YP+AkyryZgNfz
 N55Odb9FPBy0Ejmq84GzS6bFPnncQmTh+I0IPJgSo1Nh+dtTjk/y0X/kF6tPOwNqoDkH
 1yrA==
X-Gm-Message-State: APjAAAXaDu1uN655VzDUow0TUJJmNqkPk7MqYZQBKP2UT5H5HmfvhOXa
 DQ+Ywy6ah5+Kwa4FtdpBVjzNtmY9Wi4=
X-Google-Smtp-Source: APXvYqwoIuifzuWe4EXFhMnbHHcXlKzhxgNP6V7uP4XPWAVjj1I3V/WzuBcrf5RyT22nWr5Gzx6+fQ==
X-Received: by 2002:a63:1521:: with SMTP id v33mr18854563pgl.9.1569040382707; 
 Fri, 20 Sep 2019 21:33:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 193sm4179986pfc.59.2019.09.20.21.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 21:33:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] target/alpha: Fix SWCR_MAP_UMZ
Date: Fri, 20 Sep 2019 21:32:51 -0700
Message-Id: <20190921043256.4575-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921043256.4575-1-richard.henderson@linaro.org>
References: <20190921043256.4575-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were setting the wrong bit.  The fp_status.flush_to_zero
setting is overwritten by either the constant 1 or the value
of fpcr_flush_to_zero depending on bits within an fp insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 6c1703682e..10602fb339 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -71,7 +71,7 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
         env->fp_status.flush_inputs_to_zero = 1;
     }
     if (env->swcr & SWCR_MAP_UMZ) {
-        env->fp_status.flush_to_zero = 1;
+        env->fpcr_flush_to_zero = 1;
     }
     env->fpcr_exc_enable &= ~(alpha_ieee_swcr_to_fpcr(env->swcr) >> 32);
 #endif
-- 
2.17.1


