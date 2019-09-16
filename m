Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888E8C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 12:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5669420665
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 12:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5669420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9qLw-0000Or-CE
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 08:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9qKv-0008Bi-5V
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9qKt-0006uC-SX
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 08:42:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9qKp-0006sJ-3f; Mon, 16 Sep 2019 08:42:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E262CA70E;
 Mon, 16 Sep 2019 12:42:25 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A58DC60BE1;
 Mon, 16 Sep 2019 12:42:22 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190915203655.21638-1-mlevitsk@redhat.com>
 <20190915203655.21638-2-mlevitsk@redhat.com>
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
Message-ID: <de464a16-d4c4-5adb-69f8-4f1ed1717533@redhat.com>
Date: Mon, 16 Sep 2019 14:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190915203655.21638-2-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="caOjIlolDftIqjlzmFnjbKHOvlG3cFyYj"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 16 Sep 2019 12:42:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 1/3] block/qcow2: Fix corruption
 introduced by commit 8ac0f15f335
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--caOjIlolDftIqjlzmFnjbKHOvlG3cFyYj
Content-Type: multipart/mixed; boundary="1fiOmnlFOfQRCnLjp07dTSzlfCyh15W8o";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Message-ID: <de464a16-d4c4-5adb-69f8-4f1ed1717533@redhat.com>
Subject: Re: [PATCH v7 1/3] block/qcow2: Fix corruption introduced by commit
 8ac0f15f335
References: <20190915203655.21638-1-mlevitsk@redhat.com>
 <20190915203655.21638-2-mlevitsk@redhat.com>
In-Reply-To: <20190915203655.21638-2-mlevitsk@redhat.com>

--1fiOmnlFOfQRCnLjp07dTSzlfCyh15W8o
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.09.19 22:36, Maxim Levitsky wrote:
> This fixes subtle corruption introduced by luks threaded encryption
> in commit 8ac0f15f335
>=20
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1745922
>=20
> The corruption happens when we do a write that
>    * writes to two or more unallocated clusters at once
>    * doesn't fully cover the first sector
>    * doesn't fully cover the last sector
>    * uses luks encryption
>=20
> In this case, when allocating the new clusters we COW both areas
> prior to the write and after the write, and we encrypt them.
>=20
> The above mentioned commit accidentally made it so we encrypt the
> second COW area using the physical cluster offset of the first area.
>=20
> The problem is that offset_in_cluster in do_perform_cow_encrypt
> can be larger that the cluster size, thus cluster_offset
> will no longer point to the start of the cluster at which encrypted
> area starts.
>=20
> Next patch in this series will refactor the code to avoid all these
> assumptions.
>=20
> In the bugreport that was triggered by rebasing a luks image to new,
> zero filled base, which lot of such writes, and causes some files
> with zero areas to contain garbage there instead.
> But as described above it can happen elsewhere as well
>=20
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-cluster.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--1fiOmnlFOfQRCnLjp07dTSzlfCyh15W8o--

--caOjIlolDftIqjlzmFnjbKHOvlG3cFyYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1/gywACgkQ9AfbAGHV
z0B2rwgAn89m/lVSzkV/b2ei2YV8qeLuDCpzubmVYtlGuDivIcWPuOH8M/9FjsY2
QGPSaQqt4JCuHBOA3zrtd3ujes1gX8Qv87OJUKrL1WTkOWuT/zpTga5RuwoGBn4I
fpVSfmOPKkfvBFpYGy93TJkPzno66JRZyUkgiA2JR1T8V3rbA8IoSNlNMt4YsUsG
wh4pRYez+4rRrfwfb2ZuS+p2kf1sNuHw2F/1I2HUMFUjqyac5M3H59S+zgl2ytuR
o6v0yN+GptYfuOFmyi9cUqK2qOfHsnBJhyn7q/+O/oyS72HV1pLVgif5yley9YK+
QJN+F66kZ/CPRm08BsyxgxdaEz7RDg==
=eBVf
-----END PGP SIGNATURE-----

--caOjIlolDftIqjlzmFnjbKHOvlG3cFyYj--

