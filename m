Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EB7C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF3C20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRpH3EzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF3C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7qA-0000EN-2r
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jV-0002qu-Ng
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jU-0000MZ-6j
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:01 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:33185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jT-0000M8-7y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id v8so7290406wma.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1e9mqY9kw1A5MpQFjMDnQ9ZYdH5jolAxvUg1fANxwL8=;
 b=uRpH3EzFSBQF8ydeJwQ5myYTcDVmmQHthH4l0/ltCn/c8gIZ9OBy1e1ytCUdPFtYPT
 dKYEUs5odas3iI/Te9gPpKedYiMQuGeK0jsd2veCp5LYYOy8bKWJGkvGnBmVCPpXNlxZ
 r3WvTTOFqgj99tiV1/edhNYwjoAS9pdyf/CZeT6bhBnHdmNWh/nrvGeZzmXzvvI13LOD
 EvM+rJ2lnvNgikO+YgLKR9khBE2PlSzPhWeEZxKdhGfRkVH33IU4KSLhzPEB3HM1irjo
 4KTFV1Mvw9PjMQleFmWSWpPfHt/L/v+FEvlI92wGF46Z62OqBBa5DhXpDXrJmQJQU9Pn
 Y17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1e9mqY9kw1A5MpQFjMDnQ9ZYdH5jolAxvUg1fANxwL8=;
 b=cbXSXFqhpAEOsFdTQpcWv4ZIAiWFY/lVHnZf8AX+1VFW1OP1VAE6iw+m8EoigQd7pl
 vSVOs5BfVddv69f6K9+edUqDxlZwjPd4uYnmt6/u0Cu556+vwoYqY0kI7Vmbze8UIdqC
 A0fA1RS3fSTtCYKZVP6+WQRPlH5o+1dHjFtZg7Mz2CDvj/0ujti3I6DF0jBnKYryCaLf
 yoH8yrlWzunKLZEuhUKhLYGnux42be1czv+bbijOGCh6VveSDrPK+TX/Y/I2Nn8am25A
 77KqYVqT+rmqv41WxqiZXWQcJy4vnZl+73op7QAI9EupUc6dPeHbUalsVqgQdCRJz9IE
 0wzg==
X-Gm-Message-State: AGi0PuaYoZ/p9YKt+g97jvWl5xW559PQQhKTbujsn7DIDV0Pbu5bXkJ7
 NTqmNunfZdVBHzo9Q9cp1oYsdhnfNJn6dg==
X-Google-Smtp-Source: APiQypJOQidEyAitEMkZZ/p4Fcr7A7LTrsLjD5n/rYQIvod+owFRX2hL+uNfxNkTrIyTrxILedIyTg==
X-Received: by 2002:a7b:c755:: with SMTP id w21mr2545507wmk.120.1588247516387; 
 Thu, 30 Apr 2020 04:51:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.51.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:51:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/31] qdev: add clock input&output support to devices.
Date: Thu, 30 Apr 2020 12:51:22 +0100
Message-Id: <20200430115142.13430-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::334
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

From: Damien Hedde <damien.hedde@greensocs.com>

Add functions to easily handle clocks with devices.
Clock inputs and outputs should be used to handle clock propagation
between devices.
The API is very similar the GPIO API.

This is based on the original work of Frederic Konrad.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200406135251.157596-4-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/Makefile.objs   |   2 +-
 tests/Makefile.include  |   1 +
 include/hw/qdev-clock.h | 104 +++++++++++++++++++++++++
 include/hw/qdev-core.h  |  12 +++
 hw/core/qdev-clock.c    | 168 ++++++++++++++++++++++++++++++++++++++++
 hw/core/qdev.c          |  12 +++
 6 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/qdev-clock.h
 create mode 100644 hw/core/qdev-clock.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 115df550874..1d540ed6e78 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -7,7 +7,7 @@ common-obj-y += hotplug.o
 common-obj-y += vmstate-if.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y += irq.o
-common-obj-y += clock.o
+common-obj-y += clock.o qdev-clock.o
 
 common-obj-$(CONFIG_SOFTMMU) += reset.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 51de6762983..03a74b60f6b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -439,6 +439,7 @@ tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/fw-path-provider.o \
 	hw/core/reset.o \
 	hw/core/vmstate-if.o \
+	hw/core/clock.o hw/core/qdev-clock.o \
 	$(test-qapi-obj-y)
 tests/test-vmstate$(EXESUF): tests/test-vmstate.o \
 	migration/vmstate.o migration/vmstate-types.o migration/qemu-file.o \
diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
new file mode 100644
index 00000000000..b3b3a3e021c
--- /dev/null
+++ b/include/hw/qdev-clock.h
@@ -0,0 +1,104 @@
+/*
+ * Device's clock input and output
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
+#ifndef QDEV_CLOCK_H
+#define QDEV_CLOCK_H
+
+#include "hw/clock.h"
+
+/**
+ * qdev_init_clock_in:
+ * @dev: the device to add an input clock to
+ * @name: the name of the clock (can't be NULL).
+ * @callback: optional callback to be called on update or NULL.
+ * @opaque: argument for the callback
+ * @returns: a pointer to the newly added clock
+ *
+ * Add an input clock to device @dev as a clock named @name.
+ * This adds a child<> property.
+ * The callback will be called with @opaque as opaque parameter.
+ */
+Clock *qdev_init_clock_in(DeviceState *dev, const char *name,
+                          ClockCallback *callback, void *opaque);
+
+/**
+ * qdev_init_clock_out:
+ * @dev: the device to add an output clock to
+ * @name: the name of the clock (can't be NULL).
+ * @returns: a pointer to the newly added clock
+ *
+ * Add an output clock to device @dev as a clock named @name.
+ * This adds a child<> property.
+ */
+Clock *qdev_init_clock_out(DeviceState *dev, const char *name);
+
+/**
+ * qdev_get_clock_in:
+ * @dev: the device which has the clock
+ * @name: the name of the clock (can't be NULL).
+ * @returns: a pointer to the clock
+ *
+ * Get the input clock @name from @dev or NULL if does not exist.
+ */
+Clock *qdev_get_clock_in(DeviceState *dev, const char *name);
+
+/**
+ * qdev_get_clock_out:
+ * @dev: the device which has the clock
+ * @name: the name of the clock (can't be NULL).
+ * @returns: a pointer to the clock
+ *
+ * Get the output clock @name from @dev or NULL if does not exist.
+ */
+Clock *qdev_get_clock_out(DeviceState *dev, const char *name);
+
+/**
+ * qdev_connect_clock_in:
+ * @dev: a device
+ * @name: the name of an input clock in @dev
+ * @source: the source clock (an output clock of another device for example)
+ *
+ * Set the source clock of input clock @name of device @dev to @source.
+ * @source period update will be propagated to @name clock.
+ */
+static inline void qdev_connect_clock_in(DeviceState *dev, const char *name,
+                                         Clock *source)
+{
+    clock_set_source(qdev_get_clock_in(dev, name), source);
+}
+
+/**
+ * qdev_alias_clock:
+ * @dev: the device which has the clock
+ * @name: the name of the clock in @dev (can't be NULL)
+ * @alias_dev: the device to add the clock
+ * @alias_name: the name of the clock in @container
+ * @returns: a pointer to the clock
+ *
+ * Add a clock @alias_name in @alias_dev which is an alias of the clock @name
+ * in @dev. The direction _in_ or _out_ will the same as the original.
+ * An alias clock must not be modified or used by @alias_dev and should
+ * typically be only only for device composition purpose.
+ */
+Clock *qdev_alias_clock(DeviceState *dev, const char *name,
+                        DeviceState *alias_dev, const char *alias_name);
+
+/**
+ * qdev_finalize_clocklist:
+ * @dev: the device being finalized
+ *
+ * Clear the clocklist from @dev. Only used internally in qdev.
+ */
+void qdev_finalize_clocklist(DeviceState *dev);
+
+#endif /* QDEV_CLOCK_H */
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 1405b8a990a..d87d989e72a 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -149,6 +149,17 @@ struct NamedGPIOList {
     QLIST_ENTRY(NamedGPIOList) node;
 };
 
+typedef struct Clock Clock;
+typedef struct NamedClockList NamedClockList;
+
+struct NamedClockList {
+    char *name;
+    Clock *clock;
+    bool output;
+    bool alias;
+    QLIST_ENTRY(NamedClockList) node;
+};
+
 /**
  * DeviceState:
  * @realized: Indicates whether the device has been fully constructed.
@@ -171,6 +182,7 @@ struct DeviceState {
     bool allow_unplug_during_migration;
     BusState *parent_bus;
     QLIST_HEAD(, NamedGPIOList) gpios;
+    QLIST_HEAD(, NamedClockList) clocks;
     QLIST_HEAD(, BusState) child_bus;
     int num_child_bus;
     int instance_id_alias;
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
new file mode 100644
index 00000000000..62035aef830
--- /dev/null
+++ b/hw/core/qdev-clock.c
@@ -0,0 +1,168 @@
+/*
+ * Device's clock input and output
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
+#include "hw/qdev-clock.h"
+#include "hw/qdev-core.h"
+#include "qapi/error.h"
+
+/*
+ * qdev_init_clocklist:
+ * Add a new clock in a device
+ */
+static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
+                                           bool output, Clock *clk)
+{
+    NamedClockList *ncl;
+
+    /*
+     * Clock must be added before realize() so that we can compute the
+     * clock's canonical path during device_realize().
+     */
+    assert(!dev->realized);
+
+    /*
+     * The ncl structure is freed by qdev_finalize_clocklist() which will
+     * be called during @dev's device_finalize().
+     */
+    ncl = g_new0(NamedClockList, 1);
+    ncl->name = g_strdup(name);
+    ncl->output = output;
+    ncl->alias = (clk != NULL);
+
+    /*
+     * Trying to create a clock whose name clashes with some other
+     * clock or property is a bug in the caller and we will abort().
+     */
+    if (clk == NULL) {
+        clk = CLOCK(object_new(TYPE_CLOCK));
+        object_property_add_child(OBJECT(dev), name, OBJECT(clk), &error_abort);
+        if (output) {
+            /*
+             * Remove object_new()'s initial reference.
+             * Note that for inputs, the reference created by object_new()
+             * will be deleted in qdev_finalize_clocklist().
+             */
+            object_unref(OBJECT(clk));
+        }
+    } else {
+        object_property_add_link(OBJECT(dev), name,
+                                 object_get_typename(OBJECT(clk)),
+                                 (Object **) &ncl->clock,
+                                 NULL, OBJ_PROP_LINK_STRONG, &error_abort);
+    }
+
+    ncl->clock = clk;
+
+    QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
+    return ncl;
+}
+
+void qdev_finalize_clocklist(DeviceState *dev)
+{
+    /* called by @dev's device_finalize() */
+    NamedClockList *ncl, *ncl_next;
+
+    QLIST_FOREACH_SAFE(ncl, &dev->clocks, node, ncl_next) {
+        QLIST_REMOVE(ncl, node);
+        if (!ncl->output && !ncl->alias) {
+            /*
+             * We kept a reference on the input clock to ensure it lives up to
+             * this point so we can safely remove the callback.
+             * It avoids having a callback to a deleted object if ncl->clock
+             * is still referenced somewhere else (eg: by a clock output).
+             */
+            clock_clear_callback(ncl->clock);
+            object_unref(OBJECT(ncl->clock));
+        }
+        g_free(ncl->name);
+        g_free(ncl);
+    }
+}
+
+Clock *qdev_init_clock_out(DeviceState *dev, const char *name)
+{
+    NamedClockList *ncl;
+
+    assert(name);
+
+    ncl = qdev_init_clocklist(dev, name, true, NULL);
+
+    return ncl->clock;
+}
+
+Clock *qdev_init_clock_in(DeviceState *dev, const char *name,
+                            ClockCallback *callback, void *opaque)
+{
+    NamedClockList *ncl;
+
+    assert(name);
+
+    ncl = qdev_init_clocklist(dev, name, false, NULL);
+
+    if (callback) {
+        clock_set_callback(ncl->clock, callback, opaque);
+    }
+    return ncl->clock;
+}
+
+static NamedClockList *qdev_get_clocklist(DeviceState *dev, const char *name)
+{
+    NamedClockList *ncl;
+
+    QLIST_FOREACH(ncl, &dev->clocks, node) {
+        if (strcmp(name, ncl->name) == 0) {
+            return ncl;
+        }
+    }
+
+    return NULL;
+}
+
+Clock *qdev_get_clock_in(DeviceState *dev, const char *name)
+{
+    NamedClockList *ncl;
+
+    assert(name);
+
+    ncl = qdev_get_clocklist(dev, name);
+    assert(!ncl->output);
+
+    return ncl->clock;
+}
+
+Clock *qdev_get_clock_out(DeviceState *dev, const char *name)
+{
+    NamedClockList *ncl;
+
+    assert(name);
+
+    ncl = qdev_get_clocklist(dev, name);
+    assert(ncl->output);
+
+    return ncl->clock;
+}
+
+Clock *qdev_alias_clock(DeviceState *dev, const char *name,
+                        DeviceState *alias_dev, const char *alias_name)
+{
+    NamedClockList *ncl;
+
+    assert(name && alias_name);
+
+    ncl = qdev_get_clocklist(dev, name);
+
+    qdev_init_clocklist(alias_dev, alias_name, ncl->output, ncl->clock);
+
+    return ncl->clock;
+}
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 85f062def72..dd77a560672 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -37,6 +37,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
+#include "hw/qdev-clock.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
@@ -855,6 +856,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
     HotplugHandler *hotplug_ctrl;
     BusState *bus;
+    NamedClockList *ncl;
     Error *local_err = NULL;
     bool unattached_parent = false;
     static int unattached_count;
@@ -902,6 +904,13 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
          */
         g_free(dev->canonical_path);
         dev->canonical_path = object_get_canonical_path(OBJECT(dev));
+        QLIST_FOREACH(ncl, &dev->clocks, node) {
+            if (ncl->alias) {
+                continue;
+            } else {
+                clock_setup_canonical_path(ncl->clock);
+            }
+        }
 
         if (qdev_get_vmsd(dev)) {
             if (vmstate_register_with_alias_id(VMSTATE_IF(dev),
@@ -1025,6 +1034,7 @@ static void device_initfn(Object *obj)
     dev->allow_unplug_during_migration = false;
 
     QLIST_INIT(&dev->gpios);
+    QLIST_INIT(&dev->clocks);
 }
 
 static void device_post_init(Object *obj)
@@ -1054,6 +1064,8 @@ static void device_finalize(Object *obj)
          */
     }
 
+    qdev_finalize_clocklist(dev);
+
     /* Only send event if the device had been completely realized */
     if (dev->pending_deleted_event) {
         g_assert(dev->canonical_path);
-- 
2.20.1


