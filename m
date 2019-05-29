Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82246C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451E420B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451E420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52025 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVwhU-0005L2-HS
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:24:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVwge-0004zd-NC
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVwgd-0005D6-JV
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVwgZ-0004vn-7v; Wed, 29 May 2019 07:23:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49752307D96F;
	Wed, 29 May 2019 11:23:53 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D87995B0A0;
	Wed, 29 May 2019 11:23:42 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190506153429.52737-1-vsementsov@virtuozzo.com>
	<20190506153429.52737-4-vsementsov@virtuozzo.com>
	<ee950bac-f0d8-3bc9-f5ed-deaf4d36777b@redhat.com>
	<5a18f815-ed81-fd58-5f48-9ffe944f0ea4@virtuozzo.com>
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
Message-ID: <3f1e1a61-41ba-cbd9-4dce-8516227336d5@redhat.com>
Date: Wed, 29 May 2019 13:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5a18f815-ed81-fd58-5f48-9ffe944f0ea4@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lKz1hIAgBBTKcepYsGQPjEKA0TFNP3iMr"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 29 May 2019 11:23:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v6 3/3] block/stream: introduce a bottom
 node
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"wencongyang2@huawei.com" <wencongyang2@huawei.com>,
	"xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lKz1hIAgBBTKcepYsGQPjEKA0TFNP3iMr
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>
Message-ID: <3f1e1a61-41ba-cbd9-4dce-8516227336d5@redhat.com>
Subject: Re: [PATCH v6 3/3] block/stream: introduce a bottom node
References: <20190506153429.52737-1-vsementsov@virtuozzo.com>
 <20190506153429.52737-4-vsementsov@virtuozzo.com>
 <ee950bac-f0d8-3bc9-f5ed-deaf4d36777b@redhat.com>
 <5a18f815-ed81-fd58-5f48-9ffe944f0ea4@virtuozzo.com>
In-Reply-To: <5a18f815-ed81-fd58-5f48-9ffe944f0ea4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.05.19 09:34, Vladimir Sementsov-Ogievskiy wrote:
> 28.05.2019 20:33, Max Reitz wrote:
>> On 06.05.19 17:34, Vladimir Sementsov-Ogievskiy wrote:
>>> From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>
>>> The bottom node is the intermediate block device that has the base as=
 its
>>> backing image. It is used instead of the base node while a block stre=
am
>>> job is running to avoid dependency on the base that may change due to=
 the
>>> parallel jobs. The change may take place due to a filter node as well=
 that
>>> is inserted between the base and the intermediate bottom node. It occ=
urs
>>> when the base node is the top one for another commit or stream job.
>>> After the introduction of the bottom node, don't freeze its backing c=
hild,
>>> that's the base, anymore.
>>>
>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>> ---
>>>   block/stream.c         | 49 +++++++++++++++++++++------------------=
---
>>>   tests/qemu-iotests/245 |  4 ++--
>>>   2 files changed, 27 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/block/stream.c b/block/stream.c
>>> index 65b13b27e0..fc97c89f81 100644
>>> --- a/block/stream.c
>>> +++ b/block/stream.c
>>
>> [...]
>>
>>> @@ -248,26 +250,25 @@ void stream_start(const char *job_id, BlockDriv=
erState *bs,
>>>        * already have our own plans. Also don't allow resize as the i=
mage size is
>>>        * queried only at the job start and then cached. */
>>>       s =3D block_job_create(job_id, &stream_job_driver, NULL, bs,
>>> -                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_U=
NCHANGED |
>>> -                         BLK_PERM_GRAPH_MOD,
>>> -                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_U=
NCHANGED |
>>> -                         BLK_PERM_WRITE,
>>> +                         basic_flags | BLK_PERM_GRAPH_MOD,
>>> +                         basic_flags | BLK_PERM_WRITE,
>>>                            speed, creation_flags, NULL, NULL, errp);
>>>       if (!s) {
>>>           goto fail;
>>>       }
>>>  =20
>>> -    /* Block all intermediate nodes between bs and base, because the=
y will
>>> -     * disappear from the chain after this operation. The streaming =
job reads
>>> -     * every block only once, assuming that it doesn't change, so bl=
ock writes
>>> -     * and resizes. */
>>> -    for (iter =3D backing_bs(bs); iter && iter !=3D base; iter =3D b=
acking_bs(iter)) {
>>> -        block_job_add_bdrv(&s->common, "intermediate node", iter, 0,=

>>> -                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE=
_UNCHANGED,
>>> -                           &error_abort);
>>> +    /*
>>> +     * Block all intermediate nodes between bs and bottom (inclusive=
), because
>>> +     * they will disappear from the chain after this operation. The =
streaming
>>> +     * job reads every block only once, assuming that it doesn't cha=
nge, so
>>> +     * forbid writes and resizes.
>>> +     */
>>> +    for (iter =3D bs; iter !=3D bottom; iter =3D backing_bs(iter)) {=

>>> +        block_job_add_bdrv(&s->common, "intermediate node", backing_=
bs(iter),
>>> +                           0, basic_flags, &error_abort);
>>
>> I don=E2=80=99t understand this change.  Isn=E2=80=99t it doing exactl=
y the same as before?
>>
>> (If so, I just find it harder to read because every iteration isn=E2=80=
=99t
>> about @iter but backing_bs(iter).)
>=20
> Hm, it's the same, but not using base. We may save old loop if calculat=
e base exactly before
> the loop (or at least not separated from it by any yield-point)

But we are still in stream_start() here.  base cannot have changed yet,
can it?

(I don=E2=80=99t even think this is about yield points.  As long as
stream_start() doesn=E2=80=99t return, the QMP monitor won=E2=80=99t rece=
ive any new
commands.)

Max


--lKz1hIAgBBTKcepYsGQPjEKA0TFNP3iMr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzua7wACgkQ9AfbAGHV
z0DHcwgAj7vJqm7S5OzSLH5oQcepRqhqZr2KgnbyIt0zvaCLoL6VKm3n583Xl3V/
IEMn1+78/YeRTNNgP01RViV5otkjtmmJPBNxyVjUy5iP6PlhFe5M5kxJ/h06cLHV
FOX6FhTeR72tSLGgTpTBH8ANOILe+qtZ2ceVE1iPPbNnqipHxxPl540B6KZa9Io8
KVEjA2Km4cARvNG1y4jQ8/Lo5Gt4bzluhe4OCnKQnrMvt6UWk0CcrEZX1Bx5Pe90
G2n5KQPJGug7BXnEhzOlzg2wmo05282j4HZ3/ykj06Xo+t+iKzoo3DlRzuQUFCNA
12rJHN0QzEuY/r9okUI1SRbtRFgWpw==
=875s
-----END PGP SIGNATURE-----

--lKz1hIAgBBTKcepYsGQPjEKA0TFNP3iMr--

