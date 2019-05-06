Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D561C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446F320830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446F320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59799 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhQ6-0005oX-FY
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:28:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNhK0-0000nu-38
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hNhJy-0000IG-OZ
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:22:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hNhJs-00009K-V3; Mon, 06 May 2019 13:22:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63ACE7E43D;
	Mon,  6 May 2019 17:22:26 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C513F61F21;
	Mon,  6 May 2019 17:22:25 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
References: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
	<316d5b3f-d25a-6f9d-6d28-a91f7d2bc22e@redhat.com>
	<d2a3e561-8f17-8d97-3396-e275f0262cf2@redhat.com>
	<3e34678e-daa2-a7e0-3da9-dbd3d1c27e64@redhat.com>
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
Message-ID: <3b88c3f8-c1bd-babe-f995-425da8840778@redhat.com>
Date: Mon, 6 May 2019 12:22:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3e34678e-daa2-a7e0-3da9-dbd3d1c27e64@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cCg9hq2icHZKZ8hd4mr4GL1Gaf0W6L0In"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 06 May 2019 17:22:26 +0000 (UTC)
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cCg9hq2icHZKZ8hd4mr4GL1Gaf0W6L0In
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <3b88c3f8-c1bd-babe-f995-425da8840778@redhat.com>
Subject: Re: Failing QEMU iotest 221
References: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
 <316d5b3f-d25a-6f9d-6d28-a91f7d2bc22e@redhat.com>
 <d2a3e561-8f17-8d97-3396-e275f0262cf2@redhat.com>
 <3e34678e-daa2-a7e0-3da9-dbd3d1c27e64@redhat.com>
In-Reply-To: <3e34678e-daa2-a7e0-3da9-dbd3d1c27e64@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/3/19 3:54 PM, Eric Blake wrote:

>>> Ugh. Hole granularities are file-system specific, so we need to figur=
e
>>> out some way to fuzz the input. It might also be possible to pick nic=
er
>>> size numbers - perhaps if the test image is sized at 64k+1 instead of=

>>> 43009 (84*512, but NOT evenly divisible by 4k), the +1 byte is more
>>> likely to be directly one a hole boundary, rather than being somewher=
e
>>> that causes rounding the hole boundary 2k earlier because of 4k or 64=
k
>>> sizing constraints.
>>
>> Ok ... sounds like that's definitely something I'd like to leave to yo=
u
>> or one of the block guys to fix.
>=20
> I can certainly prepare a patch that widens the file to 64k+1 instead o=
f
> 43008+1, but since I can't (yet) reproduce the failure, I'd be relying
> on you to verify that it makes a difference.

Patch posted in another thread.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cCg9hq2icHZKZ8hd4mr4GL1Gaf0W6L0In
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzQbVAACgkQp6FrSiUn
Q2opJwgAnzm4mvQ56YZKvcxLPawVHhvaJyul/y+GW8U8Vh5TLoHJCgMSVSN3VVJ9
k1qEcBtFIeHuByJ+dO05r2jjWtKD9WwN6wCpjWQS5iYlpx1r2a4I57+wmn7Aik2r
TdHQtzC7QCZFokgtoT0hFOwyxdWKxjSnnZtLE1ZpKBHEwfLNpmW0zAK4WHENK/Pu
i/xSHVl9rFIrHCXm5YKtjoXu3Ub5G9IoY6AN1LJx5enLZ2omKD89tKtrttRyVvdb
qU6l3I71kPI5RpKF4FH8npyE1OIoOshzUUMFCHVpAoBEJmLNo3jmMZFKPN5wRfkm
sLzhLAo/GL4w0JWQN+aG33a3kLWCcQ==
=v3za
-----END PGP SIGNATURE-----

--cCg9hq2icHZKZ8hd4mr4GL1Gaf0W6L0In--

