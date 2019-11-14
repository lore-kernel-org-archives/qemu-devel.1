Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846BCC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536C2206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/+qiS0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536C2206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCWx-0001hh-HV
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iVCWK-0001F9-Jt
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iVCWJ-0008Hf-1N
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:38:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iVCWI-0008HT-UA
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573727914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9H/vsiZjCx8pUyXCv8d8yJsEGJ4ywO3WWmG01J/SJLU=;
 b=L/+qiS0+/0VfLFHLKah1z/3/PDhJ2YPRCDNdBaJdDmRDaNthnOGHOibIWroNxo/NJFu+k4
 bcPy9LJ7fFnJszwDOixDongTmF2t5bRFIqlBPeCsV4hdqegv9Y9AcaHfAP2GGhqjHLbB1P
 oXUOHMlqUUdFdUatA14gq6gHfDdrQLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-j_6aqM7mPpW4dfLM5r6ISA-1; Thu, 14 Nov 2019 05:38:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 074DB1005513;
 Thu, 14 Nov 2019 10:38:30 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF153601B8;
 Thu, 14 Nov 2019 10:38:25 +0000 (UTC)
Date: Thu, 14 Nov 2019 11:38:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v1] s390x: kvm-unit-tests: a PONG device for Sub
 Channels tests
Message-ID: <20191114113823.5d752648.cohuck@redhat.com>
In-Reply-To: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
References: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: j_6aqM7mPpW4dfLM5r6ISA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: thuth@redhat.com, qemu-s390x@nongnu.org, david@redhat.com,
 qemu-devel@nongnu.org, frankja@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 Nov 2019 20:02:33 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

Minor nit for $SUBJECT: this isn't a kvm-unit-tests patch, that's just
one consumer :)

> The PONG device accept two commands: PONG_READ and PONG_WRITE
> which allow to read from and write to an internal buffer of
> 1024 bytes.
>=20
> The QEMU device is named ccw-pong.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/s390x/Makefile.objs  |   1 +
>  hw/s390x/ccw-pong.c     | 186 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/s390x/pong.h |  47 ++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 hw/s390x/ccw-pong.c
>  create mode 100644 include/hw/s390x/pong.h
>=20
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index ee91152..3a83438 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -32,6 +32,7 @@ obj-$(CONFIG_KVM) +=3D tod-kvm.o
>  obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
>  obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o s390-mchk.o
>  obj-y +=3D s390-ccw.o
> +obj-y +=3D ccw-pong.o

Not sure if unconditionally introducing a test device is a good idea.

>  obj-y +=3D ap-device.o
>  obj-y +=3D ap-bridge.o
>  obj-y +=3D s390-sei.o
> diff --git a/hw/s390x/ccw-pong.c b/hw/s390x/ccw-pong.c
> new file mode 100644
> index 0000000..e7439d5
> --- /dev/null
> +++ b/hw/s390x/ccw-pong.c
> @@ -0,0 +1,186 @@
> +/*
> + * CCW PING-PONG
> + *
> + * Copyright 2019 IBM Corp.
> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "cpu.h"
> +#include "exec/address-spaces.h"
> +#include "hw/s390x/css.h"
> +#include "hw/s390x/css-bridge.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/s390x/pong.h"
> +
> +#define PONG_BUF_SIZE 0x1000
> +static char buf[PONG_BUF_SIZE] =3D "Hello world\n";
> +
> +static inline int pong_rw(CCW1 *ccw, char *p, int len, bool dir)
> +{
> +    int ret;
> +
> +    ret =3D address_space_rw(&address_space_memory, ccw->cda,
> +                           MEMTXATTRS_UNSPECIFIED,
> +                           (unsigned char *)buf, len, dir);
> +
> +    return (ret =3D=3D MEMTX_OK) ? -EIO : 0;
> +}
> +
> +/* Handle READ ccw commands from guest */
> +static int handle_payload_read(CcwPONGDevice *dev, CCW1 *ccw)
> +{
> +    CcwDevice *ccw_dev =3D CCW_DEVICE(dev);
> +    int len;
> +
> +    if (!ccw->cda) {
> +        return -EFAULT;
> +    }
> +
> +    if (ccw->count > PONG_BUF_SIZE) {
> +        len =3D PONG_BUF_SIZE;
> +        ccw_dev->sch->curr_status.scsw.count =3D ccw->count - PONG_BUF_S=
IZE;
> +    } else {
> +        len =3D ccw->count;
> +        ccw_dev->sch->curr_status.scsw.count =3D 0;
> +    }
> +
> +    return pong_rw(ccw, buf, len, 1);
> +}
> +
> +/*
> + * Handle WRITE ccw commands to write data to client
> + * The SCSW count is set to the number of bytes not transfered.
> + */
> +static int handle_payload_write(CcwPONGDevice *dev, CCW1 *ccw)
> +{
> +    CcwDevice *ccw_dev =3D CCW_DEVICE(dev);
> +    int len;
> +
> +    if (!ccw->cda) {
> +        ccw_dev->sch->curr_status.scsw.count =3D ccw->count;
> +        return -EFAULT;
> +    }
> +
> +    if (ccw->count > PONG_BUF_SIZE) {
> +        len =3D PONG_BUF_SIZE;
> +        ccw_dev->sch->curr_status.scsw.count =3D ccw->count - PONG_BUF_S=
IZE;
> +    } else {
> +        len =3D ccw->count;
> +        ccw_dev->sch->curr_status.scsw.count =3D 0;
> +    }
> +
> +    return pong_rw(ccw, buf, len, 0);

Can you please use the dstream infrastructure for read/write handling?

You also seem to miss some basic checks e.g. for short reads/writes
with and without SLI set.

> +}
> +
> +static int pong_ccw_cb(SubchDev *sch, CCW1 ccw)
> +{
> +    int rc =3D 0;
> +    CcwPONGDevice *dev =3D sch->driver_data;
> +
> +    switch (ccw.cmd_code) {
> +    case PONG_WRITE:
> +        rc =3D handle_payload_write(dev, &ccw);
> +        break;
> +    case PONG_READ:
> +        rc =3D handle_payload_read(dev, &ccw);
> +        break;
> +    default:
> +        rc =3D -ENOSYS;
> +        break;
> +    }
> +
> +    if (rc =3D=3D -EIO) {
> +        /* I/O error, specific devices generate specific conditions */
> +        SCHIB *schib =3D &sch->curr_status;
> +
> +        sch->curr_status.scsw.dstat =3D SCSW_DSTAT_UNIT_CHECK;
> +        sch->sense_data[0] =3D 0x40;    /* intervention-req */

This is really odd. If it succeeds, you generate a unit check with
intervention required? Confused. At the very least, this requires some
description as to how this device is supposed to interact with the
driver.

> +        schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
> +        schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
> +        schib->scsw.ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY =
|
> +                   SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
> +    }
> +    return rc;
> +}
> +
> +static void pong_ccw_realize(DeviceState *ds, Error **errp)
> +{
> +    uint16_t chpid;
> +    CcwPONGDevice *dev =3D CCW_PONG(ds);
> +    CcwDevice *cdev =3D CCW_DEVICE(ds);
> +    CCWDeviceClass *cdk =3D CCW_DEVICE_GET_CLASS(cdev);
> +    SubchDev *sch;
> +    Error *err =3D NULL;
> +
> +    sch =3D css_create_sch(cdev->devno, errp);
> +    if (!sch) {
> +        return;
> +    }
> +
> +    sch->driver_data =3D dev;
> +    cdev->sch =3D sch;
> +    chpid =3D css_find_free_chpid(sch->cssid);
> +
> +    if (chpid > MAX_CHPID) {
> +        error_setg(&err, "No available chpid to use.");
> +        goto out_err;
> +    }
> +
> +    sch->id.reserved =3D 0xff;
> +    sch->id.cu_type =3D CCW_PONG_CU_TYPE;
> +    css_sch_build_virtual_schib(sch, (uint8_t)chpid,
> +                                CCW_PONG_CHPID_TYPE);
> +    sch->do_subchannel_work =3D do_subchannel_work_virtual;
> +    sch->ccw_cb =3D pong_ccw_cb;
> +
> +    cdk->realize(cdev, &err);
> +    if (err) {
> +        goto out_err;
> +    }
> +
> +    css_reset_sch(sch);
> +    return;
> +
> +out_err:
> +    error_propagate(errp, err);
> +    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL=
);
> +    cdev->sch =3D NULL;
> +    g_free(sch);
> +}
> +
> +static Property pong_ccw_properties[] =3D {
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pong_ccw_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->props =3D pong_ccw_properties;
> +    dc->bus_type =3D TYPE_VIRTUAL_CSS_BUS;
> +    dc->realize =3D pong_ccw_realize;
> +    dc->hotpluggable =3D false;
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);

Huh? misc seems like a better idea for this :)

> +}
> +
> +static const TypeInfo pong_ccw_info =3D {
> +    .name =3D TYPE_CCW_PONG,
> +    .parent =3D TYPE_CCW_DEVICE,
> +    .instance_size =3D sizeof(CcwPONGDevice),
> +    .class_init =3D pong_ccw_class_init,
> +    .class_size =3D sizeof(CcwPONGClass),
> +};
> +
> +static void pong_ccw_register(void)
> +{
> +    type_register_static(&pong_ccw_info);
> +}
> +
> +type_init(pong_ccw_register)

Some questions regarding this device and its intended usage:

- What are you trying to test? Basic ccw processing, or something more
  specific? Is there any way you can use the kvm-unit-test
  infrastructure to test basic processing with an existing device?
- Who is instantiating this device? Only the kvm-unit-test?
- Can you instantiate multiple instances? Does that make sense? If yes,
  it should probably not request a new chpid every time :)
- What happens if someone instantiates this by hand? The only drawback
  is that it uses up a subchannel and a chpid, right?
- Do you plan to make this hotpluggable later?


