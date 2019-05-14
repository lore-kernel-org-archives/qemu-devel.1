Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81622C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B9720873
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B9720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQfMT-0005yk-J3
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:53:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQfLY-0005Xe-9I
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQfLW-0006QU-Jg
	for qemu-devel@nongnu.org; Tue, 14 May 2019 17:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hQfLT-0006Ij-71; Tue, 14 May 2019 17:52:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74F86301899D;
	Tue, 14 May 2019 21:52:22 +0000 (UTC)
Received: from [10.3.116.43] (ovpn-116-43.phx2.redhat.com [10.3.116.43])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C515719C7E;
	Tue, 14 May 2019 21:52:21 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190514214230.22601-1-mreitz@redhat.com>
	<20190514214230.22601-3-mreitz@redhat.com>
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
Message-ID: <37e9abea-d7f8-9ea8-d584-4de345257376@redhat.com>
Date: Tue, 14 May 2019 16:52:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514214230.22601-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="elFsbVhpz9Qy1oaTYRHORu5V3KjJUPZkC"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 14 May 2019 21:52:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Test unaligned raw images
 with O_DIRECT
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--elFsbVhpz9Qy1oaTYRHORu5V3KjJUPZkC
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable@nongnu.org
Message-ID: <37e9abea-d7f8-9ea8-d584-4de345257376@redhat.com>
Subject: Re: [PATCH 2/2] iotests: Test unaligned raw images with O_DIRECT
References: <20190514214230.22601-1-mreitz@redhat.com>
 <20190514214230.22601-3-mreitz@redhat.com>
In-Reply-To: <20190514214230.22601-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/14/19 4:42 PM, Max Reitz wrote:
> We already have 221 for accesses through the page cache, but it is
> better to create a new file for O_DIRECT instead of integrating those
> test cases into 221.  This way, we can make use of
> _supported_cache_modes (and _default_cache_mode) so the test is
> automatically skipped on filesystems that do not support O_DIRECT.
>=20
> As part of the split, add _supported_cache_modes to 221.  With that, it=

> no longer fails when run with -c none or -c directsync.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/221     |  4 ++
>  tests/qemu-iotests/253     | 84 ++++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/253.out | 14 +++++++
>  tests/qemu-iotests/group   |  1 +
>  4 files changed, 103 insertions(+)
>  create mode 100755 tests/qemu-iotests/253
>  create mode 100644 tests/qemu-iotests/253.out

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
> index 25dd47bcfe..0e9096fec7 100755
> --- a/tests/qemu-iotests/221
> +++ b/tests/qemu-iotests/221
> @@ -1,6 +1,7 @@
>  #!/usr/bin/env bash
>  #
>  # Test qemu-img vs. unaligned images
> +# (See also 253, which is the O_DIRECT version)
>  #
>  # Copyright (C) 2018-2019 Red Hat, Inc.
>  #
> @@ -37,6 +38,9 @@ _supported_fmt raw
>  _supported_proto file
>  _supported_os Linux
> =20
> +_default_cache_mode writeback
> +_supported_cache_modes writeback writethrough unsafe
> +
>  echo
>  echo "=3D=3D=3D Check mapping of unaligned raw image =3D=3D=3D"
>  echo
> diff --git a/tests/qemu-iotests/253 b/tests/qemu-iotests/253
> new file mode 100755
> index 0000000000..d88d5afa45
> --- /dev/null
> +++ b/tests/qemu-iotests/253
> @@ -0,0 +1,84 @@
> +#!/usr/bin/env bash
> +#
> +# Test qemu-img vs. unaligned images; O_DIRECT version
> +# (Originates from 221)
> +#
> +# Copyright (C) 2019 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify=

> +# it under the terms of the GNU General Public License as published by=

> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
> +#
> +
> +seq=3D"$(basename $0)"
> +echo "QA output created by $seq"
> +
> +status=3D1 # failure is the default!
> +
> +_cleanup()
> +{
> +    _cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +_supported_fmt raw
> +_supported_proto file
> +_supported_os Linux
> +
> +_default_cache_mode none
> +_supported_cache_modes none directsync
> +
> +echo
> +echo "=3D=3D=3D Check mapping of unaligned raw image =3D=3D=3D"
> +echo
> +
> +# We do not know how large a physical sector is, but it is certainly
> +# going to be a factor of 1 MB
> +size=3D$((1 * 1024 * 1024 - 1))
> +
> +# qemu-img create rounds size up to BDRV_SECTOR_SIZE
> +_make_test_img $size
> +$QEMU_IMG map --output=3Djson --image-opts \
> +    "driver=3D$IMGFMT,file.driver=3Dfile,file.filename=3D$TEST_IMG,cac=
he.direct=3Don" \
> +    | _filter_qemu_img_map
> +
> +# so we resize it and check again
> +truncate --size=3D$size "$TEST_IMG"
> +$QEMU_IMG map --output=3Djson --image-opts \
> +    "driver=3D$IMGFMT,file.driver=3Dfile,file.filename=3D$TEST_IMG,cac=
he.direct=3Don" \
> +    | _filter_qemu_img_map
> +
> +# qemu-io with O_DIRECT always writes whole physical sectors.  Again,
> +# we do not know how large a physical sector is, so we just start
> +# writing from a 64 kB boundary, which should always be aligned.
> +offset=3D$((1 * 1024 * 1024 - 64 * 1024))
> +$QEMU_IO -c "w $offset $((size - offset))" "$TEST_IMG" | _filter_qemu_=
io
> +$QEMU_IMG map --output=3Djson --image-opts \
> +    "driver=3D$IMGFMT,file.driver=3Dfile,file.filename=3D$TEST_IMG,cac=
he.direct=3Don" \
> +    | _filter_qemu_img_map
> +
> +# Resize it and check again -- contrary to 221, we may not get partial=

> +# sectors here, so there should be only two areas (one zero, one
> +# data).
> +truncate --size=3D$size "$TEST_IMG"
> +$QEMU_IMG map --output=3Djson --image-opts \
> +    "driver=3D$IMGFMT,file.driver=3Dfile,file.filename=3D$TEST_IMG,cac=
he.direct=3Don" \
> +    | _filter_qemu_img_map
> +
> +# success, all done
> +echo '*** done'
> +rm -f $seq.full
> +status=3D0
> diff --git a/tests/qemu-iotests/253.out b/tests/qemu-iotests/253.out
> new file mode 100644
> index 0000000000..607c0baa0b
> --- /dev/null
> +++ b/tests/qemu-iotests/253.out
> @@ -0,0 +1,14 @@
> +QA output created by 253
> +
> +=3D=3D=3D Check mapping of unaligned raw image =3D=3D=3D
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048575
> +[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET}]
> +[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET}]
> +wrote 65535/65535 bytes at offset 983040
> +63.999 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": fal=
se, "offset": OFFSET},
> +{ "start": 983040, "length": 65536, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET}]
> +[{ "start": 0, "length": 983040, "depth": 0, "zero": true, "data": fal=
se, "offset": OFFSET},
> +{ "start": 983040, "length": 65536, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET}]
> +*** done
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 00e474ab0a..52b7c16e15 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -250,3 +250,4 @@
>  248 rw auto quick
>  249 rw auto quick
>  252 rw auto backing quick
> +253 rw auto quick
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--elFsbVhpz9Qy1oaTYRHORu5V3KjJUPZkC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzbOJUACgkQp6FrSiUn
Q2q6EwgAp9NpVbs53RO50nEA6HnMoBbn7s/2m9q+QnxBwRNXm3Td5gbsbUqgVp6q
1PikFShMKoN5CsLofCABFb/sNBVB9+mnwMiN6d0NgSntpFSBxWthqmuGZLzOGj+y
R2gdzmq2S+ZlKYj6c8FRIcnCHsLzzg+rsv4TQW2LUAZ4/QygIOq42wn2v21CklaN
PYd6dfIEXpo/PtPpabfdar5cUwaTbGC5+RvSFKcSHK3SnlCqaY4c8Q2wb+Jbfk1a
V2odFL3AFm7MaueVtnrvBcC2ku2zsVQo2uTwFnz7zF37aEyJ4xB55JRhw4q8ESAH
yG95EOFUgAHWJdw79wctnf2MGigwCw==
=KBrz
-----END PGP SIGNATURE-----

--elFsbVhpz9Qy1oaTYRHORu5V3KjJUPZkC--

