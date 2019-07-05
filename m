Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E54C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9F8218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9F8218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjL1Z-00070d-Qz
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47685)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hjKza-0005Y5-AW
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hjKzZ-0004JI-4G
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hjKzS-0004HC-VU; Fri, 05 Jul 2019 05:58:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6797F2F8BCC;
 Fri,  5 Jul 2019 09:58:49 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-154.brq.redhat.com
 [10.40.204.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 688F21001DC3;
 Fri,  5 Jul 2019 09:58:44 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20190705093258.47856-1-sgarzare@redhat.com>
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
Message-ID: <dcc9f3dc-78b4-4216-2791-b7e90f6d79ff@redhat.com>
Date: Fri, 5 Jul 2019 11:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190705093258.47856-1-sgarzare@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cuuLkNd2D3kumeBjl04OhjgZu864ZAoaX"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 05 Jul 2019 09:58:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] block/rbd: implement
 .bdrv_get_allocated_file_size callback
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <jdillama@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cuuLkNd2D3kumeBjl04OhjgZu864ZAoaX
Content-Type: multipart/mixed; boundary="FhVQztPfNgWIRbOdTQC0aOfUwLbmRJCEd";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Josh Durgin <jdurgin@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Dillaman <jdillama@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <dcc9f3dc-78b4-4216-2791-b7e90f6d79ff@redhat.com>
Subject: Re: [PATCH v3] block/rbd: implement .bdrv_get_allocated_file_size
 callback
References: <20190705093258.47856-1-sgarzare@redhat.com>
In-Reply-To: <20190705093258.47856-1-sgarzare@redhat.com>

--FhVQztPfNgWIRbOdTQC0aOfUwLbmRJCEd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.07.19 11:32, Stefano Garzarella wrote:
> This patch allows 'qemu-img info' to show the 'disk size' for
> the RBD images that have the fast-diff feature enabled.
>=20
> If this feature is enabled, we use the rbd_diff_iterate2() API
> to calculate the allocated size for the image.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3:
>   - return -ENOTSUP instead of -1 when fast-diff is not available
>     [John, Jason]
> v2:
>   - calculate the actual usage only if the fast-diff feature is
>     enabled [Jason]
> ---
>  block/rbd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 54 insertions(+)

Well, the librbd documentation is non-existing as always, but while
googling, I at least found that libvirt has exactly the same code.  So I
suppose it must be quite correct, then.

> diff --git a/block/rbd.c b/block/rbd.c
> index 59757b3120..b6bed683e5 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -1084,6 +1084,59 @@ static int64_t qemu_rbd_getlength(BlockDriverSta=
te *bs)
>      return info.size;
>  }
> =20
> +static int rbd_allocated_size_cb(uint64_t offset, size_t len, int exis=
ts,
> +                                 void *arg)
> +{
> +    int64_t *alloc_size =3D (int64_t *) arg;
> +
> +    if (exists) {
> +        (*alloc_size) +=3D len;
> +    }
> +
> +    return 0;
> +}
> +
> +static int64_t qemu_rbd_get_allocated_file_size(BlockDriverState *bs)
> +{
> +    BDRVRBDState *s =3D bs->opaque;
> +    uint64_t flags, features;
> +    int64_t alloc_size =3D 0;
> +    int r;
> +
> +    r =3D rbd_get_flags(s->image, &flags);
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    r =3D rbd_get_features(s->image, &features);
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    /*
> +     * We use rbd_diff_iterate2() only if the RBD image have fast-diff=

> +     * feature enabled. If it is disabled, rbd_diff_iterate2() could b=
e
> +     * very slow on a big image.
> +     */
> +    if (!(features & RBD_FEATURE_FAST_DIFF) ||
> +        (flags & RBD_FLAG_FAST_DIFF_INVALID)) {
> +        return -ENOTSUP;
> +    }
> +
> +    /*
> +     * rbd_diff_iterate2(), if the source snapshot name is NULL, invok=
es
> +     * the callback on all allocated regions of the image.
> +     */
> +    r =3D rbd_diff_iterate2(s->image, NULL, 0,
> +                          bs->total_sectors * BDRV_SECTOR_SIZE, 0, 1,
> +                          &rbd_allocated_size_cb, &alloc_size);

But I have a question.  This is basically block_status, right?  So it
gives us information on which areas are allocated and which are not.
The result thus gives us a lower bound on the allocation size, but is it
really exactly the allocation size?

There are two things I=E2=80=99m concerned about:

1. What about metadata?

2. If you have multiple snapshots, this will only report the overall
allocation information, right?  So say there is something like this:

(=E2=80=9CA=E2=80=9D means an allocated MB, =E2=80=9C-=E2=80=9D is an una=
llocated MB)

Snapshot 1: AAAA---
Snapshot 2: --AAAAA
Snapshot 3: -AAAA--

I think the allocated data size is the number of As in total (13 MB).
But I suppose this API will just return 7 MB, because it looks on
everything an it sees the whole image range (7 MB) to be allocated.  It
doesn=E2=80=99t report in how many snapshots some region is allocated.

Max

> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    return alloc_size;
> +}
> +
>  static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>                                               int64_t offset,
>                                               PreallocMode prealloc,
> @@ -1291,6 +1344,7 @@ static BlockDriver bdrv_rbd =3D {
>      .bdrv_get_info          =3D qemu_rbd_getinfo,
>      .create_opts            =3D &qemu_rbd_create_opts,
>      .bdrv_getlength         =3D qemu_rbd_getlength,
> +    .bdrv_get_allocated_file_size =3D qemu_rbd_get_allocated_file_size=
,
>      .bdrv_co_truncate       =3D qemu_rbd_co_truncate,
>      .protocol_name          =3D "rbd",
> =20
>=20



--FhVQztPfNgWIRbOdTQC0aOfUwLbmRJCEd--

--cuuLkNd2D3kumeBjl04OhjgZu864ZAoaX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0fH1MACgkQ9AfbAGHV
z0CZrggAietHTQTZ4YJJM+X/nm3KxCVjx/DwQZ3EaqssTqPF+3HKTGyCgPs+Ybzo
kgmNP+5qayEmCj61axWAE8GR4XfHH4qpS21qsZ06QbHiEOjfD22qZl68YRJL8KpL
z4DFhB7KJACEntnF8fhSmukOYka0zT/kgNLPwSrM+yLxn1GXs5qpDRNPNhAmCnzZ
ZZgoAKrCC1WjnTq8RVfHSFNqCxbTGkihFXHyN0SKbIbYJld1IpCEjGGzj5I61U0i
q67hy37zxb8IZWHgZmouzwvNd+Le84redmCDT1nWE+ytozFCQM3ScLQ04xr/JR6l
JLd6HZioXNDWV8gS/QcQ3ustevurnw==
=ZGfF
-----END PGP SIGNATURE-----

--cuuLkNd2D3kumeBjl04OhjgZu864ZAoaX--

