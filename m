Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AE5C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85534206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85534206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9m6b-0008Vy-LE
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9m2x-0004wa-L9
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9m2w-00028F-7y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37972)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9m2w-00027j-0I
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:07:42 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42881C057F2C
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 08:07:41 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id 194so25845881pfu.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 01:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bnN7K5Xo2dCypYqOs+nUuanAlqTG6zTwZJ4Gt3nUhbs=;
 b=Vw2kd/M4CaGZeTCxBSth1rp2haMh6QNrN2vWwVid5TngTQfR2WNXT/6HAnIITUjfrf
 MZfL6tcZ3juluaytZYzL2wgmJD0ZiqpdyWRdoIxZcXkIh7M7+jcAspWWFOh5x/+crM1v
 gVo9z6zs2eqtoP1EPtQajnHAzYRBWBw8GwXFWRi0FQ83hIuzfybiGb1g/OzfVD9v3wat
 f1KCRc3sSs5HuMFMUOOcKM0ImRUd/oKKnLGUd0p3ZTPc/kYn2V593fFrXJYs38u62zSs
 sFgG8vpvRyx4axjRi7QDthZ5Vwa/iIq9cxPV2VLNxBcrfFcjQzADWNG9Z2HDXmM11qWc
 H/lQ==
X-Gm-Message-State: APjAAAWCsewT5cugRazlYSzMmo7x6dAhVYXRn0ivbzcDFNHd9aGhF8Rm
 4EzDlvzSrV7JVZYrXVzf/ij+WW/Qi41KpIyOv4GPBJsV5W3ePwsANMFmzNJKiPQD23TW32xOcTt
 62mhr61HHgNZ4nv4=
X-Received: by 2002:aa7:80ca:: with SMTP id a10mr52220393pfn.96.1568621260420; 
 Mon, 16 Sep 2019 01:07:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyC7lRWCvXNKpA79rEQh7y8YxospED3eirnBQbXXeJDdwPrBKBWkrrgWBaqvL4g0fC134FRgw==
X-Received: by 2002:aa7:80ca:: with SMTP id a10mr52220375pfn.96.1568621260219; 
 Mon, 16 Sep 2019 01:07:40 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r12sm43051515pgb.73.2019.09.16.01.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 01:07:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:07:16 +0800
Message-Id: <20190916080718.3299-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916080718.3299-1-peterx@redhat.com>
References: <20190916080718.3299-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 2/4] qdev/machine: Introduce hotplug_allowed
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
 peterx@redhat.com, Eric Auger <eric.auger@redhat.com>,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce this new per-machine hook to give any machine class a chance
to do a sanity check on the to-be-hotplugged device as a sanity test.
This will be used for x86 to try to detect some illegal configuration
of devices, e.g., possible conflictions between vfio-pci and x86
vIOMMU.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
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


