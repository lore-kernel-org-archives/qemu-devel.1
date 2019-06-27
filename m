Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84857C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0D22146E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0D22146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXK6-0003Lj-8d
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36599)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hgWTN-0006r3-6R
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hgWTL-000366-ME
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13783)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hgWTG-0002wD-AP; Thu, 27 Jun 2019 11:37:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A25A8285B4;
 Thu, 27 Jun 2019 15:37:53 +0000 (UTC)
Received: from [10.3.116.142] (ovpn-116-142.phx2.redhat.com [10.3.116.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5CA660126;
 Thu, 27 Jun 2019 15:37:52 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190626024942.29758-1-eblake@redhat.com>
 <20190626082251.GA29008@redhat.com>
 <a3418db6-4bb4-029e-8a5d-d9e6b1185f22@redhat.com>
 <20190627145850.GN12358@redhat.com>
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
Message-ID: <fd45bfbe-f8a3-afd9-1230-798f4c647d30@redhat.com>
Date: Thu, 27 Jun 2019 10:37:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627145850.GN12358@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SSf8SMWCiJ474UWdKl8hmADN2xC7Ivz7s"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 27 Jun 2019 15:37:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Permit TLS with Unix sockets
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
Cc: qemu-devel@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>, rjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SSf8SMWCiJ474UWdKl8hmADN2xC7Ivz7s
Content-Type: multipart/mixed; boundary="892I7ZPAfaPTWrCcMyC1q7OZ3csgscr7l";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <fd45bfbe-f8a3-afd9-1230-798f4c647d30@redhat.com>
Subject: Re: [PATCH] qemu-nbd: Permit TLS with Unix sockets
References: <20190626024942.29758-1-eblake@redhat.com>
 <20190626082251.GA29008@redhat.com>
 <a3418db6-4bb4-029e-8a5d-d9e6b1185f22@redhat.com>
 <20190627145850.GN12358@redhat.com>
In-Reply-To: <20190627145850.GN12358@redhat.com>

--892I7ZPAfaPTWrCcMyC1q7OZ3csgscr7l
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/27/19 9:58 AM, Daniel P. Berrang=C3=A9 wrote:

>>>
>>> Do you need something on the client side too ?
>>
>> The proposal that Rich is working on for standardized NBD URIs [1] say=
s
>> that we need a patch to support nbds://host/export and
>> nbds+unix://export?socket=3D/path as ways to request an encrypted clie=
nt
>> connection with default encryption parameters. For anything more
>> complex, we have to use --imageopts and request an encrypted connectio=
n
>> by parts - but the QAPI schema already permits us to pass in an
>> 'tls-creds' parameter for both TCP and Unix sockets, so no, I don't
>> think we need any client side changes at this point.

Okay, I just tested that pre-patch, qemu-nbd --list refuses to connect,
but post-patch it works:

$ ./qemu-nbd -r -k /tmp/nbdsock --object \
  tls-creds-psk,id=3Dtls0,endpoint=3Dserver,dir=3D/home/eblake/libnbd/tes=
ts \
  --tls-creds tls0 -f raw -x / ./file
$ qemu-nbd --list -k /tmp/nbdsock --object \

tls-creds-psk,id=3Dtls0,endpoint=3Dclient,dir=3D/home/eblake/libnbd/tests=
,username=3Deblake
\
  --tls-creds tls0
qemu-nbd: TLS is only supported with IPv4/IPv6
$ ./qemu-nbd --list -k /tmp/nbdsock --object \

tls-creds-psk,id=3Dtls0,endpoint=3Dclient,dir=3D/home/eblake/libnbd/tests=
,username=3Deblake
\
  --tls-creds tls0
exports available: 1
=2E..

>=20
> The QAPI schema isn't what I was thinking about....  in block/nbd.c
> we have the same restriction you lifted here
>=20
>         tlscreds =3D nbd_get_tls_creds(s->tlscredsid, errp);
>         if (!tlscreds) {
>             goto error;
>         }
>=20
>         /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET6=
 */
>         if (s->saddr->type !=3D SOCKET_ADDRESS_TYPE_INET) {
>             error_setg(errp, "TLS only supported over IP sockets");
>             goto error;
>         }

Oh. Yeah, I'll have to fix that; it's different than qemu-nbd --list.

>=20
> For client side we would also need to allow a 'tls-hostname' parameter
> in BlockdevOptionsNbd, so that the client can pass a hostname to use
> for validating the x509 certificate, the same way we allow for live
> migration.

Okay, v2 coming up later, once I've done more integration testing.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--892I7ZPAfaPTWrCcMyC1q7OZ3csgscr7l--

--SSf8SMWCiJ474UWdKl8hmADN2xC7Ivz7s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl0U4tAACgkQp6FrSiUn
Q2pNuAf/WyiDmacuqI5lvvA9PwERxevsYEo0+8y8tzpafFjES0FYuw6Rg2t2ET6S
OdIwKyOistECKwsX1XaM9AsKM+6L0tUeaQuO/zHPWfcyvDPLvGqBjkzGhoJdRQsY
f33/arSqQe5StEvOALfMpCgOvcrqt7F7vO9vwIBzQ4JAHRcTGNe2KQXuax8JHtMn
YNzHSUwP4+qsRJuzhH2JBrXTpyAyta7Aug+07ijCBy17JS9eZYt83xf0ZenWXYwd
v3i/ngI+hU+5V45JU8uw+NEWMZyJpX95D+yqCP6Z04SiKEqzod5CvGoEEO30OKkc
SqSKcix3qdutYFh+YWTuMRKf01IR9A==
=l4fw
-----END PGP SIGNATURE-----

--SSf8SMWCiJ474UWdKl8hmADN2xC7Ivz7s--

