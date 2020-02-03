Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315D8C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F003E20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9a81LrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F003E20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybmg-0001i7-6i
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iybm2-00019z-IH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iybm0-0002c7-Rx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:28:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29146
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iybm0-0002bb-Lz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580736500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0srS6pVABld/qNGZdsEBNeHQohddXIhkSCO6I5J1bM=;
 b=U9a81LrWe7rgKgnShKtPXovOqgc9K9BMcKorVRo85mOQLwps+zStbYxyBqY1gZRsl8JeYt
 yXghnnUIqzj7LV7a1jINIXrjDlgLdfJLufESSJ4AFwshr1f9kknEHo0Lqo5kp+p7d5Za7T
 UgIEXzKQMvL8SnWVnYyaI/DUch4L/U4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-A0xksueWNqKNJx2Rs5q5CQ-1; Mon, 03 Feb 2020 08:28:18 -0500
Received: by mail-qt1-f198.google.com with SMTP id c22so9834476qtn.23
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 05:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NZdtt/bGxJKWPx8gwLXEibCe3fEV92G0oZRadmu+eu8=;
 b=O5oRzgVcIALMxm4jR/QSOvdFr+dOXjXWkbhtscP5YWRg0F4KBmxU9JITM2YQKzijCR
 +82i+zT9kJp5Xsy+P7uoEshvi0m3QYsAYvAJYtQUX3PO0toEVD5S/ngz+2YhR4toBeWm
 ElnnmFe6Asxnp6yBFtp2EXhTSIkwpD4WmdpOwSHaEot+KMoHFOoRshheKpu2UIZFX3Au
 Q57ZP1B4/5v81NMyJFJN0zldtqLZ/RtFFPQJCzh8PIiy7V4ZslPWw6miS+puEMkoIAeL
 BGTxRhix33qSTPLU5vxg82RRkbe3eUOW8BEbNTnQsi2rZz8ibHR0DDK2btWjYB9n+J78
 N34g==
X-Gm-Message-State: APjAAAWgfn2ato8n9h8MPFERXy135t2b91ib1zHcwWIfGSMWHhQ7a0y1
 SLy/fmiGOszYjRGBIRylMiXB04l+vEZAil5gBM2DO6Rbdp2c/M6ArhZAN2Yn9TD9G89mztQa8oB
 MTlhJHfkjxPAa3D8=
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr23796556qtv.137.1580736497651; 
 Mon, 03 Feb 2020 05:28:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqyP4jzDiQCO8fYzSf/G6PZn956mbLr4gCf9v2GICalsQxWEtMNHRxb5PMJGSvPkC1blrFcH6g==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr23796523qtv.137.1580736497337; 
 Mon, 03 Feb 2020 05:28:17 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id w134sm9463350qka.127.2020.02.03.05.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 05:28:16 -0800 (PST)
Date: Mon, 3 Feb 2020 08:28:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v13 07/10] virtio-iommu-pci: Add virtio iommu pci support
Message-ID: <20200203082637-mutt-send-email-mst@kernel.org>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <20200125171955.12825-8-eric.auger@redhat.com>
 <20200203080122-mutt-send-email-mst@kernel.org>
 <037666c2-6124-0db6-3688-a134f9f0845a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <037666c2-6124-0db6-3688-a134f9f0845a@redhat.com>
X-MC-Unique: A0xksueWNqKNJx2Rs5q5CQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Mon, Feb 03, 2020 at 02:20:55PM +0100, Auger Eric wrote:
> Hi Michael,
>=20
> On 2/3/20 2:03 PM, Michael S. Tsirkin wrote:
> > On Sat, Jan 25, 2020 at 06:19:52PM +0100, Eric Auger wrote:
> >> This patch adds virtio-iommu-pci, which is the pci proxy for
> >> the virtio-iommu device.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >=20
> > I commented on v11 of this patch:
> >>> Could you send a smaller patchset without pci/acpi bits for now?
> > And you answered:
> >> Yes I am about to send v12.
> >=20
> > I guess this patch is here by mistake then?
> >=20
> > I think PCI devices should always have config space so guests are
> > not tempted to find work-arounds. Right?
> No it is not here by mistake. I removed everything related non DT
> integration as we discussed.
>=20
> DT support is fully upstream even for virtio-iommu-pci.
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/virtio/iommu.txt
>=20
> So what's wrong implementing that at the moment. As we discussed we
> would use the PCIe config space integration for non DT.
>=20
> If I use the MMIO based device, I am forced to lock an MMIO region for
> it in the machvirt memory map:
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/b=
indings/virtio/mmio.txt
>=20
> I guess Peter (Maydell) will not be happy with this situation either.
>=20
> Thanks
>=20
> Eric

I see. Can't we limit this to DT platforms for now then?



> >=20
> >> ---
> >>
> >> v11 -> v12:
> >> - added Jean's R-b
> >> - remove the array of intervals. Will be introduced later?
> >>
> >> v10 -> v11:
> >> - add the reserved_regions array property
> >>
> >> v9 -> v10:
> >> - include "hw/qdev-properties.h" header
> >>
> >> v8 -> v9:
> >> - add the msi-bypass property
> >> - create virtio-iommu-pci.c
> >> ---
> >>  hw/virtio/Makefile.objs          |  1 +
> >>  hw/virtio/virtio-iommu-pci.c     | 88 +++++++++++++++++++++++++++++++=
+
> >>  include/hw/pci/pci.h             |  1 +
> >>  include/hw/virtio/virtio-iommu.h |  1 +
> >>  qdev-monitor.c                   |  1 +
> >>  5 files changed, 92 insertions(+)
> >>  create mode 100644 hw/virtio/virtio-iommu-pci.c
> >>
> >> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> >> index 2fd9da7410..4e4d39a0a4 100644
> >> --- a/hw/virtio/Makefile.objs
> >> +++ b/hw/virtio/Makefile.objs
> >> @@ -29,6 +29,7 @@ obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-ho=
st-pci.o
> >>  obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-pci.o
> >>  obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng-pci.o
> >>  obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon-pci.o
> >> +obj-$(CONFIG_VIRTIO_IOMMU) +=3D virtio-iommu-pci.o
> >>  obj-$(CONFIG_VIRTIO_9P) +=3D virtio-9p-pci.o
> >>  obj-$(CONFIG_VIRTIO_SCSI) +=3D virtio-scsi-pci.o
> >>  obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk-pci.o
> >> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci=
.c
> >> new file mode 100644
> >> index 0000000000..4cfae1f9df
> >> --- /dev/null
> >> +++ b/hw/virtio/virtio-iommu-pci.c
> >> @@ -0,0 +1,88 @@
> >> +/*
> >> + * Virtio IOMMU PCI Bindings
> >> + *
> >> + * Copyright (c) 2019 Red Hat, Inc.
> >> + * Written by Eric Auger
> >> + *
> >> + *  This program is free software; you can redistribute it and/or mod=
ify
> >> + *  it under the terms of the GNU General Public License version 2 or
> >> + *  (at your option) any later version.
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +
> >> +#include "virtio-pci.h"
> >> +#include "hw/virtio/virtio-iommu.h"
> >> +#include "hw/qdev-properties.h"
> >> +
> >> +typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
> >> +
> >> +/*
> >> + * virtio-iommu-pci: This extends VirtioPCIProxy.
> >> + *
> >> + */
> >> +#define VIRTIO_IOMMU_PCI(obj) \
> >> +        OBJECT_CHECK(VirtIOIOMMUPCI, (obj), TYPE_VIRTIO_IOMMU_PCI)
> >> +
> >> +struct VirtIOIOMMUPCI {
> >> +    VirtIOPCIProxy parent_obj;
> >> +    VirtIOIOMMU vdev;
> >> +};
> >> +
> >> +static Property virtio_iommu_pci_properties[] =3D {
> >> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> >> +    DEFINE_PROP_END_OF_LIST(),
> >> +};
> >> +
> >> +static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error =
**errp)
> >> +{
> >> +    VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(vpci_dev);
> >> +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> >> +
> >> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> >> +    object_property_set_link(OBJECT(dev),
> >> +                             OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
> >> +                             "primary-bus", errp);
> >> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> >> +}
> >> +
> >> +static void virtio_iommu_pci_class_init(ObjectClass *klass, void *dat=
a)
> >> +{
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> >> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> >> +    k->realize =3D virtio_iommu_pci_realize;
> >> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >> +    dc->props =3D virtio_iommu_pci_properties;
> >> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> >> +    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_IOMMU;
> >> +    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
> >> +    pcidev_k->class_id =3D PCI_CLASS_OTHERS;
> >> +}
> >> +
> >> +static void virtio_iommu_pci_instance_init(Object *obj)
> >> +{
> >> +    VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(obj);
> >> +
> >> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> >> +                                TYPE_VIRTIO_IOMMU);
> >> +}
> >> +
> >> +static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info =3D {
> >> +    .base_name             =3D TYPE_VIRTIO_IOMMU_PCI,
> >> +    .generic_name          =3D "virtio-iommu-pci",
> >> +    .transitional_name     =3D "virtio-iommu-pci-transitional",
> >> +    .non_transitional_name =3D "virtio-iommu-pci-non-transitional",
> >> +    .instance_size =3D sizeof(VirtIOIOMMUPCI),
> >> +    .instance_init =3D virtio_iommu_pci_instance_init,
> >> +    .class_init    =3D virtio_iommu_pci_class_init,
> >> +};
> >> +
> >> +static void virtio_iommu_pci_register(void)
> >> +{
> >> +    virtio_pci_types_register(&virtio_iommu_pci_info);
> >> +}
> >> +
> >> +type_init(virtio_iommu_pci_register)
> >> +
> >> +
> >> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> >> index 2acd8321af..cfedf5a995 100644
> >> --- a/include/hw/pci/pci.h
> >> +++ b/include/hw/pci/pci.h
> >> @@ -86,6 +86,7 @@ extern bool pci_available;
> >>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
> >>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
> >>  #define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
> >> +#define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1014
> >> =20
> >>  #define PCI_VENDOR_ID_REDHAT             0x1b36
> >>  #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
> >> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virt=
io-iommu.h
> >> index 2a2c2ecf83..f39aa0fbb4 100644
> >> --- a/include/hw/virtio/virtio-iommu.h
> >> +++ b/include/hw/virtio/virtio-iommu.h
> >> @@ -25,6 +25,7 @@
> >>  #include "hw/pci/pci.h"
> >> =20
> >>  #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
> >> +#define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-device-base"
> >>  #define VIRTIO_IOMMU(obj) \
> >>          OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
> >> =20
> >> diff --git a/qdev-monitor.c b/qdev-monitor.c
> >> index 3465a1e2d0..97f4022b51 100644
> >> --- a/qdev-monitor.c
> >> +++ b/qdev-monitor.c
> >> @@ -66,6 +66,7 @@ static const QDevAlias qdev_alias_table[] =3D {
> >>      { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_S390X }=
,
> >>      { "virtio-input-host-pci", "virtio-input-host",
> >>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
> >> +    { "virtio-iommu-pci", "virtio-iommu", QEMU_ARCH_ALL & ~QEMU_ARCH_=
S390X },
> >>      { "virtio-keyboard-ccw", "virtio-keyboard", QEMU_ARCH_S390X },
> >>      { "virtio-keyboard-pci", "virtio-keyboard",
> >>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
> >> --=20
> >> 2.20.1
> >=20
> >=20


