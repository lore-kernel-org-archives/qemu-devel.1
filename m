Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E92BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CBB21783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR1XKX/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CBB21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAdG-00030p-97
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 09:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iUAcV-0002R2-Qm
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iUAcT-00015X-Cc
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:24:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39119
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iUAcT-00015J-7m
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573482280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c5MLCRruWAeKvnK3HfmEpVctzcmYx4mCz+j9wkkF96Q=;
 b=NR1XKX/pgG95scv9iusXgvlL+VbHIk48UCj/fcEe/eMSh5zMzSKJjqnj11Y+M36Di8U7qr
 1vBULuIwR8YFG6gUr53unzJfHFWTBUkqbB2rg+RrQ9YDHLf652Xf3DkAnd3nPCwbWV6IlT
 S7lC06cPM+xu8wYcaiarE1EjhlBLg+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-Uii5XZuxPaCUaowUA6E6Mw-1; Mon, 11 Nov 2019 09:24:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D1AB107AD2F;
 Mon, 11 Nov 2019 14:24:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AED131823C;
 Mon, 11 Nov 2019 14:24:31 +0000 (UTC)
Date: Mon, 11 Nov 2019 15:24:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 2/5] nvdimm: Use configurable ACPI IO base and size
Message-ID: <20191111152429.50b02929@redhat.com>
In-Reply-To: <20191004155302.4632-3-shameerali.kolothum.thodi@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <20191004155302.4632-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Uii5XZuxPaCUaowUA6E6Mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On Fri, 4 Oct 2019 16:52:59 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Kwangwoo Lee <kwangwoo.lee@sk.com>
>=20
> This patch makes IO base and size configurable to create NPIO AML for
> ACPI NFIT. Since a different architecture like AArch64 does not use
> port-mapped IO, a configurable IO base is required to create correct
> mapping of ACPI IO address and size.
>=20
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/acpi/nvdimm.c        | 32 ++++++++++++++++++++++----------
>  hw/i386/acpi-build.c    |  6 ++++++
>  hw/i386/acpi-build.h    |  3 +++
>  hw/i386/pc_piix.c       |  2 ++
>  hw/i386/pc_q35.c        |  2 ++
>  include/hw/mem/nvdimm.h |  3 +++
>  6 files changed, 38 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 9fdad6dc3f..f91eea3802 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -926,11 +926,13 @@ void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_de=
v, DeviceState *dev)
>  }
> =20
>  void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
> +                            struct AcpiGenericAddress dsm_io,
>                              FWCfgState *fw_cfg, Object *owner)
>  {
> +    state->dsm_io =3D dsm_io;
>      memory_region_init_io(&state->io_mr, owner, &nvdimm_dsm_ops, state,
> -                          "nvdimm-acpi-io", NVDIMM_ACPI_IO_LEN);
> -    memory_region_add_subregion(io, NVDIMM_ACPI_IO_BASE, &state->io_mr);
> +                          "nvdimm-acpi-io", dsm_io.bit_width >> 3);
> +    memory_region_add_subregion(io, dsm_io.address, &state->io_mr);
> =20
>      state->dsm_mem =3D g_array_new(false, true /* clear */, 1);
>      acpi_data_push(state->dsm_mem, sizeof(NvdimmDsmIn));
> @@ -959,12 +961,14 @@ void nvdimm_init_acpi_state(NVDIMMState *state, Mem=
oryRegion *io,
> =20
>  #define NVDIMM_QEMU_RSVD_UUID   "648B9CF2-CDA1-4312-8AD9-49C4AF32BD62"
> =20
> -static void nvdimm_build_common_dsm(Aml *dev)
> +static void nvdimm_build_common_dsm(Aml *dev,
> +                                    NVDIMMState *nvdimm_state)
>  {
>      Aml *method, *ifctx, *function, *handle, *uuid, *dsm_mem, *elsectx2;
>      Aml *elsectx, *unsupport, *unpatched, *expected_uuid, *uuid_invalid;
>      Aml *pckg, *pckg_index, *pckg_buf, *field, *dsm_out_buf, *dsm_out_bu=
f_size;
>      uint8_t byte_list[1];
> +    AmlRegionSpace rs;
> =20
>      method =3D aml_method(NVDIMM_COMMON_DSM, 5, AML_SERIALIZED);
>      uuid =3D aml_arg(0);
> @@ -975,9 +979,16 @@ static void nvdimm_build_common_dsm(Aml *dev)
> =20
>      aml_append(method, aml_store(aml_name(NVDIMM_ACPI_MEM_ADDR), dsm_mem=
));
> =20
> +    if (nvdimm_state->dsm_io.space_id =3D=3D AML_AS_SYSTEM_IO) {
> +        rs =3D AML_SYSTEM_IO;
> +    } else {
> +        rs =3D AML_SYSTEM_MEMORY;
> +    }
> +
>      /* map DSM memory and IO into ACPI namespace. */
> -    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, AML_SYSTE=
M_IO,
> -               aml_int(NVDIMM_ACPI_IO_BASE), NVDIMM_ACPI_IO_LEN));
> +    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, rs,
> +               aml_int(nvdimm_state->dsm_io.address),
> +               nvdimm_state->dsm_io.bit_width >> 3));
>      aml_append(method, aml_operation_region(NVDIMM_DSM_MEMORY,
>                 AML_SYSTEM_MEMORY, dsm_mem, sizeof(NvdimmDsmIn)));
> =20
> @@ -992,7 +1003,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
>      field =3D aml_field(NVDIMM_DSM_IOPORT, AML_DWORD_ACC, AML_NOLOCK,
>                        AML_PRESERVE);
>      aml_append(field, aml_named_field(NVDIMM_DSM_NOTIFY,
> -               NVDIMM_ACPI_IO_LEN * BITS_PER_BYTE));
> +              (nvdimm_state->dsm_io.bit_width >> 3) * BITS_PER_BYTE));
Why are you converting bits to bytes and then back to bits, here?


>      aml_append(method, field);
> =20
>      /*
> @@ -1260,7 +1271,8 @@ static void nvdimm_build_nvdimm_devices(Aml *root_d=
ev, uint32_t ram_slots)
>  }
> =20
>  static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
> -                              BIOSLinker *linker, GArray *dsm_dma_area,
> +                              BIOSLinker *linker,
> +                              NVDIMMState *nvdimm_state,
>                                uint32_t ram_slots)
>  {
>      Aml *ssdt, *sb_scope, *dev;
> @@ -1288,7 +1300,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets=
, GArray *table_data,
>       */
>      aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0012")));
> =20
> -    nvdimm_build_common_dsm(dev);
> +    nvdimm_build_common_dsm(dev, nvdimm_state);
> =20
>      /* 0 is reserved for root device. */
>      nvdimm_build_device_dsm(dev, 0);
> @@ -1307,7 +1319,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets=
, GArray *table_data,
>                                                 NVDIMM_ACPI_MEM_ADDR);
> =20
>      bios_linker_loader_alloc(linker,
> -                             NVDIMM_DSM_MEM_FILE, dsm_dma_area,
> +                             NVDIMM_DSM_MEM_FILE, nvdimm_state->dsm_mem,
>                               sizeof(NvdimmDsmIn), false /* high memory *=
/);
>      bios_linker_loader_add_pointer(linker,
>          ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
> @@ -1329,7 +1341,7 @@ void nvdimm_build_acpi(GArray *table_offsets, GArra=
y *table_data,
>          return;
>      }
> =20
> -    nvdimm_build_ssdt(table_offsets, table_data, linker, state->dsm_mem,
> +    nvdimm_build_ssdt(table_offsets, table_data, linker, state,
>                        ram_slots);
> =20
>      device_list =3D nvdimm_get_device_list();
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 1d077a7cb7..b5170912a8 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -126,6 +126,12 @@ typedef struct FwCfgTPMConfig {
> =20
>  static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
> =20
> +const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio =3D {
> +    .space_id =3D AML_AS_SYSTEM_IO,
> +    .address =3D NVDIMM_ACPI_IO_BASE,
> +    .bit_width =3D NVDIMM_ACPI_IO_LEN << 3
> +};
> +
>  static void init_common_fadt_data(MachineState *ms, Object *o,
>                                    AcpiFadtData *data)
>  {
> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> index 007332e51c..74df5fc612 100644
> --- a/hw/i386/acpi-build.h
> +++ b/hw/i386/acpi-build.h
> @@ -1,6 +1,9 @@
> =20
>  #ifndef HW_I386_ACPI_BUILD_H
>  #define HW_I386_ACPI_BUILD_H
> +#include "hw/acpi/acpi-defs.h"
> +
> +extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
> =20
>  void acpi_setup(void);
> =20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 6824b72124..78521cf017 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -58,6 +58,7 @@
>  #include "migration/misc.h"
>  #include "kvm_i386.h"
>  #include "sysemu/numa.h"
> +#include "hw/i386/acpi-build.h"
> =20
>  #define MAX_IDE_BUS 2
> =20
> @@ -303,6 +304,7 @@ else {
> =20
>      if (machine->nvdimms_state->is_enabled) {
>          nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
> +                               x86_nvdimm_acpi_dsmio,
>                                 pcms->fw_cfg, OBJECT(pcms));
>      }
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 8fad20f314..d53ee8de84 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -53,6 +53,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/numa.h"
> +#include "hw/i386/acpi-build.h"
> =20
>  /* ICH9 AHCI has 6 ports */
>  #define MAX_SATA_PORTS     6
> @@ -330,6 +331,7 @@ static void pc_q35_init(MachineState *machine)
> =20
>      if (machine->nvdimms_state->is_enabled) {
>          nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
> +                               x86_nvdimm_acpi_dsmio,
>                                 pcms->fw_cfg, OBJECT(pcms));
>      }
>  }
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 523a9b3d4a..5fe440861e 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -25,6 +25,7 @@
> =20
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "hw/acpi/aml-build.h"
> =20
>  #define NVDIMM_DEBUG 0
>  #define nvdimm_debug(fmt, ...)                                \
> @@ -140,10 +141,12 @@ struct NVDIMMState {
>       */
>      int32_t persistence;
>      char    *persistence_string;
> +    struct AcpiGenericAddress dsm_io;
>  };
>  typedef struct NVDIMMState NVDIMMState;
> =20
>  void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
> +                            struct AcpiGenericAddress dsm_io,
>                              FWCfgState *fw_cfg, Object *owner);
>  void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
>                         BIOSLinker *linker, NVDIMMState *state,


