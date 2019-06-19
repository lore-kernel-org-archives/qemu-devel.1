Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1F7C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47A920B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47A920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXLK-00063r-3r
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44428)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hdXGF-0000Qh-BG
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hdXGD-0003rU-Rb
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:52:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hdXGD-0003qJ-JI
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:52:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 125743082AF2;
 Wed, 19 Jun 2019 09:52:08 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-148.sin2.redhat.com
 [10.67.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB8D010190A8;
 Wed, 19 Jun 2019 09:51:48 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 15:19:07 +0530
Message-Id: <20190619094907.10131-8-pagupta@redhat.com>
In-Reply-To: <20190619094907.10131-1-pagupta@redhat.com>
References: <20190619094907.10131-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 19 Jun 2019 09:52:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 7/7] pc: Support for virtio-pmem-pci
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
Cc: kwolf@redhat.com, aarcange@redhat.com, cohuck@redhat.com,
 xiaoguangrong.eric@gmail.com, mst@redhat.com, pagupta@redhat.com,
 riel@surriel.com, david@redhat.com, armbru@redhat.com, ehabkost@redhat.com,
 lcapitulino@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, dan.j.williams@intel.com, nilal@redhat.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Override the device hotplug handler to properly handle the memory device
part via virtio-pmem-pci callbacks from the machine hotplug handler and
forward to the actual PCI bus hotplug handler.

As PCI hotplug has not been properly factored out into hotplug handlers,
most magic is performed in the (un)realize functions. Also some PCI host
buses don't have a PCI hotplug handler at all yet, just to be sure that
we alway have a hotplug handler on x86, add a simple error check.

Unlocking virtio-pmem will unlock virtio-pmem-pci.

Signed-off-by: David Hildenbrand <david@redhat.com>
[ Disable virtio-pmem hotunplug ]
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 hw/i386/Kconfig |  1 +
 hw/i386/pc.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 9817888216..4ddf2a9c55 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -30,6 +30,7 @@ config PC
     # For ACPI builder:
     select SERIAL_ISA
     select ACPI_VMGENID
+    select VIRTIO_PMEM_SUPPORTED
 
 config PC_PCI
     bool
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d98b737b8f..3b2ad42699 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -77,6 +77,8 @@
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
 #include "standard-headers/asm-x86/bootparam.h"
+#include "hw/virtio/virtio-pmem-pci.h"
+#include "hw/mem/memory-device.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -2398,6 +2400,65 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     numa_cpu_pre_plug(cpu_slot, dev, errp);
 }
 
+static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev, Error **errp)
+{
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+    Error *local_err = NULL;
+
+    if (!hotplug_dev2) {
+        /*
+         * Without a bus hotplug handler, we cannot control the plug/unplug
+         * order. This should never be the case on x86, however better add
+         * a safety net.
+         */
+        error_setg(errp, "virtio-pmem-pci not supported on this bus.");
+        return;
+    }
+    /*
+     * First, see if we can plug this memory device at all. If that
+     * succeeds, branch of to the actual hotplug handler.
+     */
+    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
+                           &local_err);
+    if (!local_err) {
+        hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
+    }
+    error_propagate(errp, local_err);
+}
+
+static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
+{
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+    Error *local_err = NULL;
+
+    /*
+     * Plug the memory device first and then branch off to the actual
+     * hotplug handler. If that one fails, we can easily undo the memory
+     * device bits.
+     */
+    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+    hotplug_handler_plug(hotplug_dev2, dev, &local_err);
+    if (local_err) {
+        memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+    }
+    error_propagate(errp, local_err);
+}
+
+static void pc_virtio_pmem_pci_unplug_request(HotplugHandler *hotplug_dev,
+                                              DeviceState *dev, Error **errp)
+{
+    /* We don't support virtio pmem hot unplug */
+    error_setg(errp, "virtio pmem device unplug not supported.");
+}
+
+static void pc_virtio_pmem_pci_unplug(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
+{
+    /* We don't support virtio pmem hot unplug */
+}
+
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
@@ -2405,6 +2466,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
         pc_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
+        pc_virtio_pmem_pci_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -2415,6 +2478,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         pc_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
+        pc_virtio_pmem_pci_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -2425,6 +2490,8 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         pc_memory_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
+        pc_virtio_pmem_pci_unplug_request(hotplug_dev, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -2438,6 +2505,8 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
         pc_memory_unplug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         pc_cpu_unplug_cb(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
+        pc_virtio_pmem_pci_unplug(hotplug_dev, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -2448,7 +2517,8 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
 
-- 
2.14.5


