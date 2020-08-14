Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8766C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775DF207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFDrudV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775DF207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cmV-00008Q-MG
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cjt-0004Dy-F1
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cjr-0002KV-Ut
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:33 -0400
Received: by mail-wm1-x341.google.com with SMTP id k20so8436903wmi.5
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hn4hL0y7ZpwSzMH1FWPCmjokpRtbCkZjalyMESN2N7M=;
 b=YFDrudV0p8Rt+yk6Zwx8X6WsKXIdMtw4EQucHrPL25x5aWmibCh/FqOQQLNLMw+5nr
 YICGcUU0ql9nca4oLJ8flwdPl0PT3SgwuZeiQDZ/WyP1isKtYOh5j7AXmY1bXnOfsgbD
 b3SdO2nhEUUwYKS+lx8CkUhyV7J1h3xyUv22F1Z9ArRFYq63Vaq2maPdoe+KBUQE+Yew
 SMvh87A+W4ZLVIbss83TWUgabpJYX/YOcnJA69LNhP5rsSWkJWdNGVo+Ceb6qFzPNc9J
 Ql+O6fd9FgF7XFCAakxD9fleATw2/RFodjeYJA0Biflj9pi5QIN6Dc87NANFWVi5kPFV
 7D1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hn4hL0y7ZpwSzMH1FWPCmjokpRtbCkZjalyMESN2N7M=;
 b=asjz0Su9/V5uIBL9xA/h9TZyaocnOHWH/Wm7m7JvERoHluWisMh39rX8pRdK6bsQvn
 TJ4oVGeQwnKCItqjPG6nw7ae0kjOcbkixtVrAiHXSQhB8zDJIrNY267UnBsTp/tMpScv
 5dJsFnVUb12yqHsV8OgSKc2UWnFXtaHBA1TB26S+jMnyOJCpqQdfHoACUoP2P9V6im4H
 sCLNEYBMlP9kJy6dV62QU0JNG6S0O16aBjHN2AKvpw8sPK+4lm1B4mSFiIOOovTyarkO
 j+jCVtPQ4hQTWTZTVnePZdD9eXbx9PaRgonkhjjJsXAVky5qtJvaPnGkNo03pVZklgTU
 gM1Q==
X-Gm-Message-State: AOAM5312IuB4MbEVzusTPs0OjxBfHJhtu1meDVt7wcKTjr9TFW6kt/b0
 9PBt62mMxaTW9yW33CTfGhngkXCloac=
X-Google-Smtp-Source: ABdhPJyNStCYxJDisiWbuES7fx01TmZg1wUt51sqBa3IW3EoCQ4MsqjZtZMrzW1OUeO6kCkrXFc1TQ==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr3095243wme.45.1597423170178; 
 Fri, 14 Aug 2020 09:39:30 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p14sm18417178wrg.96.2020.08.14.09.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 09:39:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/timer/avr_timer16: Use the Clock API
Date: Fri, 14 Aug 2020 18:39:21 +0200
Message-Id: <20200814163924.11662-3-f4bug@amsat.org>
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

Expose the 'clkt' clock source. Connect the MCU I/O clock to it.
Drop the now unused 'cpu-frequency-hz' static property.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/avr_timer16.h |  3 ++-
 hw/avr/atmega.c                |  3 +--
 hw/timer/avr_timer16.c         | 12 ++++--------
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/hw/timer/avr_timer16.h b/include/hw/timer/avr_timer16.h
index 982019d242..fb1ef5d3be 100644
--- a/include/hw/timer/avr_timer16.h
+++ b/include/hw/timer/avr_timer16.h
@@ -31,6 +31,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/hw.h"
+#include "hw/clock.h"
 
 enum NextInterrupt {
     OVERFLOW,
@@ -52,6 +53,7 @@ typedef struct AVRTimer16State {
     MemoryRegion iomem;
     MemoryRegion imsk_iomem;
     MemoryRegion ifr_iomem;
+    Clock *clkin;
     QEMUTimer *timer;
     qemu_irq capt_irq;
     qemu_irq compa_irq;
@@ -84,7 +86,6 @@ typedef struct AVRTimer16State {
     uint8_t ifr;
 
     uint8_t id;
-    uint64_t cpu_freq_hz;
     uint64_t freq_hz;
     uint64_t period_ns;
     uint64_t reset_time_ns;
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 9d814de499..f14b558140 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -332,8 +332,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
         devname = g_strdup_printf("timer%zu", i);
         object_initialize_child(OBJECT(dev), devname, &s->timer[i],
                                 TYPE_AVR_TIMER16);
-        object_property_set_uint(OBJECT(&s->timer[i]), "cpu-frequency-hz",
-                                 s->xtal_freq_hz, &error_abort);
+        qdev_connect_clock_in(DEVICE(&s->timer[i]), "clkt", s->ioclk);
         sbd = SYS_BUS_DEVICE(&s->timer[i]);
         sysbus_realize(sbd, &error_abort);
         sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[idx].addr);
diff --git a/hw/timer/avr_timer16.c b/hw/timer/avr_timer16.c
index c48555da52..7634fe6587 100644
--- a/hw/timer/avr_timer16.c
+++ b/hw/timer/avr_timer16.c
@@ -35,6 +35,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/avr_timer16.h"
 #include "trace.h"
@@ -167,7 +168,7 @@ static void avr_timer16_clksrc_update(AVRTimer16State *t16)
         break;
     }
     if (divider) {
-        t16->freq_hz = t16->cpu_freq_hz / divider;
+        t16->freq_hz = clock_get_hz(t16->clkin) / divider;
         t16->period_ns = NANOSECONDS_PER_SECOND / t16->freq_hz;
         trace_avr_timer16_clksrc_update(t16->freq_hz, t16->period_ns,
                                         (uint64_t)(1e6 / t16->freq_hz));
@@ -544,8 +545,6 @@ static const MemoryRegionOps avr_timer16_ifr_ops = {
 
 static Property avr_timer16_properties[] = {
     DEFINE_PROP_UINT8("id", struct AVRTimer16State, id, 0),
-    DEFINE_PROP_UINT64("cpu-frequency-hz", struct AVRTimer16State,
-                       cpu_freq_hz, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -564,6 +563,8 @@ static void avr_timer16_init(Object *obj)
 {
     AVRTimer16State *s = AVR_TIMER16(obj);
 
+    s->clkin = qdev_init_clock_in(DEVICE(obj), "clkt", NULL, s);
+
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->capt_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compa_irq);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->compb_irq);
@@ -587,11 +588,6 @@ static void avr_timer16_realize(DeviceState *dev, Error **errp)
 {
     AVRTimer16State *s = AVR_TIMER16(dev);
 
-    if (s->cpu_freq_hz == 0) {
-        error_setg(errp, "AVR timer16: cpu-frequency-hz property must be set");
-        return;
-    }
-
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, avr_timer16_interrupt, s);
     s->enabled = true;
 }
-- 
2.21.3


