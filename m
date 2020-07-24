Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F76EC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C2A206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfD9sR6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C2A206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0jg-00025x-7G
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz0iq-0000Y4-Mh
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:39:00 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz0io-0001Tr-Mb
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:39:00 -0400
Received: by mail-pf1-x442.google.com with SMTP id w126so5298736pfw.8
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qt22xVqHd5YyzEckOxpQME7xz7JKzheB5mpy8sevhNw=;
 b=YfD9sR6zM90w3eAwKCmYtoJ2CTjePq9q+W+oumniCQg5WpnrfhvHtuaI+vrgrPinAA
 vSW/S0MSFN+OmWoZctNrZYWsA7r7AQJqNFQUsXEmMpJXLeX42GOswB8PJ8rpe0ktZBco
 f1DlS92F/Rezig+Yzujqd8JgzgniRmzxhlbC4J3L0s2x812Xxe8A0TUmB72HcQDTF+Xu
 0BFzwPbcAeVHFTeozHEjDkHV6CgYm4Ffh5Xacnx+I74a5tYidMPRz9ip9NzxJFxpegvt
 +vBGX62VnpZujoelGEJjuWfbXvKs+1VOLhrFHUgzHZWRIBsUvr/uQZwiX9qfme9KqQfN
 DlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qt22xVqHd5YyzEckOxpQME7xz7JKzheB5mpy8sevhNw=;
 b=jAPit87LyabW4aVl8pgCN+s6569q6UUlGB/aNv6A/maIdDTAHSLZ3oaFIGDv7DbkM3
 pN1EzLr1Xl5zVQH1BuG/1CYXKE1JeGn7DwyD1/B9XfCG1JsTpzu0YX4lkhTOUoQZouMX
 LQ0FJ5XYs8wTz+z2xb6p8O77euL08W+oA5zWy+VVEolxq2WQIVCvaQCvsYZ0hrvhoGoV
 TfqhHEfLE42Js0/9ITvVrVl4tlTsLXuy+eR+RtPPKQI31w4Qs1K5b9KbqgtaKo55UptC
 gbLHkl7+rVBxN1z7dtvlXN9KDqYwfK8y9PUe+rLv1xezWOS1CQlxfarEIDbZfbCC6cuL
 uLvA==
X-Gm-Message-State: AOAM531eanJLl3HTnT53OMKjFD5tEWecJE8UHQizHStxiQyxH8AeV1aK
 G84LF+fPJIWeJLVwEuqjxkWC4dACwkM=
X-Google-Smtp-Source: ABdhPJwZEFTrVatJOlWPu/ixbHba6f+ynd+00XfigfZA82wcEX6fKcsrvZRrACkpgfMm58csksk3uA==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr9022226pgk.434.1595608737060; 
 Fri, 24 Jul 2020 09:38:57 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id r191sm7261663pfr.181.2020.07.24.09.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 09:38:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/arm/boot: Fix PAUTH for EL3 direct kernel boot
Date: Fri, 24 Jul 2020 09:38:51 -0700
Message-Id: <20200724163853.504655-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724163853.504655-1-richard.henderson@linaro.org>
References: <20200724163853.504655-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: peter.maydell@linaro.org, vincenzo.frascino@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When booting an EL3 cpu with -kernel, we set up EL3 and then
drop down to EL2.  We need to enable access to v8.3-PAuth
keys and instructions at EL3 before doing so.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/boot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index fef4072db1..c44fd3382d 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -736,6 +736,9 @@ static void do_cpu_reset(void *opaque)
                     } else {
                         env->pstate = PSTATE_MODE_EL1h;
                     }
+                    if (cpu_isar_feature(aa64_pauth, cpu)) {
+                        env->cp15.scr_el3 |= SCR_API | SCR_APK;
+                    }
                     /* AArch64 kernels never boot in secure mode */
                     assert(!info->secure_boot);
                     /* This hook is only supported for AArch32 currently:
-- 
2.25.1


