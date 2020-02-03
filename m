Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A684EC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616C6207E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exUQrHqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616C6207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyc54-0001ky-K7
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyc47-0000mh-HJ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyc45-00012B-MH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:47:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28457
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyc45-0000yr-I7
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580737620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+NqdDMvr6ibk08mTZ/OLpIXPh9vAD+oGLkGG2+p9eQ=;
 b=exUQrHqYph6Tgq5+MNRIAKzO8cYBfCTTachzUCSwrVPowahlqqypF7n37naQHaRc39lw4W
 CLtUsB+98iTVpOK2YCuJPfRT0hVcWp3qG+twH+JL58OG1dWxcwUU/ceeVq9Gp0qoJM1cR1
 wAjcouxv7dY/WhTYannGtDY6Ky1RRUE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-jp3oFEV2PZqEmM-RU0H1ng-1; Mon, 03 Feb 2020 08:46:58 -0500
Received: by mail-qv1-f72.google.com with SMTP id v3so9487274qvm.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 05:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=autq2jCamxuS1Bu9hLKFxQZqaz4BeF/L0ATO2KLLmpk=;
 b=OX/4wMdsgcUjrtQSrCPcdFiPgw7qyedPAYlJvRAG3DClqtOn6XTIxmInVEQ4kpPRTe
 WrMoBNCoAMbABPDGjspSOLqXRPZpzS11DaaQABDw/RzKNe3RZRTQPGL2QWsvTu+Zwo+H
 277hSfs6+aQi2vIshJYgzIZbHeqi0yOgJ5HzfFckJeh+3EqmeJo/Y8gsY98OpTHbcmuA
 YOf2HrrFcUH3rs9DleEsgWe6HogHFBrR2WnqSBPd8asxs6a4QaC/jvXjvz0ZkeMKDX6W
 FopWCR0S3HwfYODArrplQ/HmULvDj+zEwC/EM700dY772HU/8+glSJj0mNP1QwC/NV6P
 u/nA==
X-Gm-Message-State: APjAAAV9eE0Ggrc8P8kajSgIgbABIUfJeHL55H7HUsAs56Knq9OjuUFh
 7wkKqpHQIOG0KtzwOEPk4ZJXWUyePFv79xTH96b2gPuHfd1QQGJQzQj6QdbUW09WiOVS9i3k/Aq
 eb9YMmBsJyXILSQQ=
X-Received: by 2002:a05:620a:2104:: with SMTP id
 l4mr21942840qkl.240.1580737618023; 
 Mon, 03 Feb 2020 05:46:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwnE2kSfjWm+IxNAa9aTlJJ4PnCRCwMynZjdq8+iP3W+7bPH8tu6v849XexkQyPCIGaq2hmQ==
X-Received: by 2002:a05:620a:2104:: with SMTP id
 l4mr21942814qkl.240.1580737617696; 
 Mon, 03 Feb 2020 05:46:57 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id q5sm9178141qkf.14.2020.02.03.05.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 05:46:56 -0800 (PST)
Date: Mon, 3 Feb 2020 08:46:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v13 07/10] virtio-iommu-pci: Add virtio iommu pci support
Message-ID: <20200203084532-mutt-send-email-mst@kernel.org>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <20200125171955.12825-8-eric.auger@redhat.com>
 <20200203080122-mutt-send-email-mst@kernel.org>
 <037666c2-6124-0db6-3688-a134f9f0845a@redhat.com>
 <20200203082637-mutt-send-email-mst@kernel.org>
 <462756c1-b4fd-e0f0-7fca-61b9b1fd8157@redhat.com>
MIME-Version: 1.0
In-Reply-To: <462756c1-b4fd-e0f0-7fca-61b9b1fd8157@redhat.com>
X-MC-Unique: jp3oFEV2PZqEmM-RU0H1ng-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 02:38:22PM +0100, Auger Eric wrote:
> Hi Michael,
>=20
> On 2/3/20 2:28 PM, Michael S. Tsirkin wrote:
> > On Mon, Feb 03, 2020 at 02:20:55PM +0100, Auger Eric wrote:
> >> Hi Michael,
> >>
> >> On 2/3/20 2:03 PM, Michael S. Tsirkin wrote:
> >>> On Sat, Jan 25, 2020 at 06:19:52PM +0100, Eric Auger wrote:
> >>>> This patch adds virtio-iommu-pci, which is the pci proxy for
> >>>> the virtio-iommu device.
> >>>>
> >>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>>
> >>> I commented on v11 of this patch:
> >>>>> Could you send a smaller patchset without pci/acpi bits for now?
> >>> And you answered:
> >>>> Yes I am about to send v12.
> >>>
> >>> I guess this patch is here by mistake then?
> >>>
> >>> I think PCI devices should always have config space so guests are
> >>> not tempted to find work-arounds. Right?
> >> No it is not here by mistake. I removed everything related non DT
> >> integration as we discussed.
> >>
> >> DT support is fully upstream even for virtio-iommu-pci.
> >> https://github.com/torvalds/linux/blob/master/Documentation/devicetree=
/bindings/virtio/iommu.txt
> >>
> >> So what's wrong implementing that at the moment. As we discussed we
> >> would use the PCIe config space integration for non DT.
> >>
> >> If I use the MMIO based device, I am forced to lock an MMIO region for
> >> it in the machvirt memory map:
> >> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetre=
e/bindings/virtio/mmio.txt
> >>
> >> I guess Peter (Maydell) will not be happy with this situation either.
> >>
> >> Thanks
> >>
> >> Eric
> >=20
> > I see. Can't we limit this to DT platforms for now then?
> That is the case. virtio-iommu does not work with ACPI.


Right. But nothing seems to prevent users from creating it
on systems without dt, and there won't be an easy way for
management to detect it when qemu added  this support down the road.



> For non DT the plan is to use what you suggested, ie. pass the binding
> info through the PCIe config space.
>=20
> In that prospect I am waiting for Jean-Philippe's [RFC 00/13]
> virtio-iommu on non-devicetree platforms respin
> (https://lore.kernel.org/linux-iommu/20191203190136.00007171@intel.com/T/=
)
> and especially patches 12 and 13 of the series, ie. binding info through
> the PCIe config space.
>=20
> Thanks
>=20
> Eric
> >=20
> >=20
> >=20
> >>>
> >>>> ---
> >>>>
> >>>> v11 -> v12:
> >>>> - added Jean's R-b
> >>>> - remove the array of intervals. Will be introduced later?
> >>>>
> >>>> v10 -> v11:
> >>>> - add the reserved_regions array property
> >>>>
> >>>> v9 -> v10:
> >>>> - include "hw/qdev-properties.h" header
> >>>>
> >>>> v8 -> v9:
> >>>> - add the msi-bypass property
> >>>> - create virtio-iommu-pci.c
> >>>> ---
> >>>>  hw/virtio/Makefile.objs          |  1 +
> >>>>  hw/virtio/virtio-iommu-pci.c     | 88 +++++++++++++++++++++++++++++=
+++
> >>>>  include/hw/pci/pci.h             |  1 +
> >>>>  include/hw/virtio/virtio-iommu.h |  1 +
> >>>>  qdev-monitor.c                   |  1 +
> >>>>  5 files changed, 92 insertions(+)
> >>>>  create mode 100644 hw/virtio/virtio-iommu-pci.c
> >>>>
> >>>> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> >>>> index 2fd9da7410..4e4d39a0a4 100644
> >>>> --- a/hw/virtio/Makefile.objs
> >>>> +++ b/hw/virtio/Makefile.objs
> >>>> @@ -29,6 +29,7 @@ obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-=
host-pci.o
> >>>>  obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-pci.o
> >>>>  obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng-pci.o
> >>>>  obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon-pci.o
> >>>> +obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu-pci.o
> >>>>  obj-$(CONFIG_VIRTIO_9P) +=3D virtio-9p-pci.o
> >>>>  obj-$(CONFIG_VIRTIO_SCSI) +=3D virtio-scsi-pci.o
> >>>>  obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk-pci.o
> >>>> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-p=
ci.c
> >>>> new file mode 100644
> >>>> index 0000000000..4cfae1f9df
> >>>> --- /dev/null
> >>>> +++ b/hw/virtio/virtio-iommu-pci.c
> >>>> @@ -0,0 +1,88 @@
> >>>> +/*
> >>>> + * Virtio IOMMU PCI Bindings
> >>>> + *
> >>>> + * Copyright (c) 2019 Red Hat, Inc.
> >>>> + * Written by Eric Auger
> >>>> + *
> >>>> + *  This program is free software; you can redistribute it and/or m=
odify
> >>>> + *  it under the terms of the GNU General Public License version 2 =
or
> >>>> + *  (at your option) any later version.
> >>>> + */
> >>>> +
> >>>> +#include "qemu/osdep.h"
> >>>> +
> >>>> +#include "virtio-pci.h"
> >>>> +#include "hw/virtio/virtio-iommu.h"
> >>>> +#include "hw/qdev-properties.h"
> >>>> +
> >>>> +typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
> >>>> +
> >>>> +/*
> >>>> + * virtio-iommu-pci: This extends VirtioPCIProxy.
> >>>> + *
> >>>> + */
> >>>> +#define VIRTIO_IOMMU_PCI(obj) \
> >>>> +        OBJECT_CHECK(VirtIOIOMMUPCI, (obj), TYPE_VIRTIO_IOMMU_PCI)
> >>>> +
> >>>> +struct VirtIOIOMMUPCI {
> >>>> +    VirtIOPCIProxy parent_obj;
> >>>> +    VirtIOIOMMU vdev;
> >>>> +};
> >>>> +
> >>>> +static Property virtio_iommu_pci_properties[] =3D {
> >>>> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> >>>> +    DEFINE_PROP_END_OF_LIST(),
> >>>> +};
> >>>> +
> >>>> +static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Erro=
r **errp)
> >>>> +{
> >>>> +    VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(vpci_dev);
> >>>> +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> >>>> +
> >>>> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> >>>> +    object_property_set_link(OBJECT(dev),
> >>>> +                             OBJECT(pci_get_bus(&vpci_dev->pci_dev)=
),
> >>>> +                             "primary-bus", errp);
> >>>> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> >>>> +}
> >>>> +
> >>>> +static void virtio_iommu_pci_class_init(ObjectClass *klass, void *d=
ata)
> >>>> +{
> >>>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >>>> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> >>>> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> >>>> +    k->realize =3D virtio_iommu_pci_realize;
> >>>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >>>> +    dc->props =3D virtio_iommu_pci_properties;
> >>>> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> >>>> +    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_IOMMU;
> >>>> +    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
> >>>> +    pcidev_k->class_id =3D PCI_CLASS_OTHERS;
> >>>> +}
> >>>> +
> >>>> +static void virtio_iommu_pci_instance_init(Object *obj)
> >>>> +{
> >>>> +    VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(obj);
> >>>> +
> >>>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> >>>> +                                TYPE_VIRTIO_IOMMU);
> >>>> +}
> >>>> +
> >>>> +static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info =3D {
> >>>> +    .base_name             =3D TYPE_VIRTIO_IOMMU_PCI,
> >>>> +    .generic_name          =3D "virtio-iommu-pci",
> >>>> +    .transitional_name     =3D "virtio-iommu-pci-transitional",
> >>>> +    .non_transitional_name =3D "virtio-iommu-pci-non-transitional",
> >>>> +    .instance_size =3D sizeof(VirtIOIOMMUPCI),
> >>>> +    .instance_init =3D virtio_iommu_pci_instance_init,
> >>>> +    .class_init    =3D virtio_iommu_pci_class_init,
> >>>> +};
> >>>> +
> >>>> +static void virtio_iommu_pci_register(void)
> >>>> +{
> >>>> +    virtio_pci_types_register(&virtio_iommu_pci_info);
> >>>> +}
> >>>> +
> >>>> +type_init(virtio_iommu_pci_register)
> >>>> +
> >>>> +
> >>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> >>>> index 2acd8321af..cfedf5a995 100644
> >>>> --- a/include/hw/pci/pci.h
> >>>> +++ b/include/hw/pci/pci.h
> >>>> @@ -86,6 +86,7 @@ extern bool pci_available;
> >>>>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
> >>>>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
> >>>>  #define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
> >>>> +#define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1014
> >>>> =20
> >>>>  #define PCI_VENDOR_ID_REDHAT             0x1b36
> >>>>  #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
> >>>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/vi=
rtio-iommu.h
> >>>> index 2a2c2ecf83..f39aa0fbb4 100644
> >>>> --- a/include/hw/virtio/virtio-iommu.h
> >>>> +++ b/include/hw/virtio/virtio-iommu.h
> >>>> @@ -25,6 +25,7 @@
> >>>>  #include "hw/pci/pci.h"
> >>>> =20
> >>>>  #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
> >>>> +#define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-device-base"
> >>>>  #define VIRTIO_IOMMU(obj) \
> >>>>          OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
> >>>> =20
> >>>> diff --git a/qdev-monitor.c b/qdev-monitor.c
> >>>> index 3465a1e2d0..97f4022b51 100644
> >>>> --- a/qdev-monitor.c
> >>>> +++ b/qdev-monitor.c
> >>>> @@ -66,6 +66,7 @@ static const QDevAlias qdev_alias_table[] =3D {
> >>>>      { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_S390X=
 },
> >>>>      { "virtio-input-host-pci", "virtio-input-host",
> >>>>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
> >>>> +    { "virtio-iommu-pci", "virtio-iommu", QEMU_ARCH_ALL & ~QEMU_ARC=
H_S390X },
> >>>>      { "virtio-keyboard-ccw", "virtio-keyboard", QEMU_ARCH_S390X },
> >>>>      { "virtio-keyboard-pci", "virtio-keyboard",
> >>>>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
> >>>> --=20
> >>>> 2.20.1
> >>>
> >>>
> >=20


