Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC838C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2F520665
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2F520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsXvC-00036P-S6
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 15:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58286)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsXuj-0002bn-7y
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsXuh-00081m-RM
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:36:01 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsXuh-00081Q-Mm
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:35:59 -0400
Received: by mail-vs1-f67.google.com with SMTP id 190so44414114vsf.9
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 12:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KoB+W5mDl+LcNp17jNhxXbUNUrzulxs7NMBGX8YpGQc=;
 b=GjNT7yqh3weema8pixw3tIaPYC706O7PQJvCWRWAcJQ+g8DOSEPILxxlqjofvpYk5w
 DAQPafDp82lqCTi8Q4km/K2oPMAJ47Ixqi1SgEn8Cfz7wtcuzYUVtF7LNXKCTbGOKZff
 hu4MoYKb7y4ZjrGG0wf1mJtoVI2XAimaY5mtf8+OIUuhxSHHFM5BbTptkG1Nw0evG6p+
 /ZE5hZy96kwx33cmrv1RDw9ZpWEMzfqy4Q4if2l8oCQiYuTM5Tf9T4lH6nMMqWKPtbjf
 Vls7orzVG0kjnny1Kn2O4XJYiTKV3Hexv5ARweNPgMXIuZ3SGHv1mbR1BtXEkOqLHtHx
 iTeg==
X-Gm-Message-State: APjAAAX7Yg/QHsCDCYodII2AtAcOb+owDbQDPaNG911mRrUY+IrQ+7jr
 ihdcFY3QqVlrKjN6fO6wn/5KXA==
X-Google-Smtp-Source: APXvYqxUhyalh/JP8D5YxNe7klJhqqoxhRfT0Gx28XIoomnMM7ql9OQapZmalcg9/PbPDtHkWFiEIA==
X-Received: by 2002:a67:9946:: with SMTP id b67mr76996454vse.37.1564515358745; 
 Tue, 30 Jul 2019 12:35:58 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 y71sm15103383vsc.19.2019.07.30.12.35.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 12:35:57 -0700 (PDT)
Date: Tue, 30 Jul 2019 15:35:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190730153305-mutt-send-email-mst@kernel.org>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-15-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730172137.23114-15-eric.auger@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.217.67
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

On Tue, Jul 30, 2019 at 07:21:36PM +0200, Eric Auger wrote:
> This patch adds virtio-iommu-pci, which is the pci proxy for
> the virtio-iommu device.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

This part I'm not sure we should merge just yet.  The reason being I
think we should limit it to mmio where DT can be used to describe iommu
topology. For PCI I don't see why we shouldn't always expose this
in the config space, and I think it's preferable not to
need to support a mix of DT,ACPI and PCI as options.

> ---
> 
> v8 -> v9:
> - add the msi-bypass property
> - create virtio-iommu-pci.c
> ---
>  hw/virtio/Makefile.objs          |  1 +
>  hw/virtio/virtio-iommu-pci.c     | 88 ++++++++++++++++++++++++++++++++
>  include/hw/pci/pci.h             |  1 +
>  include/hw/virtio/virtio-iommu.h |  1 +
>  qdev-monitor.c                   |  1 +
>  5 files changed, 92 insertions(+)
>  create mode 100644 hw/virtio/virtio-iommu-pci.c
> 
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index f42e4dd94f..80ca719f1c 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -27,6 +27,7 @@ obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
>  obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-pci.o
>  obj-$(CONFIG_VIRTIO_RNG) += virtio-rng-pci.o
>  obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon-pci.o
> +obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu-pci.o
>  obj-$(CONFIG_VIRTIO_9P) += virtio-9p-pci.o
>  obj-$(CONFIG_VIRTIO_SCSI) += virtio-scsi-pci.o
>  obj-$(CONFIG_VIRTIO_BLK) += virtio-blk-pci.o
> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
> new file mode 100644
> index 0000000000..f9977096bd
> --- /dev/null
> +++ b/hw/virtio/virtio-iommu-pci.c
> @@ -0,0 +1,88 @@
> +/*
> + * Virtio IOMMU PCI Bindings
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + * Written by Eric Auger
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or
> + *  (at your option) any later version.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "virtio-pci.h"
> +#include "hw/virtio/virtio-iommu.h"
> +
> +typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
> +
> +/*
> + * virtio-iommu-pci: This extends VirtioPCIProxy.
> + *
> + */
> +#define VIRTIO_IOMMU_PCI(obj) \
> +        OBJECT_CHECK(VirtIOIOMMUPCI, (obj), TYPE_VIRTIO_IOMMU_PCI)
> +
> +struct VirtIOIOMMUPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIOIOMMU vdev;
> +};
> +
> +static Property virtio_iommu_pci_properties[] = {
> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> +    DEFINE_PROP_BOOL("msi-bypass", VirtIOIOMMUPCI, vdev.msi_bypass, true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_link(OBJECT(dev),
> +                             OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
> +                             "primary-bus", errp);
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +}
> +
> +static void virtio_iommu_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +    k->realize = virtio_iommu_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->props = virtio_iommu_pci_properties;
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_IOMMU;
> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id = PCI_CLASS_OTHERS;
> +}
> +
> +static void virtio_iommu_pci_instance_init(Object *obj)
> +{
> +    VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_IOMMU);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info = {
> +    .base_name             = TYPE_VIRTIO_IOMMU_PCI,
> +    .generic_name          = "virtio-iommu-pci",
> +    .transitional_name     = "virtio-iommu-pci-transitional",
> +    .non_transitional_name = "virtio-iommu-pci-non-transitional",
> +    .instance_size = sizeof(VirtIOIOMMUPCI),
> +    .instance_init = virtio_iommu_pci_instance_init,
> +    .class_init    = virtio_iommu_pci_class_init,
> +};
> +
> +static void virtio_iommu_pci_register(void)
> +{
> +    virtio_pci_types_register(&virtio_iommu_pci_info);
> +}
> +
> +type_init(virtio_iommu_pci_register)
> +
> +
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index aaf1b9f70d..492ea7e68d 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -86,6 +86,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
>  #define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
> +#define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1014
>  
>  #define PCI_VENDOR_ID_REDHAT             0x1b36
>  #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index 56c8b4e57f..893ac65c0b 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -25,6 +25,7 @@
>  #include "hw/pci/pci.h"
>  
>  #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
> +#define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-device-base"
>  #define VIRTIO_IOMMU(obj) \
>          OBJECT_CHECK(VirtIOIOMMU, (obj), TYPE_VIRTIO_IOMMU)
>  
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 58222c2211..74cf090c61 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -63,6 +63,7 @@ static const QDevAlias qdev_alias_table[] = {
>      { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_S390X },
>      { "virtio-input-host-pci", "virtio-input-host",
>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
> +    { "virtio-iommu-pci", "virtio-iommu", QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
>      { "virtio-keyboard-ccw", "virtio-keyboard", QEMU_ARCH_S390X },
>      { "virtio-keyboard-pci", "virtio-keyboard",
>              QEMU_ARCH_ALL & ~QEMU_ARCH_S390X },
> -- 
> 2.20.1

