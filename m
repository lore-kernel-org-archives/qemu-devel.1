Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCD8C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCA1206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ND0BwB2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCA1206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8cX-0007E0-Ou
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZV-0001nb-56
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:17 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZU-00070P-7m
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id 50so10453147wrc.11
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JEvempOs4qwCLlW8+Q/mQ4vm2AHnJE/FFxeayEtZ2rg=;
 b=ND0BwB2qLdk0USt8J04Shxk31omqX3pgStx/xXqVLqrwNOFd8PDM+IItgVYrQxcYd9
 Z1/SJ6ko9rP0MEaRWvdsbaTdQ4NOUs5Jx5Y6xqNoTCaJh2ysrQhcvR7Jg+CEejQpnEDP
 0UzxRgFzarDmIKcNhGxUNZoxjyqjtkVLIIgaT/NYM4J+3tQs7FPTSNKCs46xAFuKy46k
 GGZZi7a+6snW+HyWHp/zQKvuAZoL+0q8BLYPREc13/YeWH/PPnxf0K45w7RRExlzk/oi
 7sq3P6qC6Mhgo+N3ujLxD+M2OEi2GJO/q83rO821mcUouBU2pIysXMSsCXbKCvvbS3ie
 79gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JEvempOs4qwCLlW8+Q/mQ4vm2AHnJE/FFxeayEtZ2rg=;
 b=CPE6YXDwSANB/nQ9bZxcr4wFm2LclG8+DP2tGRZtjPxhnr3mo70ZdPJyZc7FDV3dza
 aIwMC6iz19HsuwZ4wIbeatS+dn57Je5aGipK/72HIaO5PiB+F2h2PtSvkJQhf5E0NEDD
 84+MD7u23VVcTEEPUhiegdBQS2wZTncm/2nBgjQCoAI5ZTmgHs6gddrjwd2m6nNm627W
 YncI6LaJvAoMJ4mHC624Dodaxhh20TDkHt6DlcF6N6mwGZ+YkZJhqT6AO3D2vO4DSBDI
 Tztuzf1u5DLEfwXxKfjRYOoAEElsxwaegwGa8AS7lG9xnr53pBXDIqvciEFXQFB+4xux
 uU5A==
X-Gm-Message-State: AGi0PuZ1jRzJVxFH0J6HHJJil6DMD3u94qXJNuajjpBA6xjEX46+ss2G
 ooB17dzluRyhdVXH4zBSFfh/sx2k3w1zmw==
X-Google-Smtp-Source: APiQypJ9Q49j2E+xgorTERhSnr+0UiGin//+C7BWrqeK6MA/QipHkHQXguqVVFfx7JdybLm2WGbfIA==
X-Received: by 2002:adf:afd6:: with SMTP id y22mr18779187wrd.417.1589204054485; 
 Mon, 11 May 2020 06:34:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/34] hw/timer/nrf51_timer: Display timer ID in trace events
Date: Mon, 11 May 2020 14:33:37 +0100
Message-Id: <20200511133405.5275-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The NRF51 series SoC have 3 timer peripherals, each having
4 counters. To help differentiate which peripheral is accessed,
display the timer ID in the trace events.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200504072822.18799-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/timer/nrf51_timer.h |  1 +
 hw/arm/nrf51_soc.c             |  5 +++++
 hw/timer/nrf51_timer.c         | 11 +++++++++--
 hw/timer/trace-events          |  4 ++--
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/hw/timer/nrf51_timer.h b/include/hw/timer/nrf51_timer.h
index 85cad2300df..eb6815f21d7 100644
--- a/include/hw/timer/nrf51_timer.h
+++ b/include/hw/timer/nrf51_timer.h
@@ -59,6 +59,7 @@ typedef struct NRF51TimerState {
     MemoryRegion iomem;
     qemu_irq irq;
 
+    uint8_t id;
     QEMUTimer timer;
     int64_t timer_start_ns;
     int64_t update_counter_ns;
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index e50473fd199..71309e53cc8 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -150,6 +150,11 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* TIMER */
     for (i = 0; i < NRF51_NUM_TIMERS; i++) {
+        object_property_set_uint(OBJECT(&s->timer[i]), i, "id", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index bc82c85a6f2..38cea0542e1 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -17,6 +17,7 @@
 #include "hw/arm/nrf51.h"
 #include "hw/irq.h"
 #include "hw/timer/nrf51_timer.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
@@ -185,7 +186,7 @@ static uint64_t nrf51_timer_read(void *opaque, hwaddr offset, unsigned int size)
                       __func__, offset);
     }
 
-    trace_nrf51_timer_read(offset, r, size);
+    trace_nrf51_timer_read(s->id, offset, r, size);
 
     return r;
 }
@@ -197,7 +198,7 @@ static void nrf51_timer_write(void *opaque, hwaddr offset,
     uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     size_t idx;
 
-    trace_nrf51_timer_write(offset, value, size);
+    trace_nrf51_timer_write(s->id, offset, value, size);
 
     switch (offset) {
     case NRF51_TIMER_TASK_START:
@@ -372,12 +373,18 @@ static const VMStateDescription vmstate_nrf51_timer = {
     }
 };
 
+static Property nrf51_timer_properties[] = {
+    DEFINE_PROP_UINT8("id", NRF51TimerState, id, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void nrf51_timer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = nrf51_timer_reset;
     dc->vmsd = &vmstate_nrf51_timer;
+    device_class_set_props(dc, nrf51_timer_properties);
 }
 
 static const TypeInfo nrf51_timer_info = {
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 29fda7870e0..43b605cc759 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -67,8 +67,8 @@ cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK
 cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
 
 # nrf51_timer.c
-nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+nrf51_timer_read(uint8_t timer_id, uint64_t addr, uint32_t value, unsigned size) "timer %u read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+nrf51_timer_write(uint8_t timer_id, uint64_t addr, uint32_t value, unsigned size) "timer %u write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 
 # bcm2835_systmr.c
 bcm2835_systmr_irq(bool enable) "timer irq state %u"
-- 
2.20.1


