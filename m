Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654A7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC6520872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC6520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bjO-00021z-Cr
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7bgW-0006x8-6d
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7bgU-0004V5-Oz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7bgP-0004SV-3P; Tue, 10 Sep 2019 04:39:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C79A62119;
 Tue, 10 Sep 2019 08:39:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A88A21001959;
 Tue, 10 Sep 2019 08:39:17 +0000 (UTC)
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
Message-ID: <310835ca-4aa9-0c4f-5d18-1a89e2e0be74@redhat.com>
Date: Tue, 10 Sep 2019 10:39:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <577ab66d-ea14-a363-0b8a-92932198c284@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1PxnIJ7Q3kXzULtAFoQj2lgqD4v1xb2ds"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 10 Sep 2019 08:39:27 +0000 (UTC)
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
--1PxnIJ7Q3kXzULtAFoQj2lgqD4v1xb2ds
Content-Type: multipart/mixed; boundary="SBtd1bwE7JO5DXCLb8G3JeuHejGDrutEz";
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
Message-ID: <310835ca-4aa9-0c4f-5d18-1a89e2e0be74@redhat.com>
Subject: Re: [PATCH v10 04/14] block/backup: introduce BlockCopyState
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
 <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
 <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>
 <e94365cd-3bdf-4055-10de-abad4f65225b@redhat.com>
 <d4b6869a-a711-f911-2b29-c7062aa44aa6@virtuozzo.com>
 <80720d39-b9d6-d693-0f6a-0a078d6056e0@redhat.com>
 <577ab66d-ea14-a363-0b8a-92932198c284@virtuozzo.com>
In-Reply-To: <577ab66d-ea14-a363-0b8a-92932198c284@virtuozzo.com>

--SBtd1bwE7JO5DXCLb8G3JeuHejGDrutEz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 10:12, Vladimir Sementsov-Ogievskiy wrote:
> 10.09.2019 10:42, Max Reitz wrote:
>> On 09.09.19 17:11, Vladimir Sementsov-Ogievskiy wrote:
>>> 09.09.2019 17:24, Max Reitz wrote:
>>>> On 09.09.19 16:12, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 09.09.2019 15:59, Max Reitz wrote:
>>>>>> On 30.08.19 18:12, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> Split copying code part from backup to "block-copy", including se=
parate
>>>>>>> state structure and function renaming. This is needed to share it=
 with
>>>>>>> backup-top filter driver in further commits.
>>>>>>>
>>>>>>> Notes:
>>>>>>>
>>>>>>> 1. As BlockCopyState keeps own BlockBackend objects, remaining
>>>>>>> job->common.blk users only use it to get bs by blk_bs() call, so =
clear
>>>>>>> job->commen.blk permissions set in block_job_create and add
>>>>>>> job->source_bs to be used instead of blk_bs(job->common.blk), to =
keep
>>>>>>> it more clear which bs we use when introduce backup-top filter in=

>>>>>>> further commit.
>>>>>>>
>>>>>>> 2. Rename s/initializing_bitmap/skip_unallocated/ to sound a bit =
better
>>>>>>> as interface to BlockCopyState
>>>>>>>
>>>>>>> 3. Split is not very clean: there left some duplicated fields, ba=
ckup
>>>>>>> code uses some BlockCopyState fields directly, let's postpone it =
for
>>>>>>> further improvements and keep this comment simpler for review.
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo=
=2Ecom>
>>>>>>> ---
>>>>>>>     block/backup.c     | 357 ++++++++++++++++++++++++++++--------=
---------
>>>>>>>     block/trace-events |  12 +-
>>>>>>>     2 files changed, 231 insertions(+), 138 deletions(-)
>>>>>>>
>>>>>>> diff --git a/block/backup.c b/block/backup.c
>>>>>>> index abb5099fa3..002dee4d7f 100644
>>>>>>> --- a/block/backup.c
>>>>>>> +++ b/block/backup.c
>>>>>>> @@ -35,12 +35,43 @@ typedef struct CowRequest {
>>>>>>>         CoQueue wait_queue; /* coroutines blocked on this request=
 */
>>>>>>>     } CowRequest;
>>>>>>>    =20
>>>>>>> +typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *o=
paque);
>>>>>>> +typedef void (*ProgressResetCallbackFunc)(void *opaque);
>>>>>>> +typedef struct BlockCopyState {
>>>>>>> +    BlockBackend *source;
>>>>>>> +    BlockBackend *target;
>>>>>>> +    BdrvDirtyBitmap *copy_bitmap;
>>>>>>> +    int64_t cluster_size;
>>>>>>> +    bool use_copy_range;
>>>>>>> +    int64_t copy_range_size;
>>>>>>> +    uint64_t len;
>>>>>>> +
>>>>>>> +    BdrvRequestFlags write_flags;
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * skip_unallocated: if true, on copy operation firstly rese=
t areas
>>>>>>> +     * unallocated in top layer of source (and then of course do=
n't copy
>>>>>>> +     * corresponding clusters). If some bytes reset, call
>>>>>>> +     * progress_reset_callback.
>>>>>>> +     */
>>>>>>
>>>>>> It isn=E2=80=99t quite clear that this refers to the copy_bitmap. =
 Maybe
>>>>>> something like
>>>>>>
>>>>>> =E2=80=9CIf true, the copy operation prepares a sync=3Dtop job: It=
 scans the
>>>>>
>>>>> hmm, now it's not refactored to scan it before copying loop, so it'=
s not precise
>>>>> wording..
>>>>>
>>>>>> source's top layer to find all unallocated areas and resets them i=
n the
>>>>>
>>>>> Not all, but mostly inside block-copy requested area (but may be mo=
re)
>>>>
>>>> Sorry, I meant backup operation.
>>>>
>>>>>> copy_bitmap (so they will not be copied).  Whenever any such area =
is
>>>>>> cleared, progress_reset_callback will be invoked.
>>>>>> Once the whole top layer has been scanned, skip_unallocated is cle=
ared
>>>>>> and the actual copying begins.=E2=80=9D
>>>>>
>>>>> Last sentence sounds like it's a block-copy who will clear skip_una=
llocated,
>>>>> but it's not so. It's not very good design and may be refactored in=
 future,
>>>>> but for now, I'd better drop last sentence.
>>>>
>>>> But wasn=E2=80=99t that the point of this variable?  That it goes ba=
ck to false
>>>> once the bitmap is fully initialized?
>>>
>>> I just want to stress, that block-copy itself (which will be in a sep=
arate file,
>>> so it would be clean enough, what is block-copy and what is its user)=
 do not clear
>>> this variable. It of course may track calls to  block_copy_reset_unal=
located() and
>>> clear this variable automatically, but it don't do it now. And your w=
ording looks
>>> for me like block-copy code may automatically clear this variable
>>
>> Hm, OK.
>>
>>>>
>>>>>>
>>>>>> instead?
>>>>>
>>>>> Or, what about the following mix:
>>>>>
>>>>> Used for job sync=3Dtop mode. If true, block_copy() will reset in c=
opy_bitmap areas
>>>>> unallocated in top image (so they will not be copied). Whenever any=
 such area is cleared,
>>>>> progress_reset_callback will be invoked. User is assumed to call in=
 background
>>>>> block_copy_reset_unallocated() several times to cover the whole cop=
ied disk and
>>>>> then clear skip_unallocated, to prevent extra effort.
>>>>
>>>> I don=E2=80=99t know.  The point of this variable is the initializat=
ion of the
>>>> bitmap.  block-copy only uses this as a hint that it needs to
>>>> participate in that initialization process, too, and cannot assume t=
he
>>>> bitmap to be fully allocated.
>>>
>>> Hmm, but where is a conflict of this and my wording? IMHO, I just doc=
umented
>>> exactly what's written in the code.
>>
>> There=E2=80=99s no conflict because it isn=E2=80=99t mentioned; which =
is the problem I
>> have with it.
>>
>> What I was really confused about is who consumes the variable.  It all=

>> becomes much clearer when I take it as a given that all of your
>> description just is an imperative to block-copy.  That simply wasn=E2=80=
=99t
>> clear to me.  (Which is why you don=E2=80=99t like my description, pre=
cisely
>> because it tells the story from another POV, namely that of backup.)
>>
>> Furthermore, I just miss the big picture about it.  Why does the
>> variable even exist?
>=20
> Too keep it simpler for now, we can improve it as a follow-up. I see
> several solutions:
>=20
> 1. track sequential calls to block_copy_reset_unallocated() and when
> it comes to the disk end - clear the variable
>=20
> 2. don't publish block_copy_reset_unallocated() at all, assuming sequen=
tial
> calls to block_copy() and do like in (1.)
>=20
> 3. keep additional bitmap to track, what was already explored about bei=
ng
> allocated/unallocated (seems too much)

Sorry, over some editing I accidentally removed the meaning from what I
wrote there.  I didn=E2=80=99t mean literally =E2=80=9CWhy does the varia=
ble exist=E2=80=9D or
=E2=80=9CI don=E2=80=99t understand the big picture=E2=80=9D.  I meant =E2=
=80=9CThe comment does not
explain the big picture, for example, it does not explain why the
variable even exists.=E2=80=9D

Max


--SBtd1bwE7JO5DXCLb8G3JeuHejGDrutEz--

--1PxnIJ7Q3kXzULtAFoQj2lgqD4v1xb2ds
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13YTMACgkQ9AfbAGHV
z0BwqQf+KRvejjVZpq5aReqeAYQezQvX14deQSRSVNL1xFAmituIk6/hnxfhYfd1
k5LyNkKxQgvkeq3bVIdNgFIMlHhR1Ik4CeMvYVZe5VKEHtn1PM38xtpecM77oTDy
vIBj9gs+CcGwusL1TTR15OaB9eGxfZXw0aZyx7KTfghiKgWD3CvRIpk+Kxx2PDk0
6MCMPopodNv6WO3emN6O84C3NXWoXZqSXYP1rqcaVeKUXKLiDBNTp/iElGBtxze1
+RCxvOfw7ivLIGmgpFKtqR/XQ51hkNdFoGTyPqdXfSc9Ki0aUiiFWHhZB16KErq4
lK/bv1i50ZPDGA803qkN4XLqMBdp8Q==
=ntMD
-----END PGP SIGNATURE-----

--1PxnIJ7Q3kXzULtAFoQj2lgqD4v1xb2ds--

