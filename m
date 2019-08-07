Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8533C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937262229C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937262229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQxz-000777-UM
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43046)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hvQxP-0006Cb-24
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hvQxN-0001KU-47
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:46:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hvQxH-00015x-Kk; Wed, 07 Aug 2019 14:46:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE1603078856;
 Wed,  7 Aug 2019 18:46:34 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-24.brq.redhat.com
 [10.40.204.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7BF05D9DC;
 Wed,  7 Aug 2019 18:46:27 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-9-vsementsov@virtuozzo.com>
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
Message-ID: <bf5dc465-6dce-8a8c-86d0-322adda769a8@redhat.com>
Date: Wed, 7 Aug 2019 20:46:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807080750.15950-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="srF1YnK6f2dSxnD2UWYcEGY02fmNI8Ysj"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 07 Aug 2019 18:46:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 8/8] block/backup: backup_do_cow: use
 bdrv_dirty_bitmap_next_dirty_area
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--srF1YnK6f2dSxnD2UWYcEGY02fmNI8Ysj
Content-Type: multipart/mixed; boundary="0II9Al887mJM692gZytYE5FqC6WFjdTCB";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, fam@euphon.net,
 stefanha@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <bf5dc465-6dce-8a8c-86d0-322adda769a8@redhat.com>
Subject: Re: [PATCH 8/8] block/backup: backup_do_cow: use
 bdrv_dirty_bitmap_next_dirty_area
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-9-vsementsov@virtuozzo.com>
In-Reply-To: <20190807080750.15950-9-vsementsov@virtuozzo.com>

--0II9Al887mJM692gZytYE5FqC6WFjdTCB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.08.19 10:07, Vladimir Sementsov-Ogievskiy wrote:
> Use effective bdrv_dirty_bitmap_next_dirty_area interface.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 56 ++++++++++++++++++++++----------------------------=

>  1 file changed, 24 insertions(+), 32 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index f19c9195fe..5ede0c8290 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -235,25 +235,28 @@ static int coroutine_fn backup_do_cow(BackupBlock=
Job *job,
>  {
>      CowRequest cow_request;
>      int ret =3D 0;
> -    int64_t start, end; /* bytes */
> +    uint64_t off, cur_bytes;
> +    int64_t aligned_offset, aligned_bytes, aligned_end;
>      BdrvRequestFlags read_flags =3D
>              is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
> =20
>      qemu_co_rwlock_rdlock(&job->flush_rwlock);
> =20
> -    start =3D QEMU_ALIGN_DOWN(offset, job->cluster_size);
> -    end =3D QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
> +    aligned_offset =3D QEMU_ALIGN_DOWN(offset, job->cluster_size);
> +    aligned_end =3D QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
> +    aligned_bytes =3D aligned_end - aligned_offset;
> =20
> -    trace_backup_do_cow_enter(job, start, offset, bytes);
> +    trace_backup_do_cow_enter(job, aligned_offset, offset, bytes);
> =20
> -    wait_for_overlapping_requests(job, start, end);
> -    cow_request_begin(&cow_request, job, start, end);
> +    wait_for_overlapping_requests(job, aligned_offset, aligned_end);
> +    cow_request_begin(&cow_request, job, aligned_offset, aligned_end);=

> =20
>      if (job->initializing_bitmap) {
> -        int64_t off, chunk;
> +        int64_t chunk;
> =20
> -        for (off =3D offset; offset < end; offset +=3D chunk) {
> -            ret =3D backup_bitmap_reset_unallocated(job, off, end - of=
f, &chunk);
> +        for (off =3D aligned_offset; off < aligned_end; off +=3D chunk=
) {
> +            ret =3D backup_bitmap_reset_unallocated(job, off, aligned_=
end - off,
> +                                                  &chunk);
>              if (ret < 0) {
>                  chunk =3D job->cluster_size;
>              }
> @@ -261,47 +264,36 @@ static int coroutine_fn backup_do_cow(BackupBlock=
Job *job,
>      }
>      ret =3D 0;
> =20
> -    while (start < end) {
> -        int64_t dirty_end;
> -        int64_t cur_bytes;
> -
> -        if (!bdrv_dirty_bitmap_get(job->copy_bitmap, start)) {
> -            trace_backup_do_cow_skip(job, start);
> -            start +=3D job->cluster_size;
> -            continue; /* already copied */
> -        }
> -
> -        dirty_end =3D bdrv_dirty_bitmap_next_zero(job->copy_bitmap, st=
art,
> -                                                end - start);
> -        if (dirty_end < 0) {
> -            dirty_end =3D end;
> -        }
> -
> -        trace_backup_do_cow_process(job, start);
> -        cur_bytes =3D MIN(dirty_end - start, job->len - start);
> -        bdrv_reset_dirty_bitmap(job->copy_bitmap, start, dirty_end - s=
tart);
> +    off =3D aligned_offset;
> +    cur_bytes =3D aligned_bytes;
> +    while (bdrv_dirty_bitmap_next_dirty_area(job->copy_bitmap,
> +                                             &off, &cur_bytes))
> +    {
> +        trace_backup_do_cow_process(job, off);
> +        bdrv_reset_dirty_bitmap(job->copy_bitmap, off, cur_bytes);
> =20
>          if (job->use_copy_range) {
> -            ret =3D backup_cow_with_offload(job, start, cur_bytes, rea=
d_flags);
> +            ret =3D backup_cow_with_offload(job, off, cur_bytes, read_=
flags);
>              if (ret < 0) {
>                  job->use_copy_range =3D false;
>              }
>          }
>          if (!job->use_copy_range) {
> -            ret =3D backup_cow_with_bounce_buffer(job, start, cur_byte=
s,
> +            ret =3D backup_cow_with_bounce_buffer(job, off, cur_bytes,=

>                                                  read_flags, error_is_r=
ead);
>          }
>          if (ret < 0) {
> -            bdrv_set_dirty_bitmap(job->copy_bitmap, start, dirty_end -=
 start);
> +            bdrv_set_dirty_bitmap(job->copy_bitmap, off, cur_bytes);
>              break;
>          }
> =20
>          /* Publish progress, guest I/O counts as progress too.  Note t=
hat the
>           * offset field is an opaque progress value, it is not a disk =
offset.
>           */
> -        start +=3D cur_bytes;
> +        off +=3D cur_bytes;
>          job->bytes_read +=3D cur_bytes;
>          job_progress_update(&job->common.job, cur_bytes);
> +        cur_bytes =3D offset + bytes - off;

Hm, why not aligned_end - off?

(You could also drop aligned_bytes altogether and always set cur_bytes
to aligned_end - off.)

Max

>      }
> =20
>      cow_request_end(&cow_request);
>=20



--0II9Al887mJM692gZytYE5FqC6WFjdTCB--

--srF1YnK6f2dSxnD2UWYcEGY02fmNI8Ysj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1LHIEACgkQ9AfbAGHV
z0ANSggAuB8qS98sTHymhRaq4vVrmo6ai8NDQ821al1xtR8CiFpVrby6jlBoG6ns
tU5beslKaPqTfizQ7MclyAAQHFaGX+9//fTEWrlHEm/U8OEgEjnB1CvNthonGPuf
RdFps4rwZ/6rDmOwSmEqkXiWKQQHAcgCAGRxe5FYwpo/ae8uRQtLTboNw18Gdw5r
jwMytXxZ97cWqPOI3CIZwH0DzVPeHpGLtF5fjkzqDtiatK8xVdBMq6GdVrL6yGeJ
LBFN+bpEdk6Q+ukaSJX7dLn4yPOquykuiEKop5RcD0MsGJgq+0NSuo88hugGptaO
c/z/U+fwfBs5nK1TmQJGkHrKp7LrSw==
=QIFt
-----END PGP SIGNATURE-----

--srF1YnK6f2dSxnD2UWYcEGY02fmNI8Ysj--

