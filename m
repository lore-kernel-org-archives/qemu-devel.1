Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A445C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CC921655
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLOkAixe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CC921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAqa-00081v-1J
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 09:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iUApr-0007Tz-LO
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iUApo-0006Oj-Eh
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:38:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iUApo-0006OB-7P
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573483107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+8Uh2nV5a8/IJopEh5bHa5TUy7eygDhpJDpFvRnIbU=;
 b=KLOkAixeeZCzbmx86Fa2YQy7N1yj3yX25I7qCTs6RG8hKdIrEPaAuOrHzt6nVVuZdyeFe5
 OXAeqr0kYf7Jkp1OmVmsidFown3M5zyTQhDKGmKRfo4ECKL2a+KnCSaXk+bfTab5P6V32/
 0DCLfNTtZVR6tqeat+tXs1SjCm4Gw48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-LTKKiDpePgiuSvMBo0F0Hw-1; Mon, 11 Nov 2019 09:38:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63FDC800D49;
 Mon, 11 Nov 2019 14:38:22 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B634B5DD73;
 Mon, 11 Nov 2019 14:38:17 +0000 (UTC)
Date: Mon, 11 Nov 2019 15:38:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 3/5] hw/arm/virt: Add nvdimm hot-plug infrastructure
Message-ID: <20191111153815.0593fc8f@redhat.com>
In-Reply-To: <20191004155302.4632-4-shameerali.kolothum.thodi@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <20191004155302.4632-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: LTKKiDpePgiuSvMBo0F0Hw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 16:53:00 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Kwangwoo Lee <kwangwoo.lee@sk.com>
>=20
> Pre-plug and plug handlers are prepared for NVDIMM support.

Prepare pre-plug and plug handlers for NVDIMM support.

> Please note nvdimm_support is not yet enabled.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/Kconfig           |  1 +
>  hw/arm/virt-acpi-build.c |  6 ++++++
>  hw/arm/virt.c            | 22 +++++++++++++++++++++-
>  hw/mem/Kconfig           |  2 +-
>  include/hw/arm/virt.h    |  1 +
>  5 files changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index c6e7782580..851dd81289 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -24,6 +24,7 @@ config ARM_VIRT
>      select DIMM
>      select ACPI_MEMORY_HOTPLUG
>      select ACPI_HW_REDUCED
> +    select ACPI_NVDIMM
> =20
>  config CHEETAH
>      bool
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 074e0c858e..4e63f5da48 100644
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
> @@ -835,6 +836,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuil=
dTables *tables)
>          }
>      }
> =20
> +    if (ms->nvdimms_state->is_enabled) {
> +        nvdimm_build_acpi(table_offsets, tables_blob, tables->linker,
> +                          ms->nvdimms_state, ms->ram_slots);
> +    }
> +
>      if (its_class_name() && !vmc->no_its) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_iort(tables_blob, tables->linker, vms);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d4bedc2607..30bc8a7803 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -143,6 +143,7 @@ static const MemMapEntry base_memmap[] =3D {
>      [VIRT_SMMU] =3D               { 0x09050000, 0x00020000 },
>      [VIRT_PCDIMM_ACPI] =3D        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
>      [VIRT_ACPI_GED] =3D           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
> +    [VIRT_NVDIMM_ACPI] =3D        { 0x09090000, NVDIMM_ACPI_IO_LEN},
>      [VIRT_MMIO] =3D               { 0x0a000000, 0x00000200 },
>      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that s=
ize */
>      [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
> @@ -1750,6 +1751,18 @@ static void machvirt_init(MachineState *machine)
> =20
>      create_platform_bus(vms, pic);
> =20
> +    if (machine->nvdimms_state->is_enabled) {
> +        const struct AcpiGenericAddress arm_virt_nvdimm_acpi_dsmio =3D {
> +            .space_id =3D AML_AS_SYSTEM_MEMORY,
> +            .address =3D vms->memmap[VIRT_NVDIMM_ACPI].base,
> +            .bit_width =3D NVDIMM_ACPI_IO_LEN << 3
> +        };
> +
> +        nvdimm_init_acpi_state(machine->nvdimms_state, sysmem,
> +                               arm_virt_nvdimm_acpi_dsmio,
> +                               vms->fw_cfg, OBJECT(vms));
> +    }
> +
>      vms->bootinfo.ram_size =3D machine->ram_size;
>      vms->bootinfo.nb_cpus =3D smp_cpus;
>      vms->bootinfo.board_id =3D -1;
> @@ -1916,9 +1929,10 @@ static void virt_memory_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>                                   Error **errp)
>  {
>      VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
> +    MachineState *ms =3D MACHINE(hotplug_dev);
>      const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
> =20
> -    if (is_nvdimm) {
> +    if (is_nvdimm && (!ms->nvdimms_state->is_enabled)) {
shouldn't shouldn't this hunk go to 5/5 where functionality is eventually
enabled and use the same error message as in pc_memory_pre_plug()

>          error_setg(errp, "nvdimm is not yet supported");
>          return;
>      }
> @@ -1937,6 +1951,8 @@ static void virt_memory_plug(HotplugHandler *hotplu=
g_dev,
>  {
>      HotplugHandlerClass *hhc;
>      VirtMachineState *vms =3D VIRT_MACHINE(hotplug_dev);
> +    MachineState *ms =3D MACHINE(hotplug_dev);
> +    bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>      Error *local_err =3D NULL;
> =20
>      pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), &local_err);
> @@ -1944,6 +1960,10 @@ static void virt_memory_plug(HotplugHandler *hotpl=
ug_dev,
>          goto out;
>      }
> =20
> +    if (is_nvdimm) {
> +        nvdimm_plug(ms->nvdimms_state);
> +    }
> +
>      hhc =3D HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
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
> index 0b41083e9d..06d5e75611 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -79,6 +79,7 @@ enum {
>      VIRT_SECURE_MEM,
>      VIRT_PCDIMM_ACPI,
>      VIRT_ACPI_GED,
> +    VIRT_NVDIMM_ACPI,
>      VIRT_LOWMEMMAP_LAST,
>  };
> =20


