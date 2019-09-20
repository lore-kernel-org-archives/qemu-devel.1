Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6A0C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5562073F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5562073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBIL6-0000CV-Fr
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 08:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBIJS-0007vi-OK
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBIJQ-00072w-Nh
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:47:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBIJJ-0006xZ-2w; Fri, 20 Sep 2019 08:46:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B767C057F88;
 Fri, 20 Sep 2019 12:46:51 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82CB75C1B5;
 Fri, 20 Sep 2019 12:46:40 +0000 (UTC)
Subject: Re: [PATCH v11 04/14] block/backup: introduce BlockCopyState
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190910102332.20560-1-vsementsov@virtuozzo.com>
 <20190910102332.20560-5-vsementsov@virtuozzo.com>
 <bafea6c6-38cc-1848-92ea-ec891457515a@virtuozzo.com>
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
Message-ID: <bb798ca2-dd22-9ffe-de08-a4d0d8891f30@redhat.com>
Date: Fri, 20 Sep 2019 14:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bafea6c6-38cc-1848-92ea-ec891457515a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tjxwYJODeXfTLvl3YwLDvYPNpFexwOdHl"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 20 Sep 2019 12:46:51 +0000 (UTC)
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
--tjxwYJODeXfTLvl3YwLDvYPNpFexwOdHl
Content-Type: multipart/mixed; boundary="McdBk85pCsyMw8m2rKqdMQf74tdgIq9cC";
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
Message-ID: <bb798ca2-dd22-9ffe-de08-a4d0d8891f30@redhat.com>
Subject: Re: [PATCH v11 04/14] block/backup: introduce BlockCopyState
References: <20190910102332.20560-1-vsementsov@virtuozzo.com>
 <20190910102332.20560-5-vsementsov@virtuozzo.com>
 <bafea6c6-38cc-1848-92ea-ec891457515a@virtuozzo.com>
In-Reply-To: <bafea6c6-38cc-1848-92ea-ec891457515a@virtuozzo.com>

--McdBk85pCsyMw8m2rKqdMQf74tdgIq9cC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 20:25, Vladimir Sementsov-Ogievskiy wrote:
> 10.09.2019 13:23, Vladimir Sementsov-Ogievskiy wrote:
>> Split copying code part from backup to "block-copy", including separat=
e
>> state structure and function renaming. This is needed to share it with=

>> backup-top filter driver in further commits.
>>
>> Notes:
>>
>> 1. As BlockCopyState keeps own BlockBackend objects, remaining
>> job->common.blk users only use it to get bs by blk_bs() call, so clear=

>> job->commen.blk permissions set in block_job_create and add
>> job->source_bs to be used instead of blk_bs(job->common.blk), to keep
>> it more clear which bs we use when introduce backup-top filter in
>> further commit.
>>
>> 2. Rename s/initializing_bitmap/skip_unallocated/ to sound a bit bette=
r
>> as interface to BlockCopyState
>>
>> 3. Split is not very clean: there left some duplicated fields, backup
>> code uses some BlockCopyState fields directly, let's postpone it for
>> further improvements and keep this comment simpler for review.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>=20
>=20
> [..]
>=20
>> +
>> +static BlockCopyState *block_copy_state_new(
>> +        BlockDriverState *source, BlockDriverState *target,
>> +        int64_t cluster_size, BdrvRequestFlags write_flags,
>> +        ProgressBytesCallbackFunc progress_bytes_callback,
>> +        ProgressResetCallbackFunc progress_reset_callback,
>> +        void *progress_opaque, Error **errp)
>> +{
>> +    BlockCopyState *s;
>> +    int ret;
>> +    uint64_t no_resize =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE =
|
>> +                         BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MO=
D;
>> +    BdrvDirtyBitmap *copy_bitmap;
>> +
>> +    copy_bitmap =3D bdrv_create_dirty_bitmap(source, cluster_size, NU=
LL, errp);
>> +    if (!copy_bitmap) {
>> +        return NULL;
>> +    }
>> +    bdrv_disable_dirty_bitmap(copy_bitmap);
>> +
>> +    s =3D g_new(BlockCopyState, 1);
>> +    *s =3D (BlockCopyState) {
>> +        .source =3D blk_new(bdrv_get_aio_context(source),
>> +                          BLK_PERM_CONSISTENT_READ, no_resize),
>> +        .target =3D blk_new(bdrv_get_aio_context(target),
>> +                          BLK_PERM_WRITE, no_resize),
>> +        .copy_bitmap =3D copy_bitmap,
>> +        .cluster_size =3D cluster_size,
>> +        .len =3D bdrv_dirty_bitmap_size(copy_bitmap),
>> +        .write_flags =3D write_flags,
>> +        .use_copy_range =3D !(write_flags & BDRV_REQ_WRITE_COMPRESSED=
),
>> +        .progress_bytes_callback =3D progress_bytes_callback,
>> +        .progress_reset_callback =3D progress_reset_callback,
>> +        .progress_opaque =3D progress_opaque,
>> +    };
>> +
>> +    s->copy_range_size =3D QEMU_ALIGN_UP(MIN(blk_get_max_transfer(s->=
source),
>> +                                           blk_get_max_transfer(s->ta=
rget)),
>> +                                       s->cluster_size);
>=20
> preexistent, but it obviously should be QEMU_ALIGN_DOWN. I can resend w=
ith a separate
> fix, it may be fixed while queuing (if resend is not needed for other r=
easons) or
> I'll send a follow-up fix later, whichever you prefer.

Hm, true.  But then we=E2=80=99ll also need to handle the (unlikely, admi=
ttedly)
case where max_transfer < cluster_size so this would then return 0 (by
setting use_copy_range =3D false).  So how about this:

> diff --git a/block/backup.c b/block/backup.c
> index e5bcfe7177..ba4a37dbb5 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -182,9 +182,13 @@ static BlockCopyState *block_copy_state_new(
>          .progress_opaque =3D progress_opaque,
>      };
> =20
> -    s->copy_range_size =3D QEMU_ALIGN_UP(MIN(blk_get_max_transfer(s->s=
ource),
> -                                           blk_get_max_transfer(s->tar=
get)),
> -                                       s->cluster_size);
> +    s->copy_range_size =3D QEMU_ALIGN_DOWN(MIN(blk_get_max_transfer(s-=
>source),
> +                                             blk_get_max_transfer(s->t=
arget)),
> +                                         s->cluster_size);
> +    if (s->copy_range_size =3D=3D 0) {
> +        /* max_transfer < cluster_size */
> +        s->use_copy_range =3D false;
> +    }
> =20
>      /*
>       * We just allow aio context change on our block backends. block_c=
opy() user

Max


--McdBk85pCsyMw8m2rKqdMQf74tdgIq9cC--

--tjxwYJODeXfTLvl3YwLDvYPNpFexwOdHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2Eyi4ACgkQ9AfbAGHV
z0B8SAf/TpP+fsPX5YRdiRyD8nMz/tl+oQLnNTlnv7B/1wIiULedSnnpzeMZ8jjd
U9706m9tAZipL/4BdfgXxBgo9wR7E2Q8Ej/HsYDVmX1snMrJnh/o5ROL0/BCZXPv
kymREIdzBJp47YfnS1hCuuL8ObCJdYwpPjLZ9zd8CDEgR9cDccCSVHW8bT98rj94
IH8mIRmK9ASZ8wmyg8Br3Ukd6tPvH35Sejled+eYtUtbUN5iJ1vYUcSs517pnpe2
3+6u2J9LZvkKxVd0AsySJJ2cgDuPeXmHtcyA/oExkbXs4KeiDlWly/mIxGFh5NOC
5izPc710Lxyry14urJwVvKJz45lB8g==
=N50x
-----END PGP SIGNATURE-----

--tjxwYJODeXfTLvl3YwLDvYPNpFexwOdHl--

