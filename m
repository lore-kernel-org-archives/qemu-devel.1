Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9652C04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 02:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9217520675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 02:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9217520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56603 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSY2N-000308-DP
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 22:28:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSY1S-0002eP-Fi
	for qemu-devel@nongnu.org; Sun, 19 May 2019 22:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSY1P-0001UU-Kg
	for qemu-devel@nongnu.org; Sun, 19 May 2019 22:27:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:5906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSY1L-0001SV-K7; Sun, 19 May 2019 22:27:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 May 2019 19:27:21 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga007.fm.intel.com with ESMTP; 19 May 2019 19:27:19 -0700
Date: Mon, 20 May 2019 10:26:49 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190520022648.GA15986@richard>
References: <20190520005957.6953-1-richardw.yang@linux.intel.com>
	<20190520005957.6953-6-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520005957.6953-6-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH v5 5/6] hw/acpi: Consolidate build_mcfg to
 pci.c
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, thuth@redhat.com,
	mst@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
	qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 08:59:56AM +0800, Wei Yang wrote:
>Now we have two identical build_mcfg functions.
>
>Consolidate them in acpi/pci.c.
>
>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Oops, I should drop these SOB.

>
>---
>v4:
>  * ACPI_PCI depends on both ACPI and PCI
>  * rebase on latest master, adjust arm Kconfig
>v3:
>  * adjust changelog based on Igor's suggestion
>---
> default-configs/i386-softmmu.mak |  1 +
> hw/acpi/Kconfig                  |  4 +++
> hw/acpi/Makefile.objs            |  1 +
> hw/acpi/pci.c                    | 46 ++++++++++++++++++++++++++++++++
> hw/arm/Kconfig                   |  1 +
> hw/arm/virt-acpi-build.c         | 17 ------------
> hw/i386/acpi-build.c             | 18 +------------
> include/hw/acpi/pci.h            |  1 +
> 8 files changed, 55 insertions(+), 34 deletions(-)
> create mode 100644 hw/acpi/pci.c
>
>diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
>index ba3fb3ff50..cd5ea391e8 100644
>--- a/default-configs/i386-softmmu.mak
>+++ b/default-configs/i386-softmmu.mak
>@@ -25,3 +25,4 @@
> CONFIG_ISAPC=y
> CONFIG_I440FX=y
> CONFIG_Q35=y
>+CONFIG_ACPI_PCI=y
>diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
>index eca3beed75..7c59cf900b 100644
>--- a/hw/acpi/Kconfig
>+++ b/hw/acpi/Kconfig
>@@ -23,6 +23,10 @@ config ACPI_NVDIMM
>     bool
>     depends on ACPI
> 
>+config ACPI_PCI
>+    bool
>+    depends on ACPI && PCI
>+
> config ACPI_VMGENID
>     bool
>     default y
>diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
>index 2d46e3789a..661a9b8c2f 100644
>--- a/hw/acpi/Makefile.objs
>+++ b/hw/acpi/Makefile.objs
>@@ -11,6 +11,7 @@ common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
> common-obj-y += acpi_interface.o
> common-obj-y += bios-linker-loader.o
> common-obj-y += aml-build.o
>+common-obj-$(CONFIG_ACPI_PCI) += pci.o
> common-obj-$(CONFIG_TPM) += tpm.o
> 
> common-obj-$(CONFIG_IPMI) += ipmi.o
>diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
>new file mode 100644
>index 0000000000..fa0fa30bb9
>--- /dev/null
>+++ b/hw/acpi/pci.c
>@@ -0,0 +1,46 @@
>+/*
>+ * Support for generating PCI related ACPI tables and passing them to Guests
>+ *
>+ * Copyright (C) 2006 Fabrice Bellard
>+ * Copyright (C) 2008-2010  Kevin O'Connor <kevin@koconnor.net>
>+ * Copyright (C) 2013-2019 Red Hat Inc
>+ * Copyright (C) 2019 Intel Corporation
>+ *
>+ * Author: Wei Yang <richardw.yang@linux.intel.com>
>+ * Author: Michael S. Tsirkin <mst@redhat.com>
>+ *
>+ * This program is free software; you can redistribute it and/or modify
>+ * it under the terms of the GNU General Public License as published by
>+ * the Free Software Foundation; either version 2 of the License, or
>+ * (at your option) any later version.
>+
>+ * This program is distributed in the hope that it will be useful,
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>+ * GNU General Public License for more details.
>+
>+ * You should have received a copy of the GNU General Public License along
>+ * with this program; if not, see <http://www.gnu.org/licenses/>.
>+ */
>+
>+#include "qemu/osdep.h"
>+#include "hw/acpi/aml-build.h"
>+#include "hw/acpi/pci.h"
>+#include "hw/pci/pcie_host.h"
>+
>+void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>+{
>+    AcpiTableMcfg *mcfg;
>+    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
>+
>+    mcfg = acpi_data_push(table_data, len);
>+    mcfg->allocation[0].address = cpu_to_le64(info->base);
>+
>+    /* Only a single allocation so no need to play with segments */
>+    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>+    mcfg->allocation[0].start_bus_number = 0;
>+    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
>+
>+    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>+}
>+
>diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>index af8cffde9c..9aced9d54d 100644
>--- a/hw/arm/Kconfig
>+++ b/hw/arm/Kconfig
>@@ -19,6 +19,7 @@ config ARM_VIRT
>     select PLATFORM_BUS
>     select SMBIOS
>     select VIRTIO_MMIO
>+    select ACPI_PCI
> 
> config CHEETAH
>     bool
>diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>index e7c96d658e..4a64f9985c 100644
>--- a/hw/arm/virt-acpi-build.c
>+++ b/hw/arm/virt-acpi-build.c
>@@ -546,23 +546,6 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                  "SRAT", table_data->len - srat_start, 3, NULL, NULL);
> }
> 
>-static void
>-build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>-{
>-    AcpiTableMcfg *mcfg;
>-    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
>-
>-    mcfg = acpi_data_push(table_data, len);
>-    mcfg->allocation[0].address = cpu_to_le64(info->base);
>-
>-    /* Only a single allocation so no need to play with segments */
>-    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>-    mcfg->allocation[0].start_bus_number = 0;
>-    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
>-
>-    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>-}
>-
> /* GTDT */
> static void
> build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>index 0d78d73894..85dc1640bc 100644
>--- a/hw/i386/acpi-build.c
>+++ b/hw/i386/acpi-build.c
>@@ -2405,22 +2405,6 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>                  table_data->len - srat_start, 1, NULL, NULL);
> }
> 
>-static void
>-build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>-{
>-    AcpiTableMcfg *mcfg;
>-    int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
>-
>-    mcfg = acpi_data_push(table_data, len);
>-    mcfg->allocation[0].address = cpu_to_le64(info->base);
>-    /* Only a single allocation so no need to play with segments */
>-    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>-    mcfg->allocation[0].start_bus_number = 0;
>-    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
>-
>-    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
>-}
>-
> /*
>  * VT-d spec 8.1 DMA Remapping Reporting Structure
>  * (version Oct. 2014 or later)
>@@ -2690,7 +2674,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>     }
>     if (acpi_get_mcfg(&mcfg)) {
>         acpi_add_table(table_offsets, tables_blob);
>-        build_mcfg_q35(tables_blob, tables->linker, &mcfg);
>+        build_mcfg(tables_blob, tables->linker, &mcfg);
>     }
>     if (x86_iommu_get_default()) {
>         IommuType IOMMUType = x86_iommu_get_type();
>diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
>index 124af7d32a..8bbd32cf45 100644
>--- a/include/hw/acpi/pci.h
>+++ b/include/hw/acpi/pci.h
>@@ -30,4 +30,5 @@ typedef struct AcpiMcfgInfo {
>     uint32_t size;
> } AcpiMcfgInfo;
> 
>+void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info);
> #endif
>-- 
>2.19.1

-- 
Wei Yang
Help you, Help me

