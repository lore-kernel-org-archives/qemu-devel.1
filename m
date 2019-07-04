Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA289C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 17:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A500A2189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 17:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A500A2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj5dQ-00048Y-J2
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 13:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hj5Z3-0002Oy-4s
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 13:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hj5Z1-0001Gn-F5
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 13:30:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hj5Yr-0000v1-4L; Thu, 04 Jul 2019 13:30:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E84EB30C1208;
 Thu,  4 Jul 2019 17:30:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-93.brq.redhat.com
 [10.40.204.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EFB096AA8;
 Thu,  4 Jul 2019 17:30:01 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-12-jsnow@redhat.com>
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
Message-ID: <6fb4a48b-5b69-7d20-eca9-beb01fd2f225@redhat.com>
Date: Thu, 4 Jul 2019 19:29:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703215542.16123-12-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="W7foRS0OYtleU8MeEPTE0HziFcfAiiwKJ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 04 Jul 2019 17:30:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 11/18] block/backup: upgrade copy_bitmap
 to BdrvDirtyBitmap
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
--W7foRS0OYtleU8MeEPTE0HziFcfAiiwKJ
Content-Type: multipart/mixed; boundary="5t9avffQyHqRknJYBGdDmfDXxCrJxOxFE";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, vsementsov@virtuozzo.com,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <6fb4a48b-5b69-7d20-eca9-beb01fd2f225@redhat.com>
Subject: Re: [PATCH v2 11/18] block/backup: upgrade copy_bitmap to
 BdrvDirtyBitmap
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-12-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-12-jsnow@redhat.com>

--5t9avffQyHqRknJYBGdDmfDXxCrJxOxFE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 23:55, John Snow wrote:
> This simplifies some interface matters; namely the initialization and
> (later) merging the manifest back into the sync_bitmap if it was
> provided.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c | 76 ++++++++++++++++++++++++--------------------------=

>  1 file changed, 37 insertions(+), 39 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index d7fdafebda..9cc5a7f6ca 100644
> --- a/block/backup.c
> +++ b/block/backup.c

[...]

> @@ -202,7 +204,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJo=
b *job,
>      cow_request_begin(&cow_request, job, start, end);
> =20
>      while (start < end) {
> -        if (!hbitmap_get(job->copy_bitmap, start)) {
> +        if (!bdrv_dirty_bitmap_get(job->copy_bitmap, start)) {
>              trace_backup_do_cow_skip(job, start);
>              start +=3D job->cluster_size;
>              continue; /* already copied */
> @@ -296,14 +298,16 @@ static void backup_abort(Job *job)
>  static void backup_clean(Job *job)
>  {
>      BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job=
);
> +    BlockDriverState *bs =3D blk_bs(s->target);

I=E2=80=99d prefer to call it target_bs, because =E2=80=9Cbs=E2=80=9D is =
usually the source node.

Which brings me to a question: Why is the copy bitmap assigned to the
target in the first place?  Wouldn=E2=80=99t it make more sense on the so=
urce?

> +
> +    if (s->copy_bitmap) {
> +        bdrv_release_dirty_bitmap(bs, s->copy_bitmap);
> +        s->copy_bitmap =3D NULL;
> +    }
> +
>      assert(s->target);
>      blk_unref(s->target);
>      s->target =3D NULL;
> -
> -    if (s->copy_bitmap) {
> -        hbitmap_free(s->copy_bitmap);
> -        s->copy_bitmap =3D NULL;
> -    }
>  }
> =20
>  void backup_do_checkpoint(BlockJob *job, Error **errp)

[...]

> @@ -387,59 +391,49 @@ static bool bdrv_is_unallocated_range(BlockDriver=
State *bs,
> =20
>  static int coroutine_fn backup_loop(BackupBlockJob *job)
>  {
> -    int ret;
>      bool error_is_read;
>      int64_t offset;
> -    HBitmapIter hbi;
> +    BdrvDirtyBitmapIter *bdbi;
>      BlockDriverState *bs =3D blk_bs(job->common.blk);
> +    int ret =3D 0;
> =20
> -    hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
> -    while ((offset =3D hbitmap_iter_next(&hbi)) !=3D -1) {
> +    bdbi =3D bdrv_dirty_iter_new(job->copy_bitmap);
> +    while ((offset =3D bdrv_dirty_iter_next(bdbi)) !=3D -1) {
>          if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP &&
>              bdrv_is_unallocated_range(bs, offset, job->cluster_size))
>          {
> -            hbitmap_reset(job->copy_bitmap, offset, job->cluster_size)=
;
> +            bdrv_set_dirty_bitmap(job->copy_bitmap, offset, job->clust=
er_size);

Should be reset.

>              continue;
>          }
> =20
>          do {
>              if (yield_and_check(job)) {
> -                return 0;
> +                goto out;
>              }
>              ret =3D backup_do_cow(job, offset,
>                                  job->cluster_size, &error_is_read, fal=
se);
>              if (ret < 0 && backup_error_action(job, error_is_read, -re=
t) =3D=3D
>                             BLOCK_ERROR_ACTION_REPORT)
>              {
> -                return ret;
> +                goto out;
>              }
>          } while (ret < 0);
>      }
> =20
> -    return 0;
> + out:
> +    bdrv_dirty_iter_free(bdbi);
> +    return ret;
>  }
> =20
>  /* init copy_bitmap from sync_bitmap */
>  static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
>  {
> -    uint64_t offset =3D 0;
> -    uint64_t bytes =3D job->len;
> -
> -    while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
> -                                             &offset, &bytes))
> -    {
> -        hbitmap_set(job->copy_bitmap, offset, bytes);
> -
> -        offset +=3D bytes;
> -        if (offset >=3D job->len) {
> -            break;
> -        }
> -        bytes =3D job->len - offset;
> -    }
> +    bdrv_dirty_bitmap_merge_internal(job->copy_bitmap, job->sync_bitma=
p,
> +                                     NULL, true);

How about asserting that this was successful?

> =20
>      /* TODO job_progress_set_remaining() would make more sense */
>      job_progress_update(&job->common.job,
> -        job->len - hbitmap_count(job->copy_bitmap));
> +                        job->len - bdrv_get_dirty_count(job->copy_bitm=
ap));
>  }
> =20
>  static int coroutine_fn backup_run(Job *job, Error **errp)

[...]

> @@ -670,7 +668,7 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>   error:
>      if (copy_bitmap) {
>          assert(!job || !job->copy_bitmap);
> -        hbitmap_free(copy_bitmap);
> +        bdrv_release_dirty_bitmap(bs, copy_bitmap);

If you decide to keep the copy_bitmap on the target, s/bs/target/.

Max


--5t9avffQyHqRknJYBGdDmfDXxCrJxOxFE--

--W7foRS0OYtleU8MeEPTE0HziFcfAiiwKJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0eN5cACgkQ9AfbAGHV
z0ASTQf8D+2815W64wCJP4eJQRIDbMa4dFC+ge4hPtgHS9rZfakmRqfvNEyWGf44
bTJ3Y0DKH0VPrrd8AfcASlWBl7vO+bpLX3ZiWlMQF6gkGFu8Urz5Ox+0KaGni6Py
YeEyRU0AqRr+Z/nw1P7Gex/AswbjXmYddhWQBAJmsrchsloSqo140e1KrX6sIUg0
gf+dmdvkC9GQB2IF3Uf65bMIHJOo+VcjkUVenhvyydEic2R0YRpHXpF96fV5JWfB
ZyXUF+1rZaDA9ZSIC1kj4voDBhQmG26ZBy+tov1yJbXl40eOCXEsBQIkJ/CD26Qb
Kxb0tlyUy9yP1eBO5MNm5qUJqHQftA==
=TpzL
-----END PGP SIGNATURE-----

--W7foRS0OYtleU8MeEPTE0HziFcfAiiwKJ--

