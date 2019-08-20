Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75647C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E03A20C01
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 19:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E03A20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ADU-0000YV-S0
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 15:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i0A9t-0006PW-G2
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i0A9r-0000Tz-ET
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 15:51:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i0A9l-0000Q8-3Z; Tue, 20 Aug 2019 15:51:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC7043175283;
 Tue, 20 Aug 2019 19:50:59 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F26F418946;
 Tue, 20 Aug 2019 19:50:54 +0000 (UTC)
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org
References: <20190817175346.12518-1-nsoffer@redhat.com>
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
Message-ID: <0d8c2c6a-55ef-3517-b93c-05d9a04e5d26@redhat.com>
Date: Tue, 20 Aug 2019 21:50:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817175346.12518-1-nsoffer@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i0fnbuoqgbe9csrEb1IRbzT64LzkxQPwP"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 20 Aug 2019 19:51:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block: Use QEMU_IS_ALIGNED instead of
 reinventing it
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nir Soffer <nsoffer@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i0fnbuoqgbe9csrEb1IRbzT64LzkxQPwP
Content-Type: multipart/mixed; boundary="8GgMb1U36y2tOhNOYfHVi2FU6TbkgSXdM";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nir Soffer <nsoffer@redhat.com>
Message-ID: <0d8c2c6a-55ef-3517-b93c-05d9a04e5d26@redhat.com>
Subject: Re: [PATCH] block: Use QEMU_IS_ALIGNED instead of reinventing it
References: <20190817175346.12518-1-nsoffer@redhat.com>
In-Reply-To: <20190817175346.12518-1-nsoffer@redhat.com>

--8GgMb1U36y2tOhNOYfHVi2FU6TbkgSXdM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.08.19 19:53, Nir Soffer wrote:
> Replace instances of:
>=20
>     (n & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0)
>=20
> With:
>=20
>     QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE)
>=20
> Which reveals the intent of the code better, and makes it easier to
> locate the code checking alignment.
>=20
> QEMU_IS_ALIGNED is implemented using %, which may be less efficient but=

> it is used only in assert() except one instance, so it should not
> matter.
>=20
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  block/bochs.c | 4 ++--
>  block/cloop.c | 4 ++--
>  block/dmg.c   | 4 ++--
>  block/io.c    | 8 ++++----
>  block/qcow2.c | 4 ++--
>  block/vvfat.c | 8 ++++----
>  qemu-img.c    | 2 +-
>  7 files changed, 17 insertions(+), 17 deletions(-)

Because John was speaking about a magical incantation, I found
BDRV_SECTOR_MASK.  There are two places in block/qcow2-cluster.c that
use that to check alignment, I think those should be amended as well.

Max


--8GgMb1U36y2tOhNOYfHVi2FU6TbkgSXdM--

--i0fnbuoqgbe9csrEb1IRbzT64LzkxQPwP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1cTx0ACgkQ9AfbAGHV
z0D78Qf+KsGiQBO4K8OgkZ5O6v4eMj0RXxuiG3ZbF1QFRXgfyaMzAMUGz4WZsHoj
TFYrInyH+V7G7dH4+20cd2W9xIjP3CUZi9l60tEgs9vAQiTRvRpDgv/pfRRL1t5v
1cnGdCjYTY6jAe7EQ/GHLNSIi98JvlnwDujC3QFpMGHX0x86C7GpsiGUS4RozXDG
MAxcvGb7wdA8/etzCykfDfai0ZoAqNMH3kLSB2QhKTd7L29yBP4G6DV71wzZx+rd
wAT7B51AxBhPdt9nQg5AKb4QIOg8wsww4Y9fjYPLlHjO4yjho5vPh1KgvML8Yc3T
snjsIO+spQ88wVPE1NUtlyaHsUwxCg==
=Ciej
-----END PGP SIGNATURE-----

--i0fnbuoqgbe9csrEb1IRbzT64LzkxQPwP--

