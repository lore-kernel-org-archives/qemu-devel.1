Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911DEC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FAE20843
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVQ1QDjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FAE20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34271 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQqT7-00007m-BF
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 05:45:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQqRz-00084n-36
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQqRw-0006zV-Fh
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:43:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hQqRw-0006x1-3h
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:43:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id w12so1912025wrp.2
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 02:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=DBCye91eFpFo5v2P+tmiMTOILEzmw7YTqXwXSbkfqeU=;
	b=WVQ1QDjnl47GMloSH5/Lqg8jeK6oW2p5BVtEBzcJp3ftBXT1tQxAMrKQ+nJdknJJGC
	2XxQLt6hLZPuQd6424fSDiQmNSAw7rPRxKUBxnmIPyQoFlyEAWfIL5sWgTfWYlGQdTi4
	1mQTZSZDoRPZPHtxsOmaDBu+uc825wMBpa2COuStT/+eVI2UjUzNvi+J/4dSkkTWTEhw
	1W1rhZ4XRJe+/TFgPnFNk6qK2GUytE3QCTuPcZ9FpLnQARnqJ+b73rzqkufIlU4UJldy
	c4fkpqeYknZpdPsnYanDtYdG5TyN2kOnYy1b1AYEhnRhYarK8emWf2UgnBqtzmilpTv+
	fjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=DBCye91eFpFo5v2P+tmiMTOILEzmw7YTqXwXSbkfqeU=;
	b=kAZPIbkafa4gRm4HQp6dTzzU9ae9xuboJg4gniP2qraqW04Y0TriORxq+PuwHDUQHq
	N5PXAnVfEFHNCwrULos4lqAG/u+ecVVB/ifqYsDU7vZOKlGiCzwtxURDBFCh9r0MOqSc
	/hZELvZjyc1+NEsGB4FuUZdRb9fsZkkNO0o/7M6fGpR+2ijUCqHcRQ7FOvEwKcnTO4wl
	3znMl/w9kmjdX4GqEtEhNWopLI+uJIZHiYpbNrh1Bh9+5m2k4A0ouZnJkukcfsMNlhJw
	bR2cG+G/2w9Wyph9bV1NjXzTXGVw35kbRxKaVIUQujFMZfN+xiq7Ly7EqrMhery7iCvH
	b3HA==
X-Gm-Message-State: APjAAAWum8iBUzMpqvCZOgpzBg405jtQgnjLuCqHKSwReuCaVoA96VLY
	AJe0EVRIq6TS0B8i+LVXT14=
X-Google-Smtp-Source: APXvYqyC3BJhuD5ggP8cqCqlpAlmoQj+mwV6xOadgU1gwP/xxog7MU3hQPd+CjsL7ctbY85oJUrbuw==
X-Received: by 2002:adf:fb09:: with SMTP id c9mr22202811wrr.137.1557913426132; 
	Wed, 15 May 2019 02:43:46 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	j131sm2518867wmb.9.2019.05.15.02.43.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 02:43:45 -0700 (PDT)
Date: Wed, 15 May 2019 10:43:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Yoni Bettan <ybettan@redhat.com>
Message-ID: <20190515094344.GA29507@stefanha-x1.localdomain>
References: <20190428132631.37430-1-ybettan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20190428132631.37430-1-ybettan@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH V1] Introducing virtio-example.
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ailan@redhat.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2019 at 04:26:31PM +0300, Yoni Bettan wrote:
> The main goal is to create an example to be used as template or
> guideline for contributors when they wish to create a new virtio
> device and to document "the right way" to do so.
>=20
> It consists of several parts:
>=20
>     1. The device specification
>         * it can be found in the device header
>         * it will hopefully be added to the official virtio specification
>=20
>     2. The device implementation for Qemu-KVM hypervisor
>         * this patch content
>=20
>     3. The device driver for linux
>         * it will hopefully be added to linux
>         * for now it can be found at https://github.com/ybettan/\
>                 QemuDeviceDrivers/blob/master/virtio/virtio_example_drive=
r.c
>=20
>     4. A blog on virtio
>         * introducing the virtio concept
>         * gives some motivation for virtio-devices to be used
>         * bring extra documentation on "how to write":
>             - device specification
>             - device implementation
>             - device driver for linux
>         * it can be found at https://howtovms.wordpress.com
>=20
> Signed-off-by: Yoni Bettan <ybettan@redhat.com>
> ---

Existing VIRTIO devices provide plenty of examples of how to implement
device emulation and guest drivers.  This device is trivial and doesn't
address the interesting decisions that device designers face.  Its
usefulness is limited.  I don't think it should go into the spec, Linux,
or QEMU.

The following areas would be more helpful than an example device:

 * Expanding "Appendix B. Creating New Device Types" in the spec:
   https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.htm=
l#x1-444000B

 * A code commentary of an existing device like virtio-net or
   virtio-scsi since they are non-trivial.  That would be a good fit for
   a series of blog posts.

 * Improving the doc comments in Linux and QEMU.

>=20
> RFC -> V1:
>    =20
>     * Updated the commit message to be more informative about the full
>       working flow.
>=20
>     * Added the device specification to the device header.
>=20
>     * Removed the PCI-ID given for the device.
>       This was done by forcing the device to be in modern-only mode there=
fore
>       the PCI-ID is now generated automatically.
>    =20
>     * Made all requests consist of both input and output buffer instead
>       of separating them into 2 different requests.
>=20
>     * Made the device IO deal with integers instead of strings.
>       The user have read/write access to the device using sysfs,
>       therefore the driver's input are strings, in the RFC version
>       those strings where passed directly to the device and the integer
>       conversion was done inside the device, now the driver is handling t=
hose
>       conversions and the device is unaware of them.
>=20
>     * Added more documentation for the get_features() function.
>=20
>     * Simplified the error propagation in virtio_example_pci_realize()
>       function.
>=20
>     * Removed all code of previous previous patch from standard-headers.
>=20
>=20
>  hw/virtio/Makefile.objs            |   1 +
>  hw/virtio/virtio-example.c         | 110 +++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c             |  47 ++++++++++++
>  hw/virtio/virtio-pci.h             |  14 ++++
>  include/hw/virtio/virtio-example.h |  92 ++++++++++++++++++++++++
>  5 files changed, 264 insertions(+)
>  create mode 100644 hw/virtio/virtio-example.c
>  create mode 100644 include/hw/virtio/virtio-example.h
>=20
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 1b2799cfd8..7a6fb2505c 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -7,6 +7,7 @@ common-obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-pci.o
>  common-obj-$(CONFIG_VIRTIO_MMIO) +=3D virtio-mmio.o
>  obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-balloon.o
>  obj-$(CONFIG_VIRTIO_CRYPTO) +=3D virtio-crypto.o
> +obj-$(CONFIG_VIRTIO_CRYPTO) +=3D virtio-example.o

CRYPTO? :)

>  obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) +=3D virti=
o-crypto-pci.o
> =20
>  obj-$(CONFIG_LINUX) +=3D vhost.o vhost-backend.o vhost-user.o
> diff --git a/hw/virtio/virtio-example.c b/hw/virtio/virtio-example.c
> new file mode 100644
> index 0000000000..fd72f7c3a5
> --- /dev/null
> +++ b/hw/virtio/virtio-example.c
> @@ -0,0 +1,110 @@
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
> +
> +/*
> + * this function is called when the driver 'kick' the virtqueue.
> + * since we can have more than 1 virtqueue we need the vq argument in or=
der to
> + * know which one was kicked by the driver.
> + */
> +static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtQueueElement *elem;
> +    int data;
> +
> +    /*
> +     * get the virtqueue element sent from the driver.
> +     * in_sg are the driver inputs (device outputs)
> +     * out_sg are the driver output (device input)
> +     */
> +    elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));

virtqueue_pop() can fail.  The NULL return value must be handled.

> +
> +    /* read the driver output sg (device input sg) into a buffer */
> +    iov_to_buf(elem->out_sg, elem->out_num, 0, &data, sizeof(int));
> +
> +    /* process the data */
> +    data++;
> +
> +    /* write the result to the driver input sg (device output sg) */
> +    iov_from_buf(elem->in_sg, elem->in_num, 0, &data, sizeof(int));

This exposes uninitialized stack memory from QEMU to the guest when
elem->out_num =3D 0 or the buffer is smaller than sizeof(int).  This is a
security bug.

To avoid it, handle iov_to_buf() failure with virtio_error() and return
early.  The device will be left in the "broken" state and further
operation will fail (e.g. virtqueue_pop() will fail until the next
device reset).

> +
> +    /* push back the result into the virtqueue */
> +    virtqueue_push(vq, elem, 1);

Why 1?  Normally this is the number of bytes transferred so it should be
sizeof(int).

> +
> +    /* interrupt the driver */
> +    virtio_notify(vdev, vq);
> +
> +    return;
> +}
> +
> +/*
> + * This function gets the host features as a parameter and add to it all=
 the
> + * features supported by the device.
> + * This example-device has no currently defined feature bits but we stil=
l need
> + * this function because when a device is plugged this function is calle=
d to
> + * check the features offer by the device so it must exist and return the
> + * host features without any change.
> + */
> +static uint64_t
> +get_features(VirtIODevice *vdev, uint64_t features, Error **errp)
> +{
> +    return features;
> +}
> +
> +static void virtio_example_device_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIOEXAMPLE *vexmp =3D VIRTIO_EXAMPLE(dev);
> +
> +    /* common virtio device initialization */
> +    virtio_init(vdev, "virtio-example", VIRTIO_ID_EXAMPLE, 0);
> +
> +    /* this device suppot 1 virtqueue */
> +    vexmp->vq =3D virtio_add_queue(vdev, 1, handle_input);
> +}
> +
> +static void virtio_example_device_unrealize(DeviceState *dev, Error **er=
rp)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +
> +    /* common virtio device cleanup */
> +    virtio_cleanup(vdev);
> +}
> +
> +static void virtio_example_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    vdc->realize =3D virtio_example_device_realize;
> +    vdc->unrealize =3D virtio_example_device_unrealize;
> +    vdc->get_features =3D get_features;
> +}
> +
> +static const TypeInfo virtio_example_info =3D {
> +    .name =3D TYPE_VIRTIO_EXAMPLE,
> +    .parent =3D TYPE_VIRTIO_DEVICE,
> +    .instance_size =3D sizeof(VirtIOEXAMPLE),
> +    .class_init =3D virtio_example_class_init,
> +};
> +
> +static void virtio_register_types(void)
> +{
> +    type_register_static(&virtio_example_info);
> +}
> +
> +type_init(virtio_register_types)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 3a01fe90f0..36333168ad 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2521,6 +2521,52 @@ static const TypeInfo virtio_rng_pci_info =3D {
>      .class_init    =3D virtio_rng_pci_class_init,
>  };
> =20
> +/* virtio-example-pci */
> +
> +static void virtio_example_pci_realize(VirtIOPCIProxy *vpci_dev, Error *=
*errp)
> +{
> +    VirtIOExamplePCI *vexmp =3D VIRTIO_EXAMPLE_PCI(vpci_dev);
> +    DeviceState *vdev =3D DEVICE(&vexmp->vdev);
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    /*
> +     * force modern-only mode on the device, now a PCI-ID will be genera=
ted
> +     * automatically according to the VIRTIO-ID.
> +     */
> +    virtio_pci_force_virtio_1(vpci_dev);
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +}
> +
> +static void virtio_example_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> +
> +    k->realize =3D virtio_example_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +
> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id =3D PCI_CLASS_OTHERS;
> +}
> +
> +static void virtio_example_initfn(Object *obj)
> +{
> +    VirtIOExamplePCI *dev =3D VIRTIO_EXAMPLE_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_EXAMPLE);
> +}
> +
> +static const TypeInfo virtio_example_pci_info =3D {
> +    .name          =3D TYPE_VIRTIO_EXAMPLE_PCI,
> +    .parent        =3D TYPE_VIRTIO_PCI,
> +    .instance_size =3D sizeof(VirtIOExamplePCI),
> +    .instance_init =3D virtio_example_initfn,
> +    .class_init    =3D virtio_example_pci_class_init,
> +};
> +
>  /* virtio-input-pci */
> =20
>  static Property virtio_input_pci_properties[] =3D {
> @@ -2693,6 +2739,7 @@ static const TypeInfo virtio_pci_bus_info =3D {
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
> =20
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
> diff --git a/include/hw/virtio/virtio-example.h b/include/hw/virtio/virti=
o-example.h
> new file mode 100644
> index 0000000000..48397af4e1
> --- /dev/null
> +++ b/include/hw/virtio/virtio-example.h
> @@ -0,0 +1,92 @@
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
> +
> +/*
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> + *                             Device specification
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> + *
> + * 5.2 Example Device
> + *
> + * The virtio example device is a simple virtual block device. Read and =
write
> + * requests are placed in the queue, and serviced (probably out of order=
) by
> + * the device except where noted.

This was copy-pasted from virtio-blk and does not accurately describe
this example device.

> + *
> + * 5.2.1 Device ID
> + *
> + * 21

A new ID is probably required.  See the latest ID requests on the virtio
mailing list.

> + *
> + * 5.2.2 Virtqueues
> + *
> + * 0 requestq
> + *
> + * 5.2.3 Feature bits
> + *
> + * None currently defined.
> + *
> + * 5.2.4 Device configuration layout
> + *
> + * None currently defined.
> + *
> + * 5.2.5 Device Initialization
> + *
> + * 1. The virtqueue is initialized.
> + *
> + * 5.2.6 Device Operation
> + *
> + * When the driver need computation, it places a request that consist of=
 both
> + * input and output buffer into the queue.
> + * The first buffer is used as an input for the device and contain a sin=
gle
> + * integer, represented by 4 or 8 bytes (depends on the architecture), a=
nd the
> + * second is given for the device to fill the result in it.

Modern VIRTIO devices have a well-defined ABI and do not contain
architecture-dependent data layout (with few exceptions).  An example
device should demonstrate this by using a little-endian 4-byte integer.

> + *
> + * The device is increasing this integer by 1, meaning the LSB will be
> + * increased by 1 and if needed the carry will be carried to the next by=
te.
> + *
> + * If the device get a number that is out of the range of an integer onl=
y the
> + * lower bytes that fit the size of an integer will represent the input =
and the
> + * upper bytes will be ignored.
> + * If the result is out of range then only the lower bytes will be writt=
en as
> + * result as well.
> + *
> + * 5.2.6.1 Driver Requirements: Device Operation
> + *
> + * The driver MUST place the 2 buffers in the same request in order to m=
ake a
> + * request atomically handled by the device, the first buffer contains t=
he
> + * input and should be read-only and the second should be empty and writ=
e-only.

Please use the terminology from the specification:
s/buffer/element/

Here is the definition from 3.2.1.1 Placing Buffers Into The Descriptor
Table:
"A buffer consists of zero or more device-readable physically-contiguous
elements followed by zero or more physically-contiguous device-writable
elements (each has at least one element)."

In other words, a "buffer" is an entire request-response and consists of
a scatter-gather list of driver->device and device->driver "elements".

> + *
> + * 5.2.6.2 Device Requirements: Device Operation
> + *
> + * The device MUST place the result inside the output buffer allocated b=
y the
> + * driver.
> + */
> +
> +#ifndef QEMU_VIRTIO_EXAMPLE_H
> +#define QEMU_VIRTIO_EXAMPLE_H
> +
> +#define VIRTIO_ID_EXAMPLE 21
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
> +    /* Only one vq - guest puts buffer(s) on it when it needs computatio=
n */
> +    VirtQueue *vq;
> +
> +} VirtIOEXAMPLE;
> +
> +#endif
> --=20
> 2.17.2
>=20

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzb308ACgkQnKSrs4Gr
c8jU5ggAwJQoCoZ4YrQod1/lDblNY2Q34+lM2iXyViHYOWCKpGLJ84uxdcfPqawW
YU9r6MwapNv5N+cFNcv1RIRF4iEap4R4TZ3xY+xwY0Tksozb3iWWJ1PL7/bmQIqL
7jbTRM9r4HssTnFJpQfCLbcoij8rliqIgLhF4GcMGcVb1U5wKtc1jJCeBcorHsf+
yaxDUNzHSa8WvNSI59zEZbdY9sohKhJZAQRZtp5wZxZs9v0CK5d+Mmz7ud6+xhi4
604bkyFXbz6G1CA4V9Ftdqd7YwOxEtHzCY0GkttCST8zKxP6TmrIyoo0hHt27gXR
ZdKRZDDFXV7N6SBUjH3JyqtZVB9TnA==
=mi2f
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--

