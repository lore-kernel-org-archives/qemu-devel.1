Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B759CC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525252084B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525252084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41358 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgJ4-0001Fr-G2
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51022)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdgH4-00007F-5D
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdgH2-0000It-UM
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:29:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdgGy-0000FW-6k; Wed, 19 Jun 2019 15:29:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5827A22386E;
 Wed, 19 Jun 2019 19:29:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-121.ams2.redhat.com
 [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E57F5D9C6;
 Wed, 19 Jun 2019 19:29:24 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <87a5ec62-6274-77c6-60a3-b4ad7b4ec822@redhat.com>
Date: Wed, 19 Jun 2019 21:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E5IJMqXoO5MUPn2rPE8uMxQnPqYSssdNm"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 19 Jun 2019 19:29:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 0/3] block/stream: get rid of the base
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 berto@igalia.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E5IJMqXoO5MUPn2rPE8uMxQnPqYSssdNm
Content-Type: multipart/mixed; boundary="z70sWiktRL7E3sohsTywm9Cd81VAwfl5y";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, jsnow@redhat.com,
 stefanha@redhat.com, fam@euphon.net, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <87a5ec62-6274-77c6-60a3-b4ad7b4ec822@redhat.com>
Subject: Re: [PATCH v7 0/3] block/stream: get rid of the base
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>

--z70sWiktRL7E3sohsTywm9Cd81VAwfl5y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.05.19 19:56, Andrey Shinkevich wrote:
> This series introduces a bottom intermediate node that eliminates the
> dependency on the base that may change while stream job is running.
> It happens when stream/commit parallel jobs are running on the same
> backing chain. The base node of the stream job may be a top node of
> the parallel commit job and can change before the stream job is
> completed. We avoid that dependency by introducing the bottom node.
>=20
> v7: [resend by Andrey]
>   01: assert(intermediate) was inserted before the call to
>       bdrv_is_allocated() in the intermediate node loop of the
>       bdrv_is_allocated_above() as suggested by Max.
>   02: The change of the intermediate node loop in the stream_start() wa=
s
>       rolled back to its original design and the reassignment of the ba=
se
>       node pointer was added as Vladimir and Max suggested. The relevan=
t
>       comment was amended.
>=20
> v6: [resend by Vladimir]
>   01: improve comment in block/io.c, suggested by Alberto
>=20
> v5: [resend by Vladimir]
>   01: use comment wording in block/io.c suggested by Alberto
>=20
> v4:
> trace_stream_start reverted to the base.
> bdrv_is_allocated_above_inclusive() deleted and the new parameter
> 'bool include_base' was added to the bdrv_is_allocated_above().
>=20
> Andrey Shinkevich (3):
>   block: include base when checking image chain for block allocation
>   block/stream: refactor stream_run: drop goto
>   block/stream: introduce a bottom node
>=20
>  block/commit.c         |  2 +-
>  block/io.c             | 21 +++++++++++++------
>  block/mirror.c         |  2 +-
>  block/replication.c    |  2 +-
>  block/stream.c         | 56 ++++++++++++++++++++++++------------------=
--------
>  include/block/block.h  |  3 ++-
>  tests/qemu-iotests/245 |  4 ++--
>  7 files changed, 49 insertions(+), 41 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

Just needs some simple changes to patch 1 to rebase it on 863cc78f1b3
and c8bb23cbdbe.

Max


--z70sWiktRL7E3sohsTywm9Cd81VAwfl5y--

--E5IJMqXoO5MUPn2rPE8uMxQnPqYSssdNm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0KjRMACgkQ9AfbAGHV
z0CAtQf+OibHcNFuwNkfC8UebYt/SmPOMgnbu0oFOlf9NRzJFaCPGoB700oDu/35
azkf1jAFewWxy6CV35budMtXssi0gH2BGMqSPTXj+YE0onVn6FYBMlpK9PGT9Y1m
vaHYlFsaT5JcE7dfs4m+yEj88R62NswKWLZokfMFtOWVWGQVTyJFZEOp42bs3S/Z
whJ56RymhMZ2ILkO8jNqSmrKUl5rlIxeLrQ/gDVsJBESPbHPMb66c6gLjsFRzLsK
sdaQmRIgQTD7EZ3xEWYC47OT0gVLJjK1/F4/G+QSIJ0J1hQx7cPlk/mG3XE3ZjnY
upVvZs02N97+1dfOAOu4Fgbeuv2MKw==
=7hTm
-----END PGP SIGNATURE-----

--E5IJMqXoO5MUPn2rPE8uMxQnPqYSssdNm--

