Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D40C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5732070B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5732070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49237 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcHS-0004TQ-5T
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:13:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYcG4-0003Zo-RO
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYcFw-0006sz-Q4
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hYcFl-0006SS-Ne; Wed, 05 Jun 2019 16:11:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A16B481DE1;
	Wed,  5 Jun 2019 20:11:18 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BD103607C5;
	Wed,  5 Jun 2019 20:11:17 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
	<20190605100913.34972-3-vsementsov@virtuozzo.com>
	<cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
	<20190605163710.GP8956@redhat.com>
	<e5a35aeb-21a4-449c-f8d5-9d2ac2968fd5@virtuozzo.com>
	<19a96fc2-7f12-7b30-edef-b3da66eef759@redhat.com>
	<c0df2189-d90a-8a58-776b-646bbad76976@virtuozzo.com>
	<20190605173601.GB13261@redhat.com>
	<d8d3da39-d136-a7b1-5ad4-ad3742f8ffa1@redhat.com>
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
Message-ID: <930cdbf0-c382-a2b5-4d8b-659396c9bd5d@redhat.com>
Date: Wed, 5 Jun 2019 15:11:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d8d3da39-d136-a7b1-5ad4-ad3742f8ffa1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lyS0iZLW8ZiSjouYVBT5yO5PqZ8Y5GLEd"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 05 Jun 2019 20:11:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] nbd-server-add [was: [PATCH 2/2] nbd-client: enable
 TCP keepalive]
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
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lyS0iZLW8ZiSjouYVBT5yO5PqZ8Y5GLEd
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <930cdbf0-c382-a2b5-4d8b-659396c9bd5d@redhat.com>
Subject: nbd-server-add [was: [PATCH 2/2] nbd-client: enable TCP keepalive]
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
 <20190605100913.34972-3-vsementsov@virtuozzo.com>
 <cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
 <20190605163710.GP8956@redhat.com>
 <e5a35aeb-21a4-449c-f8d5-9d2ac2968fd5@virtuozzo.com>
 <19a96fc2-7f12-7b30-edef-b3da66eef759@redhat.com>
 <c0df2189-d90a-8a58-776b-646bbad76976@virtuozzo.com>
 <20190605173601.GB13261@redhat.com>
 <d8d3da39-d136-a7b1-5ad4-ad3742f8ffa1@redhat.com>
In-Reply-To: <d8d3da39-d136-a7b1-5ad4-ad3742f8ffa1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 6/5/19 2:48 PM, Eric Blake wrote:

> This also made me wonder if we should start a deprecation clock to
> improve the nbd-server-start command to use SocketAddress instead of
> SocketAddressLegacy.  If we revive Max's work on implementing a default=

> branch for a union discriminator
> (https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01682.html),
> we could have something like:

Re-reading that thread, I see that Markus was arguing for a slightly
different QAPI syntax than Max's proposal, basically:

>=20
> { 'enum': 'NbdSocketAddressHack',
>   'data': [ 'legacy', 'inet', 'unix' ] }
> { 'struct': 'NbdServerAddrLegacy',
>   'data': { 'addr', 'SocketAddressLegacy' } }
> { 'union': 'NbdServerAddr',
>   'base': { 'type': 'NbdSocketAddressHack',
>             '*tls-creds': 'str',
>             '*tls-authz': 'str' },
>   'discriminator': 'type',
>   'default-variant': 'legacy',
>   'data': { 'legacy': 'NbdServerAddrLegacy',
>             'inet', 'InetSocketAddress',
>             'unix', 'UnixSocketAddress' } }
> { 'command', 'nbd-server-start', 'data': 'NbdServerAddr' }

{ 'union': 'NbdServerAddr',
  'base': { '*type': { 'type': 'NbdSocketAddressHack',
                       'default': 'legacy' },
            '*tls-creds', 'str', '*tls-authz', 'str' },
  'discriminator': 'type',
  'data': { 'legacy': 'NbdServerAddrLegacy',
            'inet', 'InetSocketAddress',
            'unix', 'UnixSocketAddress' } }

>=20
> which should be backwards compatible with the existing:
>=20
> { "execute": "nbd-server-start", "arguments": {
>     "tls-authz": "authz0",
>     "addr": { "type": "inet", "data": {
>       "host": "localhost", "port": "10809" } } } }
>=20
> by relying on the discriminator's default expansion to:
>=20
> { "execute": "nbd-server-start", "arguments": {
>     "tls-authz": "authz0",
>     "type": "legacy",
>     "addr": { "type": "inet", "data": {
>       "host": "localhost", "port": "10809" } } } }

But this part remains true - if a flat union has an optional
discriminator, then the discriminator must include a default value,
where omitting the discriminator then results in sane expansion, and
where a careful choice of discriminator default allows legacy syntax to
co-exist with new preferred syntax.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--lyS0iZLW8ZiSjouYVBT5yO5PqZ8Y5GLEd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz4IeQACgkQp6FrSiUn
Q2r4BAf/U31LWboXHOoqmRJdd0WrmSYGU1suU888HFDKn4Y1aARwzscgrLThvpAR
3UnxyrO85lJeI1GCQTR4QrjtiGd7vKVPykmfCprGs5XgNWE7vrBdwmWp7Wby8jQ0
5UwSc7EcUUazS4k/2FYbG/KP0uxrirxIhPyuZH+IFirR+tyxwMm5I11tZM+Ocjld
m7EH0bQ4DxYglMaUUycr1uIQ3SgmzcNpQeA+EkIjMN3DQloYNDwGBzSmzMPyD1P1
oKs1xo+Z+ePNNP209rEkLnDdZOLBLTb9GF9Un+VEnakSXoUE5ndHdAkbD/H7qS+v
mYUxK9QChjhG20p8FIjHXdChreIZsA==
=MJAG
-----END PGP SIGNATURE-----

--lyS0iZLW8ZiSjouYVBT5yO5PqZ8Y5GLEd--

