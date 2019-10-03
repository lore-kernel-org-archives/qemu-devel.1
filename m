Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D4FC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6BE206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6BE206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFzGs-0008U9-QY
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 07:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iFzFP-0007cs-N7
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iFzFN-0006j3-IH
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:26:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iFzFN-0006hk-9h
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:26:13 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 15982C05E740
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 11:26:12 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id s19so552001wmj.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 04:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=d93WqDjHA92NUrrFWYCKTzaN8bdm35VX9nXUmV1YNoY=;
 b=KjUyqcsq0vvMO7rJMQO3Rc+1ljq/GC+yMUJk6UBuyb1L+92XJ4KHcGjnlmm/f6scGS
 7P+t0FHSexdL77ecXzHt/P/1PY6ot9l8zVNT21y+3iGuhpCOm4c8j2Lw/EPqimYejMeV
 hBBSa+OMM7UpSYG1DMuk7Bn+g80Ey/PyaLfupZQG2QgEQB7Fm9zFmxZf/zPE2KbmYSpt
 cvaTPJE1lA2Z4hd1I+OIIIoSfjTUmPSV5zIvD0HUiplQTkIdxcpgTYLfUFzqsT4xpXfn
 hQxJPAW43et52J03wKjuOCbYLekUCIkPYsUZOZMGwjBnbmXWP8mlkr46oJvRxA9xPesu
 UzmQ==
X-Gm-Message-State: APjAAAW99X76cTweqsAM28TYnkB6kA0tJxJUuYFoeff/hx/rgb7xRqyV
 D+sPb5cMF30UVQGv7DIpLasrtKPiGTZfRmjgB/1I6fFzLy/wEQlcdhy9WL0cgeeO0W5+HqaajOZ
 D56N1YTnkR/4nulA=
X-Received: by 2002:a5d:4b46:: with SMTP id w6mr7113882wrs.223.1570101970782; 
 Thu, 03 Oct 2019 04:26:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTFI5UGcYTON50bRWlx6Jy0lUhFHBw1YeptSOOMXE7n7394znz443L/fDTftItATRXq9MJAw==
X-Received: by 2002:a5d:4b46:: with SMTP id w6mr7113858wrs.223.1570101970512; 
 Thu, 03 Oct 2019 04:26:10 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id c8sm2567537wrr.49.2019.10.03.04.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2019 04:26:09 -0700 (PDT)
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-2-slp@redhat.com>
 <96ff1ae1-fc3f-af56-08bd-a8b821385572@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 01/10] hw/virtio: Factorize virtio-mmio headers
In-reply-to: <96ff1ae1-fc3f-af56-08bd-a8b821385572@redhat.com>
Date: Thu, 03 Oct 2019 13:26:07 +0200
Message-ID: <87ftkahxyo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 10/2/19 1:30 PM, Sergio Lopez wrote:
>> Put QOM and main struct definition in a separate header file, so it
>> can be accessed from other components.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>   hw/virtio/virtio-mmio.c         | 48 +---------------------
>>   include/hw/virtio/virtio-mmio.h | 73 +++++++++++++++++++++++++++++++++
>>   2 files changed, 74 insertions(+), 47 deletions(-)
>>   create mode 100644 include/hw/virtio/virtio-mmio.h
>>
>> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
>> index 3d5ca0f667..94d934c44b 100644
>> --- a/hw/virtio/virtio-mmio.c
>> +++ b/hw/virtio/virtio-mmio.c
>> @@ -29,57 +29,11 @@
>>   #include "qemu/host-utils.h"
>>   #include "qemu/module.h"
>>   #include "sysemu/kvm.h"
>> -#include "hw/virtio/virtio-bus.h"
>> +#include "hw/virtio/virtio-mmio.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/log.h"
>>   #include "trace.h"
>>   -/* QOM macros */
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
>> -#define VIRT_VERSION 2
>> -#define VIRT_VERSION_LEGACY 1
>> -#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
>> -
>> -typedef struct VirtIOMMIOQueue {
>> -    uint16_t num;
>> -    bool enabled;
>> -    uint32_t desc[2];
>> -    uint32_t avail[2];
>> -    uint32_t used[2];
>> -} VirtIOMMIOQueue;
>> -
>> -typedef struct {
>> -    /* Generic */
>> -    SysBusDevice parent_obj;
>> -    MemoryRegion iomem;
>> -    qemu_irq irq;
>> -    bool legacy;
>> -    /* Guest accessible state needing migration and reset */
>> -    uint32_t host_features_sel;
>> -    uint32_t guest_features_sel;
>> -    uint32_t guest_page_shift;
>> -    /* virtio-bus */
>> -    VirtioBusState bus;
>> -    bool format_transport_address;
>> -    /* Fields only used for non-legacy (v2) devices */
>> -    uint32_t guest_features[2];
>> -    VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
>> -} VirtIOMMIOProxy;
>> -
>>   static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
>>   {
>>       return kvm_eventfds_enabled();
>> diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-=
mmio.h
>> new file mode 100644
>> index 0000000000..c8a6ef20de
>> --- /dev/null
>> +++ b/include/hw/virtio/virtio-mmio.h
>> @@ -0,0 +1,73 @@
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
>
> I'd rather use HW_VIRTIO_MMIO_H

Looks like there isn't a consensus in this regard:

$ grep "ifndef" *
vhost-backend.h:#ifndef VHOST_BACKEND_H
vhost.h:#ifndef VHOST_H
vhost-scsi-common.h:#ifndef VHOST_SCSI_COMMON_H
vhost-scsi.h:#ifndef VHOST_SCSI_H
vhost-user-blk.h:#ifndef VHOST_USER_BLK_H
vhost-user.h:#ifndef HW_VIRTIO_VHOST_USER_H
vhost-user-scsi.h:#ifndef VHOST_USER_SCSI_H
vhost-vsock.h:#ifndef QEMU_VHOST_VSOCK_H
virtio-access.h:#ifndef QEMU_VIRTIO_ACCESS_H
virtio-balloon.h:#ifndef QEMU_VIRTIO_BALLOON_H
virtio-balloon.h.orig:#ifndef QEMU_VIRTIO_BALLOON_H
virtio-blk.h:#ifndef QEMU_VIRTIO_BLK_H
virtio-bus.h:#ifndef VIRTIO_BUS_H
virtio-crypto.h:#ifndef QEMU_VIRTIO_CRYPTO_H
virtio-gpu-bswap.h:#ifndef HW_VIRTIO_GPU_BSWAP_H
virtio-gpu.h:#ifndef HW_VIRTIO_GPU_H
virtio-gpu-pci.h:#ifndef HW_VIRTIO_GPU_PCI_H
virtio-gpu-pixman.h:#ifndef HW_VIRTIO_GPU_PIXMAN_H
virtio.h:#ifndef QEMU_VIRTIO_H
virtio-input.h:#ifndef QEMU_VIRTIO_INPUT_H
virtio-mmio.h:#ifndef QEMU_VIRTIO_MMIO_H
virtio-net.h:#ifndef QEMU_VIRTIO_NET_H
virtio-pmem.h:#ifndef HW_VIRTIO_PMEM_H
virtio-rng.h:#ifndef QEMU_VIRTIO_RNG_H
virtio-scsi.h:#ifndef QEMU_VIRTIO_SCSI_H
virtio-serial.h:#ifndef QEMU_VIRTIO_SERIAL_H

Do we have an actual policy written somewhere?

> Regardless:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
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
>> +#define VIRT_VERSION 2
>> +#define VIRT_VERSION_LEGACY 1
>> +#define VIRT_VENDOR 0x554D4551 /* 'QEMU' */
>> +
>> +typedef struct VirtIOMMIOQueue {
>> +    uint16_t num;
>> +    bool enabled;
>> +    uint32_t desc[2];
>> +    uint32_t avail[2];
>> +    uint32_t used[2];
>> +} VirtIOMMIOQueue;
>> +
>> +typedef struct {
>> +    /* Generic */
>> +    SysBusDevice parent_obj;
>> +    MemoryRegion iomem;
>> +    qemu_irq irq;
>> +    bool legacy;
>> +    /* Guest accessible state needing migration and reset */
>> +    uint32_t host_features_sel;
>> +    uint32_t guest_features_sel;
>> +    uint32_t guest_page_shift;
>> +    /* virtio-bus */
>> +    VirtioBusState bus;
>> +    bool format_transport_address;
>> +    /* Fields only used for non-legacy (v2) devices */
>> +    uint32_t guest_features[2];
>> +    VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
>> +} VirtIOMMIOProxy;
>> +
>> +#endif
>>


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2V2s8ACgkQ9GknjS8M
AjUOxg/7BF2O23GVyAmhX2lDHKQjB+h9bqtJ0apVuVjAN4cZkT4w47c01Ar+gsYI
x4c8UbjweVzUg4XD0QeiNpFl8ValI99MmLj8H3MpFRzjWVrOi4SmCeqvlkYBJD0o
U27kxVgFPRDylV1j+AErR44CjhYwU5UfwB8KU4cmflgiSxXIoQYeJgpl8ymSoIWf
cSoYCc7GoIOE3ATK7CfaCxT7EtXifuydQD9L+BUuTyUWsRY3gARhbz+JcVly28QE
LegzUJ5/FFXOzsWicauJDlOyJ02T8tYD6tElAP8vA4g16W7ACb4EwdGcCgsfI7jy
BfIbHkLIacg2jgblOq8/tt+/rf/+jV9VNWERc+oB9OUWfdR+mL0afjsYEiKb8AbF
68R7VdQAq4VW7eE6dkJ0/mPs8jft+nYz9WCHKncjVL+Vgys2vEMmMwqxKQXE2Fnu
+FdCMnPZPnSPrhrgVm1P8fGvRUk+FZv4H0xaHKp8xNnbMlyzcEuoVu/B2w/kYuzz
NYCZ3BT94+OxoBOQ0PaOPwD6FekGviRe89xxaRTtHfxkMmLVY8xRn3/f2+RlwFnN
hB24Qu0AWzbXBzsqaap3ocMfVBUMQsobjAJZdI7lJH7H5JeJMj7b8JlYkYly/pJd
8TR2Qop00yM7KLmiYtGaKFvf1VL3ErALL33/bU9Zht+ekjrZWCw=
=Gv+n
-----END PGP SIGNATURE-----
--=-=-=--

