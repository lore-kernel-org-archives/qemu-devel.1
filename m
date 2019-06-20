Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E9AC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 16:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C4C20679
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 16:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C4C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49922 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzXm-0003DP-9n
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 12:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdzJg-0000xb-JB
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdzJZ-0000sI-Pk
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:49:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdzHr-00075F-My; Thu, 20 Jun 2019 11:47:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 02725C057E7D;
 Thu, 20 Jun 2019 15:47:25 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E5041001E73;
 Thu, 20 Jun 2019 15:47:18 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-6-jsnow@redhat.com>
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
Message-ID: <8f3822dc-b3a5-994a-6fd7-d7291954789c@redhat.com>
Date: Thu, 20 Jun 2019 17:47:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620010356.19164-6-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GLOlMofvbWhPsq1LRl4CgfSEijtdsAaru"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 20 Jun 2019 15:47:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 05/12] hbitmap: enable merging across
 granularities
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GLOlMofvbWhPsq1LRl4CgfSEijtdsAaru
Content-Type: multipart/mixed; boundary="JU6rGCyG6MRiFjCwSIIPGMztDgEbPiNDb";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 eblake@redhat.com, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <8f3822dc-b3a5-994a-6fd7-d7291954789c@redhat.com>
Subject: Re: [PATCH 05/12] hbitmap: enable merging across granularities
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-6-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-6-jsnow@redhat.com>

--JU6rGCyG6MRiFjCwSIIPGMztDgEbPiNDb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 03:03, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  util/hbitmap.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 45d1725daf..0d6724b7bc 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -777,7 +777,17 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
> =20
>  bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b)
>  {
> -    return (a->size =3D=3D b->size) && (a->granularity =3D=3D b->granu=
larity);
> +    return (a->size =3D=3D b->size);
> +}
> +
> +static void hbitmap_sparse_merge(HBitmap *dst, const HBitmap *src)
> +{
> +    uint64_t offset =3D 0;
> +    uint64_t count =3D src->orig_size;
> +
> +    while (hbitmap_next_dirty_area(src, &offset, &count)) {
> +        hbitmap_set(dst, offset, count);
> +    }
>  }
> =20
>  /**
> @@ -804,6 +814,16 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap=
 *b, HBitmap *result)
>          return true;
>      }
> =20
> +    if (a->size !=3D b->size) {

Don=E2=80=99t you mean s/size/granularity/?

Right now, this is dead code, which leads me to asking for a test.
(Well, no, I would=E2=80=99ve asked anyway.)

Max

> +        if (a !=3D result) {
> +            hbitmap_sparse_merge(result, a);
> +        }
> +        if (b !=3D result) {
> +            hbitmap_sparse_merge(result, b);
> +        }
> +        return true;
> +    }
> +
>      /* This merge is O(size), as BITS_PER_LONG and HBITMAP_LEVELS are =
constant.
>       * It may be possible to improve running times for sparsely popula=
ted maps
>       * by using hbitmap_iter_next, but this is suboptimal for dense ma=
ps.
>=20



--JU6rGCyG6MRiFjCwSIIPGMztDgEbPiNDb--

--GLOlMofvbWhPsq1LRl4CgfSEijtdsAaru
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0LqoQACgkQ9AfbAGHV
z0DarQgAwypaDBPCk67E+UqL67Y/vbLSuAJuXK4CmWqjl1mgD4ZDmUDHt8sXSbyz
FHr22OH+CacDsd0h3j85s+D9elPC4nzToVlZEt/QwnNzmwPDBWC7MV6xESbMMdTa
rzF4M39Y0kgL2YrmYQWroemD1S1lum/7vCQSsTHoAarDz6cCKWJYa6swOFqDjLye
900YK2H7cude6eqGxAMJ+ThM81GLDOTiLuRxNbsphqNaBGndifimDoH4H3YAi0/q
Fs7f9im3Me2ClXkebmFnufiFj2P6UTxP2N5J/eJviemFD5Vv7tmfuo7yHSskwgPq
sMG1O5MbuN0dGakjJZdGvp/JvnscUg==
=0i23
-----END PGP SIGNATURE-----

--GLOlMofvbWhPsq1LRl4CgfSEijtdsAaru--

