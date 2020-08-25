Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288F8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDFB20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gz82VMtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDFB20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgpN-0005ZH-71
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4Y-0000kG-Gq
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:38 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4S-000259-J3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:36 -0400
Received: by mail-pf1-x442.google.com with SMTP id t9so4129329pfq.8
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XYFF+nRDeDk80M21qSEoaFQq0JFdLsE3apwlxbKB9OI=;
 b=Gz82VMtPCylrr8JFVL1kGAtjMTu69kceqQ4FTzs2dJP3TU6qcK7Im7ifVq3yorhbvu
 31ckriXBTjR37pcZicbjrdPk16p5KdoRI8wi3F4TVdQ7zo8paYt+SDKNAso/tiX8Mm3z
 2N87IZXOdai+oavqYjD0Ejj3afyS65kb7o/QWmzz4SKq7kNy0KrKUoznXUZjhOPRKX5R
 zfBpzz41BP/PsRMPYPj8IjCVfsfHvO7U9DtczzDuczJ/eUVKS7DTx8qCoIa2oLXBOqtK
 9LA/9rjZpEGdZAKGephIjdyJcBihrjHaBllfItLSWTTgte6tEbNLIJybcGOOQ0KFV7/2
 qkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XYFF+nRDeDk80M21qSEoaFQq0JFdLsE3apwlxbKB9OI=;
 b=ZVW2wVdldodynm+xAPcSS672fgRDS1LNX1Rjgf5kadh6FxppGm/DIxTkHJxLt8Up+r
 KAKBTsmmL5rhLYcVNWzBCvRBFl920GeOAArVOdC6qS9E1mhQOAfka/rvvFlSapF6XxTl
 Y/32uAxbes7s43OFIzOX2Cp7u7LCq8kUxo/xAUvmeUOlAs8hQWo77SavhvTilE+4MCrW
 pdFFBkFpOQMFKMWuloYaQThgX3O6KmFJjl7IumxAicE9IBjixX5/V1iA7CI+uRSiBhxA
 7TB1suEhDijy1z/Kr3kvdbL0RpvFDisK4wc2YT3Tw3vrScn4D4TE+N1kZJnmDBd/FSr6
 OWXQ==
X-Gm-Message-State: AOAM533PinB90C8qMPltSaLooWD0rYNjBmbN7MQsp+mBPBSNw7yRoREf
 p3JpxybBsJHOEJTg72EJWgkkLsyKa4d68A==
X-Google-Smtp-Source: ABdhPJwken8sRhLjmqROkJlkkNI2rwlNWIQir6xjuse2SKvOH4i0WqHDZvreqS1L/HK/h6ShLL0low==
X-Received: by 2002:aa7:9467:: with SMTP id t7mr9245560pfq.64.1598389290523;
 Tue, 25 Aug 2020 14:01:30 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 75/77] target/microblaze: Remove cpu_R[0]
Date: Tue, 25 Aug 2020 13:59:48 -0700
Message-Id: <20200825205950.730499-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
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
Cc: edgar.iglesias@gmail.com
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
index 2df22e8c2a..c8eb68ce4b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1875,7 +1875,13 @@ void mb_tcg_init(void)
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


