Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5641C4CECD
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE99620644
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE99620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBIzJ-0007aj-9s
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBIwY-0005b0-Uf
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBIwW-0000M8-T3
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:27:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBIwB-0000At-WE; Fri, 20 Sep 2019 09:27:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5B07B30832EA;
 Fri, 20 Sep 2019 13:27:02 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6E3A60606;
 Fri, 20 Sep 2019 13:26:53 +0000 (UTC)
Subject: Re: [PATCH v11 04/14] block/backup: introduce BlockCopyState
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190910102332.20560-1-vsementsov@virtuozzo.com>
 <20190910102332.20560-5-vsementsov@virtuozzo.com>
 <bafea6c6-38cc-1848-92ea-ec891457515a@virtuozzo.com>
 <bb798ca2-dd22-9ffe-de08-a4d0d8891f30@redhat.com>
 <abf4fdcc-2ca3-7ec5-93ff-95be6b480a5d@virtuozzo.com>
 <fbcb6733-b19f-e275-71cb-466238d8b193@virtuozzo.com>
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
Message-ID: <5d9c1263-c0d7-0f51-424a-25406ed435db@redhat.com>
Date: Fri, 20 Sep 2019 15:26:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fbcb6733-b19f-e275-71cb-466238d8b193@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="juKHbAU4WPTfqDQDrTUFjgTFsbatXolER"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 20 Sep 2019 13:27:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
--juKHbAU4WPTfqDQDrTUFjgTFsbatXolER
Content-Type: multipart/mixed; boundary="nLN1fBGiJ9qmVycQIEKDy7fOwCSHRAWTg";
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
Message-ID: <5d9c1263-c0d7-0f51-424a-25406ed435db@redhat.com>
Subject: Re: [PATCH v11 04/14] block/backup: introduce BlockCopyState
References: <20190910102332.20560-1-vsementsov@virtuozzo.com>
 <20190910102332.20560-5-vsementsov@virtuozzo.com>
 <bafea6c6-38cc-1848-92ea-ec891457515a@virtuozzo.com>
 <bb798ca2-dd22-9ffe-de08-a4d0d8891f30@redhat.com>
 <abf4fdcc-2ca3-7ec5-93ff-95be6b480a5d@virtuozzo.com>
 <fbcb6733-b19f-e275-71cb-466238d8b193@virtuozzo.com>
In-Reply-To: <fbcb6733-b19f-e275-71cb-466238d8b193@virtuozzo.com>

--nLN1fBGiJ9qmVycQIEKDy7fOwCSHRAWTg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.09.19 14:56, Vladimir Sementsov-Ogievskiy wrote:
> 20.09.2019 15:56, Vladimir Sementsov-Ogievskiy wrote:
>> 20.09.2019 15:46, Max Reitz wrote:
>>> On 13.09.19 20:25, Vladimir Sementsov-Ogievskiy wrote:
>>>> 10.09.2019 13:23, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Split copying code part from backup to "block-copy", including sepa=
rate
>>>>> state structure and function renaming. This is needed to share it w=
ith
>>>>> backup-top filter driver in further commits.
>>>>>
>>>>> Notes:
>>>>>
>>>>> 1. As BlockCopyState keeps own BlockBackend objects, remaining
>>>>> job->common.blk users only use it to get bs by blk_bs() call, so cl=
ear
>>>>> job->commen.blk permissions set in block_job_create and add
>>>>> job->source_bs to be used instead of blk_bs(job->common.blk), to ke=
ep
>>>>> it more clear which bs we use when introduce backup-top filter in
>>>>> further commit.
>>>>>
>>>>> 2. Rename s/initializing_bitmap/skip_unallocated/ to sound a bit be=
tter
>>>>> as interface to BlockCopyState
>>>>>
>>>>> 3. Split is not very clean: there left some duplicated fields, back=
up
>>>>> code uses some BlockCopyState fields directly, let's postpone it fo=
r
>>>>> further improvements and keep this comment simpler for review.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
>>>>> ---
>>>>
>>>>
>>>> [..]
>>>>
>>>>> +
>>>>> +static BlockCopyState *block_copy_state_new(
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *sourc=
e, BlockDriverState *target,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t cluster_size, B=
drvRequestFlags write_flags,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ProgressBytesCallbackFu=
nc progress_bytes_callback,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ProgressResetCallbackFu=
nc progress_reset_callback,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *progress_opaque, =
Error **errp)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 BlockCopyState *s;
>>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>>> +=C2=A0=C2=A0=C2=A0 uint64_t no_resize =3D BLK_PERM_CONSISTENT_READ=
 | BLK_PERM_WRITE |
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD;
>>>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *copy_bitmap;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 copy_bitmap =3D bdrv_create_dirty_bitmap(source=
, cluster_size, NULL, errp);
>>>>> +=C2=A0=C2=A0=C2=A0 if (!copy_bitmap) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 bdrv_disable_dirty_bitmap(copy_bitmap);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 s =3D g_new(BlockCopyState, 1);
>>>>> +=C2=A0=C2=A0=C2=A0 *s =3D (BlockCopyState) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .source =3D blk_new(bdr=
v_get_aio_context(source),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 BLK_PERM_CONSISTENT_READ, no_resize),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .target =3D blk_new(bdr=
v_get_aio_context(target),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 BLK_PERM_WRITE, no_resize),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .copy_bitmap =3D copy_b=
itmap,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cluster_size =3D clust=
er_size,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .len =3D bdrv_dirty_bit=
map_size(copy_bitmap),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write_flags =3D write_=
flags,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .use_copy_range =3D !(w=
rite_flags & BDRV_REQ_WRITE_COMPRESSED),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .progress_bytes_callbac=
k =3D progress_bytes_callback,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .progress_reset_callbac=
k =3D progress_reset_callback,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .progress_opaque =3D pr=
ogress_opaque,
>>>>> +=C2=A0=C2=A0=C2=A0 };
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 s->copy_range_size =3D QEMU_ALIGN_UP(MIN(blk_ge=
t_max_transfer(s->source),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_get_max_transfer(s->target)),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 s->cluster_size);
>>>>
>>>> preexistent, but it obviously should be QEMU_ALIGN_DOWN. I can resen=
d with a separate
>>>> fix, it may be fixed while queuing (if resend is not needed for othe=
r reasons) or
>>>> I'll send a follow-up fix later, whichever you prefer.
>>>
>>> Hm, true.=C2=A0 But then we=E2=80=99ll also need to handle the (unlik=
ely, admittedly)
>>> case where max_transfer < cluster_size so this would then return 0 (b=
y
>>> setting use_copy_range =3D false).=C2=A0 So how about this:
>>
>> Done in [PATCH v12 0/2] backup: copy_range fixes.
>> If it is convenient I'll rebase these series on "[PATCH v12 0/2] backu=
p: copy_range fixes"

Oh, good.

I think taking copy_range fixes first would make more sense.  It seems
that John still had some suggestion for it...?

Max


--nLN1fBGiJ9qmVycQIEKDy7fOwCSHRAWTg--

--juKHbAU4WPTfqDQDrTUFjgTFsbatXolER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2E05wACgkQ9AfbAGHV
z0BYNAgAgpvDF9u4pf1qb8o6lf3ehGGCLqKZxMKNCYd9tjhSU5oUtnPQJ+cneuG8
KnYyk6bPwsi6ZeGPeMi4Fi5lGBQmPMQouhC1+zIyQ8f1yyGtLkrMkgdXAlIAu9UK
9VQuLV884pHCNzOaNXMKMO2A3+xgGrNrtkWv/4tdR1TSql4V1WAWD/VEoGTdMTsl
yvLWg8FOpsFoc+vZxtnFy/J5FAiThV5ndySpQBWGwGyIhReKve72hirc/ofdotbF
Tn26KBIFjRnsvFpwaT/8wZNNIXM3G8IwHJXgiGv2iBW97t8UPM68ln/aufJRqeeg
ZKnZ4uNavqnwF9MoWvB/7JQUzmpndA==
=vCnQ
-----END PGP SIGNATURE-----

--juKHbAU4WPTfqDQDrTUFjgTFsbatXolER--

