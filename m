Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ADCC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B9720679
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B9720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv22J-00013f-Jl
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42829)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hv21r-0000ZL-TF
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hv21q-0001zf-KI
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:09:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hv21m-0001wO-0T; Tue, 06 Aug 2019 12:09:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16CDF8E5AC;
 Tue,  6 Aug 2019 16:09:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-49.brq.redhat.com
 [10.40.204.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15F6219C5B;
 Tue,  6 Aug 2019 16:09:28 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190806152611.280389-1-vsementsov@virtuozzo.com>
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
Message-ID: <fa5f14a1-e05d-24e7-a51e-ad7737d5f4a1@redhat.com>
Date: Tue, 6 Aug 2019 18:09:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806152611.280389-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r0efrs7WsagEdtYEFduGYp3z3BSTkUYsq"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 06 Aug 2019 16:09:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] util/hbitmap: strict hbitmap_reset
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
Cc: fam@euphon.net, kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r0efrs7WsagEdtYEFduGYp3z3BSTkUYsq
Content-Type: multipart/mixed; boundary="qJ5rIzEyMJr5ZtLUfFsBjFsyRBHdzLsEj";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, fam@euphon.net,
 kwolf@redhat.com, den@openvz.org
Message-ID: <fa5f14a1-e05d-24e7-a51e-ad7737d5f4a1@redhat.com>
Subject: Re: [PATCH v2] util/hbitmap: strict hbitmap_reset
References: <20190806152611.280389-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190806152611.280389-1-vsementsov@virtuozzo.com>

--qJ5rIzEyMJr5ZtLUfFsBjFsyRBHdzLsEj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.08.19 17:26, Vladimir Sementsov-Ogievskiy wrote:
> hbitmap_reset has an unobvious property: it rounds requested region up.=

> It may provoke bugs, like in recently fixed write-blocking mode of
> mirror: user calls reset on unaligned region, not keeping in mind that
> there are possible unrelated dirty bytes, covered by rounded-up region
> and information of this unrelated "dirtiness" will be lost.
>=20
> Make hbitmap_reset strict: assert that arguments are aligned, allowing
> only one exception when @start + @count =3D=3D hb->orig_size. It's need=
ed
> to comfort users of hbitmap_next_dirty_area, which cares about
> hb->orig_size.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> v2 based on Max's https://github.com/XanClic/qemu.git block
> which will be merged soon to 4.1, and this patch goes to 4.2
> Based-on: https://github.com/XanClic/qemu.git block
>=20
> v1 was "[PATCH] util/hbitmap: fix unaligned reset", and as I understand=

> we all agreed to just assert alignment instead of aligning down
> automatically.
>=20
>  include/qemu/hbitmap.h | 5 +++++
>  tests/test-hbitmap.c   | 2 +-
>  util/hbitmap.c         | 4 ++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
> index 4afbe6292e..7865e819ca 100644
> --- a/include/qemu/hbitmap.h
> +++ b/include/qemu/hbitmap.h
> @@ -132,6 +132,11 @@ void hbitmap_set(HBitmap *hb, uint64_t start, uint=
64_t count);
>   * @count: Number of bits to reset.
>   *
>   * Reset a consecutive range of bits in an HBitmap.
> + * @start and @count must be aligned to bitmap granularity. The only e=
xception
> + * is resetting the tail of the bitmap: @count may be equal to @start =
+
> + * hb->orig_size,

s/@start + hb->orig_size/hb->orig_size - @start/, I think.

>     in this case @count may be not aligned. @start + @count

+are

With those fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> + * allowed to be greater than hb->orig_size, but only if @start < hb->=
orig_size
> + * and @start + @count =3D ALIGN_UP(hb->orig_size, granularity).
>   */
>  void hbitmap_reset(HBitmap *hb, uint64_t start, uint64_t count);
> =20
> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
> index 592d8219db..2be56d1597 100644
> --- a/tests/test-hbitmap.c
> +++ b/tests/test-hbitmap.c
> @@ -423,7 +423,7 @@ static void test_hbitmap_granularity(TestHBitmapDat=
a *data,
>      hbitmap_test_check(data, 0);
>      hbitmap_test_set(data, 0, 3);
>      g_assert_cmpint(hbitmap_count(data->hb), =3D=3D, 4);
> -    hbitmap_test_reset(data, 0, 1);
> +    hbitmap_test_reset(data, 0, 2);
>      g_assert_cmpint(hbitmap_count(data->hb), =3D=3D, 2);
>  }
> =20
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index bcc0acdc6a..586920cb52 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -476,6 +476,10 @@ void hbitmap_reset(HBitmap *hb, uint64_t start, ui=
nt64_t count)
>      /* Compute range in the last layer.  */
>      uint64_t first;
>      uint64_t last =3D start + count - 1;
> +    uint64_t gran =3D 1ULL << hb->granularity;
> +
> +    assert(!(start & (gran - 1)));
> +    assert(!(count & (gran - 1)) || (start + count =3D=3D hb->orig_siz=
e));
> =20
>      trace_hbitmap_reset(hb, start, count,
>                          start >> hb->granularity, last >> hb->granular=
ity);
>=20



--qJ5rIzEyMJr5ZtLUfFsBjFsyRBHdzLsEj--

--r0efrs7WsagEdtYEFduGYp3z3BSTkUYsq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1JpjcACgkQ9AfbAGHV
z0CUBAf/ScXgAitZ4siqtqa63CSDkhKMT1A32smL5mraMiFZg4EJjFXJri3FYRMy
Vu4FxjSI5yjwza+/rduBVNoYZwgaA0qOXa1hgUg3Ll8laca47Cw8wqyWxOOHnVaQ
CzsVI+nFHo+z2yeqefAfqeM5RULb3RrxnPByDvBPPjDgtM5zpVvTp3u8kxNnfCVq
s2tZQgWK4TN1VMM2X6ch5j9GPyF4V7H3sWVyCqLLC64kdmhmh3PdRXJ2ylx2pps5
HPOsr0HV10FaEpFyN8RVsEbK1+lu6DLJKZ86TVs0I77lRvSSwakytIwsKNaOHmHT
qBMDjGx/L2NjL9JpKWpP42/dAqsr2Q==
=sHyY
-----END PGP SIGNATURE-----

--r0efrs7WsagEdtYEFduGYp3z3BSTkUYsq--

