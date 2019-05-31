Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE99C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D7025173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D7025173
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44869 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWiyp-0003pU-55
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:58:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hWixM-0002i9-LN
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hWixL-0004a7-98
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hWixD-0004Mf-V6; Fri, 31 May 2019 10:56:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99C70104C1;
	Fri, 31 May 2019 14:56:04 +0000 (UTC)
Received: from [10.3.116.169] (ovpn-116-169.phx2.redhat.com [10.3.116.169])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E14D5877A;
	Fri, 31 May 2019 14:55:59 +0000 (UTC)
To: John Snow <jsnow@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190530143941.241963-1-vsementsov@virtuozzo.com>
	<c7ef8501-0c9f-f21b-1b60-dcd7dba03557@redhat.com>
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
Message-ID: <f9af022a-7acf-bb1c-3d2c-b095bff2e251@redhat.com>
Date: Fri, 31 May 2019 09:55:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c7ef8501-0c9f-f21b-1b60-dcd7dba03557@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6rBj2LhvMearAcziGElQxZbnPaszOFxDe"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 31 May 2019 14:56:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] qapi: add dirty-bitmaps to
 query-named-block-nodes result
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
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com,
	nshirokovskiy@virtuozzo.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6rBj2LhvMearAcziGElQxZbnPaszOFxDe
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org,
 armbru@redhat.com, mreitz@redhat.com
Message-ID: <f9af022a-7acf-bb1c-3d2c-b095bff2e251@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qapi: add dirty-bitmaps to
 query-named-block-nodes result
References: <20190530143941.241963-1-vsementsov@virtuozzo.com>
 <c7ef8501-0c9f-f21b-1b60-dcd7dba03557@redhat.com>
In-Reply-To: <c7ef8501-0c9f-f21b-1b60-dcd7dba03557@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/30/19 11:26 AM, John Snow wrote:
>=20
>=20
> On 5/30/19 10:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Let's add a possibility to query dirty-bitmaps not only on root nodes.=

>> It is useful when dealing both with snapshots and incremental backups.=

>>

>> +++ b/block/qapi.c
>> @@ -78,6 +78,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBacken=
d *blk,
>>          info->backing_file =3D g_strdup(bs->backing_file);
>>      }
>> =20
>> +    if (!QLIST_EMPTY(&bs->dirty_bitmaps)) {
>> +        info->has_dirty_bitmaps =3D true;
>> +        info->dirty_bitmaps =3D bdrv_query_dirty_bitmaps(bs);
>> +    }
>> +
>>      info->detect_zeroes =3D bs->detect_zeroes;
>> =20
>>      if (blk && blk_get_public(blk)->throttle_group_member.throttle_st=
ate) {
>>
>=20
> So query-block uses bdrv_query_info, which calls bdrv_block_device_info=
,
> so we'll duplicate the bitmap output when doing the old-fashioned block=

> query, but that's probably harmless overall.

We already know that none of our existing query- interfaces are sane
(either too little information, or too much).  Duplication starts to
push an interface towards too much (it takes processor time to bundle up
the extra JSON, especially if the other end is not going to care if it
was present). I know Kevin still has somewhere on his to-do list the
implementation of a saner query- command for the information we really
want (about each block, without redundant information, and where we
don't repeat information in a nested manner, but where we also don't
omit information that would otherwise require multiple existing query-
to reconstruct).

>=20
> We can continue to support the output in both places, or we could opt t=
o
> deprecate the older interface; I think this is one of the last chances
> we'd get to do so before libvirt and wider adoption.
>=20
> I think that's probably Eric's choice.

If you want to try to deprecate the old location, introspection at least
works to allow libvirt to know which place to look for it on a given
qemu. If you don't think deprecation is necessary, the duplication is
probably tolerable for now (as ideally we'd be deprecating ALL of our
not-quite-perfect query- block interfaces in favor of whatever sane
interface Kevin comes up with).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6rBj2LhvMearAcziGElQxZbnPaszOFxDe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzxQH4ACgkQp6FrSiUn
Q2rchwf8D4htmZWKqE49D4AvkrI8tvKZ2VDqm2y1zm4ngloF2bINX8VWkoRinvsr
P78nHwOhH5WigC4WSk4J6MUT5wj/vxG86vq9u5mJmq+Dq6ahsYhCSJX6mU3aELUs
gg5EEyqjrSewzZ96Nu13ie7xO3PtrUyIW9x18TwrzCqVq4vt1kuLlOzA37gk3DKq
wNAdLf2zrYcXxnzLbR13VxHQSTJ3AghCPYuJZEm3ytcpMb+6SIFJn+Fjkfr8ai6E
SftnyQGECZqUfvvne/PFZQqI9vpEybg/g0uCrKfLG6YHGj/6qUSHz9u1BzV6kL8w
vDo03n7fQaLUR+1skhcTWfZ5UcuHMg==
=DJJh
-----END PGP SIGNATURE-----

--6rBj2LhvMearAcziGElQxZbnPaszOFxDe--

