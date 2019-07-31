Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23493C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE82206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE82206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsnQb-000812-4N
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 08:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hsnQA-0007VP-I6
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hsnQ8-0001ZX-RR
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:09:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hsnQ5-0001Vh-0Z; Wed, 31 Jul 2019 08:09:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0061230821AE;
 Wed, 31 Jul 2019 12:09:24 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-44.ams2.redhat.com
 [10.36.117.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E48D25D9C5;
 Wed, 31 Jul 2019 12:09:18 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190725091900.30542-1-vsementsov@virtuozzo.com>
 <20190725091900.30542-2-vsementsov@virtuozzo.com>
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
Message-ID: <2a105159-ab90-8f7c-bba9-4cec27e6144c@redhat.com>
Date: Wed, 31 Jul 2019 14:09:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725091900.30542-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HGNFFV4rPmQTX0MHfEqiR4g5tvalwGZt3"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 31 Jul 2019 12:09:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
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
Cc: fam@euphon.net, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HGNFFV4rPmQTX0MHfEqiR4g5tvalwGZt3
Content-Type: multipart/mixed; boundary="lTNPetTuBKC6yLFpsSKfETEz4ccfqC3yP";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, fam@euphon.net, kwolf@redhat.com, den@openvz.org
Message-ID: <2a105159-ab90-8f7c-bba9-4cec27e6144c@redhat.com>
Subject: Re: [PATCH v3 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
References: <20190725091900.30542-1-vsementsov@virtuozzo.com>
 <20190725091900.30542-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190725091900.30542-2-vsementsov@virtuozzo.com>

--lTNPetTuBKC6yLFpsSKfETEz4ccfqC3yP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.07.19 11:18, Vladimir Sementsov-Ogievskiy wrote:
> On reopen to rw parent may need rw access to child in .prepare, for
> example qcow2 needs to write IN_USE flags into stored bitmaps
> (currently it is done in a hacky way after commit and don't work).
> So, let's introduce such logic.
>=20
> The drawback is that in worst case bdrv_reopen_set_read_only may finish=

> with error and in some intermediate state: some nodes reopened RW and
> some are not. But this is a way to fix bug around reopening qcow2
> bitmaps in the following commits.

This commit message doesn=E2=80=99t really explain what this patch does.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block_int.h |   2 +
>  block.c                   | 144 ++++++++++++++++++++++++++++++++++----=

>  2 files changed, 133 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 3aa1e832a8..7bd6fd68dd 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -531,6 +531,8 @@ struct BlockDriver {
>                               uint64_t parent_perm, uint64_t parent_sha=
red,
>                               uint64_t *nperm, uint64_t *nshared);
> =20
> +     bool (*bdrv_need_rw_file_child_during_reopen_rw)(BlockDriverState=
 *bs);
> +
>      /**
>       * Bitmaps should be marked as 'IN_USE' in the image on reopening =
image
>       * as rw. This handler should realize it. It also should unset rea=
donly
> diff --git a/block.c b/block.c
> index cbd8da5f3b..3c8e1c59b4 100644
> --- a/block.c
> +++ b/block.c
> @@ -1715,10 +1715,12 @@ static void bdrv_get_cumulative_perm(BlockDrive=
rState *bs, uint64_t *perm,
>                                       uint64_t *shared_perm);
> =20
>  typedef struct BlockReopenQueueEntry {
> -     bool prepared;
> -     bool perms_checked;
> -     BDRVReopenState state;
> -     QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
> +    bool reopened_file_child_rw;
> +    bool changed_file_child_perm_rw;
> +    bool prepared;
> +    bool perms_checked;
> +    BDRVReopenState state;
> +    QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
>  } BlockReopenQueueEntry;
> =20
>  /*
> @@ -3421,6 +3423,105 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopen=
Queue *bs_queue,
>                                     keep_old_opts);
>  }
> =20
> +static int bdrv_reopen_set_read_only_drained(BlockDriverState *bs,
> +                                             bool read_only,
> +                                             Error **errp)
> +{
> +    BlockReopenQueue *queue;
> +    QDict *opts =3D qdict_new();
> +
> +    qdict_put_bool(opts, BDRV_OPT_READ_ONLY, read_only);
> +
> +    queue =3D bdrv_reopen_queue(NULL, bs, opts, true);
> +
> +    return bdrv_reopen_multiple(queue, errp);
> +}
> +
> +/*
> + * handle_recursive_reopens
> + *
> + * On fail it needs rollback_recursive_reopens to be called.

It would be nice if this description actually said anything about what
the function is supposed to do.

> + */
> +static int handle_recursive_reopens(BlockReopenQueueEntry *current,
> +                                    Error **errp)
> +{
> +    int ret;
> +    BlockDriverState *bs =3D current->state.bs;
> +
> +    /*
> +     * We use the fact that in reopen-queue children are always follow=
ing
> +     * parents.
> +     * TODO: Switch BlockReopenQueue to be QTAILQ and use
> +     *       QTAILQ_FOREACH_REVERSE.

Why don=E2=80=99t you do that first?  It would make the code more obvious=
 at
least to me.

> +     */
> +    if (QSIMPLEQ_NEXT(current, entry)) {
> +        ret =3D handle_recursive_reopens(QSIMPLEQ_NEXT(current, entry)=
, errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    if ((current->state.flags & BDRV_O_RDWR) && bs->file && bs->drv &&=

> +        bs->drv->bdrv_need_rw_file_child_during_reopen_rw &&
> +        bs->drv->bdrv_need_rw_file_child_during_reopen_rw(bs))
> +    {
> +        if (!bdrv_is_writable(bs->file->bs)) {
> +            ret =3D bdrv_reopen_set_read_only_drained(bs->file->bs, fa=
lse, errp);

Hm.  Sorry, I find this all a bit hard to understand.  (No comments and
all.)

I understand that this is for an RO -> RW transition?  Everything is
still RO, but the parent will need an RW child before it transitions to
RW itself.


I=E2=80=99m going to be honest up front, I don=E2=80=99t like this very m=
uch.  But I
think it may be a reasonable solution for now.

As I remember, the problem was that when reopening a qcow2 node from RO
to RW, we need to write something in .prepare() (because it can fail),
but naturally no .prepare() is called after any .commit(), so no matter
the order of nodes in the ReopenQueue, the child node will never be RW
by this point.

Hm.  To me that mostly means that making the whole reopen process a
transaction was just a dream that turns out not to work.

OK, so what would be the real, proper, all-encompassing fix?  I suppose
we=E2=80=99d need a way to express reopen dependency relationships.  So i=
f a
node depends on one or more of its children to be reopened before/after
it can be reopened itself, we=E2=80=99d need to pull them out of the Reop=
enQueue
(along with their dependencies) and do a separate bdrv_reopen_multiple()
on them.  So we=E2=80=99d want to split the ReopenQueue into as few subqu=
eues as
possible, so that all dependencies are satisfied.

One such dependency is if you change a node from RO to RW, and that
change requires an RW child.

The reverse dependency occurs is if you change a node from RW to RO, and
the nodes wants to write something to its child, so it needs to remain
RW until then.

Currently, the former is just broken (hence this patch).  The latter is
kind of addressed by virtue of =E2=80=9CWriting happens in .prepare(), an=
d
parents come before children in the ReopenQueue=E2=80=9D.


OK, so you address one specific case of a dependency, namely of a node
on its bs->file when it comes to writableness.  Not too bad, supporting
bs->file as the only dependency makes sense.  Everything else would
become complicated.


Besides being more specific than the general solution I tried to sketch
above, there is one more difference, though: In that description, I said
we should remove the node and its dependencies from the ReopenQueue, and
commit it earlier.  That has three implicatons:

First, this patch reopens the file if it is not writable, but the parent
needs it to be writable.  I think that=E2=80=99s wrong.  We should take t=
he
file=E2=80=99s entry of the ReopenQueue and reopen it accordingly, not bl=
indly
reopen it RW.  (If the user didn=E2=80=99t specify the file to be reopene=
d RW,
that should be an error.)

Second, you need to take the dependencies into account.  (I don=E2=80=99t=
 know
whether this one is a problem in practice.)  If the file node itself has
a child that needs to be RW, then you need to take that from the
ReopenQueue, too, and repoen it RW, too.

Third, the reopen may require some other options on the file.
Temporarily reopening it RW without changing those options may not be
what the user wants.  (So another reason to take the existing
ReopenQueue entry.)


So -- without having tried, of course -- I think a better design would
be to look for bs->file->bs in the ReopenQueue, recursively all of its
children, and move all of those entries into a new queue, and then
invoke bdrv_reopen_multiple() on that one first.

The question then becomes how to roll back those changes...  I don=E2=80=99=
t
know whether just having bdrv_reopen() partially succeed is so bad.
Otherwise, we=E2=80=99d need a function to translate an existing node's s=
tate
into a BdrvReopenQueueEntry so we can thus return to the old state.

> +            if (ret < 0) {
> +                return ret;
> +            }
> +            current->reopened_file_child_rw =3D true;
> +        }
> +
> +        if (!(bs->file->perm & BLK_PERM_WRITE)) {
> +            ret =3D bdrv_child_try_set_perm(bs->file,
> +                                          bs->file->perm | BLK_PERM_WR=
ITE,
> +                                          bs->file->shared_perm, errp)=
;

bdrv_child_try_set_perm() is dangerous, because its effect will be
undone whenever something happens that causes the permissions to be
refreshed.  (Hence the comment in block_int.h which says to avoid it.)
Generally, bdrv_child_refresh_perms() should be enough.  If it isn=E2=80=99=
t,
I=E2=80=99d say something=E2=80=99s off.

Max

> +            if (ret < 0) {
> +                return ret;
> +            }
> +            current->changed_file_child_perm_rw =3D true;
> +        }
> +    }
> +
> +    return 0;
> +}


--lTNPetTuBKC6yLFpsSKfETEz4ccfqC3yP--

--HGNFFV4rPmQTX0MHfEqiR4g5tvalwGZt3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1BhOwACgkQ9AfbAGHV
z0BuXAf/fiqRivsUOvKBgYV3hSLc1Gj1b31bapS3G8k32n1AuhTLQPcaNvnp1R9n
rqzEa19i7cXeQUIeEpbKlRosD6bM45W7AkhJHerMA9E60hSNhXQcNtASj7jf19H0
tVUAcb+qyaWio/6ZLpLFfby1rNMV/aK9CQtlNc0pmsmM6WTb7druNGLdLU2RGabn
uu4ZZto6h4/fUeVLsRJ8Fw4lzuo/Y8+piD2gjwgylsRUjl1yE9o4t0MNWBtnuYpB
9e1SsW13QXU+w2qynbL0+BCZRHx4o1+Dal7w5M0fYsD2xKlakUhhYA8XL6staBB9
QuwJmTGfFgXb//Lwf7nk4U/1WPSbMw==
=DtHX
-----END PGP SIGNATURE-----

--HGNFFV4rPmQTX0MHfEqiR4g5tvalwGZt3--

