Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69435C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B5920863
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B5920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuq2-0004Px-Lf
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hcu5Q-0004iI-Pg
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hcu5M-00073t-Sy
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:02:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hcu5C-0006qy-Bh; Mon, 17 Jun 2019 12:02:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 595B430860A5;
 Mon, 17 Jun 2019 16:02:03 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05AE491F36;
 Mon, 17 Jun 2019 16:01:55 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
 <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
 <46f18bb5-f123-b20a-7cb9-97caedae8290@redhat.com>
 <13b8c3d7-dd95-d42f-e7bc-86907444b78a@virtuozzo.com>
 <9a6a5790-c9ff-e8a4-3a41-4aebe554ae1c@redhat.com>
 <20190617155315.GK7397@linux.fritz.box>
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
Message-ID: <b86c6a8f-7a89-58ca-6966-b2f00aff0f2b@redhat.com>
Date: Mon, 17 Jun 2019 18:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617155315.GK7397@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1bm9mDgqORzN9oRH8WgDczkyCqL3yt2J5"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 17 Jun 2019 16:02:03 +0000 (UTC)
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1bm9mDgqORzN9oRH8WgDczkyCqL3yt2J5
Content-Type: multipart/mixed; boundary="I1jiS7VNzk2BIZXX72R46KcO9fKxRH4VL";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>
Message-ID: <b86c6a8f-7a89-58ca-6966-b2f00aff0f2b@redhat.com>
Subject: Re: [PATCH v8 4/7] block: introduce backup-top filter driver
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
 <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
 <46f18bb5-f123-b20a-7cb9-97caedae8290@redhat.com>
 <13b8c3d7-dd95-d42f-e7bc-86907444b78a@virtuozzo.com>
 <9a6a5790-c9ff-e8a4-3a41-4aebe554ae1c@redhat.com>
 <20190617155315.GK7397@linux.fritz.box>
In-Reply-To: <20190617155315.GK7397@linux.fritz.box>

--I1jiS7VNzk2BIZXX72R46KcO9fKxRH4VL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.06.19 17:53, Kevin Wolf wrote:
> Am 17.06.2019 um 16:56 hat Max Reitz geschrieben:
>> On 17.06.19 12:36, Vladimir Sementsov-Ogievskiy wrote:
>>> 14.06.2019 23:03, Max Reitz wrote:
>>>> On 14.06.19 18:22, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 14.06.2019 15:57, Max Reitz wrote:
>>>>>> On 14.06.19 11:04, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> 13.06.2019 18:57, Max Reitz wrote:
>>>>>>>> On 29.05.19 17:46, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>>> Backup-top filter does copy-before-write operation. It should b=
e
>>>>>>>>> inserted above active disk and has a target node for CBW, like =
the
>>>>>>>>> following:
>>>>>>>>>
>>>>>>>>>        +-------+
>>>>>>>>>        | Guest |
>>>>>>>>>        +-------+
>>>>>>>>>            |r,w
>>>>>>>>>            v
>>>>>>>>>        +------------+  target   +---------------+
>>>>>>>>>        | backup_top |---------->| target(qcow2) |
>>>>>>>>>        +------------+   CBW     +---------------+
>>>>>>>>>            |
>>>>>>>>> backing |r,w
>>>>>>>>>            v
>>>>>>>>>        +-------------+
>>>>>>>>>        | Active disk |
>>>>>>>>>        +-------------+
>>>>>>>>>
>>>>>>>>> The driver will be used in backup instead of write-notifiers.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuoz=
zo.com>
>>>>>>>>> ---
>>>>>>>>>     block/backup-top.h  |  64 +++++++++
>>>>>>>>>     block/backup-top.c  | 322 +++++++++++++++++++++++++++++++++=
+++++++++++
>>>>>>>>>     block/Makefile.objs |   2 +
>>>>>>>>>     3 files changed, 388 insertions(+)
>>>>>>>>>     create mode 100644 block/backup-top.h
>>>>>>>>>     create mode 100644 block/backup-top.c
>>>>>>>>>
>>>>>>>>> diff --git a/block/backup-top.h b/block/backup-top.h
>>>>>>>>> new file mode 100644
>>>>>>>>> index 0000000000..788e18c358
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/block/backup-top.h
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>>> +/*
>>>>>>>>> + * bdrv_backup_top_append
>>>>>>>>> + *
>>>>>>>>> + * Append backup_top filter node above @source node. @target n=
ode will receive
>>>>>>>>> + * the data backed up during CBE operations. New filter togeth=
er with @target
>>>>>>>>> + * node are attached to @source aio context.
>>>>>>>>> + *
>>>>>>>>> + * The resulting filter node is implicit.
>>>>>>>>
>>>>>>>> Why?  It=E2=80=99s just as easy for the caller to just make it i=
mplicit if it
>>>>>>>> should be.  (And usually the caller should decide that.)
>>>>>>>
>>>>>>> Personally, I don't know what are the reasons for filters to bi i=
mplicit or not,
>>>>>>> I just made it like other job-filters.. I can move making-implici=
t to the caller
>>>>>>> or drop it at all (if it will work).
>>>>>>
>>>>>> Nodes are implicit if they haven=E2=80=99t been added consciously =
by the user.
>>>>>> A node added by a block job can be non-implicit, too, as mirror sh=
ows;
>>>>>> If the user specifies the filter-node-name option, they will know =
about
>>>>>> the node, thus it is no longer implicit.
>>>>>>
>>>>>> If the user doesn=E2=80=99t know about the node (they didn=E2=80=99=
t give the
>>>>>> filter-node-name option), the node is implicit.
>>>>>>
>>>>>
>>>>> Ok, I understand it. But it doesn't show, why it should be implicit=
?
>>>>> Isn't it less buggy to make all filters explicit? We don't hide imp=
licit nodes
>>>>> from query-named-block-nodes (the only interface to explore the who=
le graph for now)
>>>>> anyway. And we can't absolutely hide side effects of additional nod=
e in the graph.
>>>>
>>>> Well, we try, at least.  At least we hide them from query-block.
>>>>
>>>>> So, is there any real benefit of supporting separation into implici=
t and explicit filters?
>>>>> It seems for me that it only complicates things...
>>>>> In other words, what will break if we make all filters explicit?
>>>>
>>>> The theory is that qemu may decide to add nodes at any point, but at=

>>>> least when managing chains etc., they may not be visible to the user=
=2E  I
>>>> don=E2=80=99t think we can get rid of them so easily.
>=20
> I think the important point to understand here is that implicit filters=

> are a concept to maintain compatibility with legacy (pre-blockdev)
> management tools which simply don't manage stuff on the node level. So
> changing the structure of the graph is not a problem for them and we
> just need to make sure that when they do something with a BlockBackend,=

> we perform the action on the node that they actually mean.
>=20
> Modern management tools are expected to manage the graph on a node leve=
l
> and to assign node names to everything.
>=20
> Note that libvirt is close to becoming a modern management tool, so it'=
s
> probably a good idea to now make all block jobs add filters where we'll=

> need them in the long run.
>=20
>>>> One example that isn=E2=80=99t implemented yet is copy-on-read.  In =
theory,
>>>> specifying copy-on-read=3Don for -drive should create an implicit CO=
R node
>>>> on top.  The user shouldn=E2=80=99t see that node when inspecting th=
e drive or
>>>> when issuing block jobs on it, etc.  And this node has to stay there=

>>>> when the user does e.g. an active commit somewhere down the chain.
>>>
>>> Why instead not to just write in doc that yes, filter is created when=
 you
>>> enable copy-on-read?
>>
>> Because the problem is that existing users are not aware of that.
>>
>> If they were, they could simply create a COR filter already.
>>
>> I suppose we could interpret the deprecation policy in a way that we
>> could change the behavior of -drive copy-on-read=3Don, but as I alread=
y
>> said, what=E2=80=99s the point of supporting -drive copy-on-read=3Don,=
 when you
>> can simply explicitly create a COR filter on top?
>=20
> I actually changed my opinion on how to do this since we introduced
> implicit filters. I know think that the right way to move forward is to=

> make sure that the copy-on-read filter can do everything it needs to do=
,
> and then just completely deprecate -drive copy-on-read=3Don instead of
> adding compatibility magic to turn it into an implicit copy-on-read
> filter internally.

Sure, so your answer to =E2=80=9Cwhat=E2=80=99s the point of supporting -=
drive
copy-on-read=3Don=E2=80=9D is =E2=80=9Cthere is none=E2=80=9D.  Fair enou=
gh. :-)

>>>> That sounds like a horrible ordeal to implement, so it hasn=E2=80=99=
t been done
>>>> yet.  Maybe it never will.  It isn=E2=80=99t that bad for the job fi=
lters,
>>>> because they generally freeze the block graph, so there is no proble=
m
>>>> with potential modifications.
>>>>
>>>> All in all I do think having implicit nodes makes sense.  Maybe not =
so
>>>> much now, but in the future (if someone implements converting -drive=
 COR
>>>> and throttle options to implicit nodes...).
>>>
>>> But do we have at least strong definition of how implicit nodes shoul=
d behave
>>> on any graph-modifying operations around them?
>>
>> No.  Depends on the node.
>>
>>> Should new implicit/explicit
>>> filters be created above or under them?
>>
>> That was always the most difficult question we had when we introduced
>> filters.
>>
>> The problem is that we never answered it in our code base.
>>
>> One day, we just added filters (=E2=80=9Clet=E2=80=99s see what happen=
s=E2=80=9D), and in the
>> beginning, they were all explicit, so we still didn=E2=80=99t have to =
answer
>> this question (in code).  Then job filters were added, and we still
>> didn=E2=80=99t have to, because they set blockers so the graph couldn=E2=
=80=99t be
>> reorganized with them in place anyway.
>>
>> If we converted copy-on-read=3Don to a COR node, we would have to answ=
er
>> that question.
>=20
> That's why we shouldn't do that, but just remove copy-on-read=3Don. :-)=


And BB-level throttling, fair enough.

(Although the first step would be probably to make throttle groups
non-experimental?  Like, drop the x- prefix for all their parameters.)

>>>>> But should really filter do that job, or it is here only to do CBW?=
 Maybe target
>>>>> must have another parent which will care about flushing.
>>>>>
>>>>> Ok, I think I'll flush target here too for safety, and leave a comm=
ent, that something
>>>>> smarter would be better.
>>>>> (or, if we decide to flush all children by default in generic code,=
 I'll drop this handler)
>>>>
>>>> [1] Thinking more about this, for normal backups the target file doe=
s
>>>> not reflect a valid disk state until the backup is done; just like f=
or
>>>> qemu-img convert.  Just like qemu-img convert, there is therefore no=

>>>> reason to flush the target until the job is done.
>=20
> Depends, the target could have the source as its backing file (like
> fleecing, but without exporting it right now), and then you could alway=
s
> have a consistent view on the target. Well, almost.
>=20
> Almost because to guarantee this, we'd have to flush between each CBW
> and the corresponding write to the same block, to make sure that the ol=
d
> data is backed up before it is overwritten.

Yes, that=E2=80=99s what I meant by =E2=80=9Cenforce on the host that the=
 target is
always flushed before the source=E2=80=9D.  Well, I meant to say there is=
 no
good way of doing that, and I kind of don=E2=80=99t consider this a good =
way.

> Of course, this would perform about as badly as internal COW in qcow2..=
=2E
> So probably not a guarantee we should be making by default. But it migh=
t
> make sense as an option.

I don=E2=80=99t know.  =E2=80=9CUse this option so your data isn=E2=80=99=
t lost in case of a
power failure, but it makes everything pretty slow=E2=80=9D?  Who is goin=
g to do
explicitly enable that (before their first data loss)?

Max


--I1jiS7VNzk2BIZXX72R46KcO9fKxRH4VL--

--1bm9mDgqORzN9oRH8WgDczkyCqL3yt2J5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0HuXIACgkQ9AfbAGHV
z0DkrAf/ZJs/EtAp6ZvZRQk/G1m25SEQunrXqVpTdfisKK3W3gVfmAK6Kf1ftbzA
YB+VkJgv3W37Q7yPXTOzd+EsbN9CxteedFK2Q3KDg5lQ7DlbquCHcnkS85X41Gqb
wfvJW58AUzav6X0zB3qZtOY99+hwKxCZvGOSQXm8+asDqJfNq6dwjH7odBErqm9a
jHu05VpY7KJZiEvckCqfKvx7f01E9cZ8d+6oUryO6a9MLcc+HzH3COgaOsTIZCSk
RhYxj4m26qRpoD+A2GchzNwROYGxg4lLbSIhPXxWFwu5qGDgxwtlsEXd7dWhQ1BD
kqwSjHh7yuaLrsDsJ20rcl62XN6QFg==
=+3kj
-----END PGP SIGNATURE-----

--1bm9mDgqORzN9oRH8WgDczkyCqL3yt2J5--

