Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1145C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DB42084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DB42084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctfp-0005hN-Sh
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53062)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hct3r-0007ha-VI
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hct3o-0006Yn-QF
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hct3j-0006Tf-6B; Mon, 17 Jun 2019 10:56:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2988231628F1;
 Mon, 17 Jun 2019 14:56:26 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECEBD7EA34;
 Mon, 17 Jun 2019 14:56:16 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
 <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
 <46f18bb5-f123-b20a-7cb9-97caedae8290@redhat.com>
 <13b8c3d7-dd95-d42f-e7bc-86907444b78a@virtuozzo.com>
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
Message-ID: <9a6a5790-c9ff-e8a4-3a41-4aebe554ae1c@redhat.com>
Date: Mon, 17 Jun 2019 16:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <13b8c3d7-dd95-d42f-e7bc-86907444b78a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CHFwZiVs8Kg08rsujl6VHqSBtMbpWEeKa"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 17 Jun 2019 14:56:26 +0000 (UTC)
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CHFwZiVs8Kg08rsujl6VHqSBtMbpWEeKa
Content-Type: multipart/mixed; boundary="dTQ78IpkNIgH2XX8Z9o85TuRdslgPUk9J";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "eblake@redhat.com" <eblake@redhat.com>
Message-ID: <9a6a5790-c9ff-e8a4-3a41-4aebe554ae1c@redhat.com>
Subject: Re: [PATCH v8 4/7] block: introduce backup-top filter driver
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
 <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
 <46f18bb5-f123-b20a-7cb9-97caedae8290@redhat.com>
 <13b8c3d7-dd95-d42f-e7bc-86907444b78a@virtuozzo.com>
In-Reply-To: <13b8c3d7-dd95-d42f-e7bc-86907444b78a@virtuozzo.com>

--dTQ78IpkNIgH2XX8Z9o85TuRdslgPUk9J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.06.19 12:36, Vladimir Sementsov-Ogievskiy wrote:
> 14.06.2019 23:03, Max Reitz wrote:
>> On 14.06.19 18:22, Vladimir Sementsov-Ogievskiy wrote:
>>> 14.06.2019 15:57, Max Reitz wrote:
>>>> On 14.06.19 11:04, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 13.06.2019 18:57, Max Reitz wrote:
>>>>>> On 29.05.19 17:46, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> Backup-top filter does copy-before-write operation. It should be
>>>>>>> inserted above active disk and has a target node for CBW, like th=
e
>>>>>>> following:
>>>>>>>
>>>>>>>        +-------+
>>>>>>>        | Guest |
>>>>>>>        +-------+
>>>>>>>            |r,w
>>>>>>>            v
>>>>>>>        +------------+  target   +---------------+
>>>>>>>        | backup_top |---------->| target(qcow2) |
>>>>>>>        +------------+   CBW     +---------------+
>>>>>>>            |
>>>>>>> backing |r,w
>>>>>>>            v
>>>>>>>        +-------------+
>>>>>>>        | Active disk |
>>>>>>>        +-------------+
>>>>>>>
>>>>>>> The driver will be used in backup instead of write-notifiers.
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo=
=2Ecom>
>>>>>>> ---
>>>>>>>     block/backup-top.h  |  64 +++++++++
>>>>>>>     block/backup-top.c  | 322 +++++++++++++++++++++++++++++++++++=
+++++++++
>>>>>>>     block/Makefile.objs |   2 +
>>>>>>>     3 files changed, 388 insertions(+)
>>>>>>>     create mode 100644 block/backup-top.h
>>>>>>>     create mode 100644 block/backup-top.c
>>>>>>>
>>>>>>> diff --git a/block/backup-top.h b/block/backup-top.h
>>>>>>> new file mode 100644
>>>>>>> index 0000000000..788e18c358
>>>>>>> --- /dev/null
>>>>>>> +++ b/block/backup-top.h
>>>>
>>>> [...]
>>>>
>>>>>>> +/*
>>>>>>> + * bdrv_backup_top_append
>>>>>>> + *
>>>>>>> + * Append backup_top filter node above @source node. @target nod=
e will receive
>>>>>>> + * the data backed up during CBE operations. New filter together=
 with @target
>>>>>>> + * node are attached to @source aio context.
>>>>>>> + *
>>>>>>> + * The resulting filter node is implicit.
>>>>>>
>>>>>> Why?  It=E2=80=99s just as easy for the caller to just make it imp=
licit if it
>>>>>> should be.  (And usually the caller should decide that.)
>>>>>
>>>>> Personally, I don't know what are the reasons for filters to bi imp=
licit or not,
>>>>> I just made it like other job-filters.. I can move making-implicit =
to the caller
>>>>> or drop it at all (if it will work).
>>>>
>>>> Nodes are implicit if they haven=E2=80=99t been added consciously by=
 the user.
>>>> A node added by a block job can be non-implicit, too, as mirror show=
s;
>>>> If the user specifies the filter-node-name option, they will know ab=
out
>>>> the node, thus it is no longer implicit.
>>>>
>>>> If the user doesn=E2=80=99t know about the node (they didn=E2=80=99t=
 give the
>>>> filter-node-name option), the node is implicit.
>>>>
>>>
>>> Ok, I understand it. But it doesn't show, why it should be implicit?
>>> Isn't it less buggy to make all filters explicit? We don't hide impli=
cit nodes
>>> from query-named-block-nodes (the only interface to explore the whole=
 graph for now)
>>> anyway. And we can't absolutely hide side effects of additional node =
in the graph.
>>
>> Well, we try, at least.  At least we hide them from query-block.
>>
>>> So, is there any real benefit of supporting separation into implicit =
and explicit filters?
>>> It seems for me that it only complicates things...
>>> In other words, what will break if we make all filters explicit?
>>
>> The theory is that qemu may decide to add nodes at any point, but at
>> least when managing chains etc., they may not be visible to the user. =
 I
>> don=E2=80=99t think we can get rid of them so easily.
>>
>> One example that isn=E2=80=99t implemented yet is copy-on-read.  In th=
eory,
>> specifying copy-on-read=3Don for -drive should create an implicit COR =
node
>> on top.  The user shouldn=E2=80=99t see that node when inspecting the =
drive or
>> when issuing block jobs on it, etc.  And this node has to stay there
>> when the user does e.g. an active commit somewhere down the chain.
>=20
> Why instead not to just write in doc that yes, filter is created when y=
ou
> enable copy-on-read?

Because the problem is that existing users are not aware of that.

If they were, they could simply create a COR filter already.

I suppose we could interpret the deprecation policy in a way that we
could change the behavior of -drive copy-on-read=3Don, but as I already
said, what=E2=80=99s the point of supporting -drive copy-on-read=3Don, wh=
en you
can simply explicitly create a COR filter on top?

> And do same for all operations which may create filter,
> we don't have a lot of them? And add optional parameter to set node-nam=
e for
> created filter.

That optional parameter exists, and if it is given, the user shows that
they are aware of the node.  Hence the node becomes explicit then.

The problem is with legacy users that use an existing interface and
suddenly the externally visible interface of qemu changes in a way that
could break them.  I suppose additional entries in
query-named-block-nodes is not breakage.  Maybe it is, that would be a
bug then.

(If nobody has noticed so far, that may be because these legacy
applications didn=E2=80=99t use query-named-block-nodes.  But now maybe l=
ibvirt
does, and so if we converted copy-on-read=3Don to a COR node, it would
notice now and thus break.  So just because our handling of implicit
nodes is broken right now does not mean we can abandon the concept
altogether.)

>> That sounds like a horrible ordeal to implement, so it hasn=E2=80=99t =
been done
>> yet.  Maybe it never will.  It isn=E2=80=99t that bad for the job filt=
ers,
>> because they generally freeze the block graph, so there is no problem
>> with potential modifications.
>>
>> All in all I do think having implicit nodes makes sense.  Maybe not so=

>> much now, but in the future (if someone implements converting -drive C=
OR
>> and throttle options to implicit nodes...).
>=20
> But do we have at least strong definition of how implicit nodes should =
behave
> on any graph-modifying operations around them?

No.  Depends on the node.

> Should new implicit/explicit
> filters be created above or under them?

That was always the most difficult question we had when we introduced
filters.

The problem is that we never answered it in our code base.

One day, we just added filters (=E2=80=9Clet=E2=80=99s see what happens=E2=
=80=9D), and in the
beginning, they were all explicit, so we still didn=E2=80=99t have to ans=
wer
this question (in code).  Then job filters were added, and we still
didn=E2=80=99t have to, because they set blockers so the graph couldn=E2=80=
=99t be
reorganized with them in place anyway.

If we converted copy-on-read=3Don to a COR node, we would have to answer
that question.

> We should specify it in doc about all
> such operations, otherwise effect of implicit nodes may change unpredic=
tably for
> the user. I'm afraid, that implicit filters will just continue my list =
of
> features which should not be used if we want to be able to maintain all=
 this mess..

Yeah, well, that is nothing new at all.  For example, note the =E2=80=9CS=
plit
I/O throttling off into own BDS =E2=80=93 Requires some care with snapsho=
ts
etc.=E2=80=9D here:
https://wiki.qemu.org/ToDo/Block#Dynamic_graph_reconfiguration_.28e.g._ad=
ding_block_filters.2C_taking_snapshots.2C_etc..29

This was always a problem.  It was always the biggest problem with
filters.  We never answered it because it never become an acute problem,
as I described above.

We just said =E2=80=9CFor explicit filters, they just stay where they are=
, and
that=E2=80=99s OK because the user can take care of them.=E2=80=9D  We ne=
ver did add the
implicit filters that were actually going to become a problem (COR and
throttle).

So as I said above, the behavior of implicit nodes needs to be examined
on a case-by-case basis.  Well, actually, this is only about COR and
throttle, really, and both would behave the same: Always stay at the
BlockBackend, because that is the behavior when you currently use
BB-level throttling or COR.

The jobs that now use implicit nodes freeze the graph, so there is no
problem there.

(Also, by the way, we do not need the option to give COR/throttle nodes
created through BB options a node name.  As I said above, at that point
you can just create the node yourself.)

> 1. If you something around filenames don't work, use node-names, and be=
tter
> don't use filename-based APIs

I think we agree that filename-based APIs were a mistake.  (Though only
in hindsight.  They were added when there where no node names, so it did
make sense then.)

So now you should not use them, correct.

> 2. If you qemu-img can't do what you need, use paused qemu process, and=
 better,
> don't use qemu-img

There was always a plan to give qemu-img feature parity to qemu proper.
 But often the interface is just a problem.  Node names really don=E2=80=99=
t
make much sense with qemu-img, I think.

(I mean, feel free to add something that automatically names the backing
nodes e.g. backing.0, backing.1, etc., and then add an interface to
qemu-img commit to use node names, but I find that weird.)

So I don=E2=80=99t quite see the problem.  Of course qemu has more functi=
onality
than qemu-img.  qemu-img is fine as long as you have a simple set-up,
but once it gets more complicated, you need management software; and
that software shouldn=E2=80=99t care much whether it uses qemu-img or qem=
u itself.

> and a new one:
>=20
> 3. If something is broken around jobs and filters and any block operati=
ons,
> set filter-node-name in parameters to make filter node explicit. And be=
tter,
> always set it..

Uh, yeah?  I don=E2=80=99t see the problem here.

This is like saying =E2=80=9CIf I want to use new features, I should use
-blockdev and not -hda=E2=80=9D.  Yes, that is correct.  You should set
filter-node-name if you care about the exact state of the graph.

> So at least, I think we should make it possible for all filters to be e=
xplicit
> if user wants, by setting its name like in mirror.

For all filters that the user has no other way of creating them, yes.
(That is, the filters created by the block jobs.)

> (and then, I will not really care of implicit-filters related logic, li=
ke I don't
> really care about filename-api related logic)
>=20
> Also, now, implict filters are actually available for direct manipulati=
on by user,
> as their node-names are exported in query-named-block-nodes and nothing=
 prevents
> using these names in differet APIs.

Hm, yes.  Is that a problem?

>>>> [...]
>>>>
>>>>>>> +static int coroutine_fn backup_top_co_flush(BlockDriverState *bs=
)
>>>>>>> +{
>>>>>>> +    if (!bs->backing) {
>>>>>>> +        return 0;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return bdrv_co_flush(bs->backing->bs);
>>>>>>
>>>>>> Should we flush the target, too?
>>>>>
>>>>> Hm, you've asked it already, on previous version :)
>>>>
>>>> I wasn=E2=80=99t sure...
>>>>
>>>>> Backup don't do it,
>>>>> so I just keep old behavior. And what is the reason to flush backup=
 target
>>>>> on any guest flush?
>>>>
>>>> Hm, well, what=E2=80=99s the reason not to do it?
>>>
>>> guest flushes will be slowed down?
>>
>> Hm, the user could specify cache=3Dunsafe if they don=E2=80=99t care. =
 Which gives
>> me second thoughs... [1]
>>
>>>> Also, there are not only guest flushes.  bdrv_flush_all() exists, wh=
ich
>>>> is called when the guest is stopped.  So who is going to flush the
>>>> target if not its parent?
>>>>
>>>> [...]
>>>
>>> Backup job? But filter should not relay on it..
>>
>> Hm.  Backup job actually doesn=E2=80=99t sound that wrong.
>>
>>> But should really filter do that job, or it is here only to do CBW? M=
aybe target
>>> must have another parent which will care about flushing.
>>>
>>> Ok, I think I'll flush target here too for safety, and leave a commen=
t, that something
>>> smarter would be better.
>>> (or, if we decide to flush all children by default in generic code, I=
'll drop this handler)
>>
>> [1] Thinking more about this, for normal backups the target file does
>> not reflect a valid disk state until the backup is done; just like for=

>> qemu-img convert.  Just like qemu-img convert, there is therefore no
>> reason to flush the target until the job is done.
>>
>> But there is also the other case of image fleecing.  In this case, the=

>> target will have another parent, so bdrv_flush_all() will be done by
>> someone.  Still, it intuitively makes sense to me that in this case, t=
he
>> backup-top filter should flush the target if the guest decides to flus=
h
>> the device (so that the target stays consistent on disk).
>>
>> backup-top currently cannot differentiate between the cases, but maybe=

>> that is generally a useful hint to give to it?  (That is, whether the
>> target has a consistent state or not.)
>=20
> Hmm, for fleecing we don't need consistent state of temporary image. If=
 something fails,
> the whole operation is considered to be failed. And anyway, I don't see=
 relations
> between consistency of temporary fleecing image and guest flushes, why =
should we
> bind them?

Guest flushes are about clearing the cache and keeping the disk state
consistent in case of e.g. power failure.  So if the target should be
consistent, it too should then survive a power failure.

Hm, but then again, if we don=E2=80=99t enforce on the host that the targ=
et is
always flushed before the source, that consistency is quickly lost when
the host decides to flush the cache just because it wants to.

Hmmm.  I guess we could say that the target is always inconsistent on
e.g. power failure.

My problem is that the target is also, well, a backup, you know.  So
it=E2=80=99s kind of a pain if we don=E2=80=99t care about it.  The user =
probably wanted
to save that old data, and now it may be lost just because we didn=E2=80=99=
t
flush it when the user entered =E2=80=9Csync=E2=80=9D in the VM.  I don=E2=
=80=99t know.

Max


--dTQ78IpkNIgH2XX8Z9o85TuRdslgPUk9J--

--CHFwZiVs8Kg08rsujl6VHqSBtMbpWEeKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0Hqg8ACgkQ9AfbAGHV
z0CuUgf+N6n/jS9pTEhlYwIN1DH3Bt6H0uGSQzdztodwWLuCZtEFgS5sDZo79g7u
ysR6eEcdGfZ0gBnltAH8ywDjIFCZA5T+fpWQM+YE5ImxJAygc4PpkA/R6ibBgx56
0sCeUBRey9CI+hazesdXlaSTUlqTIiWJ8Pa8ikgpvJSw3PNy7AA45i8eKRWRz1sa
Kr7ki9liaZB2uTwRoLgsQYppY3UME/WwH5d6YEsZmnsbaFsXNqhO9Ts6UL1+s90T
KgI5srCVHbWTW5rR3EkE7t4SZebA9UKvAEq/8Ygni1gIiWvONPfBrX8WZms/wqsW
C94A/iW4OD1STxJs0AMIW+KA8SAh/A==
=svsv
-----END PGP SIGNATURE-----

--CHFwZiVs8Kg08rsujl6VHqSBtMbpWEeKa--

