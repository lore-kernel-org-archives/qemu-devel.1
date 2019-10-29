Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C3ECA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364D520862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364D520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPaeU-0001kF-KK
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaTO-00081Y-AW
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaTI-0003Ag-3N
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaTG-00036k-1Q
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:00:15 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E50A32A09B7
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:00:11 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id w6so531335qte.5
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=01Fs1jey86esNNGNv7ScP/Az7KLeObzFJh8m27qruq0=;
 b=BpvsUkkOWg7JD7ylp6MO7IGPS1si8l1JqMR9lMjnV7InAFOD35bLZF1WOm+pH2G0oq
 4oDGMsUBLsjZ58qhx7lmp0WWrbpzlljO7O/wqgky0X10lJZ1VPCzA63oVChxlnPXdrIJ
 6RxSPRczjBZNMwDzoqQs5O9r12qISnCLYBIo+VnsDpc0SCXEzl++HfwAnjmPln3R/4GZ
 ik3P9iR6EE6xBDmyvmWOG9dyzO9AzO4mVp5KXWjOmpXpf6UAREwazFtk52R84hD/JmmK
 etTemgWhp+HKWyv2Ts1aCAbI/uZdpjS/2Fb8IxtPhUjXmPyzrfVPKvU1uwbHitRpLjYb
 Mzcw==
X-Gm-Message-State: APjAAAWxgYIayVOPUdF8jEHhHorvNAvafmWOPXOS491CkALFgh8YvJ4P
 g2ZkIbBmzE45gJ7fx8friRzqBgFGTWuDJdx/9GdjKJmtGf+sxq88EMCxx4Go2BUGSAJEa5aGt2k
 N4vRyLON3HpBAkY4=
X-Received: by 2002:ac8:701e:: with SMTP id x30mr1784899qtm.203.1572390010496; 
 Tue, 29 Oct 2019 16:00:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxnePi/t76Pwk14BSFFyIh6tOx7lRZP9ASPgqfMuvaYamd/RqGVnP4c11rIgMBUm3uMOmBSFw==
X-Received: by 2002:ac8:701e:: with SMTP id x30mr1784827qtm.203.1572390009832; 
 Tue, 29 Oct 2019 16:00:09 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id g7sm380776qki.75.2019.10.29.16.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:00:09 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:00:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/14] qdev/qbus: add hidden device support
Message-ID: <20191029225932.14585-2-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Jens Freimann <jfreimann@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

This adds support for hiding a device to the qbus and qdev APIs.  The
first user of this will be the virtio-net failover feature but the API
introduced with this patch could be used to implement other features as
well, for example hiding pci devices when a pci bus is powered off.

qdev_device_add() is modified to check for a failover_pair_id
argument in the option string. A DeviceListener callback
should_be_hidden() is added. It can be used by a standby device to
inform qdev that this device should not be added now. The standby device
handler can store the device options to plug the device in at a later
point in time.

One reason for hiding the device is that we don't want to expose both
devices to the guest kernel until the respective virtio feature bit
VIRTIO_NET_F_STANDBY was negotiated and we know that the devices will be
handled correctly by the guest.

More information on the kernel feature this is using:
 https://www.kernel.org/doc/html/latest/networking/net_failover.html

An example where the primary device is a vfio-pci device and the standby
device is a virtio-net device:

A device is hidden when it has an "failover_pair_id" option, e.g.

 -device virtio-net-pci,...,failover=on,...
 -device vfio-pci,...,failover_pair_id=net1,...

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191029114905.6856-2-jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/core/qdev.c         | 24 ++++++++++++++++++++++++
 include/hw/qdev-core.h | 29 +++++++++++++++++++++++++++++
 qdev-monitor.c         | 41 +++++++++++++++++++++++++++++++++++++----
 vl.c                   |  6 ++++--
 4 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cbad6c1d55..3b8d43d0fd 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -212,6 +212,30 @@ void device_listener_unregister(DeviceListener *listener)
     QTAILQ_REMOVE(&device_listeners, listener, link);
 }
 
+bool qdev_should_hide_device(QemuOpts *opts)
+{
+    int rc = -1;
+    DeviceListener *listener;
+
+    QTAILQ_FOREACH(listener, &device_listeners, link) {
+       if (listener->should_be_hidden) {
+            /*
+             * should_be_hidden_will return
+             *  1 if device matches opts and it should be hidden
+             *  0 if device matches opts and should not be hidden
+             *  -1 if device doesn't match ops
+             */
+            rc = listener->should_be_hidden(listener, opts);
+        }
+
+        if (rc > 0) {
+            break;
+        }
+    }
+
+    return rc > 0;
+}
+
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version)
 {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index aa123f88cb..710981af36 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -78,6 +78,19 @@ typedef void (*BusUnrealize)(BusState *bus, Error **errp);
  * respective parent types.
  *   </para>
  * </note>
+ *
+ * # Hiding a device #
+ * To hide a device, a DeviceListener function should_be_hidden() needs to
+ * be registered.
+ * It can be used to defer adding a device and therefore hide it from the
+ * guest. The handler registering to this DeviceListener can save the QOpts
+ * passed to it for re-using it later and must return that it wants the device
+ * to be/remain hidden or not. When the handler function decides the device
+ * shall not be hidden it will be added in qdev_device_add() and
+ * realized as any other device. Otherwise qdev_device_add() will return early
+ * without adding the device. The guest will not see a "hidden" device
+ * until it was marked don't hide and qdev_device_add called again.
+ *
  */
 typedef struct DeviceClass {
     /*< private >*/
@@ -154,6 +167,12 @@ struct DeviceState {
 struct DeviceListener {
     void (*realize)(DeviceListener *listener, DeviceState *dev);
     void (*unrealize)(DeviceListener *listener, DeviceState *dev);
+    /*
+     * This callback is called upon init of the DeviceState and allows to
+     * inform qdev that a device should be hidden, depending on the device
+     * opts, for example, to hide a standby device.
+     */
+    int (*should_be_hidden)(DeviceListener *listener, QemuOpts *device_opts);
     QTAILQ_ENTRY(DeviceListener) link;
 };
 
@@ -451,4 +470,14 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
 
+/**
+ * @qdev_should_hide_device:
+ * @opts: QemuOpts as passed on cmdline.
+ *
+ * Check if a device should be added.
+ * When a device is added via qdev_device_add() this will be called,
+ * and return if the device should be added now or not.
+ */
+bool qdev_should_hide_device(QemuOpts *opts);
+
 #endif
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 148df9cacf..ffa08c670f 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -32,9 +32,11 @@
 #include "qemu/help_option.h"
 #include "qemu/option.h"
 #include "qemu/qemu-print.h"
+#include "qemu/option_int.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/sysemu.h"
 #include "migration/misc.h"
+#include "migration/migration.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -562,13 +564,36 @@ void qdev_set_id(DeviceState *dev, const char *id)
     }
 }
 
+static int is_failover_device(void *opaque, const char *name, const char *value,
+                        Error **errp)
+{
+    if (strcmp(name, "failover_pair_id") == 0) {
+        QemuOpts *opts = (QemuOpts *)opaque;
+
+        if (qdev_should_hide_device(opts)) {
+            return 1;
+        }
+    }
+
+    return 0;
+}
+
+static bool should_hide_device(QemuOpts *opts)
+{
+    if (qemu_opt_foreach(opts, is_failover_device, opts, NULL) == 0) {
+        return false;
+    }
+    return true;
+}
+
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 {
     DeviceClass *dc;
     const char *driver, *path;
-    DeviceState *dev;
+    DeviceState *dev = NULL;
     BusState *bus = NULL;
     Error *err = NULL;
+    bool hide;
 
     driver = qemu_opt_get(opts, "driver");
     if (!driver) {
@@ -602,11 +627,17 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
             return NULL;
         }
     }
-    if (qdev_hotplug && bus && !qbus_is_hotpluggable(bus)) {
+    hide = should_hide_device(opts);
+
+    if ((hide || qdev_hotplug) && bus && !qbus_is_hotpluggable(bus)) {
         error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
         return NULL;
     }
 
+    if (hide) {
+        return NULL;
+    }
+
     if (!migration_is_idle()) {
         error_setg(errp, "device_add not allowed while migrating");
         return NULL;
@@ -648,8 +679,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 
 err_del_dev:
     error_propagate(errp, err);
-    object_unparent(OBJECT(dev));
-    object_unref(OBJECT(dev));
+    if (dev) {
+        object_unparent(OBJECT(dev));
+        object_unref(OBJECT(dev));
+    }
     return NULL;
 }
 
diff --git a/vl.c b/vl.c
index 49778e7399..c389d24b2c 100644
--- a/vl.c
+++ b/vl.c
@@ -2207,10 +2207,12 @@ static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
     DeviceState *dev;
 
     dev = qdev_device_add(opts, errp);
-    if (!dev) {
+    if (!dev && *errp) {
+        error_report_err(*errp);
         return -1;
+    } else if (dev) {
+        object_unref(OBJECT(dev));
     }
-    object_unref(OBJECT(dev));
     return 0;
 }
 
-- 
MST


