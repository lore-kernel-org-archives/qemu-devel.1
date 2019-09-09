Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A09C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852FB20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852FB20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7JzX-0003Xl-N2
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7Jyf-0002uL-DU
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7Jye-0008As-02
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:45:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7JyZ-00087Y-On; Mon, 09 Sep 2019 09:45:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C0A78DCF81;
 Mon,  9 Sep 2019 13:45:03 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E15606012A;
 Mon,  9 Sep 2019 13:44:56 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-15-vsementsov@virtuozzo.com>
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
Message-ID: <ae052311-34bb-88a6-b415-fd79aaa45cb0@redhat.com>
Date: Mon, 9 Sep 2019 15:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830161228.54238-15-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rWvRkZYIxatezMNp0p7zUr93AIYGiZ7Kp"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Mon, 09 Sep 2019 13:45:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v10 14/14] block/backup: use backup-top
 instead of write notifiers
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
Cc: fam@euphon.net, kwolf@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 jsnow@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rWvRkZYIxatezMNp0p7zUr93AIYGiZ7Kp
Content-Type: multipart/mixed; boundary="gstlI6XGLrTZLGyvMIqVLd7dTgU7UXNAr";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net,
 stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <ae052311-34bb-88a6-b415-fd79aaa45cb0@redhat.com>
Subject: Re: [PATCH v10 14/14] block/backup: use backup-top instead of write
 notifiers
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-15-vsementsov@virtuozzo.com>
In-Reply-To: <20190830161228.54238-15-vsementsov@virtuozzo.com>

--gstlI6XGLrTZLGyvMIqVLd7dTgU7UXNAr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.08.19 18:12, Vladimir Sementsov-Ogievskiy wrote:
> Drop write notifiers and use filter node instead.
>=20
> =3D Changes =3D
>=20
> 1. Add filter-node-name argument for backup qmp api. We have to do it
> in this commit, as 257 needs to be fixed.
>=20
> 2. There are no more write notifiers here, so is_write_notifier
> parameter is dropped from block-copy paths.
>=20
> 3. Intersecting requests handling changed, now synchronization between
> backup-top, backup and guest writes are all done in block/block-copy.c
> and works as follows:
>=20
> On copy operation, we work only with dirty areas. If bits are dirty it
> means that there are no requests intersecting with this area. We clear
> dirty bits and take bdrv range lock (bdrv_co_try_lock) on this area to
> prevent further operations from interaction with guest (only with
> guest, as neither backup nor backup-top will touch non-dirty area). If
> copy-operation failed we set dirty bits back together with releasing
> the lock.
>=20
> The actual difference with old scheme is that on guest writes we
> don't lock the whole region but only dirty-parts, and to be more
> precise: only dirty-part we are currently operate on. In old scheme
> guest write to non-dirty area (which may be safely ignored by backup)
> may wait for intersecting request, touching some other area which is
> dirty.
>=20
> 4. To sync with in-flight requests at job finish we now have drained
> removing of the filter, we don't need rw-lock.
>=20
> =3D Notes =3D
>=20
> Note the consequence of three objects appearing: backup-top, backup job=

> and block-copy-state:
>=20
> 1. We want to insert backup-top before job creation, to behave similar
> with mirror and commit, where job is started upon filter.
>=20
> 2. We also have to create block-copy-state after filter injection, as
> we don't want its source child be replaced by filter. Instead we want
> to keep BCS.source to be real source node, as we want to use
> bdrv_co_try_lock in CBW operations and it can't be used on filter, as
> on filter we already have in-flight (write) request from upper layer.
>=20
> So, we firstly create inject backup-top, then create job and BCS. BCS
> is the latest just to not create extra variable for it. Finally we set
> bcs for backup-top filter.
>=20
> =3D Iotest changes =3D
>=20
> 56: op-blocker doesn't shoot now, as we set it on source, but then
> check on filter, when trying to start second backup.
> To keep the test we instead can catch another collision: both jobs will=

> get 'drive0' job-id, as job-id parameter is unspecified. To prevent
> interleaving with file-posix locks (as they are dependent on config)
> let's use another target for second backup.
>=20
> Also, it's obvious now that we'd like to drop this op-blocker at all
> and add a test-case for two backups from one node (to different
> destinations) actually works. But not in these series.
>=20
> 257: The test wants to emulate guest write during backup. They should
> go to filter node, not to original source node, of course. Therefore we=

> need to specify filter node name and use it.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json       |   8 +-
>  include/block/block-copy.h |  10 +-
>  include/block/block_int.h  |   1 +
>  block/backup-top.c         |  14 +-
>  block/backup.c             | 113 +++-----------
>  block/block-copy.c         |  45 ++++--
>  block/replication.c        |   2 +-
>  blockdev.c                 |   1 +
>  tests/qemu-iotests/056     |   8 +-
>  tests/qemu-iotests/257     |   7 +-
>  tests/qemu-iotests/257.out | 306 ++++++++++++++++++-------------------=

>  11 files changed, 238 insertions(+), 277 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--gstlI6XGLrTZLGyvMIqVLd7dTgU7UXNAr--

--rWvRkZYIxatezMNp0p7zUr93AIYGiZ7Kp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12V1YACgkQ9AfbAGHV
z0DfkAf/bEyIDXBZUXxRzWhNKnkKOmbrJeNmlyMD2IyUdJxFSP3/cwtqgM69R3SR
mlYcRR+WGqsdVQT4VjQBGmva/yw1AxyS7NH2rptRq2MqChRLpoJ5P8Eis/FQjirb
p2xt1nvkksZZhCOzdK4NOpd0LuPkLlgcKtGGTJ0vRle1FQQtdP31YqWiYAS1ETMI
9liAmLC9utWzu+0oMJ+bTfB6JF9WqOaUB1G6Q/uOVDV4tNXEuqc9gQRkXt9OHKdc
kQCoIE4L4rnNaH9s9GBV13t8HS9hd7nTVB8srT9TBY+D336kXCvSb/gbhbafcFd0
Nhlr/f3CUl0i/0sRsWkd4x87XJjGIg==
=0MZM
-----END PGP SIGNATURE-----

--rWvRkZYIxatezMNp0p7zUr93AIYGiZ7Kp--

