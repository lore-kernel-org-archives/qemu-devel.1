Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D95C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 15:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122D221848
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 15:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122D221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVHKb-0004YL-8I
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 11:14:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVHJn-0004Cv-Ev
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVHJm-0007lq-7R
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:13:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVHJj-0007hl-5a; Mon, 27 May 2019 11:13:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5CD9308FE62;
	Mon, 27 May 2019 15:13:37 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A5C7F608A4;
	Mon, 27 May 2019 15:13:31 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190408162617.258535-1-vsementsov@virtuozzo.com>
	<20190408162617.258535-3-vsementsov@virtuozzo.com>
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
Message-ID: <4fdb0181-b9ae-25fa-c601-9f646772c0bd@redhat.com>
Date: Mon, 27 May 2019 17:13:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408162617.258535-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FahmQZwjX6dQxSHXA0cIYZzb974PNalZh"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 27 May 2019 15:13:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 2/2] block: avoid recursive block_status
 call if possible
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
Cc: kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FahmQZwjX6dQxSHXA0cIYZzb974PNalZh
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, eblake@redhat.com,
 den@openvz.org
Message-ID: <4fdb0181-b9ae-25fa-c601-9f646772c0bd@redhat.com>
Subject: Re: [PATCH v2 2/2] block: avoid recursive block_status call if
 possible
References: <20190408162617.258535-1-vsementsov@virtuozzo.com>
 <20190408162617.258535-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190408162617.258535-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.04.19 18:26, Vladimir Sementsov-Ogievskiy wrote:
> drv_co_block_status digs bs->file for additional, more accurate search
> for hole inside region, reported as DATA by bs since 5daa74a6ebc.
>=20
> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> knows, where are holes and where is data. But every block_status
> request calls lseek additionally. Assume a big disk, full of
> data, in any iterative copying block job (or img convert) we'll call
> lseek(HOLE) on every iteration, and each of these lseeks will have to
> iterate through all metadata up to the end of file. It's obviously
> ineffective behavior. And for many scenarios we don't need this lseek
> at all.
>=20
> However, lseek is needed when we have metadata-preallocated image.
>=20
> So, let's detect metadata-preallocation case and don't dig qcow2's
> protocol file in other cases.
>=20
> The idea is to compare allocation size in POV of filesystem with
> allocations size in POV of Qcow2 (by refcounts). If allocation in fs is=

> significantly lower, consider it as metadata-preallocation case.
>=20
> 102 iotest changed, as our detector can't detect shrinked file as
> metadata-preallocation, which don't seem to be wrong, as with metadata
> preallocation we always have valid file length.
>=20
> Other two iotests tiny changed QMP output sequence, which should be
> exactly because skipped lseek at mirror beginning.
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.h              |  4 ++++
>  include/block/block.h      |  8 +++++++-
>  block/io.c                 |  9 ++++++++-
>  block/qcow2-refcount.c     | 32 ++++++++++++++++++++++++++++++++
>  block/qcow2.c              | 11 +++++++++++
>  tests/qemu-iotests/102     |  2 +-
>  tests/qemu-iotests/102.out |  3 ++-
>  tests/qemu-iotests/141.out |  2 +-
>  tests/qemu-iotests/144.out |  2 +-
>  9 files changed, 67 insertions(+), 6 deletions(-)

For me, this patch breaks iotests 141 (for qed) and 211 (for vdi):

> 141 1s ...        [17:11:53] [17:11:53] - output mismatch (see 141.out.=
bad)
> --- tests/qemu-iotests/141.out 2019-05-27 17:11:43.327664282 +0200
> +++ build/tests/qemu-iotests/141.out.bad       2019-05-27 17:11:53.9494=
39880 +0200
> @@ -42,9 +42,9 @@
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
> -{"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0=
, "speed": 0, "type": "commit"}}
> +{"return": {}}
>  {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: bloc=
k device is in use by block job: commit"}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}

and

> 211 5s ...        [17:11:54] [17:11:58] - output mismatch (see 211.out.=
bad)
> --- tests/qemu-iotests/211.out 2019-05-22 19:58:34.870273427 +0200
> +++ build/tests/qemu-iotests/211.out.bad       2019-05-27 17:11:58.2593=
48827 +0200
> @@ -55,8 +55,7 @@
>  virtual size: 32 MiB (33554432 bytes)
>  cluster_size: 1048576
> =20
> -[{ "start": 0, "length": 3072, "depth": 0, "zero": false, "data": true=
, "offset": 1024},
> -{ "start": 3072, "length": 33551360, "depth": 0, "zero": true, "data":=
 true, "offset": 4096}]
> +[{ "start": 0, "length": 33554432, "depth": 0, "zero": false, "data": =
true, "offset": 1024}]
> =20
>  =3D=3D=3D Invalid BlockdevRef =3D=3D=3D

Doesn=E2=80=99t look too bad, but still, broken iotests are broken iotest=
s. :/

Max


--FahmQZwjX6dQxSHXA0cIYZzb974PNalZh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzr/poACgkQ9AfbAGHV
z0DQnwf/Xj/4wqkgynhzteFGceVS5wvmuOerDNJiSVfJF7clG8k0KJbnljfYYzge
kab4e237IPfJN3kh5Kechn1B0tL4BnIUCOJgkETfo7FyNbX4F4tmDe7xZQ345p8B
uCLJ8lEHtE9Rt5YoDeaU37Oq+YZZHY+3wCwQ26f3m2EcM4VKZOMFqXJYasxp7/B6
auxREww76Q0CCg/19GjI0YqLdSl0xmDWLZAvVmkp4UW+n/VwGS/69tzwSDJcUL+K
LcIEqTdiKaSPXRiTEnvGVnQ3RdksICG3DhJNoLg5CUPBzDEGCQCLPvBTqSLlWwX0
q1ymgQt2HrCEM/DXZEDX8i9XR1wIiA==
=q6hu
-----END PGP SIGNATURE-----

--FahmQZwjX6dQxSHXA0cIYZzb974PNalZh--

