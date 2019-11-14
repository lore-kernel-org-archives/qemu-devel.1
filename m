Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F28C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 12:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADE620709
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 12:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXR90Obs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADE620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVEKa-0004Hf-2t
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 07:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iVEJR-0003V8-VB
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iVEJP-0007jY-N5
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:33:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58865
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iVEJP-0007i1-K3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573734802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eUtOATTOpM0HsoehESrNmMHioeExkEOVwZK4rLoGy1k=;
 b=VXR90ObsJWO+H2qTrD4SIGWwdLULAYgnAh0W63N1DVa1QDQgh5K2IR0tk7G/jw9YeI0W+L
 YS8iEPVWD/PmKBjFgkryQWacQMz7ABxuwBWDOvDDt4xm9E6xJtNBjLufH+CkKp1nbwNm5s
 OfTeg58434ZgLtrAGVpxQdiLLxSNB0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-ttsV_3YCOOq-9icbw9XxNg-1; Thu, 14 Nov 2019 07:33:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68E0810CE7B8;
 Thu, 14 Nov 2019 12:33:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-89.ams2.redhat.com
 [10.36.116.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3E2310013D9;
 Thu, 14 Nov 2019 12:33:14 +0000 (UTC)
Subject: Re: [PATCH v1] s390x: kvm-unit-tests: a PONG device for Sub Channels
 tests
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
 <20191114113823.5d752648.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b103f51b-f304-cf71-15f9-5fd456a6fcfe@redhat.com>
Date: Thu, 14 Nov 2019 13:33:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191114113823.5d752648.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ttsV_3YCOOq-9icbw9XxNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-s390x@nongnu.org, david@redhat.com, qemu-devel@nongnu.org,
 frankja@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/11/2019 11.38, Cornelia Huck wrote:
> On Wed, 13 Nov 2019 20:02:33 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
> Minor nit for $SUBJECT: this isn't a kvm-unit-tests patch, that's just
> one consumer :)
>=20
>> The PONG device accept two commands: PONG_READ and PONG_WRITE
>> which allow to read from and write to an internal buffer of
>> 1024 bytes.
>>
>> The QEMU device is named ccw-pong.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>  hw/s390x/Makefile.objs  |   1 +
>>  hw/s390x/ccw-pong.c     | 186 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/hw/s390x/pong.h |  47 ++++++++++++
>>  3 files changed, 234 insertions(+)
>>  create mode 100644 hw/s390x/ccw-pong.c
>>  create mode 100644 include/hw/s390x/pong.h
>>
>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index ee91152..3a83438 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_KVM) +=3D tod-kvm.o
>>  obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
>>  obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o s390-mchk.o
>>  obj-y +=3D s390-ccw.o
>> +obj-y +=3D ccw-pong.o
>=20
> Not sure if unconditionally introducing a test device is a good idea.

This definitely needs a CONFIG switch (which can be "y" by default, but
still we should provide a possibility to disable it)

>>  obj-y +=3D ap-device.o
>>  obj-y +=3D ap-bridge.o
>>  obj-y +=3D s390-sei.o
>> diff --git a/hw/s390x/ccw-pong.c b/hw/s390x/ccw-pong.c
>> new file mode 100644
>> index 0000000..e7439d5
>> --- /dev/null
>> +++ b/hw/s390x/ccw-pong.c
>> @@ -0,0 +1,186 @@
>> +/*
>> + * CCW PING-PONG

Please add a short description here what this device is all about.

>> + * Copyright 2019 IBM Corp.
>> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (=
at
>> + * your option) any later version. See the COPYING file in the top-leve=
l
>> + * directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu/module.h"
>> +#include "cpu.h"
>> +#include "exec/address-spaces.h"
>> +#include "hw/s390x/css.h"
>> +#include "hw/s390x/css-bridge.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/s390x/pong.h"
>> +
>> +#define PONG_BUF_SIZE 0x1000
>> +static char buf[PONG_BUF_SIZE] =3D "Hello world\n";
>> +
>> +static inline int pong_rw(CCW1 *ccw, char *p, int len, bool dir)
>> +{
>> +    int ret;
>> +
>> +    ret =3D address_space_rw(&address_space_memory, ccw->cda,
>> +                           MEMTXATTRS_UNSPECIFIED,
>> +                           (unsigned char *)buf, len, dir);
>> +
>> +    return (ret =3D=3D MEMTX_OK) ? -EIO : 0;

If return code was OK, then you return an EIO error? That looks weird?

>> +}
>> +
>> +/* Handle READ ccw commands from guest */
>> +static int handle_payload_read(CcwPONGDevice *dev, CCW1 *ccw)
>> +{
>> +    CcwDevice *ccw_dev =3D CCW_DEVICE(dev);
>> +    int len;
>> +
>> +    if (!ccw->cda) {
>> +        return -EFAULT;
>> +    }
>> +
>> +    if (ccw->count > PONG_BUF_SIZE) {
>> +        len =3D PONG_BUF_SIZE;
>> +        ccw_dev->sch->curr_status.scsw.count =3D ccw->count - PONG_BUF_=
SIZE;
>> +    } else {
>> +        len =3D ccw->count;
>> +        ccw_dev->sch->curr_status.scsw.count =3D 0;
>> +    }
>> +
>> +    return pong_rw(ccw, buf, len, 1);
>> +}
>> +
>> +/*
>> + * Handle WRITE ccw commands to write data to client
>> + * The SCSW count is set to the number of bytes not transfered.
>> + */
>> +static int handle_payload_write(CcwPONGDevice *dev, CCW1 *ccw)
>> +{
>> +    CcwDevice *ccw_dev =3D CCW_DEVICE(dev);
>> +    int len;
>> +
>> +    if (!ccw->cda) {
>> +        ccw_dev->sch->curr_status.scsw.count =3D ccw->count;
>> +        return -EFAULT;
>> +    }
>> +
>> +    if (ccw->count > PONG_BUF_SIZE) {
>> +        len =3D PONG_BUF_SIZE;
>> +        ccw_dev->sch->curr_status.scsw.count =3D ccw->count - PONG_BUF_=
SIZE;
>> +    } else {
>> +        len =3D ccw->count;
>> +        ccw_dev->sch->curr_status.scsw.count =3D 0;
>> +    }
>> +
>> +    return pong_rw(ccw, buf, len, 0);
>=20
> Can you please use the dstream infrastructure for read/write handling?
>=20
> You also seem to miss some basic checks e.g. for short reads/writes
> with and without SLI set.
>=20
>> +}
>> +
>> +static int pong_ccw_cb(SubchDev *sch, CCW1 ccw)
>> +{
>> +    int rc =3D 0;
>> +    CcwPONGDevice *dev =3D sch->driver_data;
>> +
>> +    switch (ccw.cmd_code) {
>> +    case PONG_WRITE:
>> +        rc =3D handle_payload_write(dev, &ccw);
>> +        break;
>> +    case PONG_READ:
>> +        rc =3D handle_payload_read(dev, &ccw);
>> +        break;
>> +    default:
>> +        rc =3D -ENOSYS;
>> +        break;
>> +    }
>> +
>> +    if (rc =3D=3D -EIO) {
>> +        /* I/O error, specific devices generate specific conditions */
>> +        SCHIB *schib =3D &sch->curr_status;
>> +
>> +        sch->curr_status.scsw.dstat =3D SCSW_DSTAT_UNIT_CHECK;
>> +        sch->sense_data[0] =3D 0x40;    /* intervention-req */
>=20
> This is really odd. If it succeeds, you generate a unit check with
> intervention required? Confused. At the very least, this requires some
> description as to how this device is supposed to interact with the
> driver.
>=20
>> +        schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
>> +        schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
>> +        schib->scsw.ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY=
 |
>> +                   SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
>> +    }
>> +    return rc;
>> +}
[...]
>> +
>> +static Property pong_ccw_properties[] =3D {
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void pong_ccw_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->props =3D pong_ccw_properties;

As long as there are no properties, I think you can simply drop that line.

 Thomas


