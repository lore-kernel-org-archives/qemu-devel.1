Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06D0C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 20:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925862075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 20:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925862075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47143 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMfD7-0001DA-Ig
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 16:55:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMfCI-0000tY-Bk
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMfCH-0000ns-31
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:54:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hMfCE-0000lb-L0; Fri, 03 May 2019 16:54:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A837B59465;
	Fri,  3 May 2019 20:54:17 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 378E6600C7;
	Fri,  3 May 2019 20:54:14 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
References: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
	<316d5b3f-d25a-6f9d-6d28-a91f7d2bc22e@redhat.com>
	<d2a3e561-8f17-8d97-3396-e275f0262cf2@redhat.com>
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
Message-ID: <3e34678e-daa2-a7e0-3da9-dbd3d1c27e64@redhat.com>
Date: Fri, 3 May 2019 15:54:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d2a3e561-8f17-8d97-3396-e275f0262cf2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IIyiWqaavXnBD0SAYKC24TlEPzNk3oPMC"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 03 May 2019 20:54:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Failing QEMU iotest 221
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503205413.TnVjklK4-q0-pkCGWISQ2P0UnU3WCq9NWXtRavrIa5E@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IIyiWqaavXnBD0SAYKC24TlEPzNk3oPMC
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <3e34678e-daa2-a7e0-3da9-dbd3d1c27e64@redhat.com>
Subject: Re: Failing QEMU iotest 221
References: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
 <316d5b3f-d25a-6f9d-6d28-a91f7d2bc22e@redhat.com>
 <d2a3e561-8f17-8d97-3396-e275f0262cf2@redhat.com>
In-Reply-To: <d2a3e561-8f17-8d97-3396-e275f0262cf2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/2/19 11:43 PM, Thomas Huth wrote:
> On 03/05/2019 00.02, Eric Blake wrote:
>> On 4/28/19 10:21 AM, Thomas Huth wrote:
>>> QEMU iotest 221 is failing for me, too, when I run it with -raw:
>>
>> Which filesystem?
>=20
> ext4 again.
>=20
> $ stat -f /home/thuth/tmp/qemu-build/tests/qemu-iotests/
>   File: "/home/thuth/tmp/qemu-build/tests/qemu-iotests/"
>     ID: 1e68b4a412e09716 Namelen: 255     Type: ext2/ext3
> Block size: 1024       Fundamental block size: 1024

Odd that it is so small; these days, most ext4 systems have a block size
of 4k.

>=20
> Maybe the "check" script should report the output of "stat -f", too?

Wouldn't hurt, although that doesn't tell us all of the file system
tuning parameters that might be important to reproducing a problem.


>>> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/221.out.bad	2019-04=
-28 17:18:52.000000000 +0200
>>> @@ -7,10 +7,10 @@
>>>  [{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET}]
>>>  wrote 1/1 bytes at offset 43008
>>>  1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET},
>>> -{ "start": 40960, "length": 2049, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET},
>>> +[{ "start": 0, "length": 43008, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET},
>>> +{ "start": 43008, "length": 1, "depth": 0, "zero": false, "data": tr=
ue, "offset": OFFSET},
>>
>> Ugh. Hole granularities are file-system specific, so we need to figure=

>> out some way to fuzz the input. It might also be possible to pick nice=
r
>> size numbers - perhaps if the test image is sized at 64k+1 instead of
>> 43009 (84*512, but NOT evenly divisible by 4k), the +1 byte is more
>> likely to be directly one a hole boundary, rather than being somewhere=

>> that causes rounding the hole boundary 2k earlier because of 4k or 64k=

>> sizing constraints.
>=20
> Ok ... sounds like that's definitely something I'd like to leave to you=

> or one of the block guys to fix.

I can certainly prepare a patch that widens the file to 64k+1 instead of
43008+1, but since I can't (yet) reproduce the failure, I'd be relying
on you to verify that it makes a difference.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--IIyiWqaavXnBD0SAYKC24TlEPzNk3oPMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzMqnUACgkQp6FrSiUn
Q2rLWQf/ZnycWxcGiOfsWyEogzcjcJ5NNO4Q/xEjvfeHzTaxiVwBlPlifNPJT4CS
8tv1DNWsoXp6I3K9vZIRAkw8MuPSACAAn1LbOPXyTcgJF6OWAJr3N1W07PwBgbox
BkzeYwIztWmuZVvD8Q1bjAo/QfDlFGKmEXoPFZXJwU/5j8a5FpydYg+zopo6RqTE
R4JW9i2M30MWZz+eFOUVzruANLNU0tpkbgzEDznHMFBcI2HiQWANlVrMvrs9HzoV
5RMyxTdkztNQ3DIs3Qvy7CaDHrUBDY7Pj0dZjA+1QFcXCPA9XUKELS9HYUUm5KBC
WdQHC/o9ySau9vzEdx9CPrHy28CMaQ==
=xfCm
-----END PGP SIGNATURE-----

--IIyiWqaavXnBD0SAYKC24TlEPzNk3oPMC--

