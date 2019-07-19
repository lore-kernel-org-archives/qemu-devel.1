Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F114C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289A22184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNMfRjHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289A22184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa5G-0006kJ-9C
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55267)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3d-0008Mi-B6
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3b-0005b5-36
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:48 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa3Z-0005EM-R4
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:46 -0400
Received: by mail-pl1-x641.google.com with SMTP id b7so16204293pls.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JBDZxP60+vIjwwzQbC3L2o1kpMj6601b/tqCyxFOHVI=;
 b=fNMfRjHxUxFXWj1u1ZhSzE6L8w03nfrXMO+op/YIDdrMkXx4YWTHbP8E46LCjau8jr
 xMZAaDRf5fMvMtJoTbs8nwtLWc8Dtd/53Yb2bP1Hwyb2LFh/DKKjI+M+1RSmPSB2CQvt
 3Jm2TzvPyGs4LRMkFYOiEJvmdz6FIdm4xP31DMVPwzVIOfkNja7JbLeZOoRdIiHeOHm/
 mhLmClDHzttCaS0x1/LOC5WccpXpgHteropifuS6KM1QO583Ky14Yt+NIRiG4Q59TG7L
 vXKvgqVa/GQ+jfyvk0BMAkp+NrV6gGz2UAyn3uAbeuHd6Q8cyfyuEPQmL9eWDusFjnmF
 kAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JBDZxP60+vIjwwzQbC3L2o1kpMj6601b/tqCyxFOHVI=;
 b=VYzAeUceTiFKggM8vDaRv7K8BcpIYD01qWMs/psWkKmsnjbIdphm3BCwMqTRjn0vBS
 0+1Sb54UWGz+iisbUucxTl6Rh7aqsLRRd6vYEAzZRctmKh2CSaUbYnljxQctIDylZa6T
 llbWU7XzAG23j84gu7pLxBhANE1dV6PanpFrCQ8oLkJMYVRVCfim85UymgBhMeus898f
 c4vq4IRRmSrHUtRBiTCA3SktF+s/8sJWEQEV3iLTVXapiTs5BLf9ZsHtY/cJeeYkFNSx
 RyEFLGShKeZ/z1pdJAqFNlw5F07OoY6lr0SSKmnP/dtPSfVCpTInH9N4Ty/6l/5lEohe
 T+HA==
X-Gm-Message-State: APjAAAWp0sQOuT2foJt0IIZLsctkhVqBFvq6nulmzu9Fao16nfSbX/15
 CMAyAzs476hgINyoCoL0odyQkGQzKbI=
X-Google-Smtp-Source: APXvYqyRKYVjn8fASYJhq2lS/YS8Lc6mZsV6StjoUjeTifnAajdaLYJIDp4+VZbm1R+1JfP6DfasXw==
X-Received: by 2002:a17:902:70cc:: with SMTP id
 l12mr17486441plt.87.1563570236745; 
 Fri, 19 Jul 2019 14:03:56 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:26 -0700
Message-Id: <20190719210326.15466-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH for-4.2 24/24] target/arm: Enable ARMv8.1-VHE
 in -cpu max
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1901997a06..b1bb394c6d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -337,6 +337,7 @@ static void aarch64_max_initfn(Object *obj)
         t = cpu->isar.id_aa64mmfr1;
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
         cpu->isar.id_aa64mmfr1 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
-- 
2.17.1


