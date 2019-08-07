Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E48C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5908922305
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5908922305
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44179 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQGM-0005MB-LY
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33252)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hvQFS-0004Iz-CD
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hvQFR-0000lj-8S
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:01:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hvQFO-0000eE-LE; Wed, 07 Aug 2019 14:01:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A489641C9;
 Wed,  7 Aug 2019 18:01:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-24.brq.redhat.com
 [10.40.204.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5C2160BE1;
 Wed,  7 Aug 2019 18:01:06 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-5-vsementsov@virtuozzo.com>
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
Message-ID: <23fd227d-9074-3a9e-b6c7-09f4abadc021@redhat.com>
Date: Wed, 7 Aug 2019 20:01:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807080750.15950-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eY5UdLN4bLnK0UE2iRSemEcBU9aJbuTFJ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 07 Aug 2019 18:01:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/8] block/backup: improve unallocated
 clusters skipping
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
--eY5UdLN4bLnK0UE2iRSemEcBU9aJbuTFJ
Content-Type: multipart/mixed; boundary="g2szmPiiB0ykmyTTWHdjAI74Ls3aegkit";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, fam@euphon.net,
 stefanha@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <23fd227d-9074-3a9e-b6c7-09f4abadc021@redhat.com>
Subject: Re: [PATCH 4/8] block/backup: improve unallocated clusters skipping
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190807080750.15950-5-vsementsov@virtuozzo.com>

--g2szmPiiB0ykmyTTWHdjAI74Ls3aegkit
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.08.19 10:07, Vladimir Sementsov-Ogievskiy wrote:
> Limit block_status querying to request bounds on write notifier to
> avoid extra seeking.

I don=E2=80=99t understand this reasoning.  Checking whether something is=

allocated for qcow2 should just mean an L2 cache lookup.  Which we have
to do anyway when we try to copy data off the source.

I could understand saying this makes the code easier, but I actually
don=E2=80=99t think it does.  If you implemented checking the allocation =
status
only for areas where the bitmap is reset (which I think this patch
should), then it=E2=80=99d just duplicate the existing loop.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index 11e27c844d..a4d37d2d62 100644
> --- a/block/backup.c
> +++ b/block/backup.c

[...]

> @@ -267,6 +267,18 @@ static int coroutine_fn backup_do_cow(BackupBlockJ=
ob *job,
>      wait_for_overlapping_requests(job, start, end);
>      cow_request_begin(&cow_request, job, start, end);
> =20
> +    if (job->initializing_bitmap) {
> +        int64_t off, chunk;
> +
> +        for (off =3D offset; offset < end; offset +=3D chunk) {

This is what I=E2=80=99m referring to, I think this loop should skip area=
s that
are clean.

> +            ret =3D backup_bitmap_reset_unallocated(job, off, end - of=
f, &chunk);
> +            if (ret < 0) {
> +                chunk =3D job->cluster_size;
> +            }
> +        }
> +    }
> +    ret =3D 0;
> +
>      while (start < end) {
>          int64_t dirty_end;
> =20
> @@ -276,15 +288,6 @@ static int coroutine_fn backup_do_cow(BackupBlockJ=
ob *job,
>              continue; /* already copied */
>          }
> =20
> -        if (job->initializing_bitmap) {
> -            ret =3D backup_bitmap_reset_unallocated(job, start, &skip_=
bytes);
> -            if (ret =3D=3D 0) {
> -                trace_backup_do_cow_skip_range(job, start, skip_bytes)=
;
> -                start +=3D skip_bytes;
> -                continue;
> -            }
> -        }
> -
>          dirty_end =3D bdrv_dirty_bitmap_next_zero(job->copy_bitmap, st=
art,
>                                                  end - start);
>          if (dirty_end < 0) {

Hm, you resolved that conflict differently from me.

I decided the bdrv_dirty_bitmap_next_zero() call should go before the
backup_bitmap_reset_unallocated() call so that we can then do a

  dirty_end =3D MIN(dirty_end, start + skip_bytes);

because we probably don=E2=80=99t want to copy anything past what
backup_bitmap_reset_unallocated() has inquired.


But then again this patch eliminates the difference anyway...

Max

> @@ -546,7 +549,8 @@ static int coroutine_fn backup_run(Job *job, Error =
**errp)
>                  goto out;
>              }
> =20
> -            ret =3D backup_bitmap_reset_unallocated(s, offset, &count)=
;
> +            ret =3D backup_bitmap_reset_unallocated(s, offset, s->len =
- offset,
> +                                                  &count);
>              if (ret < 0) {
>                  goto out;
>              }
>=20



--g2szmPiiB0ykmyTTWHdjAI74Ls3aegkit--

--eY5UdLN4bLnK0UE2iRSemEcBU9aJbuTFJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1LEeEACgkQ9AfbAGHV
z0DFOQf/ZqlolhoQr9bg13lKH/idiVUVUF0wdEjb1aobuX6lnaRNgLtb+SYOmk/o
/PoOBG/FsUgZRBc+/prcC3SEyskIjkmhyUiKIaI16DeXGNPstDTqhSQajIlqHxi1
37BE2d/EnayLkm0GeA2bGZZhE3MLgQhHJnrk5+hvYZ0/PGCV6Njz3CmDjSIne49a
qCUXycUAxtb/SnveYc+j/rO4t6g4XiK8lStM+l25EZUGxURyrcl2mwWWqjtk++nS
PcE7db1EXbz8L215anOvpwU1py20bbsn+vCl4i2iZb2B+vArB19x+6xD5+gzIWSh
bENyE6Pw2EcxkLE95Yiaw2BwTLFkgw==
=pI3O
-----END PGP SIGNATURE-----

--eY5UdLN4bLnK0UE2iRSemEcBU9aJbuTFJ--

