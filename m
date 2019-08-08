Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E51BC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 00:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4168021872
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 00:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4168021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvWEu-0004HM-IT
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 20:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35864)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hvWEU-0003mj-Nh
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 20:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hvWET-0006XP-2M
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 20:24:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40008)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hvWEQ-0006Vz-GQ; Wed, 07 Aug 2019 20:24:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A6CFC3086202;
 Thu,  8 Aug 2019 00:24:37 +0000 (UTC)
Received: from [10.3.116.93] (ovpn-116-93.phx2.redhat.com [10.3.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2AEB600CC;
 Thu,  8 Aug 2019 00:24:36 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-4-dplotnikov@virtuozzo.com>
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
Message-ID: <24146f62-84b9-c585-0618-d039ae95e273@redhat.com>
Date: Wed, 7 Aug 2019 19:24:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704130949.14017-4-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ISVtZiLvRvurQsN1DNdgrqlKpcchmKoBx"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 08 Aug 2019 00:24:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qcow2: add zstd cluster compression
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
--ISVtZiLvRvurQsN1DNdgrqlKpcchmKoBx
Content-Type: multipart/mixed; boundary="HffF4z0T3jwlZiEonf3xvqt8N2iskjOmI";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <24146f62-84b9-c585-0618-d039ae95e273@redhat.com>
Subject: Re: [PATCH v2 3/3] qcow2: add zstd cluster compression
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-4-dplotnikov@virtuozzo.com>
In-Reply-To: <20190704130949.14017-4-dplotnikov@virtuozzo.com>

--HffF4z0T3jwlZiEonf3xvqt8N2iskjOmI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/4/19 8:09 AM, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of compression ratio in comparison with
> zlib, which, by the moment, has been the only compression

s/by/at/

> method available.
>=20
> The performance test results:
> Test compresses and decompresses qemu qcow2 image with just
> installed rhel-7.6 guest.
> Image cluster size: 64K. Image on disk size: 2.2G
>=20
> The test was conducted with brd disk to reduce the influence
> of disk subsystem to the test results.
> The results is given in seconds.
>=20
> compress cmd:
>   time ./qemu-img convert -O qcow2 -c -o compression_type=3D[zlib|zstd]=

>                   src.img [zlib|zstd]_compressed.img
> decompress cmd
>   time ./qemu-img convert -O qcow2
>                   [zlib|zstd]_compressed.img uncompressed.img
>=20
>            compression               decompression
>          zlib       zstd           zlib         zstd
> ------------------------------------------------------------
> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
> user     65.0       15.8            5.3          2.5
> sys       3.3        0.2            2.0          2.0
>=20
> Both ZLIB and ZSTD gave the same compression ratio: 1.57
> compressed image size in both cases: 1.4G
>=20

Nice numbers.

> +++ b/docs/interop/qcow2.txt
> @@ -538,6 +538,9 @@ Compressed Clusters Descriptor (x =3D 62 - (cluster=
_bits - 8)):
>                      Another compressed cluster may map to the tail of =
the final
>                      sector used by this compressed cluster.
> =20
> +                    The layout of the compressed data depends on the c=
ompression
> +                    type used for the image (see compressed cluster la=
yout).
> +
>  If a cluster is unallocated, read requests shall read the data from th=
e backing
>  file (except if bit 0 in the Standard Cluster Descriptor is set). If t=
here is
>  no backing file or the backing file is smaller than the image, they sh=
all read
> @@ -790,3 +793,19 @@ In the image file the 'enabled' state is reflected=
 by the 'auto' flag. If this
>  flag is set, the software must consider the bitmap as 'enabled' and st=
art
>  tracking virtual disk changes to this bitmap from the first write to t=
he
>  virtual disk. If this flag is not set then the bitmap is disabled.
> +
> +=3D=3D=3D Compressed cluster layout =3D=3D=3D
> +
> +The compressed cluster data may have a different layout depending on t=
he
> +compression type used for the image, and store specific data for the p=
articular
> +compression type.
> +
> +Compressed data layout for the available compression types:
> +(x =3D data_space_length - 1)
> +
> +    zlib:
> +        Byte  0 -  x:     the compressed data content
> +                          all the space provided used for compressed d=
ata
> +    zstd:
> +        Byte  0 -  3:     the length of compressed data
> +              4 -  x:     the compressed data content

Missing a change to the header description at bytes 104-107 calling out
'1' as meaning zstd (it only calls out '0' or absent as meaning zlib).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HffF4z0T3jwlZiEonf3xvqt8N2iskjOmI--

--ISVtZiLvRvurQsN1DNdgrqlKpcchmKoBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1La8QACgkQp6FrSiUn
Q2rbdQf+J45wP6pNcU+Y12Hhim7eXgh8wv++FimUl1Ypm5rPJ5WNVbWMHy7Bf4BN
fOxDLIe8P7TqPSHUltAHY5T93VrbpySHQAPj4e6j4yRzvfFL3wYV4YmqQZ9dqFuw
y9nbBEa/tEETOxY0z2HTHmiNE6atN0uIUDvVK2Bv0m6fgOGmlEmveeOw2FQGv52v
LtYNKvIhOXf/b33120D3TPii0/1OWhXSUAlUUF+dGLSDl9GTYGZw7/lCnCrTDzdR
+bLFVZEgZIddZkBs41MucJtg0BotFSmlH27XRFxoaL+snCik1ZMLHPG4kXngDW/p
XRGBfeHxoB4oA081mIYTrVHSFqOn4g==
=7VX7
-----END PGP SIGNATURE-----

--ISVtZiLvRvurQsN1DNdgrqlKpcchmKoBx--

