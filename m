Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06ACC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D9221852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D9221852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFIx-0003Hp-8x
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iAF8F-0002Y2-10
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iAF8D-0000Qt-Kd
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iAF8D-0000Qd-Cu
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:11:05 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 975996412B
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 15:11:04 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id 10so4581057qka.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PDMfqNHbwS0bH1PKNn7AqQ0pdJHxTWF/7HX1ECSzeGs=;
 b=CeqiD/UTmalaEdVY46Mclq0ANfiZ4nKsmn4E0ZbzB5TvLRm145SHeUrMFunciUfr1Q
 5rlpyAtgm15r/Q0Dztvt1ZHQjcmE1qGlfkZt6j8qnIYmXEEqQtoJeg2R3CG0u1UHjiD4
 ZggbuThypGnUPNxsvbJS5Rkp5AwNu0X82KhM3/cZ2X9A/NEHl7cJasekWlXapQVe8znN
 qZ6mUWS/jBpvnJddO7PHDXoNmmacj0cxGx4S2Icpq9Atib7ETpsRyaQodP1tAO9+AUwB
 JWU2yKHIH8pL4BFc3WrNZDIvCMFu0L4+hvutCqDW+0g3iVvkxQNR+6ZiX8PBYPD9VyVn
 dT+g==
X-Gm-Message-State: APjAAAWEDxbyI6VRWFVxfQDeZgP/4VirbNjdx/sdq9O6OWPb0IXEUrnk
 4f2EeUK7R3G24ZAWm+WKNXbcW+tIGgly8l4AawvQGCNqgFv5KmxyWwiWYBsQuDX0vywFsDdUlJt
 ScK4KvzrUkxJ1Bsk=
X-Received: by 2002:a37:4f4e:: with SMTP id d75mr4109461qkb.137.1568733063594; 
 Tue, 17 Sep 2019 08:11:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwRgVipevJp3rU7IQBoAX70nhRatQl9PTmCLtjCdOPU4cFRe5BPhVs7cR7MB/coBhXS4mAQNA==
X-Received: by 2002:a37:4f4e:: with SMTP id d75mr4109428qkb.137.1568733063418; 
 Tue, 17 Sep 2019 08:11:03 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id g45sm1527366qtc.9.2019.09.17.08.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:11:02 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:10:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190916080718.3299-3-peterx@redhat.com>
References: <20190917151011.24588-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190917151011.24588-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/10] qdev/machine: Introduce hotplug_allowed
 hook
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
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190917151059.xA0vuO95KVt0_F0y1Vx58FKUl6uuMtXW6Ry4sG34Qd0@z>

From: Peter Xu <peterx@redhat.com>

Introduce this new per-machine hook to give any machine class a chance
to do a sanity check on the to-be-hotplugged device as a sanity test.
This will be used for x86 to try to detect some illegal configuration
of devices, e.g., possible conflictions between vfio-pci and x86
vIOMMU.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190916080718.3299-3-peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/core/qdev.c         | 17 +++++++++++++++++
 include/hw/boards.h    |  9 +++++++++
 include/hw/qdev-core.h |  1 +
 qdev-monitor.c         |  7 +++++++
 4 files changed, 34 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 60d66c2f39..cbad6c1d55 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -237,6 +237,23 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
     return NULL;
 }
 
+bool qdev_hotplug_allowed(DeviceState *dev, Error **errp)
+{
+    MachineState *machine;
+    MachineClass *mc;
+    Object *m_obj = qdev_get_machine();
+
+    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
+        machine = MACHINE(m_obj);
+        mc = MACHINE_GET_CLASS(machine);
+        if (mc->hotplug_allowed) {
+            return mc->hotplug_allowed(machine, dev, errp);
+        }
+    }
+
+    return true;
+}
+
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
 {
     if (dev->parent_bus) {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 2289536e48..be18a5c032 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -166,6 +166,13 @@ typedef struct {
  *    The function pointer to hook different machine specific functions for
  *    parsing "smp-opts" from QemuOpts to MachineState::CpuTopology and more
  *    machine specific topology fields, such as smp_dies for PCMachine.
+ * @hotplug_allowed:
+ *    If the hook is provided, then it'll be called for each device
+ *    hotplug to check whether the device hotplug is allowed.  Return
+ *    true to grant allowance or false to reject the hotplug.  When
+ *    false is returned, an error must be set to show the reason of
+ *    the rejection.  If the hook is not provided, all hotplug will be
+ *    allowed.
  */
 struct MachineClass {
     /*< private >*/
@@ -224,6 +231,8 @@ struct MachineClass {
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
+    bool (*hotplug_allowed)(MachineState *state, DeviceState *dev,
+                            Error **errp);
     CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index de70b7a19a..aa123f88cb 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -280,6 +280,7 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
+bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
 /**
  * qdev_get_hotplug_handler: Get handler responsible for device wiring
  *
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 8fe5c2cad2..148df9cacf 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -615,6 +615,13 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     /* create device */
     dev = DEVICE(object_new(driver));
 
+    /* Check whether the hotplug is allowed by the machine */
+    if (qdev_hotplug && !qdev_hotplug_allowed(dev, &err)) {
+        /* Error must be set in the machine hook */
+        assert(err);
+        goto err_del_dev;
+    }
+
     if (bus) {
         qdev_set_parent_bus(dev, bus);
     } else if (qdev_hotplug && !qdev_get_machine_hotplug_handler(dev)) {
-- 
MST


