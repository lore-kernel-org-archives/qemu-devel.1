Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2CDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC47E217D8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoRbwSZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC47E217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmIP4-0000e4-1E
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmIMO-00044A-8i; Fri, 19 Jun 2020 10:51:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmIMH-0003gI-AI; Fri, 19 Jun 2020 10:51:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id o11so2256400wrv.9;
 Fri, 19 Jun 2020 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TQIXtSJLI5JjENe67Ipi+8d5uXeAJhyCfAa9D+kxU/g=;
 b=uoRbwSZm+L9xhgmRaY2MHMY4Qm4lK5ZKhzayABUp2IlkIplF0P2+9sBQJ9Lc0brvEO
 smeAqqdOT1D/GBUcIyx/mDNYE73QX6+RtBM5e0rH7MOyKShCOHVqSSddApteHhoC5giP
 3N6nQfMqtri74mOOhxsGcRzmwn7xhJJe22mUh3x/W6CEhMKqfzVpanrFrM4B1SAD+A1c
 GgPoRIwK4iFVyjzzf894nf5qerCntU1sYo7wTpHD4waSf0jIKN679Yem4lo35WNngg2+
 7ENpvzizhjW51hBdWV3ImLvNQ/G7YwtkKQK4R07PeP19/s0UMOCwq77JXmcmhREuy+S/
 tPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TQIXtSJLI5JjENe67Ipi+8d5uXeAJhyCfAa9D+kxU/g=;
 b=TF7itPwW+ClRznICMMT1SszculRfsbGu6l75gOOC3GnqFthrtBO6EK4LaXr1Zct4M6
 MyaDsY3/Cb5DiHLJxEDeGl6cf1Qn9fgsFBfsJ4anTSuUvafCDfb6qj8JQiXp+dsp1Lze
 bC5SYMCvlH1PgrTZ4bN+A1G/eXJ+soqa4+d/pmDC9W1YdI9LrtDRx6Gi6VXGf+aZYQTJ
 k4jK1e2WJ+lUcTammG1UmtrwPk825NIsD2yKV1jhWcG+WaoghV72J+vIee+WT1d8ljbw
 /LWoJz/yVmOXd5Nep0lDYlyKN0FhK47KEfLZxU+KbEg3awfFgfpT/JG5KPWxApI4vZaV
 SacA==
X-Gm-Message-State: AOAM533XXar3T4TtuEgPJeLAQ4HI9pOw1+MR09XbG07UEeJnoLGhROqw
 WFdb5x0aYiZasQurTo6WO60043Sz
X-Google-Smtp-Source: ABdhPJxcC57NgYaJSnls9KxA8eFSXqY93ruQtXaaa9HkahBjbJHasGM6jQ4y7kO+CcYr+HPeSZJleA==
X-Received: by 2002:adf:f512:: with SMTP id q18mr4869863wro.38.1592578267419; 
 Fri, 19 Jun 2020 07:51:07 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id e12sm7512548wro.52.2020.06.19.07.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 07:51:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] hw/misc/pca9552: Trace LED On/Off events
Date: Fri, 19 Jun 2020 16:51:00 +0200
Message-Id: <20200619145101.1637-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200619145101.1637-1-f4bug@amsat.org>
References: <20200619145101.1637-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a trivial representation of the PCA9552 LEDs.

Example booting obmc-phosphor-image:

  $ qemu-system-arm -M witherspoon-bmc -trace pca9552_leds_status
  19286@1592574170.202791:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [*...............]
  19286@1592574170.203609:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [**..............]
  19286@1592574170.204102:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [***.............]
  19286@1592574170.204415:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****............]
  19286@1592574170.204758:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........*..]
  19286@1592574170.205070:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........**.]
  19286@1592574170.205380:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........***]
  19286@1592574235.384845:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........*.*]
  19286@1592574235.894049:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........***]
  19286@1592574236.404277:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........*.*]
  19286@1592574236.914644:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........***]
  19286@1592574237.424558:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........*.*]
  19286@1592574237.934580:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........***]
  19286@1592574238.444688:pca9552_leds_status 0x55dde47807c0 LEDs 0-15 [****.........*.*]

We notice the LED #14 (front-power LED) starts to blink.

This LED is described in the witherspoon device-tree [*]:

  front-power {
      retain-state-shutdown;
      default-state = "keep";
      gpios = <&pca0 14 GPIO_ACTIVE_LOW>;
  };

[*] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts?id=b1f9be9392f0#n140

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/pca9552.h |  1 +
 hw/misc/pca9552.c         | 29 +++++++++++++++++++++++++++++
 hw/misc/trace-events      |  3 +++
 3 files changed, 33 insertions(+)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index b2b9a5d9d4..4e171d88c6 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -26,6 +26,7 @@ typedef struct PCA9552State {
     uint8_t pointer;
 
     uint8_t regs[PCA9552_NR_REGS];
+    uint16_t leds_status; /* Holds latest INPUT0 & INPUT1 status */
     uint8_t max_reg;
     uint8_t nr_leds;
 } PCA9552State;
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 00fa91b7f4..50c149077d 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -12,11 +12,13 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/bitops.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "trace.h"
 
 #define PCA955X_LED_MAX 16
 
@@ -60,6 +62,32 @@ static void pca9552_update_pin_input(PCA9552State *s)
     }
 }
 
+static void pca9552_display_leds(PCA9552State *s)
+{
+    uint16_t leds_status, led_changed;
+    int i;
+
+    leds_status = (s->regs[PCA9552_INPUT1] << 8) | s->regs[PCA9552_INPUT0];
+    led_changed = s->leds_status ^ leds_status;
+    if (!led_changed) {
+        return;
+    }
+    s->leds_status = leds_status;
+    if (trace_event_get_state_backends(TRACE_PCA9552_LEDS_STATUS)) {
+        char buf[PCA9552_LED_COUNT + 1];
+
+        for (i = 0; i < s->nr_leds; i++) {
+            if (extract32(leds_status, i, 1)) {
+                buf[i] = '*';
+            } else {
+                buf[i] = '.';
+            }
+        }
+        buf[i] = '\0';
+        trace_pca9552_leds_status(s, buf);
+    }
+}
+
 static uint8_t pca9552_read(PCA9552State *s, uint8_t reg)
 {
     switch (reg) {
@@ -97,6 +125,7 @@ static void pca9552_write(PCA9552State *s, uint8_t reg, uint8_t data)
     case PCA9552_LS3:
         s->regs[reg] = data;
         pca9552_update_pin_input(s);
+        pca9552_display_leds(s);
         break;
 
     case PCA9552_INPUT0:
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 5561746866..5d9505ad0f 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
 # grlib_ahb_apb_pnp.c
 grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
 grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
+
+# pca9552.c
+pca9552_leds_status(void *object, const char *buf) "%p LEDs 0-15 [%s]"
-- 
2.21.3


