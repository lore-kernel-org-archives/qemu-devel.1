Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B7C352AB
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECB121850
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECB121850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmQ3-00004z-1C
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDmJx-00039W-RT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDmJw-0007nN-7A
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDmJs-0007a4-NK; Fri, 27 Sep 2019 05:13:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A5443082135;
 Fri, 27 Sep 2019 09:13:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-76.brq.redhat.com
 [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 470015D6A7;
 Fri, 27 Sep 2019 09:13:41 +0000 (UTC)
Subject: Re: [PATCH v4 10/10] qcow2-bitmap: move bitmap reopen-rw code to
 qcow2_reopen_commit
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
 <20190807141226.193501-11-vsementsov@virtuozzo.com>
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
Message-ID: <79c92b1c-d626-6374-bcd0-8e2bb3a8e6d9@redhat.com>
Date: Fri, 27 Sep 2019 11:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190807141226.193501-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zjskGgH1rbwmixmDn27ef36xkXFq1Yc3t"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 27 Sep 2019 09:13:43 +0000 (UTC)
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
Cc: fam@euphon.net, kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zjskGgH1rbwmixmDn27ef36xkXFq1Yc3t
Content-Type: multipart/mixed; boundary="OYxzrnNjGJqocSsfGaQrCAAg7lKherQqX"

--OYxzrnNjGJqocSsfGaQrCAAg7lKherQqX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.08.19 16:12, Vladimir Sementsov-Ogievskiy wrote:
> The only reason I can imagine for this strange code at the very-end of
> bdrv_reopen_commit is the fact that bs->read_only updated after
> calling drv->bdrv_reopen_commit in bdrv_reopen_commit. And in the same
> time, prior to previous commit, qcow2_reopen_bitmaps_rw did a wrong
> check for being writable, when actually it only need writable file
> child not self.
>=20
> So, as it's fixed, let's move things to correct place.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block_int.h |  6 ------
>  block.c                   | 19 -------------------
>  block/qcow2.c             | 15 ++++++++++++++-
>  3 files changed, 14 insertions(+), 26 deletions(-)
>=20
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 3aa1e832a8..18a1e81194 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -531,12 +531,6 @@ struct BlockDriver {
>                               uint64_t parent_perm, uint64_t parent_sha=
red,
>                               uint64_t *nperm, uint64_t *nshared);
> =20
> -    /**
> -     * Bitmaps should be marked as 'IN_USE' in the image on reopening =
image
> -     * as rw. This handler should realize it. It also should unset rea=
donly
> -     * field of BlockDirtyBitmap's in case of success.
> -     */
> -    int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);=

>      bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs,
>                                              const char *name,
>                                              uint32_t granularity,
> diff --git a/block.c b/block.c
> index d59f9f97cb..395bc88045 100644
> --- a/block.c
> +++ b/block.c
> @@ -3925,16 +3925,12 @@ void bdrv_reopen_commit(BDRVReopenState *reopen=
_state)
>      BlockDriver *drv;
>      BlockDriverState *bs;
>      BdrvChild *child;
> -    bool old_can_write, new_can_write;
> =20
>      assert(reopen_state !=3D NULL);
>      bs =3D reopen_state->bs;
>      drv =3D bs->drv;
>      assert(drv !=3D NULL);
> =20
> -    old_can_write =3D
> -        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTI=
VE);
> -
>      /* If there are any driver level actions to take */
>      if (drv->bdrv_reopen_commit) {
>          drv->bdrv_reopen_commit(reopen_state);
> @@ -3978,21 +3974,6 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_=
state)
>      }
> =20
>      bdrv_refresh_limits(bs, NULL);
> -
> -    new_can_write =3D
> -        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTI=
VE);
> -    if (!old_can_write && new_can_write && drv->bdrv_reopen_bitmaps_rw=
) {
> -        Error *local_err =3D NULL;
> -        if (drv->bdrv_reopen_bitmaps_rw(bs, &local_err) < 0) {
> -            /* This is not fatal, bitmaps just left read-only, so all =
following
> -             * writes will fail. User can remove read-only bitmaps to =
unblock
> -             * writes.
> -             */
> -            error_reportf_err(local_err,
> -                              "%s: Failed to make dirty bitmaps writab=
le: ",
> -                              bdrv_get_node_name(bs));
> -        }
> -    }
>  }
> =20
>  /*
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 5c1187e2f9..9e6210c282 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1828,6 +1828,20 @@ fail:
>  static void qcow2_reopen_commit(BDRVReopenState *state)
>  {
>      qcow2_update_options_commit(state->bs, state->opaque);
> +    if (state->flags & BDRV_O_RDWR) {
> +        Error *local_err =3D NULL;
> +
> +        if (qcow2_reopen_bitmaps_rw(state->bs, &local_err) < 0) {
> +            /*
> +             * This is not fatal, bitmaps just left read-only, so all =
following
> +             * writes will fail. User can remove read-only bitmaps to =
unblock
> +             * writes or retry reopen.
> +             */

It=E2=80=99s still my impression that this is absolutely fatal, because t=
hat
means the node isn=E2=80=99t actually writable, and that means the reopen=

effectively failed.

But again, it doesn=E2=80=99t make things worse.

Assuming the RW -> RW transition is a no-op now (the previous patch
claims to handle that case):

Acked-by: Max Reitz <mreitz@redhat.com>

> +            error_reportf_err(local_err,
> +                              "%s: Failed to make dirty bitmaps writab=
le: ",
> +                              bdrv_get_node_name(state->bs));
> +        }
> +    }
>      g_free(state->opaque);
>  }
> =20
> @@ -5229,7 +5243,6 @@ BlockDriver bdrv_qcow2 =3D {
>      .bdrv_detach_aio_context  =3D qcow2_detach_aio_context,
>      .bdrv_attach_aio_context  =3D qcow2_attach_aio_context,
> =20
> -    .bdrv_reopen_bitmaps_rw =3D qcow2_reopen_bitmaps_rw,
>      .bdrv_can_store_new_dirty_bitmap =3D qcow2_can_store_new_dirty_bit=
map,
>      .bdrv_remove_persistent_dirty_bitmap =3D qcow2_remove_persistent_d=
irty_bitmap,
>  };
>=20



--OYxzrnNjGJqocSsfGaQrCAAg7lKherQqX--

--zjskGgH1rbwmixmDn27ef36xkXFq1Yc3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2N0sMACgkQ9AfbAGHV
z0AKLgf+P1D61R7kC/yjTsvOMJeDV9Q17FR9nS9cMVCWQOBvyeU4DSLb2+NPLZ8p
1aE+kjsH7cb35fFQ7rWTrixF337LcrNQeBOFNgk75fLlMyIfy+p8aFr/drJnxZLn
VZJL3eMEw2+DLiEsoGnNLKs/AOubIzIIEy1Tzx5P+u3XZNuZ7RRatInCXJeCwzq9
rlVtIkY0oyyXLHmiIR2+NQYti5KmHljyJs5Daww3BFQzPB1YeCoXCsNu/YCysAbn
EuVKHo4kJdqmb9ufTxd0S1cVmfq1THTRCpx+O9FeGYU0Ry7lx3EAufPAgKiBxB5d
/ew2vknV0kGNx6oSggClH5TJmivmiQ==
=3zGh
-----END PGP SIGNATURE-----

--zjskGgH1rbwmixmDn27ef36xkXFq1Yc3t--

