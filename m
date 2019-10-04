Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A411C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE882070B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE882070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGOTi-0006IT-6r
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 10:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGOSK-000540-Hs
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 10:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGOSH-0005dv-IF
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 10:21:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGOSE-0005cR-3h; Fri, 04 Oct 2019 10:21:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16375315C027;
 Fri,  4 Oct 2019 14:21:09 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8A9119C5B;
 Fri,  4 Oct 2019 14:21:01 +0000 (UTC)
Subject: Re: [PATCH v15 0/5] backup-top filter driver for backup
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191001131409.14202-1-vsementsov@virtuozzo.com>
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
Message-ID: <5b6c405f-e8a1-43eb-b709-53e88ad642e1@redhat.com>
Date: Fri, 4 Oct 2019 16:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001131409.14202-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nDaPVilttZcwM1PVFtSNA8Yx9ZBCbVfCg"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 04 Oct 2019 14:21:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 qemu-devel@nongnu.org, armbru@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nDaPVilttZcwM1PVFtSNA8Yx9ZBCbVfCg
Content-Type: multipart/mixed; boundary="j22uwsHuRQI1CLPO2hMgtWCExcuzpViMI"

--j22uwsHuRQI1CLPO2hMgtWCExcuzpViMI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.10.19 15:14, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> These series introduce backup-top driver. It's a filter-node, which
> do copy-before-write operation. Mirror uses filter-node for handling
> guest writes, let's move to filter-node (from write-notifiers) for
> backup too.
>=20
> Preparation patches are queued in Max's block branch:
>=20
> Based-on: https://github.com/XanClic/qemu.git block
>=20
> v15: use BdrvChildren in block-copy
> 01-03: new
> 04-05: a lot of changes, such as
> 04:
>     - add new parameters for creation
>     - prepare bcs creation
>     - add target child
>     - refactor bdrv_backup_top_append
>     - drop r-b
> 05:
>     - move block-copy to use BdrvChildren
>     - drop extra style fixing hunks
>     - iotest 141 output changed
>=20
> v14: Drop range locks, keep old good in-flight requests waiting
>=20
> 12: new patch
> 14: use old request-waiting scheme instead of range locks
>=20
> Vladimir Sementsov-Ogievskiy (5):
>   block/backup: move in-flight requests handling from backup to
>     block-copy
>   block/backup: move write_flags calculation inside backup_job_create
>   block/block-copy: split block_copy_set_callbacks function
>   block: introduce backup-top filter driver
>   block/backup: use backup-top instead of write notifiers
>=20
>  qapi/block-core.json       |   8 +-
>  block/backup-top.h         |  41 +++++
>  include/block/block-copy.h |  31 +++-
>  include/block/block_int.h  |   1 +
>  block/backup-top.c         | 276 +++++++++++++++++++++++++++++++++
>  block/backup.c             | 147 +++++-------------
>  block/block-copy.c         | 140 +++++++++--------
>  block/replication.c        |   2 +-
>  blockdev.c                 |   1 +
>  block/Makefile.objs        |   1 +
>  tests/qemu-iotests/056     |   8 +-
>  tests/qemu-iotests/141.out |   2 +-
>  tests/qemu-iotests/257     |   7 +-
>  tests/qemu-iotests/257.out | 306 ++++++++++++++++++-------------------=

>  14 files changed, 628 insertions(+), 343 deletions(-)
>  create mode 100644 block/backup-top.h
>  create mode 100644 block/backup-top.c

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--j22uwsHuRQI1CLPO2hMgtWCExcuzpViMI--

--nDaPVilttZcwM1PVFtSNA8Yx9ZBCbVfCg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2XVUwACgkQ9AfbAGHV
z0Cn9Af/Ub9MHBSSHqBHCgJyIIZIiCFkfeoBlgkV3nNInEqn5BYL228q/bmxqMeU
tuTQDjqE52HHD4PvMeEPiLFxmXpOGZQgC7ZpFcsFsrFSIpoPJn2w876TFBi1gbAy
EWIiI9AQ2wKlkXD5T6hjLuXXAhlIU51weEuI3/G4xXr5KAQEMqSa3gCk/eXhYOQX
g4l8nYY3PPJDfGMjWH9a7MryUPEjkSplI/qjOf7QHnvLe4ydJrK8XRw3OO+HNUqW
SsSABsPllsmIT+2kI2R4TfiO/skJbtrnJLLP9JGoHydlKYmIsm6a9lthi0f8Bpkn
Fbkj3P+G+v/S8VJAN2pzAUB6eSbyjw==
=OVtw
-----END PGP SIGNATURE-----

--nDaPVilttZcwM1PVFtSNA8Yx9ZBCbVfCg--

