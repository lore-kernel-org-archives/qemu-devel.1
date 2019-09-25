Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C982C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCBC20874
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCBC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCwDz-0004SE-2Q
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 21:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCwDD-0003yw-Cv
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCwDC-0001E6-39
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:35:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50728)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iCwD7-0001D5-Ej; Tue, 24 Sep 2019 21:35:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C364F8980EF;
 Wed, 25 Sep 2019 01:35:15 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54B0A5D9CC;
 Wed, 25 Sep 2019 01:35:10 +0000 (UTC)
Subject: Re: [PATCH 1/1] dirty-bitmaps: remove deprecated autoload parameter
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190924230143.22551-1-jsnow@redhat.com>
 <20190924230143.22551-2-jsnow@redhat.com>
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
Message-ID: <100c8b98-a240-0a7a-e018-d71615061bc0@redhat.com>
Date: Tue, 24 Sep 2019 20:35:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924230143.22551-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="srHZOqxBBqTqkYzRiUo22jDfBXdmkx78U"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 25 Sep 2019 01:35:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--srHZOqxBBqTqkYzRiUo22jDfBXdmkx78U
Content-Type: multipart/mixed; boundary="X4ClLKwNaXjLJ9Dn4e2tLbeCcq8SOKUAj";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <100c8b98-a240-0a7a-e018-d71615061bc0@redhat.com>
Subject: Re: [PATCH 1/1] dirty-bitmaps: remove deprecated autoload parameter
References: <20190924230143.22551-1-jsnow@redhat.com>
 <20190924230143.22551-2-jsnow@redhat.com>
In-Reply-To: <20190924230143.22551-2-jsnow@redhat.com>

--X4ClLKwNaXjLJ9Dn4e2tLbeCcq8SOKUAj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/24/19 6:01 PM, John Snow wrote:
> This parameter has been deprecated since 2.12.0 and is eligible for
> removal. Remove this parameter as it is actually completely ignored;
> let's not give false hope.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qemu-deprecated.texi | 20 +++++++++++++++-----
>  qapi/block-core.json |  6 +-----
>  blockdev.c           |  6 ------
>  3 files changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 01245e0b1c..d60246d5d6 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi

> +@node Recently removed features
> +@appendix Recently removed features
> +
> +What follows is a record of recently removed, formerly deprecated
> +features that serves as a record for users who have encountered
> +trouble after a recent upgrade.
> +
> +@section QEMU Machine Protocol (QMP) commands
> +
> +@subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)=


Do we want to state 'since 4.2' here, as the point where it was removed?

Otherwise,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--X4ClLKwNaXjLJ9Dn4e2tLbeCcq8SOKUAj--

--srHZOqxBBqTqkYzRiUo22jDfBXdmkx78U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2KxE0ACgkQp6FrSiUn
Q2oMTQgAqQNT/sXeIlKfi7Z6/wErUy+yhz8ZaSsOTkMl+eDaXPftYKyMouFLXyVy
hzvhDC3dU8Gr1j+UfcEz0+EYxuYdTFrztwjchPD5k5g87LL/pSBvfDHW6Q2JuBqT
5V5SDUWHhJS+a/QTH6KROlFshgAfAJKlSZ9/7A1h5DU+4NWbG7uboqFLhfloHe6J
LDOFfQQRFL7ezmi8ANzGFgEH4BdHDwyoTjT80AY/hDZPWau3eVq6PSUfxmFcMFs4
8yqEp2RUl+kaxZ5FrW8Nt42uI5/kICEqhBJksUS4hyxAkY5Vj7R4j1ZoWJeibmSL
lBA72uSc43f6RU4rotIZi5tLf5U+2g==
=ICAt
-----END PGP SIGNATURE-----

--srHZOqxBBqTqkYzRiUo22jDfBXdmkx78U--

