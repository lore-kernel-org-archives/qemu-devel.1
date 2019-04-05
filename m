Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8892C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 21:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF4521726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 21:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF4521726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCWQp-0007fW-Dt
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 17:31:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hCWPk-0007Dk-Mo
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hCWPf-0000xA-6u
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:30:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hCWPe-0000lW-FH
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:30:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56239D56EF
	for <qemu-devel@nongnu.org>; Fri,  5 Apr 2019 21:30:12 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7380F1018A38;
	Fri,  5 Apr 2019 21:30:06 +0000 (UTC)
Date: Fri, 5 Apr 2019 18:30:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Yoni Bettan <ybettan@redhat.com>
Message-ID: <20190405213005.GA20799@habkost.net>
References: <20190401111843.54528-1-ybettan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190401111843.54528-1-ybettan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 05 Apr 2019 21:30:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC-PATCH] Introducing virtio-example device.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ailan@redhat.com, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405213005.wF8QCiCfwol68s3UN101rs2RQIRiuG1JmWiyNoIJQU4@z>

Hi,

Thanks for the patch, comments below:

On Mon, Apr 01, 2019 at 02:18:43PM +0300, Yoni Bettan wrote:
> The main goal is to add an example device to Qemu to be used as template or
> guideline for contributors when they wish to create a new virtio device.
> 
> Another reason for this device is to document "the right way" to write
> a new virtio device in Qemu.
> 
> This device is a simple device and its functionality is to increase its input
> by 1.

I believe we need a clearer description of what the device does,
especially considering that you are using base 10 strings as
input and output.

(See additional comments about the string conversion below)

> 
> The device driver is located at:
> https://github.com/ybettan/QemuDeviceDrivers.git
> 
> In addition I am writing a blog to give a logical overview of the virtio
> protocol and a step-by-step guide to write a new virtio device.
> This blog can be found at https://howtovms.wordpress.com.
> 
> scripts/checkpatch.pl have some errors do to "//" (old style one line comment),
> those lines contains FIXMEs for the next version and will be removed.
> 
> Signed-off-by: Yoni Bettan <ybettan@redhat.com>
> ---
>  hw/virtio/Makefile.objs                       |   1 +
>  hw/virtio/virtio-example.c                    | 121 ++++++++++++++++++
>  hw/virtio/virtio-pci.c                        |  49 +++++++
>  hw/virtio/virtio-pci.h                        |  14 ++
>  include/hw/pci/pci.h                          |   1 +
>  include/hw/virtio/virtio-example.h            |  31 +++++
>  .../standard-headers/linux/virtio_example.h   |   8 ++
>  include/standard-headers/linux/virtio_ids.h   |   1 +
>  8 files changed, 226 insertions(+)
>  create mode 100644 hw/virtio/virtio-example.c
>  create mode 100644 include/hw/virtio/virtio-example.h
>  create mode 100644 include/standard-headers/linux/virtio_example.h
> 
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 1b2799cfd8..7a6fb2505c 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -7,6 +7,7 @@ common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
>  common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
>  obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
>  obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
> +obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-example.o
>  obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
>  
>  obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
> diff --git a/hw/virtio/virtio-example.c b/hw/virtio/virtio-example.c
> new file mode 100644
> index 0000000000..3c170f8022
> --- /dev/null
> +++ b/hw/virtio/virtio-example.c
> @@ -0,0 +1,121 @@
> +/*
> + * A virtio device example.
> + *
> + * Copyright 2019 Red Hat, Inc.
> + * Copyright 2019 Yoni Bettan <ybettan@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/iov.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-example.h"
> +
> +#define MAX_DATA_SIZE 10
> +
> +
> +/*
> + * this function is called when the driver 'kick' the virtqueue.
> + * since we can have more than 1 virtqueue we need the vq argument in order to
> + * know which one was kicked by the driver.
> + */
> +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtQueueElement *elem;
> +    int data, len;
> +    char buf[MAX_DATA_SIZE];
> +
> +    /* check that virtqueue have at least 2 elements, input and output */
> +    //FIXME: implement
> +
> +    /* get the virtqueue input element sent from the driver */
> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +
> +    /* read the input element (sg) into a buffer */
> +    len = iov_to_buf(elem->in_sg, elem->out_num, 0, buf, MAX_DATA_SIZE);

I believe you mean elem->in_num above.


> +    //FIXME: should i check buffer overflow, or iov_to_buf() is safe ?

If iov_to_buf() didn't check the buffer size, checking it after
it returned would be too late.

> +    if (len > MAX_DATA_SIZE) {
> +        goto error;
> +    }
> +
> +    /* process the data */
> +    data = atoi(buf);

What if there's no null terminator on the input buffer?

> +    sprintf(buf, "%d", ++data);

MAX_DATA_SIZE is 10, so if input data is "999999999" you will
write beyond the end of the buffer.

I suggest not dealing with the complexity of string conversion,
and just do something simpler (like increasing every byte by 1).


> +
> +    /* get the virtqueue output element sent from the driver */
> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));

I don't understand why you are using two separate buffers here.
A single request may contain both input and output buffers.

Also, I believe there's a risk here that the device will see the
input buffer before the output buffer is added to the queue by
the guest.


> +
> +    /* write the result to the output element (sg) */
> +    len = iov_from_buf(elem->in_sg, elem->in_num, 0, buf, MAX_DATA_SIZE);

Why are you writing to in_sg instead of out_sg?

> +    //FIXME: should i check buffer overflow, or iov_from_buf() is safe ?
> +
> +    /* push back the result into the virtqueue */
> +    virtqueue_push(vq, elem, /*len=*/1);

I suggest removing the "len=" comment in the next version.

> +
> +    /* interrupt the driver */
> +    virtio_notify(vdev, vq);

These last two lines look right, but I would like somebody who
works on virtio drivers to confirm.

> +
> +    return;
> +
> +error:
> +    printf("ERROR: buffer overflow\n");
> +    //FIXME: can we make the request fail ?, if iov_*_buf is safe we don't need it

I suggest simply dropping the data if there's no room on the
output buffer.  This way there's no need for any error handling.

> +}
> +
> +/*
> + * There is no currently defined feature bits, we still need this function
> + * because the backend driver checks that VirtioDeviceClass.get_features is
> + * initialized
> + */

Maybe we should explain what get_features() does and why, as this
is an example device implementation.

> +static uint64_t get_features(VirtIODevice *vdev, uint64_t features, Error **errp)
> +{
> +    return features;
> +}
> +
> +static void virtio_example_device_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VirtIOEXAMPLE *vexmp = VIRTIO_EXAMPLE(dev);
> +
> +    /* base class initialization */

I'm not sure "base class initialization" is an accurate
description of virtio_init().  Maybe the comment makes it more
confusing.

> +    virtio_init(vdev, "virtio-example", VIRTIO_ID_EXAMPLE, /*config_size=*/0);

I suggest removing the "config_size=" comment in the next
version.

> +
> +    /* this device suppot 1 virtqueue */
> +    vexmp->vq = virtio_add_queue(vdev, 8, handle_input);
> +}
> +
> +static void virtio_example_device_unrealize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +
> +    /* base class cleanup */
> +    virtio_cleanup(vdev);
> +}
> +
> +static void virtio_example_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    vdc->realize = virtio_example_device_realize;
> +    vdc->unrealize = virtio_example_device_unrealize;
> +    vdc->get_features = get_features;
> +}
> +
> +static const TypeInfo virtio_example_info = {
> +    .name = TYPE_VIRTIO_EXAMPLE,
> +    .parent = TYPE_VIRTIO_DEVICE,
> +    .instance_size = sizeof(VirtIOEXAMPLE),
> +    .class_init = virtio_example_class_init,
> +};
> +
> +static void virtio_register_types(void)
> +{
> +    type_register_static(&virtio_example_info);
> +}
> +
> +type_init(virtio_register_types)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 3a01fe90f0..99fc6ce79b 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2521,6 +2521,54 @@ static const TypeInfo virtio_rng_pci_info = {
>      .class_init    = virtio_rng_pci_class_init,
>  };
>  
> +/* virtio-example-pci */
> +
> +static void virtio_example_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VirtIOExamplePCI *vexmp = VIRTIO_EXAMPLE_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&vexmp->vdev);
> +    Error *err = NULL;
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }

The 5 lines above can be replaced by:

    object_property_set_bool(OBJECT(vdev), true, "realized", errp);

> +
> +}
> +
> +static void virtio_example_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +
> +    k->realize = virtio_example_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_EXAMPLE;
> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id = PCI_CLASS_OTHERS;
> +}
> +
> +static void virtio_example_initfn(Object *obj)
> +{
> +    VirtIOExamplePCI *dev = VIRTIO_EXAMPLE_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_EXAMPLE);
> +}
> +
> +static const TypeInfo virtio_example_pci_info = {
> +    .name          = TYPE_VIRTIO_EXAMPLE_PCI,
> +    .parent        = TYPE_VIRTIO_PCI,
> +    .instance_size = sizeof(VirtIOExamplePCI),
> +    .instance_init = virtio_example_initfn,
> +    .class_init    = virtio_example_pci_class_init,
> +};
> +
>  /* virtio-input-pci */
>  
>  static Property virtio_input_pci_properties[] = {
> @@ -2693,6 +2741,7 @@ static const TypeInfo virtio_pci_bus_info = {
>  static void virtio_pci_register_types(void)
>  {
>      type_register_static(&virtio_rng_pci_info);
> +    type_register_static(&virtio_example_pci_info);
>      type_register_static(&virtio_input_pci_info);
>      type_register_static(&virtio_input_hid_pci_info);
>      type_register_static(&virtio_keyboard_pci_info);
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 813082b0d7..db3f5ec17d 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -19,6 +19,7 @@
>  #include "hw/virtio/virtio-blk.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "hw/virtio/virtio-rng.h"
> +#include "hw/virtio/virtio-example.h"
>  #include "hw/virtio/virtio-serial.h"
>  #include "hw/virtio/virtio-scsi.h"
>  #include "hw/virtio/virtio-balloon.h"
> @@ -51,6 +52,7 @@ typedef struct VHostSCSIPCI VHostSCSIPCI;
>  typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
>  typedef struct VHostUserBlkPCI VHostUserBlkPCI;
>  typedef struct VirtIORngPCI VirtIORngPCI;
> +typedef struct VirtIOExamplePCI VirtIOExamplePCI;
>  typedef struct VirtIOInputPCI VirtIOInputPCI;
>  typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
>  typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
> @@ -339,6 +341,18 @@ struct VirtIORngPCI {
>      VirtIORNG vdev;
>  };
>  
> +/*
> + * virtio-example-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_EXAMPLE_PCI "virtio-example-pci"
> +#define VIRTIO_EXAMPLE_PCI(obj) \
> +        OBJECT_CHECK(VirtIOExamplePCI, (obj), TYPE_VIRTIO_EXAMPLE_PCI)
> +
> +struct VirtIOExamplePCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIOEXAMPLE vdev;
> +};
> +
>  /*
>   * virtio-input-pci: This extends VirtioPCIProxy.
>   */
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 990d6fcbde..c69d5997b7 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -83,6 +83,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_VIRTIO_CONSOLE     0x1003
>  #define PCI_DEVICE_ID_VIRTIO_SCSI        0x1004
>  #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
> +#define PCI_DEVICE_ID_VIRTIO_EXAMPLE     0x1006 //FIXME: update to valid ID

I'm not sure what to do about the device ID here.  Should we really allocate a
device ID for this example device?


>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
>  
> diff --git a/include/hw/virtio/virtio-example.h b/include/hw/virtio/virtio-example.h
> new file mode 100644
> index 0000000000..c08db28e8f
> --- /dev/null
> +++ b/include/hw/virtio/virtio-example.h
> @@ -0,0 +1,31 @@
> +/*
> + * Virtio EXAMPLE Support
> + *
> + * Copyright Red Hat, Inc. 2019
> + * Copyright Yoni Bettan <ybettan@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#ifndef QEMU_VIRTIO_EXAMPLE_H
> +#define QEMU_VIRTIO_EXAMPLE_H
> +
> +#include "standard-headers/linux/virtio_example.h"
> +
> +#define TYPE_VIRTIO_EXAMPLE "virtio-example-device"
> +#define VIRTIO_EXAMPLE(obj) \
> +        OBJECT_CHECK(VirtIOEXAMPLE, (obj), TYPE_VIRTIO_EXAMPLE)
> +#define VIRTIO_EXAMPLE_GET_PARENT_CLASS(obj) \
> +        OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_EXAMPLE)
> +
> +typedef struct VirtIOEXAMPLE {
> +    VirtIODevice parent_obj;
> +
> +    /* Only one vq - guest puts buffer(s) on it when it needs computation */
> +    VirtQueue *vq;
> +
> +} VirtIOEXAMPLE;
> +
> +#endif
> diff --git a/include/standard-headers/linux/virtio_example.h b/include/standard-headers/linux/virtio_example.h
> new file mode 100644
> index 0000000000..6321c60c5c
> --- /dev/null
> +++ b/include/standard-headers/linux/virtio_example.h
> @@ -0,0 +1,8 @@
> +#ifndef _LINUX_VIRTIO_EXAMPLE_H
> +#define _LINUX_VIRTIO_EXAMPLE_H
> +/* This header is BSD licensed so anyone can use the definitions to implement
> + * compatible drivers/servers. */
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "standard-headers/linux/virtio_config.h"
> +
> +#endif /* _LINUX_VIRTIO_EXAMPLE_H */
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index 6d5c3b2d4f..30c189303b 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -43,5 +43,6 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_EXAMPLE      21 /* virtio example */
>  

Same question about device ID here.  Should we really allocate a device ID for
this example device?

Also, standard-headers is supposed to be copied from the Linux source tree, and
not touched by any patch except when running update-linux-headers.sh.

-- 
Eduardo

