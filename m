Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFED4C47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C77222C5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C77222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGs7I-0006PL-OC
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs4o-0004gr-5A
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs4m-0003ze-5X
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs4k-0003vO-3f
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:58:56 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3873E4E908
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:58:50 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id e13so10864758qto.18
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PmQ7/Ti/UH+E64m44DqjgcPM92YTvzFcTPlAGD1O1uQ=;
 b=L6THjNLK4aeWzLDYpWC80XIkUaQTH49qxpiX5h3UZ0m8Lu1ltz8U2RtzNI1KMOGA6X
 ZYYkCJxq30BdXYXEYEaX8x4eg8MWSFBBgQlF/z089wJVKoHA7BSjGXl+ZDUdDKN4YIJL
 u3Im+j/3YNHc0H6EwKGQzauGmyQSbGEq/I7X0fI3a0FEQiWXZLfGnrlCTCd7dwW03sMC
 yjy3ezfkXrQO2E8Lh95I4Ujd3IQLLuJ7ryPhXPS3m5IL0AZ999NhLGBQOZ1JBTQFr7s5
 nwGXd0g4zotVW2G93kibAXRKjXOvhP3DzSWSR6TG0WyX5RzCBS91dX35C+fNBYNfOA4F
 inQw==
X-Gm-Message-State: APjAAAU9PhdNst7TArimhiCkte3MDFNWZDtraTfj5X2IqIO/9o925U68
 tM5icApMVmdF/qceBM/qnDGGHh+9jlZX9wavmE2oEh9FpF4KD8aEYBNhT6Fo/aPXq9DpODSKciu
 uDxI1BmKn7jQgIhI=
X-Received: by 2002:a37:9503:: with SMTP id x3mr16440179qkd.418.1570312728907; 
 Sat, 05 Oct 2019 14:58:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw9VtevycKc0HeKndMsIjx8rupYe16IwuoUM/rmmy+2nvlDYCF6jabFibuZqm19kSVRv8ya5g==
X-Received: by 2002:a37:9503:: with SMTP id x3mr16440165qkd.418.1570312728600; 
 Sat, 05 Oct 2019 14:58:48 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 j7sm7435428qtc.73.2019.10.05.14.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:58:47 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:58:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/19] hw/acpi: Make ACPI IO address space configurable
Message-ID: <20190918130633.4872-2-shameerali.kolothum.thodi@huawei.com>
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005215843.xJXeu83lRlrSa4jcfYkbC_GTvwDt-Y_gQ4oyyh0uiBg@z>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

This is in preparation for adding support for ARM64 platforms
where it doesn't use port mapped IO for ACPI IO space. We are
making changes so that MMIO region can be accommodated
and board can pass the base address into the aml build function.

Also move few MEMORY_* definitions to header so that other memory
hotplug event signalling mechanisms (eg. Generic Event Device on
HW-reduced acpi platforms) can use the same from their respective
event handler code.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190918130633.4872-2-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/memory_hotplug.c         | 33 ++++++++++++++------------------
 hw/i386/acpi-build.c             |  7 ++++++-
 hw/i386/pc.c                     |  3 +++
 include/hw/acpi/memory_hotplug.h |  9 +++++++--
 include/hw/i386/pc.h             |  3 +++
 5 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 9483d66e86..9b0b150f4f 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -30,12 +30,7 @@
 #define MEMORY_SLOT_PROXIMITY_METHOD "MPXM"
 #define MEMORY_SLOT_EJECT_METHOD     "MEJ0"
 #define MEMORY_SLOT_NOTIFY_METHOD    "MTFY"
-#define MEMORY_SLOT_SCAN_METHOD      "MSCN"
 #define MEMORY_HOTPLUG_DEVICE        "MHPD"
-#define MEMORY_HOTPLUG_IO_LEN         24
-#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
-
-static uint16_t memhp_io_base;
 
 static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus *mdev)
 {
@@ -210,7 +205,7 @@ static const MemoryRegionOps acpi_memory_hotplug_ops = {
 };
 
 void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
-                              MemHotplugState *state, uint16_t io_base)
+                              MemHotplugState *state, hwaddr io_base)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
 
@@ -219,12 +214,10 @@ void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
         return;
     }
 
-    assert(!memhp_io_base);
-    memhp_io_base = io_base;
     state->devs = g_malloc0(sizeof(*state->devs) * state->dev_count);
     memory_region_init_io(&state->io, owner, &acpi_memory_hotplug_ops, state,
                           "acpi-mem-hotplug", MEMORY_HOTPLUG_IO_LEN);
-    memory_region_add_subregion(as, memhp_io_base, &state->io);
+    memory_region_add_subregion(as, io_base, &state->io);
 }
 
 /**
@@ -343,7 +336,8 @@ const VMStateDescription vmstate_memory_hotplug = {
 
 void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
                               const char *res_root,
-                              const char *event_handler_method)
+                              const char *event_handler_method,
+                              AmlRegionSpace rs, hwaddr memhp_io_base)
 {
     int i;
     Aml *ifctx;
@@ -352,10 +346,6 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
     Aml *mem_ctrl_dev;
     char *mhp_res_path;
 
-    if (!memhp_io_base) {
-        return;
-    }
-
     mhp_res_path = g_strdup_printf("%s." MEMORY_HOTPLUG_DEVICE, res_root);
     mem_ctrl_dev = aml_device("%s", mhp_res_path);
     {
@@ -366,14 +356,19 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
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
index 4e0f9f425a..1d077a7cb7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1888,7 +1888,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
                        "\\_SB.PCI0", "\\_GPE._E02");
     }
-    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0", "\\_GPE._E03");
+
+    if (pcms->memhp_io_base && nr_mem) {
+        build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0",
+                                 "\\_GPE._E03", AML_SYSTEM_IO,
+                                 pcms->memhp_io_base);
+    }
 
     scope =  aml_scope("_GPE");
     {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bcda50efcc..4b1904237e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1766,6 +1766,9 @@ void pc_memory_init(PCMachineState *pcms,
 
     /* Init default IOAPIC address space */
     pcms->ioapic_as = &address_space_memory;
+
+    /* Init ACPI memory hotplug IO base address */
+    pcms->memhp_io_base = ACPI_MEMORY_HOTPLUG_BASE;
 }
 
 /*
diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
index 77c65765d6..dfe9cf3fde 100644
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
+                              AmlRegionSpace rs, hwaddr memhp_io_base);
 #endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6df4f4b6fb..37bfd95113 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -70,6 +70,9 @@ struct PCMachineState {
     /* Address space used by IOAPIC device. All IOAPIC interrupts
      * will be translated to MSI messages in the address space. */
     AddressSpace *ioapic_as;
+
+    /* ACPI Memory hotplug IO base address */
+    hwaddr memhp_io_base;
 };
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
-- 
MST


