Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F33C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A650620652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A650620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLUIw-0007nL-Rt
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 11:04:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUHp-0007Te-BB
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLUHo-0004mN-7n
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:03:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hLUHn-0004lj-V9; Tue, 30 Apr 2019 11:03:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1ECCC059B7A;
	Tue, 30 Apr 2019 15:03:09 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B7611001E66;
	Tue, 30 Apr 2019 15:03:06 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Boxuan Li <liboxuan@connect.hku.hk>, qemu-devel@nongnu.org
References: <20190428110258.86681-1-liboxuan@connect.hku.hk>
	<a683a29f-ea7b-aaf9-258f-68f4ffcd9b96@redhat.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
	xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
	xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
	TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
	GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
	sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
	AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
	CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
	RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
	wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
	Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
	gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
	pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
	zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
	pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
	3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
	NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
	cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
	SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
	I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
	mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
	Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
	2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <5fe13664-cabc-6fc9-7437-285cc1452944@redhat.com>
Date: Tue, 30 Apr 2019 10:03:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a683a29f-ea7b-aaf9-258f-68f4ffcd9b96@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2MqIhRHehvafaaPeCANYMcdExHqA49PDl"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 30 Apr 2019 15:03:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] virtio-mmio: Always compile debug prints
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430150305.Klf9vUhKTKY6nEEY-1P-y48zSoRwYMsV6Js3P2XSgvs@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2MqIhRHehvafaaPeCANYMcdExHqA49PDl
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Boxuan Li <liboxuan@connect.hku.hk>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <5fe13664-cabc-6fc9-7437-285cc1452944@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-mmio: Always compile debug prints
References: <20190428110258.86681-1-liboxuan@connect.hku.hk>
 <a683a29f-ea7b-aaf9-258f-68f4ffcd9b96@redhat.com>
In-Reply-To: <a683a29f-ea7b-aaf9-258f-68f4ffcd9b96@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 5:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Li,
>=20
> On 4/28/19 1:02 PM, Boxuan Li wrote:
>> Wrap printf calls inside debug macros (DPRINTF) in `if` statement, and=

>> change output to stderr as well. This will ensure that printf function=

>> will always compile and prevent bitrot of the format strings.
>=20
> There is an effort in QEMU to replace the obsolete DPRINTF() macros by
> trace events (which prevent format strings bitroting).

Trace events are even more powerful than conditional debugs (in that you
can turn them on or off at runtime, instead of compile time). But
incremental improvements are still better than nothing.


>>
>> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
>> index 5807aa87fe..693b3c9eb4 100644
>> --- a/hw/virtio/virtio-mmio.c
>> +++ b/hw/virtio/virtio-mmio.c
>> @@ -28,15 +28,14 @@
>>  #include "hw/virtio/virtio-bus.h"
>>  #include "qemu/error-report.h"
>> =20
>> -/* #define DEBUG_VIRTIO_MMIO */
>> -
>> -#ifdef DEBUG_VIRTIO_MMIO

The old code let a user pass CFLAGS=3D-DDEBUG_VIRTIO_MMIO to turn things =
on...

>> -
>> -#define DPRINTF(fmt, ...) \
>> -do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
>> -#else
>> -#define DPRINTF(fmt, ...) do {} while (0)
>> -#endif
>> +#define DEBUG_VIRTIO_MMIO 0

=2E..the new code requires a source code edit. This can be considered a
step backwards in developer friendliness.  Better might be:

#ifdef DEBUG_VIRTIO_MMIO
#define DEBUG_VIRTIO_MMIO_PRINT 1
#else
#define DEBUG_VIRTIO_MMIO_PRINT 0
#endif

>> +
>> +#define DPRINTF(fmt, ...)                                            =
\
>> +    do {                                                             =
\
>> +        if (DEBUG_VIRTIO_MMIO) {                                     =
\

and the corresponding use of DEBUG_VIRTIO_MMIO_PRINT here, so that you
preserve the ability to do a command-line CFLAGS=3D-D override, rather
than forcing a source code edit.

>> +            fprintf(stderr, "virtio_mmio: " fmt , ## __VA_ARGS__);   =
\

No space before ,

>> +        }                                                            =
\
>> +    } while (0)
>> =20
>>  /* QOM macros */
>>  /* virtio-mmio-bus */
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2MqIhRHehvafaaPeCANYMcdExHqA49PDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIY6kACgkQp6FrSiUn
Q2ohCAf+O2qzgwj4/OP37+rMmBJK9d1ZYizKAcHPgFU3kvzcvnkQRz8hs+FEWo7H
qN4R/RGqSiP7T+o/xqymHltFFumqegI1aG11IZf38qohr7j4MWVxdhWxFBwsgqXx
rcMe7pV/XroFXS2RlMi05Lp3uUIDFRq0DmL0L+xm+82eMveNlqJv6SRQIeV1idwm
ZPehg9LpWsTQvL4QhEwX7zsJ+EvXUMBtuGxaPX98hmE2euqo40CCi3D5tISdfIrN
W3PjG7MxMML7RJqupcatJ0DRr1FkKXAQRtml0LTpLjL7X7NYKxEYEHQQITA6+Ea9
P7Q4zhns+hMmoJYjEaOTppyIZft15w==
=DNmD
-----END PGP SIGNATURE-----

--2MqIhRHehvafaaPeCANYMcdExHqA49PDl--

