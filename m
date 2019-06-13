Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65864C31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC47215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC47215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSs5-0001LW-B2
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41103)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbS6q-0003J0-48
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbS6i-0000GU-KL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:57:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbS6M-0007qE-2G; Thu, 13 Jun 2019 11:57:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6AC7289C39;
 Thu, 13 Jun 2019 15:57:20 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8043B19700;
 Thu, 13 Jun 2019 15:57:15 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
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
Message-ID: <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
Date: Thu, 13 Jun 2019 17:57:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529154654.95870-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="maTl3rTAaec12kDbe6CaqTkNlb1y2M5aZ"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 13 Jun 2019 15:57:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 4/7] block: introduce backup-top filter
 driver
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--maTl3rTAaec12kDbe6CaqTkNlb1y2M5aZ
Content-Type: multipart/mixed; boundary="E2fevzjs9W4sorPhaxVn24z7GLG8K2FCE";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com
Message-ID: <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
Subject: Re: [PATCH v8 4/7] block: introduce backup-top filter driver
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190529154654.95870-5-vsementsov@virtuozzo.com>

--E2fevzjs9W4sorPhaxVn24z7GLG8K2FCE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.05.19 17:46, Vladimir Sementsov-Ogievskiy wrote:
> Backup-top filter does copy-before-write operation. It should be
> inserted above active disk and has a target node for CBW, like the
> following:
>=20
>     +-------+
>     | Guest |
>     +-------+
>         |r,w
>         v
>     +------------+  target   +---------------+
>     | backup_top |---------->| target(qcow2) |
>     +------------+   CBW     +---------------+
>         |
> backing |r,w
>         v
>     +-------------+
>     | Active disk |
>     +-------------+
>=20
> The driver will be used in backup instead of write-notifiers.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup-top.h  |  64 +++++++++
>  block/backup-top.c  | 322 ++++++++++++++++++++++++++++++++++++++++++++=

>  block/Makefile.objs |   2 +
>  3 files changed, 388 insertions(+)
>  create mode 100644 block/backup-top.h
>  create mode 100644 block/backup-top.c
>=20
> diff --git a/block/backup-top.h b/block/backup-top.h
> new file mode 100644
> index 0000000000..788e18c358
> --- /dev/null
> +++ b/block/backup-top.h
> @@ -0,0 +1,64 @@
> +/*
> + * backup-top filter driver
> + *
> + * The driver performs Copy-Before-Write (CBW) operation: it is inject=
ed above
> + * some node, and before each write it copies _old_ data to the target=
 node.
> + *
> + * Copyright (c) 2018 Virtuozzo International GmbH. All rights reserve=
d.
> + *
> + * Author:
> + *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License as published b=
y
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>=
=2E
> + */
> +
> +#ifndef BACKUP_TOP_H
> +#define BACKUP_TOP_H
> +
> +#include "qemu/osdep.h"
> +
> +#include "block/block_int.h"
> +
> +typedef void (*BackupTopProgressCallback)(uint64_t done, void *opaque)=
;
> +typedef struct BDRVBackupTopState {
> +    HBitmap *copy_bitmap; /* what should be copied to @target on guest=
 write. */
> +    BdrvChild *target;
> +
> +    BackupTopProgressCallback progress_cb;
> +    void *progress_opaque;
> +} BDRVBackupTopState;
> +
> +/*
> + * bdrv_backup_top_append
> + *
> + * Append backup_top filter node above @source node. @target node will=
 receive
> + * the data backed up during CBE operations. New filter together with =
@target
> + * node are attached to @source aio context.
> + *
> + * The resulting filter node is implicit.

Why?  It=E2=80=99s just as easy for the caller to just make it implicit i=
f it
should be.  (And usually the caller should decide that.)

> + *
> + * @copy_bitmap selects regions which needs CBW. Furthermore, backup_t=
op will
> + * use exactly this bitmap, so it may be used to control backup_top be=
havior
> + * dynamically. Caller should not release @copy_bitmap during life-tim=
e of
> + * backup_top. Progress is tracked by calling @progress_cb function.
> + */
> +BlockDriverState *bdrv_backup_top_append(
> +        BlockDriverState *source, BlockDriverState *target,
> +        HBitmap *copy_bitmap, Error **errp);
> +void bdrv_backup_top_set_progress_callback(
> +        BlockDriverState *bs, BackupTopProgressCallback progress_cb,
> +        void *progress_opaque);
> +void bdrv_backup_top_drop(BlockDriverState *bs);
> +
> +#endif /* BACKUP_TOP_H */
> diff --git a/block/backup-top.c b/block/backup-top.c
> new file mode 100644
> index 0000000000..1daa02f539
> --- /dev/null
> +++ b/block/backup-top.c
> @@ -0,0 +1,322 @@
> +/*
> + * backup-top filter driver
> + *
> + * The driver performs Copy-Before-Write (CBW) operation: it is inject=
ed above
> + * some node, and before each write it copies _old_ data to the target=
 node.
> + *
> + * Copyright (c) 2018 Virtuozzo International GmbH. All rights reserve=
d.
> + *
> + * Author:
> + *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License as published b=
y
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>=
=2E
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qemu/cutils.h"
> +#include "qapi/error.h"
> +#include "block/block_int.h"
> +#include "block/qdict.h"
> +
> +#include "block/backup-top.h"
> +
> +static coroutine_fn int backup_top_co_preadv(
> +        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> +        QEMUIOVector *qiov, int flags)
> +{
> +    /*
> +     * Features to be implemented:
> +     * F1. COR. save read data to fleecing target for fast access
> +     *     (to reduce reads). This possibly may be done with use of co=
py-on-read
> +     *     filter, but we need an ability to make COR requests optiona=
l: for
> +     *     example, if target is a ram-cache, and if it is full now, w=
e should
> +     *     skip doing COR request, as it is actually not necessary.
> +     *
> +     * F2. Feature for guest: read from fleecing target if data is in =
ram-cache
> +     *     and is unchanged
> +     */
> +
> +    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
> +}
> +
> +static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t =
offset,
> +                                       uint64_t bytes)
> +{
> +    int ret =3D 0;
> +    BDRVBackupTopState *s =3D bs->opaque;
> +    uint64_t gran =3D 1UL << hbitmap_granularity(s->copy_bitmap);
> +    uint64_t end =3D QEMU_ALIGN_UP(offset + bytes, gran);
> +    uint64_t off =3D QEMU_ALIGN_DOWN(offset, gran), len;

The =E2=80=9C, len=E2=80=9D is a bit weirdly placed there, why not define=
 it on a
separate line as "uint64_t len =3D end - off"?

> +    void *buf =3D qemu_blockalign(bs, end - off);
> +
> +    /*
> +     * Features to be implemented:
> +     * F3. parallelize copying loop
> +     * F4. detect zeroes ? or, otherwise, drop detect zeroes from back=
up code
> +     *     and just enable zeroes detecting on target
> +     * F5. use block_status ?
> +     * F6. don't copy clusters which are already cached by COR [see F1=
]
> +     * F7. if target is ram-cache and it is full, there should be a po=
ssibility
> +     *     to drop not necessary data (cached by COR [see F1]) to hand=
le CBW
> +     *     fast.

Also =E2=80=9Cdrop BDRV_REQ_SERIALISING from writes to s->target unless n=
ecessary=E2=80=9D?

> +     */
> +
> +    len =3D end - off;
> +    while (hbitmap_next_dirty_area(s->copy_bitmap, &off, &len)) {
> +        hbitmap_reset(s->copy_bitmap, off, len);
> +
> +        ret =3D bdrv_co_pread(bs->backing, off, len, buf,
> +                            BDRV_REQ_NO_SERIALISING);
> +        if (ret < 0) {
> +            hbitmap_set(s->copy_bitmap, off, len);
> +            goto out;
> +        }
> +
> +        ret =3D bdrv_co_pwrite(s->target, off, len, buf, BDRV_REQ_SERI=
ALISING);
> +        if (ret < 0) {
> +            hbitmap_set(s->copy_bitmap, off, len);
> +            goto out;
> +        }
> +
> +        if (s->progress_cb) {
> +            s->progress_cb(len, s->progress_opaque);
> +        }
> +        off +=3D len;
> +        if (off >=3D end) {
> +            break;
> +        }
> +        len =3D end - off;
> +    }
> +
> +out:
> +    qemu_vfree(buf);
> +
> +    /*
> +     * F8. we fail guest request in case of error. We can alter it by
> +     * possibility to fail copying process instead, or retry several t=
imes, or
> +     * may be guest pause, etc.
> +     */
> +    return ret;
> +}
> +
> +static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
> +                                               int64_t offset, int byt=
es)
> +{
> +    int ret =3D backup_top_cbw(bs, offset, bytes);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /*
> +     * Features to be implemented:
> +     * F9. possibility of lazy discard: just defer the discard after f=
leecing
> +     *     completion. If write (or new discard) occurs to the same ar=
ea, just
> +     *     drop deferred discard.
> +     */
> +
> +    return bdrv_co_pdiscard(bs->backing, offset, bytes);
> +}
> +
> +static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *=
bs,
> +        int64_t offset, int bytes, BdrvRequestFlags flags)
> +{
> +    int ret =3D backup_top_cbw(bs, offset, bytes);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
> +}
> +
> +static coroutine_fn int backup_top_co_pwritev(BlockDriverState *bs,
> +                                              uint64_t offset,
> +                                              uint64_t bytes,
> +                                              QEMUIOVector *qiov, int =
flags)
> +{
> +    if (!(flags & BDRV_REQ_WRITE_UNCHANGED)) {
> +        int ret =3D backup_top_cbw(bs, offset, bytes);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
> +}
> +
> +static int coroutine_fn backup_top_co_flush(BlockDriverState *bs)
> +{
> +    if (!bs->backing) {
> +        return 0;
> +    }
> +
> +    return bdrv_co_flush(bs->backing->bs);

Should we flush the target, too?

> +}
> +
> +static void backup_top_refresh_filename(BlockDriverState *bs)
> +{
> +    if (bs->backing =3D=3D NULL) {
> +        /*
> +         * we can be here after failed bdrv_attach_child in
> +         * bdrv_set_backing_hd
> +         */
> +        return;
> +    }
> +    bdrv_refresh_filename(bs->backing->bs);

bdrv_refresh_filename() should have done this already.

> +    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
> +            bs->backing->bs->filename);
> +}
> +
> +static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
> +                                  const BdrvChildRole *role,
> +                                  BlockReopenQueue *reopen_queue,
> +                                  uint64_t perm, uint64_t shared,
> +                                  uint64_t *nperm, uint64_t *nshared)
> +{
> +    /*
> +     * We have HBitmap in the state, its size is fixed, so we never al=
low
> +     * resize.
> +     */
> +    uint64_t rw =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGE=
D |
> +                  BLK_PERM_WRITE;
> +
> +    bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,=

> +                              nperm, nshared);
> +
> +    *nperm =3D *nperm & rw;
> +    *nshared =3D *nshared & rw;

Somehow, that bdrv_filter_default_perm() call doesn=E2=80=99t make this f=
unction
easier for me.

It seems like this is basically just =E2=80=9C*nperm =3D perm & rw=E2=80=9D=
 and
=E2=80=9C*nshared =3D shared & rw=E2=80=9D.

> +
> +    if (role =3D=3D &child_file) {
> +        /*
> +         * Target child
> +         *
> +         * Share write to target (child_file), to not interfere
> +         * with guest writes to its disk which may be in target backin=
g chain.
> +         */
> +        if (perm & BLK_PERM_WRITE) {
> +            *nshared =3D *nshared | BLK_PERM_WRITE;

Why not always share WRITE on the target?

> +        }
> +    } else {
> +        /* Source child */
> +        if (perm & BLK_PERM_WRITE) {

Or WRITE_UNCHANGED, no?

> +            *nperm =3D *nperm | BLK_PERM_CONSISTENT_READ;
> +        }
> +        *nshared =3D
> +            *nshared & (BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCH=
ANGED);

And here it isn=E2=80=99t =E2=80=9C*nshared =3D shared & rw=E2=80=9D but =
=E2=80=9Crw & ~WRITE=E2=80=9D.

I feel like this function would be simpler if you just set *nperm and
*nshared separately in the two branches of this condition, without
setting a =E2=80=9Cdefault=E2=80=9D first.

> +    }
> +}
> +
> +BlockDriver bdrv_backup_top_filter =3D {
> +    .format_name =3D "backup-top",
> +    .instance_size =3D sizeof(BDRVBackupTopState),
> +
> +    .bdrv_co_preadv             =3D backup_top_co_preadv,
> +    .bdrv_co_pwritev            =3D backup_top_co_pwritev,
> +    .bdrv_co_pwrite_zeroes      =3D backup_top_co_pwrite_zeroes,
> +    .bdrv_co_pdiscard           =3D backup_top_co_pdiscard,
> +    .bdrv_co_flush              =3D backup_top_co_flush,
> +
> +    .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,=

> +
> +    .bdrv_refresh_filename      =3D backup_top_refresh_filename,
> +
> +    .bdrv_child_perm            =3D backup_top_child_perm,
> +
> +    .is_filter =3D true,
> +};
> +
> +BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
> +                                         BlockDriverState *target,
> +                                         HBitmap *copy_bitmap,
> +                                         Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    BDRVBackupTopState *state;
> +    BlockDriverState *top =3D bdrv_new_open_driver(&bdrv_backup_top_fi=
lter,
> +                                                 NULL, BDRV_O_RDWR, er=
rp);
> +
> +    if (!top) {
> +        return NULL;
> +    }
> +
> +    top->implicit =3D true;

As I said above, I think the caller should set this.

> +    top->total_sectors =3D source->total_sectors;
> +    top->bl.opt_mem_alignment =3D MAX(bdrv_opt_mem_align(source),
> +                                    bdrv_opt_mem_align(target));
> +    top->opaque =3D state =3D g_new0(BDRVBackupTopState, 1);
> +    state->copy_bitmap =3D copy_bitmap;
> +
> +    bdrv_ref(target);
> +    state->target =3D bdrv_attach_child(top, target, "target", &child_=
file, errp);
> +    if (!state->target) {
> +        bdrv_unref(target);
> +        bdrv_unref(top);
> +        return NULL;
> +    }
> +
> +    bdrv_set_aio_context(top, bdrv_get_aio_context(source));
> +    bdrv_set_aio_context(target, bdrv_get_aio_context(source));

I suppose these calls aren=E2=80=99t necessary anymore (compare d0ee0204f=
4009).
 (I=E2=80=99m not fully sure, though.  In any case, they would need to be=

bdrv_try_set_aio_context() if they were still necessary.)

> +
> +    bdrv_drained_begin(source);
> +
> +    bdrv_ref(top);
> +    bdrv_append(top, source, &local_err);
> +    if (local_err) {
> +        error_prepend(&local_err, "Cannot append backup-top filter: ")=
;
> +    }
> +
> +    bdrv_drained_end(source);
> +
> +    if (local_err) {
> +        bdrv_unref_child(top, state->target);
> +        bdrv_unref(top);
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    return top;
> +}

I guess it would be nice if it users could blockdev-add a backup-top
node to basically get a backup with sync=3Dnone.

(The bdrv_open implementation should then create a new bitmap and
initialize it to be fully set.)

But maybe it wouldn=E2=80=99t be so nice and I just have feverish dreams.=


> +void bdrv_backup_top_set_progress_callback(
> +        BlockDriverState *bs, BackupTopProgressCallback progress_cb,
> +        void *progress_opaque)
> +{
> +    BDRVBackupTopState *s =3D bs->opaque;
> +
> +    s->progress_cb =3D progress_cb;
> +    s->progress_opaque =3D progress_opaque;
> +}
> +
> +void bdrv_backup_top_drop(BlockDriverState *bs)
> +{
> +    BDRVBackupTopState *s =3D bs->opaque;
> +    AioContext *aio_context =3D bdrv_get_aio_context(bs);
> +
> +    aio_context_acquire(aio_context);
> +
> +    bdrv_drained_begin(bs);
> +
> +    bdrv_child_try_set_perm(bs->backing, 0, BLK_PERM_ALL, &error_abort=
);

Pre-existing in other jobs, but I think calling this function is
dangerous.  (Which is why I remove it in my =E2=80=9Cblock: Ignore loosen=
ing
perm restrictions failures=E2=80=9D series.)

> +    bdrv_replace_node(bs, backing_bs(bs), &error_abort);
> +    bdrv_set_backing_hd(bs, NULL, &error_abort);

I think some of this function should be in a .bdrv_close()
implementation, for example this bdrv_set_backing_hd() call.

> +    bdrv_drained_end(bs);
> +
> +    if (s->target) {
> +        bdrv_unref_child(bs, s->target);

And this.  Well, neither needs to be in a .bdrv_close() implementation,
actually, because bdrv_close() will just do it by itself.

I suppose you=E2=80=99re trying to remove the children so the node is no =
longer
usable after this point; but that isn=E2=80=99t quite right, then.  The f=
ilter
functions still refer to s->target and bs->backing, so you need to stop
them from doing anything then.

At this point, you might as well add a variable to BDRVBackupTopState
that says whether the filter is still supposed to be usable (like the
=E2=80=9Cstop=E2=80=9D variable I added to mirror in =E2=80=9Cblock/mirro=
r: Fix child
permissions=E2=80=9D).  If so, the permission function should signal 0/AL=
L for
the permissions on backing (and probably target), and all filter
functions always immediately return an error.

So I don=E2=80=99t think backing and target need to be removed here.  We =
can
wait for that until bdrv_close(), but we should ensure that the filter
really is unusable after this function has been called.

Max

> +    }
> +    bdrv_unref(bs);
> +
> +    aio_context_release(aio_context);
> +}
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index ae11605c9f..dfbdfe6ab4 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -40,6 +40,8 @@ block-obj-y +=3D throttle.o copy-on-read.o
> =20
>  block-obj-y +=3D crypto.o
> =20
> +block-obj-y +=3D backup-top.o
> +
>  common-obj-y +=3D stream.o
> =20
>  nfs.o-libs         :=3D $(LIBNFS_LIBS)
>=20



--E2fevzjs9W4sorPhaxVn24z7GLG8K2FCE--

--maTl3rTAaec12kDbe6CaqTkNlb1y2M5aZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0CclkACgkQ9AfbAGHV
z0BiwAf/YHh3wPSNY9K5xakWI3/EQS+85VII5quvrZaWJcnEU7hG0cdeGujNsRR9
4xW07cYp3CYf2SotRV2FpqrJI/6p9ebsMFYh81d6aE/bIuT7KP5UjEpco85Vv0xq
G5rDLkL5b6yigCYlP+livE+IGU/11AZflT00RqKM5A/sEu0nEPe5zNQeAi38gz4g
8aKx8VTgfQ+uHnUacpS9emxECZtQUHGhUYnMi2Lsdk8vsr+Icj1Utd6nviqziJav
j49H/TwI0XG1dLBVZ7jGpNwPD9bswImMlcJsltKkHrkaKMIaeS5Si/jfE8BwS6ZH
y4HrSEqhkJURsTfypP1vhdUHlqHRYA==
=5nbY
-----END PGP SIGNATURE-----

--maTl3rTAaec12kDbe6CaqTkNlb1y2M5aZ--

