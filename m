Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0009CC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B670324684
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B670324684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uNP-0000tJ-TP
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j6uMp-0000Tq-Ll
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j6uMn-0001ys-Mu
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:56:39 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2072 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j6uMn-0001eV-3p
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:56:37 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 350C3EB53F134FD7FFFE;
 Wed, 26 Feb 2020 18:56:30 +0800 (CST)
Received: from dggeme706-chm.china.huawei.com (10.1.199.102) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 18:56:29 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 26 Feb 2020 18:56:29 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Wed, 26 Feb 2020 18:56:28 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for arm
Thread-Topic: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for arm
Thread-Index: AQHV634DptZMLVW0EUqun9Ee8tGbGqgrXfSAgAHxpPA=
Date: Wed, 26 Feb 2020 10:56:28 +0000
Message-ID: <dc909f207fbb456dbe70c5ddf837dab9@huawei.com>
References: <20200225015026.940-1-miaoyubo@huawei.com>
 <20200225015026.940-3-miaoyubo@huawei.com>
 <20200225081151-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200225081151-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.29]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.189
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
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, February 25, 2020 9:15 PM
> To: miaoyubo <miaoyubo@huawei.com>
> Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com; Xiexiangyou
> <xiexiangyou@huawei.com>; imammedo@redhat.com; qemu-
> devel@nongnu.org; berrange@redhat.com
> Subject: Re: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for ar=
m
>=20
> On Tue, Feb 25, 2020 at 09:50:25AM +0800, Yubo Miao wrote:
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
> >  hw/arm/virt-acpi-build.c | 115
> ++++++++++++++++++++++++++++++++++++---
> >  hw/arm/virt.c            |   3 +
> >  include/hw/arm/virt.h    |   7 +++
> >  3 files changed, 118 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c index
> > 37c34748a6..be1986c60d 100644
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
> >  static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus) @@ -266,19
> > +268,116 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, Aml *scope)  }
> >
> >  static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry
> *memmap,
> > -                              uint32_t irq, bool use_highmem, bool hig=
hmem_ecam)
> > +                              uint32_t irq, bool use_highmem, bool hig=
hmem_ecam,
> > +                              VirtMachineState *vms)
> >  {
> >      int ecam_id =3D VIRT_ECAM_ID(highmem_ecam);
> > -    Aml *method, *crs;
> > +    Aml *method, *crs, *dev;
> > +    int count =3D 0;
> >      hwaddr base_mmio =3D memmap[VIRT_PCIE_MMIO].base;
> >      hwaddr size_mmio =3D memmap[VIRT_PCIE_MMIO].size;
> >      hwaddr base_pio =3D memmap[VIRT_PCIE_PIO].base;
> >      hwaddr size_pio =3D memmap[VIRT_PCIE_PIO].size;
> >      hwaddr base_ecam =3D memmap[ecam_id].base;
> >      hwaddr size_ecam =3D memmap[ecam_id].size;
> > +    /*
> > +     * 0x600000 would be enough for pxb device
>=20
> It's not clear where does pxb come in here.
>=20

Thanks for replying, I would add comments when pxb comes.

> > +     * if it is too small, there is no enough space
> > +     * for a pcie device plugged in a pcie-root port
> > +     */
> > +    hwaddr size_addr =3D 0x600000;
> > +    hwaddr size_io =3D 0x4000;
>=20
> Please explain how are memory and io partitioned.
> Looks like you are forcing a very specific layout here, but it's not docu=
mented
> anywhere, which can cause issues like running out of memory where we
> previously were ok.
>=20
>=20

The resources allocated for pxb is  in the end of the resources used to
be allocated for pci host bridge. The memory length for each pxb-pcie is
0x600000 and the io is 16k. The resources allocated for pxbs are quiet smal=
l,
Therefore, the resources for the main host bridge should be large enough.
=A0
For piix4, the memory resource length for each PXB is  0x200000, but
In arm, 200000 is not enough, if one nvme is plugged on pcie-root-port and =
plug
on the pxb, 600000 is enough for the memory, therefore, the memory length a=
re defined
as 0x600000.=20
=A0
Just using 0x600000 and 0x4000 is not so decent,=20
I will try to find if there's a better way to allocate the resources.

> >      int nr_pcie_buses =3D size_ecam / PCIE_MMCFG_SIZE_MIN;
> > +    PCIBus *bus =3D VIRT_MACHINE(vms)->bus;
> > +
> > +    if (bus) {
> > +        QLIST_FOREACH(bus, &bus->child, sibling) {
> > +            uint8_t bus_num =3D pci_bus_num(bus);
> > +            uint8_t numa_node =3D pci_bus_numa_node(bus);
> > +
> > +            if (!pci_bus_is_root(bus)) {
> > +                continue;
> > +            }
> > +            /*
> > +             * Coded up the MIN of the busNr defined for pxb-pcie,
> > +             * the MIN - 1 would be the MAX bus number for the main
> > +             * host bridge.
> > +             */
> > +            if (bus_num < nr_pcie_buses) {
> > +                nr_pcie_buses =3D bus_num;
> > +            }
> > +            count++;
> > +            dev =3D aml_device("PC%.02X", bus_num);
> > +            aml_append(dev, aml_name_decl("_HID",
> aml_string("PNP0A08")));
> > +            aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03"=
)));
> > +            aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> > +            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> > +            aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
> > +            aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
> > +            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> > +            aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb
> > + Device")));
>=20
> how do you know it's a pxb device?
>=20

if (!pci_bus_is_root(bus))=20
continue;
Just go through the children of bus.0, if it is root bus, then it is a pxb =
device.

> > +            if (numa_node !=3D NUMA_NODE_UNASSIGNED) {
> > +                method =3D aml_method("_PXM", 0, AML_NOTSERIALIZED);
> > +                aml_append(method, aml_return(aml_int(numa_node)));
> > +                aml_append(dev, method);
> > +            }
> > +
> > +            acpi_dsdt_add_pci_route_table(dev, scope, irq);
> > +
> > +            method =3D aml_method("_CBA", 0, AML_NOTSERIALIZED);
> > +            aml_append(method, aml_return(aml_int(base_ecam)));
> > +            aml_append(dev, method);
> > +
> > +            method =3D aml_method("_CRS", 0, AML_NOTSERIALIZED);
> > +            Aml *rbuf =3D aml_resource_template();
> > +            aml_append(rbuf,
> > +                       aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXE=
D,
> > +                                           AML_POS_DECODE, 0x0000,
> > +                                           bus_num, bus_num + 1, 0x000=
0,
> > +                                           2));
> > +            aml_append(rbuf,
> > +                       aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> > +                                        AML_MAX_FIXED, AML_NON_CACHEAB=
LE,
> > +                                        AML_READ_WRITE, 0x0000,
> > +                                        base_mmio + size_mmio -
> > +                                        size_addr * count,
> > +                                        base_mmio + size_mmio - 1 -
> > +                                        size_addr * (count - 1),
> > +                                        0x0000, size_addr));
> > +            aml_append(rbuf,
> > +                       aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED,
> > +                       AML_POS_DECODE, AML_ENTIRE_RANGE,
> > +                       0x0000, size_pio - size_io * count,
> > +                       size_pio - 1 - size_io * (count - 1),
> > +                       base_pio, size_io));
> > +
> > +            if (use_highmem) {
> > +                hwaddr base_mmio_high =3D
> memmap[VIRT_HIGH_PCIE_MMIO].base;
> > +                hwaddr size_mmio_high =3D
> > + memmap[VIRT_HIGH_PCIE_MMIO].size;
> > +
> > +                aml_append(rbuf,
> > +                       aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> > +                                        AML_MAX_FIXED, AML_NON_CACHEAB=
LE,
> > +                                        AML_READ_WRITE, 0x0000,
> > +                                        base_mmio_high + size_mmio_hig=
h -
> > +                                        size_addr * count,
> > +                                        base_mmio_high + size_mmio_hig=
h -
> > +                                        1 - size_addr * (count - 1),
> > +                                        0x0000, size_addr));
> > +            }
> > +
> > +            aml_append(method, aml_name_decl("RBUF", rbuf));
> > +            aml_append(method, aml_return(rbuf));
> > +            aml_append(dev, method);
> > +
> > +            acpi_dsdt_add_pci_osc(dev, scope);
> > +
> > +            aml_append(scope, dev);
> > +
> > +        }
> > +    }
> >
> > -    Aml *dev =3D aml_device("%s", "PCI0");
> > +    dev =3D aml_device("%s", "PCI0");
> >      aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
> >      aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
> >      aml_append(dev, aml_name_decl("_SEG", aml_int(0))); @@ -302,11
> > +401,13 @@ static void acpi_dsdt_add_pci(Aml *scope, const
> MemMapEntry *memmap,
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
> > +                     size_pio - 1 - size_io * count, base_pio,
> > +                     size_pio - size_io * count));
> >
> >      if (use_highmem) {
> >          hwaddr base_mmio_high =3D memmap[VIRT_HIGH_PCIE_MMIO].base;
> @@
> > -746,7 +847,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> VirtMachineState *vms)
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
> > a/hw/arm/virt.c b/hw/arm/virt.c index f788fe27d6..6314928671 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1246,6 +1246,9 @@ static void create_pcie(VirtMachineState *vms)
> >      }
> >
> >      pci =3D PCI_HOST_BRIDGE(dev);
> > +
> > +    VIRT_MACHINE(qdev_get_machine())->bus =3D pci->bus;
> > +
> >      if (pci->bus) {
> >          for (i =3D 0; i < nb_nics; i++) {
> >              NICInfo *nd =3D &nd_table[i]; diff --git
> > a/include/hw/arm/virt.h b/include/hw/arm/virt.h index
> > 71508bf40c..90f10a1e46 100644
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
> > +     */
> > +    PCIBus *bus;
> >  } VirtMachineState;
> >
> >  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM :
> > VIRT_PCIE_ECAM)
> > --
> > 2.19.1
> >


