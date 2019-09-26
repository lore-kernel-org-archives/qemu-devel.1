Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1AC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7B0207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4s6pL2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7B0207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYjX-0005z1-A1
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcT-0007sR-J3
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcS-0006P4-3L
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYcR-0006NZ-MC
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:35:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id b9so3916447wrs.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NgqUAJsE7r0/x7zzoIk5q9AJ4sTQDZ6fkjzBj1TKaAU=;
 b=u4s6pL2x5XGl06sEYmtlCOrCHRyfPaiEF6068V7gCMNvUg9pEk0Sp5KrDzGokwxT63
 ebFkvJyirU8JdwNRLoPFcNJ63H9wCqlEMs0I6BSBdu7D7e8Vw4fwlo0UvUqZn21nmNJc
 Q3GZYO2RiydGRDU5lqea+xKdZ2K60OzY3RcUS8oH0vze6MFGZ6kmJrpwXiEy6tN6NfJH
 6cEvdMQKwETawoiuInV+rwZT1j8iZTEwiZ+tReX4fofWkK3w7QCIYFcBCtSnswQ1WTu2
 uWBs8ENP5/VP0zsoNuDQLBnzNjWnINjpCCp2iex9SjES292SiUoyDFpGqTpPI9mLuBdR
 YZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NgqUAJsE7r0/x7zzoIk5q9AJ4sTQDZ6fkjzBj1TKaAU=;
 b=UuCE1IOOONOp4tvxEIU1t5Q4y6Z4dFXKz7XR8woxhLXIdGTcQmx/CKPLd+P/GHNeTv
 qYsVEnzX5zGrNTPMif46wE+Zh+gc7UooRVCvmvaFi0gKNKZhLKS5ypxFrNMR7N56MmSH
 ZzPExEsEhU63FfNaiUdPNmZVfN/oAWYEubRgQ+9w6HsXx1pJ098+GyMS3Bq8YSDbjmqT
 33y4nx+U/rLfNA1I6CYaGZbqtRhTmpmkC1/4hBYp146VnWXUTIqZBV3LBgvmaM0ODLki
 Ay2/ilkvY30tGbFfDwcypd6oN8apBQV9E5vd0oVKVSkveCWE/lJD50HUetJU3tqN3V4K
 GZnw==
X-Gm-Message-State: APjAAAWBHhvTnz/ed58171oxCLAsKrz4+Lcl5Oa7D6GrgYz2ZuNW4thN
 atNVi/dz2Gfu5Wyza3aaMkh/uQ==
X-Google-Smtp-Source: APXvYqzN3HTFFzq1VUveQSRSX3bhx/yJrlJSZaHsWCj7NfrCdoI0V3w2ZWulfuGoAhZSE69PrwWh7Q==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr3913603wrq.375.1569522958492; 
 Thu, 26 Sep 2019 11:35:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c6sm20747wrm.71.2019.09.26.11.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:35:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A21E91FF92;
 Thu, 26 Sep 2019 19:35:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 05/28] target/alpha: Write to fpcr_flush_to_zero once
Date: Thu, 26 Sep 2019 19:35:30 +0100
Message-Id: <20190926183553.13895-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Tidy the computation of the value; no functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190921043256.4575-6-richard.henderson@linaro.org>

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
2.20.1


