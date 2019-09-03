Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5ADC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85C821897
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85C821897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5E8r-0000Hl-TI
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 15:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5E4F-0006ky-PP
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5E4E-00063W-4s
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i5E4A-0005zu-GE; Tue, 03 Sep 2019 15:02:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4644510C6983;
 Tue,  3 Sep 2019 19:02:07 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E3E35C21A;
 Tue,  3 Sep 2019 19:02:01 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190903145634.20237-1-eblake@redhat.com>
 <9bde61cf-b4a7-fb11-7b8d-12cf8a2dc558@redhat.com>
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
Message-ID: <a49c5a8d-b77a-a2fe-fb02-673971ccd70b@redhat.com>
Date: Tue, 3 Sep 2019 14:02:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9bde61cf-b4a7-fb11-7b8d-12cf8a2dc558@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CPtHfnksjeSGS2Qo2ZCMV3FF69GgNtd3U"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 03 Sep 2019 19:02:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] docs: Update preferred NBD
 device syntax
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
Cc: vsementsov@virtuozzo.com, libvirt-list@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CPtHfnksjeSGS2Qo2ZCMV3FF69GgNtd3U
Content-Type: multipart/mixed; boundary="F3otzXzbvJGBR4pF6QD3x98wSkPXvN8HB";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, libvirt-list@redhat.com
Message-ID: <a49c5a8d-b77a-a2fe-fb02-673971ccd70b@redhat.com>
Subject: Re: [Qemu-block] [PATCH] docs: Update preferred NBD device syntax
References: <20190903145634.20237-1-eblake@redhat.com>
 <9bde61cf-b4a7-fb11-7b8d-12cf8a2dc558@redhat.com>
In-Reply-To: <9bde61cf-b4a7-fb11-7b8d-12cf8a2dc558@redhat.com>

--F3otzXzbvJGBR4pF6QD3x98wSkPXvN8HB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[adding libvirt list]

On 9/3/19 1:50 PM, John Snow wrote:
>=20
>=20
> On 9/3/19 10:56 AM, Eric Blake wrote:
>> Mention the preferred URI form, especially since NBD is trying to
>> standardize that form: https://lists.debian.org/nbd/2019/06/msg00012.h=
tml
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  qemu-doc.texi | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index 577d1e837640..c83fb347d77e 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -297,7 +297,14 @@ qemu-system-i386 -drive file=3Discsi://192.0.2.1/=
iqn.2001-04.com.example/1
>>
>>  @item NBD
>>  QEMU supports NBD (Network Block Devices) both using TCP protocol as =
well
>> -as Unix Domain Sockets.
>> +as Unix Domain Sockets.  With TCP, the default port is 10809.
>>
>> -Syntax for specifying a NBD device using TCP
>> +Syntax for specifying a NBD device using TCP, in preferred URI form:
>> +``nbd://<server-ip>[:<port>]/[<export>]''
>> +
>> +Syntax for specifying a NBD device using Unix Domain Sockets; remembe=
r
>> +that '?' is a shell glob character and may need quoting:
>> +``nbd+unix:///[<export>]?socket=3D<domain-socket>''
>> +
>> +Older syntax that is also recognized:
>=20
> Deprecated officially, or no?
>=20
>>  ``nbd:<server-ip>:<port>[:exportname=3D<export>]''
>>
>> -Syntax for specifying a NBD device using Unix Domain Sockets
>>  ``nbd:unix:<domain-socket>[:exportname=3D<export>]''

I didn't feel like starting a deprecation clock, in part because libvirt
is still using nbd:host:port:exportname during migration, similarly code
in virstoragefile.c is using only the old form.  Do we want to start a
deprecation (as a separate patch), to prod faster changes in libvirt in
switching to the newer form where sensible?

>>
>>  Example for TCP
>>  @example
>> -qemu-system-i386 --drive file=3Dnbd:192.0.2.1:30000
>> +qemu-system-i386 --drive file=3Dnbd://192.0.2.1:30000
>>  @end example
>>
>>  Example for Unix Domain Sockets
>>  @example
>> -qemu-system-i386 --drive file=3Dnbd:unix:/tmp/nbd-socket
>> +qemu-system-i386 --drive "file=3Dnbd+unix:///?socket=3D/tmp/nbd-socke=
t"
>>  @end example
>>
>>  @item SSH
>>
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks; will queue through my NBD tree (regardless of whether we decide
I should add more patches to start a deprecation cycle).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--F3otzXzbvJGBR4pF6QD3x98wSkPXvN8HB--

--CPtHfnksjeSGS2Qo2ZCMV3FF69GgNtd3U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1uuKkACgkQp6FrSiUn
Q2phWQf+PBC1TWDUQA8tHdrIiX58BiXUZu0b6Vy+eQClYFxYzV7mSiZQe4RkSEtS
RUCXBx+EpSMiiNtIQwbJOj132Of+sb7sWgkQvQlMq13SG4zizzYElemWVQy2jF+V
2ttRM1Ky0Q1W02pqpooRQYJoVJpoh8vpOy9tzfgRcmOYsHy5igJWFv9nBVvRXn/O
2rt84LjpIY4qdUaGmZhhmF+d9Hd+6nUloK31/cBK9etpRvs3CxT8BKNdqJvTIFET
MssKj9rRE7bJK789HMOxKvzanyvq3fyYB0A+ytKV1L+Qd5bVjAG4oTwyjegxbUT1
VqQkIcL/yDps56QH7QcWAPVYBnB0fQ==
=Q8jV
-----END PGP SIGNATURE-----

--CPtHfnksjeSGS2Qo2ZCMV3FF69GgNtd3U--

