Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033B2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C409B2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6FxaP1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C409B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfjr-0006rA-27
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEU-00045D-1K
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:30 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:41389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfES-0000Ld-7C
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:29 -0400
Received: by mail-qv1-xf42.google.com with SMTP id er17so1756650qvb.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lvs+qOX6bs/iZi7N2ZR8e7cxDlqBQWqbjCB2CJTYkPk=;
 b=F6FxaP1VKb0Gp1RxkTSgeFU7z5xnH3WLU9yvrvrXFeftFMOjWOT6axOqQviQ1F6OHs
 9ROzfE9VvuQUivb+EWC4tzJ08Iy56H54YmMZQt4s6tMoW5Y59eKORw0xTJg2xgXQnrTg
 9LajHXVdIlB6e+cj8UMyC3VIwpAKMDBQDFtmdA8zKGWvWoYjOn89xd17JEfYQ1UB/7Ox
 pZR8j1Ngp1YcyR2DUCy8q3Q/BUP3ZL8DOkSry8GyUeL/hv5zbljxe8WGNuLy6lGc8gYr
 kefE0wPQOPrLkepve5JkKtgB6utrxmgFhtC3LgfzkYyhsESYQJjcNVjZ+uetAO7pAKKM
 6FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lvs+qOX6bs/iZi7N2ZR8e7cxDlqBQWqbjCB2CJTYkPk=;
 b=F4gDC2cPD4JewJcVqvREGZgnQYA8pknrY5QIYt3OSKaLqH93chu+XJXEcvpE5mmSSf
 i8kfTnhv0crXN6Nr7EOYSpbcyq0DoZ87atDFNUpk6fFQdGJ/BgkvcNfePkcuQjm+V1P0
 yJH+vTD6diOC2xB6GLg5VDQPRA8of/jiMXbUm7hpNOpEbX3IVY6VGu0pojwVZxGHUXWB
 SwQKyRdahN7Or0/IltDg/hAXEq8YWsvt4sB5BtZDp7FXmsR9dXhFeRIsv+10772VW8lW
 +tFoa9viusYy5aKZUQ0lHUtI2spw1rt6fbrU5O7n0Ohvi+XrfQB9yfw2XsqdptHWKKzz
 buTQ==
X-Gm-Message-State: AOAM530A4vNwvKoxly/AEo6VaZbjRV3fD26wSERrL26QcBgm6NPgux1g
 adpEA9zT68OgVKcsd8jyzsenFMtV9TEJPw==
X-Google-Smtp-Source: ABdhPJwMiMj3L4AYJp4dTQnS/AXWCyx62yxhxQh0MycziR2B/kY3gf3yxkhhQwIV6Pc/ts+b2sFPLg==
X-Received: by 2002:ad4:46a9:: with SMTP id br9mr557202qvb.246.1592427867100; 
 Wed, 17 Jun 2020 14:04:27 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:26 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 49/73] m68k: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:02:07 -0400
Message-Id: <20200617210231.4393-50-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=robert.foley@linaro.org; helo=mail-qv1-xf42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/m68k/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 72c545149e..f2585154f5 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -33,7 +33,7 @@ static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool m68k_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void m68k_set_feature(CPUM68KState *env, int feature)
-- 
2.17.1


