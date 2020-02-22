Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3651AC35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05B142071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B142071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5REy-00023c-55
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 04:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j5REN-0001eO-MT
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 04:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j5REM-0007Yt-2j
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 04:37:51 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:39706 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j5REL-0007YS-Gh
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 04:37:50 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id A20008C39442DEBD9356;
 Sat, 22 Feb 2020 17:37:39 +0800 (CST)
Received: from dggeme755-chm.china.huawei.com (10.3.19.101) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 22 Feb 2020 17:37:38 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sat, 22 Feb 2020 17:37:39 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Sat, 22 Feb 2020 17:37:38 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [RFC v3 2/3] acpi:pci-expender-bus: Add pxb support for arm
Thread-Topic: [RFC v3 2/3] acpi:pci-expender-bus: Add pxb support for arm
Thread-Index: AQHV6IEdkKwvX8nXB0+qNEO77j5bOagk+fkAgAH7a6A=
Date: Sat, 22 Feb 2020 09:37:38 +0000
Message-ID: <744bd79fef954750b387e1d99ee43d3e@huawei.com>
References: <20200221063512.1104-1-miaoyubo@huawei.com>
 <20200221063512.1104-3-miaoyubo@huawei.com>
 <20200221061402-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200221061402-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.131.16]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.255
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
> Sent: Friday, February 21, 2020 7:18 PM
> To: miaoyubo <miaoyubo@huawei.com>
> Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com; Xiexiangyou
> <xiexiangyou@huawei.com>; imammedo@redhat.com;
> qemu-devel@nongnu.org
> Subject: Re: [RFC v3 2/3] acpi:pci-expender-bus: Add pxb support for arm
>=20
> On Fri, Feb 21, 2020 at 02:35:11PM +0800, Yubo Miao wrote:
> > From: miaoyubo <miaoyubo@huawei.com>
> >
> > Currently virt machine is not supported by pxb-pcie, and only one main
> > host bridge described in ACPI tables.
> > In this patch,PXB-PCIE is supproted by arm and certain resource is
> > allocated for each pxb-pcie in acpi table.
> > The resource for the main host bridge is also reallocated.
> >
> > Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> > ---
> >  hw/arm/virt-acpi-build.c | 125
> +++++++++++++++++++++++++++++++++++----
> >  hw/pci-host/gpex.c       |   4 ++
> >  include/hw/arm/virt.h    |   7 +++
> >  3 files changed, 125 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c index
> > 0540234b8a..2c1e0d2aaa 100644
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
> >  static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus) @@ -271,19
> > +273,117 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, Aml *scope)  }
> >
> >  static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry
> *memmap,
> > -                              uint32_t irq, bool use_highmem, bool
> highmem_ecam)
> > +                              uint32_t irq, bool use_highmem, bool
> highmem_ecam,
> > +                              VirtMachineState *vms)
> >  {
> >      int ecam_id =3D VIRT_ECAM_ID(highmem_ecam);
> > -    Aml *method, *crs;
> > +    Aml *method, *dev, *crs;
> > +    int count =3D 0;
> >      hwaddr base_mmio =3D memmap[VIRT_PCIE_MMIO].base;
> >      hwaddr size_mmio =3D memmap[VIRT_PCIE_MMIO].size;
> >      hwaddr base_pio =3D memmap[VIRT_PCIE_PIO].base;
> >      hwaddr size_pio =3D memmap[VIRT_PCIE_PIO].size;
> >      hwaddr base_ecam =3D memmap[ecam_id].base;
> >      hwaddr size_ecam =3D memmap[ecam_id].size;
> > +    /*
> > +     * 0x600000 would be enough for pxb device
> > +     * if it is too small, there is no enough space
> > +     * for a pcie device plugged in a pcie-root port
> > +     */
> > +    hwaddr size_addr =3D 0x600000;
> > +    hwaddr size_io =3D 0x4000;
> >      int nr_pcie_buses =3D size_ecam / PCIE_MMCFG_SIZE_MIN;
> > +    int root_bus_limit =3D 0xFF;
>=20
> what's this?
>=20

Thanks for replying.
This is used to define the bus numbers for the main host bridge,=20
If no pxb-pcie is defined, the bus number for the main host bridge
would range form 0 to 255.

> > +    PCIBus *bus =3D NULL;
> > +    bus =3D VIRT_MACHINE(vms)->bus;
>=20
> So just move assignment as part of declaration.
>=20

Thanks for the suggestion!

> > +
> > +    if (bus) {
> > +        QLIST_FOREACH(bus, &bus->child, sibling) {
> > +            uint8_t bus_num =3D pci_bus_num(bus);
> > +            uint8_t numa_node =3D pci_bus_numa_node(bus);
> > +
> > +            if (!pci_bus_is_root(bus)) {
> > +                continue;
> > +            }
> > +            if (bus_num < root_bus_limit) {
> > +                root_bus_limit =3D bus_num - 1;
>=20
> what is this doing? manually coded up MIN?
>=20

This coded up the MIN of busNr defined in pxb-pcie devices,=20
and the Min busNr-1 would be the MAX bus Number for the main host bridge.
For example, if one pxb-pcie with busNr 128(which is 80) defined,=20
The bus for the main host bridge would be 0-7F, and the bus for pxb-pcie
would be 80-81(just allocate two buses,keep the same with X86).
If pxb-pcie is not defined, the bus for main host bridge would be 0-FF.

> > +            }
> > +            count++;
> > +            dev =3D aml_device("PC%.02X", bus_num);
> > +            aml_append(dev, aml_name_decl("_HID",
> aml_string("PNP0A08")));
> > +            aml_append(dev, aml_name_decl("_CID",
> aml_string("PNP0A03")));
> > +            aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > +            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> > +            aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> > +            aml_append(dev, aml_name_decl("_BBN",
> aml_int(bus_num)));
> > +            aml_append(dev, aml_name_decl("_UID",
> aml_int(bus_num)));
> > +            aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb
> Device")));
> > +            if (numa_node !=3D NUMA_NODE_UNASSIGNED) {
> > +                method =3D aml_method("_PXM", 0,
> AML_NOTSERIALIZED);
> > +                aml_append(method,
> aml_return(aml_int(numa_node)));
> > +                aml_append(dev, method);
> > +            }
> > +
> >   * GPEX host
> > @@ -98,6 +99,9 @@ static void gpex_host_realize(DeviceState *dev, Error
> **errp)
> >                                       pci_swizzle_map_irq_fn, s,
> &s->io_mmio,
> >                                       &s->io_ioport, 0, 4,
> > TYPE_PCIE_BUS);
> >
> > +#ifdef __aarch64__
> > +    VIRT_MACHINE(qdev_get_machine())->bus =3D pci->bus; #endif
>=20
> I'm repeating myself but - what does this have to do with building on
> __aarch64__?
>=20

I would move this into machvirt_init, therefore, the __aarch64__ is not nee=
ded.

> >      qdev_set_parent_bus(DEVICE(&s->gpex_root), BUS(pci->bus));
> >      pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
> >      qdev_init_nofail(DEVICE(&s->gpex_root));
> > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h index
> > 71508bf40c..9accaf2b1b 100644
> > --- a/include/hw/arm/virt.h
> > +++ b/include/hw/arm/virt.h
> > @@ -140,6 +140,13 @@ typedef struct {
> >      DeviceState *gic;
> >      DeviceState *acpi_dev;
> >      Notifier powerdown_notifier;
> > +    /*
> > +     * pointer to devices and objects
> > +     * Via going through the bus, all
> > +     * pci devices and related objectes
> > +     * could be gained.
> > +     * */
> > +    PCIBus *bus;
>=20
> That comment doesn't really tell me what this is.
> Is this the root bus?
> With an extender, don't we have lots of roots?
>=20
>=20

Yes, this is the root bus.(The pci.0 or pcie.0)=20
The main root is pci.0 or pcie.0, the extender plays the role of root for d=
evices=20
plugged on it. For the extender, there is only one root,pci.0 or pcie.0.
But for devices like pcie-root-port, they could also regard pxb-pcie as roo=
t.
Hope this solve your question.

> >  } VirtMachineState;
> >
> >  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM :
> > VIRT_PCIE_ECAM)
> > --
> > 2.19.1
> >

Regards,
Miao

