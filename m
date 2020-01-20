Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B510C33CAA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6983622314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hie6JUCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6983622314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itaWv-0005jN-2a
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itaU6-0002mu-MW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itaU1-0007Qw-5I
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:05:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42703
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itaU0-0007N9-Rw
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579539900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cHzgnN/W5sGKy/oM2khiqYDifaiPZvFIh+a218Mtwt8=;
 b=Hie6JUCXh7Ze7iQM8jEXo6+HH1XjHHRxgVoUiEgFM4iaSvg3cj6wpg3ypjKT6SqWIfOUsb
 /i3filF0ExJgInSn0dS0ypFP3eKImo6HSnmnmuuW6i2yxkWex2Qw5lYA1kbxY9XflNJ84A
 oCkEk5p3Ke4oZn2NzMyv9mDMXtj2Q94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-nPUFGZQwP429yq8ARmdRHw-1; Mon, 20 Jan 2020 12:04:56 -0500
X-MC-Unique: nPUFGZQwP429yq8ARmdRHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC8A98010CD;
 Mon, 20 Jan 2020 17:04:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B5745C3FA;
 Mon, 20 Jan 2020 17:04:52 +0000 (UTC)
Subject: Re: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200116155452.30972-1-vsementsov@virtuozzo.com>
 <20200116155452.30972-3-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <eedd42b6-bf4e-f6de-13a4-412d389fdb09@redhat.com>
Date: Mon, 20 Jan 2020 18:04:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116155452.30972-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BLEegEOtvuV7FQLNvS2z5IjSE4aUaTrQl"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BLEegEOtvuV7FQLNvS2z5IjSE4aUaTrQl
Content-Type: multipart/mixed; boundary="QChfY7XyghdANwwNKZZFbpT3vOfCw789p"

--QChfY7XyghdANwwNKZZFbpT3vOfCw789p
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.01.20 16:54, Vladimir Sementsov-Ogievskiy wrote:
> This test checks that bug is really fixed by previous commit.
>=20
> Cc: qemu-stable@nongnu.org # v4.2.0
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/283     | 75 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/283.out |  8 ++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 84 insertions(+)
>  create mode 100644 tests/qemu-iotests/283
>  create mode 100644 tests/qemu-iotests/283.out

The test looks good to me, I just have a comment nit and a note on the
fact that this should probably be queued only after Thomas=E2=80=99s =E2=80=
=9CEnable
more iotests during "make check-block"=E2=80=9D series.

> diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
> new file mode 100644
> index 0000000000..f0f216d109
> --- /dev/null
> +++ b/tests/qemu-iotests/283
> @@ -0,0 +1,75 @@
> +#!/usr/bin/env python
> +#
> +# Test for backup-top filter permission activation failure
> +#
> +# Copyright (c) 2019 Virtuozzo International GmbH.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +import iotests
> +
> +# The test is unrelated to formats, restrict it to qcow2 to avoid extra =
runs
> +iotests.verify_image_format(supported_fmts=3D['qcow2'])
> +
> +size =3D 1024 * 1024
> +
> +"""
> +On activation, backup-top is going to unshare write permission on its
> +source child. It will be impossible for the following configuration:

=E2=80=9CThe following configuration will become impossible=E2=80=9D?

I think there should be some note that this is exactly what we want to
test, i.e. what happens when this impossible configuration is attempted
by starting a backup.  (And maybe why this isn=E2=80=99t allowed; namely be=
cause
we couldn=E2=80=99t do CBW for such write accesses.)

> +
> +    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90  target  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
> +    =E2=94=82 target =E2=94=82 =E2=97=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80 =E2=94=82 backup_top  =E2=94=82
> +    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98
> +                            =E2=94=82
> +                            =E2=94=82 backing
> +                            =E2=96=BC
> +                        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90
> +                        =E2=94=82   source    =E2=94=82
> +                        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98
> +                            =E2=94=82
> +                            =E2=94=82 file
> +                            =E2=96=BC
> +                        =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90  write perm   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=90
> +                        =E2=94=82    base     =E2=94=82 =E2=97=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80 =E2=94=82 other =E2=94=82
> +                        =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98               =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=98

Cool Unicode art. :-)

> +
> +Write unsharing will be propagated to the "source->base"link and will
> +conflict with other node write permission.
> +
> +(Note, that we can't just consider source to be direct child of other,
> +as in this case this link will be broken, when backup_top is appended)
> +"""
> +
> +vm =3D iotests.VM()
> +vm.launch()
> +
> +vm.qmp_log('blockdev-add', **{'node-name': 'target', 'driver': 'null-co'=
})
> +
> +vm.qmp_log('blockdev-add', **{
> +    'node-name': 'source',
> +    'driver': 'blkdebug',
> +    'image': {'node-name': 'base', 'driver': 'null-co', 'size': size}
> +})
> +
> +vm.qmp_log('blockdev-add', **{
> +    'node-name': 'other',
> +    'driver': 'blkdebug',
> +    'image': 'base',
> +    'take-child-perms': ['write']
> +})
> +
> +vm.qmp_log('blockdev-backup', sync=3D'full', device=3D'source', target=
=3D'target')
> +
> +vm.shutdown()

[...]

> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index cb2b789e44..d827e8c821 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -288,3 +288,4 @@
>  277 rw quick
>  279 rw backing quick
>  280 rw migration quick
> +283 auto quick

Hm.  This would be the first Python test in auto.  Thomas=E2=80=99s series =
has
at least one patch that seems useful to come before we do this, namely
=E2=80=9CSkip Python-based tests if QEMU does not support virtio-blk=E2=80=
=9D.  So I
suppose his series should come before this, then.

Max


--QChfY7XyghdANwwNKZZFbpT3vOfCw789p--

--BLEegEOtvuV7FQLNvS2z5IjSE4aUaTrQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4l3bIACgkQ9AfbAGHV
z0BHOAf+NePNhh8c1GcpdU3gLlF39HPN9kv7LWXyRnzBhaQqXDnbEl4RlSAhyBZ6
xMGHrLpfVqQ0Tv8WyJjAxggV+C3yW2lnIfcH98k5vbKafEmovFxa0eziKZySwfYW
HSqX9b2KFCbmWiZTR0bmugYxeeZVcNfY54VQity9LipLkLHmo8n6eqV/U4T5sUoB
wl4MKd2GvZQGFNnxnYQgGlKSY+6FN06skpBIfWIk2Q/owlIc6rJBiU8/IyVHT6KH
nR6DkIh8d//mKDusRTWf/cHqk29zISQr+4P34qIVv7NEBVPbx4t18B6Fc2nkSpgG
9Y++PZsW6OEqmiHZgsVMm9EhjYppaw==
=o76p
-----END PGP SIGNATURE-----

--BLEegEOtvuV7FQLNvS2z5IjSE4aUaTrQl--


