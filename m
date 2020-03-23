Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B33BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4657206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtJ52ygZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4657206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGOvt-0003JL-WF
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jGOvB-0002nF-2X
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jGOv2-0002Xn-PV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:23:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jGOv2-0002SY-M5
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584976991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLB+koY/nzkIGatIlw9Tknm3DRGakqlSWOy3P31GX9g=;
 b=LtJ52ygZGHt66WzTZ11YAcJia+8Gl0OrUWiRHPqCne3biag+bmUPQ+FBjJKUjl62CAcicC
 79xQJ+hSFggp77UAeJm5+xsCEZgnNyJHTTOXFWfdj8aqER+DGPjSdZwgbEvZiRD4z8sxv+
 NAcrT6YG7Tbp7z7X5dahVPP0az9teNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-DskXZGD2Payv6cu47_idaA-1; Mon, 23 Mar 2020 11:23:07 -0400
X-MC-Unique: DskXZGD2Payv6cu47_idaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9F9C107ACC4;
 Mon, 23 Mar 2020 15:23:05 +0000 (UTC)
Received: from localhost (unknown [10.40.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C65A419C70;
 Mon, 23 Mar 2020 15:22:44 +0000 (UTC)
Date: Mon, 23 Mar 2020 16:22:43 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 06/10] hw/arm/virt: Add nvdimm hot-plug infrastructure
Message-ID: <20200323162243.4e1574c4@redhat.com>
In-Reply-To: <20200311172014.33052-7-shameerali.kolothum.thodi@huawei.com>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
 <20200311172014.33052-7-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, david@redhat.com,
 shannon.zhaosl@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 17:20:10 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Kwangwoo Lee <kwangwoo.lee@sk.com>
> 
> This adds support to init nvdimm acpi state and build nvdimm acpi tables.
> Please note nvdimm_support is not yet enabled.
> 
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v2 -> v3
>  -Modified commit log.
> ---
>  hw/arm/Kconfig           |  1 +
>  hw/arm/virt-acpi-build.c |  6 ++++++
>  hw/arm/virt.c            | 19 +++++++++++++++++++
>  hw/mem/Kconfig           |  2 +-
>  include/hw/arm/virt.h    |  1 +
>  5 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index bc54fd61f9..b023c0ecd5 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -25,6 +25,7 @@ config ARM_VIRT
>      select DIMM
>      select ACPI_MEMORY_HOTPLUG
>      select ACPI_HW_REDUCED
> +    select ACPI_NVDIMM
>  
>  config CHEETAH
>      bool
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index c13710b727..b7d666b7a4 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -44,6 +44,7 @@
>  #include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci.h"
>  #include "hw/arm/virt.h"
> +#include "hw/mem/nvdimm.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/reset.h"
>  #include "kvm_arm.h"
> @@ -826,6 +827,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>          }
>      }
>  
> +    if (ms->nvdimms_state->is_enabled) {
> +        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
> +                          ms->nvdimms_state, ms->ram_slots);
> +    }
> +
>      if (its_class_name() && !vmc->no_its) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_iort(tables_blob, tables->linker, vms);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 32d865a488..18178553fa 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -148,6 +148,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
>      [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
>      [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
> +    [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -1784,6 +1785,18 @@ static void machvirt_init(MachineState *machine)
>  
>      create_platform_bus(vms);
>  
> +    if (machine->nvdimms_state->is_enabled) {
> +        const struct AcpiGenericAddress arm_virt_nvdimm_acpi_dsmio = {
> +            .space_id = AML_AS_SYSTEM_MEMORY,
> +            .address = vms->memmap[VIRT_NVDIMM_ACPI].base,
> +            .bit_width = NVDIMM_ACPI_IO_LEN << 3
> +        };
> +
> +        nvdimm_init_acpi_state(machine->nvdimms_state, sysmem,
> +                               arm_virt_nvdimm_acpi_dsmio,
> +                               vms->fw_cfg, OBJECT(vms));
> +    }
> +
>      vms->bootinfo.ram_size = machine->ram_size;
>      vms->bootinfo.nb_cpus = smp_cpus;
>      vms->bootinfo.board_id = -1;
> @@ -1970,6 +1983,8 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                               DeviceState *dev, Error **errp)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    MachineState *ms = MACHINE(hotplug_dev);
> +    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>      Error *local_err = NULL;
>  
>      pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
> @@ -1977,6 +1992,10 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>          goto out;
>      }
>  
> +    if (is_nvdimm) {
> +        nvdimm_plug(ms->nvdimms_state);
> +    }
> +
>      hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
>                           dev, &error_abort);
>  
> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> index 2ad052a536..c27844900d 100644
> --- a/hw/mem/Kconfig
> +++ b/hw/mem/Kconfig
> @@ -8,4 +8,4 @@ config MEM_DEVICE
>  config NVDIMM
>      bool
>      default y
> -    depends on (PC || PSERIES)
> +    depends on (PC || PSERIES || ARM_VIRT)
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 02f500cb8e..59588d18db 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -79,6 +79,7 @@ enum {
>      VIRT_SECURE_MEM,
>      VIRT_PCDIMM_ACPI,
>      VIRT_ACPI_GED,
> +    VIRT_NVDIMM_ACPI,
>      VIRT_LOWMEMMAP_LAST,
>  };
>  


