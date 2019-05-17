Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC91C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B211020873
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B211020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdKK-000577-2w
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:55:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hRdGM-0002HT-GU
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hRdGL-0006fW-HM
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hRdGI-0006a2-UX; Fri, 17 May 2019 09:51:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E17981F25;
	Fri, 17 May 2019 13:51:02 +0000 (UTC)
Received: from [10.3.117.155] (ovpn-117-155.phx2.redhat.com [10.3.117.155])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C679B60852;
	Fri, 17 May 2019 13:50:58 +0000 (UTC)
To: John Snow <jsnow@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190516122725.132334-1-vsementsov@virtuozzo.com>
	<20190516122725.132334-2-vsementsov@virtuozzo.com>
	<04af0995-a4ef-d9cc-b4ca-1a5e837aafe1@redhat.com>
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
Message-ID: <2f7d9ea8-765b-fad1-36d5-225f3b4b2ccc@redhat.com>
Date: Fri, 17 May 2019 08:50:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <04af0995-a4ef-d9cc-b4ca-1a5e837aafe1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2LVIOrGrK6hfK4TRG8k8uqtdZzaxDztCv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 17 May 2019 13:51:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: support external bitmaps in
 block-dirty-bitmap-merge
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
Cc: kwolf@redhat.com, fam@euphon.net, mreitz@redhat.com, den@virtuozzo.com,
	armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2LVIOrGrK6hfK4TRG8k8uqtdZzaxDztCv
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, armbru@redhat.com,
 mreitz@redhat.com
Message-ID: <2f7d9ea8-765b-fad1-36d5-225f3b4b2ccc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: support external bitmaps in
 block-dirty-bitmap-merge
References: <20190516122725.132334-1-vsementsov@virtuozzo.com>
 <20190516122725.132334-2-vsementsov@virtuozzo.com>
 <04af0995-a4ef-d9cc-b4ca-1a5e837aafe1@redhat.com>
In-Reply-To: <04af0995-a4ef-d9cc-b4ca-1a5e837aafe1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/16/19 7:32 PM, John Snow wrote:
>=20
>=20
> On 5/16/19 8:27 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Add new optional parameter making possible to merge bitmaps from
>> different nodes. It is needed to maintain external snapshots during
>> incremental backup chain history.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  qapi/block-core.json | 13 ++++++++++---
>>  block/dirty-bitmap.c |  9 ++++++---
>>  blockdev.c           | 46 ++++++++++++++++++++++++++++++-------------=
-
>>  3 files changed, 48 insertions(+), 20 deletions(-)

>> -# @bitmaps: name(s) of the source dirty bitmap(s)
>> +# @bitmaps: name(s) of the source dirty bitmap(s). The field is optio=
nal
>> +#           since 4.1.
>> +#
>> +# @external-bitmaps: additional list of source dirty bitmaps with spe=
cified
>> +#                    nodes, which allows merging bitmaps between diff=
erent
>> +#                    nodes. (Since: 4.1)
>>  #
>>  # Since: 4.0
>>  ##
>>  { 'struct': 'BlockDirtyBitmapMerge',
>> -  'data': { 'node': 'str', 'target': 'str', 'bitmaps': ['str'] } }
>> +  'data': { 'node': 'str', 'target': 'str', '*bitmaps': ['str'],
>> +            '*external-bitmaps': ['BlockDirtyBitmap'] } }
>> =20
>=20
> I guess you can specify one, or both, or maybe neither! Seems fine.


>=20
> I don't think I like the name "external-bitmaps" but I guess I don't
> really have a better suggestion.

I do - we could use an alternate type instead:

{ 'alternate': 'BitmapSource',
  'data': { 'local': 'str',
             'external': 'BlockDirtyBitmap' } }

then use 'bitmaps': ['BitmapSource']

so that the caller can pass:

"bitmaps": [ "bitmap1", { "node": "other", "name", "bitmap2" } ]

and we only have to deal with one array at all times, and not have the
name 'external-bitmaps' to worry about.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2LVIOrGrK6hfK4TRG8k8uqtdZzaxDztCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzevEEACgkQp6FrSiUn
Q2rMGggAi3ZwBwc4oC5Di/kyGKPU14N9Swa2KDjVsdf1CBelJ4rCs/5tmpOq5IZv
0008017o8Lx1k2/EI3dPVlqNuQw5Wmvyxof+o02/OTGjudt3oYttGY5G0BFrFT0t
spvTBY6uku/dBjCHAF9zTEiRLoodYjeWM1S2VAcIhE2o0JyRUOYlYsNVEWb1D+LD
x0WCZSS4Uladfx8LpM6Rk0fDewgVFzSjYzydZhKBc9I7fv9Pdo9c5e5njZyoevEw
OPIZ9L1RWFhxOQCyjAUkf+C+vlSAIu/6Cu5CGYF89IAxiVOF8IFlP+E1htHrMSDJ
IHJW8mdoxLxpypPLrp3XtX99BYl8MA==
=xkuS
-----END PGP SIGNATURE-----

--2LVIOrGrK6hfK4TRG8k8uqtdZzaxDztCv--

