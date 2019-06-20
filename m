Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A872C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FDB2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FDB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzLW-0002TD-CO
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53039)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdzIq-0000By-Ce
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdzAF-0006Mf-4e
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:39:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34075)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdzAD-0005xz-PJ; Thu, 20 Jun 2019 11:39:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 11EA130C0DDD;
 Thu, 20 Jun 2019 15:39:23 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 012955D9C6;
 Thu, 20 Jun 2019 15:39:13 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-5-jsnow@redhat.com>
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
Message-ID: <5a326b6e-eb17-60a5-a656-286a087cd939@redhat.com>
Date: Thu, 20 Jun 2019 17:39:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620010356.19164-5-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iFNHZ7xf7aAOBKyTeQlUzhKIvNOnDgadz"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 20 Jun 2019 15:39:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 04/12] hbitmap: Fix merge when b is empty,
 and result is not an alias of a
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
--iFNHZ7xf7aAOBKyTeQlUzhKIvNOnDgadz
Content-Type: multipart/mixed; boundary="d7qWqHntNzl7zSkGk484CLSh515HoM3TA";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 eblake@redhat.com, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <5a326b6e-eb17-60a5-a656-286a087cd939@redhat.com>
Subject: Re: [PATCH 04/12] hbitmap: Fix merge when b is empty, and result is
 not an alias of a
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-5-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-5-jsnow@redhat.com>

--d7qWqHntNzl7zSkGk484CLSh515HoM3TA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 03:03, John Snow wrote:
> Nobody calls the function like this currently, but we neither prohibit
> or cope with this behavior. I decided to make the function cope with it=
=2E
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  util/hbitmap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 7905212a8b..45d1725daf 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -781,8 +781,9 @@ bool hbitmap_can_merge(const HBitmap *a, const HBit=
map *b)
>  }
> =20
>  /**
> - * Given HBitmaps A and B, let A :=3D A (BITOR) B.
> - * Bitmap B will not be modified.
> + * Given HBitmaps A and B, let R :=3D A (BITOR) B.
> + * Bitmaps A and B will not be modified,
> + *     except when bitmap R is an alias of A or B.
>   *
>   * @return true if the merge was successful,
>   *         false if it was not attempted.
> @@ -797,7 +798,9 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap =
*b, HBitmap *result)
>      }
>      assert(hbitmap_can_merge(b, result));
> =20
> -    if (hbitmap_count(b) =3D=3D 0) {
> +    if ((!hbitmap_count(a) && result =3D=3D b) ||
> +        (!hbitmap_count(b) && result =3D=3D a) ||
> +        (!hbitmap_count(a) && !hbitmap_count(b))) {
>          return true;
>      }

The rest of this function completely overwrites the @result bitmap.
Therefor, @result does not need to be cleared when calling this function.=


Therfore, hbitmap_merge(hbitmap_alloc(), hbitmap_alloc(), output) should
actually clear @output, I think.

Max


--d7qWqHntNzl7zSkGk484CLSh515HoM3TA--

--iFNHZ7xf7aAOBKyTeQlUzhKIvNOnDgadz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0LqKAACgkQ9AfbAGHV
z0AiNAf9ENXhpJTHfUsbHnc9/SrkRzd9SYOYXjgn3rMQpXOBA3auqfGE3/zpTx24
vfhy1qknBJPKvyyWDnFm/d+YwB+HVTQP9NTGs5qdz2VHLXRhPIcEbDqUiAifSMN3
uTzL05I05EZFfolPq0FCxpw8l8cNBJ+DYzPCaxUorXFtae5C1JiRUz57h0FoNZsz
D2pVX+lm4ljR/GO+GrAzvy2+7GjvfNVm6QvADLF3StC7f7GiQgwTuorpwQjAsM4y
UOGy+r+0Y8KpCxHeAOfqPhZYqReDc+Rh2Sz20RF8qPtOEyZ4XDcqTJakxLVcz/UM
35iWfTPcBlf+VgEOXGcsul5CSgYd3A==
=Y6By
-----END PGP SIGNATURE-----

--iFNHZ7xf7aAOBKyTeQlUzhKIvNOnDgadz--

