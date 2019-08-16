Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307DAC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 22:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0194E2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 22:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0194E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hykbP-0000Je-4F
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 18:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hykaO-0007fz-K0
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 18:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hykaN-0002HF-GZ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 18:20:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hykaL-0002Di-3M; Fri, 16 Aug 2019 18:20:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6D3748AC6F7;
 Fri, 16 Aug 2019 22:20:36 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-156.brq.redhat.com
 [10.40.204.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F361AF6C2;
 Fri, 16 Aug 2019 22:20:32 +0000 (UTC)
To: John Snow <jsnow@redhat.com>
References: <c8b0ab36-79c8-0b4b-3193-4e12ed8c848b@redhat.com>
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
Message-ID: <52b4cd48-93f2-c001-fa56-2fbd8485ee1d@redhat.com>
Date: Sat, 17 Aug 2019 00:20:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c8b0ab36-79c8-0b4b-3193-4e12ed8c848b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UGnLWZwmhbtxOyTMtxiU4boCtFAg4vl6O"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 16 Aug 2019 22:20:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] bitmaps branch conflict resolution
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UGnLWZwmhbtxOyTMtxiU4boCtFAg4vl6O
Content-Type: multipart/mixed; boundary="NbcrPCYhKAhWyKCFfKcciG7hKehVKcJpB";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <52b4cd48-93f2-c001-fa56-2fbd8485ee1d@redhat.com>
Subject: Re: bitmaps branch conflict resolution
References: <c8b0ab36-79c8-0b4b-3193-4e12ed8c848b@redhat.com>
In-Reply-To: <c8b0ab36-79c8-0b4b-3193-4e12ed8c848b@redhat.com>

--NbcrPCYhKAhWyKCFfKcciG7hKehVKcJpB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.08.19 00:07, John Snow wrote:
> Hi Max, I took your patch and adjusted it slightly: I don't like
> "skip_bytes" anymore because it's clear now that we don't only read tha=
t
> value when we're skipping bytes, so now it's just status_bytes.

Yep, sure.

> Since this is based on your fixup, would you like to offer an
> Ack/S-o-b/R-B/whichever here?

Sure:

Reviewed-by: Max Reitz <mreitz@redhat.com>

Additional explanation for others:

The conflict resolution in itself is just a matter of the
=E2=80=9Cbackup_bitmap_reset_unallocated=E2=80=9D block and the
=E2=80=9Cbdrv_dirty_bitmap_next_zero=E2=80=9D block introduced in the sam=
e place in two
separate patches (one went to master, the other to bitmaps-next).

So the question is how to order them.  On the first glance, it doesn=E2=80=
=99t
matter, it can go both ways.

On a second glance, it turns out we need to combine the results, hence
the new MIN() here.

If we are initializing the bitmap, bdrv_dirty_bitmap_next_zero() does
not necessarily return the correct result.  It is only accurate insofar
we have actually initialized the bitmap.  We can get that information
from backup_bitmap_reset_unallocated(): It ensures that the bitmap is
accurate in the [start, start + status_bytes) range.

Therefore, we have to limit dirty_end by start + status_bytes.

I don=E2=80=99t think it really matters whether we do the
backup_bitmap_reset_allocated() or the bdrv_dirty_bitmap_next_zero()
first.  It=E2=80=99s just that it=E2=80=99s slightly simpler to do the la=
tter first,
because the former is in a conditional block, so we can put the MIN()
right there.  Hence the order change here.

(If we did it the other way around, we=E2=80=99d need another conditional=
 block
=E2=80=9Cif (job->initializing_bitmap) { dirty_end =3D MIN(...) }=E2=80=9D=
 after we have
both dirty_end and status_bytes.)

Max

> diff --git a/block/backup.c b/block/backup.c
> index ee4d5598986..9e1382ec5c6 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -266,7 +266,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJo=
b
> *job,
>      int ret =3D 0;
>      int64_t start, end; /* bytes */
>      void *bounce_buffer =3D NULL;
> -    int64_t skip_bytes;
> +    int64_t status_bytes;
>=20
>      qemu_co_rwlock_rdlock(&job->flush_rwlock);
>=20
> @@ -287,21 +287,23 @@ static int coroutine_fn
> backup_do_cow(BackupBlockJob *job,
>              continue; /* already copied */
>          }
>=20
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
>                                                  (end - start));
>          if (dirty_end < 0) {
>              dirty_end =3D end;
>          }
>=20
> +        if (job->initializing_bitmap) {
> +            ret =3D backup_bitmap_reset_unallocated(job, start,
> &status_bytes);
> +            if (ret =3D=3D 0) {
> +                trace_backup_do_cow_skip_range(job, start, status_byte=
s);
> +                start +=3D status_bytes;
> +                continue;
> +            }
> +            /* Clamp to known allocated region */
> +            dirty_end =3D MIN(dirty_end, start + status_bytes);
> +        }
> +
>          trace_backup_do_cow_process(job, start);
>=20
>          if (job->use_copy_range) {
>=20



--NbcrPCYhKAhWyKCFfKcciG7hKehVKcJpB--

--UGnLWZwmhbtxOyTMtxiU4boCtFAg4vl6O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1XLC8ACgkQ9AfbAGHV
z0ApXQgAvb+jKJ5WwUPNq291uZj5BiUztKofgxMLCscm/bLhfnhTGWnQljHQ4q8I
4piQS7bBgDVvgCRKGE+Wg/DPbLUHJrqwopgvkeSHrA4i/Bb+kxf63K/KZVkxFLL9
/NG6qnl1DBOjSdRoF5BAvTzpKNU4W0VshYMV9EYoslWZi6LJ8KZk3Dkhn4egvVl8
efK71LyT27plEO3FEGXbo3J0OHQ0s8De+EduJcIoolNnHTAerCcRn28rB8HIwpRc
zKqNcACTDTi4brhYdFmRlpfQYb4qk4Ir+CkNH5YYowFQvxr7T6msuInObEZTNDkg
iISvSXe3X+gdW3kWD5t4clEhhebSCA==
=yLDs
-----END PGP SIGNATURE-----

--UGnLWZwmhbtxOyTMtxiU4boCtFAg4vl6O--

