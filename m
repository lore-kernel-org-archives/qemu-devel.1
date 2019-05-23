Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302F9C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95C32133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 17:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95C32133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTrZE-0006Go-Uh
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 13:31:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTrVh-00048b-8I
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTrVf-0006MY-5b
	for qemu-devel@nongnu.org; Thu, 23 May 2019 13:28:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTrVa-0006Cy-Hk; Thu, 23 May 2019 13:28:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 936053004419;
	Thu, 23 May 2019 17:28:01 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 33A326838D;
	Thu, 23 May 2019 17:28:00 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190410202033.28617-1-mreitz@redhat.com>
	<20190410202033.28617-3-mreitz@redhat.com>
	<04bde52f-4403-de9f-6ecf-8b39b77b3b06@virtuozzo.com>
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
Message-ID: <29203d9d-ca76-5244-ed50-f7b5d04b99d9@redhat.com>
Date: Thu, 23 May 2019 19:27:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <04bde52f-4403-de9f-6ecf-8b39b77b3b06@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="64tmMG6uWYh1Rh4vdd1mo8r2ej5cUiKhV"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 23 May 2019 17:28:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 02/11] block: Filtered children access
 functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--64tmMG6uWYh1Rh4vdd1mo8r2ej5cUiKhV
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <29203d9d-ca76-5244-ed50-f7b5d04b99d9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/11] block: Filtered children access
 functions
References: <20190410202033.28617-1-mreitz@redhat.com>
 <20190410202033.28617-3-mreitz@redhat.com>
 <04bde52f-4403-de9f-6ecf-8b39b77b3b06@virtuozzo.com>
In-Reply-To: <04bde52f-4403-de9f-6ecf-8b39b77b3b06@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.05.19 16:50, Vladimir Sementsov-Ogievskiy wrote:
> 10.04.2019 23:20, Max Reitz wrote:
>> What bs->file and bs->backing mean depends on the node.  For filter
>> nodes, both signify a node that will eventually receive all R/W
>> accesses.  For format nodes, bs->file contains metadata and data, and
>> bs->backing will not receive writes -- instead, writes are COWed to
>> bs->file.  Usually.
>>
>> In any case, it is not trivial to guess what a child means exactly wit=
h
>> our currently limited form of expression.  It is better to introduce
>> some functions that actually guarantee a meaning:
>>
>> - bdrv_filtered_cow_child() will return the child that receives reques=
ts
>>    filtered through COW.  That is, reads may or may not be forwarded
>>    (depending on the overlay's allocation status), but writes never go=
 to
>>    this child.
>>
>> - bdrv_filtered_rw_child() will return the child that receives request=
s
>>    filtered through some very plain process.  Reads and writes issued =
to
>>    the parent will go to the child as well (although timing, etc. may =
be
>>    modified).
>>
>> - All drivers but quorum (but quorum is pretty opaque to the general
>>    block layer anyway) always only have one of these children: All rea=
d
>>    requests must be served from the filtered_rw_child (if it exists), =
so
>>    if there was a filtered_cow_child in addition, it would not receive=

>>    any requests at all.
>>    (The closest here is mirror, where all requests are passed on to th=
e
>>    source, but with write-blocking, write requests are "COWed" to the
>>    target.  But that just means that the target is a special child tha=
t
>>    cannot be introspected by the generic block layer functions, and th=
at
>>    source is a filtered_rw_child.)
>>    Therefore, we can also add bdrv_filtered_child() which returns that=

>>    one child (or NULL, if there is no filtered child).
>>
>> Also, many places in the current block layer should be skipping filter=
s
>> (all filters or just the ones added implicitly, it depends) when going=

>> through a block node chain.  They do not do that currently, but this
>> patch makes them.
>>
>> One example for this is qemu-img map, which should skip filters and on=
ly
>> look at the COW elements in the graph.  The change to iotest 204's
>> reference output shows how using blkdebug on top of a COW node used to=

>> make qemu-img map disregard the rest of the backing chain, but with th=
is
>> patch, the allocation in the base image is reported correctly.
>>
>> Furthermore, a note should be made that sometimes we do want to access=

>> bs->backing directly.  This is whenever the operation in question is n=
ot
>> about accessing the COW child, but the "backing" child, be it COW or
>> not.  This is the case in functions such as bdrv_open_backing_file() o=
r
>> whenever we have to deal with the special behavior of @backing as a
>> blockdev option, which is that it does not default to null like all
>> other child references do.
>>
>> Finally, the query functions (query-block and query-named-block-nodes)=

>> are modified to return any filtered child under "backing", not just
>> bs->backing or COW children.  This is so that filters do not interrupt=

>> the reported backing chain.  This changes the output of iotest 184, as=

>> the throttled node now appears as a backing child.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
> [..]
>=20
>> --- a/block/mirror.c
>> +++ b/block/mirror.c

[...]

>> @@ -1650,7 +1651,9 @@ static void mirror_start_job(const char *job_id,=
 BlockDriverState *bs,
>>        * any jobs in them must be blocked */
>>       if (target_is_backing) {
>>           BlockDriverState *iter;
>> -        for (iter =3D backing_bs(bs); iter !=3D target; iter =3D back=
ing_bs(iter)) {
>> +        for (iter =3D bdrv_filtered_bs(bs); iter !=3D target;
>=20
> should it be filtered_target too?

Hmm...  The comment says that all nodes that disappear must be blocked.
 I don=E2=80=99t even know by heart which nodes I let disappear. :-/

I suppose we should start at the first explicit node, filter or not...?

>> +             iter =3D bdrv_filtered_bs(iter))
>> +        {
>>               /* XXX BLK_PERM_WRITE needs to be allowed so we don't bl=
ock
>>                * ourselves at s->base (if writes are blocked for a nod=
e, they are
>>                * also blocked for its backing file). The other options=
 would be a

[...]

>> @@ -1707,14 +1710,14 @@ void mirror_start(const char *job_id, BlockDri=
verState *bs,
>>                     MirrorCopyMode copy_mode, Error **errp)
>>   {
>>       bool is_none_mode;
>> -    BlockDriverState *base;
>> +    BlockDriverState *base =3D NULL;
>=20
> dead assignment

Now I wonder why I even have that.  Probably an artifact from some
intermediate point.

>>  =20
>>       if (mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
>>           error_setg(errp, "Sync mode 'incremental' not supported");
>>           return;
>>       }
>>       is_none_mode =3D mode =3D=3D MIRROR_SYNC_MODE_NONE;
>> -    base =3D mode =3D=3D MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL=
;
>> +    base =3D mode =3D=3D MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_ne=
xt(bs) : NULL;
>>       mirror_start_job(job_id, bs, creation_flags, target, replaces,
>>                        speed, granularity, buf_size, backing_mode,
>>                        on_source_error, on_target_error, unmap, NULL, =
NULL,
>> diff --git a/block/qapi.c b/block/qapi.c
>> index 110d05dc57..478c6f5e0d 100644
>> --- a/block/qapi.c
>> +++ b/block/qapi.c

[...]

>> @@ -535,9 +538,10 @@ static BlockStats *bdrv_query_bds_stats(BlockDriv=
erState *bs,
>>           s->parent =3D bdrv_query_bds_stats(bs->file->bs, blk_level);=

>>       }
>>  =20
>> -    if (blk_level && bs->backing) {
>> +    cow_bs =3D bdrv_filtered_cow_bs(bs);
>=20
> So, if we at blk_level and top bs is explicit filter, you don't want to=
 show it's
> child?

I do.  It=E2=80=99s in s->parent.  I thought it makes sense to change the=

existing bs->file vs. bs->backing to storage vs. COW.

> Hmm, at least, we can't show it if it is file-child, as qapi filed alre=
ady called
> backing. So, if we can't show for file-child-based filters, it may be b=
etter to not
> show filter children here at all.
>=20
>> +    if (blk_level && cow_bs) {
>>           s->has_backing =3D true;
>> -        s->backing =3D bdrv_query_bds_stats(bs->backing->bs, blk_leve=
l);
>> +        s->backing =3D bdrv_query_bds_stats(cow_bs, blk_level);
>>       }
>>  =20
>>       return s;
>> diff --git a/block/stream.c b/block/stream.c
>> index bfaebb861a..23d5c890e0 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -65,6 +65,7 @@ static int stream_prepare(Job *job)
>>       StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.j=
ob);
>>       BlockJob *bjob =3D &s->common;
>>       BlockDriverState *bs =3D blk_bs(bjob->blk);
>> +    BlockDriverState *unfiltered =3D bdrv_skip_rw_filters(bs);
>=20
> Aha, I'd call it filtered, but unfiltered is correct too, it's amazing

Haha :-)

I think it=E2=80=99s all rather insane than amazing, but, well, insanity =
never
ceases to amaze, does it.

>>       BlockDriverState *base =3D s->base;
>>       Error *local_err =3D NULL;
>>       int ret =3D 0;
>> @@ -72,7 +73,7 @@ static int stream_prepare(Job *job)

[...]

>> @@ -121,7 +122,7 @@ static int coroutine_fn stream_run(Job *job, Error=
 **errp)
>>       int64_t n =3D 0; /* bytes */
>>       void *buf;
>>  =20
>> -    if (!bs->backing) {
>> +    if (!bdrv_filtered_child(bs)) {
>>           goto out;
>>       }
>=20
> this condition checks that there is nothing to stream, so, I thing it's=
 better to check
> if (!bdrv_backing_chain_next(bs)) {
>    goto out;
> }

Ah, sure.

>> @@ -162,7 +163,7 @@ static int coroutine_fn stream_run(Job *job, Error=
 **errp)
>>           } else if (ret >=3D 0) {
>>               /* Copy if allocated in the intermediate images.  Limit =
to the
>>                * known-unallocated area [offset, offset+n*BDRV_SECTOR_=
SIZE).  */
>> -            ret =3D bdrv_is_allocated_above(backing_bs(bs), base,
>> +            ret =3D bdrv_is_allocated_above(bdrv_filtered_bs(bs), bas=
e,
>>                                             offset, n, &n);
>=20
> Hmm, if we trying to support bs to be filter, and actually operate on f=
irst-non-filter,
> as you write in qapi spec, this is wrong. Again it should be
> bdrv_filtered_cow_bs(bdrv_skip_rw_filters(bs))..

Would bdrv_backing_chain_next() fulfill the same purpose?  It can=E2=80=99=
t be
allocated in a filter node, after all.

> Or, may be better, we at stream start should calculate reald top bs to =
operate on, and
> forget about all filters above.. i.e., do bs =3D bdrv_skip_rw_filters(b=
s) at the very
> beginning, when creating a job.

Sounds reasonable.  We can ignore all the filters on top of the
(un)filtered top anyway.

>>               /* Finish early if end of backing file has been reached =
*/
>> @@ -268,7 +269,9 @@ void stream_start(const char *job_id, BlockDriverS=
tate *bs,
>>        * disappear from the chain after this operation. The streaming =
job reads
>>        * every block only once, assuming that it doesn't change, so bl=
ock writes
>>        * and resizes. */
>> -    for (iter =3D backing_bs(bs); iter && iter !=3D base; iter =3D ba=
cking_bs(iter)) {
>> +    for (iter =3D bdrv_filtered_bs(bs); iter && iter !=3D base;
>> +         iter =3D bdrv_filtered_bs(iter))
>> +    {
>>           block_job_add_bdrv(&s->common, "intermediate node", iter, 0,=

>>                              BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE=
_UNCHANGED,
>>                              &error_abort);
>> diff --git a/blockdev.c b/blockdev.c
>> index 4775a07d93..bb71b8368d 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -1094,7 +1094,7 @@ void hmp_commit(Monitor *mon, const QDict *qdict=
)
>>               return;
>>           }
>>  =20
>> -        bs =3D blk_bs(blk);
>> +        bs =3D bdrv_skip_implicit_filters(blk_bs(blk));
>>           aio_context =3D bdrv_get_aio_context(bs);
>>           aio_context_acquire(aio_context);
>>  =20
>> @@ -1663,7 +1663,7 @@ static void external_snapshot_prepare(BlkActionS=
tate *common,
>>           goto out;
>>       }
>>  =20
>> -    if (state->new_bs->backing !=3D NULL) {
>> +    if (bdrv_filtered_cow_child(state->new_bs)) {
>=20
> Do we allow to create filter snapshot? We should either restrict it exp=
licitly or
> check bdrv_filtered_child here.. And we can't allow file-based-filters =
anyway..

Hm, yes, we should probably check both (separately to give better error
messages).

In theory it might be possible to allow filters on top, but there isn=E2=80=
=99t
really any point.  If someone wants to add filters on top of the
snapshot, they should use reopen.

> [skipped up to the end of blockdev.c, I'm tired o_O]

I can very much relate. :-)

Your review definitely is much appreciated.

>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bi=
tmap.c
>> index d1bb863cb6..f99f753fba 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -285,9 +285,7 @@ static int init_dirty_bitmap_migration(void)
>>           const char *drive_name =3D bdrv_get_device_or_node_name(bs);=

>>  =20
>>           /* skip automatically inserted nodes */
>> -        while (bs && bs->drv && bs->implicit) {
>> -            bs =3D backing_bs(bs);
>> -        }
>> +        bs =3D bdrv_skip_implicit_filters(bs);
>=20
> this intersects with Jonh's patch
> [PATCH v2] migration/dirty-bitmaps: change bitmap enumeration method
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03340.html

Well.  I=E2=80=99m not really considerate of other patches with this seri=
es.
Rebasing is always such a pain that I just write it for the current
master.  I won=E2=80=99t incorporate unmerged series because doing so may=
 cause
me to have to rebase more than once.

And I can=E2=80=99t get this series merged soon enough because it=E2=80=99=
s just wrong
that I (and you) have to the one(s) thinking about how to treat filters
everywhere.  It should be the people that introduce the code.

>>           for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>>                bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap))
>> diff --git a/nbd/server.c b/nbd/server.c
>> index e21bd501dc..e41ae89dbe 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -1506,13 +1506,13 @@ NBDExport *nbd_export_new(BlockDriverState *bs=
, uint64_t dev_offset,
>>       if (bitmap) {
>>           BdrvDirtyBitmap *bm =3D NULL;
>>  =20
>> -        while (true) {
>> +        while (bs) {
>>               bm =3D bdrv_find_dirty_bitmap(bs, bitmap);
>> -            if (bm !=3D NULL || bs->backing =3D=3D NULL) {
>> +            if (bm !=3D NULL) {
>>                   break;
>>               }
>>  =20
>> -            bs =3D bs->backing->bs;
>> +            bs =3D bdrv_filtered_bs(bs);
>>           }
>=20
> Check in documentation: "@bitmap: Also export the dirty bitmap reachabl=
e from @device".
>=20
> "Reachable" is not bad, but we may want to clarify that extended backin=
g chain is meant

Hm...  Isn=E2=80=99t that just a problem with the current documentation?

I think this change in code better fits what I=E2=80=99d guess from =E2=80=
=9Creachable=E2=80=9D
than what it currently means.

>>           if (bm =3D=3D NULL) {
>> diff --git a/qemu-img.c b/qemu-img.c
>> index aa6f81f1ea..bcfbb743fc 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c

[...]

>> @@ -2434,7 +2433,8 @@ static int img_convert(int argc, char **argv)
>>            * s.target_backing_sectors has to be negative, which it wil=
l
>>            * be automatically).  The backing file length is used only
>>            * for optimizations, so such a case is not fatal. */
>> -        s.target_backing_sectors =3D bdrv_nb_sectors(out_bs->backing-=
>bs);
>> +        s.target_backing_sectors =3D
>> +            bdrv_nb_sectors(bdrv_filtered_cow_bs(out_bs));
>=20
> can't out_bs be filter itself?

why would you do that

More serious, well, perhaps, in theory.  In practice I really cannot
imagine why it would be.

>=20
>>       } else {
>>           s.target_backing_sectors =3D -1;
>>       }
>> @@ -2797,6 +2797,7 @@ static int get_block_status(BlockDriverState *bs=
, int64_t offset,
>>  =20
>>       depth =3D 0;
>>       for (;;) {
>> +        bs =3D bdrv_skip_rw_filters(bs);
>=20
> Why? Filters may have own implementation of block_status, why to skip i=
t?
>=20
> Or, thay cannot? Really, may be disallow filters have block_status, we =
may solve
> inefficient block_status_above we talked about before.

As said in the other subthread, I think ignoring filters here is fine.

Max

>>           ret =3D bdrv_block_status(bs, offset, bytes, &bytes, &map, &=
file);
>>           if (ret < 0) {
>>               return ret;


--64tmMG6uWYh1Rh4vdd1mo8r2ej5cUiKhV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzm2B4ACgkQ9AfbAGHV
z0Cg8Af9GorKkkPnb2tWw2Cs7fuM6teGRikAMbSaDI8pjv/CvxtTizNW0UIrGKwW
d3IVbGePlwDoAUdzUbpggWiSr0wHeX4h7prh/KGuWmLTmaJlQp1g9ouPnoAge4Zn
H7JXHUYxJUHw+Ue6A3viRwOIkbeM3bhlRcNEo6sCfaYZzfvZDQzHTSkR1qZj7xBS
9jUXERiXrDl68Krd62wJ6yrfd+S1583pf5pHvo8K2ywz8s/m7Fjs0SOixob8KDBZ
Pb8WDTXmLp0BBIG1/imhl8yDdzxCnByiQ1xk706O1AvZSMHkhqc5QBUdqPbup4JY
dHRtae4N4MIjZ1Dbt/g3uEadc5kp0Q==
=xFzY
-----END PGP SIGNATURE-----

--64tmMG6uWYh1Rh4vdd1mo8r2ej5cUiKhV--

