Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EABC04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3D820818
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3D820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRLFG-0007gF-UV
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 14:36:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRLEJ-00075S-C8
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRLEH-0003Xf-SF
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:35:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRLEH-0003Ww-Lv
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:35:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so7645255wme.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 11:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Mtihu+D1CKfb2Lz5cJJNlyb+I2hHT9gFed5bBMoKBYM=;
	b=K/7/KOGh37+rz3km3WF4842mRHfNwQKw1mgpTBvwXtG3D8mai2rIThf+GfdN52jmuA
	+9r8cptqf+YxFd7YEJEhnTiSKJXPHfxvBbW4nS1/7o7s3/qRw1G0q7ONZv+ktrb22A30
	+SW8dUDc7wcEyPiANLI9uM6WpSjV02eyUVvsGKi1cAVr/V2fUmCJtK6xGdHTpM6P2s0i
	MmQ8NakK/dQRcIHYC5jP/SO4/vk66gohbvzcJek+m2Bh01Tm+I8LctoVQLWLdx/+7uFX
	Fsan1IFYzyFtpYOhihyusRtPdFJgUUzCzBjjWEUhfxfO0BvdJsY380SJzG4B5zYI8uhj
	kq3Q==
X-Gm-Message-State: APjAAAVGvsA9SFMvV/S+2hHLzyk4dsINFT2UuvDZSZVPZ6S9mDqLBtYN
	sqJCs/pQPCac9Z8t4L4uF90txQ==
X-Google-Smtp-Source: APXvYqwFeiWZbPCWo7c7Dc8cXQfw8cJ0KKLIcGwTzjAkJLP3rg2XDltAxYhBtz7/yioNO0ia0qMVVg==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr29498727wmc.36.1558031744694; 
	Thu, 16 May 2019 11:35:44 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	f10sm9704515wrg.24.2019.05.16.11.35.43
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 11:35:44 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
References: <20190419003053.8260-1-richardw.yang@linux.intel.com>
	<20190419003053.8260-6-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <911eb251-8525-0efb-089b-d3feec5c68d1@redhat.com>
Date: Thu, 16 May 2019 20:35:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419003053.8260-6-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v4 5/6] hw/acpi: Consolidate build_mcfg to
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org,
	Thomas Huth <thuth@redhat.com>, mst@redhat.com,
	shannon.zhaosl@gmail.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/19/19 2:30 AM, Wei Yang wrote:
> Now we have two identical build_mcfg functions.
> 
> Consolidate them in acpi/pci.c.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> ---
> v3:
>   * adjust changelog based on Igor's suggestion
> ---
>  default-configs/arm-softmmu.mak  |  1 +
>  default-configs/i386-softmmu.mak |  1 +
>  hw/acpi/Kconfig                  |  4 +++
>  hw/acpi/Makefile.objs            |  1 +
>  hw/acpi/pci.c                    | 46 ++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c         | 17 ------------
>  hw/i386/acpi-build.c             | 18 +------------
>  include/hw/acpi/pci.h            |  1 +
>  8 files changed, 55 insertions(+), 34 deletions(-)
>  create mode 100644 hw/acpi/pci.c
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 613d19a06d..8f2796e195 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -144,6 +144,7 @@ CONFIG_XIO3130=y
>  CONFIG_IOH3420=y
>  CONFIG_I82801B11=y
>  CONFIG_ACPI=y
> +CONFIG_ACPI_PCI=y
>  CONFIG_ARM_VIRT=y
>  CONFIG_SMBIOS=y
>  CONFIG_ASPEED_SOC=y
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
> index eca3beed75..7265843cc3 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -23,6 +23,10 @@ config ACPI_NVDIMM
>      bool
>      depends on ACPI
>  
> +config ACPI_PCI
> +    bool
> +    depends on ACPI

Shouldn't this be "depends on ACPI && PCI"?

> +
>  config ACPI_VMGENID
>      bool
>      default y
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index ba93c5b64a..9bb2101e3b 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -11,6 +11,7 @@ common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>  common-obj-y += acpi_interface.o
>  common-obj-y += bios-linker-loader.o
>  common-obj-y += aml-build.o utils.o
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
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index ebddcde596..e3353de9e4 100644
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
> index c2de7f4b01..29980bb3f4 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2393,22 +2393,6 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
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
> @@ -2678,7 +2662,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
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
> 

