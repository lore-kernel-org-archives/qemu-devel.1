Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F306C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077DF20693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077DF20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8jrI-0003sy-0Y
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i8jqK-0003Lk-At
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i8jqJ-0004l4-AT
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:34:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i8jqJ-0004kd-2Z; Fri, 13 Sep 2019 07:34:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A8318980F8;
 Fri, 13 Sep 2019 11:34:22 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4DFE410E;
 Fri, 13 Sep 2019 11:34:21 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <20190912184607.3507-1-eblake@redhat.com>
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
Message-ID: <f604ebfe-0157-81df-a948-18bf9589d880@redhat.com>
Date: Fri, 13 Sep 2019 06:34:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912184607.3507-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0OLxt4MArl96ukrVC5EfwVnHzHs635YKc"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 13 Sep 2019 11:34:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] build: Don't ignore qapi-visit-core.c
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0OLxt4MArl96ukrVC5EfwVnHzHs635YKc
Content-Type: multipart/mixed; boundary="Neh0UhmQ1I6i5ocvaZk5AztnPJ0Z8QzyS";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Message-ID: <f604ebfe-0157-81df-a948-18bf9589d880@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] build: Don't ignore qapi-visit-core.c
References: <20190912184607.3507-1-eblake@redhat.com>
In-Reply-To: <20190912184607.3507-1-eblake@redhat.com>

--Neh0UhmQ1I6i5ocvaZk5AztnPJ0Z8QzyS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

cc: qemu-trivial

On 9/12/19 1:46 PM, Eric Blake wrote:
> This file is version-controlled, and not generated from a .json file.
>=20
> Fixes: bf582c3461b
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.gitignore b/.gitignore
> index e9bbc006d39e..7de868d1eab4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -41,6 +41,7 @@
>  /qapi/qapi-types-*.[ch]
>  /qapi/qapi-types.[ch]
>  /qapi/qapi-visit-*.[ch]
> +!/qapi/qapi-visit-core.c
>  /qapi/qapi-visit.[ch]
>  /qapi/qapi-doc.texi
>  /qemu-doc.html
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Neh0UhmQ1I6i5ocvaZk5AztnPJ0Z8QzyS--

--0OLxt4MArl96ukrVC5EfwVnHzHs635YKc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl17fr0ACgkQp6FrSiUn
Q2qoggf6Akxtu6F3bWZLZ4gBi10IciPc9LfaCa/WheWApsUuc0D84Mxf1MkMbxp7
tdzWQftKU1c7vR2+pCC9o09ERIXkX88HoPxjuxDvRbGJ0p7BUKgAJpNpJaiUIlXZ
lr7uSBgSqs3/WJLPacYqLMzFK3T2djyD5SZ63sHswoPvIkCoZwbdAoyhrJhECpfS
buDM6W9hwAijVI1UTglSesTO5fSANi797rPXgNqk1X1onD27oxWnkqjbscxK/C3A
cRxHqySLZasE4f7yGRP98UjQRq9Urg6+HJFmZydQw0gWji2Pg51BVAHTxFGiIluf
WoJjkHJty+xmI8e2o+l3JBa0nvEmew==
=y+Eo
-----END PGP SIGNATURE-----

--0OLxt4MArl96ukrVC5EfwVnHzHs635YKc--

