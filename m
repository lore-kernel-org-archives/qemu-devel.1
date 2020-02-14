Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7754C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D7B2465D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D7B2465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2VP5-0000Fv-N5
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 02:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j2VOR-0008GO-01
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j2VOP-0005pG-Ek
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:28:06 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2437 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j2VOO-0005lJ-Pv
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:28:05 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id C651777D93D76B364902;
 Fri, 14 Feb 2020 15:28:01 +0800 (CST)
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 15:28:01 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 14 Feb 2020 15:28:01 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Fri, 14 Feb 2020 15:28:01 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [RFC 1/2] arm: acpi: pci-expender-bus: Make arm to support
 PXB-PCIE
Thread-Topic: [RFC 1/2] arm: acpi: pci-expender-bus: Make arm to support
 PXB-PCIE
Thread-Index: AQHV4kI1MrlFPsHFbUiw/EhImvL2MagYZJQAgAHm3vA=
Date: Fri, 14 Feb 2020 07:28:00 +0000
Message-ID: <c4c765b5a2c641218302280882e2982f@huawei.com>
References: <20200213074952.544-1-miaoyubo@huawei.com>
 <20200213074952.544-2-miaoyubo@huawei.com>
 <20200213052011-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200213052011-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.29]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.187
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
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Thursday, February 13, 2020 6:23 PM
> To: miaoyubo <miaoyubo@huawei.com>
> Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com; Xiexiangyou
> <xiexiangyou@huawei.com>; imammedo@redhat.com; qemu-
> devel@nongnu.org
> Subject: Re: [RFC 1/2] arm: acpi: pci-expender-bus: Make arm to support
> PXB-PCIE
>=20
> On Thu, Feb 13, 2020 at 03:49:51PM +0800, Yubo Miao wrote:
> > From: miaoyubo <miaoyubo@huawei.com>
> >
> > Currently virt machine is not supported by pxb-pcie, and only one main
> > host bridge described in ACPI tables.
> > Under this circumstance, different io numas for differnt devices is
> > not possible, in order to present io numas to the guest, especially
> > for host pssthrough devices. PXB-PCIE is supproted by arm and certain
> > resource is allocated for each pxb-pcie in acpi table.
> >
> > Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> > ---
> >  hw/arm/virt-acpi-build.c | 234
> +++++++++++++++++++++++++++++++++++++--
> >  hw/pci-host/gpex.c       |   4 +
> >  include/hw/arm/virt.h    |   1 +
> >  3 files changed, 228 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c index
> > bd5f771e9b..2e449d0098 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -49,6 +49,8 @@
> >  #include "kvm_arm.h"
> >  #include "migration/vmstate.h"
> >
> > +#include "hw/arm/virt.h"
> > +#include "hw/pci/pci_bus.h"
> >  #define ARM_SPI_BASE 32
> >
> > +            /*
> > +             * PCI Firmware Specification 3.0
> > +             * 4.6.1. _DSM for PCI Express Slot Information
> > +             * The UUID in _DSM in this context is
> > +             * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
> > +             */
> > +            UUID =3D aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D"=
);
> > +            ifctx =3D aml_if(aml_equal(aml_arg(0), UUID));
> > +            ifctx1 =3D aml_if(aml_equal(aml_arg(2), aml_int(0)));
> > +            uint8_t byte_list[1] =3D {1};
> > +            buf =3D aml_buffer(1, byte_list);
> > +            aml_append(ifctx1, aml_return(buf));
> > +            aml_append(ifctx, ifctx1);
> > +            aml_append(method, ifctx);
> > +
> > +            byte_list[0] =3D 0;
> > +            buf =3D aml_buffer(1, byte_list);
> > +            aml_append(method, aml_return(buf));
> > +            aml_append(dev, method);
> > +
> > +            Aml *dev_rp0 =3D aml_device("%s", "RP0");
> > +            aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
> > +            aml_append(dev, dev_rp0);
> > +
> > +            aml_append(scope, dev);
> > +
> > +        }
> > +    }
>=20
>=20
> There's a bunch of code duplicated here. Please refactor creating APIs fo=
r
> reused code.
>=20

Thanks for your reply, this would be done by patch V2.

> >
> > -    Aml *dev =3D aml_device("%s", "PCI0");
> > +    dev =3D aml_device("%s", "PCI0");
> >      aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
> >      aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
> >      aml_append(dev, aml_name_decl("_SEG", aml_int(0))); @@ -219,16
> > +428,18 @@ static void acpi_dsdt_add_pci(Aml *scope, const
> MemMapEntry *memmap,
> >      Aml *rbuf =3D aml_resource_template();
> >      aml_append(rbuf,
> >          aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED,
> AML_POS_DECODE,
> > -                            0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
> > -                            nr_pcie_buses));
> > +                            0x0000, 0x0000, root_bus_limit, 0x0000,
> > +                            root_bus_limit + 1));
> >      aml_append(rbuf,
> >          aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> AML_MAX_FIXED,
> >                           AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
> base_mmio,
> > -                         base_mmio + size_mmio - 1, 0x0000, size_mmio)=
);
> > +                         base_mmio + size_mmio - 1 - size_addr * count=
,
> > +                         0x0000, size_mmio - size_addr * count));
> >      aml_append(rbuf,
> >          aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED,
> AML_POS_DECODE,
> > -                     AML_ENTIRE_RANGE, 0x0000, 0x0000, size_pio - 1, b=
ase_pio,
> > -                     size_pio));
> > +                     AML_ENTIRE_RANGE, 0x0000, 0x0000,
> > +                     size_pio / 2 - 1 - size_io * count, base_pio,
> > +                     size_pio / 2 - size_io * count));
> >
> >      if (use_highmem) {
> >          hwaddr base_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].base;
> @@
> > -238,8 +449,9 @@ static void acpi_dsdt_add_pci(Aml *scope, const
> MemMapEntry *memmap,
> >              aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> AML_MAX_FIXED,
> >                               AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000=
,
> >                               base_mmio_high,
> > -                             base_mmio_high + size_mmio_high - 1, 0x00=
00,
> > -                             size_mmio_high));
> > +                             base_mmio_high + size_mmio_high - 1 -
> > +                             size_addr * count,
> > +                             0x0000, size_mmio_high - size_addr *
> > + count));
> >      }
> >
> >      aml_append(method, aml_name_decl("RBUF", rbuf)); @@ -744,7
> +956,7
> > @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState
> *vms)
> >      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> >                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
> NUM_VIRTIO_TRANSPORTS);
> >      acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] +
> ARM_SPI_BASE),
> > -                      vms->highmem, vms->highmem_ecam);
> > +                      vms->highmem, vms->highmem_ecam, vms);
> >      if (vms->acpi_dev) {
> >          build_ged_aml(scope, "\\_SB."GED_DEVICE,
> >                        HOTPLUG_HANDLER(vms->acpi_dev), diff --git
> > a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c index 0ca604dc62..2c18cdfec4
> > 100644
> > --- a/hw/pci-host/gpex.c
> > +++ b/hw/pci-host/gpex.c
> > @@ -36,6 +36,7 @@
> >  #include "hw/qdev-properties.h"
> >  #include "migration/vmstate.h"
> >  #include "qemu/module.h"
> > +#include "hw/arm/virt.h"
> >
> >
> /**********************************************************
> ******************
> >   * GPEX host
> > @@ -98,6 +99,9 @@ static void gpex_host_realize(DeviceState *dev, Error
> **errp)
> >                                       pci_swizzle_map_irq_fn, s, &s->io=
_mmio,
> >                                       &s->io_ioport, 0, 4,
> > TYPE_PCIE_BUS);
> >
> > +#ifdef __aarch64__
> > +    VIRT_MACHINE(qdev_get_machine())->bus =3D pci->bus; #endif
> >      qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
> >      pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
> >      qdev_init_nofail(DEVICE(&s->gpex_root));
> > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h index
> > 71508bf40c..cfc65dd19b 100644
> > --- a/include/hw/arm/virt.h
> > +++ b/include/hw/arm/virt.h
> > @@ -140,6 +140,7 @@ typedef struct {
> >      DeviceState *gic;
> >      DeviceState *acpi_dev;
> >      Notifier powerdown_notifier;
> > +    PCIBus *bus;
> >  } VirtMachineState;
>=20
>=20
> Given you only support one bus, why not just look the device up based on
> type?
>=20

"Given you only support one bus"
What does this mean? the patch enables to define multiply pxb-pcie devices,=
=20
and each pxb-pcie is allocated with two bus numbers in acpi tables.
"why not just look the device up based on type?"
We need the structure bus to get the numa_id defined by the user.

> >
> >  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM :
> > VIRT_PCIE_ECAM)
> > --
> > 2.19.1
> >

Regards,
Miao


