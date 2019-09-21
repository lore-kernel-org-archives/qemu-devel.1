Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39104C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C7020C01
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PO0GiQse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C7020C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBXBS-0000iN-NM
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 00:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX5K-0003RY-BL
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX5F-0006Y3-8Q
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:25 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:47014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBX5E-0006QK-HN
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:20 -0400
Received: by mail-pf1-x444.google.com with SMTP id q5so5852658pfg.13
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 21:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8832rs/gjYJtK2KCkPzbjErZga7EWVI26gkEzFEjWFQ=;
 b=PO0GiQse2Tt2buMzBBQF17lZ2BDMqCf8+qVTGxSzCAQzsfwfnbeZvlxMEzupWX6wLH
 5j1MdnUOo5gN83hnqC8x1HzuoI5Z4GUpQTb/4RLZ/devOLCueelWgLKzGlt8RRiuMLWw
 sI0fbHFdgZVUIB3KdZSys4UamvIKkcqXiQ5GwCNeC6b+3T9t7IIjFC9hcVn2j3PauHs8
 lKCBtyemq+6SX1W0ao6sx5uzHbzkJ8lgf4XTGbugaW/Z/x2AGoK+4iaPbEj1mz0/mQlZ
 R25hB3gjt3iSDkBzd37NQjjP1/mBdX6goqqU73oYR/DWVAjLYcEK+DmiBmsaPqowPMsi
 zV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8832rs/gjYJtK2KCkPzbjErZga7EWVI26gkEzFEjWFQ=;
 b=tVuv9+jTzqDyo7UxB13nPk+Z6JRpdphZt/agZSwyAGaJF8E2OidnOIc+eeHFbtzeqZ
 eEVpX7pBqC1arzTG0cIDe4a6gxaxcXUklloFC7XSSwEUD62jivProMB5KywWnm1WKswq
 dzT4rRpFOnrin6Pdel43XPnZwV2ZYJ+9WErP1ckho2WG9YZB1lxjtDsgXHVdoDCd7p0q
 1bgrTH/PeswywmjygkYirTOls5KPZyMKWIm6elR2ibqsp95O5O6SPAV7meY3TaF7wmjg
 c89e27StsPTSxWQzt8V0vzzV9bwumbZceZAGx8VH/P2Zo0ccG18btEC57jCLazghfn5L
 BHBg==
X-Gm-Message-State: APjAAAWE7Crtgu/bP7EbYGy32dOz034GZlytCUmHcu4SiO5JJLNQv1cK
 URI9LxTgOTBOO51lsr9sFY0ZJUterVU=
X-Google-Smtp-Source: APXvYqyEAoWRisG1pyxAcwIk1bHr4UWk6rkI6/6B8WMjvhmPvJgtkgyZmQWwxnOp+hxbx1s+D+phJA==
X-Received: by 2002:a63:1f1f:: with SMTP id f31mr18413877pgf.353.1569040385641; 
 Fri, 20 Sep 2019 21:33:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 193sm4179986pfc.59.2019.09.20.21.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 21:33:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] target/alpha: Handle SWCR_MAP_DMZ earlier
Date: Fri, 20 Sep 2019 21:32:53 -0700
Message-Id: <20190921043256.4575-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921043256.4575-1-richard.henderson@linaro.org>
References: <20190921043256.4575-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

Since we're converting the swcr to fpcr format for exceptions,
it's trivial to add FPCR_DNZ to the set of fpcr bits overriden.
No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index e21c488aa3..2f959c65ef 100644
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
2.17.1


