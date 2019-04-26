Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C422BC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 20:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822D020679
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 20:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822D020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51913 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK7vi-0003WJ-M5
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 16:58:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK7us-00039i-F7
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK7ur-0007Z5-53
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hK7uo-0007Tq-BJ; Fri, 26 Apr 2019 16:57:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B3043172D67;
	Fri, 26 Apr 2019 20:57:49 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-82.brq.redhat.com
	[10.40.204.82])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D5A422E02C;
	Fri, 26 Apr 2019 20:57:47 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1554985749.git.berto@igalia.com>
	<437727cd1a4ba03312b56d331f2f69fe92846af8.1554985749.git.berto@igalia.com>
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
Message-ID: <23d216b2-409c-d397-18ca-3c4662dedf52@redhat.com>
Date: Fri, 26 Apr 2019 22:57:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <437727cd1a4ba03312b56d331f2f69fe92846af8.1554985749.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eWs7BqQPGXigAC6PLHcHUUI0Z56CSIcV6"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 26 Apr 2019 20:57:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 2/2] iotests: Check that images
 are in read-only mode after block-commit
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426205746.7VIV4rMxJ0gTZzpYOP0CE1jWtwbuuIUpaMIbxwfP3Zg@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eWs7BqQPGXigAC6PLHcHUUI0Z56CSIcV6
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <23d216b2-409c-d397-18ca-3c4662dedf52@redhat.com>
Subject: Re: [PATCH for-4.1 v2 2/2] iotests: Check that images are in
 read-only mode after block-commit
References: <cover.1554985749.git.berto@igalia.com>
 <437727cd1a4ba03312b56d331f2f69fe92846af8.1554985749.git.berto@igalia.com>
In-Reply-To: <437727cd1a4ba03312b56d331f2f69fe92846af8.1554985749.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.19 14:32, Alberto Garcia wrote:
> This tests the fix from the previous patch.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/249     | 115 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/249.out |  35 ++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 151 insertions(+)
>  create mode 100755 tests/qemu-iotests/249
>  create mode 100644 tests/qemu-iotests/249.out
>=20
> diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
> new file mode 100755
> index 0000000000..a6ee2ef492
> --- /dev/null
> +++ b/tests/qemu-iotests/249
> @@ -0,0 +1,115 @@
> +#!/usr/bin/env bash
> +#
> +# Test that a backing image is put back in read-only mode after
> +# block-commit (both when it fails and when it succeeds).
> +#
> +# Copyright (C) 2019 Igalia, S.L.
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
> +owner=3Dberto@igalia.com
> +
> +seq=3D`basename $0`

I have been berated for not using $() here...

> +echo "QA output created by $seq"
> +
> +here=3D`pwd`

=2E..and including this line here, so I suppose I'll pass that criticism
along. O:-)

Otherwise, the test looks good to me, just one thing...

[...]

> +echo
> +echo '=3D=3D=3D Run block-commit on base using the default filter node=
 name'
> +echo
> +_send_qemu_cmd $QEMU_HANDLE \
> +    "{ 'execute': 'block-commit',
> +       'arguments': {'job-id': 'job0', 'device': 'none1', 'top-node': =
'int'}}" \
> +    'return'
> +
> +# Wait for block-commit to finish
> +sleep 0.5

Why not just

_send_qemu_cmd $QEMU_HANDLE '' \
    '"status": "null"'

?

First, that would avoid timing issues.  Second, this places all the job
logs above the "=3D=3D=3D Send a write command [...] (3)" line.

Max

> +echo
> +echo '=3D=3D=3D Send a write command to a drive opened in read-only mo=
de (3)'
> +echo


--eWs7BqQPGXigAC6PLHcHUUI0Z56CSIcV6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzDcMoACgkQ9AfbAGHV
z0CsyQf+MKjfVAfOiV2TpRACOltI4KxpxUkPfwHACjbRM40ifphplRTU2uQe2cyY
jOuvABdQaFbl5xHoGH8B1MRBS/gxKKO3+LzrKYaCywqQ6g9YR38ZXJoVrEyWWb6j
Yw2BR67trfR83m4Tc7z22V//cKi5IjQ6k0owrKs4Yl36d3L6NM/hb9Se/NzwmXOM
GD4OzRzOJh4YhNk8GgT7pkKhKCgwiwiov9PCBzVehWLmxoRdGTujmRexosYmxHC4
cDm4473+HPx72UkdZv0XYPXUhIh84/Ev0UmTHp4kSrlFaNmpmcczGEzPPXkhZOUp
AmIUqPNr6zAnw1VlNfsRvfdAB1GSrA==
=+E4O
-----END PGP SIGNATURE-----

--eWs7BqQPGXigAC6PLHcHUUI0Z56CSIcV6--

