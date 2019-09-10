Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AAEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC632081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC632081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dBv-0002bL-QC
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7dAl-0001jb-NG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7dAk-0005Ij-MX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:14:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57890)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7dAf-0005Em-Vj; Tue, 10 Sep 2019 06:14:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6547A300BCE9;
 Tue, 10 Sep 2019 10:14:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E07E6012D;
 Tue, 10 Sep 2019 10:14:32 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
 <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
 <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>
 <e94365cd-3bdf-4055-10de-abad4f65225b@redhat.com>
 <d4b6869a-a711-f911-2b29-c7062aa44aa6@virtuozzo.com>
 <80720d39-b9d6-d693-0f6a-0a078d6056e0@redhat.com>
 <577ab66d-ea14-a363-0b8a-92932198c284@virtuozzo.com>
 <310835ca-4aa9-0c4f-5d18-1a89e2e0be74@redhat.com>
 <c6859d2b-e530-8e5a-375d-87954c974e0d@virtuozzo.com>
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
Message-ID: <079112b9-7a54-1c10-6f89-145d866115f2@redhat.com>
Date: Tue, 10 Sep 2019 12:14:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c6859d2b-e530-8e5a-375d-87954c974e0d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="O0Sz8lfYHJOs2dTjmizr5PJmIxdipLmbA"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 10 Sep 2019 10:14:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v10 04/14] block/backup: introduce
 BlockCopyState
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O0Sz8lfYHJOs2dTjmizr5PJmIxdipLmbA
Content-Type: multipart/mixed; boundary="YK6N2L8jKNq9AhkwQWlfeSIPAsP4egR0w";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <079112b9-7a54-1c10-6f89-145d866115f2@redhat.com>
Subject: Re: [PATCH v10 04/14] block/backup: introduce BlockCopyState
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
 <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
 <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>
 <e94365cd-3bdf-4055-10de-abad4f65225b@redhat.com>
 <d4b6869a-a711-f911-2b29-c7062aa44aa6@virtuozzo.com>
 <80720d39-b9d6-d693-0f6a-0a078d6056e0@redhat.com>
 <577ab66d-ea14-a363-0b8a-92932198c284@virtuozzo.com>
 <310835ca-4aa9-0c4f-5d18-1a89e2e0be74@redhat.com>
 <c6859d2b-e530-8e5a-375d-87954c974e0d@virtuozzo.com>
In-Reply-To: <c6859d2b-e530-8e5a-375d-87954c974e0d@virtuozzo.com>

--YK6N2L8jKNq9AhkwQWlfeSIPAsP4egR0w
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 11:22, Vladimir Sementsov-Ogievskiy wrote:

[...]

> Ok, than
>=20
> 4. Postpone improvements for a follow-up (anyway, finally, block-copy s=
hould
> use block_status to copy by larger chunks, like mirror does), and impro=
ve the
> comment like this:
>=20
> """
> Used for job sync=3Dtop mode, which currently works as follows (the siz=
e of the
> comment definitely shows unclean design, but this is a TODO to improve =
it):
> If job started in sync=3Dtop mode, which means that we want to copy onl=
y parts
> allocated in top layer, job should behave like this:
>=20
> 1. Create block-copy state with skip_unallocated =3D true.
> 2. Then, block_copy() will automatically check for allocation in top la=
yer,
> and do not copy areas which are not allocated in top layer. So, for exa=
mple,
> copy-before-write operations in backup works correctly even before [3.]=

> 3. Sequentially call block_copy_reset_unallocated() to cover the whole =
source
> node, copy_bitmap will be updated correspondingly.
> 4. Unset skip_unallocated variable in block-copy state, to avoid extra =
(as
> everything is covered by [3.]) block-status queries in block_copy() cal=
ls
> 5. Do sequential copying by loop of block_copy() calls, all needed allo=
cation
> information is already in copy_bitmap.
>=20
>  From block_copy() side, it behaves like this:
> If skip_unallocated is set, block_copy() will reset in copy_bitmap area=
s
> unallocated in top image (so they will not be copied). Whenever any suc=
h
> area is cleared, progress_reset_callback will be invoked. Note, that
> progress_reset_callback is called from block_copy_reset_unallocated() t=
oo.
> """

Can this not be simplified?

"""
Used by sync=3Dtop jobs, which first scan the source node for unallocated=

areas and clear them in the copy_bitmap.  During this process, the
bitmap is thus not fully initialized: It may still have bits set for
areas that are unallocated and should actually not be copied.

This is indicated by skip_unallocated.

In this case, block_copy() will query the source=E2=80=99s allocation sta=
tus,
skip unallocated regions, clear them in the copy_bitmap, and invoke
block_copy_reset_unallocated() every time it does.

Otherwise, block_copy() copies everything that=E2=80=99s dirty in the cop=
y_bitmap.
"""

Max


--YK6N2L8jKNq9AhkwQWlfeSIPAsP4egR0w--

--O0Sz8lfYHJOs2dTjmizr5PJmIxdipLmbA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13d4YACgkQ9AfbAGHV
z0Autwf/WOo1WyxhxN5W/cvHcGlcPDK8dh/66ZPDpHY61NZlxMEpw3c+Ei/pnc0s
kqNNaTVibjpX4qOe4/L0Emn8EuGpXE1d1oRtK9fGZdYOm1EkfUIdPo+EE/4ytLHm
xCUk3KFF4u89JXJ6+xZoDEkr6BN4TN703fuc7tkj/4yM7jFf7dicurIjzzYu41qs
xFt2i4UnlBdh99qBS0+jMAWvn4wGR5jY634wAz2hJWk6cWSCVX6fKCu7p3cFJ9n0
DWBmus4qGjk5HanZ0ZX/7bV92XHDAUgE99H4iEevXT9Pi2fOJjVSVGgRKghN00OR
Np22QORjqeVcFBeQmvC7QMXLGzcflA==
=wn0M
-----END PGP SIGNATURE-----

--O0Sz8lfYHJOs2dTjmizr5PJmIxdipLmbA--

