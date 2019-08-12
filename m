Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6556C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C24520665
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C24520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCvf-0004W5-PA
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51766)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxCvE-00043N-Ti
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxCvD-000440-JP
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:11:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxCvA-00042w-EE; Mon, 12 Aug 2019 12:11:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D33230A5A62;
 Mon, 12 Aug 2019 16:11:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C41480899;
 Mon, 12 Aug 2019 16:11:36 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
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
Message-ID: <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
Date: Mon, 12 Aug 2019 18:11:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SIMMyA7LWkEoF5TCepp76voCl0cj7Hc98"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 12 Aug 2019 16:11:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SIMMyA7LWkEoF5TCepp76voCl0cj7Hc98
Content-Type: multipart/mixed; boundary="G77LnfKG7Ao5ydjR80gJvfBuRIClNTaoV";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
Subject: Re: [PATCH v3 6/7] block/backup: teach backup_cow_with_bounce_buffer
 to copy more at once
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
In-Reply-To: <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>

--G77LnfKG7Ao5ydjR80gJvfBuRIClNTaoV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 17:47, Vladimir Sementsov-Ogievskiy wrote:
> 12.08.2019 18:10, Max Reitz wrote:
>> On 10.08.19 21:31, Vladimir Sementsov-Ogievskiy wrote:
>>> backup_cow_with_offload can transfer more than one cluster. Let
>>> backup_cow_with_bounce_buffer behave similarly. It reduces the number=

>>> of IO requests, since there is no need to copy cluster by cluster.
>>>
>>> Logic around bounce_buffer allocation changed: we can't just allocate=

>>> one-cluster-sized buffer to share for all iterations. We can't also
>>> allocate buffer of full-request length it may be too large, so
>>> BACKUP_MAX_BOUNCE_BUFFER is introduced. And finally, allocation logic=

>>> is to allocate a buffer sufficient to handle all remaining iterations=

>>> at the point where we need the buffer for the first time.
>>>
>>> Bonus: get rid of pointer-to-pointer.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/backup.c | 65 +++++++++++++++++++++++++++++++----------------=
---
>>>   1 file changed, 41 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/block/backup.c b/block/backup.c
>>> index d482d93458..65f7212c85 100644
>>> --- a/block/backup.c
>>> +++ b/block/backup.c
>>> @@ -27,6 +27,7 @@
>>>   #include "qemu/error-report.h"
>>>  =20
>>>   #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
>>> +#define BACKUP_MAX_BOUNCE_BUFFER (64 * 1024 * 1024)
>>>  =20
>>>   typedef struct CowRequest {
>>>       int64_t start_byte;
>>> @@ -98,44 +99,55 @@ static void cow_request_end(CowRequest *req)
>>>       qemu_co_queue_restart_all(&req->wait_queue);
>>>   }
>>>  =20
>>> -/* Copy range to target with a bounce buffer and return the bytes co=
pied. If
>>> - * error occurred, return a negative error number */
>>> +/*
>>> + * Copy range to target with a bounce buffer and return the bytes co=
pied. If
>>> + * error occurred, return a negative error number
>>> + *
>>> + * @bounce_buffer is assumed to enough to store
>>
>> s/to/to be/
>>
>>> + * MIN(BACKUP_MAX_BOUNCE_BUFFER, @end - @start) bytes
>>> + */
>>>   static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJo=
b *job,
>>>                                                         int64_t start=
,
>>>                                                         int64_t end,
>>>                                                         bool is_write=
_notifier,
>>>                                                         bool *error_i=
s_read,
>>> -                                                      void **bounce_=
buffer)
>>> +                                                      void *bounce_b=
uffer)
>>>   {
>>>       int ret;
>>>       BlockBackend *blk =3D job->common.blk;
>>> -    int nbytes;
>>> +    int nbytes, remaining_bytes;
>>>       int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING =
: 0;
>>>  =20
>>>       assert(QEMU_IS_ALIGNED(start, job->cluster_size));
>>> -    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_si=
ze);
>>> -    nbytes =3D MIN(job->cluster_size, job->len - start);
>>> -    if (!*bounce_buffer) {
>>> -        *bounce_buffer =3D blk_blockalign(blk, job->cluster_size);
>>> -    }
>>> +    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, end - start);
>>> +    nbytes =3D MIN(end - start, job->len - start);
>>>  =20
>>> -    ret =3D blk_co_pread(blk, start, nbytes, *bounce_buffer, read_fl=
ags);
>>> -    if (ret < 0) {
>>> -        trace_backup_do_cow_read_fail(job, start, ret);
>>> -        if (error_is_read) {
>>> -            *error_is_read =3D true;
>>> +
>>> +    remaining_bytes =3D nbytes;
>>> +    while (remaining_bytes) {
>>> +        int chunk =3D MIN(BACKUP_MAX_BOUNCE_BUFFER, remaining_bytes)=
;
>>> +
>>> +        ret =3D blk_co_pread(blk, start, chunk, bounce_buffer, read_=
flags);
>>> +        if (ret < 0) {
>>> +            trace_backup_do_cow_read_fail(job, start, ret);
>>> +            if (error_is_read) {
>>> +                *error_is_read =3D true;
>>> +            }
>>> +            goto fail;
>>>           }
>>> -        goto fail;
>>> -    }
>>>  =20
>>> -    ret =3D blk_co_pwrite(job->target, start, nbytes, *bounce_buffer=
,
>>> -                        job->write_flags);
>>> -    if (ret < 0) {
>>> -        trace_backup_do_cow_write_fail(job, start, ret);
>>> -        if (error_is_read) {
>>> -            *error_is_read =3D false;
>>> +        ret =3D blk_co_pwrite(job->target, start, chunk, bounce_buff=
er,
>>> +                            job->write_flags);
>>> +        if (ret < 0) {
>>> +            trace_backup_do_cow_write_fail(job, start, ret);
>>> +            if (error_is_read) {
>>> +                *error_is_read =3D false;
>>> +            }
>>> +            goto fail;
>>>           }
>>> -        goto fail;
>>> +
>>> +        start +=3D chunk;
>>> +        remaining_bytes -=3D chunk;
>>>       }
>>>  =20
>>>       return nbytes;
>>> @@ -301,9 +313,14 @@ static int coroutine_fn backup_do_cow(BackupBloc=
kJob *job,
>>>               }
>>>           }
>>>           if (!job->use_copy_range) {
>>> +            if (!bounce_buffer) {
>>> +                size_t len =3D MIN(BACKUP_MAX_BOUNCE_BUFFER,
>>> +                                 MAX(dirty_end - start, end - dirty_=
end));
>>> +                bounce_buffer =3D blk_try_blockalign(job->common.blk=
, len);
>>> +            }
>>
>> If you use _try_, you should probably also check whether it succeeded.=

>=20
> Oops, you are right, of course.
>=20
>>
>> Anyway, I wonder whether it=E2=80=99d be better to just allocate this =
buffer
>> once per job (the first time we get here, probably) to be of size
>> BACKUP_MAX_BOUNCE_BUFFER and put it into BackupBlockJob.  (And maybe a=
dd
>> a buf-size parameter similar to what the mirror jobs have.)
>>
>=20
> Once per job will not work, as we may have several guest writes in para=
llel and therefore
> several parallel copy-before-write operations.

Hm.  I=E2=80=99m not quite happy with that because if the guest just issu=
es many
large discards in parallel, this means that qemu will allocate a large
amount of memory.

It would be nice if there was a simple way to keep track of the total
memory usage and let requests yield if they would exceed it.

> Or if you mean writing an allocator based
> on once-allocated buffer like in mirror, I really dislike this idea, as=
 we already have
> allocator: memalign/malloc/free and it works well, no reason to invent =
a new one and
> hardcode it into block layer (look at my answer to Eric on v2 of this p=
atch for more info).

Well, at least it=E2=80=99d be something we can delay until blockdev-copy=

arrives(TM).

Max

> Or, if you mean only backup_loop generated copy-requests, yes we may ke=
ep only one buffer for them,
> but:
> 1. it is not how it works now, so my patch is not a degradation in this=
 case
> 2. I'm going to parallelize backup loop too, like my series "qcow2: asy=
nc handling of fragmented io",
>     which will need several allocated buffers anyway.
>=20
>>
>>>               ret =3D backup_cow_with_bounce_buffer(job, start, dirty=
_end,
>>>                                                   is_write_notifier,
>>> -                                                error_is_read, &boun=
ce_buffer);
>>> +                                                error_is_read, bounc=
e_buffer);
>>>           }
>>>           if (ret < 0) {
>>>               break;
>>>
>>
>>
>=20
>=20



--G77LnfKG7Ao5ydjR80gJvfBuRIClNTaoV--

--SIMMyA7LWkEoF5TCepp76voCl0cj7Hc98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1Rj7YACgkQ9AfbAGHV
z0BuEwf/Z9GdOulZRNZnS7OY21oaLn3L5d2zcLV+3hbfvxTt33NcJONp+v+/atlZ
/Ig99ZvXenzb2rmK4285SxMF9A3QjeDuIHq+/aKjKzP86y3Hd1dbGdjHvA//5Rka
MvcuSuhlE7uLqhlojvUKu6IfMavTHnP0Rl8CPSP8ZTtVlkzm+0k15fbyZmzXJIde
4au6SkSg4Z0Ji4Akk5aeNfIMR1p/I0fX/reMhWxg8tkhclpa5fv7lbWsgjJ+8n2m
pi8V7c038ej4H8HqCJ+pBc09UkEZ1WyIwDOkdmY5tuwLFs3m7Wct8MjawqDDgXDu
rISrE8e1sWMUg1ssqV4MZVxhfoKl5A==
=fA6F
-----END PGP SIGNATURE-----

--SIMMyA7LWkEoF5TCepp76voCl0cj7Hc98--

