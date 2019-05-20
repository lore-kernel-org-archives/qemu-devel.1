Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C62C04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 01:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199BA20675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 01:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199BA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55784 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSWkJ-0004Ny-AY
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 21:05:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSWfm-00017G-3h
	for qemu-devel@nongnu.org; Sun, 19 May 2019 21:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSWfk-0006g0-N1
	for qemu-devel@nongnu.org; Sun, 19 May 2019 21:01:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:13790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSWfh-0006aZ-HO; Sun, 19 May 2019 21:00:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 May 2019 18:00:56 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga008.jf.intel.com with ESMTP; 19 May 2019 18:00:54 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Mon, 20 May 2019 08:59:55 +0800
Message-Id: <20190520005957.6953-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190520005957.6953-1-richardw.yang@linux.intel.com>
References: <20190520005957.6953-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.120
Subject: [Qemu-devel] [PATCH v5 4/6] hw/arm/virt-acpi-build: pass
 AcpiMcfgInfo to build_mcfg()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, thuth@redhat.com,
	mst@redhat.com, shannon.zhaosl@gmail.com,
	Wei Yang <richardw.yang@linux.intel.com>, imammedo@redhat.com,
	philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To build MCFG, two information is necessary:

    * bus number
    * base address

Abstract these two information to AcpiMcfgInfo so that build_mcfg and
build_mcfg_q35 will have the same declaration.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

---
v4:
  * rebase on latest master
v3:
  * move AcpiMcfgInfo to pci.h
v2:
  * for arm platform, construct a AcpiMcfgInfo directly
---
 hw/arm/virt-acpi-build.c | 18 +++++++++++-------
 hw/i386/acpi-build.c     |  6 +-----
 include/hw/acpi/pci.h    | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/acpi/pci.h

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 12dbaf3846..e7c96d658e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -40,6 +40,7 @@
 #include "hw/loader.h"
 #include "hw/hw.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/pci.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/arm/virt.h"
@@ -546,21 +547,18 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 }
 
 static void
-build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
 {
     AcpiTableMcfg *mcfg;
-    const MemMapEntry *memmap = vms->memmap;
-    int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
     int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
 
     mcfg = acpi_data_push(table_data, len);
-    mcfg->allocation[0].address = cpu_to_le64(memmap[ecam_id].base);
+    mcfg->allocation[0].address = cpu_to_le64(info->base);
 
     /* Only a single allocation so no need to play with segments */
     mcfg->allocation[0].pci_segment = cpu_to_le16(0);
     mcfg->allocation[0].start_bus_number = 0;
-    mcfg->allocation[0].end_bus_number =
-        PCIE_MMCFG_BUS(memmap[ecam_id].size - 1);
+    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
 
     build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
 }
@@ -801,7 +799,13 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_gtdt(tables_blob, tables->linker, vms);
 
     acpi_add_table(table_offsets, tables_blob);
-    build_mcfg(tables_blob, tables->linker, vms);
+    {
+        AcpiMcfgInfo mcfg = {
+           .base = vms->memmap[VIRT_ECAM_ID(vms->highmem_ecam)].base,
+           .size = vms->memmap[VIRT_ECAM_ID(vms->highmem_ecam)].size,
+        };
+        build_mcfg(tables_blob, tables->linker, &mcfg);
+    }
 
     acpi_add_table(table_offsets, tables_blob);
     build_spcr(tables_blob, tables->linker, vms);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9c1152c819..0d78d73894 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -59,6 +59,7 @@
 #include "hw/i386/x86-iommu.h"
 
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/pci.h"
 
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
@@ -87,11 +88,6 @@
 /* Default IOAPIC ID */
 #define ACPI_BUILD_IOAPIC_ID 0x0
 
-typedef struct AcpiMcfgInfo {
-    uint64_t base;
-    uint32_t size;
-} AcpiMcfgInfo;
-
 typedef struct AcpiPmInfo {
     bool s3_disabled;
     bool s4_disabled;
diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
new file mode 100644
index 0000000000..124af7d32a
--- /dev/null
+++ b/include/hw/acpi/pci.h
@@ -0,0 +1,33 @@
+/*
+ * Support for generating PCI related ACPI tables and passing them to Guests
+ *
+ * Copyright (C) 2006 Fabrice Bellard
+ * Copyright (C) 2008-2010  Kevin O'Connor <kevin@koconnor.net>
+ * Copyright (C) 2013-2019 Red Hat Inc
+ * Copyright (C) 2019 Intel Corporation
+ *
+ * Author: Wei Yang <richardw.yang@linux.intel.com>
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef HW_ACPI_PCI_H
+#define HW_ACPI_PCI_H
+
+typedef struct AcpiMcfgInfo {
+    uint64_t base;
+    uint32_t size;
+} AcpiMcfgInfo;
+
+#endif
-- 
2.19.1


