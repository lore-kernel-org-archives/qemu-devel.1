Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B56C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 21:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27176208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 21:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27176208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlKB9-0000PA-FX
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 17:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50777)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlK9W-0008AO-6w
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 17:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlK9U-0002zI-84
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 17:29:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlK9K-0002M6-5n; Wed, 10 Jul 2019 17:29:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86B7330B97AA;
 Wed, 10 Jul 2019 21:29:01 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86BB05D9CA;
 Wed, 10 Jul 2019 21:29:00 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190703172813.6868-1-mreitz@redhat.com>
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
Message-ID: <8920a73b-36fd-ab1f-8a6a-8fa600e5f788@redhat.com>
Date: Wed, 10 Jul 2019 23:28:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703172813.6868-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t0pNsTNK30pWZDrN4MaRsmCSavGkcz4RY"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 10 Jul 2019 21:29:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 00/12] block: Fixes for concurrent block
 jobs
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t0pNsTNK30pWZDrN4MaRsmCSavGkcz4RY
Content-Type: multipart/mixed; boundary="4ULhHFGuD74yHSZDMiYsF2i4qyHybbH6K";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <8920a73b-36fd-ab1f-8a6a-8fa600e5f788@redhat.com>
Subject: Re: [PATCH v2 00/12] block: Fixes for concurrent block jobs
References: <20190703172813.6868-1-mreitz@redhat.com>
In-Reply-To: <20190703172813.6868-1-mreitz@redhat.com>

--4ULhHFGuD74yHSZDMiYsF2i4qyHybbH6K
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping

I suppose I=E2=80=99ll apply the patches I had in v1 if I don=E2=80=99t g=
et reviews for
the new patches, because some fixes are better than none.

(And probably patch 2, because it=E2=80=99s obvious.)

Max

On 03.07.19 19:28, Max Reitz wrote:
> This is a v2 to =E2=80=9Cblock: Add BDS.never_freeze=E2=80=9D.
>=20
> It depends on my =E2=80=9Cblock: Delay poll when ending drained section=
s=E2=80=9D
> series:
>=20
> Depends-on: <20190619152603.5937-1-mreitz@redhat.com>
>=20
>=20
> It turned out that if you run 030 (or just the new test_overlapping_5
> case) sufficiently often, it breaks; which is why I=E2=80=99m hesitant =
to just
> merge the =E2=80=9Cadd never_freeze=E2=80=9D series as it is.
>=20
> There are several reasons for why this test case breaks, I hope patches=

> 3 to 6 fix them.  Patch 12 adds a test that is much more reliable than
> test_overlapping_5 at detecting the problems fixed by at least patches =
4
> to 6.  (I think that 3 doesn=E2=80=99t really need a test.)
>=20
> I=E2=80=99m sure there are other ways to see these problems, but well, =
coming
> from 030, concurrent commit/stream jobs are how I reproduced them.
> Hence the same of this series.
>=20
> Patch 2 is for something I encountered on the way.  Patch 11 tests it.
>=20
>=20
> v2:
> - Added a bunch of more patches.
>=20
>=20
> git backport-diff against v1:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/12:[----] [--] 'block: Add BDS.never_freeze'
> 002/12:[down] 'block/stream: Fix error path'
> 003/12:[down] 'block/stream: Swap backing file change order'
> 004/12:[down] 'block: Keep subtree drained in drop_intermediate'
> 005/12:[down] 'block: Reduce (un)drains when replacing a child'
> 006/12:[down] 'block: Deep-clear inherits_from'
> 007/12:[----] [--] 'iotests: Fix throttling in 030'
> 008/12:[----] [--] 'iotests: Compare error messages in 030'
> 009/12:[----] [--] 'iotests: Add @use_log to VM.run_job()'
> 010/12:[----] [--] 'iotests: Add new case to 030'
> 011/12:[down] 'iotests: Add read-only test case to 030'
> 012/12:[down] 'iotests: Add test for concurrent stream/commit'
>=20
>=20
>=20
> Max Reitz (12):
>   block: Add BDS.never_freeze
>   block/stream: Fix error path
>   block/stream: Swap backing file change order
>   block: Keep subtree drained in drop_intermediate
>   block: Reduce (un)drains when replacing a child
>   block: Deep-clear inherits_from
>   iotests: Fix throttling in 030
>   iotests: Compare error messages in 030
>   iotests: Add @use_log to VM.run_job()
>   iotests: Add new case to 030
>   iotests: Add read-only test case to 030
>   iotests: Add test for concurrent stream/commit
>=20
>  include/block/block_int.h     |   3 +
>  block.c                       |  93 +++++++++++++------
>  block/commit.c                |   4 +
>  block/mirror.c                |   4 +
>  block/stream.c                |   4 +-
>  tests/qemu-iotests/030        | 150 +++++++++++++++++++++++++------
>  tests/qemu-iotests/030.out    |   4 +-
>  tests/qemu-iotests/258        | 163 ++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/258.out    |  33 +++++++
>  tests/qemu-iotests/group      |   1 +
>  tests/qemu-iotests/iotests.py |  18 ++--
>  11 files changed, 413 insertions(+), 64 deletions(-)
>  create mode 100755 tests/qemu-iotests/258
>  create mode 100644 tests/qemu-iotests/258.out
>=20



--4ULhHFGuD74yHSZDMiYsF2i4qyHybbH6K--

--t0pNsTNK30pWZDrN4MaRsmCSavGkcz4RY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0mWJsACgkQ9AfbAGHV
z0ChnQf7BVGhvc388oq0S/bi6DnDrcpYcpMtGZj86taweMzLAkZu6/EY+HbhhGgN
8rksbYt+2tdHXj6WOmV3iUgKpVNn9Ai0lOGfexSfO0XgIfZEqCdwgRjaz5LiEAJY
BBevaT89jdC/qQItvAp0Mjyae9rg8HTHoGY61xdc+4Lw3ETHZ4GAaP5C9IUWek0Z
uks3j4/AVTtwZEtt3dkaZDEKNeFrfta9+RQmmly9pCP2+KTyi8y1rJMBOerevmWs
zop35rRIJgFcrdUBoLoR2BDfEkwgyJwH2jaTYg8GknpOFvPgxxymP4WZyjvOWBAY
zWgwzsWScHluDX0y320XSwQM35/NcQ==
=aE2g
-----END PGP SIGNATURE-----

--t0pNsTNK30pWZDrN4MaRsmCSavGkcz4RY--

