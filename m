Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653FAC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B19E21019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B19E21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZNK-0007ek-Ia
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlZMk-0006sD-EE
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlZMi-0000Wr-Qr
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:44:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlZMa-0000QV-Fw; Thu, 11 Jul 2019 09:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE2A7307D85E;
 Thu, 11 Jul 2019 13:43:54 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B56C51001947;
 Thu, 11 Jul 2019 13:43:53 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <096a8bcf57997c594e1d5d7ea9606029909b81fc.camel@redhat.com>
 <20190711091127.12988-1-mlevitsk@redhat.com>
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
Message-ID: <aab36239-5717-e918-05c9-1876d87fd7a8@redhat.com>
Date: Thu, 11 Jul 2019 15:43:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190711091127.12988-1-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SzKMKSXNVjAzTtaC23C4FhbpxaYrQiL1Y"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 11 Jul 2019 13:43:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] LUKS: support preallocation in qemu-img
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SzKMKSXNVjAzTtaC23C4FhbpxaYrQiL1Y
Content-Type: multipart/mixed; boundary="iz0BN6zH8ALR4Ij9QZkJuYpfEwzaYXC7f";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <aab36239-5717-e918-05c9-1876d87fd7a8@redhat.com>
Subject: Re: [PATCH v2] LUKS: support preallocation in qemu-img
References: <096a8bcf57997c594e1d5d7ea9606029909b81fc.camel@redhat.com>
 <20190711091127.12988-1-mlevitsk@redhat.com>
In-Reply-To: <20190711091127.12988-1-mlevitsk@redhat.com>

--iz0BN6zH8ALR4Ij9QZkJuYpfEwzaYXC7f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.07.19 11:11, Maxim Levitsky wrote:
> preallocation=3Doff and preallocation=3Dmetadata
> both allocate luks header only, and preallocation=3Dfalloc/full
> is passed to underlying file.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/crypto.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

FWIW, do you see the implementation of block_crypto_co_truncate()?
Like, how it just passes preallocation requests through to the
underlying layer?  How I said it shouldn=E2=80=99t be done?

Yes, that was me, in commit 7ea37c30660.

So, er, yeah.

> diff --git a/block/crypto.c b/block/crypto.c
> index 8237424ae6..cbc291301e 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
[...]

> @@ -534,12 +537,28 @@ static int coroutine_fn block_crypto_co_create_op=
ts_luks(const char *filename,
>      QCryptoBlockCreateOptions *create_opts =3D NULL;
>      BlockDriverState *bs =3D NULL;
>      QDict *cryptoopts;
> +    PreallocMode prealloc;
> +    char *buf =3D NULL;
>      int64_t size;
>      int ret;
> +    Error *local_err =3D NULL;
> =20
>      /* Parse options */
>      size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
> =20
> +    buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
> +    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, buf,
> +                                   PREALLOC_MODE_OFF, &local_err);

Please align such lines to the opening parenthesis.

> +    g_free(buf);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return -EINVAL;
> +    }
> +
> +    if (prealloc =3D=3D PREALLOC_MODE_METADATA) {
> +        prealloc  =3D PREALLOC_MODE_OFF;

There is one space too many here.

> +    }
> +

I think you also need to add a @preallocation parameter to
BlockdevCreateOptionsLUKS and handle it in block_crypto_co_create_luks().=


Max

>      cryptoopts =3D qemu_opts_to_qdict_filtered(opts, NULL,
>                                               &block_crypto_create_opts=
_luks,
>                                               true);


--iz0BN6zH8ALR4Ij9QZkJuYpfEwzaYXC7f--

--SzKMKSXNVjAzTtaC23C4FhbpxaYrQiL1Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0nPRMACgkQ9AfbAGHV
z0B6owf6AqW8ZW73LeHlZegrei/MuH8ji+0dEW/Hl7T4nQ7455DjLBM+mw+Bd71P
F4KN0GJdwEZJAUBx9FQAnBY/zWJrzS0Lvj/38QEvvEcOqD40xzVHfhxdZjoXpt9V
MAbYvOWsGjBgvZ1MVxyScXTpCUMQh8hn8E9SLU7VdwVhNvdmIhexE4op1znwab1K
L1UKAfDe3MnWkxfpG9wZ7PhcdDHRGFGpjErHUwQcjC64OoASE/kqXr8cj28DKTsL
G8Nyqi+TxdQ1I28o+wwwUykIVjalRTVKksE6OVsyjTSFUNddw6u2SkclQTZghrGA
Z9fY8WcFe4kw+fHzEfN9g3pGf9A2LQ==
=I6bH
-----END PGP SIGNATURE-----

--SzKMKSXNVjAzTtaC23C4FhbpxaYrQiL1Y--

