Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457E8C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17459206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17459206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9lx8-0007h7-Fk
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9lub-00060Z-1r
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9luZ-0006Ae-Hw
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:59:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47374)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9luZ-00069Q-77
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:59:03 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CB1F81DEC
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:59:02 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id u12so2310357pfn.19
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 00:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LChkR9HngsP+fjSd5r3ZpOSU+lcRIkGLqSV6q1LGR9A=;
 b=Mfp+UoPww7FzzHgraZhTMyFLo8fDWEeVsH4bSGuF4HeiOT8Tfp6e+WTUchoucCtxcg
 1e+6zr74/YWOnogOiKe+UVGizg1qSk/al56Mkd2IIsQI5r7vFccu9tfqY2FalZu8LqSC
 vPMrbf8aENpriHr0xqJq9CIp3HdORbkhbCZqf3cqXIScjDmmooVFJGy3f1cjSHUvKHxx
 SzoCsobx0EbmVz22KHX0u89xOCSxfOp659CjOpqEiY3ukuGXU2hb0xWjwJi0tCjMPsC/
 PoyDzQ1qexD1V4UM37xAGSDsNhpvYbpdZ5NmOHWoihOynQmOKiyarumJW24B4QPdIq+f
 zIYw==
X-Gm-Message-State: APjAAAW326AOgCdIeaIkMlRzJotlC886WFqvDtVp5ulG+/8WBlljS/A8
 n2vylBcn2i9wL2bveqleqswsWqdJ0SnhRKxCFRWAeowEbD9wosULNp5uq4wCN7f7NWzsnnUtXLW
 0JV6D3mNZWt+9bAw=
X-Received: by 2002:a17:902:6e17:: with SMTP id
 u23mr39874701plk.205.1568620741448; 
 Mon, 16 Sep 2019 00:59:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz1JYzrFh8qrWSXCcZd2TDZAUsd+4EIhgfCp+bA3ZmbnLP1poPKKdQ4NWAP2wCnmMzNrMKnzg==
X-Received: by 2002:a17:902:6e17:: with SMTP id
 u23mr39874683plk.205.1568620741251; 
 Mon, 16 Sep 2019 00:59:01 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p20sm50321443pgi.81.2019.09.16.00.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 00:59:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:58:37 +0800
Message-Id: <20190916075839.390-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916075839.390-1-peterx@redhat.com>
References: <20190916075839.390-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/4] qdev/machine: Introduce hotplug_allowed
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
index 60d66c2f39..cbad6c1d55 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -237,6 +237,23 @@ HotplugHandler *qdev_get_machine_hotplug_handler(Dev=
iceState *dev)
     return NULL;
 }
=20
+bool qdev_hotplug_allowed(DeviceState *dev, Error **errp)
+{
+    MachineState *machine;
+    MachineClass *mc;
+    Object *m_obj =3D qdev_get_machine();
+
+    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
+        machine =3D MACHINE(m_obj);
+        mc =3D MACHINE_GET_CLASS(machine);
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
  *    The function pointer to hook different machine specific functions =
for
  *    parsing "smp-opts" from QemuOpts to MachineState::CpuTopology and =
more
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
=20
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
+    bool (*hotplug_allowed)(MachineState *state, DeviceState *dev,
+                            Error **errp);
     CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *m=
achine,
                                                          unsigned cpu_in=
dex);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine)=
;
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index de70b7a19a..aa123f88cb 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -280,6 +280,7 @@ void qdev_set_legacy_instance_id(DeviceState *dev, in=
t alias_id,
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
@@ -615,6 +615,13 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error *=
*errp)
     /* create device */
     dev =3D DEVICE(object_new(driver));
=20
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
--=20
2.21.0


