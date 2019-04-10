Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037E0C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 17:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF8E2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 17:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF8E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEHJ6-0004c5-Q8
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 13:46:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEHI9-0004F6-R6
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEHI7-0006O4-RB
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:45:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEHI2-0006Is-BY; Wed, 10 Apr 2019 13:45:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7165F3078AB6;
	Wed, 10 Apr 2019 17:45:37 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D96E5C29A;
	Wed, 10 Apr 2019 17:45:35 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190401140903.19186-1-eblake@redhat.com>
	<20190401140903.19186-8-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
	mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
	/PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
	U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
	mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
	awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
	AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
	CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
	B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
	2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
	AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
	8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
	4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
	BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
	xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
	W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
	DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
	64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
	ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
	sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
	alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
	/ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
	bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
	R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <22c4f9fa-a740-0d01-7b45-c802817f4f6c@redhat.com>
Date: Wed, 10 Apr 2019 19:45:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401140903.19186-8-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uWHyVFnlJij4l7e923NLwlSh888eao3w9"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 10 Apr 2019 17:45:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 07/14] iotests: Add 241 to test
 NBD on unaligned images
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410174534.Y7fAI6fgFelr2kiXLjk4vk4aBVjXgZwNl_Ns4VXHEFE@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uWHyVFnlJij4l7e923NLwlSh888eao3w9
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <22c4f9fa-a740-0d01-7b45-c802817f4f6c@redhat.com>
Subject: Re: [Qemu-block] [PULL 07/14] iotests: Add 241 to test NBD on
 unaligned images
References: <20190401140903.19186-1-eblake@redhat.com>
 <20190401140903.19186-8-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.04.19 16:08, Eric Blake wrote:
> Add a test for the NBD client workaround in the previous patch.  It's
> not really feasible for an iotest to assume a specific tracing engine,
> so we can't really probe trace_nbd_parse_blockstatus_compliance to see
> if the server was fixed vs. whether the client just worked around the
> server (other than by rearranging order between code patches and this
> test). But having a successful exchange sure beats the previous state
> of an error message. Since format probing can change alignment, we can
> use that as an easy way to test several configurations.
>=20
> Not tested yet, but worth adding to this test in future patches: an
> NBD server that can advertise a non-sector-aligned size (such as
> nbdkit) causes qemu as the NBD client to misbehave when it rounds the
> size up and accesses beyond the advertised size. Qemu as NBD server
> never advertises a non-sector-aligned size (since bdrv_getlength()
> currently rounds up to sector boundaries); until qemu can act as such
> a server, testing that flaw will have to rely on external binaries.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20190329042750.14704-2-eblake@redhat.com>
> Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> [eblake: add forced-512 alignment, and nbdkit reproducer comment]
> ---
>  tests/qemu-iotests/241     | 100 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/241.out |  26 ++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 127 insertions(+)
>  create mode 100755 tests/qemu-iotests/241
>  create mode 100644 tests/qemu-iotests/241.out
>=20
> diff --git a/tests/qemu-iotests/241 b/tests/qemu-iotests/241
> new file mode 100755
> index 00000000000..4b196857387
> --- /dev/null
> +++ b/tests/qemu-iotests/241
> @@ -0,0 +1,100 @@
> +#!/bin/bash
> +#
> +# Test qemu-nbd vs. unaligned images
> +#
> +# Copyright (C) 2018-2019 Red Hat, Inc.
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
> +nbd_unix_socket=3D$TEST_DIR/test_qemu_nbd_socket
> +
> +_cleanup()
> +{
> +    _cleanup_test_img
> +    nbd_server_stop
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +. ./common.nbd
> +
> +_supported_fmt raw
> +_supported_proto nbd
> +_supported_os Linux
> +_require_command QEMU_NBD
> +
> +# can't use _make_test_img, because qemu-img rounds image size up,
> +# and because we want to use Unix socket rather than TCP port. Likewis=
e,
> +# we have to redirect TEST_IMG to our server.
> +# This tests that we can deal with the hole at the end of an unaligned=

> +# raw file (either because the server doesn't advertise alignment too
> +# large, or because the client ignores the server's noncompliance - ev=
en
> +# though we can't actually wire iotests into checking trace messages).=

> +printf %01000d 0 > "$TEST_IMG_FILE"
> +TEST_IMG=3D"nbd:unix:$nbd_unix_socket"
> +
> +echo
> +echo "=3D=3D=3D Exporting unaligned raw image, natural alignment =3D=3D=
=3D"
> +echo
> +
> +nbd_server_start_unix_socket -f $IMGFMT "$TEST_IMG_FILE"
> +
> +$QEMU_NBD_PROG --list -k $nbd_unix_socket | grep '\(size\|min\)'
> +$QEMU_IMG map -f raw --output=3Djson "$TEST_IMG" | _filter_qemu_img_ma=
p
> +$QEMU_IO -f raw -c map "$TEST_IMG"
> +nbd_server_stop
> +
> +echo
> +echo "=3D=3D=3D Exporting unaligned raw image, forced server sector al=
ignment =3D=3D=3D"
> +echo
> +
> +# Intentionally omit '-f' to force image probing, which in turn forces=

> +# sector alignment, here at the server.
> +nbd_server_start_unix_socket "$TEST_IMG_FILE"
> +
> +$QEMU_NBD_PROG --list -k $nbd_unix_socket | grep '\(size\|min\)'
> +$QEMU_IMG map -f raw --output=3Djson "$TEST_IMG" | _filter_qemu_img_ma=
p
> +$QEMU_IO -f raw -c map "$TEST_IMG"
> +nbd_server_stop
> +
> +echo
> +echo "=3D=3D=3D Exporting unaligned raw image, forced client sector al=
ignment =3D=3D=3D"
> +echo
> +
> +# Now force sector alignment at the client.
> +nbd_server_start_unix_socket -f $IMGFMT "$TEST_IMG_FILE"
> +
> +$QEMU_NBD_PROG --list -k $nbd_unix_socket | grep '\(size\|min\)'
> +$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
> +$QEMU_IO -c map "$TEST_IMG"
> +nbd_server_stop
> +
> +# Not tested yet: we also want to ensure that qemu as NBD client does
> +# not access beyond the end of a server's advertised unaligned size:
> +#  nbdkit -U - memory size=3D513 --run 'qemu-io -f raw -c "r 512 512" =
$nbd'
> +# However, since qemu as server always rounds up to a sector alignment=
,
> +# we would have to use nbdkit to provoke the current client failures.
> +
> +# success, all done
> +echo '*** done'
> +rm -f $seq.full
> +status=3D0
> diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
> new file mode 100644
> index 00000000000..b76a6234d72
> --- /dev/null
> +++ b/tests/qemu-iotests/241.out
> @@ -0,0 +1,26 @@
> +QA output created by 241
> +
> +=3D=3D=3D Exporting unaligned raw image, natural alignment =3D=3D=3D
> +
> +  size:  1024
> +  min block: 512
> +[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true=
}]
> +1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
> +
> +=3D=3D=3D Exporting unaligned raw image, forced server sector alignmen=
t =3D=3D=3D
> +
> +WARNING: Image format was not specified for '/home/eblake/qemu/tests/q=
emu-iotests/scratch/t.raw' and probing guessed raw.
> +         Automatically detecting the format is dangerous for raw image=
s, write operations on block 0 will be restricted.
> +         Specify the 'raw' format explicitly to remove the restriction=
s.

Is there a patch for this already?

Also, I planned to reply to the original patch =E2=80=93 but where is it?=
  The
latest version I can see on the list is v3, and that only has seven
lines in the reference output.  Well, the difference would explain why
Vladimir would give a Tested-by to a test that clearly will not run on
his machine.

Max

> +  size:  1024
> +  min block: 512
> +[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true=
}]
> +1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
> +
> +=3D=3D=3D Exporting unaligned raw image, forced client sector alignmen=
t =3D=3D=3D
> +
> +  size:  1024
> +  min block: 512
> +[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true=
}]
> +1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
> +*** done
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 41da10c6cf5..bae77183809 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -240,6 +240,7 @@
>  238 auto quick
>  239 rw auto quick
>  240 auto quick
> +241 rw auto quick
>  242 rw auto quick
>  243 rw auto quick
>  244 rw auto quick
>=20



--uWHyVFnlJij4l7e923NLwlSh888eao3w9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyuK74ACgkQ9AfbAGHV
z0BRbQf+LKw7NvYu2HGAQeJ9qjDXEw2b7EYi9D9zxXLG7twEFBD9O6hkw3AWWZ/j
6dfLzqGwAVFc5u8/K4eSOASiA6yU/Y0mOOSsQrIKkJ5FUqXcrRJbx2j/btLsVu3J
xEumTbzNKyLHgonHf3oLyI0W0GPirzQEyVVjXbagzhlVuoWeH6GYr1hFuRCiD/eh
2m27CVpJuQFL3cCdwJrLt9ReISNZr9Ik1sePNY2R3JQ2q1ePS5zeDGU4fZYs/Atp
epVAhB+UiBWxttFGkdzv7tGeunpEGNF8nNMwU9laGd4Mu/k0ul/es36CFS8hFgRy
dS0TtFA8z7JeFSM+udYKh1kK3aA09g==
=Fgpb
-----END PGP SIGNATURE-----

--uWHyVFnlJij4l7e923NLwlSh888eao3w9--

