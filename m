Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2FEC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C1020872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8sq2zWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C1020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCs8N-00064E-6w
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw2-0002Ys-Jc
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw0-0004V7-Q5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrw0-0004SH-De
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:20 -0400
Received: by mail-wr1-x441.google.com with SMTP id i18so3603129wru.11
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hZ13oH0NrkJmOGqXttosTEow//UtkytE3cMegchFT1g=;
 b=K8sq2zWu35ZcJN7+uSClRFErzby3kvqCvCrFoLehZuE/BXvL2wJo0N5Gnqj/VEU4Gk
 A7zgzDrL7gNnUXmWF3dz4YV0Unteb2RHt2F7U4HOkw80b/1GIw/kzUo8P0qeMh6UlnTQ
 JOIjRaJ/fxmd+nY1OCUrQIAibMbiBEp5WuetL6XX6NiWWZUmU9zJoPYVR2BaavZIViPv
 trrHsjf+KVSiyLzGtDD3II5Mh/xvCsgwpNVsRPf5mwAufquMa55S+HNiSXDOGZt+WRTc
 0SUazoGqeAQReuZIg5WrHXXPJkeYGTvf7vgbS7Kx5ADmfuZeVar223gZotxn+aqHMEMI
 E9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hZ13oH0NrkJmOGqXttosTEow//UtkytE3cMegchFT1g=;
 b=hpj4NXGQ6BmTI4YHPNZVBZcVGNOtSGwnA1ugOhfA3+/qyWSVQTBlEO4AVs8TM4csC0
 Yd1dHbYzWIKjFIAb7bKEYUOP8r48VH6EU30B1UBGcc6p9Vs9slW7HsvALmiEtlqFjmbu
 jzNdygFrjcUmv/7+N2R7NG+TlHh1ixpt1cZG5Z+49TCC+rIwHcsGxuYVq+YpI84mVanR
 /l2yVmAJ2RkSa34K/VkvREeHy/3XthCntEFoWlGGUkAQMyDBGkpij8JqVZ2HxvCN+anY
 PKwb2mfLKTJ9i2rSR1NdOYj6WyOAu0lmWSjjYJgL6dZrEFYU5PHIhcpHOWEu9MwHwkFr
 I5PQ==
X-Gm-Message-State: APjAAAWLyEG9SWP9Tvtqbrg1LHmhpPpFIXY8q+cOMA5pBGElQ+KcqWSP
 otMbdn/wFQj/FzRS8hJwF+0j3MWIqubylw==
X-Google-Smtp-Source: APXvYqyvwmk0JpRm7vbBHK0wOFr3pFoWn4QlkGfNEZofGZih0+mljLe/yweiKsdyuo9wFxJ0pRSLdA==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr4812854wrr.64.1569358870994; 
 Tue, 24 Sep 2019 14:01:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l6sm1719246wmg.2.2019.09.24.14.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 352831FF91;
 Tue, 24 Sep 2019 22:01:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 04/33] target/alpha: Handle SWCR_MAP_DMZ earlier
Date: Tue, 24 Sep 2019 22:00:37 +0100
Message-Id: <20190924210106.27117-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Since we're converting the swcr to fpcr format for exceptions,
it's trivial to add FPCR_DNZ to the set of fpcr bits overriden.
No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190921043256.4575-5-richard.henderson@linaro.org>
---
 target/alpha/helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index e21c488aa32..2f959c65efb 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -57,7 +57,7 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
      * the software exception mask.
      */
     uint32_t soft_fpcr = alpha_ieee_swcr_to_fpcr(env->swcr) >> 32;
-    fpcr |= soft_fpcr & FPCR_STATUS_MASK;
+    fpcr |= soft_fpcr & (FPCR_STATUS_MASK | FPCR_DNZ);
 #endif
 
     t |= CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
@@ -73,9 +73,6 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
     env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
     env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
 #ifdef CONFIG_USER_ONLY
-    if (env->swcr & SWCR_MAP_DMZ) {
-        env->fp_status.flush_inputs_to_zero = 1;
-    }
     if (env->swcr & SWCR_MAP_UMZ) {
         env->fpcr_flush_to_zero = 1;
     }
-- 
2.20.1


