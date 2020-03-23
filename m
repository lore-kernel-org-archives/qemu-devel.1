Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3663C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C042072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P25RwIrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C042072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGOnM-0007Ob-E2
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jGOmg-0006qC-Do
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jGOme-0005PC-II
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:14:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jGOmc-0005Oc-TK
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584976470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVKsPYKfV8Xv8iDOLjQ8gpLL6Prt0vNHjZJ5kMX8EV8=;
 b=P25RwIrW66+ChgX56ljm8wQw3S7JsQ9QyQVeANV08b6nJHycv2Lvh3+E/ParxNLZNrp6tx
 5KYAZ+HJV8yMWtT+FeaHJKqxRmFbNHW/hTCi6F/DQdOu45fwkqg8+jX8bFO/424yjjjAX/
 kStQaoOCQyn9dF/5xfPmPySI8LHzGkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-MaonSmhuPqmLlIF-8Yb3bg-1; Mon, 23 Mar 2020 11:14:26 -0400
X-MC-Unique: MaonSmhuPqmLlIF-8Yb3bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1125F1937FE8;
 Mon, 23 Mar 2020 15:14:25 +0000 (UTC)
Received: from localhost (unknown [10.40.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1BB29B935;
 Mon, 23 Mar 2020 15:14:07 +0000 (UTC)
Date: Mon, 23 Mar 2020 16:14:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 05/10] nvdimm: Use configurable ACPI IO base and size
Message-ID: <20200323161406.07bc0acc@redhat.com>
In-Reply-To: <20200311172014.33052-6-shameerali.kolothum.thodi@huawei.com>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
 <20200311172014.33052-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On Wed, 11 Mar 2020 17:20:09 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Kwangwoo Lee <kwangwoo.lee@sk.com>
> 
> This patch makes IO base and size configurable to create NPIO AML for
> ACPI NFIT. Since a different architecture like AArch64 does not use
> port-mapped IO, a configurable IO base is required to create correct
> mapping of ACPI IO address and size.
> 
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/nvdimm.c        | 32 ++++++++++++++++++++++----------
>  hw/i386/acpi-build.c    |  6 ++++++
>  hw/i386/acpi-build.h    |  3 +++
>  hw/i386/pc_piix.c       |  2 ++
>  hw/i386/pc_q35.c        |  2 ++
>  include/hw/mem/nvdimm.h |  3 +++
>  6 files changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 213556f35d..fb99ad845a 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -900,11 +900,13 @@ void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev)
>  }
>  
>  void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
> +                            struct AcpiGenericAddress dsm_io,
>                              FWCfgState *fw_cfg, Object *owner)
>  {
> +    state->dsm_io = dsm_io;
>      memory_region_init_io(&state->io_mr, owner, &nvdimm_dsm_ops, state,
> -                          "nvdimm-acpi-io", NVDIMM_ACPI_IO_LEN);
> -    memory_region_add_subregion(io, NVDIMM_ACPI_IO_BASE, &state->io_mr);
> +                          "nvdimm-acpi-io", dsm_io.bit_width >> 3);
> +    memory_region_add_subregion(io, dsm_io.address, &state->io_mr);
>  
>      state->dsm_mem = g_array_new(false, true /* clear */, 1);
>      acpi_data_push(state->dsm_mem, sizeof(NvdimmDsmIn));
> @@ -933,13 +935,15 @@ void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
>  
>  #define NVDIMM_QEMU_RSVD_UUID   "648B9CF2-CDA1-4312-8AD9-49C4AF32BD62"
>  
> -static void nvdimm_build_common_dsm(Aml *dev)
> +static void nvdimm_build_common_dsm(Aml *dev,
> +                                    NVDIMMState *nvdimm_state)
>  {
>      Aml *method, *ifctx, *function, *handle, *uuid, *dsm_mem, *elsectx2;
>      Aml *elsectx, *unsupport, *unpatched, *expected_uuid, *uuid_invalid;
>      Aml *pckg, *pckg_index, *pckg_buf, *field, *dsm_out_buf, *dsm_out_buf_size;
>      Aml *whilectx, *offset;
>      uint8_t byte_list[1];
> +    AmlRegionSpace rs;
>  
>      method = aml_method(NVDIMM_COMMON_DSM, 5, AML_SERIALIZED);
>      uuid = aml_arg(0);
> @@ -950,9 +954,16 @@ static void nvdimm_build_common_dsm(Aml *dev)
>  
>      aml_append(method, aml_store(aml_name(NVDIMM_ACPI_MEM_ADDR), dsm_mem));
>  
> +    if (nvdimm_state->dsm_io.space_id == AML_AS_SYSTEM_IO) {
> +        rs = AML_SYSTEM_IO;
> +    } else {
> +        rs = AML_SYSTEM_MEMORY;
> +    }
> +
>      /* map DSM memory and IO into ACPI namespace. */
> -    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, AML_SYSTEM_IO,
> -               aml_int(NVDIMM_ACPI_IO_BASE), NVDIMM_ACPI_IO_LEN));
> +    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, rs,
> +               aml_int(nvdimm_state->dsm_io.address),
> +               nvdimm_state->dsm_io.bit_width >> 3));
>      aml_append(method, aml_operation_region(NVDIMM_DSM_MEMORY,
>                 AML_SYSTEM_MEMORY, dsm_mem, sizeof(NvdimmDsmIn)));
>  
> @@ -967,7 +978,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
>      field = aml_field(NVDIMM_DSM_IOPORT, AML_DWORD_ACC, AML_NOLOCK,
>                        AML_PRESERVE);
>      aml_append(field, aml_named_field(NVDIMM_DSM_NOTIFY,
> -               NVDIMM_ACPI_IO_LEN * BITS_PER_BYTE));
> +               nvdimm_state->dsm_io.bit_width));
>      aml_append(method, field);
>  
>      /*
> @@ -1268,7 +1279,8 @@ static void nvdimm_build_nvdimm_devices(Aml *root_dev, uint32_t ram_slots)
>  }
>  
>  static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
> -                              BIOSLinker *linker, GArray *dsm_dma_area,
> +                              BIOSLinker *linker,
> +                              NVDIMMState *nvdimm_state,
>                                uint32_t ram_slots)
>  {
>      Aml *ssdt, *sb_scope, *dev;
> @@ -1296,7 +1308,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
>       */
>      aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0012")));
>  
> -    nvdimm_build_common_dsm(dev);
> +    nvdimm_build_common_dsm(dev, nvdimm_state);
>  
>      /* 0 is reserved for root device. */
>      nvdimm_build_device_dsm(dev, 0);
> @@ -1315,7 +1327,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
>                                                 NVDIMM_ACPI_MEM_ADDR);
>  
>      bios_linker_loader_alloc(linker,
> -                             NVDIMM_DSM_MEM_FILE, dsm_dma_area,
> +                             NVDIMM_DSM_MEM_FILE, nvdimm_state->dsm_mem,
>                               sizeof(NvdimmDsmIn), false /* high memory */);
>      bios_linker_loader_add_pointer(linker,
>          ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
> @@ -1337,7 +1349,7 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
>          return;
>      }
>  
> -    nvdimm_build_ssdt(table_offsets, table_data, linker, state->dsm_mem,
> +    nvdimm_build_ssdt(table_offsets, table_data, linker, state,
>                        ram_slots);
>  
>      device_list = nvdimm_get_device_list();
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 80f05d728d..ed2b9af8d8 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -128,6 +128,12 @@ typedef struct FwCfgTPMConfig {
>  
>  static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
>  
> +const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio = {
> +    .space_id = AML_AS_SYSTEM_IO,
> +    .address = NVDIMM_ACPI_IO_BASE,
> +    .bit_width = NVDIMM_ACPI_IO_LEN << 3
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
>  
>  #ifndef HW_I386_ACPI_BUILD_H
>  #define HW_I386_ACPI_BUILD_H
> +#include "hw/acpi/acpi-defs.h"
> +
> +extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
>  
>  void acpi_setup(void);
>  
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index e2d98243bc..f0066d2394 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -61,6 +61,7 @@
>  #include "migration/misc.h"
>  #include "sysemu/numa.h"
>  #include "hw/mem/nvdimm.h"
> +#include "hw/i386/acpi-build.h"
>  
>  #define MAX_IDE_BUS 2
>  
> @@ -297,6 +298,7 @@ else {
>  
>      if (machine->nvdimms_state->is_enabled) {
>          nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
> +                               x86_nvdimm_acpi_dsmio,
>                                 x86ms->fw_cfg, OBJECT(pcms));
>      }
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d37c425e22..d2806c1b29 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -54,6 +54,7 @@
>  #include "qemu/error-report.h"
>  #include "sysemu/numa.h"
>  #include "hw/mem/nvdimm.h"
> +#include "hw/i386/acpi-build.h"
>  
>  /* ICH9 AHCI has 6 ports */
>  #define MAX_SATA_PORTS     6
> @@ -315,6 +316,7 @@ static void pc_q35_init(MachineState *machine)
>  
>      if (machine->nvdimms_state->is_enabled) {
>          nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
> +                               x86_nvdimm_acpi_dsmio,
>                                 x86ms->fw_cfg, OBJECT(pcms));
>      }
>  }
> diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
> index 4807ca615b..a3c08955e8 100644
> --- a/include/hw/mem/nvdimm.h
> +++ b/include/hw/mem/nvdimm.h
> @@ -26,6 +26,7 @@
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/acpi/bios-linker-loader.h"
>  #include "qemu/uuid.h"
> +#include "hw/acpi/aml-build.h"
>  
>  #define NVDIMM_DEBUG 0
>  #define nvdimm_debug(fmt, ...)                                \
> @@ -147,10 +148,12 @@ struct NVDIMMState {
>       */
>      int32_t persistence;
>      char    *persistence_string;
> +    struct AcpiGenericAddress dsm_io;
>  };
>  typedef struct NVDIMMState NVDIMMState;
>  
>  void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
> +                            struct AcpiGenericAddress dsm_io,
>                              FWCfgState *fw_cfg, Object *owner);
>  void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
>                         BIOSLinker *linker, NVDIMMState *state,


