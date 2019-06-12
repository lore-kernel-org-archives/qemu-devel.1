Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22947C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC48B208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC48B208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbCOt-0006qx-Rb
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 19:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50509)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBkk-00009T-TI
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBYa-0003Ol-8Q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:17:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBYW-0003Ib-8n; Wed, 12 Jun 2019 18:17:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 751133162913;
 Wed, 12 Jun 2019 22:17:17 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 314DB7E692;
 Wed, 12 Jun 2019 22:17:15 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-23-mreitz@redhat.com>
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
Message-ID: <1ff98c9b-b5aa-686c-a130-cd4783a36130@redhat.com>
Date: Thu, 13 Jun 2019 00:17:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612221004.2317-23-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yvpUURpflA6uCcKzSJGlV49UA8YIeyNN9"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 12 Jun 2019 22:17:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 22/42] block: Use CAFs in
 bdrv_get_allocated_file_size()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yvpUURpflA6uCcKzSJGlV49UA8YIeyNN9
Content-Type: multipart/mixed; boundary="vvbFvFNSiHXc6iw2r10WRdmKvAmOb00CH";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1ff98c9b-b5aa-686c-a130-cd4783a36130@redhat.com>
Subject: Re: [PATCH v5 22/42] block: Use CAFs in
 bdrv_get_allocated_file_size()
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-23-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-23-mreitz@redhat.com>

--vvbFvFNSiHXc6iw2r10WRdmKvAmOb00CH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.06.19 00:09, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 11b7ba8cf6..856d9b58be 100644
> --- a/block.c
> +++ b/block.c
> @@ -4511,15 +4511,37 @@ exit:
>  int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
>  {
>      BlockDriver *drv =3D bs->drv;
> +    BlockDriverState *storage_bs, *metadata_bs;
> +
>      if (!drv) {
>          return -ENOMEDIUM;
>      }
> +
>      if (drv->bdrv_get_allocated_file_size) {
>          return drv->bdrv_get_allocated_file_size(bs);
>      }
> -    if (bs->file) {
> -        return bdrv_get_allocated_file_size(bs->file->bs);
> +
> +    storage_bs =3D bdrv_storage_bs(bs);
> +    metadata_bs =3D bdrv_metadata_bs(bs);
> +
> +    if (storage_bs) {
> +        int64_t data_size, metadata_size =3D 0;
> +
> +        data_size =3D bdrv_get_allocated_file_size(storage_bs);
> +        if (data_size < 0) {
> +            return data_size;
> +        }
> +
> +        if (storage_bs !=3D metadata_bs) {

Let this be a lesson to you: If you run all tests, then prepare to send
the series and just change =E2=80=9Ca minor thing=E2=80=9D, you really sh=
ould rerun the
tests.  Well, I should have, at least.

That should read =E2=80=9Cif (metadata_bs && storage_bs !=3D metadata_bs)=
 {=E2=80=9D.

(Damn.  Why did I only remember to do so literally five minutes after
sending the series?)

Max

> +            metadata_size =3D bdrv_get_allocated_file_size(metadata_bs=
);
> +            if (metadata_size < 0) {
> +                return metadata_size;
> +            }
> +        }
> +
> +        return data_size + metadata_size;
>      }
> +
>      return -ENOTSUP;
>  }
> =20
>=20



--vvbFvFNSiHXc6iw2r10WRdmKvAmOb00CH--

--yvpUURpflA6uCcKzSJGlV49UA8YIeyNN9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0BeeoACgkQ9AfbAGHV
z0APaAf/RyMb9f1z8VM1ErwqPmzNV3EXE1Sqj4hlWph8mH5yJ7g6yqgYSgxVXAAa
IXtSU/xhIkchuI/fdScBJgyPgyKHneKQceeKNDgXI9N1KJcXxYxIjozPSNa931BT
aHIsGq0hVxjqAYV55ruUZNPlkqVb2h9sdJyOpFnvixfWs0bR+hk9p4qKAgGEWbne
ZzYVfTBKvTFIud5puG6QChRYYqfUEzOam+rnSLgZWAgDPYQbU2H36d9keZWnLc+f
ibt0tmxC0EayZQRdO8+LO9NL4xyzqV8FFLOp1QxsYd5lcXZRgsZAGG065T+vknyj
SHQ2EyUUqp0gh+f+gWo6q5jW/A2qQw==
=nyUx
-----END PGP SIGNATURE-----

--yvpUURpflA6uCcKzSJGlV49UA8YIeyNN9--

