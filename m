Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBE2C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4224320815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4224320815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHfx-0002aa-GD
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:48:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hRHaP-00074W-CA
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hRHaN-0001dq-Td
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hRHaK-0001Oy-Nh; Thu, 16 May 2019 10:42:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27072307D848;
	Thu, 16 May 2019 14:42:10 +0000 (UTC)
Received: from [10.3.117.155] (ovpn-117-155.phx2.redhat.com [10.3.117.155])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3522C6F44C;
	Thu, 16 May 2019 14:42:08 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
	mreitz@redhat.com
References: <20190516134844.3683-1-dplotnikov@virtuozzo.com>
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
Message-ID: <8d4391fb-52a4-098f-4c9f-c1d3fc75a7ea@redhat.com>
Date: Thu, 16 May 2019 09:42:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516134844.3683-1-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="giqJdKyOQz1GVC1n3PaPoFeP2073h0dhu"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 16 May 2019 14:42:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v1] [RFC] qcow2: add compression type
 feature
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--giqJdKyOQz1GVC1n3PaPoFeP2073h0dhu
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com
Message-ID: <8d4391fb-52a4-098f-4c9f-c1d3fc75a7ea@redhat.com>
Subject: Re: [PATCH v1] [RFC] qcow2: add compression type feature
References: <20190516134844.3683-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190516134844.3683-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/16/19 8:48 AM, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type=

> feature into QCOW2 header that indicates that *all* compressed clusters=

> must be (de)compressed using a certain compression type.
>=20
> It is implied that the compression type is set on the image creation an=
d
> can be changed only later by image conversion, thus the only compressio=
n
> algorithm is used for the image.
>=20
> The plan is to add support for ZSTD and then may be something more effe=
ctive
> in the future.
>=20
> ZSTD compression algorithm consumes 3-5 times less CPU power with a
> comparable compression ratio with zlib. It would be wise to use it for
> data compression e.g. for backups.
>=20
> The default compression is ZLIB.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---

> +++ b/docs/interop/qcow2.txt
> @@ -109,7 +109,11 @@ in the description of a field.
>                                  An External Data File Name header exte=
nsion may
>                                  be present if this bit is set.
> =20
> -                    Bits 3-63:  Reserved (set to 0)
> +                    Bit 3:      Compression type bit. If the bit is se=
t, then the
> +                                type of compression the image uses is =
set in the
> +                                header extension

I'd call out 'Compression type' header extension by name, to make it
more obvious.  Is it an error if bit 3 is set but the compression header
is not present? Is it an error if the compression header is present but
bit 3 is not set?

> +
> +                    Bits 4-63:  Reserved (set to 0)
> =20
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation =
can
> @@ -175,6 +179,7 @@ be stored. Each extension has a structure like the =
following:
>                          0x23852875 - Bitmaps extension
>                          0x0537be77 - Full disk encryption header point=
er
>                          0x44415441 - External data file name string
> +                        0x434D5052 - Compression type extension

Our earlier magic numbers were probably created as random numbers and
contain 8-bit values, to make them less likely to appear naturally in
other parts of the file and thus less likely to be misinterpreted.  But
that's not a requirement, and I see that you followed the lead of "DATA"
and created "CMPR" for yours.  Works for me :)

>                          other      - Unknown header extension, can be =
safely
>                                       ignored
> =20
> @@ -771,3 +776,21 @@ In the image file the 'enabled' state is reflected=
 by the 'auto' flag. If this
>  flag is set, the software must consider the bitmap as 'enabled' and st=
art
>  tracking virtual disk changes to this bitmap from the first write to t=
he
>  virtual disk. If this flag is not set then the bitmap is disabled.
> +
> +
> +=3D=3D Compression type extension =3D=3D
> +
> +The compression type extension is an optional header extension. It sto=
res the

Could probably do a better job at describing when the header is optional
vs. mandatory.

> +ID of the compressor which has to be used to compress/decompress disk =
clusters.
> +The compression type is used for all disk cluster. Two clusters of the=
 image
> +couldn't be compressed with different compressors.

Wording suggestion: A single compression type is applied to all
compressed disk clusters, with no way to change compression types per
cluster.

But is that a hard requirement? Since this is already an incompatible
feature extension, we could have a compression type that states that
each compressed cluster is self-describing via a 1-byte prefix (yes, it
means compression is not quite as dense, but probably not an issue).

Something like: in the image header, we have compression type 1 =3D zlib,=

compression type 2 =3D zstd, etc, each of which treat all compressed
clusters as-is with no further per-cluster headers. Or, in the image
header, we have compression type 255 =3D per-cluster, at which point a
compressed cluster is now represented as: [1-byte prefix] [tail], where
the one-byte prefix is 1 =3D zlib, 2 =3D zstd, etc (but not 255), and the=
n
the tail is decoded with the appropriate algorithm. In this way, it
might even be possible to encode different clusters with an optimal
algorithm per cluster, and thus create an image that requires both zlib
and zstd to be fully read.

I'm not sure if we need that much complexity, but just throwing it out
there for thought.

> +
> +The compression type can be set on the image creation. The only way to=
 change
> +the compression type is to convert the image explicitly.
> +
> +Available compression types:
> +    ID    0: ZLIB (gzip)
> +          1: ZSTD
> +
> +The default compression type is ZLIB. When ZLIB is used the compressio=
n type
> +header extension is not present.

Here's where we have to think about back-compat. If zlib is used, and
the compression type header is present, must incompatible bit 3 be set?
Do we want to permit images that have incompatible bit 3 set and zlib
explicitly mentioned? Or are you making a hard requirement that if zlib
is chosen, incompatible bit 3 must be absent and no compression header
should be set? Or is it okay for the compression header to be present
and incompatible bit 3 clear, but only when compression type 0 is
chosen?  Let's spell out exactly what we want, probably with a goal of
minimizing the number of situations where an incompatible bit must be
set (as that makes it harder to work with images in older software).

Does the compression type really have to be chosen at image creation, or
can the decision be deferred until the time that the first compressed
cluster is written?  You could implement things to state that if
incompatible bit 3 is set but the compression header is absent, then
there must not be any compressed clusters in the image; as soon as the
first compressed cluster is written, then the compression header must
also be written (even if it explicitly calls out zlib), to make it
easier for new software to tell at a glance if the image has ever
contained compressed clusters at least once in the past.

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ccbfff9d0..8eebcc728b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -698,6 +698,7 @@
>  { 'struct': 'BlockMeasureInfo',
>    'data': {'required': 'int', 'fully-allocated': 'int'} }
> =20
> +
>  ##

Why the added blank line?

>  # @query-block:
>  #
> @@ -5257,3 +5258,16 @@
>    'data' : { 'node-name': 'str',
>               'iothread': 'StrOrNull',
>               '*force': 'bool' } }
> +
> +##
> +# @Qcow2CompressionType:
> +#
> +# Compression type used in qcow2 image file
> +#
> +# @zlib - gzip compressor
> +# @zstd - zstd compression
> +#
> +# Since: 4.0

You've missed 4.0; this should be 4.1.

> +##
> +{ 'enum': 'Qcow2CompressionType',
> +  'data': [ 'zlib', 'zstd' ] }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--giqJdKyOQz1GVC1n3PaPoFeP2073h0dhu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzddr8ACgkQp6FrSiUn
Q2qfEgf/SIuWYfThm+i0p9fbp9YwmqYuB0UwKSGxf+24Tk5wqJVXhmwCtL2PPOfq
ZU3x/h+JKCiOZD1b+f6FcHE9a7YEpyGmnCwixr1fyBEXD9RM0bRg9eMx3xLZkNge
L0qz2zQOxVeB0bRJc83qUW+sqxiOQ6OEsuyXrod8PVYY/PQfM5wWGcpf/QgT7rh/
72DkfCfIR4z2EzZb0a6sCwDi2EY4KD+RfQg+iVRvM7hORz1yjs7j9b+/4dDFP4EF
/kslJc8jPOyvnGNdsizPwPl7s1VNiIAP0OaIwR3MU6Vw+JxiB6fbR8STHGA3WzLo
FqMtPW9XF+tSq+2wAftwRS6XtKybyg==
=hzDh
-----END PGP SIGNATURE-----

--giqJdKyOQz1GVC1n3PaPoFeP2073h0dhu--

