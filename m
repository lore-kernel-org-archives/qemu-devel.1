Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E09FC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EB420830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EB420830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8jLg-0005df-5X
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8jKT-0004pd-6H
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8jKR-0005C0-Sf
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:01:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8jKN-00057N-LZ; Fri, 13 Sep 2019 07:01:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E917D86668;
 Fri, 13 Sep 2019 11:01:22 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-81.ams2.redhat.com
 [10.36.116.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C11635D9CD;
 Fri, 13 Sep 2019 11:01:20 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190912223754.875-1-mlevitsk@redhat.com>
 <20190912223754.875-4-mlevitsk@redhat.com>
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
Message-ID: <f47ffd82-91e3-cc29-fb86-34de6a1b6ae8@redhat.com>
Date: Fri, 13 Sep 2019 13:01:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912223754.875-4-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="N5QmbbWJQy0sQBhhDWZI2Kb18MZ5Al0ir"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 13 Sep 2019 11:01:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/3] qemu-iotests: Add test for bz
 #1745922
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
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N5QmbbWJQy0sQBhhDWZI2Kb18MZ5Al0ir
Content-Type: multipart/mixed; boundary="tcH8tVREen12ExvwtknysSaEfA0CpQx6p";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <f47ffd82-91e3-cc29-fb86-34de6a1b6ae8@redhat.com>
Subject: Re: [PATCH v3 3/3] qemu-iotests: Add test for bz #1745922
References: <20190912223754.875-1-mlevitsk@redhat.com>
 <20190912223754.875-4-mlevitsk@redhat.com>
In-Reply-To: <20190912223754.875-4-mlevitsk@redhat.com>

--tcH8tVREen12ExvwtknysSaEfA0CpQx6p
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 00:37, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  tests/qemu-iotests/263     | 91 ++++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/263.out | 40 +++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 132 insertions(+)
>  create mode 100755 tests/qemu-iotests/263
>  create mode 100644 tests/qemu-iotests/263.out
>=20
> diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
> new file mode 100755
> index 0000000000..afbd668cda
> --- /dev/null
> +++ b/tests/qemu-iotests/263
> @@ -0,0 +1,91 @@
> +#!/usr/bin/env bash
> +#
> +# Test encrypted write that crosses cluster boundary of two unallocate=
d clusters
> +# Based on 188
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
> +# creator
> +owner=3Dmlevitsk@redhat.com
> +
> +seq=3D`basename $0`
> +echo "QA output created by $seq"
> +
> +status=3D1	# failure is the default!
> +
> +_cleanup()
> +{
> +	_cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +_supported_fmt qcow2
> +_supported_proto generic
> +_supported_os Linux
> +
> +
> +size=3D1M
> +
> +SECRET=3D"secret,id=3Dsec0,data=3Dastrochicken"
> +QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
> +
> +
> +_run_test()
> +{
> +	echo "=3D=3D reading the whole image =3D=3D"
> +	$QEMU_IO --object $SECRET -c "read -P 0 0 $size" --image-opts $1 | _f=
ilter_qemu_io | _filter_testdir
> +
> +	echo
> +	echo "=3D=3D write two 512 byte sectors on a cluster boundary =3D=3D"=

> +	$QEMU_IO --object $SECRET -c "write -P 0xAA 0xFE00 0x400" --image-opt=
s $1 | _filter_qemu_io | _filter_testdir
> +
> +	echo
> +	echo "=3D=3D verify that the rest of the image is not changed =3D=3D"=

> +	$QEMU_IO --object $SECRET -c "read -P 0x00 0x00000 0xFE00" --image-op=
ts $1 | _filter_qemu_io | _filter_testdir
> +	$QEMU_IO --object $SECRET -c "read -P 0xAA 0x0FE00 0x400" --image-opt=
s $1 | _filter_qemu_io | _filter_testdir
> +	$QEMU_IO --object $SECRET -c "read -P 0x00 0x10200 0xEFE00" --image-o=
pts $1 | _filter_qemu_io | _filter_testdir

Looks good to me overall, but in case you respin, I don=E2=80=99t think t=
here=E2=80=99s
reason not to quote the $1.

Max


--tcH8tVREen12ExvwtknysSaEfA0CpQx6p--

--N5QmbbWJQy0sQBhhDWZI2Kb18MZ5Al0ir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl17dv8ACgkQ9AfbAGHV
z0D3Fgf+MQs0mMTjOm0bkce4gHm/ysRz9Ysw3tDrjaLhLalLqlbrFKdM13hFusAm
S59caUdh3s3adIIa7fxyfycqZxn9gb/CIipCDRa+IVSA94K+mDvDyMPBLaZZPiFY
Gma5BDsqiVoOcb5JtK0NVNqKkUVwJTke9I1D8GxxZb2N5FpP67wQq8isjj2jWrX2
uotd/kd6cI3he80hiJLZNHqv8/50N7xTLOCbpzmfpgmUAnKPGEmVpakCSaCJPWiS
7ZtwMb3dBY2Qq5utFIrjhm7meGn0+qyZ1nsPQevybKEMmsofy8vcNaM88N/ndKSI
VAeXxWuf/dyTNh9PgxxGbUdaFxteVg==
=6YTs
-----END PGP SIGNATURE-----

--N5QmbbWJQy0sQBhhDWZI2Kb18MZ5Al0ir--

