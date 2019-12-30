Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2C4C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC46206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDbjUcEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC46206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilsz3-0001r2-80
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 06:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsw0-0005Ys-EN
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvz-00039p-9n
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:10:04 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvz-00038s-3u; Mon, 30 Dec 2019 06:10:03 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so32358952wrh.5;
 Mon, 30 Dec 2019 03:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wn1QqcaJuZGKr4BaTRtaO2JGUDTV/7uIt6tHl4UtiBE=;
 b=tDbjUcEJPfbvi+A1CdqGydruCJPOHCjcNxNvU1LE9JA3rY00iS89ycaGKL8LGT4bLv
 yZSbPfKfu2ZybOjJ68Lptu6ezVmviW9f2JMB1PrfCLdkG2puzTtT6SQXru8tsTIZavl2
 Tp4pnc9LOlEsrs+p60d7P0EGdinFc16Y+Zs6R34cb809v1fWiSrr0LaCSN4bs3e5P9uV
 I3mytTUGaEymioEyAACN15hX5BYUtDHZRLzUnK0RaYXeDrR+RJmgNd+mQemyoE+0DdPZ
 E4VNrLZ47lS4BTCwpNz/RnOOXJ9nCISr35acj5ZzM1+o0H6stlYnzjFJwdY+nnm5BHmD
 zWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wn1QqcaJuZGKr4BaTRtaO2JGUDTV/7uIt6tHl4UtiBE=;
 b=tfNRhBU8/opht3mRpGSHjdTUg2haE0SXbqq4tvxOdP9ziazyGz9qHmVwk+Y4eaIHgZ
 aLMQaAQhFAlVg1SYodpQMzPMDk2bHS6pB7Aa/RmW0hcweizKKXzScqnuqCV1ZI+XJ4dU
 ae1uBxPpqY/PwkXNWidjUoNgmthcaUnX7Ho4a1mT4Y3rOVZo4ktSUuwW8LSf5/Rkj9/B
 9NaSJlqLMfY6BIX4BDrse680Rz95fGQfItGxkNIK8CNsAJLsOX+kOktLjYjX5gaSf5sa
 8R5P6/F8HE7nm7mhZWCYFUWkkvDfjc6OAqyUqfaNLOvxNECUMNyw/0rItZoCbmqYryMC
 l2lQ==
X-Gm-Message-State: APjAAAV+D0pDO3eZV7M9JvxfPscgqDqDbM9gvxrNdPYayckgy2Q8Mpix
 H75rc/D+SPnRwO1LsSdQjB665Bfi3Io=
X-Google-Smtp-Source: APXvYqz6IsNwup8mw+UxB6BAGSXSyw/Pv0DKEDPQrSMByUaGOCiOCGt1O+IhUfRqhfZm7ePixiGuyw==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr67706884wrq.64.1577704201881; 
 Mon, 30 Dec 2019 03:10:01 -0800 (PST)
Received: from x1w.redhat.com ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id p15sm20442738wma.40.2019.12.30.03.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2019 03:10:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] hw/arm/allwinner-a10: Remove local qemu_irq variables
Date: Mon, 30 Dec 2019 12:09:52 +0100
Message-Id: <20191230110953.25496-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191230110953.25496-1-f4bug@amsat.org>
References: <20191230110953.25496-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We won't reuse the CPU IRQ/FIQ variables. Simplify by calling
qdev_get_gpio_in() in place.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/allwinner-a10.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 966fbd4a6e..1cde165611 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -55,7 +55,6 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 {
     AwA10State *s = AW_A10(dev);
     SysBusDevice *sysbusdev;
-    qemu_irq fiq, irq;
     Error *err = NULL;
 
     object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
@@ -63,8 +62,6 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    irq = qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ);
-    fiq = qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ);
 
     object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
     if (err != NULL) {
@@ -73,8 +70,10 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     }
     sysbusdev = SYS_BUS_DEVICE(&s->intc);
     sysbus_mmio_map(sysbusdev, 0, AW_A10_PIC_REG_BASE);
-    sysbus_connect_irq(sysbusdev, 0, irq);
-    sysbus_connect_irq(sysbusdev, 1, fiq);
+    sysbus_connect_irq(sysbusdev, 0,
+                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
+    sysbus_connect_irq(sysbusdev, 1,
+                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
     qdev_pass_gpios(DEVICE(&s->intc), dev, NULL);
 
     object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
-- 
2.21.0


