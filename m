Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5299C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BE3207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSls7Xr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BE3207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjnwN-0003So-SB
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 13:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjntT-0006u2-AN; Fri, 12 Jun 2020 13:55:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35311)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjntR-0004Cg-PU; Fri, 12 Jun 2020 13:55:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id q25so9089779wmj.0;
 Fri, 12 Jun 2020 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oEq0TkRWvRrnUcFx8Wkpo5gILqhLeSIEML9csKX17G0=;
 b=tSls7Xr5NRKPwqv8Uq1rteK3FiLDw0JpmsDJBUlOqLAVB07fOIo/2FW1zhQyLP9mCP
 N9RAN6zh4XnwRZ4hBy+MV/pL74wlStmb8tVZnBcrEjXQSZc8Xjv4UqiMht8d3/3axt7t
 2dAVOnns/s6fVtGpzUkpCEXp2QxHpiD1KobI6g/31cA77cne5VgR+GYJgYrYaccNRUFW
 jpuVrWm8neM9sUCQZ86zJLmg6cx1UX+Xtwc1RVcBzHLMxS1HsAL9iB/gAPE+zwJET6as
 SW8s9eIBz/CW8QK0IC8vF9EYs5SiJA1y5A+9JoJztSeIFO3ZPgNUC8Kf3MnTQJ5Qaay+
 2/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oEq0TkRWvRrnUcFx8Wkpo5gILqhLeSIEML9csKX17G0=;
 b=WchU8aXLnAX7gddi5DWMZpnaxgv0L935OAm98n8B3q9EA7IyB4U313C4ftyScqPufh
 OKkrWoQ70viq5wt3i9dF38WWb83w77SNx0o5apvsXvtPOP3UztvXaZEbzwVEVPAupwm6
 hBJRCKxHAt65RvqJjIba/Xc2ZTvXQnc5wYHVVFWx9lezSwSMUR3nFqVKSIxwnuw/7ZW9
 BOlolduzty94+woE9YxZsg8zwZaO2KlKpvTPPoqgwExiourTxtie2Q30eY9eAAPww1Y/
 me1jvBNAmSKRHP+3FqzrEMAi1ST6yHWtAAeIEmOKthNsmUC424ewPIgIJPmVbjl31cmd
 BlAw==
X-Gm-Message-State: AOAM5330zlyC6Qgl+T6umrt4q+PXFT6Uw8dQiRqJpwFOs5br7g6U5ECC
 cHZjf2ORj9LLMJX8wTj6P58+TrBC
X-Google-Smtp-Source: ABdhPJz49odJZuQjyI2HnB6Qn/Vvh6TN/jwHkmxFCwKpxG+DFP6i/o7nOBue1IJbVBHXLnyFDdQtDw==
X-Received: by 2002:a1c:ddc1:: with SMTP id u184mr74492wmg.115.1591984491897; 
 Fri, 12 Jun 2020 10:54:51 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id e12sm11288658wro.52.2020.06.12.10.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 10:54:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 5/5] hw/arm/tosa: Use LED device for the Bluetooth led
Date: Fri, 12 Jun 2020 19:54:40 +0200
Message-Id: <20200612175440.9901-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612175440.9901-1-f4bug@amsat.org>
References: <20200612175440.9901-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Esteban Bosse <estebanbosse@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/tosa.c  | 7 +++----
 hw/arm/Kconfig | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 5dee2d76c6..86d7e0283a 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -24,6 +24,7 @@
 #include "hw/irq.h"
 #include "hw/ssi/ssi.h"
 #include "hw/sysbus.h"
+#include "hw/misc/led.h"
 #include "exec/address-spaces.h"
 
 #define TOSA_RAM    0x04000000
@@ -68,9 +69,6 @@ static void tosa_microdrive_attach(PXA2xxState *cpu)
 static void tosa_out_switch(void *opaque, int line, int level)
 {
     switch (line) {
-        case 0:
-            fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
-            break;
         case 1:
             fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
             break;
@@ -119,7 +117,6 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
                         qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_JC_CF_IRQ),
                         NULL);
 
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED, outsignals[0]);
     qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED, outsignals[1]);
     qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED, outsignals[2]);
     qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED, outsignals[3]);
@@ -234,6 +231,8 @@ static void tosa_init(MachineState *machine)
 
     scp0 = sysbus_create_simple("scoop", 0x08800000, NULL);
     scp1 = sysbus_create_simple("scoop", 0x14800040, NULL);
+    create_led_by_gpio_id(OBJECT(machine), DEVICE(scp1),
+                          TOSA_GPIO_BT_LED, "blue LED");
 
     tosa_gpio_setup(mpu, scp0, scp1, tmio);
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2afaa7c8e9..009336cac8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -150,6 +150,7 @@ config TOSA
     select ZAURUS  # scoop
     select MICRODRIVE
     select PXA2XX
+    select LED
 
 config SPITZ
     bool
-- 
2.21.3


