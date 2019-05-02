Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADFAC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 21:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD482053B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 21:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD482053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMJhd-0004Nn-S3
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 17:57:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJgl-0003yM-UW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJgk-0007As-24
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hMJgh-00076l-CJ; Thu, 02 May 2019 17:56:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 748F930ADBB5;
	Thu,  2 May 2019 21:56:18 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A08875C1B4;
	Thu,  2 May 2019 21:56:17 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
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
Message-ID: <f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
Date: Thu, 2 May 2019 16:56:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="htJ3JxAhi77Np0kEDLvUKYg7sHdllJV5b"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 02 May 2019 21:56:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Failing QEMU iotest 175
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502215616.2KtrwVXlmRA9pES4YpoZ5OA4rEK__MUKkzI7cjltwdc@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--htJ3JxAhi77Np0kEDLvUKYg7sHdllJV5b
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Message-ID: <f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
Subject: Re: Failing QEMU iotest 175
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
In-Reply-To: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/28/19 10:18 AM, Thomas Huth wrote:
> QEMU iotest 175 is failing for me when I run it with -raw:
>=20

>  =3D=3D creating image with default preallocation =3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
> -size=3D1048576, blocks=3D0
> +size=3D1048576, blocks=3D2

What filesystem? It should be fairly obvious that 'stat -c blocks=3D%b' i=
s
file-system dependent (some allocate slightly more or less space, based
on granularities and on predictions of future use), so we may need to
update the test to apply a filter or otherwise allow a bit of fuzz in
the answer. But 0/2 is definitely different than...
>=20
>  =3D=3D creating image with preallocation off =3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocat=
ion=3Doff
> -size=3D1048576, blocks=3D0
> +size=3D1048576, blocks=3D2
>=20
>  =3D=3D creating image with preallocation full =3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocat=
ion=3Dfull
> -size=3D1048576, blocks=3D2048
> +size=3D1048576, blocks=3D2050

2048/2050, so we DO have some indication of whether the file is sparse
or fully allocated.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--htJ3JxAhi77Np0kEDLvUKYg7sHdllJV5b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzLZ4AACgkQp6FrSiUn
Q2odjQf+JHrJqseIHIJZQQB9W1pnUI0Tw/5vM1hppVwUG9xi1bAd01BssvIAFSYe
kCaPGCqLxZoJHM2IOXoQKb9uRERUeDAwci8aWzS+slfjOfUpeNgF1XzUCyjWiHUB
S6vsMmBpHoucrbXhNdXoT3Z3+VizQKY7w9RLLpeOFqURlyG8FKKT1RJEoxYwgeeI
EqcYQbD4Ql6eygDXG7tGgv2kmB/8mqkW3LsGzV6rkwxwXbEvTDkLwgNUH6OZUFdN
TI2pEMVJjMsufJpTr81TGA3RXphxkzgTrvILZt2Orc1XG2IYSbqnvdJpePwctqHf
ctjK1lRtR9kA0tPyp4wPVDAGaRUTSw==
=+Des
-----END PGP SIGNATURE-----

--htJ3JxAhi77Np0kEDLvUKYg7sHdllJV5b--

