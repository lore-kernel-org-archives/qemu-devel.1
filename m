Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D83C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9019F21D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XILZRlLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9019F21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itWuB-0002Lg-F9
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itWsy-0001G7-EA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itWsu-0005la-Cc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:14:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43408
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itWsu-0005l2-7m
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579526067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f9kWvt6PMrgfDuhFDTHT4InagQJpkQk86sNA84esFww=;
 b=XILZRlLBb4/vYCTFM6GN4gB40VTb0QcsWrZ1Haw5Z5rgAi5RZuICqZ46/9VnRc8mVgxagz
 9n/2lebz8qv1lRXQaDC8LBgS3S8zyh3S9+pjLLAS21vSE7EIiZRxlrv9JGbe5WItybX9oK
 5mhgWmjCrY669T9yQlvBF/h+PVpOIyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-ZpF4KUjJP96PlcnxMj2xkQ-1; Mon, 20 Jan 2020 08:14:24 -0500
X-MC-Unique: ZpF4KUjJP96PlcnxMj2xkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97D4EDBA3;
 Mon, 20 Jan 2020 13:14:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC78527BD7;
 Mon, 20 Jan 2020 13:14:15 +0000 (UTC)
Subject: Re: [PATCH v3 06/10] block/dirty-bitmap: add _next_dirty API
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-7-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <0350481a-12ad-1608-79f1-b9f433963565@redhat.com>
Date: Mon, 20 Jan 2020 14:14:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191219100348.24827-7-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X7FuSQJswyWO8RSmhBdev1r4faqvTd79c"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X7FuSQJswyWO8RSmhBdev1r4faqvTd79c
Content-Type: multipart/mixed; boundary="gGMEfTTVgyc3TKPoQKQoS6onWpuv68qsA"

--gGMEfTTVgyc3TKPoQKQoS6onWpuv68qsA
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
> We have bdrv_dirty_bitmap_next_zero, let's add corresponding
> bdrv_dirty_bitmap_next_dirty, which is more comfortable to use than
> bitmap iterators in some cases.
>=20
> For test modify test_hbitmap_next_zero_check_range to check both
> next_zero and next_dirty and add some new checks.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/dirty-bitmap.h |   2 +
>  include/qemu/hbitmap.h       |  13 ++++
>  block/dirty-bitmap.c         |   6 ++
>  tests/test-hbitmap.c         | 130 ++++++++++++++++++++---------------
>  util/hbitmap.c               |  60 ++++++++--------
>  5 files changed, 126 insertions(+), 85 deletions(-)

[...]

> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
> index b6e85f3d5d..a4b032b270 100644
> --- a/include/qemu/hbitmap.h
> +++ b/include/qemu/hbitmap.h
> @@ -297,6 +297,19 @@ void hbitmap_free(HBitmap *hb);
>   */
>  void hbitmap_iter_init(HBitmapIter *hbi, const HBitmap *hb, uint64_t fir=
st);
> =20
> +/*
> + * hbitmap_next_dirty:
> + *
> + * Find next dirty bit within selected range. If not found, return -1.
> + *
> + * @hb: The HBitmap to operate on
> + * @start: The bit to start from.
> + * @count: Number of bits to proceed. If @start+@count > bitmap size, th=
e whole
> + * bitmap is looked through. You can use UINT64_MAX as @count to search =
up to

I would=92ve said s/looked through/scanned/, but it matches
hbitmap_next_zero()=92s documentation, so it=92s fine.

But definitely s/UINT64_MAX/INT64_MAX/.

> + * the bitmap end.
> + */
> +int64_t hbitmap_next_dirty(const HBitmap *hb, int64_t start, int64_t cou=
nt);
> +
>  /* hbitmap_next_zero:
>   *
>   * Find next not dirty bit within selected range. If not found, return -=
1.

[...]

> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
> index 0e1e5c64dd..e3f1b3f361 100644
> --- a/tests/test-hbitmap.c
> +++ b/tests/test-hbitmap.c
> @@ -816,92 +816,108 @@ static void test_hbitmap_iter_and_reset(TestHBitma=
pData *data,
>      hbitmap_iter_next(&hbi);
>  }
> =20
> -static void test_hbitmap_next_zero_check_range(TestHBitmapData *data,
> -                                               uint64_t start,
> -                                               uint64_t count)
> +static void test_hbitmap_next_x_check_range(TestHBitmapData *data,
> +                                            uint64_t start,
> +                                            uint64_t count)

Why not change the parameters to be signed while we=92re already here?

[...]

> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index df22f06be6..d23f4b9678 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -193,6 +193,30 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitm=
ap *hb, uint64_t first)
>      }
>  }
> =20
> +int64_t hbitmap_next_dirty(const HBitmap *hb, int64_t start, int64_t cou=
nt)
> +{
> +    HBitmapIter hbi;
> +    int64_t firt_dirty_off;

Pre-existing, but isn=92t this just a typo that you could fix here?  (i.e.
s/firt/first/)

Apart from this minor things:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +    uint64_t end;
> +
> +    assert(start >=3D 0 && count >=3D 0);
> +
> +    if (start >=3D hb->orig_size || count =3D=3D 0) {
> +        return -1;
> +    }
> +
> +    end =3D count > hb->orig_size - start ?=20


--gGMEfTTVgyc3TKPoQKQoS6onWpuv68qsA--

--X7FuSQJswyWO8RSmhBdev1r4faqvTd79c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4lp6UACgkQ9AfbAGHV
z0D3AwgAvpIP4AvvBCK9qeYRpNEaOIgaN91H82tyCOEWkshWIjLGDtt6FRAHQpaI
YYSYMcc5TBM53vVoQW2AfymaFjpFhOzN6tzt3A//08g4bS/1G5/lE1Ntb42vAqko
1jnKCv5MxL0FLTZhxrarK7Qn1SmrURssYS3A6occKlIjapfszmOG7qjqXoUR4zz7
ffMkGD8wv5p0M4pwzInV2t+U6V6nsa+fe0l75PacOr+9qvuWWkrLtH+GfHvkAvF2
gWqgvaGOis6MhoWy3772aECCSbkbvNvlWqIyAEtNfaKadGqaSC+Bx0FUFloMXjaM
7CggFQvBeFbE0iEbHnMX6hfs10y8sw==
=OP56
-----END PGP SIGNATURE-----

--X7FuSQJswyWO8RSmhBdev1r4faqvTd79c--


