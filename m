Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9696FC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C21E20863
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C21E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Kbp-0007Cy-IM
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7Kak-000687-FT
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7Kaj-0004WF-6T
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:24:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7Kaf-0004Tu-Oy; Mon, 09 Sep 2019 10:24:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA1B330A00B3;
 Mon,  9 Sep 2019 14:24:24 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5973C5D6B2;
 Mon,  9 Sep 2019 14:24:13 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
 <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
 <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>
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
Message-ID: <e94365cd-3bdf-4055-10de-abad4f65225b@redhat.com>
Date: Mon, 9 Sep 2019 16:24:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PpQ8lrhiP0Ub6mp4dkSQprxrURUlmhpY5"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 09 Sep 2019 14:24:25 +0000 (UTC)
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
--PpQ8lrhiP0Ub6mp4dkSQprxrURUlmhpY5
Content-Type: multipart/mixed; boundary="mQqCekO19cNomeeBdwiwfsHoWXPYm7k3I";
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
Message-ID: <e94365cd-3bdf-4055-10de-abad4f65225b@redhat.com>
Subject: Re: [PATCH v10 04/14] block/backup: introduce BlockCopyState
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
 <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
 <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>
In-Reply-To: <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>

--mQqCekO19cNomeeBdwiwfsHoWXPYm7k3I
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 16:12, Vladimir Sementsov-Ogievskiy wrote:
> 09.09.2019 15:59, Max Reitz wrote:
>> On 30.08.19 18:12, Vladimir Sementsov-Ogievskiy wrote:
>>> Split copying code part from backup to "block-copy", including separa=
te
>>> state structure and function renaming. This is needed to share it wit=
h
>>> backup-top filter driver in further commits.
>>>
>>> Notes:
>>>
>>> 1. As BlockCopyState keeps own BlockBackend objects, remaining
>>> job->common.blk users only use it to get bs by blk_bs() call, so clea=
r
>>> job->commen.blk permissions set in block_job_create and add
>>> job->source_bs to be used instead of blk_bs(job->common.blk), to keep=

>>> it more clear which bs we use when introduce backup-top filter in
>>> further commit.
>>>
>>> 2. Rename s/initializing_bitmap/skip_unallocated/ to sound a bit bett=
er
>>> as interface to BlockCopyState
>>>
>>> 3. Split is not very clean: there left some duplicated fields, backup=

>>> code uses some BlockCopyState fields directly, let's postpone it for
>>> further improvements and keep this comment simpler for review.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/backup.c     | 357 ++++++++++++++++++++++++++++--------------=
---
>>>   block/trace-events |  12 +-
>>>   2 files changed, 231 insertions(+), 138 deletions(-)
>>>
>>> diff --git a/block/backup.c b/block/backup.c
>>> index abb5099fa3..002dee4d7f 100644
>>> --- a/block/backup.c
>>> +++ b/block/backup.c
>>> @@ -35,12 +35,43 @@ typedef struct CowRequest {
>>>       CoQueue wait_queue; /* coroutines blocked on this request */
>>>   } CowRequest;
>>>  =20
>>> +typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaqu=
e);
>>> +typedef void (*ProgressResetCallbackFunc)(void *opaque);
>>> +typedef struct BlockCopyState {
>>> +    BlockBackend *source;
>>> +    BlockBackend *target;
>>> +    BdrvDirtyBitmap *copy_bitmap;
>>> +    int64_t cluster_size;
>>> +    bool use_copy_range;
>>> +    int64_t copy_range_size;
>>> +    uint64_t len;
>>> +
>>> +    BdrvRequestFlags write_flags;
>>> +
>>> +    /*
>>> +     * skip_unallocated: if true, on copy operation firstly reset ar=
eas
>>> +     * unallocated in top layer of source (and then of course don't =
copy
>>> +     * corresponding clusters). If some bytes reset, call
>>> +     * progress_reset_callback.
>>> +     */
>>
>> It isn=E2=80=99t quite clear that this refers to the copy_bitmap.  May=
be
>> something like
>>
>> =E2=80=9CIf true, the copy operation prepares a sync=3Dtop job: It sca=
ns the
>=20
> hmm, now it's not refactored to scan it before copying loop, so it's no=
t precise
> wording..
>=20
>> source's top layer to find all unallocated areas and resets them in th=
e
>=20
> Not all, but mostly inside block-copy requested area (but may be more)

Sorry, I meant backup operation.

>> copy_bitmap (so they will not be copied).  Whenever any such area is
>> cleared, progress_reset_callback will be invoked.
>> Once the whole top layer has been scanned, skip_unallocated is cleared=

>> and the actual copying begins.=E2=80=9D
>=20
> Last sentence sounds like it's a block-copy who will clear skip_unalloc=
ated,
> but it's not so. It's not very good design and may be refactored in fut=
ure,
> but for now, I'd better drop last sentence.

But wasn=E2=80=99t that the point of this variable?  That it goes back to=
 false
once the bitmap is fully initialized?

>>
>> instead?
>=20
> Or, what about the following mix:
>=20
> Used for job sync=3Dtop mode. If true, block_copy() will reset in copy_=
bitmap areas
> unallocated in top image (so they will not be copied). Whenever any suc=
h area is cleared,
> progress_reset_callback will be invoked. User is assumed to call in bac=
kground
> block_copy_reset_unallocated() several times to cover the whole copied =
disk and
> then clear skip_unallocated, to prevent extra effort.

I don=E2=80=99t know.  The point of this variable is the initialization o=
f the
bitmap.  block-copy only uses this as a hint that it needs to
participate in that initialization process, too, and cannot assume the
bitmap to be fully allocated.

Furthermore, it sounds a bit strange to imply that there=E2=80=99d be a s=
trict
separation between block-copy and its user.  They work tightly together
on this.  I don=E2=80=99t think it would hurt to be more concrete on what=
 the
backup job does here instead of just alluding to it as being =E2=80=9Cthe=
 user=E2=80=9D.

[...]

>>> @@ -415,16 +535,16 @@ static void backup_abort(Job *job)
>>>   static void backup_clean(Job *job)
>>>   {
>>>       BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.=
job);
>>> -    BlockDriverState *bs =3D blk_bs(s->common.blk);
>>> +    BlockCopyState *bcs =3D s->bcs;
>>>  =20
>>> -    if (s->copy_bitmap) {
>>> -        bdrv_release_dirty_bitmap(bs, s->copy_bitmap);
>>> -        s->copy_bitmap =3D NULL;
>>> -    }
>>> +    /*
>>> +     * Zero pointer first, to not interleave with backup_drain durin=
g some
>>> +     * yield. TODO: just block_copy_state_free(s->bcs) after backup_=
drain
>>> +     * dropped.
>>> +     */
>>
>> I suppose that=E2=80=98s now. :-)
>=20
> Hmm, it's in Kevin's branch. Should I rebase on it?

Yep, that=E2=80=99s what I meant.

Max


--mQqCekO19cNomeeBdwiwfsHoWXPYm7k3I--

--PpQ8lrhiP0Ub6mp4dkSQprxrURUlmhpY5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12YIoACgkQ9AfbAGHV
z0CJfAf8CWjzUt0pW1onNNRg1Of5nbAa2bhLW3oeScfQYGYRHICjQWR9BEVkSCJS
iZvLttfg7Z99Q7TIUNulUQ5/oqI+AK4yVi1q68rLqXbh4PqOSCyq+ricHkjoh5R4
kW00VRKTsAoqYBD6kovkKill93jU1N/xEMMjAc96ELcjn9jUjPdE0umIA3yngT3/
miaLJGGL/znMvsqfe1ABVaCmf+8ZX5q7S4xayG7rlLQnB1Fv6k6M3qy0eyykN/Q9
UOfIWtm289SlAsLpoucKu+e69DgOe43gt1081EdwsUh9Pyo7CZanI0s2YvHZXHNi
gj8bipJXd0O7rHvTJ3iTBSK6KoalkA==
=WRUc
-----END PGP SIGNATURE-----

--PpQ8lrhiP0Ub6mp4dkSQprxrURUlmhpY5--

