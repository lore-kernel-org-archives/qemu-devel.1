Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C84C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 20:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9C42146F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 20:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9C42146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46374 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCVH2-0007Ji-T7
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 16:17:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hCVFQ-000650-EE
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hCVFO-0006pl-Pz
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hCVF1-0006Fy-FQ; Fri, 05 Apr 2019 16:15:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D620C3082206;
	Fri,  5 Apr 2019 19:38:50 +0000 (UTC)
Received: from [10.3.116.67] (ovpn-116-67.phx2.redhat.com [10.3.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 529136063A;
	Fri,  5 Apr 2019 19:38:50 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190405191635.25740-1-mreitz@redhat.com>
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
Message-ID: <6ef529c2-714e-0764-d259-7bf65e8cd273@redhat.com>
Date: Fri, 5 Apr 2019 14:38:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405191635.25740-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="395omYHbbIFfEXpopBKmqDW2bfbacP0l7"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 05 Apr 2019 19:38:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.1] qemu-nbd: Look up flag names in
 array
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405193849.IvS1jB1lY3M6qinhMsE3OPWKd-OEaJF0ubM8vvHD6SM@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--395omYHbbIFfEXpopBKmqDW2bfbacP0l7
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6ef529c2-714e-0764-d259-7bf65e8cd273@redhat.com>
Subject: Re: [PATCH for-4.1] qemu-nbd: Look up flag names in array
References: <20190405191635.25740-1-mreitz@redhat.com>
In-Reply-To: <20190405191635.25740-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/19 2:16 PM, Max Reitz wrote:
> The existing code to convert flag bits into strings looks a bit strange=

> now, and if we ever add more flags, it will look even stranger.  Preven=
t
> that from happening by making it look up the flag names in an array.

At one point, I even considered using a QAPI type and expressing things
in a way where we could add an --output=3Djson and/or use our existing
QObject-to-human-readable formatters instead of open-coding things in
qemu-nbd.  But this patch is worthwhile in the meantime.

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Looking at the diff stat I can't claim this patch really improves
> anything by much, but the current code just pains me so.
> ---
>  include/block/nbd.h | 38 +++++++++++++++++++++++++------------
>  qemu-nbd.c          | 46 +++++++++++++++++----------------------------=

>  2 files changed, 43 insertions(+), 41 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Will apply through my NBD tree for 4.1 (no semantic change, so -rc3 is
indeed too late for taking this into 4.0)

Hmm. nbdkit uses a generated header that scrapes the definitions of
various bit values and produces automated value-to-name lookup
functions, rather than having to open-code the lookup functions. Perhaps
we could consider doing similar in qemu for even less code to maintain.


> +                [NBD_FLAG_SEND_CACHE_BIT]           =3D "cache",
> +            };
> +
>              printf("  size:  %" PRIu64 "\n", list[i].size);
>              printf("  flags: 0x%x (", list[i].flags);
> -            if (list[i].flags & NBD_FLAG_READ_ONLY) {
> -                printf(" readonly");
> -            }

I'm also wondering if I should have added another nbd_*_lookup()
function in nbd/common.c to do this lookup (even if we still like the
array approach over open-coding, and whether or not we like the idea of
generating things from the .h, having all of the lookup functions in one
place and style makes more sense than special-casing NBD_FLAG_ lookups
to just live in qemu-nbd.c).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--395omYHbbIFfEXpopBKmqDW2bfbacP0l7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlynrskACgkQp6FrSiUn
Q2q5Qwf8DJuVUGdyefrbTX4TnxssiYEz9M51TzaSGAuGnK+CjYnbLoncC53CPWmt
GaA+nVEE7sJkXENuQzcRIimdZC1KOV0WT7ZOqkHXdLbmZVwitNt9IzfiYa9KNkg1
2WjaySejpS0rI6DXZZupDP0Kame83aI3J5kVr7yD64pvB+S7Lb+xEPolof67TM/f
/3CYAAEKhrkDvCQj7LKaYkG/p+GICxOQR5KZo9HGNZgsKHo+Xup8alwnDmoz85yu
0psNZyi5S8F/UccKChI01smHf0lcO8xfBxY1Wo9i6XljCdEGH9kunFFyER9FSBWs
Diw+A0AlFbaNPiVlyNB/hHqwSBEHXA==
=YN/h
-----END PGP SIGNATURE-----

--395omYHbbIFfEXpopBKmqDW2bfbacP0l7--

