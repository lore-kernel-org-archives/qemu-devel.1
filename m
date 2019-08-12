Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF303C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C226D2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 07:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C226D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx535-0007rJ-3C
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 03:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51249)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hx51R-00043e-3Y
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hx51P-0007dl-Nz
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hx51P-0007cx-Es
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 03:45:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so103686393wrf.11
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 00:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lTmpuaaCdK+p1SsvLRVZxUAT9brrOBbHnhL4uMZgKJs=;
 b=TNXcNOPwC6V64YDLj+Gi8N2nhqX5a2W68O8EI3Ckk9ujg16mX/CHqttGfLoJpKGUAK
 ZwwmkVa/wsGSPcfZSffi7M2JVdNZ8QSQAI85GPynjnGw5E9ECnrZXfIrz8QRpfDlzhBQ
 1YbNZ44TMZhWvTDDaz+XnaGj6jkc8JatgKLCKos4GtghDc03MCC7nvh/bJ1mv4H92wZX
 XuBNgB1MtTgA3pIY8Cqa3LMLjNISSelIkOC55N6ICI+VVrC5CQK+HKJ9Rgfp5FjZQSMu
 +GCmWBSQqm5qfc1P/gWDWN9rz4utQoyNk7bm7BaV/CiebBZXSVngLAbBPT4lbLyh07q8
 8H/Q==
X-Gm-Message-State: APjAAAUFk0bby0vA7lYrH/GCOMm4oQemKL3sz3PkhPJqv8cltxq0xQjp
 dcvfLT7+b9rvxkDH5tqCmIZ4X2vKEBk38A==
X-Google-Smtp-Source: APXvYqwYyrYt3CyKED8drAxVo2rPv72ZkhD4VNuZOp69dfJgrsJ9LAOLsSSfzFeTG+OWMJmo/DsdJQ==
X-Received: by 2002:a5d:5348:: with SMTP id t8mr37981882wrv.159.1565595937867; 
 Mon, 12 Aug 2019 00:45:37 -0700 (PDT)
Received: from xz-x1.redhat.com (net77-43-52-122.mclink.it. [77.43.52.122])
 by smtp.gmail.com with ESMTPSA id a84sm15909450wmf.29.2019.08.12.00.45.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 00:45:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 12 Aug 2019 09:45:29 +0200
Message-Id: <20190812074531.28970-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812074531.28970-1-peterx@redhat.com>
References: <20190812074531.28970-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: [Qemu-devel] [PATCH RFC 2/4] qdev/machine: Introduce
 hotplug_allowed hook
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 peterx@redhat.com, Bandan Das <bsd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce this new per-machine hook to give any machine class a chance
to do a sanity check on the to-be-hotplugged device as a sanity test.
This will be used for x86 to try to detect some illegal configuration
of devices, e.g., possible conflictions between vfio-pci and x86
vIOMMU.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/qdev.c         | 17 +++++++++++++++++
 include/hw/boards.h    |  9 +++++++++
 include/hw/qdev-core.h |  1 +
 qdev-monitor.c         |  7 +++++++
 4 files changed, 34 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 94ebc0a4a1..d792b43c37 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -236,6 +236,23 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
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
index a71d1a53a5..1cf63be45d 100644
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
@@ -223,6 +230,8 @@ struct MachineClass {
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
+    bool (*hotplug_allowed)(MachineState *state, DeviceState *dev,
+                            Error **errp);
     CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 136df7774c..88e7ec4b60 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -284,6 +284,7 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
+bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
 /**
  * qdev_get_hotplug_handler: Get handler responsible for device wiring
  *
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 58222c2211..6c80602771 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -614,6 +614,13 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
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
2.21.0


