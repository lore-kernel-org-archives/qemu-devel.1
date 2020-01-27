Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47CEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709A92071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pms+rELN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709A92071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2hn-0001wN-Ls
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iw2hD-0001RT-Df
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iw2hB-0003b8-Ab
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:36:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iw2hB-0003a7-3b
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580125004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=8OlYtc1vQUUgpmkAxgaPWVNdMf8nlbRlrTS5+ZwLwo0=;
 b=Pms+rELNrAtEVU2KBrB33PNaFAeunsddwulpiZSSGlr75a3sZ6FIoRx5BtUEZgqWSyzWcu
 cQRdxTJTM7n/q4SaumrGRVDZydogQbrHxYu2j4j2/gFa5I/CyCSGrT1aOfkLWHqbCBGk9c
 +WQzT0iKKoqFMxYSnENE7i0ZJauWIrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-wiyzKgeoM1yimxQVT1H11g-1; Mon, 27 Jan 2020 06:36:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32D48107ACC5;
 Mon, 27 Jan 2020 11:36:39 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-94.ams2.redhat.com [10.36.117.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3E895D9C9;
 Mon, 27 Jan 2020 11:36:34 +0000 (UTC)
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e0d193cc-ca9b-bcdb-df7c-87ac9ce8ec4a@redhat.com>
Date: Mon, 27 Jan 2020 12:36:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: wiyzKgeoM1yimxQVT1H11g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: borntraeger@de.ibm.com, rth@twiddle.net, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/01/2020 23.14, Collin Walling wrote:
> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
> be intercepted by SIE and handled via KVM. Let's introduce some
> functions to communicate between QEMU and KVM via ioctls. These
> will be used to get/set the diag318 information.
>=20
> The availability of this instruction is determined by byte 134, bit 0
> of the Read Info block. This coincidentally expands into the space used
> for CPU entries by taking away one byte, which means VMs running with
> the diag318 capability will not be able to retrieve information regarding
> the 248th CPU. This will not effect performance, and VMs can still be

s/effect/affect/ ?

> ran with 248 CPUs.

s/ran/run/ ?

> In order to simplify the migration and system reset requirements of
> the diag318 data, let's introduce it as a device class and include
> a VMStateDescription.
>=20
> Diag318 is set to 0 during modified clear and load normal resets.
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  hw/s390x/Makefile.objs              |  1 +
>  hw/s390x/diag318.c                  | 85 +++++++++++++++++++++++++++++++=
++++++
>  hw/s390x/diag318.h                  | 40 +++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c          | 17 ++++++++
>  hw/s390x/sclp.c                     | 13 ++++++
>  include/hw/s390x/sclp.h             |  2 +
>  target/s390x/cpu_features.h         |  1 +
>  target/s390x/cpu_features_def.inc.h |  3 ++
>  target/s390x/gen-features.c         |  1 +
>  target/s390x/kvm-stub.c             | 10 +++++
>  target/s390x/kvm.c                  | 29 +++++++++++++
>  target/s390x/kvm_s390x.h            |  2 +
>  12 files changed, 204 insertions(+)
>  create mode 100644 hw/s390x/diag318.c
>  create mode 100644 hw/s390x/diag318.h
>=20
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index e02ed80..93621dc 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -34,3 +34,4 @@ obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o
>  obj-y +=3D s390-ccw.o
>  obj-y +=3D ap-device.o
>  obj-y +=3D ap-bridge.o
> +obj-y +=3D diag318.o
> diff --git a/hw/s390x/diag318.c b/hw/s390x/diag318.c
> new file mode 100644
> index 0000000..2d30bb2
> --- /dev/null
> +++ b/hw/s390x/diag318.c
> @@ -0,0 +1,85 @@
> +/*
> + * DIAGNOSE 0x318 functions for reset and migration
> + *
> + * Copyright IBM, Corp. 2019

Bump to 2020 ?

> + * Authors:
> + *  Collin Walling <walling@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t your
> + * option) any later version. See the COPYING file in the top-level dire=
ctory.
> + */
> +
> +#include "hw/s390x/diag318.h"
> +#include "qapi/error.h"
> +#include "kvm_s390x.h"
> +#include "sysemu/kvm.h"
> +
> +static int diag318_post_load(void *opaque, int version_id)
> +{
> +    DIAG318State *d =3D opaque;
> +
> +    if (kvm_enabled())
> +        kvm_s390_set_diag318_info(d->info);

QEMU coding style requires curly braces also for single lines.

> +    return 0;
> +}
> +
> +static int diag318_pre_save(void *opaque)
> +{
> +    DIAG318State *d =3D opaque;
> +
> +    if (kvm_enabled())
> +        kvm_s390_get_diag318_info(&d->info);

dito

> +    return 0;
> +}
> +
> +static bool diag318_needed(void *opaque)
> +{
> +    return kvm_enabled() ? s390_has_feat(S390_FEAT_DIAG318) : 0;
> +}
> +
> +const VMStateDescription vmstate_diag318 =3D {
> +    .name =3D "vmstate_diag318",
> +    .post_load =3D diag318_post_load,
> +    .pre_save =3D diag318_pre_save,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D diag318_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(info, DIAG318State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void s390_diag318_reset(DeviceState *dev)
> +{
> +    if (kvm_enabled())
> +        kvm_s390_set_diag318_info(0);

dito

> +}
> +
> +static void s390_diag318_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->reset =3D s390_diag318_reset;
> +    dc->vmsd =3D &vmstate_diag318;
> +    dc->hotpluggable =3D false;
> +    /* Reason: Created automatically during machine instantiation */
> +    dc->user_creatable =3D false;
> +}
> +
> +static const TypeInfo s390_diag318_info =3D {
> +    .class_init =3D s390_diag318_class_init,
> +    .parent =3D TYPE_DEVICE,
> +    .name =3D TYPE_S390_DIAG318,
> +    .instance_size =3D sizeof(DIAG318State),
> +};
> +
> +static void s390_diag318_register_types(void)
> +{
> +    type_register_static(&s390_diag318_info);
> +}
> +
> +type_init(s390_diag318_register_types)
> diff --git a/hw/s390x/diag318.h b/hw/s390x/diag318.h
> new file mode 100644
> index 0000000..06d9f67
> --- /dev/null
> +++ b/hw/s390x/diag318.h
> @@ -0,0 +1,40 @@
> +/*
> + * DIAGNOSE 0x318 functions for reset and migration
> + *
> + * Copyright IBM, Corp. 2019

2020 ?

> + * Authors:
> + *  Collin Walling <walling@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t your
> + * option) any later version. See the COPYING file in the top-level dire=
ctory.
> + */
> +
> +#ifndef HW_DIAG318_H
> +#define HW_DIAG318_H
> +
> +#include "qemu/osdep.h"
> +#include "migration/vmstate.h"
> +#include "qom/object.h"
> +#include "hw/qdev-core.h"
> +
> +#define TYPE_S390_DIAG318 "diag318"
> +#define DIAG318(obj) \
> +    OBJECT_CHECK(DIAG318State, (obj), TYPE_S390_DIAG318)
> +
> +typedef struct DIAG318State {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    uint64_t info;
> +} DIAG318State;
> +
> +typedef struct DIAG318Class {
> +    /*< private >*/
> +    DeviceClass parent_class;
> +
> +    /*< public >*/
> +} DIAG318Class;

You don't use DIAG318Class anywhere. Please drop it.

> +#endif /* HW_DIAG318_H */
> \ No newline at end of file
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e0e2813..d5b7a33 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -41,6 +41,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/s390x/tod.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/s390x/diag318.h"
> =20
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> @@ -97,6 +98,7 @@ static const char *const reset_dev_types[] =3D {
>      "s390-sclp-event-facility",
>      "s390-flic",
>      "diag288",
> +    TYPE_S390_DIAG318,
>  };
> =20
>  static void subsystem_reset(void)
> @@ -237,6 +239,17 @@ static void s390_create_sclpconsole(const char *type=
, Chardev *chardev)
>      qdev_init_nofail(dev);
>  }
> =20
> +static void s390_init_diag318(void)
> +{
> +    Object *new =3D object_new(TYPE_S390_DIAG318);

For the very unlikely case that we ever switch QEMU to C++ ... could you
maybe use a different variable name than "new" ? Simply "obj" maybe?

> +    DeviceState *dev =3D DEVICE(new);
> +
> +    object_property_add_child(qdev_get_machine(), TYPE_S390_DIAG318,
> +                              new, NULL);
> +    object_unref(new);
> +    qdev_init_nofail(dev);
> +}
> +

 Thomas


