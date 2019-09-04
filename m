Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22AAC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD3F2168B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 22:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD3F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5daC-0006kx-NG
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 18:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i5cxc-0003cr-RW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i5cxZ-0003UO-Ld
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:37:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i5cxZ-0003U9-Cg
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 17:37:01 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4FCFC83F3F
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 21:37:00 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id b15so16717wrp.21
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 14:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G/GDuOLnVngEBHwGh++uLS5RwJ2iJCA1po9Ku89opVQ=;
 b=qGtjMHZc61MS+UQpb1cp8fxXEJJ8PrPt6Z40jD3LZGJhhgworRCCnaN2921w2RHaDJ
 WgAPL24pDC4R9Nb/zdVSq5SpClIWaSv36YVDvUkAGXLEZs6DREnzE/H4INik5iNNaruz
 FffSLQkcIHej/W4llaN+TputdIw3eFcWyIN7UvIaRYo4HYFE/RDYUMAS63Qd+xBtZ+F5
 UE/8Htcjl2/+vZtOpV5zcDBqMTmFWurWSoVAJeISddLfljrd5rpIcLAqjJS5gWQdDibq
 H1ZW7DlZrFKsaAWRbRb03MNKG/M3YjgUMnz9GgEbzDpySu84o8Y/6bTGIkOAwHhpxkcv
 qJgg==
X-Gm-Message-State: APjAAAXyaICf70P5M60frAbUAwipzcUIPvkW8E6nfPCV1IIMCPtvbCVX
 0mAx0PLf315JreoihTsXiGmPdqxbx1RCg/QlAgummNvD5J9ZUwCPPXG2VLWBSLPu3+SzLrXWQQF
 uB7TkRCUXKkNEjHk=
X-Received: by 2002:a5d:6691:: with SMTP id l17mr22258971wru.262.1567633019016; 
 Wed, 04 Sep 2019 14:36:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy7rqd2HDqwcWAm9PSG1pdz8E6/nIz5Uxw9azXFnicvgSaO9wEy5M/KWQvrgPoKKFisGKUv8A==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr22258954wru.262.1567633018724; 
 Wed, 04 Sep 2019 14:36:58 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id j22sm151199wre.45.2019.09.04.14.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 14:36:57 -0700 (PDT)
Date: Wed, 4 Sep 2019 17:36:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190904171550-mutt-send-email-mst@kernel.org>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-15-eric.auger@redhat.com>
 <20190730153305-mutt-send-email-mst@kernel.org>
 <a0e88a60-083b-2730-5db8-7bba0299974b@redhat.com>
 <20190801090027-mutt-send-email-mst@kernel.org>
 <ff726b89-a1b1-9b9e-a767-ef72da520053@redhat.com>
 <20190901023827-mutt-send-email-mst@kernel.org>
 <8dd239b8-6d0b-3795-76d0-e8ead4b847ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd239b8-6d0b-3795-76d0-e8ead4b847ef@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 14/15] virtio-iommu-pci: Add
 virtio iommu pci support
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, peter.maydell@linaro.org,
 tn@semihalf.com, qemu-devel@nongnu.org, peterx@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, bharat.bhushan@nxp.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 04, 2019 at 04:19:33PM +0200, Auger Eric wrote:
> Hi Michael,
> 
> On 9/1/19 8:40 AM, Michael S. Tsirkin wrote:
> > On Thu, Aug 01, 2019 at 03:49:37PM +0200, Auger Eric wrote:
> >> Hi Michael,
> >>
> >> On 8/1/19 3:06 PM, Michael S. Tsirkin wrote:
> >>> On Thu, Aug 01, 2019 at 02:15:03PM +0200, Auger Eric wrote:
> >>>> Hi Michael,
> >>>>
> >>>> On 7/30/19 9:35 PM, Michael S. Tsirkin wrote:
> >>>>> On Tue, Jul 30, 2019 at 07:21:36PM +0200, Eric Auger wrote:
> >>>>>> This patch adds virtio-iommu-pci, which is the pci proxy for
> >>>>>> the virtio-iommu device.
> >>>>>>
> >>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>>>>
> >>>>> This part I'm not sure we should merge just yet.  The reason being I
> >>>>> think we should limit it to mmio where DT can be used to describe iommu
> >>>>> topology. For PCI I don't see why we shouldn't always expose this
> >>>>> in the config space, and I think it's preferable not to
> >>>>> need to support a mix of DT,ACPI and PCI as options.
> >>>>
> >>>> For context, some discussion related to this topic already arose on v7
> >>>> revision of the driver:
> >>>>
> >>>> [1] Re: [PATCH v7 0/7] Add virtio-iommu driver
> >>>> https://lore.kernel.org/linux-pci/87a7ioby9u.fsf@morokweng.localdomain/
> >>>>
> >>>> Some additional thoughts.
> >>>>
> >>>> First considering DT boot.
> >>>>
> >>>> THE DT description features an iommu-map property in the
> >>>> pci-host-ecam-generic node that describes which RIDs are handled by the
> >>>> virtio-iommu and a possible offset/mask to be applied inbetween the RID
> >>>> and the streamID at the input of the IOMMU
> >>>> (Documentation/devicetree/bindings/pci/pci-iommu.txt)
> >>>>
> >>>> As far as I understand when a DMA capable device is setup, its DMA
> >>>> configuration is built using that call chain:
> >>>>
> >>>> pci_dma_configure
> >>>> |_ of_dma_configure
> >>>>    |_ of_iommu_configure
> >>>>       |_ of_pci_iommu_init
> >>>>          |_ of_map_rid
> >>>>
> >>>> I understand you would like the iommu-map/iommu-map-mask info to be
> >>>> exposed directly into the config space of the device instead of inside
> >>>> the DT or IORT table. Assuming a module is initialized sufficiently
> >>>> early to retrieve this info, we would need the resulting info to be
> >>>> consolidated to allow pci_dma_configure chain to work seemlessly. This
> >>>> sounds a significant impact on above kernel infrastructure.
> >>>
> >>> I don't really know what consolidated means.
> >>> It is pretty common for IOMMUs to expose config through
> >>> PCI registers. This typically happens as a fixup.
> >> I meant: instead of retrieving the info through the of_* code you need
> >> to interoperate with the module to retrieve the same info and detect
> >> when you need to take that path instead of the of one.
> > 
> > The way to do it would be with a quirk,
> > and the quirk would not be part of the
> > virtio module - it can poke at the device using
> > virtio_pci_cfg_cap.
> 
> I got this preliminary quirk function working. However it only works for
> a DECLARE_PCI_FIXUP_ENABLE quirk. In an EARLY quirk, the guest crashes
> on the first ioread that attempts to read the BAR as mem accesses are
> not enabled yet I guess.

This is why I suggested using virtio_pci_cfg_cap.
This allows bar access when mem accesses are disabled.
 

> So assuming I get the proper system config data in the device
> configuration, the iommu bindings will be set up late.

If it all works with a late quirk, then great.
If not we can fall back to config cycles.

> By the way I have not yet attempted to generate iommu bindings from the
> quirk function (job done in drivers/acpi/arm64/iort.c) which does not
> sound to be straightforward.
> > 
> >>>
> >>> I would write a tiny driver to do exactly that,
> >>> and run it from the fixup.
> >>>
> >>>
> >>>> This comes in addition to the development of the "small module that
> >>>> loads early and pokes at the IOMMU sufficiently to get the data about
> >>>> which devices use the IOMMU out of it using standard virtio config
> >>>> space" evoked in [1] + the definition of the data formats to be put in
> >>>> the very cfg space.
> >>>
> >>> That last part is true but that's exactly why I propose we
> >>> wait on this patch a bit.
> >>>
> >>>> With ACPI I understand we have the same kind of infrastructure:
> >>>> drivers/acpi/arm64/iort.c currently extracts the mapping between RC RIDs
> >>>> and IOMMU streamids
> >>>>
> >>>> pci_dma_configure(
> >>>> |_ acpi_dma_configure
> >>>>    |_ iort_iommu_configure
> >>>>       |_ iort_pci_iommu_init
> >>>>          |_ iort_node_map_id
> >>>>             |_ iort_id_map
> >>>>
> >>>> Maybe I fail to see the easy and right way to do the integration at
> >>>> kernel level but I am a bit frightened by the efforts that would be
> >>>> requested to follow your suggestion, whereas the DT infra is ready and
> >>>> fully upstreamed to accept the use case.
> >>>
> >>> Did you take a look at drivers/pci/quirks.c and how these run?
> >>> I think it's just a question of adding DECLARE_PCI_FIXUP_CLASS_EARLY
> >>> and running your hook from there.
> >> I will do and trace the code.
> >>>
> >>>
> >>>> For ACPI I agree AFAIK IORT was primarily defined by ARM, for ARM but we
> >>>> prototyped IORT integration with x86 and it worked for pc machine
> >>>> without major trouble.
> >>>>
> >>>> I sent the kernel and qemu patches prototyping this IORT integration:
> >>>>
> >>>> https://github.com/eauger/linux/tree/virtio-iommu-v0.9-iort-x86
> >>>> https://github.com/eauger/qemu/tree/v3.1.0-rc3-virtio-iommu-v0.9-x86
> >>>>
> >>>> There ACPI IORT was built for PC machine and the integration effort at
> >>>> both kernel and QEMU level was low. This work would need to be rebased
> >>>> and depends on kernel ACPI related patches that are not yet upstreamed
> >>>> though.
> >>>>
> >>>> Thanks
> >>>>
> >>>> Eric
> >>>
> >>> In the end it might turn out you are right.  But it does us no harm to
> >>> delay this just a bit, and for now limit things to ARM where it's
> >>> already used and where alternatives exist.
> >> So if my understanding is correct, at the moment you would accept a DT
> >> integration using MMIO. Is that correct? Meanwhile we can prototype your
> >> suggestion.
> >>
> >> Thanks
> >>
> >> Eric
> > 
> > Right.
> 
> Thank you for the confirmation. However I am not sure Peter will accept
> to get the device integrated as a virtio-mmio device and then deprecated
> in favor of a virtio-pci device, all the more so work was prepared to
> get a PCI integration. Peter?
> 
> Thanks
> 
> Eric
> > 
> >>>
> >>>
> >>>>>
> >>>>>> ---
> >>>>>>
> >>>>>> v8 -> v9:
> >>>>>> - add the msi-bypass property
> >>>>>> - create virtio-iommu-pci.c
> >>>>>> ---
> >>>>>>  hw/virtio/Makefile.objs          |  1 +
> >>>>>>  hw/virtio/virtio-iommu-pci.c     | 88 ++++++++++++++++++++++++++++++++
> >>>>>>  include/hw/pci/pci.h             |  1 +
> >>>>>>  include/hw/virtio/virtio-iommu.h |  1 +
> >>>>>>  qdev-monitor.c                   |  1 +
> >>>>>>  5 files changed, 92 insertions(+)
> >>>>>>  create mode 100644 hw/virtio/virtio-iommu-pci.c
> >>>>>>
> >>>>>> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> >>>>>> index f42e4dd94f..80ca719f1c 100644
> >>>>>> --- a/hw/virtio/Makefile.objs
> >>>>>> +++ b/hw/virtio/Makefile.objs
> >>>>>> @@ -27,6 +27,7 @@ obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
> >>>>>>  obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
> >>>>>>  obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
> >>>>>>  obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
> >>>>>> +obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu-pci.o
> >>>>>>  obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
> >>>>>>  obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
> >>>>>>  obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
> >>>>>> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
> >>>>>> new file mode 100644
> >>>>>> index 0000000000..f9977096bd
> >>>>>> --- /dev/null
> >>>>>> +++ b/hw/virtio/virtio-iommu-pci.c
> >>>>>> @@ -0,0 +1,88 @@
> >>>>>> +/*
> >>>>>> + * Virtio IOMMU PCI Bindings
> >>>>>> + *
> >>>>>> + * Copyright (c) 2019 Red Hat, Inc.
> >>>>>> + * Written by Eric Auger
> >>>>>> + *
> >>>>>> + *  This program is free software; you can redistribute it and/or modify
> >>>>>> + *  it under the terms of the GNU General Public License version 2 or
> >>>>>> + *  (at your option) any later version.
> >>>>>> + */
> >>>>>> +
> >>>>>> +#include "qemu/osdep.h"
> >>>>>> +
> >>>>>> +#include "virtio-pci.h"
> >>>>>> +#include "hw/virtio/virtio-iommu.h"
> >>>>>> +
> >>>>>> +typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * virtio-iommu-pci: This extends VirtioPCIProxy.
> >>>>>> + *
> >>>>>> + */
> >>>>>> +#define VIRTIO_IOMMU_PCI(obj) \
> >>>>>> +        OBJECT_CHECK(VirtIOIOMMUPCI, (obj), TYPE_VIRTIO_IOMMU_PCI)
> >>>>>> +
> >>>>>> +struct VirtIOIOMMUPCI {
> >>>>>> +    VirtIOPCIProxy parent_obj;
> >>>>>> +    VirtIOIOMMU vdev;
> >>>>>> +};
> >>>>>> +
> >>>>>> +static Property virtio_iommu_pci_properties[] = {
> >>>>>> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> >>>>>> +    DEFINE_PROP_BOOL("msi-bypass", VirtIOIOMMUPCI, vdev.msi_bypass, true),
> >>>>>> +    DEFINE_PROP_END_OF_LIST(),
> >>>>>> +};
> >>>>>> +
> >>>>>> +static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >>>>>> +{
> >>>>>> +    VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(vpci_dev);
> >>>>>> +    DeviceState *vdev = DEVICE(&dev->vdev);
> >>>>>> +
> >>>>>> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> >>>>>> +    object_property_set_link(OBJECT(dev),
> >>>>>> +                             OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
> >>>>>> +                             "primary-bus", errp);
> >>>>>> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void virtio_iommu_pci_class_init(ObjectClass *klass, void *data)
> >>>>>> +{
> >>>>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
> >>>>>> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> >>>>>> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> >>>>>> +    k->realize = virtio_iommu_pci_realize;
> >>>>>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >>>>>> +    dc->props = virtio_iommu_pci_properties;
> >>>>>> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> >>>>>> +    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_IOMMU;
> >>>>>> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
> >>>>>> +    pcidev_k->class_id = PCI_CLASS_OTHERS;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void virtio_iommu_pci_instance_init(Object *obj)
> >>>>>> +{
> >>>>>> +    VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(obj);
> >>>>>> +
> >>>>>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> >>>>>> +                                TYPE_VIRTIO_IOMMU);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info = {
> >>>>>> +    .base_name             = TYPE_VIRTIO_IOMMU_PCI,
> >>>>>> +    .generic_name          = "virtio-iommu-pci",
> >>>>>> +    .transitional_name     = "virtio-iommu-pci-transitional",
> >>>>>> +    .non_transitional_name = "virtio-iommu-pci-non-transitional",
> >>>>>> +    .instance_size = sizeof(VirtIOIOMMUPCI),
> >>>>>> +    .instance_init = virtio_iommu_pci_instance_init,
> >>>>>> +    .class_init    = virtio_iommu_pci_class_init,
> >>>>>> +};
> >>>>>> +
> >>>>>> +static void virtio_iommu_pci_register(void)
> >>>>>> +{
> >>>>>> +    virtio_pci_types_register(&virtio_iommu_pci_info);
> >>>>>> +}
> >>>>>> +
> >>>>>> +type_init(virtio_iommu_pci_register)
> >>>>>> +
> >>>>>> +
> >>>>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> >>>>>> index aaf1b9f70d..492ea7e68d 100644
> >>>>>> --- a/include/hw/pci/pci.h
> >>>>>> +++ b/include/hw/pci/pci.h
> >>>>>> @@ -86,6 +86,7 @@ extern bool pci_available;
> >>>>>>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
> >>>>>>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
> >>>>>>  #define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
> >>>>>> +#define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1014
> >>>>>>  
> >>>>>>  #define PCI_VENDOR_ID_REDHAT             0x1b36
> >>>>>>  #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
> >>>>>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> >>>>>> index 56c8b4e57f..893ac65c0b 100644
> >>>>>> --- a/include/hw/virtio/virtio-iommu.h
> >>>>>> +++ b/include/hw/virtio/virtio-iommu.h
> >>>>>> @@ -25,6 +25,7 @@
> >>>>>>  #include "hw/pci/pci.h"
> >>>>>>  
> >>>>>>  #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
> >>>>>> +#define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-device-base"
> >>>>>>  #define VIRTIO_IOMMU(obj) \
> >>>>>>          OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
> >>>>>>  
> >>>>>> diff --git a/qdev-monitor.c b/qdev-monitor.c
> >>>>>> index 58222c2211..74cf090c61 100644
> >>>>>> --- a/qdev-monitor.c
> >>>>>> +++ b/qdev-monitor.c
> >>>>>> @@ -63,6 +63,7 @@ static const QDevAlias qdev_alias_table[] = {
> >>>>>>      { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_S390X },
> >>>>>>      { "virtio-input-host-pci", "virtio-input-host",
> >>>>>>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
> >>>>>> +    { "virtio-iommu-pci", "virtio-iommu", QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
> >>>>>>      { "virtio-keyboard-ccw", "virtio-keyboard", QEMU_ARCH_S390X },
> >>>>>>      { "virtio-keyboard-pci", "virtio-keyboard",
> >>>>>>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
> >>>>>> -- 
> >>>>>> 2.20.1
> >>>>>
> >>>

