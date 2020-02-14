Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C1FC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E00222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 07:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E00222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2VS3-000250-CI
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 02:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1j2VQk-0001VJ-Tt
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1j2VQj-0000kn-Ha
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:30:30 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:46960 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1j2VQj-0000hu-49
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 02:30:29 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 3B1FAD50A17370CAAD81;
 Fri, 14 Feb 2020 15:30:26 +0800 (CST)
Received: from dggeme708-chm.china.huawei.com (10.1.199.104) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 15:30:25 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme708-chm.china.huawei.com (10.1.199.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 14 Feb 2020 15:30:25 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Fri, 14 Feb 2020 15:30:25 +0800
From: miaoyubo <miaoyubo@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Thread-Topic: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie under
 arm.
Thread-Index: AQHV4kI1fIh9lqS0F0yGLr3GCBTaKKgYYuQAgAHpLBA=
Date: Fri, 14 Feb 2020 07:30:25 +0000
Message-ID: <d7cbacf3735a48f781f14f51d739da91@huawei.com>
References: <20200213074952.544-1-miaoyubo@huawei.com>
 <20200213074952.544-3-miaoyubo@huawei.com>
 <20200213051310-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200213051310-mutt-send-email-mst@kernel.org>
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
> Sent: Thursday, February 13, 2020 6:17 PM
> To: miaoyubo <miaoyubo@huawei.com>
> Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com; Xiexiangyou
> <xiexiangyou@huawei.com>; imammedo@redhat.com; qemu-
> devel@nongnu.org
> Subject: Re: [RFC 2/2] pci-expender-bus:Add pcie-root-port to pxb-pcie
> under arm.
>=20
> On Thu, Feb 13, 2020 at 03:49:52PM +0800, Yubo Miao wrote:
> > From: miaoyubo <miaoyubo@huawei.com>
> >
> > Since devices could not directly plugged into pxb-pcie,
>=20
> Hmm is this different from the root port? intergrated devices do exist fo=
r
> that actually.
>=20

Thanks for replying
The pxb-pcie is like a host bridge,
 you have to plug pcie-root-port or pci-bridge so devices could be plugged

> > under arm,
>=20
> how is arm special?
>=20

Cureently, if u define a pxb-pcie device, one pcie-root-port or pci-bridge =
or something=20
else have to be defined also, The patch just auto generate pcie-root-port f=
or arm to=20
avoid affect other architecture

> > one
> > pcie-root port is plugged into pxb-pcie. Due to the bus for each
> > pxb-pcie is defined as 2 in acpi dsdt tables(one for pxb-pcie, one for
> > pcie-root-port), only one device could be plugged into one pxb-pcie.
>=20
> So why can't we have users specify any number of root ports using -device=
?
> then make acpi tables match the # of ports created?
>=20
>=20

Users could specify multiply pxb-devices, it is supported.
But only one device could be plugged for each pxb-pcie,  it is the same wit=
h pxb-pci for piix.

> >
> > Signed-off-by: miaoyubo <miaoyubo@huawei.com>
> > ---
> >  hw/pci-bridge/pci_expander_bridge.c | 9 +++++++++
> >  include/hw/pci/pcie_port.h          | 1 +
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c
> > b/hw/pci-bridge/pci_expander_bridge.c
> > index 47aaaf8fd1..3d896dd452 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -15,6 +15,7 @@
> >  #include "hw/pci/pci.h"
> >  #include "hw/pci/pci_bus.h"
> >  #include "hw/pci/pci_host.h"
> > +#include "hw/pci/pcie_port.h"
> >  #include "hw/qdev-properties.h"
> >  #include "hw/pci/pci_bridge.h"
> >  #include "qemu/range.h"
> > @@ -233,7 +234,15 @@ static void pxb_dev_realize_common(PCIDevice
> > *dev, bool pcie, Error **errp)
> >
> >      ds =3D qdev_create(NULL, TYPE_PXB_HOST);
> >      if (pcie) {
> > +#ifdef __aarch64__
> > +        bus =3D pci_root_bus_new(ds, "pxb-pcie-internal",
> > +                               NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
> > +        bds =3D qdev_create(BUS(bus), "pcie-root-port");
> > +        bds->id =3D dev_name;
> > +        qdev_prop_set_uint8(bds, PCIE_ROOT_PORT_PROP_CHASSIS,
> > +pxb->bus_nr); #else
> >          bus =3D pci_root_bus_new(ds, dev_name, NULL, NULL, 0,
> > TYPE_PXB_PCIE_BUS);
> > +#endif
>=20
> What does all this have to do with building on aarch64?
>=20

Based on the comments, this patch would be abandoned in patch V2,=20
PXB-PCIE would also be useful but pcie-root-port or pci-bridge have to Be d=
efined by user.

> >      } else {
> >          bus =3D pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0,
> TYPE_PXB_BUS);
> >          bds =3D qdev_create(BUS(bus), "pci-bridge"); diff --git
> > a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h index
> > 4b3d254b08..b41d473220 100644
> > --- a/include/hw/pci/pcie_port.h
> > +++ b/include/hw/pci/pcie_port.h
> > @@ -64,6 +64,7 @@ int pcie_chassis_add_slot(struct PCIESlot *slot);
> > void pcie_chassis_del_slot(PCIESlot *s);
> >
> >  #define TYPE_PCIE_ROOT_PORT         "pcie-root-port-base"
> > +#define PCIE_ROOT_PORT_PROP_CHASSIS "chassis"
>=20
> If you are going to do this, replace other instances of "chassis"
> with the macro.
>=20

Thanks for your replay, this patch would be abandoned.

> >  #define PCIE_ROOT_PORT_CLASS(klass) \
> >       OBJECT_CLASS_CHECK(PCIERootPortClass, (klass),
> > TYPE_PCIE_ROOT_PORT)  #define PCIE_ROOT_PORT_GET_CLASS(obj) \
> > --
> > 2.19.1
> >

Regards,
Miao


