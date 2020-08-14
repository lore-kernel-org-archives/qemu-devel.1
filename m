Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14803C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1AAD207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUUnGR5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AAD207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6co2-0003cx-2E
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cjv-0004HW-8R
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:35 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cjt-0002Kl-RD
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:34 -0400
Received: by mail-wm1-x341.google.com with SMTP id p14so7986768wmg.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T47mf/KpXo4rEcEG9yBWBrQa7uEEYMLMPzhxvqfRUeU=;
 b=uUUnGR5cmO6R7x2qS/iHcvETmU//nunsed1iXUpq8OwlfxwChQE3cbFfLBpI6TPBrH
 JNuc6PQt/5VrUG9YeBu0YrcdmJDVDbC2SzokTzF5ZGAcK4hPyfDuIQCARB2RYMCk+rVT
 fyeCLIquyg5oNiLtPj+nl7cjXr2X7sqNSIHsuyW2PYcUlIMtK3Q9Wwsop8/onCVafmm/
 VupKT2pUxapfiI6r6IU5UVXAWtPwk9JSmhGNLHdAxHiQoVEaCkC1WWPX/XHfOyiussQy
 tMkHqvuoPWnvezX/xX+tvodzZEdzs5JKRpP5gxobnlYPYLtrI+kS9cGHPEpow0Z4pqXw
 l9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=T47mf/KpXo4rEcEG9yBWBrQa7uEEYMLMPzhxvqfRUeU=;
 b=hg9VtvzZz0imp0vUWYuoOEcgSHb+HViKX1A7z6Aou3hrunfT1vT2eT/sEvfZLxi+tE
 wQQ+JOWgz0xHQhm5bOINsg1V1GaACMMFGiW+0W5F0yBn7Zq76rr9f5Nc8pyTP+vk+kOZ
 tb5l01pIWiWVYp/4BwdTefSBJImeoYf0Y12ZZptaOhWclcaGoMeIDxieputUrPU8Ll5S
 ucuwhFcu/qWhDWWB4GDj81iF0OjRqCp0MluVdP0Xrmh8WG7l/v2HbiBaG/4DgMbRAP/F
 YCq1YAmqA77x5it7wBS93YFuviDDwwAYqzZf5t/jAnlAppmfEg5tFA7wnzprd0G8KYWg
 /Eug==
X-Gm-Message-State: AOAM530VZ4rYY7MaFf3RjOb5nBQw6TKqkY0TrpoBZ8+yEwg6sCkNa85g
 cF4aFcUXznpNo2NFu1sdTqGNA7VaAow=
X-Google-Smtp-Source: ABdhPJwx4BLy118NDBYSpV+Xgi2IxqepKLKDyM+A7VCEqCbBe8mtYqzaE3dYPoTL21maH7xIkMPOUA==
X-Received: by 2002:a7b:c941:: with SMTP id i1mr3219351wml.73.1597423172417;
 Fri, 14 Aug 2020 09:39:32 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p14sm18417178wrg.96.2020.08.14.09.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 09:39:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/char/avr_usart: Use the Clock API
Date: Fri, 14 Aug 2020 18:39:23 +0200
Message-Id: <20200814163924.11662-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814163924.11662-1-f4bug@amsat.org>
References: <20200814163924.11662-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expose the 'xck' clock source. Connect the MCU I/O clock to it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/avr_usart.h | 2 ++
 hw/avr/atmega.c             | 1 +
 hw/char/avr_usart.c         | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/include/hw/char/avr_usart.h b/include/hw/char/avr_usart.h
index 46d6c76e50..13cfd5ea07 100644
--- a/include/hw/char/avr_usart.h
+++ b/include/hw/char/avr_usart.h
@@ -25,6 +25,7 @@
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "hw/hw.h"
+#include "hw/clock.h"
 
 #define TYPE_AVR_USART "avr-usart"
 #define AVR_USART(obj) \
@@ -51,6 +52,7 @@ typedef struct {
     /* Baud Rate Registers (low/high byte) */
     uint8_t brrh;
     uint8_t brrl;
+    Clock *clkin;
 
     /* Receive Complete */
     qemu_irq rxc_irq;
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index f14b558140..b6e86a4531 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -302,6 +302,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
         object_initialize_child(OBJECT(dev), devname, &s->usart[i],
                                 TYPE_AVR_USART);
         qdev_prop_set_chr(DEVICE(&s->usart[i]), "chardev", serial_hd(i));
+        qdev_connect_clock_in(DEVICE(&s->usart[i]), "xck", s->ioclk);
         sbd = SYS_BUS_DEVICE(&s->usart[i]);
         sysbus_realize(sbd, &error_abort);
         sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[USART(i)].addr);
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index fd0b488ef9..4a43492082 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -23,6 +23,7 @@
 #include "hw/char/avr_usart.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 
 /* Offsets of registers. */
@@ -307,12 +308,14 @@ static void avr_usart_pr(void *opaque, int irq, int level)
 static void avr_usart_init(Object *obj)
 {
     AVRUsartState *s = AVR_USART(obj);
+
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rxc_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->dre_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->txc_irq);
     memory_region_init_io(&s->mmio, obj, &avr_usart_ops, s, TYPE_AVR_USART, 7);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     qdev_init_gpio_in(DEVICE(s), avr_usart_pr, 1);
+    s->clkin = qdev_init_clock_in(DEVICE(obj), "xck", NULL, s);
     s->enabled = true;
 }
 
-- 
2.21.3


