Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBFBC4CECD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 01:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B6C214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 01:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B6C214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAOlr-0005WX-RB
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 21:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <piaojun@huawei.com>) id 1iAOlA-00056g-GR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1iAOl8-0007Xy-Tr
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:27:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44822 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1iAOl8-0007PD-HS
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 21:27:54 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A04F9DAE9B97BE82940F;
 Wed, 18 Sep 2019 09:27:45 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Sep 2019
 09:27:41 +0800
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 <qemu-devel@nongnu.org>, <cohuck@redhat.com>, <mst@redhat.com>
References: <20190917160057.11847-1-dgilbert@redhat.com>
 <20190917160057.11847-4-dgilbert@redhat.com>
From: piaojun <piaojun@huawei.com>
Message-ID: <5D8187F9.1090303@huawei.com>
Date: Wed, 18 Sep 2019 09:27:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190917160057.11847-4-dgilbert@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: Re: [Qemu-devel] [PATCH v3 3/3] virtio: add vhost-user-fs-pci device
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
Cc: mszeredi@redhat.com, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/9/18 0:00, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add the PCI version of vhost-user-fs.
> 
> Launch QEMU like this:
> 
>   qemu -chardev socket,path=/tmp/vhost-fs.sock,id=chr0
>        -device x-vhost-user-fs-pci,tag=myfs,chardev=chr0
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/virtio/Makefile.objs       |  1 +
>  hw/virtio/vhost-user-fs-pci.c | 85 +++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>  create mode 100644 hw/virtio/vhost-user-fs-pci.c
> 
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 47ffbf22c4..e2f70fbb89 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -15,6 +15,7 @@ obj-$(CONFIG_VHOST_USER_FS) += vhost-user-fs.o
>  obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
>  obj-$(CONFIG_VIRTIO_PMEM) += virtio-pmem.o
>  common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) += virtio-pmem-pci.o
> +obj-$(call land,$(CONFIG_VHOST_USER_FS),$(CONFIG_VIRTIO_PCI)) += vhost-user-fs-pci.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
>  
>  ifeq ($(CONFIG_VIRTIO_PCI),y)
> diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
> new file mode 100644
> index 0000000000..0e70985094
> --- /dev/null
> +++ b/hw/virtio/vhost-user-fs-pci.c
> @@ -0,0 +1,85 @@
> +/*
> + * Vhost-user filesystem virtio device PCI glue
> + *
> + * Copyright 2018-2019 Red Hat, Inc.
> + *
> + * Authors:
> + *  Dr. David Alan Gilbert <dgilbert@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/virtio/vhost-user-fs.h"
> +#include "virtio-pci.h"
> +
> +struct VHostUserFSPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VHostUserFS vdev;
> +};
> +
> +typedef struct VHostUserFSPCI VHostUserFSPCI;
> +
> +#define TYPE_VHOST_USER_FS_PCI "vhost-user-fs-pci-base"
> +
> +#define VHOST_USER_FS_PCI(obj) \
> +        OBJECT_CHECK(VHostUserFSPCI, (obj), TYPE_VHOST_USER_FS_PCI)
> +
> +static Property vhost_user_fs_pci_properties[] = {
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VHostUserFSPCI *dev = VHOST_USER_FS_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +
> +    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors = dev->vdev.conf.num_request_queues + 1;
> +    }
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +}
> +
> +static void vhost_user_fs_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +    k->realize = vhost_user_fs_pci_realize;
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    dc->props = vhost_user_fs_pci_properties;
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */

Why not set *PCI_DEVICE_ID_VIRTIO_FS* here just like virtio_blk? I'm
not very familiar with this code, and just compare it with the other
same logic.

Thanks,
Jun

