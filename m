Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FCDC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89375227B9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89375227B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpuuP-0005Lx-MD
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 09:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59954)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hpuuD-0004ru-DI
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hpuuC-0007qp-D9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:32:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hpuuA-0007o7-3s; Tue, 23 Jul 2019 09:32:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E5FF30860C0;
 Tue, 23 Jul 2019 13:32:33 +0000 (UTC)
Received: from [10.3.116.46] (ovpn-116-46.phx2.redhat.com [10.3.116.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FE0660852;
 Tue, 23 Jul 2019 13:32:31 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20190723111201.1926-1-thuth@redhat.com>
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
Message-ID: <47356b7f-9486-c66d-8a0f-e2e420b08238@redhat.com>
Date: Tue, 23 Jul 2019 08:32:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190723111201.1926-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3uzMZhWz8yVrrLPCd5RyaKULbUFPonG9W"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 23 Jul 2019 13:32:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests/qemu-iotests: Don't use 'seq' in the
 iotests
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
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3uzMZhWz8yVrrLPCd5RyaKULbUFPonG9W
Content-Type: multipart/mixed; boundary="mA82t6jzwaMEe7Uvbm930knX5KDSvpvbR";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <47356b7f-9486-c66d-8a0f-e2e420b08238@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/qemu-iotests: Don't use 'seq' in the
 iotests
References: <20190723111201.1926-1-thuth@redhat.com>
In-Reply-To: <20190723111201.1926-1-thuth@redhat.com>

--mA82t6jzwaMEe7Uvbm930knX5KDSvpvbR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/23/19 6:12 AM, Thomas Huth wrote:
> The 'seq' command is not available by default on OpenBSD, so these
> iotests are currently failing there. It could be installed as 'gseq'
> from the coreutils package - but since it is using a different name
> there and we are running the iotests with the "bash" shell anyway,
> let's simply use the built-in double parentheses for the for-loops
> instead.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/007            | 2 +-
>  tests/qemu-iotests/011            | 2 +-
>  tests/qemu-iotests/032            | 2 +-
>  tests/qemu-iotests/035            | 2 +-
>  tests/qemu-iotests/037            | 2 +-
>  tests/qemu-iotests/046            | 2 +-
>  tests/qemu-iotests/common.pattern | 4 ++--
>  7 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
> index 6abd402423..7d3544b479 100755
> --- a/tests/qemu-iotests/007
> +++ b/tests/qemu-iotests/007
> @@ -48,7 +48,7 @@ echo
>  echo "creating image"
>  _make_test_img 1M
> =20
> -for i in `seq 1 10`; do
> +for ((i=3D1;i<=3D10;i++)); do

Stylistically, I would have preferred spaces after the ';'.  But that's
not a show-stopper.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--mA82t6jzwaMEe7Uvbm930knX5KDSvpvbR--

--3uzMZhWz8yVrrLPCd5RyaKULbUFPonG9W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl03DG8ACgkQp6FrSiUn
Q2ofKwgAmV8xUGaeJZoCDrOWpRXFuo9iBmTA6jSK9MU7fvQ8e9JXb66g4pQ3zSqF
z9R9y+5lvq3yA2FTn4JVdy0gGKYHzevFNLeXoDr+bzRkB55nrxZe463KIDyx63r1
b5JLHby95VEaVWalWRnfJ2AmrQWI1sWVrzJZ/a+NPEoHTsNtADJ+1lXdJZruHabm
cgTPf1eO+d8pGcCQtgblOux41ATUqFp/fzjRugXzOCUrcE56CBUve9L0xElThMVz
UaLagfCm7a5WNFyooEjB9v19DhVPcq9JMSbZldOwoxSQULWCPg1tbj4LabGEBlEW
gla1RPPqEdFC0D6qmYDi2MvcsqBRig==
=lGmX
-----END PGP SIGNATURE-----

--3uzMZhWz8yVrrLPCd5RyaKULbUFPonG9W--

