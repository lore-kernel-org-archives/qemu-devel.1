Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A49C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA0C2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA0C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycSL-0004Mr-0s
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hycJC-0003C8-AY
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hycJA-0005Xm-4z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:30:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hycJ5-0005UC-KP; Fri, 16 Aug 2019 09:30:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D664F81F19;
 Fri, 16 Aug 2019 13:30:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-156.brq.redhat.com
 [10.40.204.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8072317995;
 Fri, 16 Aug 2019 13:30:13 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-36-mreitz@redhat.com>
 <92ded75c-caed-c674-f2ef-72b15b4405b4@virtuozzo.com>
 <39c41687-e192-e63a-984f-6d60b075df1a@redhat.com>
 <694d9499-de27-5aff-c93a-1b78c01160f3@virtuozzo.com>
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
Message-ID: <7fb5ae37-ee74-a235-fb6d-80a93146bbfb@redhat.com>
Date: Fri, 16 Aug 2019 15:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <694d9499-de27-5aff-c93a-1b78c01160f3@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pxbM1Ygj7P4QFcMoPP4svX1hwWBpWaxkJ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 16 Aug 2019 13:30:14 +0000 (UTC)
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
--pxbM1Ygj7P4QFcMoPP4svX1hwWBpWaxkJ
Content-Type: multipart/mixed; boundary="qPRfallPfhRy2QG0KGBExz0V0ZgcFGDd6";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <7fb5ae37-ee74-a235-fb6d-80a93146bbfb@redhat.com>
Subject: Re: [PATCH v6 35/42] block: Fix check_to_replace_node()
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-36-mreitz@redhat.com>
 <92ded75c-caed-c674-f2ef-72b15b4405b4@virtuozzo.com>
 <39c41687-e192-e63a-984f-6d60b075df1a@redhat.com>
 <694d9499-de27-5aff-c93a-1b78c01160f3@virtuozzo.com>
In-Reply-To: <694d9499-de27-5aff-c93a-1b78c01160f3@virtuozzo.com>

--qPRfallPfhRy2QG0KGBExz0V0ZgcFGDd6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.08.19 13:01, Vladimir Sementsov-Ogievskiy wrote:
> 15.08.2019 20:01, Max Reitz wrote:
>> On 15.08.19 17:21, Vladimir Sementsov-Ogievskiy wrote:
>>> 09.08.2019 19:14, Max Reitz wrote:
>>>> Currently, check_to_replace_node() only allows mirror to replace a n=
ode
>>>> in the chain of the source node, and only if it is the first non-fil=
ter
>>>> node below the source.  Well, technically, the idea is that you can
>>>> exactly replace a quorum child by mirroring from quorum.
>>>>
>>>> This has (probably) two reasons:
>>>> (1) We do not want to create loops.
>>>> (2) @replaces and @device should have exactly the same content so
>>>>       replacing them does not cause visible data to change.
>>>>
>>>> This has two issues:
>>>> (1) It is overly restrictive.  It is completely fine for @replaces t=
o be
>>>>       a filter.
>>>> (2) It is not restrictive enough.  You can create loops with this as=

>>>>       follows:
>>>>
>>>> $ qemu-img create -f qcow2 /tmp/source.qcow2 64M
>>>> $ qemu-system-x86_64 -qmp stdio
>>>> {"execute": "qmp_capabilities"}
>>>> {"execute": "object-add",
>>>>    "arguments": {"qom-type": "throttle-group", "id": "tg0"}}
>>>> {"execute": "blockdev-add",
>>>>    "arguments": {
>>>>        "node-name": "source",
>>>>        "driver": "throttle",
>>>>        "throttle-group": "tg0",
>>>>        "file": {
>>>>            "node-name": "filtered",
>>>>            "driver": "qcow2",
>>>>            "file": {
>>>>                "driver": "file",
>>>>                "filename": "/tmp/source.qcow2"
>>>>            } } } }
>>>> {"execute": "drive-mirror",
>>>>    "arguments": {
>>>>        "job-id": "mirror",
>>>>        "device": "source",
>>>>        "target": "/tmp/target.qcow2",
>>>>        "format": "qcow2",
>>>>        "node-name": "target",
>>>>        "sync" :"none",
>>>>        "replaces": "filtered"
>>>>    } }
>>>> {"execute": "block-job-complete", "arguments": {"device": "mirror"}}=

>>>>
>>>> And qemu crashes because of a stack overflow due to the loop being
>>>> created (target's backing file is source, so when it replaces filter=
ed,
>>>> it points to itself through source).
>>>>
>>>> (blockdev-mirror can be broken similarly.)
>>>>
>>>> So let us make the checks for the two conditions above explicit, whi=
ch
>>>> makes the whole function exactly as restrictive as it needs to be.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>    include/block/block.h |  1 +
>>>>    block.c               | 83 ++++++++++++++++++++++++++++++++++++++=
+----
>>>>    blockdev.c            | 34 ++++++++++++++++--
>>>>    3 files changed, 110 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/include/block/block.h b/include/block/block.h
>>>> index 6ba853fb90..8da706cd89 100644
>>>> --- a/include/block/block.h
>>>> +++ b/include/block/block.h
>>>> @@ -404,6 +404,7 @@ bool bdrv_is_first_non_filter(BlockDriverState *=
candidate);
>>>>   =20
>>>>    /* check if a named node can be replaced when doing drive-mirror =
*/
>>>>    BlockDriverState *check_to_replace_node(BlockDriverState *parent_=
bs,
>>>> +                                        BlockDriverState *backing_b=
s,
>>>>                                            const char *node_name, Er=
ror **errp);
>>>>   =20
>>>>    /* async block I/O */
>>>> diff --git a/block.c b/block.c
>>>> index 915b80153c..4858d3e718 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>> @@ -6290,7 +6290,59 @@ bool bdrv_is_first_non_filter(BlockDriverStat=
e *candidate)
>>>>        return false;
>>>>    }
>>>>   =20
>>>> +static bool is_child_of(BlockDriverState *child, BlockDriverState *=
parent)
>>>> +{
>>>> +    BdrvChild *c;
>>>> +
>>>> +    if (!parent) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    QLIST_FOREACH(c, &parent->children, next) {
>>>> +        if (c->bs =3D=3D child || is_child_of(child, c->bs)) {
>>>> +            return true;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return false;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Return true if there are only filters in [@top, @base).  Note th=
at
>>>> + * this may include quorum (which bdrv_chain_contains() cannot
>>>> + * handle).
>>>
>>> More presizely: return true if exists chain of filters from top to ba=
se or if
>>> top =3D=3D base.
>>>
>>> I keep in mind backup-top filter:
>>>
>>> [backup-top]
>>> |          \target
>>
>> backup-top can=E2=80=99t be a filter if it has two children with diffe=
rent
>> contents, though.
>=20
> Why? target is special child, unrelated to what is read/written over ba=
ckup-top.
> It's an own business of backup-top.
>=20
>>
>> (commit-top and mirror-top aren=E2=80=99t filters either.)
>=20
> Ahm, I missed something. They have is_filter =3D true and their childre=
n considered
> to be filtered-rw children in your series? And than, who they are? Form=
at nodes?
> And how they appears in backing chains than?

Er, right, I remember, I made them filters in patch 1 of this series. m( =
:-)

But the chain would still be unique, in a sense, because backup-top only
has one filtered child, so you could go down the chain with
bdrv_filtered_rw_child().

This function doesn=E2=80=99t do that because of Quorum, which is actuall=
y a
better example.  All of its children are filtered, so we must consider
all of them.

But backup-top is actually a reason why this function is wrong as it is;
the target is not a filtered child, so it shouldn=E2=80=99t return true t=
here.

Hmmmm.

Actually, bdrv_recurse_is_first_non_filter() does nearly what we want.
(Which is why it was used here.)  The only problem is that it expects
@candidate to be a non-filter (as the name implies).  But we don=E2=80=99=
t care
about that, actually.

I suppose I can just turn bdrv_recurse_is_first_non_filter() into
bdrv_is_child_of(); it has only two callers, one is here, the other is
bdrv_is_first_non_filter().  In the latter, we can just check whether
@candidate is a filter and return false if it isn=E2=80=99t.

>> That=E2=80=99s why there must be a unique chain [@top, @base).
>>
>> I should probably not that it will return true if top =3D=3D base, tho=
ugh, yes.
>>
>>> |backing    -------->[target]
>>> V                    /
>>> [source]  <---------/backing
>>>
>>>> + */
>>>> +static bool is_filtered_child(BlockDriverState *top, BlockDriverSta=
te *base)
>>>> +{
>>>> +    BdrvChild *c;
>>>> +
>>>> +    if (!top) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    if (top =3D=3D base) {
>>>> +        return true;
>>>> +    }
>>>> +
>>>> +    if (!top->drv->is_filter) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    QLIST_FOREACH(c, &top->children, next) {
>>>> +        if (is_filtered_child(c->bs, base)) {
>>>> +            return true;
>>>> +        }
>>>> +    }
>>>
>>> interesting, how much is it better to somehow reuse DFS search writte=
n in should_update_child()..
>>> [just note, don't do it in these series please]
>>>
>>>> +
>>>> +    return false;
>>>> +}
>>>> +
>>>> +/*
>>>> + * @parent_bs is mirror's source BDS, @backing_bs is the BDS which
>>>> + * will be attached to the target when mirror completes.
>>>> + */
>>>>    BlockDriverState *check_to_replace_node(BlockDriverState *parent_=
bs,
>>>> +                                        BlockDriverState *backing_b=
s,
>>>>                                            const char *node_name, Er=
ror **errp)
>>>>    {
>>>>        BlockDriverState *to_replace_bs =3D bdrv_find_node(node_name)=
;
>>>> @@ -6309,13 +6361,32 @@ BlockDriverState *check_to_replace_node(Bloc=
kDriverState *parent_bs,
>>>>            goto out;
>>>>        }
>>>>   =20
>>>> -    /* We don't want arbitrary node of the BDS chain to be replaced=
 only the top
>>>> -     * most non filter in order to prevent data corruption.
>>>> -     * Another benefit is that this tests exclude backing files whi=
ch are
>>>> -     * blocked by the backing blockers.
>>>> +    /*
>>>> +     * If to_replace_bs is (recursively) a child of backing_bs,
>>>> +     * replacing it may create a loop.  We cannot allow that.
>>>>         */
>>>> -    if (!bdrv_recurse_is_first_non_filter(parent_bs, to_replace_bs)=
) {
>>>> -        error_setg(errp, "Only top most non filter can be replaced"=
);
>>>> +    if (to_replace_bs =3D=3D backing_bs || is_child_of(to_replace_b=
s, backing_bs)) {
>>>
>>> first condition is covered by second, so first may be omitted.
>>
>> It is not.  is_child_of() does not return true if child =3D=3D parent.=

>>
>>>> +        error_setg(errp, "Replacing this node would result in a loo=
p");
>>>> +        to_replace_bs =3D NULL;
>>>> +        goto out;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Mirror is designed in such a way that when it completes, the=

>>>> +     * source BDS is seamlessly replaced.
>>>
>>> Not source but to_replace_bs is replaced?
>>
>> It has originally been designed to replace the source.  If it could
>> replace any arbitrary BDS, all of this would be moot.
>=20
> quorum child, you saying about in commit message?

Which is not any arbitrary BDS, but one that looks exactly like the sourc=
e.

My point is, mirror has been *designed* to replace the source
seamlessly.  It can do more things today, but that was its original point=
=2E

That means that the target must be exactly the same as the source.  And
then we come to this:

>>>> It is therefore not allowed
>>>> +     * to replace a BDS where this condition would be violated, as =
that
>>>> +     * would defeat the purpose of mirror and could lead to data
>>>> +     * corruption.
>>>> +     * Therefore, between parent_bs and to_replace_bs there may be
>>>> +     * only filters (and the one on top must be a filter, too), so
>>>> +     * their data always stays in sync and mirror can complete and
>>>> +     * replace to_replace_bs without any possible corruptions.

So replacing a node that=E2=80=99s connected to the source only through f=
ilters
is fine because that means the replaced node will also have the same
content as the source.


How about I replace the first paragraph with:

At the end of the mirror job, the target exhibits exactly the same
content as the source, so it can replace the source node seamlessly.  It
cannot replace a BDS that differs in content, as that could lead to data
corruption.

?

>>>> +     */
>>>> +    if (!is_filtered_child(parent_bs, to_replace_bs) &&
>>>> +        !is_filtered_child(to_replace_bs, parent_bs))
>>>> +    {
>>>> +        error_setg(errp, "The node to be replaced must be connected=
 to the "
>>>> +                   "source through filter nodes only");
>>>
>>> "and the one on top must be a filter, too" not mentioned in the error=
=2E.
>>
>> Well, unless the source node is the node to be replaced.  Hm...  This
>> gets very hard to express.  I think I=E2=80=99d prefer to keep this as=
 it is,
>> even though it is not quite correct, unless you have a better suggesti=
on
>> of what to report. :-/
>=20
> I can't imaging something better than just add "(and the one on top mus=
t be a filter, too)"

The problem is that =E2=80=9Cthe one on top=E2=80=9D wouldn=E2=80=99t sou=
nd very clear to me as
a user.

Maybe include the explanation =C3=A0 la =E2=80=9CThe node to be replaced =
must be
connected to the source through filter nodes only, so its data is the
exact same at all times=E2=80=9D?  Maybe then users can guess what this
=E2=80=9Cconnected=E2=80=9D means exactly.

>>>>            to_replace_bs =3D NULL;
>>>>            goto out;
>>>>        }
>>>> diff --git a/blockdev.c b/blockdev.c
>>>> index 4e72f6f701..758e0b5431 100644
>>>> --- a/blockdev.c
>>>> +++ b/blockdev.c
>>>> @@ -3887,7 +3887,7 @@ static void blockdev_mirror_common(const char =
*job_id, BlockDriverState *bs,
>>>>        }
>>>>   =20
>>>>        if (has_replaces) {
>>>> -        BlockDriverState *to_replace_bs;
>>>> +        BlockDriverState *to_replace_bs, *backing_bs;
>>>>            AioContext *replace_aio_context;
>>>>            int64_t bs_size, replace_size;
>>>>   =20
>>>> @@ -3897,7 +3897,37 @@ static void blockdev_mirror_common(const char=
 *job_id, BlockDriverState *bs,
>>>>                return;
>>>>            }
>>>>   =20
>>>> -        to_replace_bs =3D check_to_replace_node(bs, replaces, errp)=
;
>>>> +        if (backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN ||
>>>> +            backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN)
>>>> +        {
>>>> +            /*
>>>> +             * While we do not quite know what OPEN_BACKING_CHAIN
>>>> +             * (used for mode=3Dexisting) will yield, it is probabl=
y
>>>> +             * best to restrict it exactly like SOURCE_BACKING_CHAI=
N,
>>>> +             * because that is our best guess.
>>>> +             */
>>>> +            switch (sync) {
>>>> +            case MIRROR_SYNC_MODE_FULL:
>>>> +                backing_bs =3D NULL;
>>>> +                break;
>>>> +
>>>> +            case MIRROR_SYNC_MODE_TOP:
>>>> +                backing_bs =3D bdrv_filtered_cow_bs(bdrv_skip_rw_fi=
lters(bs));
>>>
>>> why not  bdrv_backing_chain_next(bs) like in mirror_start?
>>
>> Good question.  I suppose it should be
>> bdrv_filtered_cow_bs(bdrv_backing_chain_next(bs)) in mirror_start()?
>=20
> You mean bdrv_filtered_cow_bs(bdrv_skip_rw_filters(bs)), I hope)

Er, yes, sure.

>> Because with sync=3Dtop, we just want to remove the topmost COW node (=
and
>> filters on top), but keep filters behind it.
>>
>=20
> Agreed.

OK.

Max


--qPRfallPfhRy2QG0KGBExz0V0ZgcFGDd6--

--pxbM1Ygj7P4QFcMoPP4svX1hwWBpWaxkJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1Wr+MACgkQ9AfbAGHV
z0CXLwgAjjxox2EWGEHitjFtdEZfPHptZ3DIl0JEr8aiq2iJkO49a1Fen2H2+O/L
8jNyZkXa+5EZjBQyjcIkhHFx6o/XWFdK80/tlLMTTFB9rzbESz7j2c3GGS4ARncs
s3cNxToMS8TPCC2Zj/aiX94HxuIaU9dsVZRZ4W0cHZmdcaQGbvuNC8foeh/rmcjw
rvAFFi3tPaq0r7YOYnhZVFzTMxDcSrkIPUMNO5sukOEuqsrcqdOuF5bWXdO/F/pf
mm2I3PZBmxdDG7ioKhzr5i8Vel4SiMLnsKg0r1ArWAR14/kF8RbFDoEQ2o/yG+Xs
5fUASQk40lX0CoB8E/rG0Geo1JhXgw==
=Jx9P
-----END PGP SIGNATURE-----

--pxbM1Ygj7P4QFcMoPP4svX1hwWBpWaxkJ--

