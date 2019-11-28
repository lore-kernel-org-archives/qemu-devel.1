Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC5BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45929215E5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+g86bRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45929215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia92n-0003qN-0h
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 20:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x7-00060I-9e
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x6-0004Fm-BC
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:41 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia8x6-0004Dp-4s
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:50:40 -0500
Received: by mail-wr1-x442.google.com with SMTP id i12so29015783wrn.11
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4v1ufCU3OmUo7Hl9SRgGbYrzRMi0K0vlNG4YbI/LyYw=;
 b=F+g86bRUIXqueZi0H88FMyG2aVI3z25sm1JzdeeSWJfLoHZyDGs7xkBAVyftClkWbi
 v0IzQm2sbB/PLUrLNwLwaNXBjOva18hIX2SKm7El2WIWKaJ1x30HCxH9cwVAa+M3y+3f
 uYyJkW15XFCt5umWi3jWPLZ1qtB+jo28SHiZt6Ua0FReNp5T8tg2kWW29Cm5aHuMx8is
 QTNvIUKBOrCEbyyUUv1X7g/BVWkcJrHE9kvC8EslNt144b4/GWUKFbJ/UF1RKZw+aGy5
 YyO/KiXSTa45t9Jb0Zg1yck9BvudskxVM94pUMDRZDV9llSBPTtW/NwIl0QGYvCqbquT
 Sb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4v1ufCU3OmUo7Hl9SRgGbYrzRMi0K0vlNG4YbI/LyYw=;
 b=Ajhr+2XN/WDtaiUv3QWEHeFOYkQZMBYQfuxh93uweZogL/BBCYkJQiZc2X7KU3dF4b
 ftZ4dSwcGmoJEElK+XQG9KpJchhTxT9PCdJWM32JouQfRY/SDRPiquijyRnADHLrNDIL
 bn3lbUHQuABsB1DhPtQvwb6WgXoOwY7+EDnDmFgzTAu8oEx9tH8VWtk9Hzl/2ibNKSHK
 +g8Sa/t+C08jh+KUmA37cwZGesjPA/GVz1Aq1K34cSmzrbCEvWWqtIGW+pLK0998w4fE
 Cl/SDoanKT9w5Pzxaa8TZw7qkfAtyL51dq/P2/OtGO0n/+olZcPKPm/oyRQ/xBV4UX1z
 e9UA==
X-Gm-Message-State: APjAAAWErGaT/p9e893l2tRRg4di9f81zGYULoCvdmlHhCEjGlBP49dY
 SxFeLZPETdN4rC3Ugk8ln8UE5WI5
X-Google-Smtp-Source: APXvYqxsiilrpxy5/V3MbIeKGLjft1fXPUCy7ZZQqL+PjohRDedTcybCRVuvbVdzpwCvJaKLGLGxsA==
X-Received: by 2002:a5d:5050:: with SMTP id h16mr48891832wrt.380.1574905839018; 
 Wed, 27 Nov 2019 17:50:39 -0800 (PST)
Received: from x1w.redhat.com (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id k16sm8738061wru.0.2019.11.27.17.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 17:50:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [NOTFORMERGE PATCH 04/10] target/avr: Fix IRQ count
Date: Thu, 28 Nov 2019 02:50:24 +0100
Message-Id: <20191128015030.27543-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128015030.27543-1-f4bug@amsat.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a SEGV when using IRQ#57 by expanding to 64 IRQs.
64 is a magic number.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 52ec21dd16..8198f9d49c 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -129,7 +129,7 @@ static void avr_cpu_initfn(Object *obj)
 
 #ifndef CONFIG_USER_ONLY
     /* Set the number of interrupts supported by the CPU. */
-    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 57);
+    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 64);
 #endif
 }
 
-- 
2.21.0


