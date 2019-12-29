Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCF6C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E6E207FF
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxr4a0bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E6E207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilhLd-00046O-BV
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJA-0002Li-0e
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJ8-0001WH-U1
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:11 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhJ8-0001Tj-NU
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 17:45:10 -0500
Received: by mail-wm1-x343.google.com with SMTP id 20so12878981wmj.4
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 14:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kfmw6Uf2kP9Qr8LqH5cHUDPYAsKSSyoM6o3xZGkGFTM=;
 b=Jxr4a0bc7gGJivbli8bljZC1sWLcb4p5io3X93/G1wdR1f4zh7Y67ir+sS69cWCKe9
 UKDUMl24brFKsatSpSkOPW/y7HURDrhrcKUUMs3TlXFRZM1wmY1r2XwB7rAqH3Yxa3qe
 qA8suf9RchR/yTBmUO3s2NF0AbuFxeLR0ZvqLTB1XggknvX54z014AgcLNz7gDbyebkO
 92ta6MYxkVEbVg8outDbeRqORmkSDBcSaaXY2zAt8undcvCnRJGQQ3bMtpv1hBwTbjSC
 Q0frYEJK4NYeP48/DMwxQIpNDBQ+4o5PYCmZ3jrbOpytvwZSCCp+G/ytoBZtGKoB5ePh
 fRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kfmw6Uf2kP9Qr8LqH5cHUDPYAsKSSyoM6o3xZGkGFTM=;
 b=r0JNJZusglIm0khFif51+P04xzDQLNV3Re1RrwoiX5H49D1iIrwPDWBOkSYgSh333O
 Xd+GijsUj4hcWNzCir4MFvxL2D58w9rffCnO5CdMZWhpzXUQ8bzBhMlfUC3dbhWRO2d4
 3q5yZwj2+JNw3/l8+1Ytyyzeq2jzY2Two/TJ3V84BcbVCf3E06eg4vihAf4l7rj8lfMR
 Hf/O5rZexrRXoOpaqfpbC/41twVAxNxUNY0mOwpwsEkkmvU0NpczE2M8vPCQi4/M4Xkp
 YbweEKm3cX5OUqcxFsQCx24H4PDMk86favhtrHN9tdlvbY8lx63E2Q9QSgFC/dKyM/dJ
 U1iQ==
X-Gm-Message-State: APjAAAVRxpuWDwIp2D6tDt/Q4/p1pR+5KScbXAOd0PaEZQfDhBzndQuh
 LF0BZI0oi5PpZ4pKnOyob1NS8baQzOY=
X-Google-Smtp-Source: APXvYqwD0gZKzxZjRnJ4/a1YGtmSFfXQ4b8fCSXbjGBbJxI9vcAt9SJpfbnHmCrHCX3hS5AveoRGwg==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr31182649wmi.146.1577659509642; 
 Sun, 29 Dec 2019 14:45:09 -0800 (PST)
Received: from x1w.home ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id x1sm42709188wru.50.2019.12.29.14.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Dec 2019 14:45:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/8] hw/char/avr: Reduce USART I/O size
Date: Sun, 29 Dec 2019 23:44:58 +0100
Message-Id: <20191229224505.24466-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191229224505.24466-1-f4bug@amsat.org>
References: <20191229224505.24466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per the datasheet the USART uses 7 consecutive 8-bit registers.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/avr_usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index cb307fe23d..becdb87847 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -280,7 +280,7 @@ static void avr_usart_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
-    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 8);
+    memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 7);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     qdev_init_gpio_in(DEVICE(s), avr_usart_pr, 1);
     s->enabled = true;
-- 
2.21.0


