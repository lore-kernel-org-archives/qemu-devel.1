Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3984C47256
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA50207DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn7Tr9nB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA50207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWPF9-0005kI-M2
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jWPEZ-0005KF-Eg; Wed, 06 May 2020 14:57:31 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jWPEX-0006VT-Vy; Wed, 06 May 2020 14:57:30 -0400
Received: by mail-wm1-x341.google.com with SMTP id 188so3710559wmc.2;
 Wed, 06 May 2020 11:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WVXFa/Ih8rhQRBzuo6JtPiH45Ty8rPU5DLOU2EGBzig=;
 b=Rn7Tr9nBLuXRSd6jud3gci9DBsFUfdSUupgw/VnvsFn6RntPjO4dfFR7jDbhy3jn7s
 0gQi6/YhBMueg8mGnnf/eixavS7YSw9sgYT/t3NHN+YtAlM3KGmpA2qyiNfQO81/Gtrb
 vdOYlZ7uYObGMeX3dBm0nHF/Am1dP9FIA1OLg+io+H6LiIxpdNVZ/8RBDs2XvHJii2Zp
 /AtoHb6M9ThEQaglfMLdXZTrQrz0y5ciKCOy/IzqpDbXMJdIBU+GsLraspg8zFYwsQZJ
 NTW46hDQOyfZP+c1xP6wg7TZM61wR7QyGvlH5sEzV0QAtCIGj12QngO6x16dW8e+xGLv
 THNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WVXFa/Ih8rhQRBzuo6JtPiH45Ty8rPU5DLOU2EGBzig=;
 b=g52OLRO1GOgpuAIdKJIZeJs1bhHa44KxgSGmh47gF9JJeOQKS8IjrWJTbneQe4VIrl
 5lOQh95f2+QQzYo4d/bK3ooyX8QvSW16XZKWoTFT44YUnO8Qh9p3GS6fgmiy/gkjf2b7
 MbmJCjt2rX0QuA2PdTaQ1k0j3toBmaAA07jEDEa9utyXCIcgU8e18T8SkTlj1POw7S9a
 Ce+LAYiKVwrIGPAzidwa6ShXT/6QJctuVxwUchrPpqrfLbbsi6b3u3hBzWCNhh7c6dBb
 /S9NzPyGbFi7K1ivFnYi3eerTrtOT5aLJiV0EdQ1+PO31WszPb0GIU8LbejKbKGgVZon
 nNMA==
X-Gm-Message-State: AGi0PuZb4A++N0dHjrEUf5LbjEvcQ4csvswSqqQR3k8u+87LrGynX61b
 7zR/FjWf3q2VgXCEy0lQyNnPZxLZl8ASWL6MLy8=
X-Google-Smtp-Source: APiQypLhcud8MP8CSdZJaxnEHMHoAmtleMZUO8gIQZY5EYQVFvnEPMt4xGby0ZFI+FIzZSM1C7WN8zKj1wjI8z2AGh4=
X-Received: by 2002:a1c:3c08:: with SMTP id j8mr5917736wma.30.1588791447879;
 Wed, 06 May 2020 11:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200506094948.76388-1-david@redhat.com>
 <20200506094948.76388-12-david@redhat.com>
In-Reply-To: <20200506094948.76388-12-david@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 6 May 2020 20:57:16 +0200
Message-ID: <CAM9Jb+g-mFxY+seJAPcpdavSW-_XicFbq+xfk6nis4otUQZ4VQ@mail.gmail.com>
Subject: Re: [PATCH v1 11/17] virtio-pci: Proxy for virtio-mem
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Let's add a proxy for virtio-mem, make it a memory device, and
> pass-through the properties.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/Makefile.objs    |   1 +
>  hw/virtio/virtio-mem-pci.c | 131 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-mem-pci.h |  33 ++++++++++
>  include/hw/pci/pci.h       |   1 +
>  4 files changed, 166 insertions(+)
>  create mode 100644 hw/virtio/virtio-mem-pci.c
>  create mode 100644 hw/virtio/virtio-mem-pci.h
>
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 7df70e977e..b9661f9c01 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -19,6 +19,7 @@ obj-$(call land,$(CONFIG_VHOST_USER_FS),$(CONFIG_VIRTIO_PCI)) += vhost-user-fs-p
>  obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
>  obj-$(CONFIG_VIRTIO_MEM) += virtio-mem.o
> +common-obj-$(call land,$(CONFIG_VIRTIO_MEM),$(CONFIG_VIRTIO_PCI)) += virtio-mem-pci.o
>
>  ifeq ($(CONFIG_VIRTIO_PCI),y)
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
> diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
> new file mode 100644
> index 0000000000..a47d21c81f
> --- /dev/null
> +++ b/hw/virtio/virtio-mem-pci.c
> @@ -0,0 +1,131 @@
> +/*
> + * Virtio MEM PCI device
> + *
> + * Copyright (C) 2020 Red Hat, Inc.
> + *
> + * Authors:
> + *  David Hildenbrand <david@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
Don't think we need the blank line here.

> +#include "virtio-mem-pci.h"
> +#include "hw/mem/memory-device.h"
> +#include "qapi/error.h"
> +
> +static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VirtIOMEMPCI *mem_pci = VIRTIO_MEM_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&mem_pci->vdev);
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +}
> +
> +static void virtio_mem_pci_set_addr(MemoryDeviceState *md, uint64_t addr,
> +                                    Error **errp)
> +{
> +    object_property_set_uint(OBJECT(md), addr, VIRTIO_MEM_ADDR_PROP, errp);
> +}
> +
> +static uint64_t virtio_mem_pci_get_addr(const MemoryDeviceState *md)
> +{
> +    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_ADDR_PROP,
> +                                    &error_abort);
> +}
> +
> +static MemoryRegion *virtio_mem_pci_get_memory_region(MemoryDeviceState *md,
> +                                                      Error **errp)
> +{
> +    VirtIOMEMPCI *pci_mem = VIRTIO_MEM_PCI(md);
> +    VirtIOMEM *vmem = VIRTIO_MEM(&pci_mem->vdev);
> +    VirtIOMEMClass *vmc = VIRTIO_MEM_GET_CLASS(vmem);
> +
> +    return vmc->get_memory_region(vmem, errp);
> +}
> +
> +static uint64_t virtio_mem_pci_get_plugged_size(const MemoryDeviceState *md,
> +                                                Error **errp)
> +{
> +    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_SIZE_PROP,
> +                                    errp);
> +}
> +
> +static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *md,
> +                                            MemoryDeviceInfo *info)
> +{
> +    VirtioMEMDeviceInfo *vi = g_new0(VirtioMEMDeviceInfo, 1);
> +    VirtIOMEMPCI *pci_mem = VIRTIO_MEM_PCI(md);
> +    VirtIOMEM *vmem = VIRTIO_MEM(&pci_mem->vdev);
> +    VirtIOMEMClass *vpc = VIRTIO_MEM_GET_CLASS(vmem);
> +    DeviceState *dev = DEVICE(md);
> +
> +    if (dev->id) {
> +        vi->has_id = true;
> +        vi->id = g_strdup(dev->id);
> +    }
> +
> +    /* let the real device handle everything else */
> +    vpc->fill_device_info(vmem, vi);
> +
> +    info->u.virtio_mem.data = vi;
> +    info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;
> +}
> +
> +static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(klass);
> +
> +    k->realize = virtio_mem_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_MEM;
> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id = PCI_CLASS_OTHERS;
> +
> +    mdc->get_addr = virtio_mem_pci_get_addr;
> +    mdc->set_addr = virtio_mem_pci_set_addr;
> +    mdc->get_plugged_size = virtio_mem_pci_get_plugged_size;
> +    mdc->get_memory_region = virtio_mem_pci_get_memory_region;
> +    mdc->fill_device_info = virtio_mem_pci_fill_device_info;
> +}
> +
> +static void virtio_mem_pci_instance_init(Object *obj)
> +{
> +    VirtIOMEMPCI *dev = VIRTIO_MEM_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_MEM);
> +    object_property_add_alias(obj, VIRTIO_MEM_BLOCK_SIZE_PROP,
> +                              OBJECT(&dev->vdev),
> +                              VIRTIO_MEM_BLOCK_SIZE_PROP, &error_abort);
> +    object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
> +                              VIRTIO_MEM_SIZE_PROP, &error_abort);
> +    object_property_add_alias(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP,
> +                              OBJECT(&dev->vdev),
> +                              VIRTIO_MEM_REQUESTED_SIZE_PROP, &error_abort);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_mem_pci_info = {
> +    .base_name = TYPE_VIRTIO_MEM_PCI,
> +    .generic_name = "virtio-mem-pci",
> +    .instance_size = sizeof(VirtIOMEMPCI),
> +    .instance_init = virtio_mem_pci_instance_init,
> +    .class_init = virtio_mem_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_MEMORY_DEVICE },
> +        { }
> +    },
> +};
> +
> +static void virtio_mem_pci_register_types(void)
> +{
> +    virtio_pci_types_register(&virtio_mem_pci_info);
> +}
> +type_init(virtio_mem_pci_register_types)
> diff --git a/hw/virtio/virtio-mem-pci.h b/hw/virtio/virtio-mem-pci.h
> new file mode 100644
> index 0000000000..8820cd6628
> --- /dev/null
> +++ b/hw/virtio/virtio-mem-pci.h
> @@ -0,0 +1,33 @@
> +/*
> + * Virtio MEM PCI device
> + *
> + * Copyright (C) 2020 Red Hat, Inc.
> + *
> + * Authors:
> + *  David Hildenbrand <david@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_VIRTIO_MEM_PCI_H
> +#define QEMU_VIRTIO_MEM_PCI_H
> +
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-mem.h"
> +
> +typedef struct VirtIOMEMPCI VirtIOMEMPCI;
> +
> +/*
> + * virtio-mem-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_MEM_PCI "virtio-mem-pci-base"
> +#define VIRTIO_MEM_PCI(obj) \
> +        OBJECT_CHECK(VirtIOMEMPCI, (obj), TYPE_VIRTIO_MEM_PCI)
> +
> +struct VirtIOMEMPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIOMEM vdev;
> +};
> +
> +#endif /* QEMU_VIRTIO_MEM_PCI_H */
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index cfedf5a995..fec72d5a31 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -87,6 +87,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
>  #define PCI_DEVICE_ID_VIRTIO_PMEM        0x1013
>  #define PCI_DEVICE_ID_VIRTIO_IOMMU       0x1014
> +#define PCI_DEVICE_ID_VIRTIO_MEM         0x1015
>
>  #define PCI_VENDOR_ID_REDHAT             0x1b36
>  #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
> --
> 2.25.3
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

