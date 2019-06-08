Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C10C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C85208E3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C85208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60014 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZgps-0003IU-PO
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35068)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <gengdongjiu@huawei.com>) id 1hZgo0-0002ZJ-1y
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1hZgnx-00056w-PN
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:15:08 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2050 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1hZgnr-0004z0-9q; Sat, 08 Jun 2019 15:15:00 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 54BE9C3046E8836CD2C0;
 Sun,  9 Jun 2019 03:14:53 +0800 (CST)
Received: from dggeme707-chm.china.huawei.com (10.1.199.103) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 9 Jun 2019 03:14:52 +0800
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 dggeme707-chm.china.huawei.com (10.1.199.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sun, 9 Jun 2019 03:14:52 +0800
Received: from dggeme755-chm.china.huawei.com ([10.7.64.71]) by
 dggeme755-chm.china.huawei.com ([10.7.64.71]) with mapi id 15.01.1591.008;
 Sun, 9 Jun 2019 03:14:52 +0800
From: gengdongjiu <gengdongjiu@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Thread-Topic: [PATCH v17 07/10] ACPI: Add APEI GHES table generation support
Thread-Index: AdUeLm99ImdSUisjqUiifcjWzXsGlQ==
Date: Sat, 8 Jun 2019 19:14:52 +0000
Message-ID: <3a43a5a69c1d4b94b02ce9c55df67108@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.48.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.189
Subject: Re: [Qemu-devel] [PATCH v17 07/10] ACPI: Add APEI GHES table
 generation support
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "zhengxiang
 \(A\)" <zhengxiang9@huawei.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "james.morse@arm.com" <james.morse@arm.com>, "xuwei \(O\)" <xuwei5@huawei.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>=20
> On Tue, 14 May 2019 04:18:20 -0700
> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>=20
> > This implements APEI GHES Table generation via fw_cfg blobs.
> > Now it only support GPIO-Signal and ARMv8 SEA two types of GHESv2
> > error source. Afterwards, we can extend the supported types if needed.
> > For the CPER section type, currently it is memory section because
> > kernel mainly wants userspace to handle the memory errors.
> >
> > This patch follows the spec ACPI 6.2 to build the Hardware Error
> > Source table, for the detailed information, please refer to document:
> > docs/specs/acpi_hest_ghes.txt
> >
> > Suggested-by: Laszlo Ersek <lersek@redhat.com>
> > Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>=20
> Just one general question, why support the GPIO-Signal error source in th=
is patch set?  Unless I'm missing something, it's not actually
> used and would require some additional infrastructure (instantiate the GE=
DD or similar).

In my Initial patches, for the asynchronous error, I want to use the GPIO-S=
ignal to notify guest that there is asynchronous error happen. But later I =
found QEMU will mask the SIGBUS with BUS_MCEERR_AO.
SIGBUS with BUS_MCEERR_AO means the error is asynchronous error. So GPIO-Si=
gnal notification is not used since I do not handle BUS_MCEERR_AO in the si=
gbus handler.

>=20
> Might be better to drop it for now and simplify this set a little bit?

Ok, I can drop the GPIO-Signal support.

>=20
> Note I'm using the gpio path for CCIX PER error emulation so have it hook=
ed up.
> The code here is fine, just not used (I think).

By the way, you also use the SIGBUS with BUS_MCEERR_AO to report CCIX error=
 to QEMU, I am afraid this signal is also masked by QEMU.

>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
>=20
> > ---
> >  default-configs/arm-softmmu.mak |   1 +
> >  hw/acpi/Kconfig                 |   4 +
> >  hw/acpi/Makefile.objs           |   1 +
> >  hw/acpi/acpi_ghes.c             | 171 ++++++++++++++++++++++++++++++++=
++++++++
> >  hw/acpi/aml-build.c             |   2 +
> >  hw/arm/virt-acpi-build.c        |  12 +++
> >  include/hw/acpi/acpi_ghes.h     |  79 +++++++++++++++++++
> >  include/hw/acpi/aml-build.h     |   1 +
> >  8 files changed, 271 insertions(+)
> >  create mode 100644 hw/acpi/acpi_ghes.c  create mode 100644
> > include/hw/acpi/acpi_ghes.h
> >
> > diff --git a/default-configs/arm-softmmu.mak
> > b/default-configs/arm-softmmu.mak index 613d19a..7b33ae9 100644
> > --- a/default-configs/arm-softmmu.mak
> > +++ b/default-configs/arm-softmmu.mak
> > @@ -160,3 +160,4 @@ CONFIG_MUSICPAL=3Dy
> >
> >  # for realview and versatilepb
> >  CONFIG_LSI_SCSI_PCI=3Dy
> > +CONFIG_ACPI_APEI=3Dy
> > diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig index eca3bee..5228a4b
> > 100644
> > --- a/hw/acpi/Kconfig
> > +++ b/hw/acpi/Kconfig
> > @@ -23,6 +23,10 @@ config ACPI_NVDIMM
> >      bool
> >      depends on ACPI
> >
> > +config ACPI_APEI
> > +    bool
> > +    depends on ACPI
> > +
> >  config ACPI_VMGENID
> >      bool
> >      default y
> > diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs index
> > 2d46e37..5099ada 100644
> > --- a/hw/acpi/Makefile.objs
> > +++ b/hw/acpi/Makefile.objs
> > @@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D
> > memory_hotplug.o
> >  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
> >  common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
> >  common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
> > +common-obj-$(CONFIG_ACPI_APEI) +=3D acpi_ghes.o
> >  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
> >
> >  common-obj-y +=3D acpi_interface.o
> > diff --git a/hw/acpi/acpi_ghes.c b/hw/acpi/acpi_ghes.c new file mode
> > 100644 index 0000000..d03e797
> > --- /dev/null
> > +++ b/hw/acpi/acpi_ghes.c
> > @@ -0,0 +1,171 @@
> > +/* Support for generating APEI tables and record CPER for Guests
> > + *
> > + * Copyright (C) 2017 HuaWei Corporation.
> > + *
> > + * Author: Dongjiu Geng <gengdongjiu@huawei.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License as published
> > +by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > +
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > +
> > + * You should have received a copy of the GNU General Public License
> > + along
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/acpi/acpi.h"
> > +#include "hw/acpi/aml-build.h"
> > +#include "hw/acpi/acpi_ghes.h"
> > +#include "hw/nvram/fw_cfg.h"
> > +#include "sysemu/sysemu.h"
> > +#include "qemu/error-report.h"
> > +
> > +/* Build table for the hardware error fw_cfg blob */ void
> > +build_hardware_error_table(GArray *hardware_errors, BIOSLinker
> > +*linker) {
> > +    int i;
> > +
> > +    /*
> > +     * | +--------------------------+
> > +     * | |    error_block_address   |
> > +     * | |      ..........          |
> > +     * | +--------------------------+
> > +     * | |    read_ack_register     |
> > +     * | |     ...........          |
> > +     * | +--------------------------+
> > +     * | |  Error Status Data Block |
> > +     * | |      ........            |
> > +     * | +--------------------------+
> > +     */
> > +
> > +    /* Build error_block_address */
> > +    build_append_int_noprefix((void *)hardware_errors, 0,
> > +                    GHES_ADDRESS_SIZE *
> > + ACPI_HEST_ERROR_SOURCE_COUNT);
> > +
> > +    /* Build read_ack_register */
> > +    for (i =3D 0; i < ACPI_HEST_ERROR_SOURCE_COUNT; i++)
> > +        /* Initialize the value of read_ack_register to 1, so GHES can=
 be
> > +         * writeable in the first time
> > +         */
> > +        build_append_int_noprefix((void *)hardware_errors, 1,
> > + GHES_ADDRESS_SIZE);
> > +
> > +     /* Build Error Status Data Block */
> > +    build_append_int_noprefix((void *)hardware_errors, 0,
> > +                    GHES_MAX_RAW_DATA_LENGTH *
> > + ACPI_HEST_ERROR_SOURCE_COUNT);
> > +
> > +    /* Allocate guest memory for the hardware error fw_cfg blob */
> > +    bios_linker_loader_alloc(linker, GHES_ERRORS_FW_CFG_FILE, hardware=
_errors,
> > +                            1, false); }
> > +
> > +/* Build Hardware Error Source Table */ void build_apei_hest(GArray
> > +*table_data, GArray *hardware_errors,
> > +                                            BIOSLinker *linker) {
> > +    uint32_t i, error_status_block_offset, length =3D table_data->len;
> > +
> > +    /* Reserve Hardware Error Source Table header size */
> > +    acpi_data_push(table_data, sizeof(AcpiTableHeader));
> > +
> > +    /* Set the error source counts */
> > +    build_append_int_noprefix(table_data,
> > + ACPI_HEST_ERROR_SOURCE_COUNT, 4);
> > +
> > +    for (i =3D 0; i < ACPI_HEST_ERROR_SOURCE_COUNT; i++) {
> > +        /* Generic Hardware Error Source version 2(GHESv2 - Type 10)
> > +         */
> > +        build_append_int_noprefix(table_data,
> > +            ACPI_HEST_SOURCE_GENERIC_ERROR_V2, 2); /* type */
> > +        build_append_int_noprefix(table_data, cpu_to_le16(i), 2); /* s=
ource id */
> > +        build_append_int_noprefix(table_data, 0xffff, 2); /* related s=
ource id */
> > +        build_append_int_noprefix(table_data, 0, 1); /* flags */
> > +
> > +        build_append_int_noprefix(table_data, 1, 1); /* enabled */
> > +
> > +        /* Number of Records To Pre-allocate */
> > +        build_append_int_noprefix(table_data, 1, 4);
> > +        /* Max Sections Per Record */
> > +        build_append_int_noprefix(table_data, 1, 4);
> > +        /* Max Raw Data Length */
> > +        build_append_int_noprefix(table_data,
> > + GHES_MAX_RAW_DATA_LENGTH, 4);
> > +
> > +        /* Build error status address*/
> > +        build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0, 4 /* =
QWord access */, 0);
> > +        bios_linker_loader_add_pointer(linker,
> > +            ACPI_BUILD_TABLE_FILE, ERROR_STATUS_ADDRESS_OFFSET(length,=
 i),
> > +            GHES_ADDRESS_SIZE, GHES_ERRORS_FW_CFG_FILE, i *
> > + GHES_ADDRESS_SIZE);
> > +
> > +        /* Build Hardware Error Notification
> > +         * Now only enable GPIO-Signal and ARMv8 SEA notification type=
s
> > +         */
> > +        if (i =3D=3D 0) {
> > +            build_append_ghes_notify(table_data, ACPI_HEST_NOTIFY_GPIO=
, 28,
> > +                                     0, 0, 0, 0, 0, 0, 0);
> > +        } else if (i =3D=3D 1) {
> > +            build_append_ghes_notify(table_data, ACPI_HEST_NOTIFY_SEA,=
 28, 0,
> > +                                     0, 0, 0, 0, 0, 0);
> > +        }
> > +
> > +        /* Error Status Block Length */
> > +        build_append_int_noprefix(table_data,
> > +            cpu_to_le32(GHES_MAX_RAW_DATA_LENGTH), 4);
> > +
> > +        /* Build Read ACK register
> > +         * ACPI 6.1/6.2: 18.3.2.8 Generic Hardware Error Source
> > +         * version 2 (GHESv2 - Type 10)
> > +         */
> > +        build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0, 4 /* =
QWord access */, 0);
> > +        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> > +            READ_ACK_REGISTER_ADDRESS_OFFSET(length, i), GHES_ADDRESS_=
SIZE,
> > +            GHES_ERRORS_FW_CFG_FILE,
> > +            (ACPI_HEST_ERROR_SOURCE_COUNT + i) * GHES_ADDRESS_SIZE);
> > +
> > +        /* Build Read Ack Preserve and Read Ack Writer */
> > +        build_append_int_noprefix(table_data, cpu_to_le64(ReadAckPrese=
rve), 8);
> > +        build_append_int_noprefix(table_data, cpu_to_le64(ReadAckWrite=
), 8);
> > +    }
> > +
> > +    /* Generic Error Status Block offset in the hardware error fw_cfg =
blob */
> > +    error_status_block_offset =3D GHES_ADDRESS_SIZE * 2 *
> > +                                ACPI_HEST_ERROR_SOURCE_COUNT;
> > +
> > +    for (i =3D 0; i < ACPI_HEST_ERROR_SOURCE_COUNT; i++)
> > +        /* Patch address of Error Status Data Block into
> > +         * the error_block_address of hardware_errors fw_cfg blob
> > +         */
> > +        bios_linker_loader_add_pointer(linker,
> > +            GHES_ERRORS_FW_CFG_FILE, GHES_ADDRESS_SIZE * i, GHES_ADDRE=
SS_SIZE,
> > +            GHES_ERRORS_FW_CFG_FILE,
> > +            error_status_block_offset + i *
> > + GHES_MAX_RAW_DATA_LENGTH);
> > +
> > +    /* write address of hardware_errors fw_cfg blob into the
> > +     * hardware_errors_addr fw_cfg blob.
> > +     */
> > +    bios_linker_loader_write_pointer(linker, GHES_DATA_ADDR_FW_CFG_FIL=
E,
> > +        0, GHES_ADDRESS_SIZE, GHES_ERRORS_FW_CFG_FILE, 0);
> > +
> > +    build_header(linker, table_data,
> > +        (void *)(table_data->data + length), "HEST",
> > +        table_data->len - length, 1, NULL, "GHES"); }
> > +
> > +static GhesState ges;
> > +void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_error) {
> > +
> > +    size_t size =3D 2 * GHES_ADDRESS_SIZE + GHES_MAX_RAW_DATA_LENGTH;
> > +    size_t request_block_size =3D ACPI_HEST_ERROR_SOURCE_COUNT * size;
> > +
> > +    /* Create a read-only fw_cfg file for GHES */
> > +    fw_cfg_add_file(s, GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
> > +                    request_block_size);
> > +
> > +    /* Create a read-write fw_cfg file for Address */
> > +    fw_cfg_add_file_callback(s, GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL=
, NULL,
> > +        &ges.ghes_addr_le, sizeof(ges.ghes_addr_le), false); }
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c index
> > ce90970..3f2b84f 100644
> > --- a/hw/acpi/aml-build.c
> > +++ b/hw/acpi/aml-build.c
> > @@ -1645,6 +1645,7 @@ void acpi_build_tables_init(AcpiBuildTables *tabl=
es)
> >      tables->table_data =3D g_array_new(false, true /* clear */, 1);
> >      tables->tcpalog =3D g_array_new(false, true /* clear */, 1);
> >      tables->vmgenid =3D g_array_new(false, true /* clear */, 1);
> > +    tables->hardware_errors =3D g_array_new(false, true /* clear */,
> > + 1);
> >      tables->linker =3D bios_linker_loader_init();  }
> >
> > @@ -1655,6 +1656,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *t=
ables, bool mfre)
> >      g_array_free(tables->table_data, true);
> >      g_array_free(tables->tcpalog, mfre);
> >      g_array_free(tables->vmgenid, mfre);
> > +    g_array_free(tables->hardware_errors, mfre);
> >  }
> >
> >  /*
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c index
> > bf9c0bc..54f4ba5 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -45,6 +45,7 @@
> >  #include "hw/arm/virt.h"
> >  #include "sysemu/numa.h"
> >  #include "kvm_arm.h"
> > +#include "hw/acpi/acpi_ghes.h"
> >
> >  #define ARM_SPI_BASE 32
> >  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
> > @@ -808,6 +809,12 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBu=
ildTables *tables)
> >      acpi_add_table(table_offsets, tables_blob);
> >      build_spcr(tables_blob, tables->linker, vms);
> >
> > +    if (!vmc->no_ras) {
> > +        acpi_add_table(table_offsets, tables_blob);
> > +        build_hardware_error_table(tables->hardware_errors, tables->li=
nker);
> > +        build_apei_hest(tables_blob, tables->hardware_errors, tables->=
linker);
> > +    }
> > +
> >      if (nb_numa_nodes > 0) {
> >          acpi_add_table(table_offsets, tables_blob);
> >          build_srat(tables_blob, tables->linker, vms); @@ -901,6
> > +908,7 @@ static const VMStateDescription vmstate_virt_acpi_build =3D {
> >
> >  void virt_acpi_setup(VirtMachineState *vms)  {
> > +    VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
> >      AcpiBuildTables tables;
> >      AcpiBuildState *build_state;
> >
> > @@ -932,6 +940,10 @@ void virt_acpi_setup(VirtMachineState *vms)
> >      fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalo=
g->data,
> >                      acpi_data_len(tables.tcpalog));
> >
> > +    if (!vmc->no_ras) {
> > +        ghes_add_fw_cfg(vms->fw_cfg, tables.hardware_errors);
> > +    }
> > +
> >      build_state->rsdp_mr =3D acpi_add_rom_blob(build_state, tables.rsd=
p,
> >                                                ACPI_BUILD_RSDP_FILE,
> > 0);
> >
> > diff --git a/include/hw/acpi/acpi_ghes.h b/include/hw/acpi/acpi_ghes.h
> > new file mode 100644 index 0000000..38fd87c
> > --- /dev/null
> > +++ b/include/hw/acpi/acpi_ghes.h
> > @@ -0,0 +1,79 @@
> > +/* Support for generating APEI tables and record CPER for Guests
> > + *
> > + * Copyright (C) 2017 HuaWei Corporation.
> > + *
> > + * Author: Dongjiu Geng <gengdongjiu@huawei.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License as published
> > +by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > +
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > +
> > + * You should have received a copy of the GNU General Public License
> > + along
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef ACPI_GHES_H
> > +#define ACPI_GHES_H
> > +
> > +#include "hw/acpi/bios-linker-loader.h"
> > +
> > +#define GHES_ERRORS_FW_CFG_FILE         "etc/hardware_errors"
> > +#define GHES_DATA_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> > +
> > +/* The size of Address field in Generic Address Structure,
> > + * ACPI 2.0/3.0: 5.2.3.1 Generic Address Structure.
> > + */
> > +#define GHES_ADDRESS_SIZE           8
> > +
> > +#define GHES_DATA_LENGTH            72
> > +#define GHES_CPER_LENGTH            80
> > +
> > +#define ReadAckPreserve             0xfffffffe
> > +#define ReadAckWrite                0x1
> > +
> > +/* The max size in bytes for one error block */
> > +#define GHES_MAX_RAW_DATA_LENGTH        0x1000
> > +/* Now only have GPIO-Signal and ARMv8 SEA notification types error
> > +sources  */
> > +#define ACPI_HEST_ERROR_SOURCE_COUNT    2
>=20
> The GPIO case is really handy when I'm abusing this code for error inject=
ion but I don't think you actually use it in this patch set.  Perhaps it
> makes sense to drop that block for now?
>=20
> > +
> > +/*
> > + * | +--------------------------+ 0
> > + * | |        Header            |
> > + * | +--------------------------+ 40---+-
> > + * | | .................        |      |
> > + * | | error_status_address-----+ 60   |
> > + * | | .................        |      |
> > + * | | read_ack_register--------+ 104  92
> > + * | | read_ack_preserve        |      |
> > + * | | read_ack_write           |      |
> > + * + +--------------------------+ 132--+-
> > + *
> > + * From above GHES definition, the error status address offset is 60;
> > + * the Read ack register offset is 104, the whole size of GHESv2 is
> > +92  */
> > +
> > +/* The error status address offset in GHES */
> > +#define ERROR_STATUS_ADDRESS_OFFSET(start_addr, n)     (start_addr + 6=
0 + \
> > +                    offsetof(struct AcpiGenericAddress, address) + n
> > +* 92)
> > +
> > +/* The read Ack register offset in GHES */ #define
> > +READ_ACK_REGISTER_ADDRESS_OFFSET(start_addr, n) (start_addr + 104 + \
> > +                    offsetof(struct AcpiGenericAddress, address) + n
> > +* 92)
> > +
> > +typedef struct GhesState {
> > +    uint64_t ghes_addr_le;
> > +} GhesState;
> > +
> > +void build_apei_hest(GArray *table_data, GArray *hardware_error,
> > +                     BIOSLinker *linker);
> > +
> > +void build_hardware_error_table(GArray *hardware_errors, BIOSLinker
> > +*linker); void ghes_add_fw_cfg(FWCfgState *s, GArray
> > +*hardware_errors); #endif
> > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > index 1ec7e1b..78c0252 100644
> > --- a/include/hw/acpi/aml-build.h
> > +++ b/include/hw/acpi/aml-build.h
> > @@ -220,6 +220,7 @@ struct AcpiBuildTables {
> >      GArray *rsdp;
> >      GArray *tcpalog;
> >      GArray *vmgenid;
> > +    GArray *hardware_errors;
> >      BIOSLinker *linker;
> >  } AcpiBuildTables;
> >
>=20


