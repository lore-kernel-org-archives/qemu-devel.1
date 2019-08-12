Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144B1C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC25820665
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC25820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxByb-0002M2-3o
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40651)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxBy6-0001rr-Av
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxBy5-0005rg-48
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxBy2-0005qR-Do; Mon, 12 Aug 2019 11:10:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5FBC2EC520;
 Mon, 12 Aug 2019 15:10:37 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ADE96F934;
 Mon, 12 Aug 2019 15:10:29 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
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
Message-ID: <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
Date: Mon, 12 Aug 2019 17:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810193155.58637-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FW8uYhFnE6BPHqKc2zAW3k4DY98s3v9UL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 12 Aug 2019 15:10:37 +0000 (UTC)
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FW8uYhFnE6BPHqKc2zAW3k4DY98s3v9UL
Content-Type: multipart/mixed; boundary="EJ6XLnEoFFIj3Y2CYwqifKIyiYauhViwA";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, fam@euphon.net,
 stefanha@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
Subject: Re: [PATCH v3 6/7] block/backup: teach backup_cow_with_bounce_buffer
 to copy more at once
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
In-Reply-To: <20190810193155.58637-7-vsementsov@virtuozzo.com>

--EJ6XLnEoFFIj3Y2CYwqifKIyiYauhViwA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.08.19 21:31, Vladimir Sementsov-Ogievskiy wrote:
> backup_cow_with_offload can transfer more than one cluster. Let
> backup_cow_with_bounce_buffer behave similarly. It reduces the number
> of IO requests, since there is no need to copy cluster by cluster.
>=20
> Logic around bounce_buffer allocation changed: we can't just allocate
> one-cluster-sized buffer to share for all iterations. We can't also
> allocate buffer of full-request length it may be too large, so
> BACKUP_MAX_BOUNCE_BUFFER is introduced. And finally, allocation logic
> is to allocate a buffer sufficient to handle all remaining iterations
> at the point where we need the buffer for the first time.
>=20
> Bonus: get rid of pointer-to-pointer.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 65 +++++++++++++++++++++++++++++++-------------------=

>  1 file changed, 41 insertions(+), 24 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index d482d93458..65f7212c85 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -27,6 +27,7 @@
>  #include "qemu/error-report.h"
> =20
>  #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
> +#define BACKUP_MAX_BOUNCE_BUFFER (64 * 1024 * 1024)
> =20
>  typedef struct CowRequest {
>      int64_t start_byte;
> @@ -98,44 +99,55 @@ static void cow_request_end(CowRequest *req)
>      qemu_co_queue_restart_all(&req->wait_queue);
>  }
> =20
> -/* Copy range to target with a bounce buffer and return the bytes copi=
ed. If
> - * error occurred, return a negative error number */
> +/*
> + * Copy range to target with a bounce buffer and return the bytes copi=
ed. If
> + * error occurred, return a negative error number
> + *
> + * @bounce_buffer is assumed to enough to store

s/to/to be/

> + * MIN(BACKUP_MAX_BOUNCE_BUFFER, @end - @start) bytes
> + */
>  static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *=
job,
>                                                        int64_t start,
>                                                        int64_t end,
>                                                        bool is_write_no=
tifier,
>                                                        bool *error_is_r=
ead,
> -                                                      void **bounce_bu=
ffer)
> +                                                      void *bounce_buf=
fer)
>  {
>      int ret;
>      BlockBackend *blk =3D job->common.blk;
> -    int nbytes;
> +    int nbytes, remaining_bytes;
>      int read_flags =3D is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0=
;
> =20
>      assert(QEMU_IS_ALIGNED(start, job->cluster_size));
> -    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size=
);
> -    nbytes =3D MIN(job->cluster_size, job->len - start);
> -    if (!*bounce_buffer) {
> -        *bounce_buffer =3D blk_blockalign(blk, job->cluster_size);
> -    }
> +    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, end - start);
> +    nbytes =3D MIN(end - start, job->len - start);
> =20
> -    ret =3D blk_co_pread(blk, start, nbytes, *bounce_buffer, read_flag=
s);
> -    if (ret < 0) {
> -        trace_backup_do_cow_read_fail(job, start, ret);
> -        if (error_is_read) {
> -            *error_is_read =3D true;
> +
> +    remaining_bytes =3D nbytes;
> +    while (remaining_bytes) {
> +        int chunk =3D MIN(BACKUP_MAX_BOUNCE_BUFFER, remaining_bytes);
> +
> +        ret =3D blk_co_pread(blk, start, chunk, bounce_buffer, read_fl=
ags);
> +        if (ret < 0) {
> +            trace_backup_do_cow_read_fail(job, start, ret);
> +            if (error_is_read) {
> +                *error_is_read =3D true;
> +            }
> +            goto fail;
>          }
> -        goto fail;
> -    }
> =20
> -    ret =3D blk_co_pwrite(job->target, start, nbytes, *bounce_buffer,
> -                        job->write_flags);
> -    if (ret < 0) {
> -        trace_backup_do_cow_write_fail(job, start, ret);
> -        if (error_is_read) {
> -            *error_is_read =3D false;
> +        ret =3D blk_co_pwrite(job->target, start, chunk, bounce_buffer=
,
> +                            job->write_flags);
> +        if (ret < 0) {
> +            trace_backup_do_cow_write_fail(job, start, ret);
> +            if (error_is_read) {
> +                *error_is_read =3D false;
> +            }
> +            goto fail;
>          }
> -        goto fail;
> +
> +        start +=3D chunk;
> +        remaining_bytes -=3D chunk;
>      }
> =20
>      return nbytes;
> @@ -301,9 +313,14 @@ static int coroutine_fn backup_do_cow(BackupBlockJ=
ob *job,
>              }
>          }
>          if (!job->use_copy_range) {
> +            if (!bounce_buffer) {
> +                size_t len =3D MIN(BACKUP_MAX_BOUNCE_BUFFER,
> +                                 MAX(dirty_end - start, end - dirty_en=
d));
> +                bounce_buffer =3D blk_try_blockalign(job->common.blk, =
len);
> +            }

If you use _try_, you should probably also check whether it succeeded.

Anyway, I wonder whether it=E2=80=99d be better to just allocate this buf=
fer
once per job (the first time we get here, probably) to be of size
BACKUP_MAX_BOUNCE_BUFFER and put it into BackupBlockJob.  (And maybe add
a buf-size parameter similar to what the mirror jobs have.)

Max

>              ret =3D backup_cow_with_bounce_buffer(job, start, dirty_en=
d,
>                                                  is_write_notifier,
> -                                                error_is_read, &bounce=
_buffer);
> +                                                error_is_read, bounce_=
buffer);
>          }
>          if (ret < 0) {
>              break;
>=20



--EJ6XLnEoFFIj3Y2CYwqifKIyiYauhViwA--

--FW8uYhFnE6BPHqKc2zAW3k4DY98s3v9UL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1RgWQACgkQ9AfbAGHV
z0As9wf+ODi6hzYDEaZT9ylEPWJR+dKOxQGogynhMvxfbL1Hku5zbWJ9HQdub+Ma
RXI+yDKMBM6TDdwlufLFp+m8yTFVuOhPgIMJ80DNhmpgDjRQBVipvFNwpKiXTIy1
0Yib4XPtckoV7Husn9gqfjT6fSP1ep/wZlwNvrpSpOpyMXSlg0aDKWIANu8ALqbN
IXEArNOYYiuxOb4bzqiaQa8f/qQzctZLj8ZSYg6xYmLNuEyz29NMLppUcAKrLNMK
BJivyBfRe7j5jo+liHO2lbibnNHdYeyj7N783V7VT5ZupEFuUP9aVHOlpVkOXgWS
+DoO6MDjSpjxN/j45IYC7SP5BpTKtg==
=aszq
-----END PGP SIGNATURE-----

--FW8uYhFnE6BPHqKc2zAW3k4DY98s3v9UL--

