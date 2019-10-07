Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EB8C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D3A9206C2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3A9206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHV0I-0005El-Gx
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iHUux-0001L1-Rh
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iHUuv-00044d-RZ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iHUup-000438-U6; Mon, 07 Oct 2019 11:27:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B2D4315C030;
 Mon,  7 Oct 2019 15:27:15 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94DF85D9CC;
 Mon,  7 Oct 2019 15:27:13 +0000 (UTC)
Subject: Re: [PATCH 5/6] block/block-copy: add memory limit
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191003171539.12327-1-vsementsov@virtuozzo.com>
 <20191003171539.12327-6-vsementsov@virtuozzo.com>
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
Message-ID: <8aa011d7-3f11-2df5-d77e-5c5176ab63ed@redhat.com>
Date: Mon, 7 Oct 2019 17:27:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003171539.12327-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cVkkcEO2DDbP5Zbb8803lDcaYv4c1A1pQ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 07 Oct 2019 15:27:15 +0000 (UTC)
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
--cVkkcEO2DDbP5Zbb8803lDcaYv4c1A1pQ
Content-Type: multipart/mixed; boundary="resBEnXDD79a3wGe4X7tMgUCixsn6vLrF"

--resBEnXDD79a3wGe4X7tMgUCixsn6vLrF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.10.19 19:15, Vladimir Sementsov-Ogievskiy wrote:
> Currently total allocation for parallel requests to block-copy instance=

> is unlimited. Let's limit it to 128 MiB.
>=20
> For now block-copy is used only in backup, so actually we limit total
> allocation for backup job.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block-copy.h | 3 +++
>  block/block-copy.c         | 5 +++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index e2e135ff1b..bb666e7068 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h
> @@ -16,6 +16,7 @@
>  #define BLOCK_COPY_H
> =20
>  #include "block/block.h"
> +#include "qemu/co-shared-amount.h"
> =20
>  typedef struct BlockCopyInFlightReq {
>      int64_t start_byte;
> @@ -69,6 +70,8 @@ typedef struct BlockCopyState {
>       */
>      ProgressResetCallbackFunc progress_reset_callback;
>      void *progress_opaque;
> +
> +    QemuCoSharedAmount *mem;
>  } BlockCopyState;
> =20
>  BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *tar=
get,
> diff --git a/block/block-copy.c b/block/block-copy.c
> index cc49d2345d..e700c20d0f 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -21,6 +21,7 @@
>  #include "qemu/units.h"
> =20
>  #define BLOCK_COPY_MAX_COPY_RANGE (16 * MiB)
> +#define BLOCK_COPY_MAX_MEM (128 * MiB)
> =20
>  static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState =
*s,
>                                                         int64_t start,
> @@ -64,6 +65,7 @@ void block_copy_state_free(BlockCopyState *s)
>      }
> =20
>      bdrv_release_dirty_bitmap(s->source->bs, s->copy_bitmap);
> +    qemu_co_shared_amount_free(s->mem);
>      g_free(s);
>  }
> =20
> @@ -95,6 +97,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *sourc=
e, BdrvChild *target,
>          .cluster_size =3D cluster_size,
>          .len =3D bdrv_dirty_bitmap_size(copy_bitmap),
>          .write_flags =3D write_flags,
> +        .mem =3D qemu_co_shared_amount_new(BLOCK_COPY_MAX_MEM),
>      };
> =20
>      s->copy_range_size =3D QEMU_ALIGN_DOWN(max_transfer, cluster_size)=
,
> @@ -316,7 +319,9 @@ int coroutine_fn block_copy(BlockCopyState *s,
> =20
>          bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - sta=
rt);
> =20
> +        qemu_co_get_amount(s->mem, chunk_end - start);

Now that I see it like this, maybe the name is too short.  This sounds
like it was trying to get some amount of coroutines.

Would =E2=80=9Cqemu_co_get_from_shared_amount=E2=80=9D be too long?  (Som=
ething like
qemu_co_sham_alloc() would be funny, but maybe not.  :-)  Or maybe
exactly because it=E2=80=9Ds funny.)

Max

>          ret =3D block_copy_do_copy(s, start, chunk_end, error_is_read)=
;
> +        qemu_co_put_amount(s->mem, chunk_end - start);
>          if (ret < 0) {
>              bdrv_set_dirty_bitmap(s->copy_bitmap, start, chunk_end - s=
tart);
>              break;
>=20



--resBEnXDD79a3wGe4X7tMgUCixsn6vLrF--

--cVkkcEO2DDbP5Zbb8803lDcaYv4c1A1pQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2bWVAACgkQ9AfbAGHV
z0AqIQgAo5SYPSbQJ95Y+e4GeRj2YZ8FoA9WYw0b4rUwYUFm7zesjZUBvdHKsPfW
as75/+McPd38bx28RkCo/wZjncVaBEuIPLGGAeO92TxlNIPUv6JKsUyZZtWXm/h2
D2+ElJpJLe+mG4nKr0wYNLjYYVYvqirywrPjPZymNnkt21gT6Yrhvol43ViMTMX0
EcEbRPKZJjZ1hwWZQZt6gufHeFO1zf1TvCx3up6oaXsmzNTI/sDyZ4oQIxBrPUHT
lldpj8NveIIGKyUjzyHURwm0UakTg9YWUNOnFfAvolHn/rqhVOLYw3WX0zBXuo59
OhySiPdbFhTd+UL8BEy+sv/AwqSusg==
=GjBG
-----END PGP SIGNATURE-----

--cVkkcEO2DDbP5Zbb8803lDcaYv4c1A1pQ--

