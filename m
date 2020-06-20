Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04BAC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89026246EF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKh/GdEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89026246EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmgI-0000ze-Rj
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmaE-0007GQ-TX; Sat, 20 Jun 2020 19:07:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmaD-0002N8-8M; Sat, 20 Jun 2020 19:07:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id l10so13144728wrr.10;
 Sat, 20 Jun 2020 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dqGlIc+jv7onYHOT7vp+iSAvaDEPRQt/mIvRK1NcKyk=;
 b=jKh/GdEt/HW1QsvtpsCneycRhcGokA0wBKP/6lBsRCfkrMDNOJ24oFuVM5dp7qf49q
 3XpqVv0Do4gzwzvLLxvp+fm9s7yMpLfVffjOD8zlEc6U7wRJUpvlhUvzArbbhmrPDA/5
 Wnfmds4aTncR9Whux0eiOXQbzHBIc+bCFqHIJmEb787CtAkThq1xO4YIKqT/jzT4DC1z
 b6xvS0jcZ7o8/rogUANGVIZptHGsjR8TjSmPZNySQDtGhKACbFlKT7jYzQF3MkZdWzx6
 agGW2cyofSRw6fufORUzkW75mjfkSRCGIK6a0Ha+fou0kvLBMH6shcYbhGXaqyz6ZBsr
 ixeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dqGlIc+jv7onYHOT7vp+iSAvaDEPRQt/mIvRK1NcKyk=;
 b=dRamd0R1/XvNh7/PnqnnW2Ds02TlGNR53LwCnjVklrEx87Q2+LsXmU00TfF9wHkjmq
 bTX66+yWGn/tOIBrxeV7/11Y3G8+fE8dJ/m4bVL0OZom3eSAryQjYuLkczNtOJrl7qmP
 uK+8b0mYEGm6WDaX0Ff2WcdwltlbsFe3R+da2XCyTOhpgwFA4qk4zo9oaXsY1jrPcXuk
 IF3O3IWaPOn5Co+ZFZWPPuUsm+2zjQDveBRY6fb6OgaA+hVK2kujhgnUCGaA0Gp2Aa/h
 zW8OlsPg0vcm2ToV7bQvT12QZKs/YpJC0o8WQD2lvS+ik9g2SFYxa//BkewDr8OBMoFF
 kj1w==
X-Gm-Message-State: AOAM533hBsyL7nlz0Y0Rtns5y35PKuNCjE2Ss6RT9oBdgxV0BgRIHwAt
 anrp5xP6u0THXcHh7AwWsHYat6yE
X-Google-Smtp-Source: ABdhPJxQ2xwfMc7RNoy61gt7hL3XowZlJJt/Ffbes6D8Zn9Rt97UaK2OeetCreMBGUf/xeate7Ql0Q==
X-Received: by 2002:a5d:45cb:: with SMTP id b11mr10617176wrs.235.1592694451400; 
 Sat, 20 Jun 2020 16:07:31 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o82sm11455037wmo.40.2020.06.20.16.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 16:07:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/7] hw/arm/tosa: Replace fprintf() calls by LED devices
Date: Sun, 21 Jun 2020 01:07:19 +0200
Message-Id: <20200620230719.32139-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200620230719.32139-1-f4bug@amsat.org>
References: <20200620230719.32139-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The recently added LED device reports LED status changes with
the 'led_set_intensity' trace event. It is less invasive than
the fprintf() calls. We need however to have a binary built
with tracing support.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/tosa.c  | 40 +++++++++++++---------------------------
 hw/arm/Kconfig |  1 +
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 5dee2d76c6..74b5fd1049 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -24,6 +24,7 @@
 #include "hw/irq.h"
 #include "hw/ssi/ssi.h"
 #include "hw/sysbus.h"
+#include "hw/misc/led.h"
 #include "exec/address-spaces.h"
 
 #define TOSA_RAM    0x04000000
@@ -65,27 +66,6 @@ static void tosa_microdrive_attach(PXA2xxState *cpu)
     pxa2xx_pcmcia_attach(cpu->pcmcia[0], md);
 }
 
-static void tosa_out_switch(void *opaque, int line, int level)
-{
-    switch (line) {
-        case 0:
-            fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
-            break;
-        case 1:
-            fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
-            break;
-        case 2:
-            fprintf(stderr, "amber LED %s.\n", level ? "on" : "off");
-            break;
-        case 3:
-            fprintf(stderr, "wlan LED %s.\n", level ? "on" : "off");
-            break;
-        default:
-            fprintf(stderr, "Uhandled out event: %d = %d\n", line, level);
-            break;
-    }
-}
-
 static void tosa_reset(void *opaque, int line, int level)
 {
     if (level) {
@@ -98,7 +78,6 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
                 DeviceState *scp1,
                 TC6393xbState *tmio)
 {
-    qemu_irq *outsignals = qemu_allocate_irqs(tosa_out_switch, cpu, 4);
     qemu_irq reset;
 
     /* MMC/SD host */
@@ -119,11 +98,6 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
                         qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_JC_CF_IRQ),
                         NULL);
 
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED, outsignals[0]);
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED, outsignals[1]);
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED, outsignals[2]);
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED, outsignals[3]);
-
     qdev_connect_gpio_out(scp1, TOSA_GPIO_TC6393XB_L3V_ON, tc6393xb_l3v_get(tmio));
 
     /* UDC Vbus */
@@ -234,6 +208,18 @@ static void tosa_init(MachineState *machine)
 
     scp0 = sysbus_create_simple("scoop", 0x08800000, NULL);
     scp1 = sysbus_create_simple("scoop", 0x14800040, NULL);
+    create_led_by_gpio_id(OBJECT(machine), DEVICE(scp1),
+                          TOSA_GPIO_BT_LED,
+                          LED_COLOR_BLUE, "bluetooth", 0);
+    create_led_by_gpio_id(OBJECT(machine), DEVICE(scp1),
+                          TOSA_GPIO_NOTE_LED,
+                          LED_COLOR_GREEN, "note", 1);
+    create_led_by_gpio_id(OBJECT(machine), DEVICE(scp1),
+                          TOSA_GPIO_CHRG_ERR_LED,
+                          LED_COLOR_AMBER, "charger-error", 2);
+    create_led_by_gpio_id(OBJECT(machine), DEVICE(scp1),
+                          TOSA_GPIO_WLAN_LED,
+                          LED_COLOR_GREEN, "wlan", 3);
 
     tosa_gpio_setup(mpu, scp0, scp1, tmio);
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 1a57a861ac..057c869d65 100644
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


