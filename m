Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB264C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE50207ED
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 17:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvcJkqw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE50207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjnuW-00005s-22
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 13:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjntQ-0006me-Fu; Fri, 12 Jun 2020 13:55:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52449)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjntO-0004C3-NI; Fri, 12 Jun 2020 13:55:04 -0400
Received: by mail-wm1-x336.google.com with SMTP id r9so8941287wmh.2;
 Fri, 12 Jun 2020 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ey2amTDcFUvfaVpFJgzUUluWwZDBNbei1L7614Xfeag=;
 b=AvcJkqw+xe1c3RaNU1zow2SUxhLuWV8oxlbUpf8LIr/BpzwNuewMP8jjo7Vf/oUkqM
 ktOjcZ8VTMXVdvyPi+Ob7Ped0A0mwaZacLZqVjenTjln0jfqccMG0auH4w0JVuo9AevI
 62+IatMleSI2J4n7wlST+uSdyUFg4CPVHCGt7vU1G9bNALByyepPDGaY6HcbyrNlWFnS
 Pexmd6mEO7GjWorJxoeHB6rvlQNE4xx9uXXEpXgTx4Je6pJbh4gMCd7y0Y5dg+SlaFRl
 7OjUbbJDZH8vtBPRDS1kbcnKiEe91J66TBZxLdf5As7y819j8KJCIbWhBOdKO/Ne2glw
 NXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ey2amTDcFUvfaVpFJgzUUluWwZDBNbei1L7614Xfeag=;
 b=WpH7A2T5TD80xkXs030KOvea9X3uTVkAkDLbRhckGfTIT1dQxdZt2TFStO0X4paAKE
 4wFnpq6KN+UrJe07gx4Hyh6JPWn2sftC6B7HDYz0G7zoPNnLPCrPkP984I93SSumS6GF
 lEzChyx4tqs/liqP4063Se3P6Ws5oZfkmwvqWz4wZ4GbO26T0ffDaSmc+bQHaI2coaKG
 wFJ26z5RV3ldnnOQecQ8/4+3uIK/puv1zrr1cc/rpzj3Es59nPXMEgmcCaIGPvcAS2Zx
 +RwE/izBjRaAtusucpfFcjzpsbDrHeXFypMCDzgOznuPFf5Tos09GvETj/nG0uOm5Edb
 G2sQ==
X-Gm-Message-State: AOAM532p7cXz8zh7ljJ/wYI88+gwJUDF9vIlQ6LEpuc/M28iXChuKyof
 eHHopfdsV5tEYfnTo4leHjy7WDQx
X-Google-Smtp-Source: ABdhPJyZxyNMXvCE7ViTgYhk2fmyFCzUG6NfUcOFt/lFVQog4azbCqLDileXQ0wqM9TeJ9qbhzDmUA==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr112560wmb.168.1591984486585; 
 Fri, 12 Jun 2020 10:54:46 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id e12sm11288658wro.52.2020.06.12.10.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 10:54:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 2/5] hw/misc/led: Add LED_STATUS_CHANGED QAPI event
Date: Fri, 12 Jun 2020 19:54:37 +0200
Message-Id: <20200612175440.9901-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612175440.9901-1-f4bug@amsat.org>
References: <20200612175440.9901-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x336.google.com
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

Allow LED devices to emit STATUS_CHANGED events on a QMP chardev.

QMP event examples:

{
    "timestamp": {
        "seconds": 1591704274,
        "microseconds": 520850
    },
    "event": "LED_STATUS_CHANGED",
    "data": {
        "name": "Green LED #0",
        "status": "on"
    }
}
{
    "timestamp": {
        "seconds": 1591704275,
        "microseconds": 530912
    },
    "event": "LED_STATUS_CHANGED",
    "data": {
        "name": "Green LED #0",
        "status": "off"
    }
}

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1: rate limit 4/sec (eblake)
---
 qapi/led.json         | 47 +++++++++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json |  1 +
 include/hw/misc/led.h |  1 +
 hw/misc/led.c         | 24 +++++++++++++++++++++-
 MAINTAINERS           |  1 +
 qapi/Makefile.objs    |  2 +-
 6 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 qapi/led.json

diff --git a/qapi/led.json b/qapi/led.json
new file mode 100644
index 0000000000..b6cef8a5dd
--- /dev/null
+++ b/qapi/led.json
@@ -0,0 +1,47 @@
+# -*- Mode: Python -*-
+#
+
+##
+# = LED device
+##
+
+##
+# @LedState:
+#
+# Status of a LED
+#
+# @on: device is emitting
+#
+# @off: device is off
+#
+# Since: 5.1
+##
+{ 'enum': 'LedState', 'data': [ 'on', 'off' ] }
+
+##
+# @LED_STATUS_CHANGED:
+#
+# Emitted when LED status changed
+#
+# @name: LED description
+#
+# @status: New status
+#
+# Since: 5.1
+#
+# Example:
+#
+# <- {"timestamp": {"seconds": 1541579657, "microseconds": 986760},
+#     "event": "LED_STATUS_CHANGED",
+#     "data":
+#         {"name": "Blue LED #3",
+#          "status": "on"
+#         }
+#    }
+#
+##
+{ 'event': 'LED_STATUS_CHANGED',
+  'data': { 'name'      : 'str',
+            'status'    : 'LedState'
+          }
+}
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 43b0ba0dea..6f3ffc0ae1 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -84,3 +84,4 @@
 { 'include': 'misc.json' }
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
+{ 'include': 'led.json' }
diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
index 427ca1418e..9300d4db6c 100644
--- a/include/hw/misc/led.h
+++ b/include/hw/misc/led.h
@@ -21,6 +21,7 @@ typedef struct LEDState {
 
     qemu_irq irq;
     uint8_t current_state;
+    int64_t last_event_ms;
 
     /* Properties */
     char *name;
diff --git a/hw/misc/led.c b/hw/misc/led.c
index 1bae1a34c0..11c7e8bb89 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -7,18 +7,40 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-led.h"
+#include "qemu/timer.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/led.h"
 #include "hw/irq.h"
 #include "trace.h"
 
+#define MAX_QMP_LED_EVENTS_PER_SEC  4 /* TODO shared between LED children? */
+
+static void emit_led_status_changed_event(LEDState *s, int state)
+{
+    static const int64_t delay_min_ms = NANOSECONDS_PER_SECOND / SCALE_MS
+                                        / MAX_QMP_LED_EVENTS_PER_SEC;
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+
+    if (now - s->last_event_ms > delay_min_ms) {
+        qapi_event_send_led_status_changed(s->name, state
+                                                    ? LED_STATE_ON
+                                                    : LED_STATE_OFF);
+    } else {
+        /* TODO count skipped events? */
+    }
+    s->last_event_ms = now;
+}
+
 static void led_set(void *opaque, int line, int new_state)
 {
     LEDState *s = LED(opaque);
 
     trace_led_set(s->name, s->current_state, new_state);
-
+    if (new_state != s->current_state) {
+        emit_led_status_changed_event(s, new_state);
+    }
     s->current_state = new_state;
 }
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 10593863dc..266b07c4b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1860,6 +1860,7 @@ F: stubs/vmgenid.c
 LED
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 S: Maintained
+F: qapi/led.json
 F: include/hw/misc/led.h
 F: hw/misc/led.c
 
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 4673ab7490..e9f6570c32 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -6,7 +6,7 @@ util-obj-y += qmp-event.o
 util-obj-y += qapi-util.o
 
 QAPI_COMMON_MODULES = audio authz block-core block char common control crypto
-QAPI_COMMON_MODULES += dump error introspect job machine migration misc
+QAPI_COMMON_MODULES += dump error introspect job led machine migration misc
 QAPI_COMMON_MODULES += net pragma qdev qom rdma rocker run-state sockets tpm
 QAPI_COMMON_MODULES += trace transaction ui
 QAPI_TARGET_MODULES = machine-target misc-target
-- 
2.21.3


