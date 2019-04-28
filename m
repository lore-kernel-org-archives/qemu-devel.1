Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7BDC43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 22:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F4620675
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 22:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F4620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49340 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKsie-0005PC-JQ
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 18:56:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKshp-0004i5-UV
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 18:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hKsho-0007Iq-K0
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 18:55:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hKshl-0007H3-JH; Sun, 28 Apr 2019 18:55:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B32D78830E;
	Sun, 28 Apr 2019 22:55:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-32.brq.redhat.com
	[10.40.204.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B865A5D6A9;
	Sun, 28 Apr 2019 22:55:23 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-2-vsementsov@virtuozzo.com>
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
Message-ID: <fe340a80-f918-7999-fb75-4b129162bd89@redhat.com>
Date: Mon, 29 Apr 2019 00:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402153730.54145-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nkDe19NtnX0dms35SobhN9BjQiGecCibO"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Sun, 28 Apr 2019 22:55:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v5 01/10] tests/perf: Test qemu-img convert
 from raw to encrypted qcow2
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, berto@igalia.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190428225522.B6J8eJ7SjdqzKf-1z8fwmHQOy4xvAu6HRI8vrty1Qhk@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nkDe19NtnX0dms35SobhN9BjQiGecCibO
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org,
 berrange@redhat.com
Message-ID: <fe340a80-f918-7999-fb75-4b129162bd89@redhat.com>
Subject: Re: [PATCH v5 01/10] tests/perf: Test qemu-img convert from raw to
 encrypted qcow2
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
 <20190402153730.54145-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190402153730.54145-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.19 17:37, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/perf/block/qcow2/convert-to-encrypted | 48 +++++++++++++++++++++=

>  1 file changed, 48 insertions(+)
>  create mode 100755 tests/perf/block/qcow2/convert-to-encrypted

Thanks for the test case, but I don=E2=80=99t know whether this is the ri=
ght way
to include it.

A concrete problem is that it doesn=E2=80=99t work with out-of-tree build=
s (I
only do out-of-tree builds).  I wonder whether it would be possible and
make sense (I have no idea) to add a subdirectory "perf" to the iotests
and reuse its infrastructure?  Those tests wouldn=E2=80=99t run by defaul=
t.

Max

> diff --git a/tests/perf/block/qcow2/convert-to-encrypted b/tests/perf/b=
lock/qcow2/convert-to-encrypted
> new file mode 100755
> index 0000000000..7a6b7b1cab
> --- /dev/null
> +++ b/tests/perf/block/qcow2/convert-to-encrypted
> @@ -0,0 +1,48 @@
> +#!/bin/bash
> +#
> +# Test qemu-img convert from raw to encrypted qcow2
> +#
> +# Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved=
=2E
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
> +if [ "$#" -lt 2 ]; then
> +    echo "Usage: $0 SOURCE_FILE DESTINATION_FILE [additional qemu-img =
convert parameters]"
> +    exit 1
> +fi
> +
> +ROOT_DIR=3D"$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../../.." >/dev=
/null 2>&1 && pwd )"
> +QEMU_IMG=3D"$ROOT_DIR/qemu-img"
> +QEMU_IO=3D"$ROOT_DIR/qemu-io"
> +
> +size=3D1G
> +
> +src=3D"$1"
> +shift
> +
> +dst=3D"$1"
> +shift
> +
> +(
> +# create source
> +$QEMU_IMG create -f raw "$src" $size
> +$QEMU_IO -f raw -c "write -P 0xa 0 $size" "$src"
> +
> +# create target
> +$QEMU_IMG create -f qcow2 --object secret,id=3Dsec0,data=3Dtest -o enc=
rypt.format=3Dluks,encrypt.key-secret=3Dsec0 "$dst" $size
> +) > /dev/null
> +
> +# test with additional parameters left in $@
> +/usr/bin/time -f %e $QEMU_IMG convert "$@" -f raw --object secret,id=3D=
sec0,data=3Dtest --target-image-opts -n "$src" "driver=3Dqcow2,file.filen=
ame=3D$dst,encrypt.key-secret=3Dsec0"
>=20



--nkDe19NtnX0dms35SobhN9BjQiGecCibO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzGL1oACgkQ9AfbAGHV
z0Dv1gf9Fgb33NPbFmkgMoU+ruqbe1qnNS2ijYN+zyLQ4/STFN3HmTCgYydagZr1
c11XUgm1+DPpQRwAX+mc3vKCsHI6paoPDCnq55VssKd3Tx2mkygTrC6AIUdWBojJ
flA/sizxYXGq0QAY7I3UbTFoLlbBJ2ABhwQ2rVPoNrlqcMNLmLwlKYaXXRFHR02b
zXXFdib9IMqOB4ijLO9EoWNIa+UbLOwGlYpfkRbSawxgMtjT1veOfAa0UYfGsYU/
Pz1m2XHzfRUSt49qLe3bx37aukbakyX//VrrCs4pPynBzMujz8Pc37ZtJbXVTCWR
+g2p3/02n1dMllNC2RACQgY/E/wcSA==
=gH2V
-----END PGP SIGNATURE-----

--nkDe19NtnX0dms35SobhN9BjQiGecCibO--

