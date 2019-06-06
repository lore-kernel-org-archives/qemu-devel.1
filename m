Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00183C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBECC2083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBECC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34388 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYujt-0000r4-Ui
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 11:55:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYuj9-0000YM-0x
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hYuj6-0005O3-6B
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:54:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hYuj1-0004pG-Nt; Thu, 06 Jun 2019 11:54:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D74B530C0DE6;
	Thu,  6 Jun 2019 15:54:19 +0000 (UTC)
Received: from [10.3.116.85] (ovpn-116-85.phx2.redhat.com [10.3.116.85])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D9FD7BE92;
	Thu,  6 Jun 2019 15:54:16 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190606153803.5278-1-armbru@redhat.com>
	<20190606153803.5278-7-armbru@redhat.com>
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
Message-ID: <2d2f4567-1b35-6586-e195-a89b398e676c@redhat.com>
Date: Thu, 6 Jun 2019 10:54:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606153803.5278-7-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CQom1Q6zKHat1YzADbTdBrdxViQj1zdvp"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 06 Jun 2019 15:54:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 6/7] file-posix: Add dynamic-auto-read-only
 QAPI feature
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CQom1Q6zKHat1YzADbTdBrdxViQj1zdvp
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org
Message-ID: <2d2f4567-1b35-6586-e195-a89b398e676c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/7] file-posix: Add dynamic-auto-read-only
 QAPI feature
References: <20190606153803.5278-1-armbru@redhat.com>
 <20190606153803.5278-7-armbru@redhat.com>
In-Reply-To: <20190606153803.5278-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 6/6/19 10:38 AM, Markus Armbruster wrote:
> From: Kevin Wolf <kwolf@redhat.com>
>=20
> In commit 23dece19da4 ('file-posix: Make auto-read-only dynamic') ,
> auto-read-only=3Don changed its behaviour in file-posix for the 4.0
> release. This change cannot be detected through the usual mechanisms
> like schema introspection. Add a new feature flag to the schema to
> allow libvirt to detect the presence of the new behaviour.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1defcde048..f5e1ee91f9 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2859,6 +2859,15 @@
>  #                         file is large, do not use in production.
>  #                         (default: off) (since: 3.0)
>  #
> +# Features:
> +# @dynamic-auto-read-only: If present, enabled auto-read-only means th=
at the
> +#                          driver will open the image read-only at fir=
st,
> +#                          dynamically reopen the image file read-writ=
e when
> +#                          the first writer is attached to the node an=
d reopen
> +#                          read-only when the last writer is detached.=
 This
> +#                          allows to give QEMU write permissions only =
on demand

s/allows to give/allows giving/

> +#                          when an operation actually needs write acce=
ss.
> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsFile',
> @@ -2868,7 +2877,9 @@
>              '*aio': 'BlockdevAioOptions',
>  	    '*drop-cache': {'type': 'bool',
>  	                    'if': 'defined(CONFIG_LINUX)'},
> -            '*x-check-cache-dropped': 'bool' } }
> +            '*x-check-cache-dropped': 'bool' },
> +  'features': [ { 'name': 'dynamic-auto-read-only',
> +                  'if': 'defined(CONFIG_POSIX)' } ] }
> =20
>  ##
>  # @BlockdevOptionsNull:
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--CQom1Q6zKHat1YzADbTdBrdxViQj1zdvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlz5NygACgkQp6FrSiUn
Q2oIOQgAleKXU45yce9Bdv3OIM3FZi6wRnxwyClib4OKX2KPv17CPY6awNcPt6VC
+87KRieW98X/r60LYkcF7g4AC/CqO4nOs4dvbAeAmvwQd5Vzy5/EQn29MSc3Vur1
t4MN5JYU1Vffdjuupg9OQx2SGispR+jseho0eezJSk1uH1/2BwIDRIpJ5SD70V4A
U/S1tXHypnTih3DX+Fca5VrTbEqw3ZSTBwOecZnFrwfkZx1Qik6Uz1gzssW0kL4D
gt4BuWPhY0gS7wjubXLSXSpVmUlmD0BxRuZZ7Mx/y+1e73ATGMEFe2h80rk8Lct/
yMGH+d45STnDpsSDK/hO8hqU1+p6pA==
=0Bf5
-----END PGP SIGNATURE-----

--CQom1Q6zKHat1YzADbTdBrdxViQj1zdvp--

