Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0477DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34342074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxzkE+kN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34342074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8B8-0001y1-0H
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl8AB-0000rW-Nq; Tue, 16 Jun 2020 05:45:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:34963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl8A9-000265-RG; Tue, 16 Jun 2020 05:45:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id q25so2387420wmj.0;
 Tue, 16 Jun 2020 02:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pfO7RXZ9AYJ/DjgBHj2w4iXg2BcEpoZpY+MZ/Colj/Q=;
 b=KxzkE+kN8d+/yMtCLY1rzEEnkce4mOs2MuyvzONtDwHw1al6D8OQMOW6ZAr0lKDYAl
 6jivjgal0lK8KKlIWNfNyx/+eEnjViaDyH5nYwjfbntGqQDoXl2QurpPyTm+Ehl+TQtN
 32x4W+MMV/eFcU1th8H9ebPPrJ9iPy2aWGIu0Z9pFdUvvfa+ZQ4jAQxStV9/dIN4zUBu
 GmFzdfR9c74wLiX9tz+8N1o65kv4b3E0GSb5/3n5Lu/P5GIzk4AgnFNH236C6ri5AI7t
 gdrZpRmvIzG9O2ygbuOZQCZ6qVywbB7qVLCndMrC60xPEJ7yFQ9XiR7mq/EqdMbNw74e
 tjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pfO7RXZ9AYJ/DjgBHj2w4iXg2BcEpoZpY+MZ/Colj/Q=;
 b=um1IGh5n2rh0lHCJlMcsuEUY/V2anqtjt/VvD4gmXhgUxf2H+UO3qEvcvOO9VSCAVH
 pNV0+aBM863VrwRnjDCm9Tmp3K+TmdKiAJ3120owH0EIzXjt+4ALhFtSmSgSoMG7+5ip
 qVYZ7+eGmuV9KZTtmZdHqXguxw7kyhxtUNrAeq7j84Ju08v03juinUYr3KDs1WNhJPs6
 TAdwmB31Val6ycZAw/Lfv/n0s0XGdW9ewvfdaX367z+gRIDp2bQAK2LasT4subD6DNYg
 LtxZtr2bMs+X4HOUfR20WYmU9s4tIh5ram81JT6Q1DRBtrqtyyzdsUmXkO3wnkOeBbYW
 OWgA==
X-Gm-Message-State: AOAM531i/UxpPHxyg6W2wnAqT6+AZoQE7rakKLQFrWr93vOeMPNnDUyi
 +xsWpHGqdPcNqsItYqGZNno77svA
X-Google-Smtp-Source: ABdhPJxyn+eAAwG1pX3uM8LXYhyajmtwoVyA+glwGdnOODPzXDfMnmfDf833Wd2aOeXHmXstoE8IQA==
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr2386452wmd.127.1592300747903; 
 Tue, 16 Jun 2020 02:45:47 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o82sm3254017wmo.40.2020.06.16.02.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:45:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/misc/pca9552: Make LEDs 13-15 also GPIOs
Date: Tue, 16 Jun 2020 11:45:42 +0200
Message-Id: <20200616094542.25415-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616094542.25415-1-f4bug@amsat.org>
References: <20200616094542.25415-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x332.google.com
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
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PCA9552 has 3 GPIOs, add them.

See 'PCA9552 Product Datasheet Rev. 05 - 9 March 2006',
chapter 6.4 'Pins used as GPIOs':

  LED pins not used to control LEDs can be used as general
  purpose I/Os (GPIOs).
  For use as input, set LEDn to high-impedance (01) and then
  read the pin state via the input register.
  For use as output, connect external pull-up resistor to the
  pin and size it according to the DC recommended operating
  characteristics. LED output pin is HIGH when the output is
  programmed as high-impedance, and LOW when the output is
  programmed LOW through the ‘LED selector’ register. The
  output can be pulse-width controlled when PWM0 or PWM1 are
  used.

And chapter 8 'Application design-in information':

  LED0 to LED12 are used as LED drivers.
  LED13 to LED15 are used as regular GPIOs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/pca9552.h |  2 ++
 hw/misc/pca9552.c         | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index ebb43c63fe..7e47ea312d 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -15,6 +15,7 @@
 #define PCA9552(obj) OBJECT_CHECK(PCA9552State, (obj), TYPE_PCA9552)
 
 #define PCA9552_NR_REGS 10
+#define PCA9552_NR_GPIOS 3
 
 typedef struct PCA9552State {
     /*< private >*/
@@ -27,6 +28,7 @@ typedef struct PCA9552State {
     uint8_t regs[PCA9552_NR_REGS];
     uint8_t max_reg;
     uint8_t nr_leds;
+    qemu_irq gpio[PCA9552_NR_GPIOS];
 } PCA9552State;
 
 #endif
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index a3d0decbff..6ca6c0dbc2 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -12,8 +12,10 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/bitops.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
+#include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
@@ -48,12 +50,16 @@ static void pca9552_update_pin_input(PCA9552State *s)
             s->regs[input_reg] |= 1 << input_shift;
             if (input_shift < s->nr_leds) {
                 trace_pca9552_led_set(input_shift, true);
+            } else {
+                qemu_set_irq(s->gpio[input_shift - s->nr_leds], 1);
             }
             break;
         case PCA9552_LED_OFF:
             s->regs[input_reg] &= ~(1 << input_shift);
             if (input_shift < s->nr_leds) {
                 trace_pca9552_led_set(input_shift, false);
+            } else {
+                qemu_set_irq(s->gpio[input_shift - s->nr_leds], 0);
             }
             break;
         case PCA9552_LED_PWM0:
@@ -65,6 +71,16 @@ static void pca9552_update_pin_input(PCA9552State *s)
     }
 }
 
+static void pca9552_gpio_set(void *opaque, int n, int enable)
+{
+    PCA9552State *s = opaque;
+
+    /* LED13 to LED15 are used as regular GPIOs. */
+    s->regs[PCA9552_LS3] = deposit32(s->regs[PCA9552_LS3], n + 1, 1,
+                                     enable ? PCA9552_LED_ON : PCA9552_LED_OFF);
+    pca9552_update_pin_input(s);
+}
+
 static uint8_t pca9552_read(PCA9552State *s, uint8_t reg)
 {
     switch (reg) {
@@ -308,6 +324,8 @@ static void pca9552_initfn(Object *obj)
                             NULL, NULL);
         g_free(name);
     }
+    qdev_init_gpio_in(DEVICE(obj), pca9552_gpio_set, PCA9552_NR_GPIOS);
+    qdev_init_gpio_out(DEVICE(obj), s->gpio, PCA9552_NR_GPIOS);
 }
 
 static void pca9552_class_init(ObjectClass *klass, void *data)
-- 
2.21.3


