Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875EEC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBD02474C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN0N44dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBD02474C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmWp-00019N-H8
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmS7-00012t-5X; Sat, 20 Jun 2020 18:59:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmS5-0000z5-NS; Sat, 20 Jun 2020 18:59:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so13165256wrc.7;
 Sat, 20 Jun 2020 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fgUUbNqs1y/GthnSZqBcErzrgj0mvX2yz73QOQqmCzs=;
 b=IN0N44dx5JqQpjFXPsoW6yA4CjsCHIDieV3NYwj54y4/I1VmTOqPB+6LLX1de2zhwz
 8x7p+3AFWgKwfNq0EB5YQeHquQlw3pf1hh7MNHFXEPSsxnxKd3eSczF6DPBkGzI8v+/I
 XleMDqLpzE7lazF8OnS9QBdIo2tQCOzVwx/LUDDfwOmC46iSZouPeUATAyf4FTV1I0Ze
 nV4O8gnuP1nR1YF6ZA37J/AWEMTDMyMC5MSDfnhS3WTURgKEKvZQbBFiB/HQIRQ0yEDE
 v1T2bQkLCrr0XMP1fBtX2HgywfslHzyeHDpLexjbUHWnVmP1n1dpZ4ELtahS5FMNnqfi
 QZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fgUUbNqs1y/GthnSZqBcErzrgj0mvX2yz73QOQqmCzs=;
 b=pYTj+ijUhkJc8D69dUCOfHTGsjV5/2kvV2E/Ywfr0xFXMj1+G9bB5zXWN1vnSfenNU
 lYfvziIgM6vamucj9MIHQwQOCqBm4RuEPjC3KMPDoppQlDrByeK7XWeaxg8OcL0QLGk7
 9RsC3QBGFxhTPcCqFZuDAcm6XpEgrz2/ikhGbe8jY7835zJSaRU9ocxdy7MrX4T11wNl
 2ckd6l1ZpsJkj0YsUmpNwk368pSqoaytWmvvpRxP6cn1JGiyTZ7LNxGZPz1We+jMJt9C
 MbCAuvgB77eqWm4jFG1n0LMMdHJ3ZcUO5tYJgvrsze4xW1FpluDrEZMmWPmFDLk2P5l0
 RqSg==
X-Gm-Message-State: AOAM530r/znj1u0QBpWJq0VbsjeAvoFom+nIPMhNKVgCwRu6qsUuxkmU
 8dxcssi3ubf/qOSQ1f1xHpcO8wFY
X-Google-Smtp-Source: ABdhPJzcbXkznWCbTX8RdKWF4Mi5SWOJni9zTP3OBw5vPvMI4OlQtTVqCxHjn8wMRjSR5/0Lh+UrNg==
X-Received: by 2002:adf:f2cd:: with SMTP id d13mr10486117wrp.378.1592693947979; 
 Sat, 20 Jun 2020 15:59:07 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x18sm11147127wmi.35.2020.06.20.15.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 15:59:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 8/8] hw/misc/pca9552: Model qdev output GPIOs
Date: Sun, 21 Jun 2020 00:58:54 +0200
Message-Id: <20200620225854.31160-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200620225854.31160-1-f4bug@amsat.org>
References: <20200620225854.31160-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PCA9552 has 16 GPIOs which can be used as input,
output or PWM mode. QEMU models the output GPIO with
the qemu_irq type. Let the device expose the 16 GPIOs
to allow us to later connect LEDs to these outputs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/pca9552.h | 1 +
 hw/misc/pca9552.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index 755be2e8e5..2545087da3 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -30,6 +30,7 @@ typedef struct PCA9552State {
     uint8_t max_reg;
     char *description; /* For debugging purpose only */
     uint8_t nr_leds;
+    qemu_irq gpio[PCA9552_PIN_COUNT];
 } PCA9552State;
 
 #endif
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 85557b78d9..8f0ce19b74 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -16,6 +16,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
+#include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
@@ -88,9 +89,11 @@ static void pca9552_update_pin_input(PCA9552State *s)
 
         switch (config) {
         case PCA9552_LED_ON:
+            qemu_set_irq(s->gpio[i], 1);
             s->regs[input_reg] |= 1 << input_shift;
             break;
         case PCA9552_LED_OFF:
+            qemu_set_irq(s->gpio[i], 0);
             s->regs[input_reg] &= ~(1 << input_shift);
             break;
         case PCA9552_LED_PWM0:
@@ -360,6 +363,7 @@ static void pca9552_realize(DeviceState *dev, Error **errp)
     if (!s->description) {
         s->description = g_strdup("pca-unspecified");
     }
+    qdev_init_gpio_out(dev, s->gpio, s->nr_leds);
 }
 
 static Property pca9552_properties[] = {
-- 
2.21.3


