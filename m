Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89C8C32751
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 00:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91194217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 00:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91194217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvW8m-0001vL-SQ
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 20:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35242)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hvW8K-0001Rn-Ih
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 20:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hvW8J-0002wo-Be
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 20:18:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hvW8G-0002vv-Rs; Wed, 07 Aug 2019 20:18:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A8453002889;
 Thu,  8 Aug 2019 00:18:16 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D3B5600C6;
 Thu,  8 Aug 2019 00:18:15 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-2-dplotnikov@virtuozzo.com>
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
Message-ID: <325bf443-64fb-ecde-f08a-978e9bede31b@redhat.com>
Date: Wed, 7 Aug 2019 19:18:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704130949.14017-2-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BaTOtfpfpachJiROxzmnbHgXysb5lPYSG"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 08 Aug 2019 00:18:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qcow2: introduce compression type
 feature
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BaTOtfpfpachJiROxzmnbHgXysb5lPYSG
Content-Type: multipart/mixed; boundary="Rr2ui2UNApMBaxv4WJJgOQdzjB5dm6f9m";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <325bf443-64fb-ecde-f08a-978e9bede31b@redhat.com>
Subject: Re: [PATCH v2 1/3] qcow2: introduce compression type feature
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-2-dplotnikov@virtuozzo.com>
In-Reply-To: <20190704130949.14017-2-dplotnikov@virtuozzo.com>

--Rr2ui2UNApMBaxv4WJJgOQdzjB5dm6f9m
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/4/19 8:09 AM, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type=

> feature to QCOW2 header that indicates that *all* compressed clusters
> must be (de)compressed using a certain compression type.
>=20
> It is implied that the compression type is set on the image creation an=
d
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image.
>=20
> The goal of the feature is to add support of other compression algorith=
ms
> to qcow2. For example, ZSTD which is more effective on compression than=
 ZLIB.
> It works roughly 2x faster than ZLIB providing a comparable compression=
 ratio
> and therefore provide a performance advantage in backup scenarios.

provides

>=20
> The default compression is ZLIB. Images created with ZLIB compression t=
ype
> are backward compatible with older qemu versions.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

> +++ b/docs/interop/qcow2.txt
> @@ -109,7 +109,12 @@ in the description of a field.
>                                  An External Data File Name header exte=
nsion may
>                                  be present if this bit is set.
> =20
> -                    Bits 3-63:  Reserved (set to 0)
> +                    Bit 3:      Compression type bit. The bit must be =
set if
> +                                the compression type differs from defa=
ult: zlib.

I'd word this 'from the default of zlib.'

> +                                If the compression type is default the=
 bit must
> +                                be unset.

Why? I see no reason to forbid a qcow2 image that has the incompatible
bit set but still uses zlib compression.  True, such an image is not as
friendly to older clients, but it is not technically wrong, and newer
clients would still be able to use the image if not for this sentence
telling them they must not.  I'd drop this sentence.

> +
> +                    Bits 4-63:  Reserved (set to 0)
> =20
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation =
can
> @@ -165,6 +170,20 @@ in the description of a field.
>                      Length of the header structure in bytes. For versi=
on 2
>                      images, the length is always assumed to be 72 byte=
s.
> =20
> +        104 - 107:  compression_type
> +                    Defines the compression method used for compressed=
 clusters.
> +                    A single compression type is applied to all compre=
ssed image
> +                    clusters.
> +                    The compression type is set on image creation only=
=2E
> +                    The default compression type is zlib (value: 0).
> +                    When the compression type differs from the default=

> +                    the compression type bit (incompatible feature bit=
 3)
> +                    must be set.

So far, so good.

> +                    Qemu versions older than 4.1 can use images create=
d with
> +                    the default compression type without any additiona=
l
> +                    preparations and cannot use images created with an=
y other
> +                    compression type.

I'm wondering whether we need to spell this out in the spec.  Yes, I
know we spell out other qemu limitations elsewhere, but with a version
number.  But the spec would not be any less correct if you omitted this
sentence.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Rr2ui2UNApMBaxv4WJJgOQdzjB5dm6f9m--

--BaTOtfpfpachJiROxzmnbHgXysb5lPYSG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1LakYACgkQp6FrSiUn
Q2p9qgf+PD2c0smfCi7cDcFIaQPD9c5hfILgSxUWpbOfRPq7khBnL13a/YMAHY56
tgIE4kfkGREVPgGpdHnJU7pymI2SM1l/D2EkemzWzj5N92zhv+sVOUeFHrIedlYG
YmEKTyNl7AbOvexbTSIsQVy7EnuHcuE8d8iN9jHSFH6ugDsK3JmcT1FSe4Yoh2++
Ta22AxB7msoEJwtlyvARdIUDCCWiOVoLsx7O6K7UqUr6q+qs8n/KznQAEYpmbN1j
KnjwLFwuSa7o8LkbnNfRwvjI2MwL2gX++hpeMVfdjehqBNEELPXZ4/qNspl9kNQS
Hf0LwtmvDkXa+32PiZUyCKUB1gcrWA==
=4Ay2
-----END PGP SIGNATURE-----

--BaTOtfpfpachJiROxzmnbHgXysb5lPYSG--

