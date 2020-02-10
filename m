Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B0BC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920FD2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AX7k55MM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920FD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j19Es-0008TH-On
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j19Dj-0007fe-Oy
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j19Dh-00028U-TZ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:35:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j19Dh-000285-PA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581341724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTrhf2L7AWCAm3nwHHBQS39Og4+yyK0u7Oe+PVNHEAI=;
 b=AX7k55MM31K71f3NGEHldNOIdrdxsR2WzoJjveClVq/fcyfID5DXQ1xeTOmwfmh2vDP8B5
 HsPztS80X7/UVcjfSZWYw11EcGHKu22ho4PDc7V8bMmqpj9Y08nQr2/R/8zA/+Jn92AnNW
 LPdnJTfhm75K2qRi/jTACpOn1elEk9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-k7zHSwwMPQaT0MjaS5-Qng-1; Mon, 10 Feb 2020 08:35:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A02B6801FAA;
 Mon, 10 Feb 2020 13:35:18 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E310E1001B2D;
 Mon, 10 Feb 2020 13:35:08 +0000 (UTC)
Date: Mon, 10 Feb 2020 14:35:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 4/7] hw/arm/virt: Add nvdimm hot-plug infrastructure
Message-ID: <20200210143507.63e54bd0@redhat.com>
In-Reply-To: <20200117174522.22044-5-shameerali.kolothum.thodi@huawei.com>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
 <20200117174522.22044-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: k7zHSwwMPQaT0MjaS5-Qng-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 17:45:19 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Kwangwoo Lee <kwangwoo.lee@sk.com>
> 
> Prepare pre-plug and plug handlers for NVDIMM support.
> Please note nvdimm_support is not yet enabled.

looks fine to me,
except of commit message which should be updated to reflect
what patch actually does.

> 
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/Kconfig           |  1 +
>  hw/arm/virt-acpi-build.c |  6 ++++++
>  hw/arm/virt.c            | 19 +++++++++++++++++++
>  hw/mem/Kconfig           |  2 +-
>  include/hw/arm/virt.h    |  1 +
>  5 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index c6e7782580..851dd81289 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -24,6 +24,7 @@ config ARM_VIRT
>      select DIMM
>      select ACPI_MEMORY_HOTPLUG
>      select ACPI_HW_REDUCED
> +    select ACPI_NVDIMM
>  
>  config CHEETAH
>      bool
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index bd5f771e9b..c51eae549e 100644
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
> @@ -839,6 +840,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
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
> index 39ab5f47e0..7987c8f5b8 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -143,6 +143,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
>      [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
>      [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
> +    [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
>      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
>      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> @@ -1749,6 +1750,18 @@ static void machvirt_init(MachineState *machine)
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
> @@ -1936,6 +1949,8 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>  {
>      HotplugHandlerClass *hhc;
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    MachineState *ms = MACHINE(hotplug_dev);
> +    bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>      Error *local_err = NULL;
>  
>      pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
> @@ -1943,6 +1958,10 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>          goto out;
>      }
>  
> +    if (is_nvdimm) {
> +        nvdimm_plug(ms->nvdimms_state);
> +    }
> +
>      hhc = HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
>      hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &error_abort);
>  out:
> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> index 620fd4cb59..0d5f8f321a 100644
> --- a/hw/mem/Kconfig
> +++ b/hw/mem/Kconfig
> @@ -8,4 +8,4 @@ config MEM_DEVICE
>  config NVDIMM
>      bool
>      default y
> -    depends on PC
> +    depends on PC || ARM_VIRT
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 38f0c33c77..9c9eaaa89d 100644
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


