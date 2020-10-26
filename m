Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8D8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD9A20878
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn3wFgzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD9A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXApo-0008Pv-25
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXAdg-0008UW-E2; Mon, 26 Oct 2020 18:06:52 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:43217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXAdd-0005mh-4r; Mon, 26 Oct 2020 18:06:51 -0400
Received: by mail-ej1-x62c.google.com with SMTP id k3so16073952ejj.10;
 Mon, 26 Oct 2020 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5zqlhU2r4BQ3aIQwHO70lpJ2+WZUGh9Je97I/fi+pKw=;
 b=Hn3wFgzhzNZbBQ7X74Bip28TTQsPDzSL3yXP5fIv2S+2E1ZELGXy0zVRoh7QNzAn5z
 B/pgTakNCEGG7m/EV+gtIDHsYG7Hcmbfdh9RKxiDeFIZQEmNUBnJiAZ3cpwrbs58tyx2
 cZWnwOd2HdBODgKSYlsdxVJlq7aXJcwvmKCVSdkjku9s0nnFfrXDzcmww7KjZUxTkwy0
 X/rHoXmCTNPgR0Pup6hjXuwg/H33wJmi3INoTecuzOCdVYEmDaSW8/BDBAeWqx/4JKvR
 ucLTQN99ERCooUXxcjXkvSVdKaujez5Q1Hyb6AMiuAq2cU7td5wKjzIDVq2hIA7lofjb
 HA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5zqlhU2r4BQ3aIQwHO70lpJ2+WZUGh9Je97I/fi+pKw=;
 b=CgHHbLexy6O15QlBwJDD4dTOPyqw8TvSuLfW4Q0twi9EcxPdFe7jU9hrV0ycEqS7sc
 dBphx4rRZpE1duAG/E9S0amLb2BTn4S2tw+BhOnMWytli9dYaT6kPBK90+kmN8h1xBO8
 iJtLS+OewKgVunwmrtH0nX7jXyG6s8q6O3Bq+73/NqOz1l0DidcPDveUixOR7AQfftlr
 z8xAc2zbrztpAfpyQvgjLjf8ejQE9D78GanLmD5mQCbk3uCwbd2gf4hswvdQH9aruiAA
 XwT0SSqMHGVjiU3GW9QPl6c9g47MLV3g141ltN3xZHGQYJKhPL1Yi2ZXmAFX83e7dSnH
 Eqyw==
X-Gm-Message-State: AOAM53245BUQSd+E58+h5CiiE/aUc0G/U6ue+6ijWl+q9saYBjciyGYP
 J53UrJfEPi8gDEkfXDqCCWW8l8PPoHM=
X-Google-Smtp-Source: ABdhPJxq+noztl/cIokYyuQcHL1f3dZ0hYcmpuOG3d5h163cM0b55EFg2pVRlXqZbHMYNck2kUNgdw==
X-Received: by 2002:a17:906:c149:: with SMTP id
 dp9mr8509956ejc.88.1603750005200; 
 Mon, 26 Oct 2020 15:06:45 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z23sm6608971ejj.52.2020.10.26.15.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 15:06:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/7] hw/misc/led: Emit a trace event when LED intensity has
 changed
Date: Mon, 26 Oct 2020 23:06:20 +0100
Message-Id: <20201026220624.60878-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026220624.60878-1-f4bug@amsat.org>
References: <20201026220624.60878-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Track the LED intensity, and emit a trace event when it changes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200912134041.946260-4-f4bug@amsat.org>
---
 hw/misc/led.c        | 4 ++++
 hw/misc/trace-events | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/misc/led.c b/hw/misc/led.c
index c5fa09a613a..5266d026d0b 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -41,6 +41,10 @@ void led_set_intensity(LEDState *s, unsigned intensity_percent)
         intensity_percent = LED_INTENSITY_PERCENT_MAX;
     }
     trace_led_set_intensity(s->description, s->color, intensity_percent);
+    if (intensity_percent != s->intensity_percent) {
+        trace_led_change_intensity(s->description, s->color,
+                                   s->intensity_percent, intensity_percent);
+    }
     s->intensity_percent = intensity_percent;
 }
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 2b6310dbe4b..6bf7ce863fb 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -225,6 +225,7 @@ grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx6
 
 # led.c
 led_set_intensity(const char *color, const char *desc, uint8_t intensity_percent) "LED desc:'%s' color:%s intensity: %u%%"
+led_change_intensity(const char *color, const char *desc, uint8_t old_intensity_percent, uint8_t new_intensity_percent) "LED desc:'%s' color:%s intensity %u%% -> %u%%"
 
 # pca9552.c
 pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
-- 
2.26.2


