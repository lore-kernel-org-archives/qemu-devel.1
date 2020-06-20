Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CA1C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFE220757
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUM2UYrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFE220757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmU2-0004WT-8F
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmS6-00010E-9J; Sat, 20 Jun 2020 18:59:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmS4-0000yq-K1; Sat, 20 Jun 2020 18:59:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id q2so10709641wrv.8;
 Sat, 20 Jun 2020 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gvoEXdIxYQqhIJHdWM52DnB0B20B8eCcffJMhifuxRg=;
 b=jUM2UYrQRb++KYNo5KCjYsGLt0ZR3JYJx1g5W8pI+dSxzP4+AN0mLswLtC1oPPWI5l
 FK2qqgj8qmBdd3/RXT3WYVMW6UJsg0QnjWGHKbRvyRX1YyUPVEjGJUOqwGvr2KTTehMF
 zFOIGUlfv54q8RfbzEUYi/mlb6a3jV3wlgYqfdCa5wIPgG3VckVq3a0krdyi5+bZq4fO
 hHuHKehONT1RsX8/bCuWjyQ8k8VLUBpaHzAIQrWf8ZaoSGhrmgbn8oDInnTpFRfeaHXH
 hzVP01c8oV4Q0jRLE6Klyu6TZ4mwVyPa7yFTy0ALd8yP/64lQSZxSiOUpLVgWGmXNpgP
 jChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gvoEXdIxYQqhIJHdWM52DnB0B20B8eCcffJMhifuxRg=;
 b=svs6RdtY3FG3sPFiqglHmr4hYqJ2sGjnKIvT8wEPLhTUWChUnEZTT44wzxxuHWYFdT
 BNa7yYMWPYqI1IUMLHAAJyWHkK+UlWGdeP32i63r02jKlnteGb3duDtE9d8faaWCcsDy
 yN9/ZLt38n0IbYx9fVFxAMl+Gc/gOOjUjNyGP/AUM+yHJCByh3EEbM2voXhR5V/yTq8j
 T0xKlkuCGKDG7CAASZXAX37i1llnF1s8JaGMvgnkBDGNFFMZCb8EKxysGekorvlRfULQ
 V2oJETb6/arydbZv1NuG7yWl3nVNQk6rNINqyXdGKuFL+/P8HOUgLnlN2YP3wjLR6YiD
 DmSw==
X-Gm-Message-State: AOAM5330QQnVyYqy+jrcDEWSrETXWXONdza6QU5OoUePiDv1yg6u+bbY
 Ug4+DuyUjoCTA3WpQXtOhU3RsPgc
X-Google-Smtp-Source: ABdhPJxhiT/TdPY2DkLujKZ8ZcSIh45y/h8z6weh4VKdLlcWUS+CUaSplRQ+PXFITP8ctN29yJaRjg==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr10893120wro.414.1592693946775; 
 Sat, 20 Jun 2020 15:59:06 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x18sm11147127wmi.35.2020.06.20.15.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 15:59:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 7/8] hw/misc/pca9552: Trace GPIO change events
Date: Sun, 21 Jun 2020 00:58:53 +0200
Message-Id: <20200620225854.31160-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200620225854.31160-1-f4bug@amsat.org>
References: <20200620225854.31160-1-f4bug@amsat.org>
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Emit a trace event when a GPIO change its state.

Example booting obmc-phosphor-image:

  $ qemu-system-arm -M witherspoon-bmc -trace pca9552_gpio_change
  1592690552.687372:pca9552_gpio_change pca1 GPIO id:0 status: 0 -> 1
  1592690552.690169:pca9552_gpio_change pca1 GPIO id:1 status: 0 -> 1
  1592690552.691673:pca9552_gpio_change pca1 GPIO id:2 status: 0 -> 1
  1592690552.696886:pca9552_gpio_change pca1 GPIO id:3 status: 0 -> 1
  1592690552.698614:pca9552_gpio_change pca1 GPIO id:13 status: 0 -> 1
  1592690552.699833:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
  1592690552.700842:pca9552_gpio_change pca1 GPIO id:15 status: 0 -> 1
  1592690683.841921:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
  1592690683.861660:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
  1592690684.371460:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
  1592690684.882115:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
  1592690685.391411:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
  1592690685.901391:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1
  1592690686.411678:pca9552_gpio_change pca1 GPIO id:14 status: 1 -> 0
  1592690686.921279:pca9552_gpio_change pca1 GPIO id:14 status: 0 -> 1

We notice the GPIO #14 (front-power LED) starts to blink.

This LED is described in the witherspoon device-tree [*]:

  front-power {
      retain-state-shutdown;
      default-state = "keep";
      gpios = <&pca0 14 GPIO_ACTIVE_LOW>;
  };

[*] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts?id=b1f9be9392f0#n140

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/pca9552.c    | 15 +++++++++++++++
 hw/misc/trace-events |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index f0d435e310..85557b78d9 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -60,6 +60,21 @@ static void pca9552_display_pins_status(PCA9552State *s)
         buf[i] = '\0';
         trace_pca9552_gpio_status(s->description, buf);
     }
+    if (trace_event_get_state_backends(TRACE_PCA9552_GPIO_CHANGE)) {
+        for (i = 0; i < s->nr_leds; i++) {
+            if (extract32(pins_changed, i, 1)) {
+                unsigned new_state = extract32(pins_status, i, 1);
+
+                /*
+                 * We display the state using the PCA logic ("active-high").
+                 * This is not the state of the LED, which signal might be
+                 * wired "active-low" on the board.
+                 */
+                trace_pca9552_gpio_change(s->description, i,
+                                          !new_state, new_state);
+            }
+        }
+    }
 }
 
 static void pca9552_update_pin_input(PCA9552State *s)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 7630e59652..805d2110e0 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -209,3 +209,4 @@ grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx6
 
 # pca9552.c
 pca9552_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
+pca9552_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
-- 
2.21.3


