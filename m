Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1E1C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F7020896
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 19:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F7020896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbVlg-0007yv-6F
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 15:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbViF-0005d4-Mv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 15:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbVeC-0007o2-8Z
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 15:44:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbVeA-0007n3-Kn; Thu, 13 Jun 2019 15:44:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68DE73082E42;
 Thu, 13 Jun 2019 19:44:24 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3470D600C0;
 Thu, 13 Jun 2019 19:44:21 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190522170352.12020-1-mreitz@redhat.com>
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
Message-ID: <1eeac24b-7456-f533-b77e-e97acbd4d67c@redhat.com>
Date: Thu, 13 Jun 2019 21:44:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190522170352.12020-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QVnnVOVLQvDzYuTYnvCIgIihnhRVdNzHs"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 13 Jun 2019 19:44:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/8] block: Ignore loosening perm
 restrictions failures
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
--QVnnVOVLQvDzYuTYnvCIgIihnhRVdNzHs
Content-Type: multipart/mixed; boundary="vnMFXvAZqXYBNc8UiHz7ZOxBqZzgjjPt7";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1eeac24b-7456-f533-b77e-e97acbd4d67c@redhat.com>
Subject: Re: [PATCH v3 0/8] block: Ignore loosening perm restrictions failures
References: <20190522170352.12020-1-mreitz@redhat.com>
In-Reply-To: <20190522170352.12020-1-mreitz@redhat.com>

--vnMFXvAZqXYBNc8UiHz7ZOxBqZzgjjPt7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Ping

<bait>just the final three patches left to review</bait>


On 22.05.19 19:03, Max Reitz wrote:
> Hi,
>=20
> This series is mainly a fix for
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1703793.  The problem
> described there is that mirroring to a gluster volume, then switching
> off the volume makes qemu crash.  There are two problems here:
>=20
> (1) file-posix reopens the FD all the time because it thinks the FD it
>     has is RDONLY.  It actually isn=E2=80=99t after the first reopen, w=
e just
>     forgot to change the internal flags.  That=E2=80=99s what patch 1 i=
s for.
>=20
> (2) Even then, when mirror completes, it drops its write permission on
>     the FD.  This requires a reopen, which will fail if the volume is
>     down.  Mirror doesn=E2=80=99t expect that.  Nobody ever expects tha=
t
>     dropping permissions can fail, and rightfully so because that=E2=80=
=99s what
>     I think we have generally agreed on.
>     Therefore, the block layer should hide this error.  This is what th=
e
>     last two patches are for.
>=20
> The penultimate patch adds two assertions: bdrv_replace_child() (for th=
e
> old BDS) and bdrv_inactivate_recurse() assume they only ever drop
> assertions.  This is now substantiated by these new assertions.
> It turns out that this assumption was just plain wrong.  Patches 3 to 5=

> make it right.
>=20
>=20
> v3:
> - Received no reply to my =E2=80=9CHm, warnings break 'make check', so =
maybe we
>   should just keep quiet if loosening restrictions fails?=E2=80=9D ques=
tion, so
>   I assume silence means agreement.  Changed patch 7 accordingly.
>=20
> - Added a test: The fact how make check kind-of-but-not-really broke
>   showed a nice reproducer: Launching qemu with some file, then deletin=
g
>   that file, then quitting qemu.
>=20
> - Rebase =E2=80=9Cconflict=E2=80=9D in patch 6: The forward declaration=
 of
>   bdrv_get_cumulative_perm() is already in qemu thanks to commit
>   481e0eeef4f.
>=20
>=20
> git-backport-diff against v2:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/8:[----] [--] 'file-posix: Update open_flags in raw_set_perm()'
> 002/8:[----] [--] 'block: Add bdrv_child_refresh_perms()'
> 003/8:[----] [--] 'block/mirror: Fix child permissions'
> 004/8:[----] [--] 'block/commit: Drop bdrv_child_try_set_perm()'
> 005/8:[0018] [FC] 'block: Fix order in bdrv_replace_child()'
>        ^^^^ Again confuses my v2 patch with 8aecf1d1bd250a, should be:
>       [----] : patches are identical
> 006/8:[0002] [FC] 'block: Add *tighten_restrictions to *check*_perm()'
> 007/8:[0018] [FC] 'block: Ignore loosening perm restrictions failures'
> 008/8:[down] 'iotests: Test failure to loosen restrictions'
>=20
>=20
> Max Reitz (8):
>   file-posix: Update open_flags in raw_set_perm()
>   block: Add bdrv_child_refresh_perms()
>   block/mirror: Fix child permissions
>   block/commit: Drop bdrv_child_try_set_perm()
>   block: Fix order in bdrv_replace_child()
>   block: Add *tighten_restrictions to *check*_perm()
>   block: Ignore loosening perm restrictions failures
>   iotests: Test failure to loosen restrictions
>=20
>  include/block/block_int.h  |  15 ++++
>  block.c                    | 153 +++++++++++++++++++++++++++++++------=

>  block/commit.c             |   2 -
>  block/file-posix.c         |   4 +
>  block/mirror.c             |  32 +++++---
>  tests/qemu-iotests/182     |  21 +++++
>  tests/qemu-iotests/182.out |   6 ++
>  7 files changed, 198 insertions(+), 35 deletions(-)
>=20



--vnMFXvAZqXYBNc8UiHz7ZOxBqZzgjjPt7--

--QVnnVOVLQvDzYuTYnvCIgIihnhRVdNzHs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0Cp5MACgkQ9AfbAGHV
z0Drzgf/YSC4OyBwIMcPC3/tztaV6h+rPVhTvCLS+HGWAZmjEKNm+a5dd+WrESHp
bVNHoD1s/5+esGQYwf9oGVJjrkaaKSxjygAnfl4Rx1FLdXNq5feukkd7cP8lvAH7
8/BOAdl+R6dGlwP4WwGh4EBDeYs92ALAHMudUZT6XpGtjEsAgqIIhw0spjrjGao/
PO0rqO7MW6b/JjtavwpMA191kV04SS6V9eALrl6PTVf/tNQ3yeJh7gXHeDpWsnTY
DDTnDwW1KzfW0rVys25/YvYoY/aDAyRk2zh+CwSFYo9LNPUE8bILRoi1uVMO6tBX
Y9tzox9S535SziXIO/fyos2HzBTPdQ==
=rfM5
-----END PGP SIGNATURE-----

--QVnnVOVLQvDzYuTYnvCIgIihnhRVdNzHs--

