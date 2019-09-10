Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1413BC49ED6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF6C21019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF6C21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7eej-000314-KR
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7eSB-0000q4-Ea
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7eS9-0004Ro-8B
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7eS3-0004QL-Vn; Tue, 10 Sep 2019 07:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B03718CB50D;
 Tue, 10 Sep 2019 11:36:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C5EB6012A;
 Tue, 10 Sep 2019 11:36:49 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
 <20190909093604.GB13841@localhost.localdomain>
 <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
 <20190909161314.GJ17606@localhost.localdomain>
 <89984d52-881f-a1e4-c14a-2bf05fc789d0@redhat.com>
 <20190910104748.GC4446@localhost.localdomain>
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
Message-ID: <00aa6729-5fa0-31e0-8af5-1a91ae034f28@redhat.com>
Date: Tue, 10 Sep 2019 13:36:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910104748.GC4446@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="loewtPkmxk80gJCdKxPGqK0NnlIk7nm8I"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 10 Sep 2019 11:36:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 04/42] block: Add child access functions
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--loewtPkmxk80gJCdKxPGqK0NnlIk7nm8I
Content-Type: multipart/mixed; boundary="7C3Tw6HBBtKttZBW5PoFLQZTe20R3wm1L";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <00aa6729-5fa0-31e0-8af5-1a91ae034f28@redhat.com>
Subject: Re: [PATCH v6 04/42] block: Add child access functions
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
 <20190909093604.GB13841@localhost.localdomain>
 <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
 <20190909161314.GJ17606@localhost.localdomain>
 <89984d52-881f-a1e4-c14a-2bf05fc789d0@redhat.com>
 <20190910104748.GC4446@localhost.localdomain>
In-Reply-To: <20190910104748.GC4446@localhost.localdomain>

--7C3Tw6HBBtKttZBW5PoFLQZTe20R3wm1L
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 12:47, Kevin Wolf wrote:
> Am 10.09.2019 um 11:14 hat Max Reitz geschrieben:
>> On 09.09.19 18:13, Kevin Wolf wrote:
>>> Am 09.09.2019 um 16:04 hat Max Reitz geschrieben:
>>>> On 09.09.19 11:36, Kevin Wolf wrote:
>>>>> Am 09.09.2019 um 09:56 hat Max Reitz geschrieben:
>>>>>> On 04.09.19 18:16, Kevin Wolf wrote:
>>>>>>> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>>>>>>>> There are BDS children that the general block layer code can acc=
ess,
>>>>>>>> namely bs->file and bs->backing.  Since the introduction of filt=
ers and
>>>>>>>> external data files, their meaning is not quite clear.  bs->back=
ing can
>>>>>>>> be a COW source, or it can be an R/W-filtered child; bs->file ca=
n be an
>>>>>>>> R/W-filtered child, it can be data and metadata storage, or it c=
an be
>>>>>>>> just metadata storage.
>>>>>>>>
>>>>>>>> This overloading really is not helpful.  This patch adds functio=
n that
>>>>>>>> retrieve the correct child for each exact purpose.  Later patche=
s in
>>>>>>>> this series will make use of them.  Doing so will allow us to ha=
ndle
>>>>>>>> filter nodes and external data files in a meaningful way.
>>>>>>>>
>>>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.=
com>
>>>>>>>
>>>>>>> Each time I look at this patch, I'm confused by the function name=
s.
>>>>>>> Maybe I should just ask what the idea there was, or more specific=
ally:
>>>>>>> What does the "filtered" in "filtered child" really mean?
>>>>>>>
>>>>>>> Apparently any child of a filter node is "filtered" (which makes =
sense),
>>>>>>
>>>>>> It isn=E2=80=99t, filters can have non-filter children.  For examp=
le, backup-top
>>>>>> could have the source as a filtered child and the target as a non-=
filter
>>>>>> child.
>>>>>
>>>>> Hm, okay, makes sense. I had a definition in mind that says that fi=
lter
>>>>> nodes only have a single child node. Is it that a filter may have o=
nly a
>>>>> single _filtered_ child node?
>>>>
>>>> Well, there=E2=80=99s Quorum...
>>>
>>> Ah, nice, quorum sets is_filter =3D true even though it neither fulfu=
lls
>>> the conditions for it before this series, nor the changed conditions
>>> after this series.
>>>
>>> So either quorum lies and isn't actually a filter driver, or our
>>> definition in the documentation of is_filter is wrong.
>>
>> You could say it lies because in FIFO mode it clearly isn=E2=80=99t a =
filter for
>> all of its children.
>>
>> There is a reason for lying, though, which is
>> bdrv_recurse_is_first_non_filter(), which is necessary to use the whol=
e
>> to_replace mirror stuff.
>=20
> Hm, actually, now that you mention bdrv_recurse_is_first_non_filter(),
> quorum was the first driver to declare itself a filter, so strictly
> speaking, if there is an inconsistency, it's the other uses that are
> abusing the field...
>=20
>> (You mirror from a quorum with a failed child and then replace the
>> failed child.  mirror needs to ensure that there are only R/W filters
>> between the child and the mirror source so that replacing it will not
>> suddenly change any visible data.  Which is actually a lie for quorum,=

>> because the child is clearly broken and thus precisely doesn=E2=80=99t=
 show the
>> same data...)
>>
>> Maybe we should stop declaring Quorum a filter and then rename the
>> bdrv_recurse_is_first_non_filter() to, I don=E2=80=99t know,
>> bdrv_recurse_can_be_replaced_by_mirror()?
>=20
> Why not.

It feels difficult to do in this series because this is a whole new can
of worms.

In patch 35, I actually replace the mirror use case by
is_filtered_child().  So it looks to me as if that should not be done,
because I should instead fix bdrv_recurse_is_first_non_filter() (and
rename it), because quorum does allow replacing its children by mirror,
even if it does not act as a filter for them.

OTOH, there are other users of bdrv_is_first_non_filter().  Those are
qmp_block_resize() and external_snapshot_prepare(), who throw an error
if that returns false.

I think that=E2=80=99s just wrong.  First of all, I don=E2=80=99t even kn=
ow why we have
that restriction anymore (I can imagine why it used to make sense before
the permission system).  qmp_block_resize() should always work as long
as it can get BLK_PERM_RESIZE; and I don=E2=80=99t know why the parents o=
f some
node would care if you take a snapshot of their child.

>>>>>>> but also bs->backing of a qcow2 image, while bs->file of qcow2 is=
n't.
>>>>>>> raw doesn't have any "filtered" child. What's the system behind t=
his?
>>>>>>
>>>>>> =E2=80=9Cfiltered=E2=80=9D means: If the parent node returns data =
from this child, it
>>>>>> won=E2=80=99t modify it, neither its content nor its position.  CO=
W and R/W
>>>>>> filters differ in how they handle writes; R/W filters pass them th=
rough
>>>>>> to the filtered child, COW filters copy them off to some other chi=
ld
>>>>>> node (and then the filtered child=E2=80=99s data will no longer be=
 visible at
>>>>>> that location).
>>>>>
>>>>> But there is no reason why a node couldn't fulfill this condition f=
or
>>>>> more than one child node. bdrv_filtered_child() isn't well-defined =
then.
>>>>> Technically, the description "Return any filtered child" is correct=

>>>>> because "any" can be interpreted as "an arbitrary", but obviously t=
hat
>>>>> makes the function useless.
>>>>
>>>> Which is why it currently returns NULL for Quorum.
>>>
>>> Which is about the only possible choice that breaks the contract...
>>>
>>>  * Return any filtered child, independently of how it reacts to write=

>>
>> I don=E2=80=99t know if you=E2=80=99re serious about this proposition,=
 because I don=E2=80=99t
>> know whether that could be useful in any way. :-?
>=20
> Huh? This is just quoting the contract from your code?

I see.  I was thinking about =E2=80=9Cany of COW/RW, of which only one ex=
ists=E2=80=9D.
 There is an assertion for that (that only one filtered child exists at
a time) in the code.  (And I consider assertions part of the contract.)

>>>  * accesses and whether data is copied onto this BDS through COR.
>>
>> I meant the contract as =E2=80=9CReturn the single filtered child ther=
e is, or NULL=E2=80=9D
>=20
> Then that should probably be spelt out in the contract.Probably even
> explicitly "NULL if there is either no filtered child or multiple
> filtered children".

Well, it=E2=80=99s spelled out through the assertion, but not in the
documentation, yes.

>>> Maybe the documentation of bdrv_filtered_child() needs to be rephrase=
d?
>>>
>>> Going back to qcow2, it's really not much different as it has multipl=
e
>>> (two) filtered children, too.
>>
>> Well, it doesn=E2=80=99t.  It isn=E2=80=99t an R/W filter.
>=20
> What do I have to look at to see whether something is an R/W filter or
> not? qcow2 matches your criteria for an R/W filter.

No.  Some qcow2 nodes match the criteria.  But not all, which makes the
qcow2 driver not a filter driver.

> You say that it's
> not useful, so it's not an R/W filter anyway. But where in the code
> could I get this information?

=E2=80=9CWhere in the code=E2=80=9D?  Do you want to add a comment to eve=
ry BlockDriver
structure on why it does or doesn=E2=80=99t set .is_filter?

> This just doesn't make sense to me. If a driver matches the criteria fo=
r
> an R/W filter, then it should be one. If qcow2 should not be considered=

> a R/W filter, then the criteria must be changed so that it isn't.

See below.

>> Maybe what we actually need to rephrase is the definition of .is_filte=
r.
>>  (Namely something along the lines of =E2=80=9CFulfills these guarante=
es (same
>> data, etc. pp.), *and* should be skipped for allocation information
>> queries etc.=E2=80=9D.
>=20
> Hm - does this imply that .is_filter =3D=3D this is a R/W filter? Becau=
se
> this was never spelt out, neither in code comments nor in commit
> messages.

While I=E2=80=99m not a fan of comment-less code, I do think that it=E2=80=
=99s possible
to read code.  Which clearly stated this.

> If we called R/W filters just "filters" (which makes it obvious how it
> relates to .is_filter) and COW nodes something that doesn't include the=

> word "filter", things might become a lot clearer.

Because you apparently wrote this before reading that I agreed to your
renaming proposal, I now feel free to argue that I could just as well
rename .is_filter to .is_rw_filter.

Obviously I won=E2=80=99t because I prefer your proposal.

[...]

>>>>> Specficially, according to your definition, qcow2 filters both the
>>>>> backing file (COW filter) and the external data file (R/W filter).
>>>>
>>>> Not wrong.  But the same question as for raw arises: Is there any us=
e to
>>>> declaring qcow2 an R/W filter driver just because it fits the defini=
tion?
>>>
>>> Wait, where is there even a place where this could be declared?
>>>
>>> The once thing I see that a driver even can declare is drv->is_filter=
,
>>> which is about the whole driver and not about nodes. It is false for
>>> qcow2.
>>
>> That=E2=80=99s correct.  But that=E2=80=99s not a fundamental problem,=
 of course, we
>> could make it a per-BDS attribute if that made sense.
>=20
> I was thinking per-child, actually, because you declare one BdrvChild
> filtered and another not filtered.

Why don=E2=80=99t you say so from the start then?

(Sorry, but honestly about 30 % of this discussion to me feels like
you=E2=80=99re playing games with me.  Please don=E2=80=99t take this the=
 wrong way, I
mean it very neutrally.  It=E2=80=99s just that I feel like I=E2=80=99m e=
xplaining
things to you that you very much know, but you just want me to say them.
 And that feels unproductive and sometimes indeed frustrating.)

One thing is that this wouldn=E2=80=99t make the quorum case any easier b=
ecause
it actually doesn=E2=80=99t know for which children it acts as a filter a=
nd for
which it doesn=E2=80=99t.

> But by now I think most of the confusion is really just a result of COW=

> being considered a filter in some respects (mainly just the names of th=
e
> child access functions), but not in others (like .is_filter).

I don=E2=80=99t quite see how it=E2=80=99s =E2=80=9Cby now=E2=80=9D when =
in your first mail you already
basically wrote that functionally, everything works (leaving out
quorum), but that you=E2=80=99re confused (or claim to be confused, I hav=
e no
idea what=E2=80=99s real and what=E2=80=99s pretended anymore) by the nam=
es.


We have come to two results, as far as I can see:

First, naming COW backing nodes =E2=80=9CCOW filtered children=E2=80=9D c=
lashes with our
existing use of =E2=80=9Dfilter=E2=80=9D.  There is no point in forcing t=
he =E2=80=9Dfilter=E2=80=9D
label on everything.  We can just keep calling (R/W) filters filters and
COW backing children COW children.  The names are succinct enough.

In some cases, we don=E2=80=99t care whether something is a COW or filter=
ed
child, in such a case a caller can be bothered to use the slightly
longer bdrv_cow_or_filtered_child().


Second, most of the time we want a filter node to have a clear and
unique path to go down.  This is the important property of filters: That
you can skip them and go to the node that actually has the data.

Quorum breaks this by having multiple children, and nobody knows which
of them has the data we will see on the next read operation.

All =E2=80=9Cfilters=E2=80=9D who could have multiple children would have=
 this problem.
 Hence a filter must always have a single unique data child.  I think.

[...]

>>> Either use a narrow definition, or use a broad one. But use only one =
and
>>> use it consistently.
>>
>> I think the problem appears because you restrict the process to a sing=
le
>> step where there=E2=80=99s actually two.
>>
>> Drivers can be either
>> (1) R/W filters (e.g. throttle)
>> (2) COW filters (e.g. qcow2)
>> (3) None of the above (e.g. vhdx, curl)
>>
>> This choice is made on the driver level, not on the node level (for go=
od
>> reason, see below*).
>=20
> What prevents a driver from being
> (4) COW filter and R/W filter (e.g. qcow2 if it were useful)?
>=20
> I mean, conceptually, not in the implementation.

An R/W filter always shows the same data as the filtered child.  So the
COW child=E2=80=98s data can never be visible, and as such you couldn=E2=80=
=99t have a
COW child at the same time.

Max


--7C3Tw6HBBtKttZBW5PoFLQZTe20R3wm1L--

--loewtPkmxk80gJCdKxPGqK0NnlIk7nm8I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13is8ACgkQ9AfbAGHV
z0Az/Af/cM9r08cPjW1jwmcm/vNdv3uKQ19yEpOw+FgO7CmnPldLHbqiSOCfrsgg
RL0K7/vsos64Dtcw9RmqQKr4eCGLIoqvHSZyoXDxHMJ3SZezyK9d2orIE/OgJx/7
SNBUy5elnwZbXz90z6IMNm7wgJZMs7evqTN5Jaso0RD3+NHneKHYpH01MTBiBKvi
c8de/t9GkQR+HyE2eLu2QSZjwcn6Ud1w4BBHvsVmdng72Om7TNR+pumFSF6UakIt
oak1KD/GI9iKCoSsnXw6BKYGoOzszeGKjqSar4jb2ip0bz3Fm9u+04ck8kgTK+O2
GRca+aS8W5R+sVpL0NJJ1lvlgSz5RQ==
=cWgy
-----END PGP SIGNATURE-----

--loewtPkmxk80gJCdKxPGqK0NnlIk7nm8I--

