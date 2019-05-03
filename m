Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1208AC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 23:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA3B206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 23:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA3B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48655 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMhwx-0003WK-M7
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 19:50:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMhw4-0002pX-7A
	for qemu-devel@nongnu.org; Fri, 03 May 2019 19:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMhw3-0008JW-5s
	for qemu-devel@nongnu.org; Fri, 03 May 2019 19:49:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hMhw0-0008HP-Qq; Fri, 03 May 2019 19:49:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 465573082AFF;
	Fri,  3 May 2019 23:49:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-131.brq.redhat.com
	[10.40.204.131])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AFA8818343;
	Fri,  3 May 2019 23:49:40 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20190331111747.14685-1-berto@igalia.com>
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
Message-ID: <b2899621-2124-d257-87cd-0de727aba888@redhat.com>
Date: Sat, 4 May 2019 01:49:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331111747.14685-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p2ZMLAXH3JK9LPExHYiQp1oqrkaZbkvWK"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 03 May 2019 23:49:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.1] block: Use bdrv_unref_child() for
 all children in bdrv_close()
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
Message-ID: <20190503234939.KKDeV69qekiEGqQsylOSCe1h5u7VV1sTt6M6ii6HTO0@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p2ZMLAXH3JK9LPExHYiQp1oqrkaZbkvWK
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b2899621-2124-d257-87cd-0de727aba888@redhat.com>
Subject: Re: [PATCH for-4.1] block: Use bdrv_unref_child() for all children in
 bdrv_close()
References: <20190331111747.14685-1-berto@igalia.com>
In-Reply-To: <20190331111747.14685-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.03.19 13:17, Alberto Garcia wrote:
> bdrv_unref_child() does the following things:
>=20
>   - Updates the child->bs->inherits_from pointer.
>   - Calls bdrv_detach_child() to remove the BdrvChild from bs->children=
=2E
>   - Calls bdrv_unref() to unref the child BlockDriverState.
>=20
> When bdrv_unref_child() was introduced in commit 33a604075c it was not
> used in bdrv_close() because the drivers that had additional children
> (like quorum or blkverify) had already called bdrv_unref() on their
> children during their own close functions.
>=20
> This was changed later (in 0bd6e91a7e for quorum, in 3e586be0b2 for
> blkverify) so there's no reason not to use bdrv_unref_child() in
> bdrv_close() anymore.
>=20
> After this there's also no need to remove bs->backing and bs->file
> separately from the rest of the children, so bdrv_close() can be
> simplified.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)

Hm, I=E2=80=99m afraid this breaks make check:

$ make -j 4 && make tests/test-bdrv-drain && gtester tests/test-bdrv-drai=
n

TEST: tests/test-bdrv-drain... (pid=3D22321)
test-bdrv-drain: block.c:5397: bdrv_unref: Assertion `bs->refcnt > 0'
failed.

(gdb) bt
#0  0x00007f15c7ffc57f in raise () from /lib64/libc.so.6
#1  0x00007f15c7fe6895 in abort () from /lib64/libc.so.6
#2  0x00007f15c7fe6769 in __assert_fail_base.cold.0 () from /lib64/libc.s=
o.6
#3  0x00007f15c7ff4a26 in __assert_fail () from /lib64/libc.so.6
#4  0x00005562a11b0a00 in bdrv_unref (bs=3D0x5562a3370c30) at block.c:539=
7
#5  bdrv_unref (bs=3D0x5562a3370c30) at block.c:5392
#6  0x00005562a11a7f8f in test_detach_indirect (by_parent_cb=3D<optimized=

out>) at tests/test-bdrv-drain.c:1442
#7  0x00007f15c8766fca in ?? () from /lib64/libglib-2.0.so.0
#8  0x00007f15c8766e84 in ?? () from /lib64/libglib-2.0.so.0
#9  0x00007f15c8766e84 in ?? () from /lib64/libglib-2.0.so.0
#10 0x00007f15c8767282 in g_test_run_suite () from /lib64/libglib-2.0.so.=
0
#11 0x00007f15c87672a5 in g_test_run () from /lib64/libglib-2.0.so.0
#12 0x00005562a11a5b77 in main (argc=3D<optimized out>, argv=3D<optimized=

out>) at tests/test-bdrv-drain.c:1617

So I=E2=80=99ll dequeue this patch for now.

Max


--p2ZMLAXH3JK9LPExHYiQp1oqrkaZbkvWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzM05MACgkQ9AfbAGHV
z0BzNgf+O8nRk8FhleOT2T2xVmcEW6HVv/nVcdMa+pZXDNnRN8a5T5ZpweFuZnwn
VmQ7SaI+C8YWzGCNkpEAjaUqxS6IVCIgykLQ8hl11k7ZZNc2fGj9cGeO0wNEFlre
FzPBtlxQHYKT7jIDUL3FreSIO1BW9EXNupBYziBuXZOfuVjIPlSDeEfgmYiCdUJD
Rb7ML4scyAz3F8wwhb8ZorBwH2Va8DtLzuwsZ2wWZd7yx9ryZ/aNfgx2KKwj6dmr
NqcIlu7yRYswsu6eXtfceoR9KjWoYz448SMLJrYZSkfI8iD/pYGyrMWIUu7k9upI
l3SImzAefVHHq7LyAjhFOIuB6LmEbw==
=G78O
-----END PGP SIGNATURE-----

--p2ZMLAXH3JK9LPExHYiQp1oqrkaZbkvWK--

