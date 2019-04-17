Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DDAC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8780B20835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8780B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGjm6-00081U-Ni
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 08:34:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGjl7-0007g4-3L
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGjl6-00065T-60
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:33:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hGjl3-00061X-MH; Wed, 17 Apr 2019 08:33:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C1F43078A1F;
	Wed, 17 Apr 2019 12:33:39 +0000 (UTC)
Received: from [10.3.116.103] (ovpn-116-103.phx2.redhat.com [10.3.116.103])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 70B815D71B;
	Wed, 17 Apr 2019 12:33:36 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
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
Message-ID: <d03ef112-4ff4-c5af-5894-5b2c5f8075de@redhat.com>
Date: Wed, 17 Apr 2019 07:33:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417100929.39943-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iuW11Qy2ckfTPvJeEUoSL4Ttkci9xhDG9"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 17 Apr 2019 12:33:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.0? 0/2] Fix overflow bug in qcow2
 discard
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
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, stefanha@redhat.com,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417123335.Af-_GSaPmsPhXPr-CWaVNeu7wW7BzBXp8iTDEkEObWA@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iuW11Qy2ckfTPvJeEUoSL4Ttkci9xhDG9
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, mreitz@redhat.com,
 stefanha@redhat.com
Message-ID: <d03ef112-4ff4-c5af-5894-5b2c5f8075de@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0? 0/2] Fix overflow bug in qcow2
 discard
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190417100929.39943-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 5:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. We faced an interesting bug, which may be simply reproduced:
>=20
> prepare image:
> ./qemu-img create -f qcow2 -o cluster_size=3D1M /ssd/test 2300M
> ./qemu-io -c 'write 100M 2000M' -c 'write 2100M 200M' -c 'write 0 100M'=
 /ssd/test
>=20
> shrink:
> ./qemu-img resize --shrink /ssd/test 50M
>=20
> bug:
> ./qemu-img info /ssd/test
> image: /ssd/test
> file format: qcow2
> virtual size: 50M (52428800 bytes)
> disk size: 2.2G
> cluster_size: 1048576
> Format specific information:
>     compat: 1.1
>     lazy refcounts: false
>     refcount bits: 16
>     corrupt: false
>=20
> Virtual size is shrunk, but file - not. It is due to the fact,
> that merged qcow2 discard may exceed 2G, and then converting from
> uint64_t to int in qcow2_process_discards when we call bdrv_pdiscard
> make wrong thing.

Too late for 4.0, but also not a regression new to this release, since
the problem appears to have been present since its introduction in
commit 0b919fae (1.6.0) (that is, even back then, Qcow2DiscardRegion was
introduced with a 64-bit discard length, but qcow2_process_discards
blindly passed that through bdrv_discard() at the time, which took 'int
nb_sectors').

>=20
> So, here are proposal of fix and new iotest for it.
>=20
> Vladimir Sementsov-Ogievskiy (2):
>   block/io: bdrv_pdiscard: support int64_t bytes parameter
>   iotests: test big qcow2 shrink
>=20
>  include/block/block.h      |  4 +--
>  block/io.c                 | 19 ++++++-----
>  tests/qemu-iotests/249     | 69 ++++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/249.out | 30 +++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  5 files changed, 112 insertions(+), 11 deletions(-)
>  create mode 100755 tests/qemu-iotests/249
>  create mode 100644 tests/qemu-iotests/249.out
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--iuW11Qy2ckfTPvJeEUoSL4Ttkci9xhDG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3HR8ACgkQp6FrSiUn
Q2rkZwf8D1J0c9aGOSLV4ybDsfzcTr58jHbkRo9mSo9QYJAbxPVPnHjgIXzsB45G
wYQNs+/hv10COPTeuYSkLEXJI7l1NE4wpL+gISSmBQrL4pKg0AlE38G+k2bV10I6
oO88fCb3AES7c432tVC1Kzruk+UuOxPBpu4ta5vcf4dmZP+/7ZPlE/Wl9GwPQsCK
5I+iusvRcElvzJ+YbvSyak4MmtxZpKeukq6rb3lr++LlyNJiETYf5/I9+zEoyNyN
71PvpsPtW1DwkhasUylhxliwMZGfS4BiUeq2dVy0a4pagIDTMgF1R9JqA21QxrJZ
v1lTTKob2gmLIuNRPXWxCbm+687Zcw==
=ij5Q
-----END PGP SIGNATURE-----

--iuW11Qy2ckfTPvJeEUoSL4Ttkci9xhDG9--

