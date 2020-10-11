Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BC9C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4D22087D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYzPu2mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4D22087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRhRw-0002Jl-PD
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRhLn-00037m-DD; Sun, 11 Oct 2020 15:49:49 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRhLj-0000Is-IG; Sun, 11 Oct 2020 15:49:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id a72so4667804wme.5;
 Sun, 11 Oct 2020 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h379DL5DmLfjV8PYLkjd7rlBL1BTLA1UsF5gCe/58yY=;
 b=bYzPu2mnrCz0oSVAMLCkTcw1nC+d1y7eurOU3zuPIslvaw/wnfx1Z1wGBBoNWfEmAB
 ycbJrvVOfG4MJoAh7Q2UqzOZ2jxR2D+htKX5rtTjQH2ogJKSLvjPzSVhr2LNkDNraDJ3
 RZwixCsZ+iYOB1iGMhPLK+P3LNm68EU6TJfiqczhVP7eLMZRtGYkCXnHuQTK9ABRxcPr
 Q74mB92OAfc9u/32OhMYxt4NEzYcqaloNkXBawkDuVQMA8PKTXue3vlf4CLTcndMzu6W
 +/gA95u7XW35wnixpO3qfmERBZ7RauKnDI8YydBAUyyKPJyRUz28YiSLZd4BBBV0J6Yn
 zdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=h379DL5DmLfjV8PYLkjd7rlBL1BTLA1UsF5gCe/58yY=;
 b=TIortcG9cQCGCnSF1i5HQOHO2PpaA+97SYKCZH1feqw6UxsTelnatmtdxLZCLWByoe
 AUTS8paA1JXELK/xpWcT3TMP3fO57/O4KGBaBB5k6MAsP77P+RIt0FqFFQr4xuxVec5y
 laYMz4P7iGVMAbE/JIGVjIzYeBO/fh4q6NBk6dkeOAZ2T0YPsckLhUxtMQv3dk7Vp4me
 gen8Mk1OncSMYr7YxZTCTizEsW+TlMxo8nJStnXHi7O54WqnjDZHdKbSqqBFD9CARgOu
 3EUrKfxapSwEmxN229N/CjAKf5xp6bV1WmzvpQLMuoE4UqkoL3qnJDeHAK4aGL5BqSF0
 mnVA==
X-Gm-Message-State: AOAM530lQkEIcqbeL/Otpt7ykw/tz2s1O9rah7LrJTQNuEAx6nMPGtWa
 OsJuWYPAgmOJLf2SKKkoisihFBAn7bk=
X-Google-Smtp-Source: ABdhPJxRXq2SOdDUOyfr1n/82jWNvIbfbd9pUl7GWKu8ocaSIFuPvp9YNSPAd78ylzrnSXgdjC4Ucw==
X-Received: by 2002:a1c:7302:: with SMTP id d2mr8159827wmb.133.1602445779816; 
 Sun, 11 Oct 2020 12:49:39 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f14sm23024055wrt.53.2020.10.11.12.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:49:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] tests/qtest: Replace magic value by
 NANOSECONDS_PER_SECOND definition
Date: Sun, 11 Oct 2020 21:49:18 +0200
Message-Id: <20201011194918.3219195-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201011194918.3219195-1-f4bug@amsat.org>
References: <20201011194918.3219195-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit NANOSECONDS_PER_SECOND definition instead
of a magic value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qtest/rtc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/rtc-test.c b/tests/qtest/rtc-test.c
index c7af34f6b1b..402ce2c6090 100644
--- a/tests/qtest/rtc-test.c
+++ b/tests/qtest/rtc-test.c
@@ -292,7 +292,7 @@ static void alarm_time(void)
             break;
         }
 
-        clock_step(1000000000);
+        clock_step(NANOSECONDS_PER_SECOND);
     }
 
     g_assert(get_irq(RTC_ISA_IRQ));
-- 
2.26.2


