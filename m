Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DC6C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED9620881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED9620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38331 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpDd-0008Ab-PW
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:01:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTp2d-0000wA-Hw
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTp2b-0003vg-NK
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:49:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTp2X-0003oB-F3; Thu, 23 May 2019 10:49:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DA2C8110E;
	Thu, 23 May 2019 14:49:52 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 23F695D705;
	Thu, 23 May 2019 14:49:50 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190410202033.28617-1-mreitz@redhat.com>
	<20190410202033.28617-3-mreitz@redhat.com>
	<344eec5c-8908-7b32-5d5f-61911253a621@virtuozzo.com>
	<5794529f-9451-4dd9-c509-07df5cefdead@redhat.com>
	<77165189-05e4-f404-cea7-35a5a19710fc@virtuozzo.com>
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
Message-ID: <f0a29172-4647-b4d8-109e-5eaae5a6ac86@redhat.com>
Date: Thu, 23 May 2019 16:49:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <77165189-05e4-f404-cea7-35a5a19710fc@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pagkjks0BKk72QFVSpnXBLx06nJItwCJ3"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 23 May 2019 14:49:52 +0000 (UTC)
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
--Pagkjks0BKk72QFVSpnXBLx06nJItwCJ3
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <f0a29172-4647-b4d8-109e-5eaae5a6ac86@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/11] block: Filtered children access
 functions
References: <20190410202033.28617-1-mreitz@redhat.com>
 <20190410202033.28617-3-mreitz@redhat.com>
 <344eec5c-8908-7b32-5d5f-61911253a621@virtuozzo.com>
 <5794529f-9451-4dd9-c509-07df5cefdead@redhat.com>
 <77165189-05e4-f404-cea7-35a5a19710fc@virtuozzo.com>
In-Reply-To: <77165189-05e4-f404-cea7-35a5a19710fc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.05.19 13:50, Vladimir Sementsov-Ogievskiy wrote:
> 07.05.2019 18:13, Max Reitz wrote:
>> On 07.05.19 15:30, Vladimir Sementsov-Ogievskiy wrote:
>>> 10.04.2019 23:20, Max Reitz wrote:
>>>> What bs->file and bs->backing mean depends on the node.  For filter
>>>> nodes, both signify a node that will eventually receive all R/W
>>>> accesses.  For format nodes, bs->file contains metadata and data, an=
d
>>>> bs->backing will not receive writes -- instead, writes are COWed to
>>>> bs->file.  Usually.
>>>>
>>>> In any case, it is not trivial to guess what a child means exactly w=
ith
>>>> our currently limited form of expression.  It is better to introduce=

>>>> some functions that actually guarantee a meaning:
>>>>
>>>> - bdrv_filtered_cow_child() will return the child that receives requ=
ests
>>>>     filtered through COW.  That is, reads may or may not be forwarde=
d
>>>>     (depending on the overlay's allocation status), but writes never=
 go to
>>>>     this child.
>>>>
>>>> - bdrv_filtered_rw_child() will return the child that receives reque=
sts
>>>>     filtered through some very plain process.  Reads and writes issu=
ed to
>>>>     the parent will go to the child as well (although timing, etc. m=
ay be
>>>>     modified).
>>>>
>>>> - All drivers but quorum (but quorum is pretty opaque to the general=

>>>>     block layer anyway) always only have one of these children: All =
read
>>>>     requests must be served from the filtered_rw_child (if it exists=
), so
>>>>     if there was a filtered_cow_child in addition, it would not rece=
ive
>>>>     any requests at all.
>>>>     (The closest here is mirror, where all requests are passed on to=
 the
>>>>     source, but with write-blocking, write requests are "COWed" to t=
he
>>>>     target.  But that just means that the target is a special child =
that
>>>>     cannot be introspected by the generic block layer functions, and=
 that
>>>>     source is a filtered_rw_child.)
>>>>     Therefore, we can also add bdrv_filtered_child() which returns t=
hat
>>>>     one child (or NULL, if there is no filtered child).
>>>>
>>>> Also, many places in the current block layer should be skipping filt=
ers
>>>> (all filters or just the ones added implicitly, it depends) when goi=
ng
>>>> through a block node chain.  They do not do that currently, but this=

>>>> patch makes them.
>>>>
>>>> One example for this is qemu-img map, which should skip filters and =
only
>>>> look at the COW elements in the graph.  The change to iotest 204's
>>>> reference output shows how using blkdebug on top of a COW node used =
to
>>>> make qemu-img map disregard the rest of the backing chain, but with =
this
>>>> patch, the allocation in the base image is reported correctly.
>>>>
>>>> Furthermore, a note should be made that sometimes we do want to acce=
ss
>>>> bs->backing directly.  This is whenever the operation in question is=
 not
>>>> about accessing the COW child, but the "backing" child, be it COW or=

>>>> not.  This is the case in functions such as bdrv_open_backing_file()=
 or
>>>> whenever we have to deal with the special behavior of @backing as a
>>>> blockdev option, which is that it does not default to null like all
>>>> other child references do.
>>>>
>>>> Finally, the query functions (query-block and query-named-block-node=
s)
>>>> are modified to return any filtered child under "backing", not just
>>>> bs->backing or COW children.  This is so that filters do not interru=
pt
>>>> the reported backing chain.  This changes the output of iotest 184, =
as
>>>> the throttled node now appears as a backing child.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>    qapi/block-core.json           |   4 +
>>>>    include/block/block.h          |   1 +
>>>>    include/block/block_int.h      |  40 +++++--
>>>>    block.c                        | 210 +++++++++++++++++++++++++++-=
-----
>>>>    block/backup.c                 |   8 +-
>>>>    block/block-backend.c          |  16 ++-
>>>>    block/commit.c                 |  33 +++---
>>>>    block/io.c                     |  45 ++++---
>>>>    block/mirror.c                 |  21 ++--
>>>>    block/qapi.c                   |  30 +++--
>>>>    block/stream.c                 |  13 +-
>>>>    blockdev.c                     |  88 +++++++++++---
>>>>    migration/block-dirty-bitmap.c |   4 +-
>>>>    nbd/server.c                   |   6 +-
>>>>    qemu-img.c                     |  29 ++---
>>>>    tests/qemu-iotests/184.out     |   7 +-
>>>>    tests/qemu-iotests/204.out     |   1 +
>>>>    17 files changed, 411 insertions(+), 145 deletions(-)
>>>>
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index 7ccbfff9d0..dbd9286e4a 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -2502,6 +2502,10 @@
>>>>    # On successful completion the image file is updated to drop the =
backing file
>>>>    # and the BLOCK_JOB_COMPLETED event is emitted.
>>>>    #
>>>> +# In case @device is a filter node, block-stream modifies the first=
 non-filter
>>>> +# overlay node below it to point to base's backing node (or NULL if=
 @base was
>>>> +# not specified) instead of modifying @device itself.
>>>> +#
>>>
>>> Is it necessary, why we can't keep it as is, modifying exactly device=
 node? May be,
>>> user wants to use filter in stream process, throttling for example.
>>
>> That wouldn't make any sense.  Say you have this configuration:
>>
>> throttle -> top -> base
>>
>> Now you stream from base to throttle.  The data goes from base through=

>> throttle to top.  You propose to then make throttle point to base:
>>
>> throttle -> base
>>
>> This will discard all the data in top.
>>
>> Filters don=E2=80=99t store any data.  You need to keep the top data s=
toring
>> image, i.e. the first non-filter overlay.
>=20
> Ah, yes, good reason.
>=20
>>
>>>>    # @job-id: identifier for the newly-created block job. If
>>>>    #          omitted, the device name will be used. (Since 2.7)
>>>>    #
>>
>> [...]
>>
>>>> @@ -2345,7 +2347,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs,=
 BlockDriverState *backing_hd,
>>>>        bool update_inherits_from =3D bdrv_chain_contains(bs, backing=
_hd) &&
>>>>            bdrv_inherits_from_recursive(backing_hd, bs);
>>>>   =20
>>>> -    if (bdrv_is_backing_chain_frozen(bs, backing_bs(bs), errp)) {
>>>> +    if (bdrv_is_backing_chain_frozen(bs, child_bs(bs->backing), err=
p)) {
>>>
>>> If we support file-filters for frozen backing chain, could it go thro=
ugh file child here?
>>> Hmm, only in case when we are going to set backing hd for file-filter=
=2E. Hmm, could filter have
>>> both file and backing children?
>>
>> No.  A filter passes through data from its children, so it can only ha=
ve
>> a single child, or it is quorum.
>>
>> The file/backing combination is reserved for COW overlays.  file is
>> where the current layer=E2=80=99s data is, backing is the filtered chi=
ld.
>=20
> My backup-top has two children - backing and target.. So, I think, we c=
an state that
> filter should not have both file and backing children, but may have any=
 other special
> children he wants, invisible for backing-child/file-child generic logic=
=2E

Ah, yes, sorry, that=E2=80=99s what I meant.  A filter can have only a si=
ngle
filtered child, but other than that, they=E2=80=99re free to have whateve=
r.

[...]

>>> Here we don't want to check the chain, we exactly want to check backi=
ng link, so it should be
>>> something like
>>>
>>> if (bs->backing && bs->backing->frozen) {
>>>      error_setg("backig exists and frozen!");
>>>      return;
>>> }
>>>
>>>
>>> Hmm, on the other hand, if we have frozen backing chain, going throug=
h file child, we must not add
>>> backing child to the node with file child, as it will change backing =
chain (which by default goes
>>> through backing)..
>>>
>>> Anyway, we don't need to check the whole backing chain, as we may fin=
d other frozen backing subchain,
>>> far away of bs.. So, we possibly want to check
>>>
>>> if (bdrv_filtered_child(bs) && bdrv_filtered_child(bs)->frozed) {
>>>     ERROR
>>> }
>>>
>>>
>>> ....
>>>
>>> also, we'll need to check for frozen file child, when we want to repl=
ace it.
>>
>> I don=E2=80=99t quite understand.  It sounds to me like you=E2=80=99re=
 saying we don=E2=80=99t
>> need to check the whole chain here but just the immediate child.  But
>> isn=E2=80=99t that true regardless of this series?
>=20
> If we restrict adding backing child to filter with file child, all beco=
mes simpler and seems to be correct.

OK. :-)

> Should we add check for frozen file child to bdrv_replace_child() ?

Argh.  You mean move it from bdrv_set_backing_hd()?  That actually makes
a lot of sense to me.  The problem is that bdrv_replace_child()
currently cannot return an error, which may be a problem for
bdrv_detach_child().  Hm.  But that=E2=80=99s effectively only called fro=
m
functions where the child is unref=E2=80=99d, and you have to know that y=
our own
child is not frozen before you unref it.  So I guess we should be good
to pass an &error_abort there.

[...]

>>>> @@ -2208,7 +2218,7 @@ static int coroutine_fn bdrv_co_block_status_a=
bove(BlockDriverState *bs,
>>>>        bool first =3D true;
>>>>   =20
>>>>        assert(bs !=3D base);
>>>> -    for (p =3D bs; p !=3D base; p =3D backing_bs(p)) {
>>>> +    for (p =3D bs; p !=3D base; p =3D bdrv_filtered_bs(p)) {
>>>>            ret =3D bdrv_co_block_status(p, want_zero, offset, bytes,=
 pnum, map,
>>>>                                       file);
>>>
>>> Interesting that for filters who use bdrv_co_block_status_from_backin=
g and
>>> bdrv_co_block_status_from_file we will finally call .bdrv_co_block_st=
atus of
>>> underalying real node two or more times.. It's not wrong but obviousl=
y not optimal.
>>
>> Hm.  If @p is a filter, we could skip straight to *file.  Would that w=
ork?
>=20
> No, as file may be not in backing chain:
>=20
> filter
>     |
>     v
> qcow2 -> file
>     |
>     v
> qcow2
>=20
> So, we shouldn't redirect the whole loop to file..

But qcow2 is not a filter.  I meant skipping to *file only if the
current node is a filter.  And I don=E2=80=99t mean bs->file, I mean *fil=
e --
like, what bdrv_co_block_status() returns.

You say in your other mail that filters can have an own implementation
of .bdrv_co_block_status(), but I don=E2=80=99t think that makes sense,
actually.  They should always pass the status of their filtered child.

blkdebug is the only filter I know that has an own implementation, and
the only thing besides passing the data through is add an alignment
assertion.  If it simplifies everything else, I=E2=80=99m very much willi=
ng to
break that.

Max

> May be the correct solution should be introducing additional handler
> .bdrv_co_block_status_above with different logic..


--Pagkjks0BKk72QFVSpnXBLx06nJItwCJ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzmsw0ACgkQ9AfbAGHV
z0DKCAf/bjeHrt7vpc0T7k2rrNcW80oaOCWolNCl2mQpyduX2ngcliWYkBP8EsoJ
Idy4FBXfdEPlbLTM+NzgujuGIG/nTebCnfZvOl3Mdk9uQmjtKBh08xWZKD9iQDeE
swRBSfDsAjGvwi8S//nrrodNkjPhoaPpdTydCO1do73JLNl4MQK4pLbVr1dgVChM
mqZP4l2Vgx1nR8ZjENDVqJ37SC2ybhmuTjLtBv6rDnFfI3hch3e49DMrMsUQTiP9
6t1AQ0QyhnLg4t8Yry6LTT1CZLwHXV80LFnFfqxdCS8bDdB3SBkkJoYju7oebCPa
azbvenF4aOIOyo5u0HXk/4CmHfZ/nQ==
=kANP
-----END PGP SIGNATURE-----

--Pagkjks0BKk72QFVSpnXBLx06nJItwCJ3--

