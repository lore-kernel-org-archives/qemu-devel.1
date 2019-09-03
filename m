Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B616BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868DE2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868DE2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i55zT-00017g-BX
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i55xZ-0007wA-VG
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i55xY-0008O7-QO
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:22:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i55xY-0008MA-IJ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:22:48 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 342CEC028320
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 10:22:47 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id l6so6025936wrn.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 03:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=sqPo8Wybb3JmFx9L/VjPXMzZInKTyk0Co7XsqnbhqvM=;
 b=DYqrg+GpsPvgr3E6D1u2YdvOoHbsZLImH5otQXN2jYa7QFQ4Bug0IYryW8TIZWyhJK
 pcs5CoZ+3J7KllnKNOkO2w46jo8WyRJEKsiauk8nSo/hsTvm/ZeJORo/nA84iMZuEcAh
 U008nJZURJQ58+2Wpck8m2ycrXo34tEIlbi/VFhzJtUwMxdlOxxKGeVx7Do9Ocdu7a7f
 qUIDlZAoVstphcuVORBzjjUL5fZ5qvOQOKs77cPgQQwmbA2C4/sE4xVoD+7lkWWvSqN3
 RIZC7xIMf6WHA9y/TmcbGFn3jEUE5nW3xOIaqunLvmUFQphoMKwr4zK8Id/F4FRYszqz
 O1nQ==
X-Gm-Message-State: APjAAAUnkgDnoBX94croARmgYeQWy+SLhyZPcDgeWTOydX56Sff5q+28
 tgIiqH0wtJjPNi+Iqk7gKq9JWDSJpi8358jgMpqT0vTWqLG8sfIFe0nf2mmQsv8OwINNuz45LAB
 R8AHZBgvlCvVxHIc=
X-Received: by 2002:a05:600c:145:: with SMTP id
 w5mr31719830wmm.75.1567506165754; 
 Tue, 03 Sep 2019 03:22:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJwoT1LOefnrOklGAO/DXpwh9eQn0Qy+KD3998DEhVW2xscVMEjr4EIsH2TnDcmFKDe1ToaA==
X-Received: by 2002:a05:600c:145:: with SMTP id
 w5mr31719793wmm.75.1567506165441; 
 Tue, 03 Sep 2019 03:22:45 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id s22sm8554813wmc.7.2019.09.03.03.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 03:22:44 -0700 (PDT)
References: <20190829165026.225173-1-slp@redhat.com>
 <20190902154135.39043595.cohuck@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
In-reply-to: <20190902154135.39043595.cohuck@redhat.com>
Date: Tue, 03 Sep 2019 12:22:41 +0200
Message-ID: <87muflisr2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: stefanha@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 abologna@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Cornelia Huck <cohuck@redhat.com> writes:

> On Thu, 29 Aug 2019 18:50:27 +0200
> Sergio Lopez <slp@redhat.com> wrote:
>
>> Implement the modern (v2) personality, according to the VirtIO 1.0
>> specification.
>>=20
>> Support for v2 among guests is not as widespread as it'd be
>> desirable. While the Linux driver has had it for a while, support is
>> missing, at least, from Tianocore EDK II, NetBSD and FreeBSD.
>>=20
>> For this reason, the v2 personality is disabled, keeping the legacy
>> behavior as default. Machine types willing to use v2, can enable it
>> using MachineClass's compat_props.
>>=20
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>> Changelog:
>>=20
>> v2:
>>  - Switch from RFC to PATCH.
>>  - Avoid the modern vs. legacy dichotomy. Use legacy or non-legacy
>>    instead. (Andrea Bolognani, Cornelia Huck)
>>  - Include the register offset in the warning messages. (Stefan
>>    Hajnoczi)
>>  - Fix device endianness for the non-legacy mode. (Michael S. Tsirkin)
>>  - Honor the specs in VIRTIO_MMIO_QUEUE_READY. (Michael S. Tsirkin)
>> ---
>>  hw/virtio/virtio-mmio.c | 296 +++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 279 insertions(+), 17 deletions(-)
>>=20
>
>> @@ -146,28 +163,51 @@ static uint64_t virtio_mmio_read(void *opaque, hwa=
ddr offset, unsigned size)
>>      case VIRTIO_MMIO_MAGIC_VALUE:
>>          return VIRT_MAGIC;
>>      case VIRTIO_MMIO_VERSION:
>> -        return VIRT_VERSION;
>> +        if (proxy->legacy) {
>> +            return VIRT_VERSION_LEGACY;
>> +        } else {
>> +            return VIRT_VERSION;
>> +        }
>>      case VIRTIO_MMIO_DEVICE_ID:
>>          return vdev->device_id;
>>      case VIRTIO_MMIO_VENDOR_ID:
>>          return VIRT_VENDOR;
>>      case VIRTIO_MMIO_DEVICE_FEATURES:
>> -        if (proxy->host_features_sel) {
>> -            return 0;
>> -        }
>> -        return vdev->host_features;
>> +        return vdev->host_features >> (32 * proxy->host_features_sel);
>
> Hm... I think you want to return 0 for host_features_sel > 0 on legacy
> devices.

You're right, better play safe here.

> Also, there's VirtIODeviceClass->legacy_features, which probably should
> be masked out for non-legacy devices?

Good point.

>> @@ -229,17 +275,33 @@ static void virtio_mmio_write(void *opaque, hwaddr=
 offset, uint64_t value,
>>      }
>>      switch (offset) {
>>      case VIRTIO_MMIO_DEVICE_FEATURES_SEL:
>> -        proxy->host_features_sel =3D value;
>> +        if (value) {
>> +            proxy->host_features_sel =3D 1;
>> +        } else {
>> +            proxy->host_features_sel =3D 0;
>> +        }
>>          break;
>>      case VIRTIO_MMIO_DRIVER_FEATURES:
>> -        if (!proxy->guest_features_sel) {
>> +        if (!proxy->legacy) {
>> +            proxy->guest_features[proxy->guest_features_sel] =3D value;
>> +        } else if (!proxy->guest_features_sel) {
>>              virtio_set_features(vdev, value);
>
> If the guest tries to set something !0 for guest_features_sel > 0 on a
> legacy device, should that be logged as a guest bug?

We already have some warnings for unexpected guest behavior, so I agree
we should add this one for completeness.

>>          }
>>          break;
>
> (...)
>
> Otherwise, looks good to me.

Thanks!
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl1uPvEACgkQ9GknjS8M
AjWv1w/9GCgCC8KN8xFVawyb75SbFycwW2w3TEteC2QLkJXTAu8xJrUXOF41yGfZ
gqXF3GJLD8TFfVACx0CgZnl6120a0H9IhTmB4YkCzUvJJw5bEt6fad4ktcXDAQN3
G2chsx06818gIPXj5XcXQFf37FCAwHbIwbPkc4ETLoIrt0x4Lzl3qVp705n3LvpG
m7nZQr704wtjRAmqpNYT58aC1Ugc/FtfiQB4ms4Puzn/I9cOoH7VfpFiOdLtHdcl
n+QRki4eMDkfWPvXUCftGTNqa8gLb1Ee9+iLXntYwDtItSqqg60LlMZDIYYJA6NA
bpWuqvC0F95Yr1mxaB7+TcwDb3HAz6aYmACuQPipOw3+PHjybi1+ee7JrA+mMxJM
vvyzbRbdouMzOsUmKdD/vYSrXMovDRB3943a6TtMqBjslxjbmdXlRVsQf9a3I4Ll
hw1wSQqAco3pd3QDXjQyl4EEC46d/UPyCOLLW/T7dqYC361ArJpCVFwGYkLZrTzN
hNX+VhDzoA/CvKNM1bUbE8t3NA4s7e8M78fFAzbUSI4C5JmZbb1Mmha2XV2YVsn2
0+tKKcNSctu1IKJiBZKkBqYj1zu4g324YHls5dhlSq83VHc5JaLMuWyOBFONug9H
xkA257XJAPRQKuc1AWIWbojGi4Vtlr7JHILvQ52WUhccGTEmOX4=
=49cg
-----END PGP SIGNATURE-----
--=-=-=--

