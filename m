Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C94C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE2221479
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE2221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hviW0-0002WO-M0
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 09:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39782)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hviVM-00022Y-OG
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hviVL-0006PG-Ik
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hviVI-0006Mb-Vs; Thu, 08 Aug 2019 09:30:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 98BD230BA096;
 Thu,  8 Aug 2019 13:30:51 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C425600C8;
 Thu,  8 Aug 2019 13:30:49 +0000 (UTC)
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 eblake@redhat.com, armbru@redhat.com
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-3-dplotnikov@virtuozzo.com>
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
Message-ID: <8572c241-116d-620d-c001-93cc5afa30cb@redhat.com>
Date: Thu, 8 Aug 2019 15:30:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190704130949.14017-3-dplotnikov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HnzdthL09efCJ0007ohEMw7P5SfJmu6Bl"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 08 Aug 2019 13:30:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qcow2: rework the cluster
 compression routine
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HnzdthL09efCJ0007ohEMw7P5SfJmu6Bl
Content-Type: multipart/mixed; boundary="BkFcUWlZh2KYVdmb95G74htHTdVzzgSNA";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, kwolf@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Cc: den@virtuozzo.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <8572c241-116d-620d-c001-93cc5afa30cb@redhat.com>
Subject: Re: [PATCH v2 2/3] qcow2: rework the cluster compression routine
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-3-dplotnikov@virtuozzo.com>
In-Reply-To: <20190704130949.14017-3-dplotnikov@virtuozzo.com>

--BkFcUWlZh2KYVdmb95G74htHTdVzzgSNA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.07.19 15:09, Denis Plotnikov wrote:
> The patch allow to process image compression type defined
> in the image header and choose an appropriate method for
> image clusters (de)compression.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c | 93 ++++++++++++++++++++++++++++++++++++++++-----------=

>  1 file changed, 73 insertions(+), 20 deletions(-)

I tried my best to rebase this patch on top of the current master, I
hope I did it right.

(A couple of the hunks in this patch are already in master.)

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 8fa932a349..a107f76e98 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -4059,8 +4062,8 @@ static ssize_t qcow2_compress(void *dest, size_t =
dest_size,
>   * Returns: 0 on success
>   *          -1 on fail

This should be fixed to reflect the new return values.

>   */
> -static ssize_t qcow2_decompress(void *dest, size_t dest_size,
> -                                const void *src, size_t src_size)
> +static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
> +                                     const void *src, size_t src_size)=

>  {
>      int ret =3D 0;
>      z_stream strm;

[...]

> @@ -4153,20 +4156,67 @@ qcow2_co_do_compress(BlockDriverState *bs, void=
 *dest, size_t dest_size,
>      return arg.ret;
>  }
> =20
> +/*
> + * qcow2_co_compress()
> + *
> + * Compress @src_size bytes of data using the compression
> + * method defined by the image compression type
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: 0 on success
> + *          a negative error code on fail
> + */
>  static ssize_t coroutine_fn
>  qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>                    const void *src, size_t src_size)
>  {
> -    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
> -                                qcow2_compress);
> +    BDRVQcow2State *s =3D bs->opaque;
> +    Qcow2CompressFunc fn;
> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        fn =3D qcow2_zlib_compress;
> +        break;
> +
> +    default:
> +        return -ENOTSUP;

A plain abort() would work, too.  (Your choice.)

> +    }
> +
> +    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn=
);
>  }
> =20
> +/*
> + * qcow2_co_decompress()
> + *
> + * Decompress some data (not more than @src_size bytes) to produce exa=
ctly
> + * @dest_size bytes using the compression method defined by the image
> + * compression type
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: 0 on success
> + *          a negative error code on fail
> + */
>  static ssize_t coroutine_fn
>  qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size=
,
>                      const void *src, size_t src_size)
>  {
> -    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
> -                                qcow2_decompress);
> +    BDRVQcow2State *s =3D bs->opaque;
> +    Qcow2CompressFunc fn;
> +
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        fn =3D qcow2_zlib_decompress;
> +        break;
> +
> +    default:
> +        return -ENOTSUP;

Same here.

Max

> +    }
> +
> +    return qcow2_co_do_compress(bs, dest, dest_size, src, src_size, fn=
);
>  }


--BkFcUWlZh2KYVdmb95G74htHTdVzzgSNA--

--HnzdthL09efCJ0007ohEMw7P5SfJmu6Bl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1MJAcACgkQ9AfbAGHV
z0Au1Qf/W/RPdbNMMRb7QwAvOFF4k2dc43LKB+HuyPPmULEF50+cIX9FYugYBssS
wvum66eTtgOlrib/xrtiuOu9Mctl+6oPrSyyjD9OW+qGv+dFT7LBsCaPPcaGkEDA
BbMbETC1oUPUJc++a/pO/tqWuycM7sG4hplux2UeJ16X5QzxyAOV6ngmn2G+XonN
cvcXeaytS5Fj6W7hbXqWwVafzOLFG0j6p4j8gGq81Oxr5I0pL6N9xwI2TdwOGvdb
HVPeRia7YZ46WiRWkfUvFjtY9HLtqh+dKIUUdQMkGu8csts/zRFnxiarkKsFqQ72
xBdKDD1dGObT0nyJPealH5hgCe9tgA==
=c+Jl
-----END PGP SIGNATURE-----

--HnzdthL09efCJ0007ohEMw7P5SfJmu6Bl--

