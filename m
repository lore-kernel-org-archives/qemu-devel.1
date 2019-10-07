Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F421AECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA30F21721
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA30F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVLw-0000q9-MF
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iHVFn-0001sU-F0
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iHVFm-00062f-7B
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:48:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iHVFj-0005yn-I0; Mon, 07 Oct 2019 11:48:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFCECC049E1A;
 Mon,  7 Oct 2019 15:48:50 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E65085D9CC;
 Mon,  7 Oct 2019 15:48:46 +0000 (UTC)
Subject: Re: [PATCH 6/6] block/block-copy: increase buffered copy request
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191003171539.12327-1-vsementsov@virtuozzo.com>
 <20191003171539.12327-7-vsementsov@virtuozzo.com>
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
Message-ID: <441fc41e-0432-978a-9568-60b651cbf25b@redhat.com>
Date: Mon, 7 Oct 2019 17:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003171539.12327-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IGDOpKAG81JZzKypHCpbzYUQdGTZ3XlOG"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 07 Oct 2019 15:48:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IGDOpKAG81JZzKypHCpbzYUQdGTZ3XlOG
Content-Type: multipart/mixed; boundary="EkYls8C4E5UJ9XdzSyWfhDu9gMoKZXn5v"

--EkYls8C4E5UJ9XdzSyWfhDu9gMoKZXn5v
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.10.19 19:15, Vladimir Sementsov-Ogievskiy wrote:
> No reason to limit buffered copy to one cluster. Let's allow up to 1
> MiB.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block-copy.h |  2 +-
>  block/block-copy.c         | 44 +++++++++++++++++++++++++++-----------=

>  2 files changed, 32 insertions(+), 14 deletions(-)


Er, oops, looks like I was a bit quick there...

> @@ -100,17 +101,28 @@ BlockCopyState *block_copy_state_new(BdrvChild *s=
ource, BdrvChild *target,
>          .mem =3D qemu_co_shared_amount_new(BLOCK_COPY_MAX_MEM),
>      };
> =20
> -    s->copy_range_size =3D QEMU_ALIGN_DOWN(max_transfer, cluster_size)=
,
> -    /*
> -     * Set use_copy_range, consider the following:
> -     * 1. Compression is not supported for copy_range.
> -     * 2. copy_range does not respect max_transfer (it's a TODO), so w=
e factor
> -     *    that in here. If max_transfer is smaller than the job->clust=
er_size,
> -     *    we do not use copy_range (in that case it's zero after align=
ing down
> -     *    above).
> -     */
> -    s->use_copy_range =3D
> -        !(write_flags & BDRV_REQ_WRITE_COMPRESSED) && s->copy_range_si=
ze > 0;
> +    if (max_transfer < cluster_size) {
> +        /*
> +         * copy_range does not respect max_transfer. We don't want to =
bother
> +         * with requests smaller than block-copy cluster size, so fall=
back to
> +         * buffered copying (read and write respect max_transfer on th=
eir
> +         * behalf).
> +         */
> +        s->use_copy_range =3D false;
> +        s->copy_size =3D cluster_size;
> +    } else if (write_flags & BDRV_REQ_WRITE_COMPRESSED) {
> +        /* Compression is not supported for copy_range */
> +        s->use_copy_range =3D false;
> +        s->copy_size =3D MAX(cluster_size, BLOCK_COPY_MAX_BUFFER);
> +    } else {
> +        /*
> +         * copy_range does not respect max_transfer (it's a TODO), so =
we factor
> +         * that in here.
> +         */
> +        s->use_copy_range =3D true;
> +        s->copy_size =3D MIN(MAX(cluster_size, BLOCK_COPY_MAX_COPY_RAN=
GE),

This is already part of max_transfer, isn=E2=80=99t it?

(That doesn=E2=80=99t make it wrong, but I think max_transfer will always=
 be
less than or equal to MAX(cluster_size, BLOCK_COPY_MAX_COPY_RANGE) anyway=
=2E)

Max

> +                           QEMU_ALIGN_DOWN(max_transfer, cluster_size)=
);


--EkYls8C4E5UJ9XdzSyWfhDu9gMoKZXn5v--

--IGDOpKAG81JZzKypHCpbzYUQdGTZ3XlOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2bXl0ACgkQ9AfbAGHV
z0Cccgf/fVCWEiGWvL3pIu4g/BTz8scnhzB9u+G0BL+ugdi741jc0UE/RcCPPM3V
lS4U5+cTiYPfEKAwByzFOtIUyo2fvcvvq2u4pxT7otOFk1b/RuRrLTqa4s0BJXxP
qqW0SMvR5cC21BgQY4H5Z9pXXqQ8+91loTxIjnkkPEw0Eg1e8xf/ANSRhpfP5TGi
wsHCX38ngZycyzFsW2SNWNrFewHoUJnQnTIGT5J4s6cDvkyDwpNtZwhHxsm2yQn0
lZIuQKFXdz2DGicPThqmWxeZBUejKkBsVjQDHpg5KOjh7yBwB54PCFzte0VI+PBr
fmtYcHNcmpA5BzJxWxaM/xjd2BUM0g==
=ozrR
-----END PGP SIGNATURE-----

--IGDOpKAG81JZzKypHCpbzYUQdGTZ3XlOG--

