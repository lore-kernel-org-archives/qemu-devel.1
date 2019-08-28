Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6F2C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DD5208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 16:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DD5208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i30Q6-0004IE-1a
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 12:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i30Ma-0002F1-J9
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i30MY-0006ef-W2
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:00:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i30MU-0006b2-Uw; Wed, 28 Aug 2019 11:59:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA0553083363;
 Wed, 28 Aug 2019 15:59:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-32.brq.redhat.com
 [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B217404D;
 Wed, 28 Aug 2019 15:59:46 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-4-vsementsov@virtuozzo.com>
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
Message-ID: <9afc83df-5b6e-cf5c-91e4-19ab6c9eb137@redhat.com>
Date: Wed, 28 Aug 2019 17:59:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826161312.489398-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9nXtM6WaQG2nC3XQBGiyiyZnUH7bps6wo"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 28 Aug 2019 15:59:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 03/13] block/backup: introduce
 BlockCopyState
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
Cc: fam@euphon.net, kwolf@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 jsnow@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9nXtM6WaQG2nC3XQBGiyiyZnUH7bps6wo
Content-Type: multipart/mixed; boundary="tOApO72gw9Fa6K47Dfwcj3e5Gv1qHprzX";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net,
 stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <9afc83df-5b6e-cf5c-91e4-19ab6c9eb137@redhat.com>
Subject: Re: [PATCH v9 03/13] block/backup: introduce BlockCopyState
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190826161312.489398-4-vsementsov@virtuozzo.com>

--tOApO72gw9Fa6K47Dfwcj3e5Gv1qHprzX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.08.19 18:13, Vladimir Sementsov-Ogievskiy wrote:
> Split copying code part from backup to "block-copy", including separate=

> state structure and function renaming. This is needed to share it with
> backup-top filter driver in further commits.
>=20
> Notes:
>=20
> 1. As BlockCopyState keeps own BlockBackend objects, remaining

I suppose these should be BdrvChild objects at some point, but doing it
now would just mean effectively duplicating code from block-backend.c.
(=E2=80=9Cnow=E2=80=9D =3D before we have a backup-top filter to attach t=
he children to.)

> job->common.blk users only use it to get bs by blk_bs() call, so clear
> job->commen.blk permissions set in block_job_create.
>=20
> 2. Rename s/initializing_bitmap/skip_unallocated/ to sound a bit better=

> as interface to BlockCopyState
>=20
> 3. Split is not very clean: there left some duplicated fields, backup

Are there any but cluster_size and len (and source, in a sense)?

> code uses some BlockCopyState fields directly, let's postpone it for
> further improvements and keep this comment simpler for review.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c     | 324 +++++++++++++++++++++++++++------------------=

>  block/trace-events |  12 +-
>  2 files changed, 200 insertions(+), 136 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index 13a1d80157..f52ac622e0 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -35,12 +35,35 @@ typedef struct CowRequest {
>      CoQueue wait_queue; /* coroutines blocked on this request */
>  } CowRequest;
> =20
> +/*
> + * ProgressCallbackFunc
> + *
> + * Called when some progress is done in context of BlockCopyState:
> + *  1. When some bytes copied, called with @bytes > 0.
> + *  2. When some bytes resetted from copy_bitmap, called with @bytes =3D=
 0 (user

*reset

> + *     may recalculate remaining bytes from copy_bitmap dirty count.
> + */
> +typedef void (*ProgressCallbackFunc)(int64_t bytes, void *opaque);

Maybe there should be two callbacks instead, one for =E2=80=9CWe=E2=80=99=
ve actively
made progress=E2=80=9D (bytes > 0) and one for =E2=80=9CThe expected leng=
th has changed=E2=80=9D
(bytes =3D=3D 0)?

> +typedef struct BlockCopyState {
> +    BlockBackend *source;
> +    BlockBackend *target;
> +    BdrvDirtyBitmap *copy_bitmap;
> +    int64_t cluster_size;
> +    bool use_copy_range;
> +    int64_t copy_range_size;
> +    uint64_t len;
> +
> +    BdrvRequestFlags write_flags;
> +    bool skip_unallocated;

The rename seems reasonable, although I think this should get a comment,
because it doesn=E2=80=99t mean just to skip unallocated clusters; it als=
o means
to clear unallocated clusters from the bitmap.

> +
> +    ProgressCallbackFunc progress_callback;
> +    void *progress_opaque;
> +} BlockCopyState;
> +
>  typedef struct BackupBlockJob {
>      BlockJob common;
> -    BlockBackend *target;
> =20
>      BdrvDirtyBitmap *sync_bitmap;
> -    BdrvDirtyBitmap *copy_bitmap;
> =20
>      MirrorSyncMode sync_mode;
>      BitmapSyncMode bitmap_mode;

[...]

> @@ -99,9 +118,83 @@ static void cow_request_end(CowRequest *req)
>      qemu_co_queue_restart_all(&req->wait_queue);
>  }
> =20
> +static void block_copy_state_free(BlockCopyState *s)
> +{
> +    if (!s) {
> +        return;
> +    }
> +
> +    bdrv_release_dirty_bitmap(blk_bs(s->source), s->copy_bitmap);
> +    blk_unref(s->source);
> +    s->source =3D NULL;
> +    blk_unref(s->target);
> +    s->target =3D NULL;

I=E2=80=99m not quite sure why you NULL these pointers when you free the =
whole
object next anyway.

> +    g_free(s);
> +}
> +
> +static BlockCopyState *block_copy_state_new(
> +        BlockDriverState *source, BlockDriverState *target,
> +        int64_t cluster_size, BdrvRequestFlags write_flags,
> +        ProgressCallbackFunc progress_callback, void *progress_opaque,=

> +        Error **errp)
> +{
> +    BlockCopyState *s;
> +    int ret;
> +    uint64_t no_resize =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |=

> +                         BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD=
;
> +    BdrvDirtyBitmap *copy_bitmap =3D
> +            bdrv_create_dirty_bitmap(source, cluster_size, NULL, errp)=
;
> +

This probably were easier to read if you didn=E2=80=99t initialize copy_b=
itmap
with the bdrv_create_dirty_bitmap() call but instead moved that call
right above the if () here (it still fits on a single line).

> +    if (!copy_bitmap) {
> +        return NULL;
> +    }
> +    bdrv_disable_dirty_bitmap(copy_bitmap);
> +
> +    s =3D g_new0(BlockCopyState, 1);

With the following compound literal, you don=E2=80=99t need to allocate
zero-initialized memory here.

> +    *s =3D (BlockCopyState) {
> +        .source =3D blk_new(bdrv_get_aio_context(source),
> +                          BLK_PERM_CONSISTENT_READ, no_resize),
> +        .target =3D blk_new(bdrv_get_aio_context(target),
> +                          BLK_PERM_WRITE, no_resize),

Maybe we want to assert that source=E2=80=99s and target=E2=80=99s contex=
t are the same?

> +        .copy_bitmap =3D copy_bitmap,
> +        .cluster_size =3D cluster_size,
> +        .len =3D bdrv_dirty_bitmap_size(copy_bitmap),
> +        .write_flags =3D write_flags,
> +        .use_copy_range =3D !(write_flags & BDRV_REQ_WRITE_COMPRESSED)=
,
> +        .progress_callback =3D progress_callback,
> +        .progress_opaque =3D progress_opaque,
> +    };
> +
> +    s->copy_range_size =3D QEMU_ALIGN_UP(MIN(blk_get_max_transfer(s->s=
ource),
> +                                           blk_get_max_transfer(s->tar=
get)),
> +                                       s->cluster_size),

Nice simplification.

> +
> +    blk_set_disable_request_queuing(s->source, true);
> +    blk_set_allow_aio_context_change(s->source, true);
> +    blk_set_disable_request_queuing(s->target, true);
> +    blk_set_allow_aio_context_change(s->target, true);

Hm.  Doesn=E2=80=99t creating new BBs here mean that we have to deal with=
 the
fallout of changing the AioContext on either of them somewhere?

[...]

> @@ -449,8 +542,8 @@ static void backup_drain(BlockJob *job)
>      /* Need to keep a reference in case blk_drain triggers execution
>       * of backup_complete...
>       */
> -    if (s->target) {
> -        BlockBackend *target =3D s->target;
> +    if (s->bcs && s->bcs->target) {

bcs->target should always be non-NULL, shouldn=E2=80=99t it?

> +        BlockBackend *target =3D s->bcs->target;
>          blk_ref(target);
>          blk_drain(target);
>          blk_unref(target);

[...]

> @@ -730,57 +821,34 @@ BlockJob *backup_job_create(const char *job_id, B=
lockDriverState *bs,

[...]

> -    /*
> -     * Set write flags:
> -     * 1. Detect image-fleecing (and similar) schemes
> -     * 2. Handle compression
> -     */
> -    job->write_flags =3D
> -        (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALISING : 0) |=

> -        (compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
> +    job->bcs =3D block_copy_state_new(
> +            bs, target, cluster_size,
> +            /*
> +             * Set write flags:
> +             * 1. Detect image-fleecing (and similar) schemes
> +             * 2. Handle compression
> +             */
> +            (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALISING : =
0) |
> +            (compress ? BDRV_REQ_WRITE_COMPRESSED : 0),

This is a bit hard to read.  Why not add a dedicated variable for it?

> +            backup_progress_callback, job, errp);
> +    if (!job->bcs) {
> +        goto error;
> +    }
> =20
>      job->cluster_size =3D cluster_size;
> -    job->copy_bitmap =3D copy_bitmap;
> -    copy_bitmap =3D NULL;
> -    job->use_copy_range =3D !compress; /* compression isn't supported =
for it */
> -    job->copy_range_size =3D MIN_NON_ZERO(blk_get_max_transfer(job->co=
mmon.blk),
> -                                        blk_get_max_transfer(job->targ=
et));
> -    job->copy_range_size =3D MAX(job->cluster_size,
> -                               QEMU_ALIGN_UP(job->copy_range_size,
> -                                             job->cluster_size));
> =20
>      /* Required permissions are already taken with target's blk_new() =
*/
>      block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL=
,

[...]

> diff --git a/block/trace-events b/block/trace-events
> index 04209f058d..ad1454f539 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -40,12 +40,12 @@ mirror_yield_in_flight(void *s, int64_t offset, int=
 in_flight) "s %p offset %" P
>  # backup.c
>  backup_do_cow_enter(void *job, int64_t start, int64_t offset, uint64_t=
 bytes) "job %p start %" PRId64 " offset %" PRId64 " bytes %" PRIu64
>  backup_do_cow_return(void *job, int64_t offset, uint64_t bytes, int re=
t) "job %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
> -backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
> -backup_do_cow_skip_range(void *job, int64_t start, uint64_t bytes) "jo=
b %p start %"PRId64" bytes %"PRId64
> -backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId64=

> -backup_do_cow_read_fail(void *job, int64_t start, int ret) "job %p sta=
rt %"PRId64" ret %d"
> -backup_do_cow_write_fail(void *job, int64_t start, int ret) "job %p st=
art %"PRId64" ret %d"
> -backup_do_cow_copy_range_fail(void *job, int64_t start, int ret) "job =
%p start %"PRId64" ret %d"
> +block_copy_skip(void *job, int64_t start) "job %p start %"PRId64
> +block_copy_skip_range(void *job, int64_t start, uint64_t bytes) "job %=
p start %"PRId64" bytes %"PRId64
> +block_copy_process(void *job, int64_t start) "job %p start %"PRId64
> +block_copy_with_bounce_buffer_read_fail(void *job, int64_t start, int =
ret) "job %p start %"PRId64" ret %d"
> +block_copy_with_bounce_buffer_write_fail(void *job, int64_t start, int=
 ret) "job %p start %"PRId64" ret %d"
> +block_copy_with_offload_fail(void *job, int64_t start, int ret) "job %=
p start %"PRId64" ret %d"

The pointer is no longer a job pointer, though.

Max

> =20
>  # ../blockdev.c
>  qmp_block_job_cancel(void *job) "job %p"
>=20



--tOApO72gw9Fa6K47Dfwcj3e5Gv1qHprzX--

--9nXtM6WaQG2nC3XQBGiyiyZnUH7bps6wo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1mpPAACgkQ9AfbAGHV
z0DEbAf/YLZUFwzcnRJN12KwNOwz0mT7J4nblE/cRikFt2G4QFxqzl/Sgjspc/Gc
wEkjXW/ARHqZhnOk0BHvYNkjMscHVSgmGOWPJq24Iznqf8/TbwDLvPi+4g2xQBmb
0mtT1imb9LFALARcOoj24y20aLXWEhrMg9hwsvWIcA7sFwPb+Jk+fdJn/mT1sj1w
XTAE0YFlUsNynoDsFMKg1wsi7jsBVCCxbHbL3VkUPT3pDXw61/m0aHKC2/P5h6j4
axkF+Sk9dXYnZkBCNwBy4sxrhLy88lP8yf2EPZDFlkvG4sIY2D/Mzv0F4UtIMJA7
7zqHpWxW1NOTmjwX19iHjDZsvj0GUg==
=HD/0
-----END PGP SIGNATURE-----

--9nXtM6WaQG2nC3XQBGiyiyZnUH7bps6wo--

