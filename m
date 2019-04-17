Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC78C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 16:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15DB20674
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 16:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15DB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGnLH-0001S2-N5
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 12:23:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGnKP-00017m-8P
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGnKN-0002Zg-J4
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:22:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hGnK8-0002LO-TT; Wed, 17 Apr 2019 12:22:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 200A1308A10C;
	Wed, 17 Apr 2019 16:22:10 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-140.brq.redhat.com
	[10.40.204.140])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A77A760C64;
	Wed, 17 Apr 2019 16:22:07 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190410202033.28617-1-mreitz@redhat.com>
	<20190410202033.28617-3-mreitz@redhat.com>
	<5a335159-8a98-5c60-657d-920e1eb81065@virtuozzo.com>
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
Message-ID: <f7fa24d8-7608-ecc8-475c-42e3d58ba272@redhat.com>
Date: Wed, 17 Apr 2019 18:22:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5a335159-8a98-5c60-657d-920e1eb81065@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2k48u5JtNJ4D5J8fCU9uaFWo82ruCgJ0V"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 17 Apr 2019 16:22:10 +0000 (UTC)
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
Message-ID: <20190417162205.B5XR_Zu972-goOTIjOncHpC4a63ilTuEgSTguzIp9iM@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2k48u5JtNJ4D5J8fCU9uaFWo82ruCgJ0V
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <f7fa24d8-7608-ecc8-475c-42e3d58ba272@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 02/11] block: Filtered children access
 functions
References: <20190410202033.28617-1-mreitz@redhat.com>
 <20190410202033.28617-3-mreitz@redhat.com>
 <5a335159-8a98-5c60-657d-920e1eb81065@virtuozzo.com>
In-Reply-To: <5a335159-8a98-5c60-657d-920e1eb81065@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.04.19 12:02, Vladimir Sementsov-Ogievskiy wrote:
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
>=20
> really huge... didn't you consider conversion file-by-file?

Frankly, no, I just didn=E2=80=99t consider it.

Hm.  I don=E2=80=99t know, 30-patch series always look so frightening.

>> diff --git a/block.c b/block.c
>> index 16615bc876..e8f6febda0 100644
>> --- a/block.c
>> +++ b/block.c
>=20
> [..]
>=20
>>  =20
>> @@ -3467,14 +3469,17 @@ static int bdrv_reopen_parse_backing(BDRVReope=
nState *reopen_state,
>>       /*
>>        * Find the "actual" backing file by skipping all links that poi=
nt
>>        * to an implicit node, if any (e.g. a commit filter node).
>> +     * We cannot use any of the bdrv_skip_*() functions here because
>> +     * those return the first explicit node, while we are looking for=

>> +     * its overlay here.
>>        */
>>       overlay_bs =3D bs;
>> -    while (backing_bs(overlay_bs) && backing_bs(overlay_bs)->implicit=
) {
>> -        overlay_bs =3D backing_bs(overlay_bs);
>> +    while (overlay_bs->backing && bdrv_filtered_bs(overlay_bs)->impli=
cit) {
>=20
> So, you don't want to skip implicit filters with 'file' child? Then, wh=
y not to use
> child_bs(overlay_bs->backing), like in following if condition?

I think it was an artifact of writing the patch.  I started with
bdrv_filtered_bs() and then realized this depends on ->backing,
actually.  There was no functional difference so I left it as it was.

But you=E2=80=99re right, it is more clear to use child_bs(overlay_bs->ba=
cking)
isntead.

> Could we instead make backing-based filters equal to file-based, to mak=
e it possible
> to use file-based filters in backing-chain related scenarios (like upco=
ming copy-on-read
> filter for stream)? So, to expand backing-chain concept to include filt=
ers with file child?

If I understand you correctly, that=E2=80=99s basically the purpose of th=
is
series and especially this patch here.  As far as it is possible and
reasonable, I want filters that use bs->backing and bs->file behave the
same.

However, there are cases where this is not possible and
bdrv_reopen_parse_backing() is one such case.  bs->backing and bs->file
correspond to QAPI names, namely 'backing' and 'file'.  If that
distinction was already visible to the user, we cannot change it now.

We definitely cannot make file-based filters use bs->backing now because
you can create them over QAPI and they use 'file' as their child name.
Can we make backing-based filters use bs->file?  Seems more likely,
because all of them are implicit nodes, so the user usually doesn=E2=80=99=
t see
them.  But usually isn=E2=80=99t always; they do become user-visible once=
 the
user specifies a node-name for mirror or commit.

I found it more reasonable to introduce new functions that explicitly
express what kind of child they expect and then apply them everywhere as
I saw fit, instead of making the mirror/commit filter drivers use
bs->file and hope it works; not least because I=E2=80=99d still have to g=
o
through the whole block layer and check every instance of bs->backing to
see whether it really needs bs->backing or whether it should use either
of bs->backing or bs->file.

>> +        overlay_bs =3D bdrv_filtered_bs(overlay_bs);
>>       }
>>  =20
>>       /* If we want to replace the backing file we need some extra che=
cks */
>> -    if (new_backing_bs !=3D backing_bs(overlay_bs)) {
>> +    if (new_backing_bs !=3D child_bs(overlay_bs->backing)) { >       =
    /* Check for implicit nodes between bs and its backing file */
>>           if (bs !=3D overlay_bs) {
>>               error_setg(errp, "Cannot change backing link if '%s' has=
 "
>=20
> [..]
>=20
>> @@ -4203,8 +4208,8 @@ int bdrv_change_backing_file(BlockDriverState *b=
s,
>>   BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
>>                                       BlockDriverState *bs)
>>   {
>> -    while (active && bs !=3D backing_bs(active)) {
>> -        active =3D backing_bs(active);
>> +    while (active && bs !=3D bdrv_filtered_bs(active)) {
>=20
> hmm and here you actually support backing-chain with file-child-based f=
ilters in it..

Yes, because this is not about the QAPI 'backing' link.  This function
should continue to work even if there are filters in the backing chain.

>> +        active =3D bdrv_filtered_bs(active);
>>       }
>>  =20
>>       return active;
>> @@ -4226,11 +4231,11 @@ bool bdrv_is_backing_chain_frozen(BlockDriverS=
tate *bs, BlockDriverState *base,
>>   {
>>       BlockDriverState *i;
>>  =20
>> -    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
>> +    for (i =3D bs; i !=3D base; i =3D child_bs(i->backing)) {
>=20
> and here don't..

Yes, because this function is about the QAPI 'backing' link.

>>           if (i->backing && i->backing->frozen) {
>>               error_setg(errp, "Cannot change '%s' link from '%s' to '=
%s'",
>>                          i->backing->name, i->node_name,
>> -                       backing_bs(i)->node_name);
>> +                       i->backing->bs->node_name);
>>               return true;
>>           }
>>       }
>=20
> [..]
>=20
>> +static BlockDriverState *bdrv_skip_filters(BlockDriverState *bs,
>> +                                           bool stop_on_explicit_filt=
er)
>> +{
>> +    BdrvChild *filtered;
>> +
>> +    if (!bs) {
>> +        return NULL;
>> +    }
>> +
>> +    while (!(stop_on_explicit_filter && !bs->implicit)) {
>=20
> you may save some characters and extra operators by
>=20
> bool skip_explicit
> ...
> while (skip_explicit || bs->implicit) {

But is it really simpler?

>> +        filtered =3D bdrv_filtered_rw_child(bs);
>> +        if (!filtered) {
>> +            break;
>> +        }
>> +        bs =3D filtered->bs;
>> +    }
>> +    /*
>> +     * Note that this treats nodes with bs->drv =3D=3D NULL as not be=
ing
>> +     * R/W filters (bs->drv =3D=3D NULL should be replaced by somethi=
ng
>> +     * else anyway).
>> +     * The advantage of this behavior is that this function will thus=

>> +     * always return a non-NULL value (given a non-NULL @bs).
>> +     */
>> +
>> +    return bs;
>> +}
>> +
>> +/*
>> + * Return the first BDS that has not been added implicitly or that
>> + * does not have an RW-filtered child down the chain starting from @b=
s
>> + * (including @bs itself).
>> + */
>> +BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs)
>> +{
>> +    return bdrv_skip_filters(bs, true);
>> +}
>> +
>> +/*
>> + * Return the first BDS that does not have an RW-filtered child down
>> + * the chain starting from @bs (including @bs itself).
>> + */
>> +BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs)
>> +{
>> +    return bdrv_skip_filters(bs, false);
>> +}
>> +
>> +/*
>> + * For a backing chain, return the first non-filter backing image.
>=20
> or second, if we start from filter

Hm, in a sense.  Maybe:

> For a backing chain, return the first non-filter backing image of the
> first non-filter image.

?

>> + */
>> +BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs)
>> +{
>> +    return bdrv_skip_rw_filters(bdrv_filtered_cow_bs(bdrv_skip_rw_fil=
ters(bs)));
>> +}
>=20
>=20
>=20



--2k48u5JtNJ4D5J8fCU9uaFWo82ruCgJ0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAly3Uq0ACgkQ9AfbAGHV
z0BDWQf9FDllEdLqaCTNRpwKCGkFXMIEDxQnM62sNUqrd5buVx1N2TgjO8+020No
5fLlwyuDKjHb3NjayPGxiqEt+4pHgbjv2dbHU9Kw1Us72eYNhF1yeZ/5XE1tSDM+
wr1Keibicpx4p8spLzJvh8plX0p+qLST+wHaCo8auvb2JPYxtgTBTEhXbuv8j7XY
nUZ9oE6TD1Wjh8PmETZa3q56fQFLRBzDKuqUdxIWwcjxN+a/7pgkgRW5cxgDG4U2
wu2e7x6/CMj3aeSLttO0sYsaRLqiWOs1BnoT/1Jut2EYXsoYTi1ClCLVmcG0D9lH
YZhYEuecbdWbSMieRO22lTLKnByQ4w==
=Xzyv
-----END PGP SIGNATURE-----

--2k48u5JtNJ4D5J8fCU9uaFWo82ruCgJ0V--

