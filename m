Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738D2C31E41
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3222085A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3222085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haLTP-0007Mn-9v
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1haLR3-0005fK-1Y
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1haLMt-0001mw-UF
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:33:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1haLMs-0001kr-Ig; Mon, 10 Jun 2019 10:33:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CAFA581E00;
 Mon, 10 Jun 2019 14:33:39 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 262331001B36;
 Mon, 10 Jun 2019 14:33:36 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-7-vsementsov@virtuozzo.com>
 <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
 <76780fdb-4c00-a8bd-4323-15bdd403fbaf@virtuozzo.com>
 <46bd12f6-8df7-ed2d-b85a-cd621c146e27@virtuozzo.com>
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
Message-ID: <a0e798ec-9463-90c4-e4c5-fc8e2e61e9f3@redhat.com>
Date: Mon, 10 Jun 2019 09:33:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <46bd12f6-8df7-ed2d-b85a-cd621c146e27@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M3V9pZgpXymkxw1KDKsYFLi2Wgv2RfFNI"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 10 Jun 2019 14:33:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 6/7] block/nbd-client: nbd reconnect
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M3V9pZgpXymkxw1KDKsYFLi2Wgv2RfFNI
Content-Type: multipart/mixed; boundary="7fHykIZHw6DTxfQW9cNmy6UI0Lpsp2IpG";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <a0e798ec-9463-90c4-e4c5-fc8e2e61e9f3@redhat.com>
Subject: Re: [PATCH v6 6/7] block/nbd-client: nbd reconnect
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-7-vsementsov@virtuozzo.com>
 <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
 <76780fdb-4c00-a8bd-4323-15bdd403fbaf@virtuozzo.com>
 <46bd12f6-8df7-ed2d-b85a-cd621c146e27@virtuozzo.com>
In-Reply-To: <46bd12f6-8df7-ed2d-b85a-cd621c146e27@virtuozzo.com>

--7fHykIZHw6DTxfQW9cNmy6UI0Lpsp2IpG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/10/19 8:29 AM, Vladimir Sementsov-Ogievskiy wrote:

>> Hmm, and then, include it into BDRVNBDState? I don't remember why didn=
't do
>> it, and now I don't see any reason for it. We store this information a=
nyway
>> for the whole life of the driver..
>>
>> So, if I'm going to refactor it, I have a question: is there a reason =
for
>> layered BDRVNBDState:
>>
>> typedef struct BDRVNBDState {
>>  =C2=A0=C2=A0=C2=A0 NBDClientSession client;
>>
>>  =C2=A0=C2=A0=C2=A0 /* For nbd_refresh_filename() */
>>  =C2=A0=C2=A0=C2=A0 SocketAddress *saddr;
>>  =C2=A0=C2=A0=C2=A0 char *export, *tlscredsid;
>> } BDRVNBDState;
>>
>> and use nbd_get_client_session everywhere instead of simple converting=
 void *opaque
>> to State pointer like in qcow2 for example?
>>
>> The only reason I can imagine is not to share the whole BDRVNBDState, =
and keep
>> things we are using only in nbd.c to be available only in nbd.c.. But =
I've put
>> saddr and export to NBDConnection to be used in nbd-client.c anyway. S=
o, I think
>> it's a good moment to flatten and share BDRVNBDState and drop nbd_get_=
client_session.
>>
>=20
> And if we are here, what is exact purpose of splitting  nbd-client.c fr=
om nbd.c?

I see no strong reasons to keep the separation. If a single large file
is easier to maintain than an arbitrary split between two files, I'm
open to the idea of a patch that undoes the split.


> or need of defining driver callbacks in header file, instead of keeping=
 them together
> with driver struct definition and static (like other block drivers)...
>=20
>=20
> And names of these two files always confused me.. nbd.c is nbd client b=
lock driver, and
> driver is defined here.. But we have nbd-client.c which defines nbd cli=
ent driver too.
> And we also have nbd/client.c (OK, this split I understand of course, b=
ut it increases
> confusion anyway).

I'm also toying with the idea of writing block/nbd.c to utilize the
relatively-new libnbd library, to see if there are any differences in
behavior by offloading NBD access to a 3rd-party library.  But that's
further down the road.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--7fHykIZHw6DTxfQW9cNmy6UI0Lpsp2IpG--

--M3V9pZgpXymkxw1KDKsYFLi2Wgv2RfFNI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz+aj4ACgkQp6FrSiUn
Q2rRSwf/WKHDc3M6I1uD7iAqTIc4aPqp3STYEIWEggcqUOilhLJ4Y1ToGQIIh9cM
3c8MEr+AHu2LWo90Gw5inCBRE76q/IweWzDjboAxfgMZR10pHHWyqEnzE0RuJV1l
REs0zRW4ZjVSMO4lKtVpGcqVThKh9hcGXXq3OGr29rxG0CPOdac92RU1Wfw3E2UJ
9hnYL0+fWa8PX5TMWz7VhlAbUZA1e4hsTNp6vVazLYqb2nN9QbTBFSPyr5OiEyQV
DqBYyyYZ3IYxofXGauJClptgxjeXn09Bj0CD3wAFlmBq6vaVw3citurGDCxojS+S
l97DWf1i/ndNvWt+gmZNg69C31nGmQ==
=BdHz
-----END PGP SIGNATURE-----

--M3V9pZgpXymkxw1KDKsYFLi2Wgv2RfFNI--

