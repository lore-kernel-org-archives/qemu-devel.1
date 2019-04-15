Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B8C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40662075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 16:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40662075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG4Ly-0005z3-QU
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 12:21:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4Kc-0005F5-9o
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4Kb-00033I-CV
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:19:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hG4Ka-00031x-UF
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:19:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3ECC9369CA;
	Mon, 15 Apr 2019 16:19:40 +0000 (UTC)
Received: from [10.3.117.110] (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 821F6608C1;
	Mon, 15 Apr 2019 16:19:37 +0000 (UTC)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org
References: <20190415154906.14621-1-marcandre.lureau@redhat.com>
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
Message-ID: <86b16e27-781b-d298-a1c8-afd27972f000@redhat.com>
Date: Mon, 15 Apr 2019 11:19:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415154906.14621-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iFdUrPtVr1DKGQXpaa6M0wHa7v8rkKZrB"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 15 Apr 2019 16:19:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.0?] socket: allow wait=false for
 client socket
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415161936.TsykqHaGNsDdDH3LhGwLFbtMVIiHE1H9AB0jjUFFl_o@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iFdUrPtVr1DKGQXpaa6M0wHa7v8rkKZrB
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <86b16e27-781b-d298-a1c8-afd27972f000@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0?] socket: allow wait=false for client
 socket
References: <20190415154906.14621-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190415154906.14621-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/15/19 10:49 AM, Marc-Andr=C3=A9 Lureau wrote:
> Commit 767abe7 ("chardev: forbid 'wait' option with client sockets")
> is a bit too strict. Current libvirt always set wait=3Dfalse, and will
> thus fail to add client chardev.
>=20
> Make the code more permissive, allowing wait=3Dfalse with client socket=

> chardevs.
>=20
> Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

According to Fixes, this is a regression in 4.0. Is it worth having this
fix in -rc4?

>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 3916505d67..2ad9c9eea5 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1262,7 +1262,7 @@ static bool qmp_chardev_validate_socket(ChardevSo=
cket *sock,
>              error_setg(errp, "%s", "Websocket client is not implemente=
d");
>              return false;
>          }
> -        if (sock->has_wait) {
> +        if (sock->has_wait && sock->wait) {
>              error_setg(errp, "%s",
>                         "'wait' option is incompatible with "
>                         "socket in client connect mode");
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--iFdUrPtVr1DKGQXpaa6M0wHa7v8rkKZrB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly0rxgACgkQp6FrSiUn
Q2pdmwf7Br/xHtQLfu3jN9Yb0MD6vkz4P+KBYwQ7iCXaRR+4PKnUxWcvpOktlJJM
/+4p3MC1l5naP1zJ6Ls3LJC3iirdahMmH0U0wLG/1WV9s5IMAlDCw/57Vu5TQ8AF
Sp0VATl/bpMQ64D+uVFe+R1wridVlYRYKmC/2vq1A2fTl1xKNhYvYBKmQnnDHeVL
tX51/adCTqdOIa4tqPtG/5hexPk7mLtNgG5uvqfrP1KNrmHAVMRnEjYgaaxElhP2
WeJsz3x1Ohgl6btqX7Bwnpyuhauw8AeuLVIrQNtspwT0u+oBgP1O+uXQwC7TGo8t
JeIEyrzk6g4Wl7eWkLAt+BR4Z8AjQQ==
=+2DL
-----END PGP SIGNATURE-----

--iFdUrPtVr1DKGQXpaa6M0wHa7v8rkKZrB--

