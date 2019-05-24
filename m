Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBD4C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456712133D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456712133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUETv-0005mO-KY
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:59:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hUES7-0004hR-1s
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hUES5-0007xL-Uk
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:57:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hUENB-0004or-Dw; Fri, 24 May 2019 13:52:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3AB7C057E9F;
	Fri, 24 May 2019 17:52:46 +0000 (UTC)
Received: from [10.3.116.169] (ovpn-116-169.phx2.redhat.com [10.3.116.169])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 04FFA52F3;
	Fri, 24 May 2019 17:52:45 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190524172812.27308-1-mreitz@redhat.com>
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
Message-ID: <8a76f460-8a16-4621-bbe2-c71bacbbe988@redhat.com>
Date: Fri, 24 May 2019 12:52:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524172812.27308-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cvCKyS0XALytROSXz3VKlkL1kdD8yFlTU"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 24 May 2019 17:52:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] =?utf-8?q?=5BRFC_0/3=5D_block=3A_Inquire_images?=
 =?utf-8?q?=E2=80=99_rotational_info?=
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Anton Nefedov <anton.nefedov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cvCKyS0XALytROSXz3VKlkL1kdD8yFlTU
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov
 <anton.nefedov@virtuozzo.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8a76f460-8a16-4621-bbe2-c71bacbbe988@redhat.com>
Subject: =?UTF-8?Q?Re=3a_=5bQemu-devel=5d_=5bRFC_0/3=5d_block=3a_Inquire_ima?=
 =?UTF-8?Q?ges=e2=80=99_rotational_info?=
References: <20190524172812.27308-1-mreitz@redhat.com>
In-Reply-To: <20190524172812.27308-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/24/19 12:28 PM, Max Reitz wrote:
> Hi,
>=20
> http://lists.nongnu.org/archive/html/qemu-block/2019-05/msg00569.html
> shows that optimizations affect HDDs and SSDs differently.  It would be=

> nice if we could differentiate between the two and then choose to adjus=
t
> our behavior depending on whether a given image is stored on an HDD or
> not.
>=20
> Or maybe it isn=E2=80=99t so nice.  That=E2=80=99s one reason this is a=
n RFC.

Not an entirely bad idea. The NBD spec advertises whether an image is
rotational, precisely because it CAN make a difference for optimizing
access patterns. Likewise, commit 3b19f450 added support for ide
emulation to report rotation or non-rotational through to the guest.  So
plumbing it up in more places makes sense.

>=20
> The other is that I implemented recognition of the rotational status by=

> querying sysfs.  That looks stupid, but I didn=E2=80=99t find a better =
way
> (there is a BLKROTATIONAL ioctl, but that only works on device files).
>=20
> But, hey, if you look through block/file-posix.c, you=E2=80=99ll find t=
hat I=E2=80=99m
> not the first to query sysfs.  hdev_get_max_segments() does so, too.  S=
o
> maybe it isn=E2=80=99t that bad of an idea.
>=20
>=20
> What do you think?  Is the whole idea stupid?  Just the implementation?=

> Or does it make sense?
>=20

I'm in favor of the idea, whether or not review of the patches points
out tweaks to make before dropping RFC.

>=20
> Max Reitz (3):
>   block: Add ImageRotationalInfo
>   file-posix: Inquire rotational status
>   qcow2: Evaluate rotational info
>=20
>  qapi/block-core.json  | 19 ++++++++++-
>  block/qcow2.h         |  3 ++
>  include/block/block.h |  7 +++++
>  block.c               | 20 +++++++++++-
>  block/file-posix.c    | 73 +++++++++++++++++++++++++++++++++++++++++++=

>  block/qapi.c          |  3 ++
>  block/qcow2.c         | 34 +++++++++++++++++---
>  7 files changed, 153 insertions(+), 6 deletions(-)

Given my comments about NBD, I'd expect a patch to block/nbd{,-client}.c
to expose this as well.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cvCKyS0XALytROSXz3VKlkL1kdD8yFlTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzoL20ACgkQp6FrSiUn
Q2rmVAf/bt/Hfl3HPQqDp3wUAl8ayp7mtv921ZQd83+pBCCHZQAyYlgg5DVohAgu
LGziQkvbaay/BGrfORm4WUtw8Nz0D8q2X+rB/+NyyiiA8/Z7bZ3rLa7fWj64K+JJ
6IG8F+jmq5vPkmfgsI70VzkXqBg2T+Q9q66ZlJ1rBCPiMmwElMNaYOC6AxIFpMMc
k7Vvj7g4OWm8YON9z9SJwvI/UV2TfdSDIBmaDdHPgvXqb4OXm/LkeGhl97cc6IJE
NgTJrSvRSQOIRP7JcR0pJlr/k0G1gug8Dux4bi8D73boxcVVKsV3Q0NYTsB1r5fu
oDvljwN5nOnNrdZc3ew5TORe8Z54Ug==
=2ZrF
-----END PGP SIGNATURE-----

--cvCKyS0XALytROSXz3VKlkL1kdD8yFlTU--

