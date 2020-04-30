Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9015EC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9BD20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEyWGifO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9BD20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7lr-0007ww-DH
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jX-0002sC-RF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jU-0000Mb-7B
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:55905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jT-0000MD-BQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id e26so1509146wmk.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=z48Jl8XNi25vJPB9v5ehJOLopLNYTyZOH6r0FLJ81ag=;
 b=yEyWGifOTqEjX/dkCDFH83szNND1rKp6dol01G414IZuFppeNTdSzMkCYDzh9Y9+KX
 71egs29ey5IF07xxA/7cmWQCbIFG1kzfLGsBNrzShNOOKyK9CD5UJVjBmDHRC/lU5ZkK
 MOamOsPgUv2670SVIWQsKF0WEh8DOVyO72xZjxVeXu4F32qQ0JQ4DDPORpkef4yoqGvl
 E6+Z94LmfuZT7sJNSlqUnJ0nmeOZBn0XRI+YEO6JPNmD6ijIR6BZPiZ3TgIimIbc/brT
 p1JKs/JASUmydeFUZZWeyLaS4lic3xaSeSFgXTNvQk9IPcYVd9DaiirHkto8qYRPUW+r
 v1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z48Jl8XNi25vJPB9v5ehJOLopLNYTyZOH6r0FLJ81ag=;
 b=C6n14Pnh84tAi8y3UaCOX6bePUOCAdiUIJuOSD9d6E6JtuhhJjiTD1/5pbxqYWVMsP
 +BoJYcrZF6fh9TKNCRAgbRDeI3gEfsq/M+E0SKHBJJ17MDNC0uD+sKFwRLGP3jQTHUFy
 XHY733u0G7S8/0mbAaCanbR7exDjLtfVsSTOv7xJQie+TB8siHjbWLbprl7855a4HoWi
 NFFZP9fuHKlvpqlzf9TcQMvVqfs3QzEhMqxEYb1iqDpEGxU88iKE9fjQ7v1wwiLWFT2A
 hxVGzWKlf7as5EV0dLfGBVkz/GkE9dd7E7+VAJFWr0MD7mHfapaUhz37BVBN44idYQ9N
 pGLw==
X-Gm-Message-State: AGi0PuYuFV19+7fmh6QYOlENSK/7787Wc0v2JO2ZtDMswcC6CRbABFHH
 tzZKfGcT3MT0wUx4nLDw+dp56cXo7CIOyA==
X-Google-Smtp-Source: APiQypK6hxVhci54lwKhNPoD4yEEvod7p7XYnNbfB+R3TFA+HUTwXfXLt9VkQYL6Dqx3SzT2Ix6fxw==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr2565948wme.0.1588247514294;
 Thu, 30 Apr 2020 04:51:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.51.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:51:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/31] hw/core/clock: introduce clock object
Date: Thu, 30 Apr 2020 12:51:20 +0100
Message-Id: <20200430115142.13430-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::336
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

This object may be used to represent a clock inside a clock tree.

A clock may be connected to another clock so that it receives update,
through a callback, whenever the source/parent clock is updated.

Although only the root clock of a clock tree controls the values
(represented as periods) of all clocks in tree, each clock holds
a local state containing the current value so that it can be fetched
independently. It will allows us to fullfill migration requirements
by migrating each clock independently of others.

This is based on the original work of Frederic Konrad.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200406135251.157596-2-damien.hedde@greensocs.com
[PMM: Use uint64_t rather than unsigned long long in trace events;
 the dtrace backend can't handle the latter]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/Makefile.objs |   1 +
 include/hw/clock.h    | 216 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/clock.c       | 130 +++++++++++++++++++++++++
 hw/core/trace-events  |   7 ++
 4 files changed, 354 insertions(+)
 create mode 100644 include/hw/clock.h
 create mode 100644 hw/core/clock.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 6215e7c2085..1d9b0aa2057 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -7,6 +7,7 @@ common-obj-y += hotplug.o
 common-obj-y += vmstate-if.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y += irq.o
+common-obj-y += clock.o
 
 common-obj-$(CONFIG_SOFTMMU) += reset.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
diff --git a/include/hw/clock.h b/include/hw/clock.h
new file mode 100644
index 00000000000..82a7f3c6982
--- /dev/null
+++ b/include/hw/clock.h
@@ -0,0 +1,216 @@
+/*
+ * Hardware Clocks
+ *
+ * Copyright GreenSocs 2016-2020
+ *
+ * Authors:
+ *  Frederic Konrad
+ *  Damien Hedde
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef QEMU_HW_CLOCK_H
+#define QEMU_HW_CLOCK_H
+
+#include "qom/object.h"
+#include "qemu/queue.h"
+
+#define TYPE_CLOCK "clock"
+#define CLOCK(obj) OBJECT_CHECK(Clock, (obj), TYPE_CLOCK)
+
+typedef void ClockCallback(void *opaque);
+
+/*
+ * clock store a value representing the clock's period in 2^-32ns unit.
+ * It can represent:
+ *  + periods from 2^-32ns up to 4seconds
+ *  + frequency from ~0.25Hz 2e10Ghz
+ * Resolution of frequency representation decreases with frequency:
+ * + at 100MHz, resolution is ~2mHz
+ * + at 1Ghz,   resolution is ~0.2Hz
+ * + at 10Ghz,  resolution is ~20Hz
+ */
+#define CLOCK_SECOND (1000000000llu << 32)
+
+/*
+ * macro helpers to convert to hertz / nanosecond
+ */
+#define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_SECOND / 1000000000llu))
+#define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_SECOND / 1000000000llu))
+#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) != 0) ? CLOCK_SECOND / (hz) : 0u)
+#define CLOCK_PERIOD_TO_HZ(per) (((per) != 0) ? CLOCK_SECOND / (per) : 0u)
+
+/**
+ * Clock:
+ * @parent_obj: parent class
+ * @period: unsigned integer representing the period of the clock
+ * @canonical_path: clock path string cache (used for trace purpose)
+ * @callback: called when clock changes
+ * @callback_opaque: argument for @callback
+ * @source: source (or parent in clock tree) of the clock
+ * @children: list of clocks connected to this one (it is their source)
+ * @sibling: structure used to form a clock list
+ */
+
+typedef struct Clock Clock;
+
+struct Clock {
+    /*< private >*/
+    Object parent_obj;
+
+    /* all fields are private and should not be modified directly */
+
+    /* fields */
+    uint64_t period;
+    char *canonical_path;
+    ClockCallback *callback;
+    void *callback_opaque;
+
+    /* Clocks are organized in a clock tree */
+    Clock *source;
+    QLIST_HEAD(, Clock) children;
+    QLIST_ENTRY(Clock) sibling;
+};
+
+/**
+ * clock_setup_canonical_path:
+ * @clk: clock
+ *
+ * compute the canonical path of the clock (used by log messages)
+ */
+void clock_setup_canonical_path(Clock *clk);
+
+/**
+ * clock_set_callback:
+ * @clk: the clock to register the callback into
+ * @cb: the callback function
+ * @opaque: the argument to the callback
+ *
+ * Register a callback called on every clock update.
+ */
+void clock_set_callback(Clock *clk, ClockCallback *cb, void *opaque);
+
+/**
+ * clock_clear_callback:
+ * @clk: the clock to delete the callback from
+ *
+ * Unregister the callback registered with clock_set_callback.
+ */
+void clock_clear_callback(Clock *clk);
+
+/**
+ * clock_set_source:
+ * @clk: the clock.
+ * @src: the source clock
+ *
+ * Setup @src as the clock source of @clk. The current @src period
+ * value is also copied to @clk and its subtree but no callback is
+ * called.
+ * Further @src update will be propagated to @clk and its subtree.
+ */
+void clock_set_source(Clock *clk, Clock *src);
+
+/**
+ * clock_set:
+ * @clk: the clock to initialize.
+ * @value: the clock's value, 0 means unclocked
+ *
+ * Set the local cached period value of @clk to @value.
+ */
+void clock_set(Clock *clk, uint64_t value);
+
+static inline void clock_set_hz(Clock *clk, unsigned hz)
+{
+    clock_set(clk, CLOCK_PERIOD_FROM_HZ(hz));
+}
+
+static inline void clock_set_ns(Clock *clk, unsigned ns)
+{
+    clock_set(clk, CLOCK_PERIOD_FROM_NS(ns));
+}
+
+/**
+ * clock_propagate:
+ * @clk: the clock
+ *
+ * Propagate the clock period that has been previously configured using
+ * @clock_set(). This will update recursively all connected clocks.
+ * It is an error to call this function on a clock which has a source.
+ * Note: this function must not be called during device inititialization
+ * or migration.
+ */
+void clock_propagate(Clock *clk);
+
+/**
+ * clock_update:
+ * @clk: the clock to update.
+ * @value: the new clock's value, 0 means unclocked
+ *
+ * Update the @clk to the new @value. All connected clocks will be informed
+ * of this update. This is equivalent to call @clock_set() then
+ * @clock_propagate().
+ */
+static inline void clock_update(Clock *clk, uint64_t value)
+{
+    clock_set(clk, value);
+    clock_propagate(clk);
+}
+
+static inline void clock_update_hz(Clock *clk, unsigned hz)
+{
+    clock_update(clk, CLOCK_PERIOD_FROM_HZ(hz));
+}
+
+static inline void clock_update_ns(Clock *clk, unsigned ns)
+{
+    clock_update(clk, CLOCK_PERIOD_FROM_NS(ns));
+}
+
+/**
+ * clock_get:
+ * @clk: the clk to fetch the clock
+ *
+ * @return: the current period.
+ */
+static inline uint64_t clock_get(const Clock *clk)
+{
+    return clk->period;
+}
+
+static inline unsigned clock_get_hz(Clock *clk)
+{
+    return CLOCK_PERIOD_TO_HZ(clock_get(clk));
+}
+
+static inline unsigned clock_get_ns(Clock *clk)
+{
+    return CLOCK_PERIOD_TO_NS(clock_get(clk));
+}
+
+/**
+ * clock_is_enabled:
+ * @clk: a clock
+ *
+ * @return: true if the clock is running.
+ */
+static inline bool clock_is_enabled(const Clock *clk)
+{
+    return clock_get(clk) != 0;
+}
+
+static inline void clock_init(Clock *clk, uint64_t value)
+{
+    clock_set(clk, value);
+}
+static inline void clock_init_hz(Clock *clk, uint64_t value)
+{
+    clock_set_hz(clk, value);
+}
+static inline void clock_init_ns(Clock *clk, uint64_t value)
+{
+    clock_set_ns(clk, value);
+}
+
+#endif /* QEMU_HW_CLOCK_H */
diff --git a/hw/core/clock.c b/hw/core/clock.c
new file mode 100644
index 00000000000..3c0daf7d4cf
--- /dev/null
+++ b/hw/core/clock.c
@@ -0,0 +1,130 @@
+/*
+ * Hardware Clocks
+ *
+ * Copyright GreenSocs 2016-2020
+ *
+ * Authors:
+ *  Frederic Konrad
+ *  Damien Hedde
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/clock.h"
+#include "trace.h"
+
+#define CLOCK_PATH(_clk) (_clk->canonical_path)
+
+void clock_setup_canonical_path(Clock *clk)
+{
+    g_free(clk->canonical_path);
+    clk->canonical_path = object_get_canonical_path(OBJECT(clk));
+}
+
+void clock_set_callback(Clock *clk, ClockCallback *cb, void *opaque)
+{
+    clk->callback = cb;
+    clk->callback_opaque = opaque;
+}
+
+void clock_clear_callback(Clock *clk)
+{
+    clock_set_callback(clk, NULL, NULL);
+}
+
+void clock_set(Clock *clk, uint64_t period)
+{
+    trace_clock_set(CLOCK_PATH(clk), CLOCK_PERIOD_TO_NS(clk->period),
+                    CLOCK_PERIOD_TO_NS(period));
+    clk->period = period;
+}
+
+static void clock_propagate_period(Clock *clk, bool call_callbacks)
+{
+    Clock *child;
+
+    QLIST_FOREACH(child, &clk->children, sibling) {
+        if (child->period != clk->period) {
+            child->period = clk->period;
+            trace_clock_update(CLOCK_PATH(child), CLOCK_PATH(clk),
+                               CLOCK_PERIOD_TO_NS(clk->period),
+                               call_callbacks);
+            if (call_callbacks && child->callback) {
+                child->callback(child->callback_opaque);
+            }
+            clock_propagate_period(child, call_callbacks);
+        }
+    }
+}
+
+void clock_propagate(Clock *clk)
+{
+    assert(clk->source == NULL);
+    trace_clock_propagate(CLOCK_PATH(clk));
+    clock_propagate_period(clk, true);
+}
+
+void clock_set_source(Clock *clk, Clock *src)
+{
+    /* changing clock source is not supported */
+    assert(!clk->source);
+
+    trace_clock_set_source(CLOCK_PATH(clk), CLOCK_PATH(src));
+
+    clk->period = src->period;
+    QLIST_INSERT_HEAD(&src->children, clk, sibling);
+    clk->source = src;
+    clock_propagate_period(clk, false);
+}
+
+static void clock_disconnect(Clock *clk)
+{
+    if (clk->source == NULL) {
+        return;
+    }
+
+    trace_clock_disconnect(CLOCK_PATH(clk));
+
+    clk->source = NULL;
+    QLIST_REMOVE(clk, sibling);
+}
+
+static void clock_initfn(Object *obj)
+{
+    Clock *clk = CLOCK(obj);
+
+    QLIST_INIT(&clk->children);
+}
+
+static void clock_finalizefn(Object *obj)
+{
+    Clock *clk = CLOCK(obj);
+    Clock *child, *next;
+
+    /* clear our list of children */
+    QLIST_FOREACH_SAFE(child, &clk->children, sibling, next) {
+        clock_disconnect(child);
+    }
+
+    /* remove us from source's children list */
+    clock_disconnect(clk);
+
+    g_free(clk->canonical_path);
+}
+
+static const TypeInfo clock_info = {
+    .name              = TYPE_CLOCK,
+    .parent            = TYPE_OBJECT,
+    .instance_size     = sizeof(Clock),
+    .instance_init     = clock_initfn,
+    .instance_finalize = clock_finalizefn,
+};
+
+static void clock_register_types(void)
+{
+    type_register_static(&clock_info);
+}
+
+type_init(clock_register_types)
diff --git a/hw/core/trace-events b/hw/core/trace-events
index aecd8e160eb..1ac60ede6b7 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -27,3 +27,10 @@ resettable_phase_exit_begin(void *obj, const char *objtype, unsigned count, int
 resettable_phase_exit_exec(void *obj, const char *objtype, int has_method) "obj=%p(%s) method=%d"
 resettable_phase_exit_end(void *obj, const char *objtype, unsigned count) "obj=%p(%s) count=%d"
 resettable_transitional_function(void *obj, const char *objtype) "obj=%p(%s)"
+
+# clock.c
+clock_set_source(const char *clk, const char *src) "'%s', src='%s'"
+clock_disconnect(const char *clk) "'%s'"
+clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', ns=%"PRIu64"->%"PRIu64
+clock_propagate(const char *clk) "'%s'"
+clock_update(const char *clk, const char *src, uint64_t val, int cb) "'%s', src='%s', ns=%"PRIu64", cb=%d"
-- 
2.20.1


