Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D32C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A14E20726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A14E20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZcY-00052P-5p
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j6ZZY-00082y-Jz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j6ZZX-0006Do-2X
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:44:24 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2069 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j6ZZW-0006C7-M0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:44:23 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 14D79B96B6C6711EEAE4;
 Tue, 25 Feb 2020 20:44:16 +0800 (CST)
Received: from dggeme708-chm.china.huawei.com (10.1.199.104) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 20:44:15 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme708-chm.china.huawei.com (10.1.199.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 25 Feb 2020 20:44:15 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Tue, 25 Feb 2020 20:44:15 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for arm
Thread-Topic: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for arm
Thread-Index: AQHV634DptZMLVW0EUqun9Ee8tGbGqgrJCyAgACsLcD//4BQgIAAiRsw
Date: Tue, 25 Feb 2020 12:44:15 +0000
Message-ID: <766375327e6f422bbf751174269f7570@huawei.com>
References: <20200225015026.940-1-miaoyubo@huawei.com>
 <20200225015026.940-3-miaoyubo@huawei.com>
 <3086f4a2-fb0a-d276-7c76-f06474befa35@redhat.com>
 <c4aa08df40a74dbd876b9acfbbb09809@huawei.com>
 <20200225072522-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200225072522-mutt-send-email-mst@kernel.org>
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
 "imammedo@redhat.com" <imammedo@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, February 25, 2020 8:27 PM
> To: miaoyubo <miaoyubo@huawei.com>
> Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>;
> peter.maydell@linaro.org; shannon.zhaosl@gmail.com;
> berrange@redhat.com; qemu-devel@nongnu.org; Xiexiangyou
> <xiexiangyou@huawei.com>; imammedo@redhat.com
> Subject: Re: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support for ar=
m
>=20
> On Tue, Feb 25, 2020 at 12:12:12PM +0000, miaoyubo wrote:
> >
> > > -----Original Message-----
> > > From: Philippe Mathieu-Daud=E9 [mailto:philmd@redhat.com]
> > > Sent: Tuesday, February 25, 2020 5:48 PM
> > > To: miaoyubo <miaoyubo@huawei.com>; peter.maydell@linaro.org;
> > > shannon.zhaosl@gmail.com
> > > Cc: berrange@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> > > Xiexiangyou <xiexiangyou@huawei.com>; imammedo@redhat.com
> > > Subject: Re: [PATCH v4 2/3] acpi:pci-expender-bus: Add pxb support
> > > for arm
> > >
> > > On 2/25/20 2:50 AM, Yubo Miao wrote:
> > > > From: miaoyubo <miaoyubo@huawei.com>
> > > >
> > > > Currently virt machine is not supported by pxb-pcie, and only one
> > > > main host bridge described in ACPI tables.
> > > > In this patch,PXB-PCIE is supproted by arm and certain
> > >
> > > Typos: "expander" in subject and "supported" here.
> > >
> >
> > Thanks for your reply and sorry for the mistakes.
> > I will check all the subjects and comments.
> >
> > > > resource is allocated for each pxb-pcie in acpi table.
> > > > The resource for the main host bridge is also reallocated.
> > > >
> > > > Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> > > > ---
> > > >   hw/arm/virt-acpi-build.c | 115
> > > ++++++++++++++++++++++++++++++++++++---
> > > >   hw/arm/virt.c            |   3 +
> > > >   include/hw/arm/virt.h    |   7 +++
> > > >   3 files changed, 118 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > > index 37c34748a6..be1986c60d 100644
> > > > --- a/hw/arm/virt-acpi-build.c
> > > > +++ b/hw/arm/virt-acpi-build.c
> > > > @@ -49,6 +49,8 @@
> > > >   #include "kvm_arm.h"
> > > >   #include "migration/vmstate.h"
> > > >
> > > > +#include "hw/arm/virt.h"
> > > > +#include "hw/pci/pci_bus.h"
> > > >   #define ARM_SPI_BASE 32
> > > >
> > > >       if (use_highmem) {
> > > >           hwaddr base_mmio_high =3D
> > > > memmap[VIRT_HIGH_PCIE_MMIO].base;
> > > @@
> > > > -746,7 +847,7 @@ build_dsdt(GArray *table_data, BIOSLinker
> > > > *linker,
> > > VirtMachineState *vms)
> > > >       acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> > > >                       (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
> > > NUM_VIRTIO_TRANSPORTS);
> > > >       acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] +
> > > ARM_SPI_BASE),
> > > > -                      vms->highmem, vms->highmem_ecam);
> > > > +                      vms->highmem, vms->highmem_ecam, vms);
> > > >       if (vms->acpi_dev) {
> > > >           build_ged_aml(scope, "\\_SB."GED_DEVICE,
> > > >                         HOTPLUG_HANDLER(vms->acpi_dev), diff --git
> > > > a/hw/arm/virt.c b/hw/arm/virt.c index f788fe27d6..6314928671
> > > > 100644
> > > > --- a/hw/arm/virt.c
> > > > +++ b/hw/arm/virt.c
> > > > @@ -1246,6 +1246,9 @@ static void create_pcie(VirtMachineState
> *vms)
> > > >       }
> > > >
> > > >       pci =3D PCI_HOST_BRIDGE(dev);
> > > > +
> > > > +    VIRT_MACHINE(qdev_get_machine())->bus =3D pci->bus;
> > > > +
> > > >       if (pci->bus) {
> > > >           for (i =3D 0; i < nb_nics; i++) {
> > > >               NICInfo *nd =3D &nd_table[i]; diff --git
> > > > a/include/hw/arm/virt.h b/include/hw/arm/virt.h index
> > > > 71508bf40c..90f10a1e46 100644
> > > > --- a/include/hw/arm/virt.h
> > > > +++ b/include/hw/arm/virt.h
> > > > @@ -140,6 +140,13 @@ typedef struct {
> > > >       DeviceState *gic;
> > > >       DeviceState *acpi_dev;
> > > >       Notifier powerdown_notifier;
> > > > +    /*
> > > > +     * pointer to devices and objects
> > > > +     * Via going through the bus, all
> > > > +     * pci devices and related objectes
> > >
> > > Typo "objects", but I don't understand the comment well.
> > >
> >
> > Sorry for any confusion caused ,I will rewrite the comment
> > /* point to the root bus, which is pcie.0 */ Does this comment make
> > sense?
>=20
> Not really. E.g. it doesn't say what happens if there's more than one roo=
t.
>=20

If there's more than one root, like pcie.0 and pcie.1, it still point to pc=
ie.0.
In docs/pci_expander_bridge.txt, it points out pxb could be placed only
on bus 0 (pci.0). Therfore, the structure still could help us to find all p=
xb devices.
/* point to the bus 0, which is pcie.0
  * pxb devices could only be placed on bus 0.
  */
Is this ok?

> > > > +     * could be gained.
> > > > +     */
> > > > +    PCIBus *bus;
> > > >   } VirtMachineState;
> > > >
> > > >   #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM :
> > > > VIRT_PCIE_ECAM)
> > > >
> >
> > Regards,
> > Miao

Regards,
Miao

