Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1DFC18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E579120856
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E579120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38926 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNIs-0001lc-3d
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:12:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTNHb-000160-8P
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hTNHZ-0003Id-IX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hTNHW-0003Dm-0a; Wed, 22 May 2019 05:11:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EFCB3154860;
	Wed, 22 May 2019 09:11:22 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 051FD17CDA;
	Wed, 22 May 2019 09:11:15 +0000 (UTC)
Date: Wed, 22 May 2019 11:11:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190522111115.3a6205b8@redhat.com>
In-Reply-To: <20190521062836.6541-2-richardw.yang@linux.intel.com>
References: <20190521062836.6541-1-richardw.yang@linux.intel.com>
	<20190521062836.6541-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 22 May 2019 09:11:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 1/2] hw/acpi: Consolidate build_mcfg to
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, thuth@redhat.com,
	mst@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
	qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 14:28:35 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> Now we have two identical build_mcfg functions.
> 
> Consolidate them in acpi/pci.c.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> v4:
>   * ACPI_PCI depends on both ACPI and PCI
>   * rebase on latest master, adjust arm Kconfig
> v3:
>   * adjust changelog based on Igor's suggestion
> ---
>  default-configs/i386-softmmu.mak |  1 +
>  hw/acpi/Kconfig                  |  4 +++
>  hw/acpi/Makefile.objs            |  1 +
>  hw/acpi/pci.c                    | 46 ++++++++++++++++++++++++++++++++
>  hw/arm/Kconfig                   |  1 +
>  hw/arm/virt-acpi-build.c         | 17 ------------
>  hw/i386/acpi-build.c             | 18 +------------
>  include/hw/acpi/pci.h            |  1 +
>  8 files changed, 55 insertions(+), 34 deletions(-)
>  create mode 100644 hw/acpi/pci.c
> 
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> index ba3fb3ff50..cd5ea391e8 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -25,3 +25,4 @@
>  CONFIG_ISAPC=y
>  CONFIG_I440FX=y
>  CONFIG_Q35=y
> +CONFIG_ACPI_PCI=y
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index eca3beed75..7c59cf900b 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -23,6 +23,10 @@ config ACPI_NVDIMM
>      bool
>      depends on ACPI
>  
> +config ACPI_PCI
> +    bool
> +    depends on ACPI && PCI
> +
>  config ACPI_VMGENID
>      bool
>      default y
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 2d46e3789a..661a9b8c2f 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -11,6 +11,7 @@ common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>  common-obj-y += acpi_interface.o
>  common-obj-y += bios-linker-loader.o
>  common-obj-y += aml-build.o
> +common-obj-$(CONFIG_ACPI_PCI) += pci.o
>  common-obj-$(CONFIG_TPM) += tpm.o
>  
>  common-obj-$(CONFIG_IPMI) += ipmi.o
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> new file mode 100644
> index 0000000000..fa0fa30bb9
> --- /dev/null
> +++ b/hw/acpi/pci.c
> @@ -0,0 +1,46 @@
> +/*
> + * Support for generating PCI related ACPI tables and passing them to Guests
> + *
> + * Copyright (C) 2006 Fabrice Bellard
> + * Copyright (C) 2008-2010  Kevin O'Connor <kevin@koconnor.net>
> + * Copyright (C) 2013-2019 Red Hat Inc
> + * Copyright (C) 2019 Intel Corporation
> + *
> + * Author: Wei Yang <richardw.yang@linux.intel.com>
> + * Author: Michael S. Tsirkin <mst@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/pci.h"
> +#include "hw/pci/pcie_host.h"
> +
> +void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> +{
> +    AcpiTableMcfg *mcfg;
> +    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
> +
> +    mcfg = acpi_data_push(table_data, len);
> +    mcfg->allocation[0].address = cpu_to_le64(info->base);
> +
> +    /* Only a single allocation so no need to play with segments */
> +    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
> +    mcfg->allocation[0].start_bus_number = 0;
> +    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
> +
> +    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
> +}
> +
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index af8cffde9c..9aced9d54d 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -19,6 +19,7 @@ config ARM_VIRT
>      select PLATFORM_BUS
>      select SMBIOS
>      select VIRTIO_MMIO
> +    select ACPI_PCI
>  
>  config CHEETAH
>      bool
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e7c96d658e..4a64f9985c 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -546,23 +546,6 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                   "SRAT", table_data->len - srat_start, 3, NULL, NULL);
>  }
>  
> -static void
> -build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> -{
> -    AcpiTableMcfg *mcfg;
> -    int len = sizeof(*mcfg) + sizeof(mcfg->allocation[0]);
> -
> -    mcfg = acpi_data_push(table_data, len);
> -    mcfg->allocation[0].address = cpu_to_le64(info->base);
> -
> -    /* Only a single allocation so no need to play with segments */
> -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
> -    mcfg->allocation[0].start_bus_number = 0;
> -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
> -
> -    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
> -}
> -
>  /* GTDT */
>  static void
>  build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 0d78d73894..85dc1640bc 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2405,22 +2405,6 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>                   table_data->len - srat_start, 1, NULL, NULL);
>  }
>  
> -static void
> -build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
> -{
> -    AcpiTableMcfg *mcfg;
> -    int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
> -
> -    mcfg = acpi_data_push(table_data, len);
> -    mcfg->allocation[0].address = cpu_to_le64(info->base);
> -    /* Only a single allocation so no need to play with segments */
> -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
> -    mcfg->allocation[0].start_bus_number = 0;
> -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->size - 1);
> -
> -    build_header(linker, table_data, (void *)mcfg, "MCFG", len, 1, NULL, NULL);
> -}
> -
>  /*
>   * VT-d spec 8.1 DMA Remapping Reporting Structure
>   * (version Oct. 2014 or later)
> @@ -2690,7 +2674,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>      }
>      if (acpi_get_mcfg(&mcfg)) {
>          acpi_add_table(table_offsets, tables_blob);
> -        build_mcfg_q35(tables_blob, tables->linker, &mcfg);
> +        build_mcfg(tables_blob, tables->linker, &mcfg);
>      }
>      if (x86_iommu_get_default()) {
>          IommuType IOMMUType = x86_iommu_get_type();
> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> index 124af7d32a..8bbd32cf45 100644
> --- a/include/hw/acpi/pci.h
> +++ b/include/hw/acpi/pci.h
> @@ -30,4 +30,5 @@ typedef struct AcpiMcfgInfo {
>      uint32_t size;
>  } AcpiMcfgInfo;
>  
> +void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info);
>  #endif


