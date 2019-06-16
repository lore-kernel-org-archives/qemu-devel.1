Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C7EC31E49
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 12:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1451620870
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 12:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1451620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39366 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcTuN-0005xD-Rm
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 08:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36825)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ybettan@redhat.com>) id 1hcTtK-0005Ue-IT
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 08:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ybettan@redhat.com>) id 1hcTtH-0004Ik-J2
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 08:04:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1hcTtH-0004FI-Au
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 08:04:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so6292967wmj.5
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 05:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=y8QzB3LuLQCdvdIWSm4r/RN5vS0V3LP+3vtC3sRlbRQ=;
 b=gIAMjBRJ9lLRZyO2WW9JXpRZkH/Vuyq/txCMKZqQOBWWYJAsVto1H/ADqsNNL5RP1f
 sNgVxrbzc3cONKrybZpPc+yeSNFGnKm9SsQBqMV+b9mlknpgc4NRYadB5jOfp5APsxoE
 KfD8kTiU+HfffEuMDU5CNDaJ43tdKIT+TRbPdrw+503RWpiv/Tsz0MtoDijjW1heNqpU
 ixSuXeoFufKPDcHFrKe6+HIHh2PDuoRRb9G8YB3/+8aC2edp4R2tUdk4oozS+rChc8sf
 HF5A1Dv3CvFbEAdVuYVPaob4hxJhzZaFtpb0nVigyq8kaJOb16kVva/0u1DMaBe56wfV
 vhAw==
X-Gm-Message-State: APjAAAVj/5KfOuUGx3kaLMnMw0uepD7OSpbw3ZcbxN2a3d13WiQm4KeJ
 P27Meh3hIvMo3OMWnJwjUZsqdQ==
X-Google-Smtp-Source: APXvYqznFGCFXQNJrnLcwhqnVXNCTEnQ5UovifeSuxHvhUwznRHx2567882XSJyTcb6ERgKKvleGOg==
X-Received: by 2002:a1c:452:: with SMTP id 79mr15339343wme.149.1560686643973; 
 Sun, 16 Jun 2019 05:04:03 -0700 (PDT)
Received: from [10.201.132.176] (bzq-82-81-161-51.red.bezeqint.net.
 [82.81.161.51])
 by smtp.gmail.com with ESMTPSA id j18sm7546605wre.23.2019.06.16.05.04.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Jun 2019 05:04:03 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190428132631.37430-1-ybettan@redhat.com>
 <20190515094344.GA29507@stefanha-x1.localdomain>
From: Yoni Bettan <ybettan@redhat.com>
Message-ID: <d314afe9-9cfd-cba5-6aaf-ff632efb6180@redhat.com>
Date: Sun, 16 Jun 2019 15:04:01 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190515094344.GA29507@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH V1] Introducing virtio-example.
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ailan@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan and thank you for your review.

I am sorry for my late response, I have updated the specification 
according to your review (and Eduardo's review) and sent it to the 
virtio-comment mailing list.

On 5/15/19 12:43 PM, Stefan Hajnoczi wrote:
> On Sun, Apr 28, 2019 at 04:26:31PM +0300, Yoni Bettan wrote:
>> The main goal is to create an example to be used as template or
>> guideline for contributors when they wish to create a new virtio
>> device and to document "the right way" to do so.
>>
>> It consists of several parts:
>>
>>      1. The device specification
>>          * it can be found in the device header
>>          * it will hopefully be added to the official virtio specification
>>
>>      2. The device implementation for Qemu-KVM hypervisor
>>          * this patch content
>>
>>      3. The device driver for linux
>>          * it will hopefully be added to linux
>>          * for now it can be found at https://github.com/ybettan/\
>>                  QemuDeviceDrivers/blob/master/virtio/virtio_example_driver.c
>>
>>      4. A blog on virtio
>>          * introducing the virtio concept
>>          * gives some motivation for virtio-devices to be used
>>          * bring extra documentation on "how to write":
>>              - device specification
>>              - device implementation
>>              - device driver for linux
>>          * it can be found at https://howtovms.wordpress.com
>>
>> Signed-off-by: Yoni Bettan <ybettan@redhat.com>
>> ---
> Existing VIRTIO devices provide plenty of examples of how to implement
> device emulation and guest drivers.  This device is trivial and doesn't
> address the interesting decisions that device designers face.  Its
> usefulness is limited.  I don't think it should go into the spec, Linux,
> or QEMU.
>
> The following areas would be more helpful than an example device:
>
>   * Expanding "Appendix B. Creating New Device Types" in the spec:
>     https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-444000B
>
>   * A code commentary of an existing device like virtio-net or
>     virtio-scsi since they are non-trivial.  That would be a good fit for
>     a series of blog posts.
>
>   * Improving the doc comments in Linux and QEMU.
>
>> RFC -> V1:
>>      
>>      * Updated the commit message to be more informative about the full
>>        working flow.
>>
>>      * Added the device specification to the device header.
>>
>>      * Removed the PCI-ID given for the device.
>>        This was done by forcing the device to be in modern-only mode therefore
>>        the PCI-ID is now generated automatically.
>>      
>>      * Made all requests consist of both input and output buffer instead
>>        of separating them into 2 different requests.
>>
>>      * Made the device IO deal with integers instead of strings.
>>        The user have read/write access to the device using sysfs,
>>        therefore the driver's input are strings, in the RFC version
>>        those strings where passed directly to the device and the integer
>>        conversion was done inside the device, now the driver is handling those
>>        conversions and the device is unaware of them.
>>
>>      * Added more documentation for the get_features() function.
>>
>>      * Simplified the error propagation in virtio_example_pci_realize()
>>        function.
>>
>>      * Removed all code of previous previous patch from standard-headers.
>>
>>
>>   hw/virtio/Makefile.objs            |   1 +
>>   hw/virtio/virtio-example.c         | 110 +++++++++++++++++++++++++++++
>>   hw/virtio/virtio-pci.c             |  47 ++++++++++++
>>   hw/virtio/virtio-pci.h             |  14 ++++
>>   include/hw/virtio/virtio-example.h |  92 ++++++++++++++++++++++++
>>   5 files changed, 264 insertions(+)
>>   create mode 100644 hw/virtio/virtio-example.c
>>   create mode 100644 include/hw/virtio/virtio-example.h
>>
>> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
>> index 1b2799cfd8..7a6fb2505c 100644
>> --- a/hw/virtio/Makefile.objs
>> +++ b/hw/virtio/Makefile.objs
>> @@ -7,6 +7,7 @@ common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
>>   common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
>>   obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
>>   obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
>> +obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-example.o
> CRYPTO? :)
>
>>   obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
>>   
>>   obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>> diff --git a/hw/virtio/virtio-example.c b/hw/virtio/virtio-example.c
>> new file mode 100644
>> index 0000000000..fd72f7c3a5
>> --- /dev/null
>> +++ b/hw/virtio/virtio-example.c
>> @@ -0,0 +1,110 @@
>> +/*
>> + * A virtio device example.
>> + *
>> + * Copyright 2019 Red Hat, Inc.
>> + * Copyright 2019 Yoni Bettan <ybettan@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> + * (at your option) any later version.  See the COPYING file in the
>> + * top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/iov.h"
>> +#include "hw/virtio/virtio.h"
>> +#include "hw/virtio/virtio-example.h"
>> +
>> +
>> +/*
>> + * this function is called when the driver 'kick' the virtqueue.
>> + * since we can have more than 1 virtqueue we need the vq argument in order to
>> + * know which one was kicked by the driver.
>> + */
>> +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
>> +{
>> +    VirtQueueElement *elem;
>> +    int data;
>> +
>> +    /*
>> +     * get the virtqueue element sent from the driver.
>> +     * in_sg are the driver inputs (device outputs)
>> +     * out_sg are the driver output (device input)
>> +     */
>> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> virtqueue_pop() can fail.  The NULL return value must be handled.
>
>> +
>> +    /* read the driver output sg (device input sg) into a buffer */
>> +    iov_to_buf(elem->out_sg, elem->out_num, 0, &data, sizeof(int));
>> +
>> +    /* process the data */
>> +    data++;
>> +
>> +    /* write the result to the driver input sg (device output sg) */
>> +    iov_from_buf(elem->in_sg, elem->in_num, 0, &data, sizeof(int));
> This exposes uninitialized stack memory from QEMU to the guest when
> elem->out_num = 0 or the buffer is smaller than sizeof(int).  This is a
> security bug.
>
> To avoid it, handle iov_to_buf() failure with virtio_error() and return
> early.  The device will be left in the "broken" state and further
> operation will fail (e.g. virtqueue_pop() will fail until the next
> device reset).
>
>> +
>> +    /* push back the result into the virtqueue */
>> +    virtqueue_push(vq, elem, 1);
> Why 1?  Normally this is the number of bytes transferred so it should be
> sizeof(int).
>
>> +
>> +    /* interrupt the driver */
>> +    virtio_notify(vdev, vq);
>> +
>> +    return;
>> +}
>> +
>> +/*
>> + * This function gets the host features as a parameter and add to it all the
>> + * features supported by the device.
>> + * This example-device has no currently defined feature bits but we still need
>> + * this function because when a device is plugged this function is called to
>> + * check the features offer by the device so it must exist and return the
>> + * host features without any change.
>> + */
>> +static uint64_t
>> +get_features(VirtIODevice *vdev, uint64_t features, Error **errp)
>> +{
>> +    return features;
>> +}
>> +
>> +static void virtio_example_device_realize(DeviceState *dev, Error **errp)
>> +{
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +    VirtIOEXAMPLE *vexmp = VIRTIO_EXAMPLE(dev);
>> +
>> +    /* common virtio device initialization */
>> +    virtio_init(vdev, "virtio-example", VIRTIO_ID_EXAMPLE, 0);
>> +
>> +    /* this device suppot 1 virtqueue */
>> +    vexmp->vq = virtio_add_queue(vdev, 1, handle_input);
>> +}
>> +
>> +static void virtio_example_device_unrealize(DeviceState *dev, Error **errp)
>> +{
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +
>> +    /* common virtio device cleanup */
>> +    virtio_cleanup(vdev);
>> +}
>> +
>> +static void virtio_example_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
>> +
>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +    vdc->realize = virtio_example_device_realize;
>> +    vdc->unrealize = virtio_example_device_unrealize;
>> +    vdc->get_features = get_features;
>> +}
>> +
>> +static const TypeInfo virtio_example_info = {
>> +    .name = TYPE_VIRTIO_EXAMPLE,
>> +    .parent = TYPE_VIRTIO_DEVICE,
>> +    .instance_size = sizeof(VirtIOEXAMPLE),
>> +    .class_init = virtio_example_class_init,
>> +};
>> +
>> +static void virtio_register_types(void)
>> +{
>> +    type_register_static(&virtio_example_info);
>> +}
>> +
>> +type_init(virtio_register_types)
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index 3a01fe90f0..36333168ad 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -2521,6 +2521,52 @@ static const TypeInfo virtio_rng_pci_info = {
>>       .class_init    = virtio_rng_pci_class_init,
>>   };
>>   
>> +/* virtio-example-pci */
>> +
>> +static void virtio_example_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>> +{
>> +    VirtIOExamplePCI *vexmp = VIRTIO_EXAMPLE_PCI(vpci_dev);
>> +    DeviceState *vdev = DEVICE(&vexmp->vdev);
>> +
>> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
>> +    /*
>> +     * force modern-only mode on the device, now a PCI-ID will be generated
>> +     * automatically according to the VIRTIO-ID.
>> +     */
>> +    virtio_pci_force_virtio_1(vpci_dev);
>> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
>> +}
>> +
>> +static void virtio_example_pci_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
>> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
>> +
>> +    k->realize = virtio_example_pci_realize;
>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +
>> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
>> +    pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
>> +    pcidev_k->class_id = PCI_CLASS_OTHERS;
>> +}
>> +
>> +static void virtio_example_initfn(Object *obj)
>> +{
>> +    VirtIOExamplePCI *dev = VIRTIO_EXAMPLE_PCI(obj);
>> +
>> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
>> +                                TYPE_VIRTIO_EXAMPLE);
>> +}
>> +
>> +static const TypeInfo virtio_example_pci_info = {
>> +    .name          = TYPE_VIRTIO_EXAMPLE_PCI,
>> +    .parent        = TYPE_VIRTIO_PCI,
>> +    .instance_size = sizeof(VirtIOExamplePCI),
>> +    .instance_init = virtio_example_initfn,
>> +    .class_init    = virtio_example_pci_class_init,
>> +};
>> +
>>   /* virtio-input-pci */
>>   
>>   static Property virtio_input_pci_properties[] = {
>> @@ -2693,6 +2739,7 @@ static const TypeInfo virtio_pci_bus_info = {
>>   static void virtio_pci_register_types(void)
>>   {
>>       type_register_static(&virtio_rng_pci_info);
>> +    type_register_static(&virtio_example_pci_info);
>>       type_register_static(&virtio_input_pci_info);
>>       type_register_static(&virtio_input_hid_pci_info);
>>       type_register_static(&virtio_keyboard_pci_info);
>> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
>> index 813082b0d7..db3f5ec17d 100644
>> --- a/hw/virtio/virtio-pci.h
>> +++ b/hw/virtio/virtio-pci.h
>> @@ -19,6 +19,7 @@
>>   #include "hw/virtio/virtio-blk.h"
>>   #include "hw/virtio/virtio-net.h"
>>   #include "hw/virtio/virtio-rng.h"
>> +#include "hw/virtio/virtio-example.h"
>>   #include "hw/virtio/virtio-serial.h"
>>   #include "hw/virtio/virtio-scsi.h"
>>   #include "hw/virtio/virtio-balloon.h"
>> @@ -51,6 +52,7 @@ typedef struct VHostSCSIPCI VHostSCSIPCI;
>>   typedef struct VHostUserSCSIPCI VHostUserSCSIPCI;
>>   typedef struct VHostUserBlkPCI VHostUserBlkPCI;
>>   typedef struct VirtIORngPCI VirtIORngPCI;
>> +typedef struct VirtIOExamplePCI VirtIOExamplePCI;
>>   typedef struct VirtIOInputPCI VirtIOInputPCI;
>>   typedef struct VirtIOInputHIDPCI VirtIOInputHIDPCI;
>>   typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
>> @@ -339,6 +341,18 @@ struct VirtIORngPCI {
>>       VirtIORNG vdev;
>>   };
>>   
>> +/*
>> + * virtio-example-pci: This extends VirtioPCIProxy.
>> + */
>> +#define TYPE_VIRTIO_EXAMPLE_PCI "virtio-example-pci"
>> +#define VIRTIO_EXAMPLE_PCI(obj) \
>> +        OBJECT_CHECK(VirtIOExamplePCI, (obj), TYPE_VIRTIO_EXAMPLE_PCI)
>> +
>> +struct VirtIOExamplePCI {
>> +    VirtIOPCIProxy parent_obj;
>> +    VirtIOEXAMPLE vdev;
>> +};
>> +
>>   /*
>>    * virtio-input-pci: This extends VirtioPCIProxy.
>>    */
>> diff --git a/include/hw/virtio/virtio-example.h b/include/hw/virtio/virtio-example.h
>> new file mode 100644
>> index 0000000000..48397af4e1
>> --- /dev/null
>> +++ b/include/hw/virtio/virtio-example.h
>> @@ -0,0 +1,92 @@
>> +/*
>> + * Virtio EXAMPLE Support
>> + *
>> + * Copyright Red Hat, Inc. 2019
>> + * Copyright Yoni Bettan <ybettan@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> + * (at your option) any later version.  See the COPYING file in the
>> + * top-level directory.
>> + */
>> +
>> +
>> +/*
>> + * ============================================================================
>> + *                             Device specification
>> + * ============================================================================
>> + *
>> + * 5.2 Example Device
>> + *
>> + * The virtio example device is a simple virtual block device. Read and write
>> + * requests are placed in the queue, and serviced (probably out of order) by
>> + * the device except where noted.
> This was copy-pasted from virtio-blk and does not accurately describe
> this example device.
>
>> + *
>> + * 5.2.1 Device ID
>> + *
>> + * 21
> A new ID is probably required.  See the latest ID requests on the virtio
> mailing list.
>
>> + *
>> + * 5.2.2 Virtqueues
>> + *
>> + * 0 requestq
>> + *
>> + * 5.2.3 Feature bits
>> + *
>> + * None currently defined.
>> + *
>> + * 5.2.4 Device configuration layout
>> + *
>> + * None currently defined.
>> + *
>> + * 5.2.5 Device Initialization
>> + *
>> + * 1. The virtqueue is initialized.
>> + *
>> + * 5.2.6 Device Operation
>> + *
>> + * When the driver need computation, it places a request that consist of both
>> + * input and output buffer into the queue.
>> + * The first buffer is used as an input for the device and contain a single
>> + * integer, represented by 4 or 8 bytes (depends on the architecture), and the
>> + * second is given for the device to fill the result in it.
> Modern VIRTIO devices have a well-defined ABI and do not contain
> architecture-dependent data layout (with few exceptions).  An example
> device should demonstrate this by using a little-endian 4-byte integer.
>
>> + *
>> + * The device is increasing this integer by 1, meaning the LSB will be
>> + * increased by 1 and if needed the carry will be carried to the next byte.
>> + *
>> + * If the device get a number that is out of the range of an integer only the
>> + * lower bytes that fit the size of an integer will represent the input and the
>> + * upper bytes will be ignored.
>> + * If the result is out of range then only the lower bytes will be written as
>> + * result as well.
>> + *
>> + * 5.2.6.1 Driver Requirements: Device Operation
>> + *
>> + * The driver MUST place the 2 buffers in the same request in order to make a
>> + * request atomically handled by the device, the first buffer contains the
>> + * input and should be read-only and the second should be empty and write-only.
> Please use the terminology from the specification:
> s/buffer/element/
>
> Here is the definition from 3.2.1.1 Placing Buffers Into The Descriptor
> Table:
> "A buffer consists of zero or more device-readable physically-contiguous
> elements followed by zero or more physically-contiguous device-writable
> elements (each has at least one element)."
>
> In other words, a "buffer" is an entire request-response and consists of
> a scatter-gather list of driver->device and device->driver "elements".
>
>> + *
>> + * 5.2.6.2 Device Requirements: Device Operation
>> + *
>> + * The device MUST place the result inside the output buffer allocated by the
>> + * driver.
>> + */
>> +
>> +#ifndef QEMU_VIRTIO_EXAMPLE_H
>> +#define QEMU_VIRTIO_EXAMPLE_H
>> +
>> +#define VIRTIO_ID_EXAMPLE 21
>> +
>> +#define TYPE_VIRTIO_EXAMPLE "virtio-example-device"
>> +#define VIRTIO_EXAMPLE(obj) \
>> +        OBJECT_CHECK(VirtIOEXAMPLE, (obj), TYPE_VIRTIO_EXAMPLE)
>> +#define VIRTIO_EXAMPLE_GET_PARENT_CLASS(obj) \
>> +        OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_EXAMPLE)
>> +
>> +typedef struct VirtIOEXAMPLE {
>> +    VirtIODevice parent_obj;
>> +
>> +    /* Only one vq - guest puts buffer(s) on it when it needs computation */
>> +    VirtQueue *vq;
>> +
>> +} VirtIOEXAMPLE;
>> +
>> +#endif
>> -- 
>> 2.17.2
>>

