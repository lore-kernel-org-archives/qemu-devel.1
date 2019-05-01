Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B21C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4168208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4168208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32873 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLr7j-0005HE-Qe
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:26:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLr6b-0004Zw-Nn
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLr6V-0001Ds-Sk
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:25:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hLr6H-00017L-MS; Wed, 01 May 2019 11:24:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41604308FED4;
	Wed,  1 May 2019 15:24:47 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EBB37B91F;
	Wed,  1 May 2019 15:24:37 +0000 (UTC)
To: John Snow <jsnow@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20181116184324.8093-1-jsnow@redhat.com>
	<4bc81482-fab6-80dd-f684-4ffde4241dce@virtuozzo.com>
	<cb6469ca-9ba3-1ac7-7c3e-9e6c8c53e55f@redhat.com>
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
Message-ID: <fb05bc7d-7632-f72c-1c32-ba16d21a7fcb@redhat.com>
Date: Wed, 1 May 2019 10:24:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cb6469ca-9ba3-1ac7-7c3e-9e6c8c53e55f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NZ2bxkoyGL4juIOgvnyHGP1wjlx3mAtbj"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 01 May 2019 15:24:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: Silence
 coverity CID 1390625
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501152436.Eed7dmaoQg8JsrMco4uEloDopxyh8eY56OdWwUF_E6o@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NZ2bxkoyGL4juIOgvnyHGP1wjlx3mAtbj
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <fb05bc7d-7632-f72c-1c32-ba16d21a7fcb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: Silence
 coverity CID 1390625
References: <20181116184324.8093-1-jsnow@redhat.com>
 <4bc81482-fab6-80dd-f684-4ffde4241dce@virtuozzo.com>
 <cb6469ca-9ba3-1ac7-7c3e-9e6c8c53e55f@redhat.com>
In-Reply-To: <cb6469ca-9ba3-1ac7-7c3e-9e6c8c53e55f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 6:08 PM, John Snow wrote:
>=20
>=20
> On 11/20/18 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 16.11.2018 21:43, John Snow wrote:
>>> Coverity warns that backing_bs() could give us a NULL pointer, which
>>> we then use without checking that it isn't.
>>>
>>> In our loop condition, we check bs && bs->drv as a point of habit, bu=
t
>>> by nature of the block graph, we cannot have null bs pointers here.
>>>
>>> This loop skips only implicit nodes, which always have children, so
>>> this loop should never encounter a null value.
>>
>=20
> I let this drop again :)
>=20
>> You mean, always have backing (not file for ex.)? Should we at least a=
dd a comment
>> near "bool implicit;" that the node must have backing..
>>
>> Do we have filters, using 'file' child instead of backing, will we wan=
t to auto insert them, and therefore mark them with implicit=3Dtrue?
>>
>=20
> I actually have no idea. I guess this is the sort of thing we actually
> really want a dedicated kind of API for. "Find first non-filter" seems
> like a common use case that we'd want.
>=20
> [But maybe I'll avoid this problem.]

Max has already tried to tackle that problem:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01713.html

>=20
>> And one more thing:
>> So, it's looks like a wrong way to search for all block-nodes, instead=
 of looping through backing chain to the first not-implicit bds, we must =
recursively explore the whole block graph, to find _all_ the bitmaps.
>>
>=20
> Looking at this again after not having done so for so long -- I guess
> that bdrv_first/bdrv_next only iterate over *top level* BDSes and not
> any children thereof. You're right, even the method here isn't quite
> correct. We want to find ALL nodes, wherever they are.
>=20
> query_named_block_nodes uses an implementation in block.c to accomplish=

> this because the API is not public.... or, it wasn't, but it looks like=

> we have bdrv_next_all_states now, and we could use this to just find AL=
L
> of the bdrv nodes.
>=20
> Ehm.... let me send something a little more RFC-caliber that should
> address your concern (as well as Peter's) here.

Max's series also tries to improve how we visit nodes when determining
which bitmaps to find.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--NZ2bxkoyGL4juIOgvnyHGP1wjlx3mAtbj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzJujQACgkQp6FrSiUn
Q2rrgwf/Z4xmDq0VHvF3495unToxko7PShHyR5SSiF5FCuN+WV1m3XyDdJNzWawO
qzo1XZ+4aTMmSocXBXggY359d0GkgXpMZo+dxuvp2Sqox0Pft34WfkYQz05RlG82
vYW1LMzyAlUmg9SwKTf2YnOBfA2nV7cK+HT26gReCcozifJHz6IMsw6iBqUvihln
RBmbM5xTmPuynscwL6EuCw00ngQK9KBDC6oaI2cXoWs1O8qGF4XK5CRY43FbOMXE
CiewuU//VoJEJ6k+mkVfzcZAAd1YH+GZGtfrbt/G85TzS+26DjMvMaclX/ONq9PP
3y0xnNVsAvUk9bl8enkZiyNJONXqXA==
=0q0G
-----END PGP SIGNATURE-----

--NZ2bxkoyGL4juIOgvnyHGP1wjlx3mAtbj--

