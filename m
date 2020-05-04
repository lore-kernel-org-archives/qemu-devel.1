Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F86C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 07:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E51620735
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 07:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVfYczXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E51620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVVaq-0001nX-Bz
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 03:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVVWh-00062H-Ib; Mon, 04 May 2020 03:28:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVVWg-000644-Pn; Mon, 04 May 2020 03:28:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id l18so8882729wrn.6;
 Mon, 04 May 2020 00:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NmgzSAKKhE63JGc7KiZaWfPFcEP9GIaik5bYtHzc0+Y=;
 b=iVfYczXvoJQwtj6PH14fEnY/L0H/c5bU3pAvHp2tDz76/TfqEUO22DBsg7yCqXt7Xy
 nQ51JXs4+MmEOAvJPXovtgLhXyjtXxhwoaxaq+7i/+4VaEctKGduf71NqM8PX6lyMYwg
 EtA9FnyvgjKxR1cBbNdYKCFV4t9nh8Zh/V2p9WRF1i48NFuvLl+lVhKMD3gYLo7AvQ43
 LVM5n4F5d0e6o3yTt8dfvxFo9n+xC9ZJ0tkoWtWFbZyxFW738vZXpGx3GQ/2vE4AQTEO
 WQNgwjOBQKKAvLwYZ0UPbt3MnNJmuPyKM37CqtQG68RHDtMvkum5YaCjj69ZHJd86NUN
 0OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NmgzSAKKhE63JGc7KiZaWfPFcEP9GIaik5bYtHzc0+Y=;
 b=eXu0hz+g/K9NjlL621IDHaiqb4N4DI+4lm6O9Ibddm5Pj7fjx0m+YpScj+9ztt76m2
 o27WH7/3dpev2M+pYzC+m6V7Fe4NzeTNJ9FuF8LNLcTknyeKJYcOITln6zmOw4dMkgK0
 v0gdxRcLzpDDmmqPtdnv8pTtuLo8bkVs/HEckMM4Ewr1kIMwBhwRq/fPEbUYF+zXS1Wh
 uub/Y1qENJrfqLK0WoA6Li3O7sIn5wtYpYke8gtltlvBfMbkntNg4rT6O6WfLgzcLsrz
 OfR6BoGk7O8S8gMx7SbUXizJo7x2febpbwRTBBrXdoZaeB0zpTAZh0aKWRVYsD8P3g+l
 inKg==
X-Gm-Message-State: AGi0PubVeLT+QeW//0r6dKS2tYx3bOVnLfbjPMFheh1AYWupn2uzsf4x
 +FhHVEXW5G78G8xspw0YHKF2pr82
X-Google-Smtp-Source: APiQypKqswOkLxJl2q+rqM2QUL9gy8A4mN0czIerLynPN2/cxK+FlQ1BdGEnk6w0dkPDqSmiv9dz3Q==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr5769624wrc.24.1588577308885;
 Mon, 04 May 2020 00:28:28 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id w83sm12590159wmb.37.2020.05.04.00.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 00:28:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/timer/nrf51_timer: Display timer ID in trace events
Date: Mon,  4 May 2020 09:28:21 +0200
Message-Id: <20200504072822.18799-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504072822.18799-1-f4bug@amsat.org>
References: <20200504072822.18799-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NRF51 series SoC have 3 timer peripherals, each having
4 counters. To help differentiate which peripheral is accessed,
display the timer ID in the trace events.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/nrf51_timer.h |  1 +
 hw/arm/nrf51_soc.c             |  5 +++++
 hw/timer/nrf51_timer.c         | 11 +++++++++--
 hw/timer/trace-events          |  4 ++--
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/hw/timer/nrf51_timer.h b/include/hw/timer/nrf51_timer.h
index 85cad2300d..eb6815f21d 100644
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
index 6212c5cb53..44b2624e8e 100644
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
index bc82c85a6f..38cea0542e 100644
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
index 29fda7870e..43b605cc75 100644
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
2.21.3


