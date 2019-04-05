Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA6C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 20:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9D020989
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 20:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9D020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46699 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCVl5-0001g2-By
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 16:48:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hCVjt-0001Be-2X
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hCVjr-00009c-Lo
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:47:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hCVjm-00089o-Mw
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 16:47:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6E7D81DE0;
	Fri,  5 Apr 2019 19:30:41 +0000 (UTC)
Received: from [10.3.116.67] (ovpn-116-67.phx2.redhat.com [10.3.116.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D7A201001DF9;
	Fri,  5 Apr 2019 19:30:40 +0000 (UTC)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
	qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
	pbonzini@redhat.com, e.emanuelegiuseppe@gmail.com
References: <20190405184037.16799-1-dgilbert@redhat.com>
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
Message-ID: <b0340220-870c-c3a6-9ce8-592ae2f6e061@redhat.com>
Date: Fri, 5 Apr 2019 14:30:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405184037.16799-1-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f63j5Yw2EoHyf37xmyea0nSW1T44oVe5p"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 05 Apr 2019 19:30:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.0] test qgraph.c: Fix segs due to out
 of scope default
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405193039.2I7wmbw5m9vrNs5TGhknVPogt-B6OtBqT7eN7DRog7E@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f63j5Yw2EoHyf37xmyea0nSW1T44oVe5p
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, e.emanuelegiuseppe@gmail.com
Message-ID: <b0340220-870c-c3a6-9ce8-592ae2f6e061@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0] test qgraph.c: Fix segs due to out
 of scope default
References: <20190405184037.16799-1-dgilbert@redhat.com>
In-Reply-To: <20190405184037.16799-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/5/19 1:40 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> The test uses the trick:
>    if (!opts) {
>      opts =3D &(QOSGraph...Options) { };
>    }
>=20
>   in a couple of places, however the temporary created
> by the &() {}  goes out of scope at the bottom of the if,
> and results in a seg or assert when opts-> fields are
> used (on fedora 30's gcc 9).
>=20
> Fixes: fc281c802022cb3a73a5
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/libqos/qgraph.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Fixing it for 4.0 would be nice (we can't promise that everything in 4.0
is clean for gcc 9, but as long as we have to do -rc3 anyways, fixing
undefined behavior into something well-defined like this seems reasonable=
)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--f63j5Yw2EoHyf37xmyea0nSW1T44oVe5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlynrN8ACgkQp6FrSiUn
Q2pYJwf7Bz9t8TrzBGBhG/XemR+x0MtuDQBcuzMiOEOP40oigL5VpTbPzikxqWck
ECd4snSHIa4TGbL527KKYPgGzm4+cl3PLLZjjmXUbQhFRQU6ZzJLJ8PJaMpUzciN
uBafbIPSJgHPMw0sZBrxkMhrJWDam/Auo/IFfQ4D20TvvrRVCiw5xZUvDGxSYa2v
+hsS8jTqkjFvs0Ps14+3C8IWyJu5QeWvUWbHLrzkKtzz1metx91W5Uf6CuKdbC51
DHG+v5qTCmO/9L1hrIrSbiTxjE8gVahfsQ9ISST9fgnBAmOQtAE2UmQeWv7xsoQ4
fjuHIt8ruryOvKY+NOjQZclALodDfg==
=rdjJ
-----END PGP SIGNATURE-----

--f63j5Yw2EoHyf37xmyea0nSW1T44oVe5p--

