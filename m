Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23242C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFD920693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFD920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnMmY-0000rH-9q
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 08:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33606)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnMmN-0000N1-Q7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnMmM-0005Dr-Kw
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:41:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnMmK-0005AG-2E; Tue, 16 Jul 2019 08:41:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5456B307CDD1;
 Tue, 16 Jul 2019 12:41:55 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AECE95D9D6;
 Tue, 16 Jul 2019 12:41:50 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190716081516.27374-1-mlevitsk@redhat.com>
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
Message-ID: <ace970e5-7f1a-d693-952e-3d16da1d0bfe@redhat.com>
Date: Tue, 16 Jul 2019 14:41:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716081516.27374-1-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HDfXSxB8bv60fOaxYXn2z9TdLrQkTHcRD"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 16 Jul 2019 12:41:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] LUKS: support preallocation
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HDfXSxB8bv60fOaxYXn2z9TdLrQkTHcRD
Content-Type: multipart/mixed; boundary="uUFPYqmzK3YdsvMmi5B1fFVC0zr5etQq6";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Message-ID: <ace970e5-7f1a-d693-952e-3d16da1d0bfe@redhat.com>
Subject: Re: [PATCH v4] LUKS: support preallocation
References: <20190716081516.27374-1-mlevitsk@redhat.com>
In-Reply-To: <20190716081516.27374-1-mlevitsk@redhat.com>

--uUFPYqmzK3YdsvMmi5B1fFVC0zr5etQq6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 10:15, Maxim Levitsky wrote:
> preallocation=3Doff and preallocation=3Dmetadata
> both allocate luks header only, and preallocation=3Dfalloc/full
> is passed to underlying file.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534951
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/crypto.c       | 29 ++++++++++++++++++++++++++---
>  qapi/block-core.json |  5 ++++-
>  2 files changed, 30 insertions(+), 4 deletions(-)
>=20
>=20
> Changes from V3: updated the blockdev-create description

Looks good functionally, but there is a syntax problem:

> diff --git a/block/crypto.c b/block/crypto.c
> index 8237424ae6..034a645652 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c

[...]

> @@ -515,8 +523,11 @@ block_crypto_co_create_luks(BlockdevCreateOptions =
*create_options, Error **errp)
>          .u.luks =3D *qapi_BlockdevCreateOptionsLUKS_base(luks_opts),
>      };
> =20
> +    if (luks_opts->has_preallocation)
> +        preallocation =3D luks_opts->preallocation;

This lacks curly brackets.

> +
>      ret =3D block_crypto_co_create_generic(bs, luks_opts->size, &creat=
e_opts,
> -                                         errp);
> +                                         preallocation, errp);
>      if (ret < 0) {
>          goto fail;
>      }

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..9c04d83fa2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4205,13 +4205,16 @@
>  #
>  # @file             Node to create the image format on
>  # @size             Size of the virtual disk in bytes
> +# @preallocation    Preallocation mode for the new image (default: off=
;
> +#                   allowed values: off/metadata/falloc/full (since: 4=
=2E2)

Also, this lacks a closing parenthesis somewhere.

Max

>  #
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsLUKS',
>    'base': 'QCryptoBlockCreateOptionsLUKS',
>    'data': { 'file':             'BlockdevRef',
> -            'size':             'size' } }
> +            'size':             'size',
> +            '*preallocation':   'PreallocMode' } }
> =20
>  ##
>  # @BlockdevCreateOptionsNfs:
>=20



--uUFPYqmzK3YdsvMmi5B1fFVC0zr5etQq6--

--HDfXSxB8bv60fOaxYXn2z9TdLrQkTHcRD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0txgwACgkQ9AfbAGHV
z0DJjwgAoJaImOLlaiUtU8QMR2AUDSmEOWR4ePo/bGX6Oz3gcni7EYIeWdofe6Hc
e46OVlWylYHwKFSo3afXwoatTT5a0kr5aklA2Ux9/+rMQdhhCmdLz5HmXd21BzTe
Tvcw+WEcifY5ehwE4K1/qPFqSE3PE9gJY+0QE9DHdUIp78uLWNbMqCO8+8bOl4Tz
lvj8TK5a8NsmvK2UrrCJQYHvFxZgm1cUyfzY2ZILHlgJB6nBQt/rXrE3hk0DRxa0
Trvm7AF6eT5K83rlKS+P8msdwFvf9rnT7EVcizBJFJjBuAEeOlEoVSIoHOwBBtel
9hEaGl9ekwiJzOMpt/UvgIxAVOKPgQ==
=zuKJ
-----END PGP SIGNATURE-----

--HDfXSxB8bv60fOaxYXn2z9TdLrQkTHcRD--

