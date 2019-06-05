Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C7C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879D52083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 19:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879D52083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYbvG-00012C-Fv
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 15:50:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYbuN-0000gw-4q
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYbuL-0003Ha-VS
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 15:49:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hYbuF-00036R-82; Wed, 05 Jun 2019 15:49:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75846308421A;
	Wed,  5 Jun 2019 19:48:51 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2051919C6F;
	Wed,  5 Jun 2019 19:48:46 +0000 (UTC)
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
Message-ID: <d8d3da39-d136-a7b1-5ad4-ad3742f8ffa1@redhat.com>
Date: Wed, 5 Jun 2019 14:48:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605173601.GB13261@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LJvFiP5KyJSaQR7mN6J6URUXudP6t1NbB"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 05 Jun 2019 19:49:00 +0000 (UTC)
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
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LJvFiP5KyJSaQR7mN6J6URUXudP6t1NbB
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <d8d3da39-d136-a7b1-5ad4-ad3742f8ffa1@redhat.com>
Subject: Re: [PATCH 2/2] nbd-client: enable TCP keepalive
References: <20190605100913.34972-1-vsementsov@virtuozzo.com>
 <20190605100913.34972-3-vsementsov@virtuozzo.com>
 <cd780b66-ab31-1feb-0cce-0b6525df7d79@redhat.com>
 <20190605163710.GP8956@redhat.com>
 <e5a35aeb-21a4-449c-f8d5-9d2ac2968fd5@virtuozzo.com>
 <19a96fc2-7f12-7b30-edef-b3da66eef759@redhat.com>
 <c0df2189-d90a-8a58-776b-646bbad76976@virtuozzo.com>
 <20190605173601.GB13261@redhat.com>
In-Reply-To: <20190605173601.GB13261@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 6/5/19 12:36 PM, Daniel P. Berrang=C3=A9 wrote:

>>
>> Ok.
>>
>> One more thing to discuss then. Should I add keepalive directly to Blo=
ckdevOptionsNbd?
>>
>> Seems more useful to put it into SocketAddress, to be reused by other =
socket users..
>> But "SocketAddress" sounds like address, not like address+connection-o=
ptions. On
>> the other hand, structure names are not part of API. So, finally, is I=
netSocketAddress
>> a good place for such thing?
>=20
> That's an interesting idea. Using InetSocketAddress would mean that we =
could
> get support for this enabled "for free" everywhere in QEMU that uses an=

> InetSocketAddress as its master config format.

I like the idea as well.

>=20
> Of course there's plenty of places not using InetSocketAddress that wou=
ld
> still require some glue to wire up the code which converts the custom
> format into InetSocketAddress

Hmm - how many places are we using InetSocketAddress (which allows an
optional 'to' port value) when we really meant InetSocketAddressBase?
There may be some interesting hierarchy decisions to consider on where
we stick a keepalive option.

This also made me wonder if we should start a deprecation clock to
improve the nbd-server-start command to use SocketAddress instead of
SocketAddressLegacy.  If we revive Max's work on implementing a default
branch for a union discriminator
(https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01682.html),
we could have something like:

{ 'enum': 'NbdSocketAddressHack',
  'data': [ 'legacy', 'inet', 'unix' ] }
{ 'struct': 'NbdServerAddrLegacy',
  'data': { 'addr', 'SocketAddressLegacy' } }
{ 'union': 'NbdServerAddr',
  'base': { 'type': 'NbdSocketAddressHack',
            '*tls-creds': 'str',
            '*tls-authz': 'str' },
  'discriminator': 'type',
  'default-variant': 'legacy',
  'data': { 'legacy': 'NbdServerAddrLegacy',
            'inet', 'InetSocketAddress',
            'unix', 'UnixSocketAddress' } }
{ 'command', 'nbd-server-start', 'data': 'NbdServerAddr' }

which should be backwards compatible with the existing:

{ "execute": "nbd-server-start", "arguments": {
    "tls-authz": "authz0",
    "addr": { "type": "inet", "data": {
      "host": "localhost", "port": "10809" } } } }

by relying on the discriminator's default expansion to:

{ "execute": "nbd-server-start", "arguments": {
    "tls-authz": "authz0",
    "type": "legacy",
    "addr": { "type": "inet", "data": {
      "host": "localhost", "port": "10809" } } } }

but also permit the flatter:

{ "execute": "nbd-server-start", "arguments": {
    "tls-authz": "authz0",
    "type": "inet", "host": "localhost", "port": "10809" } }

and let us start a deprecation clock to get rid of the "legacy" branch
(especially if coupled with Kevin's work on adding introspectable
deprecation annotations in QAPI).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--LJvFiP5KyJSaQR7mN6J6URUXudP6t1NbB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz4HJ0ACgkQp6FrSiUn
Q2rSBAf+IYia3h6pWHlFEScRSvqPUs+s53+zd4i2HENBtTz46ddJzD5FtAFk6+yk
Yw322kXid3smV2tUpT1hfZuCXZ4Vpm3hhR2z0qkvErNiGwddKWBB3advZCiLjIQ4
RtsZ58olzMKjIIMy0qRSwgSLbnLPoGGCcZiEUYf2zZz74d5P7sUazX7BJoVajIY4
EYO6YllbboshENuLyffnvX0xrS1mTA+aUGwHFdnXzk8R/nr72/FhK0dqB4foqPKF
FUMnJaxYPE7e7pkQ0tLnlyxqtQb/4tzpSTD9r1U2UE0IBeyM105MsRdiW6e98cKj
kRsehFyBpcYcHA5LvDRAgcoH74ru4g==
=A6RV
-----END PGP SIGNATURE-----

--LJvFiP5KyJSaQR7mN6J6URUXudP6t1NbB--

