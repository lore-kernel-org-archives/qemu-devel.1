Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD517C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 17:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A107C205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 17:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A107C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyJE6-0003os-ID
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 13:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hyJ8d-0008AH-IL
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hyJ8Z-0005cU-Gy
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:02:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hyJ8K-0005VU-HU; Thu, 15 Aug 2019 13:01:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D16383064FD4;
 Thu, 15 Aug 2019 17:01:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-81.brq.redhat.com
 [10.40.204.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D6E91001947;
 Thu, 15 Aug 2019 17:01:50 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-36-mreitz@redhat.com>
 <92ded75c-caed-c674-f2ef-72b15b4405b4@virtuozzo.com>
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
Message-ID: <39c41687-e192-e63a-984f-6d60b075df1a@redhat.com>
Date: Thu, 15 Aug 2019 19:01:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <92ded75c-caed-c674-f2ef-72b15b4405b4@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0ED8TDdAXiYfA82Xudm5GsoVFGK92Yuhk"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 15 Aug 2019 17:01:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 35/42] block: Fix check_to_replace_node()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0ED8TDdAXiYfA82Xudm5GsoVFGK92Yuhk
Content-Type: multipart/mixed; boundary="iknqjXsBS9vF0WMTsODD2p8OBYx6CK9V5";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <39c41687-e192-e63a-984f-6d60b075df1a@redhat.com>
Subject: Re: [PATCH v6 35/42] block: Fix check_to_replace_node()
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-36-mreitz@redhat.com>
 <92ded75c-caed-c674-f2ef-72b15b4405b4@virtuozzo.com>
In-Reply-To: <92ded75c-caed-c674-f2ef-72b15b4405b4@virtuozzo.com>

--iknqjXsBS9vF0WMTsODD2p8OBYx6CK9V5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.08.19 17:21, Vladimir Sementsov-Ogievskiy wrote:
> 09.08.2019 19:14, Max Reitz wrote:
>> Currently, check_to_replace_node() only allows mirror to replace a nod=
e
>> in the chain of the source node, and only if it is the first non-filte=
r
>> node below the source.  Well, technically, the idea is that you can
>> exactly replace a quorum child by mirroring from quorum.
>>
>> This has (probably) two reasons:
>> (1) We do not want to create loops.
>> (2) @replaces and @device should have exactly the same content so
>>      replacing them does not cause visible data to change.
>>
>> This has two issues:
>> (1) It is overly restrictive.  It is completely fine for @replaces to =
be
>>      a filter.
>> (2) It is not restrictive enough.  You can create loops with this as
>>      follows:
>>
>> $ qemu-img create -f qcow2 /tmp/source.qcow2 64M
>> $ qemu-system-x86_64 -qmp stdio
>> {"execute": "qmp_capabilities"}
>> {"execute": "object-add",
>>   "arguments": {"qom-type": "throttle-group", "id": "tg0"}}
>> {"execute": "blockdev-add",
>>   "arguments": {
>>       "node-name": "source",
>>       "driver": "throttle",
>>       "throttle-group": "tg0",
>>       "file": {
>>           "node-name": "filtered",
>>           "driver": "qcow2",
>>           "file": {
>>               "driver": "file",
>>               "filename": "/tmp/source.qcow2"
>>           } } } }
>> {"execute": "drive-mirror",
>>   "arguments": {
>>       "job-id": "mirror",
>>       "device": "source",
>>       "target": "/tmp/target.qcow2",
>>       "format": "qcow2",
>>       "node-name": "target",
>>       "sync" :"none",
>>       "replaces": "filtered"
>>   } }
>> {"execute": "block-job-complete", "arguments": {"device": "mirror"}}
>>
>> And qemu crashes because of a stack overflow due to the loop being
>> created (target's backing file is source, so when it replaces filtered=
,
>> it points to itself through source).
>>
>> (blockdev-mirror can be broken similarly.)
>>
>> So let us make the checks for the two conditions above explicit, which=

>> makes the whole function exactly as restrictive as it needs to be.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   include/block/block.h |  1 +
>>   block.c               | 83 +++++++++++++++++++++++++++++++++++++++--=
--
>>   blockdev.c            | 34 ++++++++++++++++--
>>   3 files changed, 110 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 6ba853fb90..8da706cd89 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -404,6 +404,7 @@ bool bdrv_is_first_non_filter(BlockDriverState *ca=
ndidate);
>>  =20
>>   /* check if a named node can be replaced when doing drive-mirror */
>>   BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,=

>> +                                        BlockDriverState *backing_bs,=

>>                                           const char *node_name, Error=
 **errp);
>>  =20
>>   /* async block I/O */
>> diff --git a/block.c b/block.c
>> index 915b80153c..4858d3e718 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6290,7 +6290,59 @@ bool bdrv_is_first_non_filter(BlockDriverState =
*candidate)
>>       return false;
>>   }
>>  =20
>> +static bool is_child_of(BlockDriverState *child, BlockDriverState *pa=
rent)
>> +{
>> +    BdrvChild *c;
>> +
>> +    if (!parent) {
>> +        return false;
>> +    }
>> +
>> +    QLIST_FOREACH(c, &parent->children, next) {
>> +        if (c->bs =3D=3D child || is_child_of(child, c->bs)) {
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +/*
>> + * Return true if there are only filters in [@top, @base).  Note that=

>> + * this may include quorum (which bdrv_chain_contains() cannot
>> + * handle).
>=20
> More presizely: return true if exists chain of filters from top to base=
 or if
> top =3D=3D base.
>=20
> I keep in mind backup-top filter:
>=20
> [backup-top]
> |          \target

backup-top can=E2=80=99t be a filter if it has two children with differen=
t
contents, though.

(commit-top and mirror-top aren=E2=80=99t filters either.)

That=E2=80=99s why there must be a unique chain [@top, @base).

I should probably not that it will return true if top =3D=3D base, though=
, yes.

> |backing    -------->[target]
> V                    /
> [source]  <---------/backing
>=20
>> + */
>> +static bool is_filtered_child(BlockDriverState *top, BlockDriverState=
 *base)
>> +{
>> +    BdrvChild *c;
>> +
>> +    if (!top) {
>> +        return false;
>> +    }
>> +
>> +    if (top =3D=3D base) {
>> +        return true;
>> +    }
>> +
>> +    if (!top->drv->is_filter) {
>> +        return false;
>> +    }
>> +
>> +    QLIST_FOREACH(c, &top->children, next) {
>> +        if (is_filtered_child(c->bs, base)) {
>> +            return true;
>> +        }
>> +    }
>=20
> interesting, how much is it better to somehow reuse DFS search written =
in should_update_child()..
> [just note, don't do it in these series please]
>=20
>> +
>> +    return false;
>> +}
>> +
>> +/*
>> + * @parent_bs is mirror's source BDS, @backing_bs is the BDS which
>> + * will be attached to the target when mirror completes.
>> + */
>>   BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,=

>> +                                        BlockDriverState *backing_bs,=

>>                                           const char *node_name, Error=
 **errp)
>>   {
>>       BlockDriverState *to_replace_bs =3D bdrv_find_node(node_name);
>> @@ -6309,13 +6361,32 @@ BlockDriverState *check_to_replace_node(BlockD=
riverState *parent_bs,
>>           goto out;
>>       }
>>  =20
>> -    /* We don't want arbitrary node of the BDS chain to be replaced o=
nly the top
>> -     * most non filter in order to prevent data corruption.
>> -     * Another benefit is that this tests exclude backing files which=
 are
>> -     * blocked by the backing blockers.
>> +    /*
>> +     * If to_replace_bs is (recursively) a child of backing_bs,
>> +     * replacing it may create a loop.  We cannot allow that.
>>        */
>> -    if (!bdrv_recurse_is_first_non_filter(parent_bs, to_replace_bs)) =
{
>> -        error_setg(errp, "Only top most non filter can be replaced");=

>> +    if (to_replace_bs =3D=3D backing_bs || is_child_of(to_replace_bs,=
 backing_bs)) {
>=20
> first condition is covered by second, so first may be omitted.

It is not.  is_child_of() does not return true if child =3D=3D parent.

>> +        error_setg(errp, "Replacing this node would result in a loop"=
);
>> +        to_replace_bs =3D NULL;
>> +        goto out;
>> +    }
>> +
>> +    /*
>> +     * Mirror is designed in such a way that when it completes, the
>> +     * source BDS is seamlessly replaced. =20
>=20
> Not source but to_replace_bs is replaced?

It has originally been designed to replace the source.  If it could
replace any arbitrary BDS, all of this would be moot.

>> It is therefore not allowed
>> +     * to replace a BDS where this condition would be violated, as th=
at
>> +     * would defeat the purpose of mirror and could lead to data
>> +     * corruption.
>> +     * Therefore, between parent_bs and to_replace_bs there may be
>> +     * only filters (and the one on top must be a filter, too), so
>> +     * their data always stays in sync and mirror can complete and
>> +     * replace to_replace_bs without any possible corruptions.
>> +     */
>> +    if (!is_filtered_child(parent_bs, to_replace_bs) &&
>> +        !is_filtered_child(to_replace_bs, parent_bs))
>> +    {
>> +        error_setg(errp, "The node to be replaced must be connected t=
o the "
>> +                   "source through filter nodes only");
>=20
> "and the one on top must be a filter, too" not mentioned in the error..=


Well, unless the source node is the node to be replaced.  Hm...  This
gets very hard to express.  I think I=E2=80=99d prefer to keep this as it=
 is,
even though it is not quite correct, unless you have a better suggestion
of what to report. :-/

>>           to_replace_bs =3D NULL;
>>           goto out;
>>       }
>> diff --git a/blockdev.c b/blockdev.c
>> index 4e72f6f701..758e0b5431 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3887,7 +3887,7 @@ static void blockdev_mirror_common(const char *j=
ob_id, BlockDriverState *bs,
>>       }
>>  =20
>>       if (has_replaces) {
>> -        BlockDriverState *to_replace_bs;
>> +        BlockDriverState *to_replace_bs, *backing_bs;
>>           AioContext *replace_aio_context;
>>           int64_t bs_size, replace_size;
>>  =20
>> @@ -3897,7 +3897,37 @@ static void blockdev_mirror_common(const char *=
job_id, BlockDriverState *bs,
>>               return;
>>           }
>>  =20
>> -        to_replace_bs =3D check_to_replace_node(bs, replaces, errp);
>> +        if (backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN ||
>> +            backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN)
>> +        {
>> +            /*
>> +             * While we do not quite know what OPEN_BACKING_CHAIN
>> +             * (used for mode=3Dexisting) will yield, it is probably
>> +             * best to restrict it exactly like SOURCE_BACKING_CHAIN,=

>> +             * because that is our best guess.
>> +             */
>> +            switch (sync) {
>> +            case MIRROR_SYNC_MODE_FULL:
>> +                backing_bs =3D NULL;
>> +                break;
>> +
>> +            case MIRROR_SYNC_MODE_TOP:
>> +                backing_bs =3D bdrv_filtered_cow_bs(bdrv_skip_rw_filt=
ers(bs));
>=20
> why not  bdrv_backing_chain_next(bs) like in mirror_start?

Good question.  I suppose it should be
bdrv_filtered_cow_bs(bdrv_backing_chain_next(bs)) in mirror_start()?
Because with sync=3Dtop, we just want to remove the topmost COW node (and=

filters on top), but keep filters behind it.

Max

>> +                break;
>> +
>> +            case MIRROR_SYNC_MODE_NONE:
>> +                backing_bs =3D bs;
>> +                break;
>> +
>> +            default:
>> +                abort();
>> +            }
>> +        } else {
>> +            assert(backing_mode =3D=3D MIRROR_LEAVE_BACKING_CHAIN);
>> +            backing_bs =3D bdrv_filtered_cow_bs(bdrv_skip_rw_filters(=
target));
>> +        }
>> +
>> +        to_replace_bs =3D check_to_replace_node(bs, backing_bs, repla=
ces, errp);
>>           if (!to_replace_bs) {
>>               return;
>>           }
>>
>=20
>=20



--iknqjXsBS9vF0WMTsODD2p8OBYx6CK9V5--

--0ED8TDdAXiYfA82Xudm5GsoVFGK92Yuhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1Vj/wACgkQ9AfbAGHV
z0C21Af/d757Bg+lFZw43leowdQ8VXlVwMmQZEncBrb4u9AmM+bMGekz4H+d5Nty
Nh2jUrVS3T2ClN3yGlHUSZyl1/SFGEVHA3BXDtbr4JflgsLBhs+fuA4AEHzdPhUe
Nf+wFJB125GeH4bKgvHKuBqjT3hfF6eTEHRLeheuv4c3sau7Kvj+fBKFdBFpFHnf
6mKW8avZinJ0uCd6tXAeaShfjd+6cIvH2dn77FeV2kND8gbokAqAuk5IX7SaMMiu
wQFcoByXMuZBRvXlO3z7ddC1iAmrn1g7uG4JVzYeu64kU76nObOt5tyUh+GI9vYg
JEr1kMUpB8LcXWzH2qmFxu5oI2F5iQ==
=iAZJ
-----END PGP SIGNATURE-----

--0ED8TDdAXiYfA82Xudm5GsoVFGK92Yuhk--

