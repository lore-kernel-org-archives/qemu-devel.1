Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9DAC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 21:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B89216FD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 21:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B89216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgFOo-0001Fd-6v
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 17:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51434)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hgFOG-0000kK-2O
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 17:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hgFOE-00077z-1U
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 17:23:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hgFOB-00073S-5v; Wed, 26 Jun 2019 17:23:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 17D8283F3F;
 Wed, 26 Jun 2019 21:23:28 +0000 (UTC)
Received: from [10.3.116.44] (ovpn-116-44.phx2.redhat.com [10.3.116.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 965815C1B4;
 Wed, 26 Jun 2019 21:23:24 +0000 (UTC)
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190605161804.118956-1-vsementsov@virtuozzo.com>
 <ebef5b9b-d2e9-7097-de61-9213fcb3f4e1@redhat.com>
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
Message-ID: <78233f65-9b07-eea7-e7be-a630a6ad62a9@redhat.com>
Date: Wed, 26 Jun 2019 16:23:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ebef5b9b-d2e9-7097-de61-9213fcb3f4e1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AhxDfbZaG8mPX7cXGpY8Vwkgxnsu8PYzg"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 26 Jun 2019 21:23:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/2] nbd: enable keepalive
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
Cc: kwolf@redhat.com, den@openvz.org, berrange@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AhxDfbZaG8mPX7cXGpY8Vwkgxnsu8PYzg
Content-Type: multipart/mixed; boundary="ddHtmLeAhLj8ciH89vJlxDqnjrMJWca9f";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com, den@openvz.org
Message-ID: <78233f65-9b07-eea7-e7be-a630a6ad62a9@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 0/2] nbd: enable keepalive
References: <20190605161804.118956-1-vsementsov@virtuozzo.com>
 <ebef5b9b-d2e9-7097-de61-9213fcb3f4e1@redhat.com>
In-Reply-To: <ebef5b9b-d2e9-7097-de61-9213fcb3f4e1@redhat.com>

--ddHtmLeAhLj8ciH89vJlxDqnjrMJWca9f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/26/19 4:18 PM, John Snow wrote:
>=20
>=20
> On 6/5/19 12:18 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Here is a suggestion to enable keepalive option to track server availa=
blity.
>> We suggest to enable it by default. If we need, we'll be able to add o=
ption
>> to specify timeout by hand later.
>>
>> v2: 01 - Fix io channel returned errors to be -1 [Daniel]
>>     02 - Fix typo in commit message [Eric]
>>
>> Vladimir Sementsov-Ogievskiy (2):
>>   io/channel: add qio_channel_set_keepalive
>>   nbd-client: enable TCP keepalive
>>
>>  include/io/channel.h | 15 +++++++++++++++
>>  block/nbd-client.c   |  1 +
>>  io/channel-socket.c  | 20 ++++++++++++++++++++
>>  io/channel.c         | 14 ++++++++++++++
>>  4 files changed, 50 insertions(+)
>>
>=20
> Ping -- I think this was good to go with Dan's ACK, based on the
> discussion from v1.

Actually, I thought that we changed tactics, and that the latest version =
is:

https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01989.html

[PATCH v2] qapi: InitSocketAddress: add keepalive option

to make the setting conditional based on blockdev parameters rather than
unconditional.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ddHtmLeAhLj8ciH89vJlxDqnjrMJWca9f--

--AhxDfbZaG8mPX7cXGpY8Vwkgxnsu8PYzg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0T4ksACgkQp6FrSiUn
Q2rqrAgAjqphv294p0ZoXrOQdNSZvyqEhagkjvEQmh9L2pMB6Kfxts7pZa2DH/92
ImGn3ZjxeDDrqp3lA+L5ud/KdaAT89ZjACrNJwrOCoUfMCfw8kNsbLifradaDJrx
6IMevvi3ixp+uSRmQ5fvKW9wLR2ker/BVYgfcylN1KNONSpXzYLIyu9To7X6aNeC
ShzFmTTQoXW2XZdWX/rt/Pabejrq3oaq7WsfVWrV34Kk9v00UvMCTs6Re7NcDamX
aG/PKy4sG6X3IQ+roAsrRC7xoLN8j1rVgHyg/N8I+0OT45jHx+rBt9dP0k/kS7A4
4Mdnqbv/ai0tql+zVWaQ5eZ4SoLNzA==
=aPNV
-----END PGP SIGNATURE-----

--AhxDfbZaG8mPX7cXGpY8Vwkgxnsu8PYzg--

