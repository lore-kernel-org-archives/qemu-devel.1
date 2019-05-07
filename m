Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B8BC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642E6205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642E6205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48379 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1o3-0005vS-IT
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:14:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1me-00057I-5x
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1mc-0001Ko-3N
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:13:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO1mX-0001IG-Ev; Tue, 07 May 2019 11:13:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5F7289C3C;
	Tue,  7 May 2019 15:13:24 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E16563BBC;
	Tue,  7 May 2019 15:13:22 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190410202033.28617-1-mreitz@redhat.com>
	<20190410202033.28617-3-mreitz@redhat.com>
	<344eec5c-8908-7b32-5d5f-61911253a621@virtuozzo.com>
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
Message-ID: <5794529f-9451-4dd9-c509-07df5cefdead@redhat.com>
Date: Tue, 7 May 2019 17:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <344eec5c-8908-7b32-5d5f-61911253a621@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eMorwZOVWopjgZeMHJ77chDJmeBPGtSji"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 07 May 2019 15:13:24 +0000 (UTC)
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
--eMorwZOVWopjgZeMHJ77chDJmeBPGtSji
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <5794529f-9451-4dd9-c509-07df5cefdead@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/11] block: Filtered children access
 functions
References: <20190410202033.28617-1-mreitz@redhat.com>
 <20190410202033.28617-3-mreitz@redhat.com>
 <344eec5c-8908-7b32-5d5f-61911253a621@virtuozzo.com>
In-Reply-To: <344eec5c-8908-7b32-5d5f-61911253a621@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.05.19 15:30, Vladimir Sementsov-Ogievskiy wrote:
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
>>   qapi/block-core.json           |   4 +
>>   include/block/block.h          |   1 +
>>   include/block/block_int.h      |  40 +++++--
>>   block.c                        | 210 +++++++++++++++++++++++++++----=
--
>>   block/backup.c                 |   8 +-
>>   block/block-backend.c          |  16 ++-
>>   block/commit.c                 |  33 +++---
>>   block/io.c                     |  45 ++++---
>>   block/mirror.c                 |  21 ++--
>>   block/qapi.c                   |  30 +++--
>>   block/stream.c                 |  13 +-
>>   blockdev.c                     |  88 +++++++++++---
>>   migration/block-dirty-bitmap.c |   4 +-
>>   nbd/server.c                   |   6 +-
>>   qemu-img.c                     |  29 ++---
>>   tests/qemu-iotests/184.out     |   7 +-
>>   tests/qemu-iotests/204.out     |   1 +
>>   17 files changed, 411 insertions(+), 145 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 7ccbfff9d0..dbd9286e4a 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2502,6 +2502,10 @@
>>   # On successful completion the image file is updated to drop the bac=
king file
>>   # and the BLOCK_JOB_COMPLETED event is emitted.
>>   #
>> +# In case @device is a filter node, block-stream modifies the first n=
on-filter
>> +# overlay node below it to point to base's backing node (or NULL if @=
base was
>> +# not specified) instead of modifying @device itself.
>> +#
>=20
> Is it necessary, why we can't keep it as is, modifying exactly device n=
ode? May be,
> user wants to use filter in stream process, throttling for example.

That wouldn't make any sense.  Say you have this configuration:

throttle -> top -> base

Now you stream from base to throttle.  The data goes from base through
throttle to top.  You propose to then make throttle point to base:

throttle -> base

This will discard all the data in top.

Filters don=E2=80=99t store any data.  You need to keep the top data stor=
ing
image, i.e. the first non-filter overlay.

>>   # @job-id: identifier for the newly-created block job. If
>>   #          omitted, the device name will be used. (Since 2.7)
>>   #

[...]

>> @@ -2345,7 +2347,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, B=
lockDriverState *backing_hd,
>>       bool update_inherits_from =3D bdrv_chain_contains(bs, backing_hd=
) &&
>>           bdrv_inherits_from_recursive(backing_hd, bs);
>>  =20
>> -    if (bdrv_is_backing_chain_frozen(bs, backing_bs(bs), errp)) {
>> +    if (bdrv_is_backing_chain_frozen(bs, child_bs(bs->backing), errp)=
) {
>=20
> If we support file-filters for frozen backing chain, could it go throug=
h file child here?
> Hmm, only in case when we are going to set backing hd for file-filter..=
 Hmm, could filter have
> both file and backing children?

No.  A filter passes through data from its children, so it can only have
a single child, or it is quorum.

The file/backing combination is reserved for COW overlays.  file is
where the current layer=E2=80=99s data is, backing is the filtered child.=


> Your new API don't restrict it, and choses backing as a default
> in this case in bdrv_filtered_rw_child(), so, I assume you suppose poss=
ibility of it.

I can add an assertion against it if you=E2=80=99d like.

> Here we don't want to check the chain, we exactly want to check backing=
 link, so it should be
> something like
>=20
> if (bs->backing && bs->backing->frozen) {
>     error_setg("backig exists and frozen!");
>     return;
> }
>=20
>=20
> Hmm, on the other hand, if we have frozen backing chain, going through =
file child, we must not add
> backing child to the node with file child, as it will change backing ch=
ain (which by default goes
> through backing)..
>=20
> Anyway, we don't need to check the whole backing chain, as we may find =
other frozen backing subchain,
> far away of bs.. So, we possibly want to check
>=20
> if (bdrv_filtered_child(bs) && bdrv_filtered_child(bs)->frozed) {
>    ERROR
> }
>=20
>=20
> ....
>=20
> also, we'll need to check for frozen file child, when we want to replac=
e it.

I don=E2=80=99t quite understand.  It sounds to me like you=E2=80=99re sa=
ying we don=E2=80=99t
need to check the whole chain here but just the immediate child.  But
isn=E2=80=99t that true regardless of this series?

>>           return;
>>       }
>>  =20

[...]

>> @@ -3634,7 +3639,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_=
state, BlockReopenQueue *queue,
>>        * its metadata. Otherwise the 'backing' option can be omitted.
>>        */
>>       if (drv->supports_backing && reopen_state->backing_missing &&
>> -        (backing_bs(reopen_state->bs) || reopen_state->bs->backing_fi=
le[0])) {
>> +        (reopen_state->bs->backing || reopen_state->bs->backing_file[=
0])) {
>=20
> and if we skip implicit filters in bdrv_backing_chain_next(), shouldn't=
 we skip them
> here too?

This is a check whether it is mandatory for the user to specify the
'backing' key when reopening @bs.  It is mandatory if it currently has a
backing node, or if it should get a backing file by default because the
image header says so.

We don=E2=80=99t care about any node in particular.  The question is just=
 =E2=80=9CIs
there a backing node?=E2=80=9D.  So I don=E2=80=99t see how skipping filt=
ers would
change anything.

>>           error_setg(errp, "backing is missing for '%s'",
>>                      reopen_state->bs->node_name);
>>           ret =3D -EINVAL;
>> @@ -3779,7 +3784,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_=
state)
>>        * from bdrv_set_backing_hd()) has the new values.
>>        */
>>       if (reopen_state->replace_backing_bs) {
>> -        BlockDriverState *old_backing_bs =3D backing_bs(bs);
>> +        BlockDriverState *old_backing_bs =3D child_bs(bs->backing);
>>           assert(!old_backing_bs || !old_backing_bs->implicit);
>>           /* Abort the permission update on the backing bs we're detac=
hing */
>>           if (old_backing_bs) {
>> @@ -4203,8 +4208,8 @@ int bdrv_change_backing_file(BlockDriverState *b=
s,
>>   BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
>>                                       BlockDriverState *bs)
>>   {
>> -    while (active && bs !=3D backing_bs(active)) {
>> -        active =3D backing_bs(active);
>> +    while (active && bs !=3D bdrv_filtered_bs(active)) {
>=20
> need to adjust comment to the function then, as we may find file-based-=
overlay, not backing.

Yes, true.

>> +        active =3D bdrv_filtered_bs(active);
>>       }
>>  =20
>>       return active;

[...]

>> @@ -4494,10 +4497,14 @@ bool bdrv_is_sg(BlockDriverState *bs)
>>  =20
>>   bool bdrv_is_encrypted(BlockDriverState *bs)
>>   {
>> -    if (bs->backing && bs->backing->bs->encrypted) {
>> +    BlockDriverState *filtered =3D bdrv_filtered_bs(bs);
>> +    if (bs->encrypted) {
>> +        return true;
>> +    }
>> +    if (filtered && bdrv_is_encrypted(filtered)) {
>>           return true;
>>       }
>> -    return bs->encrypted;
>> +    return false;
>>   }
>=20
> one backing child -> recursion through extended backing chain

Yes, but isn=E2=80=99t that what we want?

[...]

>> @@ -4866,20 +4887,24 @@ int bdrv_has_zero_init_1(BlockDriverState *bs)=

>>  =20
>>   int bdrv_has_zero_init(BlockDriverState *bs)
>>   {
>> +    BlockDriverState *filtered;
>> +
>>       if (!bs->drv) {
>>           return 0;
>>       }
>>  =20
>>       /* If BS is a copy on write image, it is initialized to
>>          the contents of the base image, which may not be zeroes.  */
>> -    if (bs->backing) {
>> +    if (bdrv_filtered_cow_child(bs)) {
>>           return 0;
>>       }
>>       if (bs->drv->bdrv_has_zero_init) {
>>           return bs->drv->bdrv_has_zero_init(bs);
>>       }
>> -    if (bs->file && bs->drv->is_filter) {
>> -        return bdrv_has_zero_init(bs->file->bs);
>> +
>> +    filtered =3D bdrv_filtered_rw_bs(bs);
>> +    if (filtered) {
>> +        return bdrv_has_zero_init(filtered);
>>       }
>=20
> add recursion for filters

Not really, we had that before.

>>  =20
>>       /* safe default */

[...]

>> diff --git a/block/backup.c b/block/backup.c
>> index 9988753249..9c08353b23 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -577,6 +577,7 @@ BlockJob *backup_job_create(const char *job_id, Bl=
ockDriverState *bs,
>>       int64_t len;
>>       BlockDriverInfo bdi;
>>       BackupBlockJob *job =3D NULL;
>> +    bool target_does_cow;
>>       int ret;
>>  =20
>>       assert(bs);
>> @@ -671,8 +672,9 @@ BlockJob *backup_job_create(const char *job_id, Bl=
ockDriverState *bs,
>>       /* If there is no backing file on the target, we cannot rely on =
COW if our
>>        * backup cluster size is smaller than the target cluster size. =
Even for
>>        * targets with a backing file, try to avoid COW if possible. */=

>> +    target_does_cow =3D bdrv_filtered_cow_child(target);
>=20
> So, you excluded false-positive case when target is backing-filter. I t=
hink, we'd better skip
> filters here:
>=20
> target_does_cow =3D bdrv_filtered_cow_child(bdrv_skip_rw_filters(target=
))

Sounds correct, yes.

I suppose we then need a fix for compression, too, though.  Currently,
the code checks whether the target driver offers
=2Ebdrv_co_pwritev_compressed().  First, we should do the same there and
skip filters.  But second, in block/io.c, we then need to also skip
filters for compressed writes (by issuing normal writes to them with the
BDRV_REQ_WRITE_COMPRESSED flag set).

>>       ret =3D bdrv_get_info(target, &bdi);
>> -    if (ret =3D=3D -ENOTSUP && !target->backing) {
>> +    if (ret =3D=3D -ENOTSUP && !target_does_cow) {
>>           /* Cluster size is not defined */
>>           warn_report("The target block device doesn't provide "
>>                       "information about the block size and it doesn't=
 have a "

[...]

>> diff --git a/block/io.c b/block/io.c
>> index dfc153b8d8..83c2b6b46a 100644
>> --- a/block/io.c
>> +++ b/block/io.c

[...]

>> @@ -2208,7 +2218,7 @@ static int coroutine_fn bdrv_co_block_status_abo=
ve(BlockDriverState *bs,
>>       bool first =3D true;
>>  =20
>>       assert(bs !=3D base);
>> -    for (p =3D bs; p !=3D base; p =3D backing_bs(p)) {
>> +    for (p =3D bs; p !=3D base; p =3D bdrv_filtered_bs(p)) {
>>           ret =3D bdrv_co_block_status(p, want_zero, offset, bytes, pn=
um, map,
>>                                      file);
>=20
> Interesting that for filters who use bdrv_co_block_status_from_backing =
and
> bdrv_co_block_status_from_file we will finally call .bdrv_co_block_stat=
us of
> underalying real node two or more times.. It's not wrong but obviously =
not optimal.

Hm.  If @p is a filter, we could skip straight to *file.  Would that work=
?

[...]

>> diff --git a/block/mirror.c b/block/mirror.c
>> index 8b2404051f..80cef587f0 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -660,8 +660,9 @@ static int mirror_exit_common(Job *job)
>>                               &error_abort);
>>       if (!abort && s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN=
) {
>>           BlockDriverState *backing =3D s->is_none_mode ? src : s->bas=
e;
>> -        if (backing_bs(target_bs) !=3D backing) {
>> -            bdrv_set_backing_hd(target_bs, backing, &local_err);
>> +        if (bdrv_backing_chain_next(target_bs) !=3D backing) {
>> +            bdrv_set_backing_hd(bdrv_skip_rw_filters(target_bs), back=
ing,
>=20
> hmm, here you support filters above target_bs ...
>=20
>> +                                &local_err);
>>               if (local_err) {
>>                   error_report_err(local_err);
>>                   ret =3D -EPERM;
>> @@ -711,7 +712,7 @@ static int mirror_exit_common(Job *job)
>>       block_job_remove_all_bdrv(bjob);
>>       bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,=

>>                               &error_abort);
>> -    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &erro=
r_abort);
>> +    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &err=
or_abort);
>>  =20
>>       /* We just changed the BDS the job BB refers to (with either or =
both of the
>>        * bdrv_replace_node() calls), so switch the BB back so the clea=
nup does
>> @@ -903,7 +904,7 @@ static int coroutine_fn mirror_run(Job *job, Error=
 **errp)
>>       } else {
>>           s->target_cluster_size =3D BDRV_SECTOR_SIZE;
>>       }
>> -    if (backing_filename[0] && !target_bs->backing &&
>> +    if (backing_filename[0] && !bdrv_filtered_cow_child(target_bs) &&=

>=20
> ... and here - not

Hm, yes, I think that is a mistake.  I=E2=80=99ll try to fix it.

> [stopped here for now]

Thanks so far! :-)

Max


--eMorwZOVWopjgZeMHJ77chDJmeBPGtSji
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzRoJEACgkQ9AfbAGHV
z0BITAf7BOBab8SYDY+6gzStYBKkbNWYaDyVcK64UVTQh7T8KEaOCJbp/bMSbVlt
4072LdAvAeYydoD6Qi1Fj27y9qsraSm5pjNvUvl70eVFmE+AxFL2Sl24W5Vb6BjA
LRsWP+QgtyDRUnwPXRX99Qo8cEg/u7dEC5M2cknFiZMfhgZtEkSuTcjfbAUURB5q
2sbALOQKdXN2/NtpkZad5dbxp/s51RFGe6dmfnP0PtJLHGNLkIpNv0ttG+yAd2wd
JEOp6/jTezSY59vA/ZedefES1D/wRpUo7j/NzKHalcnUA6Jc03OgVVUj2OccvMED
LW1FP8IKEZvwLwc3TnfeqiZb9o4Vfg==
=E+OM
-----END PGP SIGNATURE-----

--eMorwZOVWopjgZeMHJ77chDJmeBPGtSji--

