Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E585C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5282E20665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNDrYc7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5282E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfpa-0006UX-Kz
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFe-0002mJ-8i
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:10 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFb-0005Sy-Gf
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:21:09 -0400
Received: by mail-pl1-x642.google.com with SMTP id y6so522253plk.10
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=18NIsjCWGgPffd6AY/cSSTGEezPxHVhnmwAp1fnNAvY=;
 b=UNDrYc7liHsOV0qv2VeKLSazz71g3yWaWpoYzo9ATGzetVJZltXNJhXSJ+TncAEiEA
 mzGDkjvTwcILHV/DANM2+yrna/ABbstMxFA5hn1KYP5PUYm1h7+EhW9T0+631p//xq3W
 JkadfelGkjsnmfBt/1jnPDwmNYga3vkk9AIaG0+2+Hd0HrcQ0viVVIvspSxCgJxXpvfg
 my2PXYCS7ZJ+Ksr+aK3vhY4plG9ShoVlZXE/NWQfdPTRpDvMj6Vb7uIH1/5jmSAb8C5p
 n5pqbvyUc/+wYFbCR7DA8XF0S3HMj+Ri6NUBRqv9kF+vAX7lPWsWdIT6qvQ9c8EC7Jcj
 wHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=18NIsjCWGgPffd6AY/cSSTGEezPxHVhnmwAp1fnNAvY=;
 b=MSjopBWFo37GgILyfMmk+eaYvO4AaZIkSf5naabyb7ivmFymSDUaLZs987Qiy1v5JM
 nhfL1pa9+tNoJUTHETqjVOWDO53+7h1fQ7S7RLC07bnBhUVvUAUM1Z/u5Ln/lQpLlVYE
 haxQCmZRDszRf+Y6rjT11PDMu9IHUCeNDULchSOU1olrGdnX5NGeZ4/KHHyjL0ejXKvx
 63CLlr4VK8C++wMo3w710z7hohVPxY6KJvaAzq6mm1shOAYHvJ7kQYMQBceZfU0wCNiD
 QKlr0uJZ1YwE6NyolxkSMY1WEXGum0TfuN/M7fJQafLEjyVlt5U37lFqyW5Ss1DGr2Sb
 pjVw==
X-Gm-Message-State: AOAM532J65apqbQrjYVoWVhymcZmNf3UD3QI5hZdBvKJ5RB+98ReQAJX
 iM6fxIuEJHwjwPfAZaGoEgKnGyOEiI5wtg==
X-Google-Smtp-Source: ABdhPJzxphlmZo5s3JgXFUz/C50p/5BKz8ASJriftwkuFzmBXb11fM0e3rX8CN41uzu754wUan4j0w==
X-Received: by 2002:a17:902:748c:: with SMTP id
 h12mr1499502pll.316.1598624465866; 
 Fri, 28 Aug 2020 07:21:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:21:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 74/76] target/microblaze: Remove cpu_R[0]
Date: Fri, 28 Aug 2020 07:19:27 -0700
Message-Id: <20200828141929.77854-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not initialize cpu_R[0], as this should be totally unused.
The cpu_for_read and cpu_for_write functions use a local temp.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8f69ca50b2..8c287457a9 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1842,7 +1842,13 @@ void mb_tcg_init(void)
     static const struct {
         TCGv_i32 *var; int ofs; char name[8];
     } i32s[] = {
-        R(0),  R(1),  R(2),  R(3),  R(4),  R(5),  R(6),  R(7),
+        /*
+         * Note that r0 is handled specially in reg_for_read
+         * and reg_for_write.  Nothing should touch cpu_R[0].
+         * Leave that element NULL, which will assert quickly
+         * inside the tcg generator functions.
+         */
+               R(1),  R(2),  R(3),  R(4),  R(5),  R(6),  R(7),
         R(8),  R(9),  R(10), R(11), R(12), R(13), R(14), R(15),
         R(16), R(17), R(18), R(19), R(20), R(21), R(22), R(23),
         R(24), R(25), R(26), R(27), R(28), R(29), R(30), R(31),
-- 
2.25.1


