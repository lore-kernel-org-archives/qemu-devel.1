Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E745C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8F0213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8F0213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfkSM-0003Ao-FK
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 08:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36275)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hfkMh-0007Bx-C7
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hfkMY-00048d-QX
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:15:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2180 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hfkMS-00041H-JK; Tue, 25 Jun 2019 08:15:46 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 6AA48C108F77C277EE6C;
 Tue, 25 Jun 2019 20:15:39 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Jun 2019 20:15:29 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Date: Tue, 25 Jun 2019 13:14:14 +0100
Message-ID: <20190625121421.22280-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
References: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: [Qemu-devel] [PATCH v6 1/8] hw/acpi: Make ACPI IO address space
 configurable
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is in preparation for adding support for ARM64 platforms
where it doesn't use port mapped IO for ACPI IO space.

Also move few MEMORY_* definitions to header so that other memory
hotplug event signalling mechanisms (eg. Generic Event Device on
HW-reduced acpi platforms) can use the same from their respective
event handler code.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/memory_hotplug.c         | 25 ++++++++++++++-----------
 hw/i386/acpi-build.c             |  3 ++-
 include/hw/acpi/memory_hotplug.h |  9 +++++++--
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 297812d5f7..c724f5f1e4 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -29,12 +29,9 @@
 #define MEMORY_SLOT_PROXIMITY_METHOD "MPXM"
 #define MEMORY_SLOT_EJECT_METHOD     "MEJ0"
 #define MEMORY_SLOT_NOTIFY_METHOD    "MTFY"
-#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
 #define MEMORY_HOTPLUG_DEVICE        "MHPD"
-#define MEMORY_HOTPLUG_IO_LEN         24
-#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
 
-static uint16_t memhp_io_base;
+static hwaddr memhp_io_base;
 
 static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus *mdev)
 {
@@ -209,7 +206,7 @@ static const MemoryRegionOps acpi_memory_hotplug_ops = {
 };
 
 void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
-                              MemHotplugState *state, uint16_t io_base)
+                              MemHotplugState *state, hwaddr io_base)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
 
@@ -342,7 +339,8 @@ const VMStateDescription vmstate_memory_hotplug = {
 
 void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
                               const char *res_root,
-                              const char *event_handler_method)
+                              const char *event_handler_method,
+                              AmlRegionSpace rs)
 {
     int i;
     Aml *ifctx;
@@ -365,14 +363,19 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
             aml_name_decl("_UID", aml_string("Memory hotplug resources")));
 
         crs = aml_resource_template();
-        aml_append(crs,
-            aml_io(AML_DECODE16, memhp_io_base, memhp_io_base, 0,
-                   MEMORY_HOTPLUG_IO_LEN)
-        );
+        if (rs == AML_SYSTEM_IO) {
+            aml_append(crs,
+                aml_io(AML_DECODE16, memhp_io_base, memhp_io_base, 0,
+                       MEMORY_HOTPLUG_IO_LEN)
+            );
+        } else {
+            aml_append(crs, aml_memory32_fixed(memhp_io_base,
+                            MEMORY_HOTPLUG_IO_LEN, AML_READ_WRITE));
+        }
         aml_append(mem_ctrl_dev, aml_name_decl("_CRS", crs));
 
         aml_append(mem_ctrl_dev, aml_operation_region(
-            MEMORY_HOTPLUG_IO_REGION, AML_SYSTEM_IO,
+            MEMORY_HOTPLUG_IO_REGION, rs,
             aml_int(memhp_io_base), MEMORY_HOTPLUG_IO_LEN)
         );
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 31a1c1e3ad..6c7c33e47a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1862,7 +1862,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
                        "\\_SB.PCI0", "\\_GPE._E02");
     }
-    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0", "\\_GPE._E03");
+    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0",
+                             "\\_GPE._E03", AML_SYSTEM_IO);
 
     scope =  aml_scope("_GPE");
     {
diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
index 77c65765d6..e3a4b89235 100644
--- a/include/hw/acpi/memory_hotplug.h
+++ b/include/hw/acpi/memory_hotplug.h
@@ -5,6 +5,10 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 
+#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
+#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
+#define MEMORY_HOTPLUG_IO_LEN         24
+
 /**
  * MemStatus:
  * @is_removing: the memory device in slot has been requested to be ejected.
@@ -29,7 +33,7 @@ typedef struct MemHotplugState {
 } MemHotplugState;
 
 void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
-                              MemHotplugState *state, uint16_t io_base);
+                              MemHotplugState *state, hwaddr io_base);
 
 void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
                          DeviceState *dev, Error **errp);
@@ -48,5 +52,6 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
 
 void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
                               const char *res_root,
-                              const char *event_handler_method);
+                              const char *event_handler_method,
+                              AmlRegionSpace rs);
 #endif
-- 
2.17.1



