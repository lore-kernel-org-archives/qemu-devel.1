Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAA8C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597962080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597962080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZg1-0003Eh-JQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:48:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLZVW-0002ST-74
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLZK1-0005cU-OJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:25:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hLZK1-0005c5-FY; Tue, 30 Apr 2019 16:25:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60B7B7D0E3;
	Tue, 30 Apr 2019 20:25:48 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D745481761;
	Tue, 30 Apr 2019 20:25:43 +0000 (UTC)
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
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
Message-ID: <c95d2923-45b2-9acf-9cc6-aa4b9e102e48@redhat.com>
Date: Tue, 30 Apr 2019 15:25:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vwUTT9KnyvxvWWJtIqBsVFwUDYzqyS7Kk"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 30 Apr 2019 20:25:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v1 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430202542.akilZymwRvYju6VWxpsJPrKLs-K39UfZElI_AzdNyVw@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vwUTT9KnyvxvWWJtIqBsVFwUDYzqyS7Kk
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>
Message-ID: <c95d2923-45b2-9acf-9cc6-aa4b9e102e48@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
References: <cover.1556650594.git.alistair.francis@wdc.com>
 <81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 3:08 PM, Alistair Francis wrote:
> Fix this warning when building with GCC9 on Fedora 30:
> In function =E2=80=98strncpy=E2=80=99,
>     inlined from =E2=80=98unix_connect_saddr.isra.0=E2=80=99 at util/qe=
mu-sockets.c:925:5:
> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_=
strncpy=E2=80=99 specified bound 108 equals destination size [-Werror=3Ds=
tringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (=
__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> In function =E2=80=98strncpy=E2=80=99,
>     inlined from =E2=80=98unix_listen_saddr.isra.0=E2=80=99 at util/qem=
u-sockets.c:880:5:
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  util/qemu-sockets.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 9705051690..4322652428 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -877,7 +877,7 @@ static int unix_listen_saddr(UnixSocketAddress *sad=
dr,
> =20
>      memset(&un, 0, sizeof(un));
>      un.sun_family =3D AF_UNIX;
> -    strncpy(un.sun_path, path, sizeof(un.sun_path));
> +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);

NACK. Linux allows you to use the full width of un.sun_path (a NUL
terminator is required if you copy less than that, but not if you use
the full width). Rather, we may need to mark path as a potential
nonstring to silence the warning, or use memcpy instead of strncpy, or
some other workaround.  (Sadly, this is one of those odd places where
strncpy is actually the right function to use, but there are so many
other places where strncpy is used incorrectly that it has turned into a
battle to use it here)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vwUTT9KnyvxvWWJtIqBsVFwUDYzqyS7Kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIr0cACgkQp6FrSiUn
Q2qhfAf6A4XRQzZYPJPr+0k1Qi6GF9T/qwSr5w10n2GyZ3ZGSAWHdr4Qt/Le3x3h
PeW5oEgFiKYJFF1I0TZV4Ul1+XVvhljrflVoTxfOHqfUVMwDwaz6rSzOweiIcuhJ
JFsIzJOZRQO+EY7Eus8v2JEs994yviqOjf+ZzxMQogztwtw4EywjLR/KWgLaTCKO
sDO7zUZG/YWqqzyrLiL5SgWVA6BPYHcEKPkNCTWA7Pnsf8e//KB2c+MSi0CNAJMJ
LLqcjOPG2ABR9mUU/tvZFiZBAZ0m+yPC+gtgg36bBt4DlsLGDig2+82dHvBjCaM/
H7p+HiuZdz8cZ/UJqF9UrrzNwDH9UQ==
=kYAw
-----END PGP SIGNATURE-----

--vwUTT9KnyvxvWWJtIqBsVFwUDYzqyS7Kk--

