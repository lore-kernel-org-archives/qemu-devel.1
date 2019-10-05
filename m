Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D930FC4740A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A689D222C5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A689D222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsFo-0005xP-2a
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs4z-0004le-JO
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs4x-00047Y-AM
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs4x-00046c-2V
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:07 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E1B33B464
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:59:06 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id c8so10910060qtd.20
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ndufQ67kwp/IMCvxSdYuiln6PDFMkiFAJlZp+SBJanQ=;
 b=HI3Byl6t4HrYx9/AB4wfQPxEgvYf8Ye1k1dFHZCJVZ3YKlwO3mMh62jTtha6o/PE88
 C6zhWDHTbAAb/GAlT7wL5HYVWw7S+GqbZn5GxnWUGycbxenRoo4IgkDcaKlgxDZjqshd
 05iZv3Stvxc59bG6wkhkAfMLPTsGkeR3OdgPA3HxgrxIGKp7kGY+Oa/bF0m12ubVi0eQ
 JhIdOkbsA4jAdwOx3ayxYus6G9dWM2y0p+kWjyN0Db09VMeQryFViUIj1kVHu79qamVV
 jRAhDBFrL/3ECvegCeTJQkRmrCsPdHSCwYFhNRyzcoSR/pw9oo87RsCm4bQl7+tO0KdO
 2tpA==
X-Gm-Message-State: APjAAAXJlqSyjxrJ2R0fKwVDvRBxt6EW/lkS3UVozYT1zsF+RMYmIyyo
 6vyjmLaihLksS+r7wqnkT5aD4HXnTVyl4laflY6V77lMn24volRsdVQpObiL1nhrw0rvjoFI+nk
 apkZlkaO2WSdOwE8=
X-Received: by 2002:a37:6584:: with SMTP id z126mr3222209qkb.460.1570312745174; 
 Sat, 05 Oct 2019 14:59:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCYqaNfMje3DFF9wWIjwylkh4hbfZ10vAel4RFEetbLBz1xBWg3C5AdeP2MJyD1HlPE9iahg==
X-Received: by 2002:a37:6584:: with SMTP id z126mr3222191qkb.460.1570312744928; 
 Sat, 05 Oct 2019 14:59:04 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 b130sm5569835qkc.100.2019.10.05.14.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:59:04 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:58:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/19] hw/arm/virt: Add memory hotplug framework
Message-ID: <20190918130633.4872-5-shameerali.kolothum.thodi@huawei.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
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
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Kwangwoo Lee <kwangwoo.lee@sk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005215859.2ycDe5A8Sb9isrKYUqHrzdNR2Iq0cVc8wm_Jklf6Kw4@z>

From: Eric Auger <eric.auger@redhat.com>

This patch adds the memory hot-plug/hot-unplug infrastructure
in machvirt. The device memory is not yet exposed to the Guest
either through DT or ACPI and hence both cold/hot plug of memory
is explicitly disabled for now.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190918130633.4872-5-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/Kconfig |  2 ++
 hw/arm/virt.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 76a2a6bcbf..39d285ad3d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -20,6 +20,8 @@ config ARM_VIRT
     select SMBIOS
     select VIRTIO_MMIO
     select ACPI_PCI
+    select MEM_DEVICE
+    select DIMM
 
 config CHEETAH
     bool
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d74538b021..1c967e3fee 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -68,6 +68,8 @@
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
 #include "target/arm/internals.h"
+#include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -1876,6 +1878,42 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
+static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                                 Error **errp)
+{
+
+    /*
+     * The device memory is not yet exposed to the Guest either through
+     * DT or ACPI and hence both cold/hot plug of memory is explicitly
+     * disabled for now.
+     */
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        error_setg(errp, "memory cold/hot plug is not yet supported");
+        return;
+    }
+
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
+}
+
+static void virt_memory_plug(HotplugHandler *hotplug_dev,
+                             DeviceState *dev, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    Error *local_err = NULL;
+
+    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
+
+    error_propagate(errp, local_err);
+}
+
+static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
+                                            DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_memory_pre_plug(hotplug_dev, dev, errp);
+    }
+}
+
 static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
@@ -1887,12 +1925,23 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                      SYS_BUS_DEVICE(dev));
         }
     }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_memory_plug(hotplug_dev, dev, errp);
+    }
+}
+
+static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+                                          DeviceState *dev, Error **errp)
+{
+    error_setg(errp, "device unplug request for unsupported device"
+               " type: %s", object_get_typename(OBJECT(dev)));
 }
 
 static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
                                                         DeviceState *dev)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
+       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
         return HOTPLUG_HANDLER(machine);
     }
 
@@ -1956,7 +2005,9 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->kvm_type = virt_kvm_type;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
+    hc->pre_plug = virt_machine_device_pre_plug_cb;
     hc->plug = virt_machine_device_plug_cb;
+    hc->unplug_request = virt_machine_device_unplug_request_cb;
     mc->numa_mem_supported = true;
 }
 
-- 
MST


