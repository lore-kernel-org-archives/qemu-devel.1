Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38860C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00FB5208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FB5208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgxrM-0007nd-90
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 16:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50247)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hgxpf-0006ra-3T
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hgxpd-0001Cg-Bj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:50:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51140)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hgxpd-00017Y-3i
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:50:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so10311227wmf.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 13:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=45YTvQDMAdv3EKIypBVchC5yDSaLJ8bG9XuqZlL/nto=;
 b=gERWZKKfI6WBrtGtxiuUJg9a6dGS1s0rGrcvYHDrGcpDNe8HPrlrSzLEuXqhmde7od
 ObnUj1WWp8AyDEzatY67og3KUG8XXGdT0+PSR/c2EZ4IFBlOBWpcwQ+8SYNWmuqXqKbp
 CKXDi0hW/BB0R02je8VjdB5Obl7kzh1Z7Nzm9gJNgcnz69S3B3Eg0w+rhcc1i5m8oJ41
 6Xzrxa18PoL90KGUKehsgNireBo1bO5/72iOAKlmQsyj9BLU5wwU30VMGjuCSyB7Zif3
 htmQfoMKAZpGHawhs1YEz22f30aZFtAp0zUw6VFRpcOE05c0ksWQh9XQP/AlDT17+Ln2
 LkBw==
X-Gm-Message-State: APjAAAWSNiODtNB8F1xyxxzP9miSskqDfkXpHD4bsohtIwSqNHNx86bO
 l0o7OVtXRQunJuLuBTDXk9JYPaRsoOM=
X-Google-Smtp-Source: APXvYqwgu/+qbLy2rv0g1d8ZX6sIv96h1ekcQh4CCk/O3xtqVLXXoz2tq3JUXTAnTUNF3YwVV4fTbA==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr8124030wmj.43.1561755050299;
 Fri, 28 Jun 2019 13:50:50 -0700 (PDT)
Received: from dritchie.redhat.com (73.red-88-25-212.staticip.rima-tde.net.
 [88.25.212.73])
 by smtp.gmail.com with ESMTPSA id r2sm2745920wme.30.2019.06.28.13.50.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 13:50:49 -0700 (PDT)
References: <20190628115349.60293-1-slp@redhat.com>
 <20190628115349.60293-3-slp@redhat.com>
 <20190628100145-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
In-reply-to: <20190628100145-mutt-send-email-mst@kernel.org>
Date: Fri, 28 Jun 2019 22:50:47 +0200
Message-ID: <87r27dwi1k.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/virtio: Factorize virtio-mmio
 headers
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Michael S. Tsirkin <mst@redhat.com> writes:

> On Fri, Jun 28, 2019 at 01:53:47PM +0200, Sergio Lopez wrote:
>> Put QOM and main struct definition in a separate header file, so it
>> can be accesed from other components.
>>=20
>> This is needed for the microvm machine type implementation.
>>=20
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>
> If you are going to productise virtio-mmio, then 1.0 support is a must.
> I am not sure we want a new machine with 0.X mmio devices.
> Especially considering that virtio-mmio does not have support for
> transitional devices.

What are the practical implications of that?

>> ---
>>  hw/virtio/virtio-mmio.c | 35 +-----------------------
>>  hw/virtio/virtio-mmio.h | 60 +++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 61 insertions(+), 34 deletions(-)
>>  create mode 100644 hw/virtio/virtio-mmio.h
>>=20
>> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
>> index 97b7f35496..87c7fe4d8d 100644
>> --- a/hw/virtio/virtio-mmio.c
>> +++ b/hw/virtio/virtio-mmio.c
>> @@ -26,44 +26,11 @@
>>  #include "qemu/host-utils.h"
>>  #include "qemu/module.h"
>>  #include "sysemu/kvm.h"
>> -#include "hw/virtio/virtio-bus.h"
>> +#include "virtio-mmio.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/log.h"
>>  #include "trace.h"
>>=20=20
>> -/* QOM macros */
>> -/* virtio-mmio-bus */
>> -#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
>> -#define VIRTIO_MMIO_BUS(obj) \
>> -        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
>> -#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
>> -        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
>> -#define VIRTIO_MMIO_BUS_CLASS(klass) \
>> -        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BU=
S)
>> -
>> -/* virtio-mmio */
>> -#define TYPE_VIRTIO_MMIO "virtio-mmio"
>> -#define VIRTIO_MMIO(obj) \
>> -        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
>> -
>> -#define VIRT_MAGIC 0x74726976 /* 'virt' */
>> -#define VIRT_VERSION 1
>> -#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
>> -
>> -typedef struct {
>> -    /* Generic */
>> -    SysBusDevice parent_obj;
>> -    MemoryRegion iomem;
>> -    qemu_irq irq;
>> -    /* Guest accessible state needing migration and reset */
>> -    uint32_t host_features_sel;
>> -    uint32_t guest_features_sel;
>> -    uint32_t guest_page_shift;
>> -    /* virtio-bus */
>> -    VirtioBusState bus;
>> -    bool format_transport_address;
>> -} VirtIOMMIOProxy;
>> -
>>  static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
>>  {
>>      return kvm_eventfds_enabled();
>> diff --git a/hw/virtio/virtio-mmio.h b/hw/virtio/virtio-mmio.h
>> new file mode 100644
>> index 0000000000..2f3973f8c7
>> --- /dev/null
>> +++ b/hw/virtio/virtio-mmio.h
>> @@ -0,0 +1,60 @@
>> +/*
>> + * Virtio MMIO bindings
>> + *
>> + * Copyright (c) 2011 Linaro Limited
>> + *
>> + * Author:
>> + *  Peter Maydell <peter.maydell@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License; either version=
 2
>> + * of the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License al=
ong
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef QEMU_VIRTIO_MMIO_H
>> +#define QEMU_VIRTIO_MMIO_H
>> +
>> +#include "hw/virtio/virtio-bus.h"
>> +
>> +/* QOM macros */
>> +/* virtio-mmio-bus */
>> +#define TYPE_VIRTIO_MMIO_BUS "virtio-mmio-bus"
>> +#define VIRTIO_MMIO_BUS(obj) \
>> +        OBJECT_CHECK(VirtioBusState, (obj), TYPE_VIRTIO_MMIO_BUS)
>> +#define VIRTIO_MMIO_BUS_GET_CLASS(obj) \
>> +        OBJECT_GET_CLASS(VirtioBusClass, (obj), TYPE_VIRTIO_MMIO_BUS)
>> +#define VIRTIO_MMIO_BUS_CLASS(klass) \
>> +        OBJECT_CLASS_CHECK(VirtioBusClass, (klass), TYPE_VIRTIO_MMIO_BU=
S)
>> +
>> +/* virtio-mmio */
>> +#define TYPE_VIRTIO_MMIO "virtio-mmio"
>> +#define VIRTIO_MMIO(obj) \
>> +        OBJECT_CHECK(VirtIOMMIOProxy, (obj), TYPE_VIRTIO_MMIO)
>> +
>> +#define VIRT_MAGIC 0x74726976 /* 'virt' */
>> +#define VIRT_VERSION 1
>> +#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
>> +
>> +typedef struct {
>> +    /* Generic */
>> +    SysBusDevice parent_obj;
>> +    MemoryRegion iomem;
>> +    qemu_irq irq;
>> +    /* Guest accessible state needing migration and reset */
>> +    uint32_t host_features_sel;
>> +    uint32_t guest_features_sel;
>> +    uint32_t guest_page_shift;
>> +    /* virtio-bus */
>> +    VirtioBusState bus;
>> +    bool format_transport_address;
>> +} VirtIOMMIOProxy;
>> +
>> +#endif
>> --=20
>> 2.21.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0WfacACgkQ9GknjS8M
AjV+kA/+PaPpJgPMdvXrRomJXVWasvHbtgy04a0mE+KGUIkIAKQJr98PRIlmrDfl
lPZmre8Kf3ba7nttx6tchszUykAJNNVlePaheRsasrzMgBrvXB9BEykgeMzeJsBX
EZndng3CQ5VBw8It2jadpZFlKwlW6owGhIRv9xC/DMQijmHob0hxZjl5vHiOkkfM
Atrb865mKrrq/oYJQSiUQYPdCdRjW/UVi65XRouVBL6VAfsPDOr3y7IJHt2qawPq
6mWNWBmP/iOUCSeldBwqmY3T1Ijuk5VsykQYFusTRDWpgzC3fuVGQCHM/N9bLZ5l
aX3XUb3BgRSQ4PfQQJnm+Dtmhj4wMiVQLtDZaDeOOePnh3Y8ZlMr5zzWGswoUAsS
p07dhsnxtUHdB72Z3LTJj7t6Vf9dixubXUtMEYMpT1TK5mS9dRKygV5LKyD1jJVr
VMsNRW6WKv5ZxNqxKZ5K9JLaIfl1ehesYeMShcCRZsYUFk19OX9h6nz7VjcyAuPf
4rb5rQaDvOmqmpfiPSyEAVXG+DQ+6dQDQcXthHS7glO+bTuE1DHVrgpj/xJXE1nh
8uZFmnmuANMINr7nkbcsyxcDunRp6ZQ1qv0ibm+zTM1RgrgZ8P8KikIbKK1KW+US
zIIsb3t3t0FgvRsM/Q8zuNIW5QuAXjzi32Z+B0ivMU+azkoCyGA=
=jcQu
-----END PGP SIGNATURE-----
--=-=-=--

