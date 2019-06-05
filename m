Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3955FC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DDD206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DDD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47394 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYZUW-0008Lk-9I
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 13:14:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYZTJ-0007ef-SE
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYZTI-0006eP-Mq
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:13:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hYZTA-0006Ib-Vb; Wed, 05 Jun 2019 13:13:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F16C42CD801;
	Wed,  5 Jun 2019 17:12:58 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 35E5C18E46;
	Wed,  5 Jun 2019 17:12:58 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
	<20190605100913.34972-3-vsementsov@virtuozzo.com>
	<cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
	<20190605163710.GP8956@redhat.com>
	<e5a35aeb-21a4-449c-f8d5-9d2ac2968fd5@virtuozzo.com>
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
Message-ID: <19a96fc2-7f12-7b30-edef-b3da66eef759@redhat.com>
Date: Wed, 5 Jun 2019 12:12:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e5a35aeb-21a4-449c-f8d5-9d2ac2968fd5@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c8GZ1fG4m8jDVlJI7I51gZljI7JrEkTz9"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 05 Jun 2019 17:12:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/2] nbd-client: enable TCP keepalive
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c8GZ1fG4m8jDVlJI7I51gZljI7JrEkTz9
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <19a96fc2-7f12-7b30-edef-b3da66eef759@redhat.com>
Subject: Re: [PATCH 2/2] nbd-client: enable TCP keepalive
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
 <20190605100913.34972-3-vsementsov@virtuozzo.com>
 <cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
 <20190605163710.GP8956@redhat.com>
 <e5a35aeb-21a4-449c-f8d5-9d2ac2968fd5@virtuozzo.com>
In-Reply-To: <e5a35aeb-21a4-449c-f8d5-9d2ac2968fd5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 6/5/19 12:05 PM, Vladimir Sementsov-Ogievskiy wrote:

>> By enabling TCP keepalives we are explicitly making the connection
>> less reliable by forcing it to be terminated when keepalive
>> threshold triggers, instead of waiting longer for TCP to recover.
>>
>> The rationale s that once a connection has been in a hung state for
>> so long that keepalive triggers, its (hopefully) not useful to the
>> mgmt app to carry on waiting anyway.
>>
>> If the connection is terminated by keepalive & the mgmt app then
>> spawns a new client to carry on with the work, what are the risks
>> involved ? eg Could packets from the stuck, terminated, connection
>> suddenly arrive later and trigger I/O with outdated data payload ?
>=20
> Hmm, I believe that tcp guarantees isolation between different connecti=
ons
>=20
>>
>> I guess this is no different a situation from an app explicitly
>> killing the QEMU NBD client process instead & spawning a new one.
>>
>> I'm still feeling a little uneasy about enabling it unconditionally
>> though, since pretty much everything I know which supports keepalives
>> has a way to turn them on/off at least, even if you can't tune the
>> individual timer settings.
>=20
> Hm. So, I can add bool keepalive parameter for nbd format with default =
to true.
> And if needed, it may be later extended to be qapi 'alternate' of bool =
or struct with
> three numeric parameters, corresponding to TCP_KEEPCNT, TCP_KEEPIDLE an=
d TCP_KEEPINTVL .
>=20
> Opinions?

Adding a bool that could later turn into a qapi 'alternate' for
fine-tuning seems reasonable. Defaulting the bool to true is not
backwards-compatible; better would be defaulting it to false and letting
users opt-in; introspection will also work to let you know whether the
feature is present.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--c8GZ1fG4m8jDVlJI7I51gZljI7JrEkTz9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz3+BgACgkQp6FrSiUn
Q2oLGAf/VHL4MkMKRaV6pNUil5qq6jkItgk3Ls3il0xhydOrzz3G12DY9K1pzHuK
9R+Cq+Wj8bGSKb62Dfmakzu9EGoyx/yFZIJOCbTjUn0MKvcBMMkjvCxHr2Z2IyjW
ZDZb/efhjLf8ZGQFKOGDeCR4wZU/RyxL0JQstHK//uTMtrXf+ieb4ZSHybHMUuk1
3rEXYYsSTFh3dxN3746jZz1gfJltpsMJMJdF86VvsOXPUjJz5PYKxUtDtw/PlLpt
UF8RoZxv2bt3thdjCZsTMZLjWDgqZVZ3WNmzWaD0mUcNfDzzw2KCKEKgkY+aYti9
cwxaUw1zU22aR0Zy9xvFoZTL/ZBgPg==
=MX4O
-----END PGP SIGNATURE-----

--c8GZ1fG4m8jDVlJI7I51gZljI7JrEkTz9--

