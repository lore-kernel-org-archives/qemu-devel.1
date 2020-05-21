Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FC720878
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpGaaZar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FC720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboc2-0008Iv-Dq
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJC-0004PH-Fk
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:38 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:40457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJ8-0006id-UZ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:38 -0400
Received: by mail-qv1-xf41.google.com with SMTP id l3so3360505qvo.7
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DUz6IjE+KDBm1v/EkLkpXtyZ6YOnw3SSFHn8L1s2bt0=;
 b=WpGaaZarln1buUQsPXvXV7MU1b2/sArJI8g/dPlZ2GY3Nlu3exrW6lezhy2Lp3rKb3
 uZ6a25KZprT5fFh9P7YuWIL7gQlKdva7U7qzbuksba8OByJMhrAEoGD2nYQ+ezJZElsN
 78y6NUVTBTSP04t9ik7Uh1hl+uYXm9nxyIiFIYS96BUbKav/Z2Y/f3HrdcxsLb/HZjgY
 JA8QT/Wy/IqQrFk6ByAa5yyZiqCBlFAY8Fpfd06Z9ZGGI+kwkbtQvTin8g0zAMASt6K3
 sK8oywFXPH9bYkv4q9ZEMJIf5sn+yOvuJdFBVdjzAq7WfjCxCSToYih9MJyh8TsFAAd7
 KNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DUz6IjE+KDBm1v/EkLkpXtyZ6YOnw3SSFHn8L1s2bt0=;
 b=aAgXV5ULeut5Nhgf13rw0700t5bvydMlJ2sRMOK516LFJ1o3LerV6o+p2UgsKpAC9j
 Z7MWC803b7AhLMhPUQvfCi3WqzknNp+k/WJb6Kx6BYVYfWoahtAvWhqWvFDl+tedghdE
 KHBich0bgkpZF/0Rc/UvuQKr1EPJSQhwFp4vHb3EiNSw3au+otXX6XtGo0mIpU3LQAHW
 unRaBn/FELKLqiXpDy+apeeAoV66qAsVqJVYPeFZ5EXgdvUIRYNHXwJMpDmjOJ7tjC3o
 AtEKpn32O1i2tngSTMyFvg27M5StILMCR2CMS5+vUzvxXHeI7hQhv8B0YLUTYUiLQ/lL
 ruUA==
X-Gm-Message-State: AOAM531fvdiMprVc22U60RjQ1pTmp07RHHuoX89zKofrG1BhbUi1uHNM
 5R2G9vjLz/Cfb3JO6YYB1WaJMtsaRJRJRg==
X-Google-Smtp-Source: ABdhPJxs5z/Sr+EzwlmkDN9oHJhMg+boja1xDSBUrrfurptRHOEUYYGQ/6vfUmT6K9RihcgGyiwG0Q==
X-Received: by 2002:a0c:b259:: with SMTP id k25mr3837154qve.111.1590079473900; 
 Thu, 21 May 2020 09:44:33 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:33 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 59/74] microblaze: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:56 -0400
Message-Id: <20200521164011.638-60-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org, cota@braap.org,
 peter.puhov@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/microblaze/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 51e5c85b10..ce70f7d281 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -84,7 +84,7 @@ static void mb_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool mb_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.17.1


