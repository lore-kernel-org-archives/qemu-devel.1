Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F33C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 17:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1638218A3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 17:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1638218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj5A7-0002fk-Vh
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 13:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51043)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hj57X-0001Ai-AH
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 13:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hj57W-00025A-7w
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 13:02:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hj57R-000220-DB; Thu, 04 Jul 2019 13:02:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1741B3082A9A;
 Thu,  4 Jul 2019 17:01:52 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-93.brq.redhat.com
 [10.40.204.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F0FC18FCC;
 Thu,  4 Jul 2019 17:01:44 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-11-jsnow@redhat.com>
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
Message-ID: <6966e086-c419-ca94-a568-9cde01b1ff78@redhat.com>
Date: Thu, 4 Jul 2019 19:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703215542.16123-11-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bGpL3IBfN8NByV3WRi7t2OdbCVbqPYH12"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 04 Jul 2019 17:01:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 10/18] block/dirty-bitmap: add
 bdrv_dirty_bitmap_get
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
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bGpL3IBfN8NByV3WRi7t2OdbCVbqPYH12
Content-Type: multipart/mixed; boundary="8qMrxtRzV700MjuMFXlVmUPtECJ54b99i";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, vsementsov@virtuozzo.com,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <6966e086-c419-ca94-a568-9cde01b1ff78@redhat.com>
Subject: Re: [PATCH v2 10/18] block/dirty-bitmap: add bdrv_dirty_bitmap_get
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-11-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-11-jsnow@redhat.com>

--8qMrxtRzV700MjuMFXlVmUPtECJ54b99i
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 23:55, John Snow wrote:
> Add a public interface for get. While we're at it,
> rename "bdrv_get_dirty_bitmap_locked" to "bdrv_dirty_bitmap_get_locked"=
=2E
>=20
> (There are more functions to rename to the bdrv_dirty_bitmap_VERB form,=

> but they will wait until the conclusion of this series.)
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c         | 18 +++++++++++-------
>  block/mirror.c               |  2 +-
>  include/block/dirty-bitmap.h |  4 ++--
>  migration/block.c            |  5 ++---
>  nbd/server.c                 |  2 +-
>  5 files changed, 17 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index b0f76826b3..97541521ab 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -509,14 +509,18 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(Bloc=
kDriverState *bs)
>  }
> =20
>  /* Called within bdrv_dirty_bitmap_lock..unlock */
> -bool bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitm=
ap,
> -                           int64_t offset)
> +bool bdrv_dirty_bitmap_get_locked(BdrvDirtyBitmap *bitmap, int64_t off=
set)
>  {
> -    if (bitmap) {
> -        return hbitmap_get(bitmap->bitmap, offset);
> -    } else {
> -        return false;
> -    }
> +    return hbitmap_get(bitmap->bitmap, offset);
> +}
> +
> +bool bdrv_dirty_bitmap_get(BdrvDirtyBitmap *bitmap, int64_t offset) {

I=E2=80=99m sure Patchew has told this already, but this is not Rust yet.=


With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +    bool ret;
> +    bdrv_dirty_bitmap_lock(bitmap);
> +    ret =3D bdrv_dirty_bitmap_get_locked(bitmap, offset);
> +    bdrv_dirty_bitmap_unlock(bitmap);
> +
> +    return ret;
>  }
> =20
>  /**


--8qMrxtRzV700MjuMFXlVmUPtECJ54b99i--

--bGpL3IBfN8NByV3WRi7t2OdbCVbqPYH12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0eMPcACgkQ9AfbAGHV
z0CA7Qf9HMRt17aJd5LPYGEkLRZjR2k6yqfSMyd49ZtX27XFuzFNOaQBs006jzRw
td7093MXrO+fmZ/gtodRkbwrvV0CtUV16G4C4vU70COfbcYMOabsKoBhnCuLt7F+
nN+KZhBXSZ+xR62LrT2BnrMahmPIBi3vmyJRO/wGCywCGoeP+Rk9GkBiF4MKrxOE
CmeKgyPh1tx9EvhPioV2F0uO1joIvgPghESfl3qxLe2FW57pnDuj/vjMQ238PLyy
R2QI4ZhfptKmB0zp+YU6L8t745X1z7ckOS2AZkEDELgaU+kes216H8IXgJHjOsRH
RcpoaZE7Y1UVbr/cCSCaPVg6cdln/w==
=ribc
-----END PGP SIGNATURE-----

--bGpL3IBfN8NByV3WRi7t2OdbCVbqPYH12--

