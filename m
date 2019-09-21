Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39A4C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FC120C01
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ID4a1Ib9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FC120C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBX8J-0005eQ-PY
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 00:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX5K-0003RK-5o
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX5F-0006YO-G4
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:25 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBX5E-0006Qg-Lv
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:21 -0400
Received: by mail-pg1-x543.google.com with SMTP id c17so4987282pgg.4
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 21:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=e9wUlJNq9/BSGM/fpYcG0qtVD5/JBFR6vCeczUn1tOI=;
 b=ID4a1Ib96z8s01zTwAh4sEYfjen+2ce6KRW+9NxASiLytDC25rFt+YdjDhL07suSVy
 WrTyHSfvdeTtsq4LoYeou9pQ4ONyD4LZdYtw+eY8jQl9U4Io3/BODxyN+IC6/nk61LaB
 iUPoKBpXd5SiZfyCB4q+UvSzOZH1lIXiIdJZQEiM/C/4cBvp74K0Ptm2nkFiyhfYueXs
 ZVgoDM3dQ5ZECl/SiabkXgJzI9vvHUMdvaD5yVPGHN/1wckxGjENCpp1Z84se8GQUU/G
 3T4utZBajWSDYCE3yaVQ0zOG90KtHLrXpAmJNcAoSJTE57r3yDTmSli/hOUJ/maQ/luI
 Y6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=e9wUlJNq9/BSGM/fpYcG0qtVD5/JBFR6vCeczUn1tOI=;
 b=BS77s4Uy5FtRHtRkIdKoRCZITikQr2Nb4Z0QH5/SNxh8tHMnUEaPtT4NqRyh/xAjQV
 9a+Soo7Rt3ATmztN8sj6+u7HStqQdWXpMnDZGkBUYgIm0xdB8Y97TjxOtI51UHWkVAV6
 ejgQ7Yih1b1iLH+frrN5OjsRipi8XYGV8pkdprZhAQ+OaSrQUXRyS3RWshKM91czEI3a
 xLE/dmQ7hJ1Dl42kdjqoWHr1q9Cf5zaC00fHeDG2I7D4A44kXuHG0PRO4MQj5LeImgdS
 l25LcYF4R8cDE2s/ZSkMnXoFCqZieHR1uRByvEDdIVm4q006cjy/mUsD4OhEygojq8H8
 m5LQ==
X-Gm-Message-State: APjAAAUZlJC4TMwFn+sRRS32r0FuvYnf7Cq9boMOepI8/VrYWOSdL6E1
 0yQI6UFjggt39uekqnA3fjXM2YM8uVI=
X-Google-Smtp-Source: APXvYqxN9FCeZS1BBSv7Ns9mEt4Of5I1Yh+LmG1aOFlog5wqkIt7WprM8e6aNYqW/D5zTYDVff2WKQ==
X-Received: by 2002:a63:e512:: with SMTP id r18mr11722947pgh.117.1569040386897; 
 Fri, 20 Sep 2019 21:33:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 193sm4179986pfc.59.2019.09.20.21.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 21:33:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] target/alpha: Write to fpcr_flush_to_zero once
Date: Fri, 20 Sep 2019 21:32:54 -0700
Message-Id: <20190921043256.4575-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921043256.4575-1-richard.henderson@linaro.org>
References: <20190921043256.4575-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Tidy the computation of the value; no functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2f959c65ef..1b3479738b 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -69,14 +69,13 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
     env->fpcr_exc_enable = ~t & FPCR_STATUS_MASK;
 
     env->fpcr_dyn_round = rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SHIFT];
-
-    env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
     env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
+
+    t = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
 #ifdef CONFIG_USER_ONLY
-    if (env->swcr & SWCR_MAP_UMZ) {
-        env->fpcr_flush_to_zero = 1;
-    }
+    t |= (env->swcr & SWCR_MAP_UMZ) != 0;
 #endif
+    env->fpcr_flush_to_zero = t;
 }
 
 uint64_t helper_load_fpcr(CPUAlphaState *env)
-- 
2.17.1


