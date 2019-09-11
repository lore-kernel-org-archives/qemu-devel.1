Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05301C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7242075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7242075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7zSA-0006bj-VU
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 06:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7zQh-0005iv-IB
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7zQf-0003ZI-Ow
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 06:00:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7zQb-0003Xv-Qm; Wed, 11 Sep 2019 06:00:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB4CFC08E2A1;
 Wed, 11 Sep 2019 10:00:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-94.ams2.redhat.com
 [10.36.116.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A017160BEC;
 Wed, 11 Sep 2019 10:00:42 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <20190910145229.GI4446@localhost.localdomain>
 <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
 <20190911065517.GA4907@localhost.localdomain>
 <f082931e-154f-5393-f5b0-ff82f43eff31@redhat.com>
 <20190911082743.GC4907@localhost.localdomain>
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
Message-ID: <aa9a6a3d-73ae-c7d4-78c9-a9c6c18fcfa4@redhat.com>
Date: Wed, 11 Sep 2019 12:00:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911082743.GC4907@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jOpdnQ5IrF0WEDPYVPDXubved54uxocSw"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 11 Sep 2019 10:00:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 22/42] block: Fix
 bdrv_get_allocated_file_size's fallback
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
--jOpdnQ5IrF0WEDPYVPDXubved54uxocSw
Content-Type: multipart/mixed; boundary="kD6cnmgGYgAb1RIEXEJTUdgmobOXohKxa";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <aa9a6a3d-73ae-c7d4-78c9-a9c6c18fcfa4@redhat.com>
Subject: Re: [PATCH v6 22/42] block: Fix bdrv_get_allocated_file_size's
 fallback
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <20190910145229.GI4446@localhost.localdomain>
 <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
 <20190911065517.GA4907@localhost.localdomain>
 <f082931e-154f-5393-f5b0-ff82f43eff31@redhat.com>
 <20190911082743.GC4907@localhost.localdomain>
In-Reply-To: <20190911082743.GC4907@localhost.localdomain>

--kD6cnmgGYgAb1RIEXEJTUdgmobOXohKxa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.09.19 10:27, Kevin Wolf wrote:
> Am 11.09.2019 um 09:37 hat Max Reitz geschrieben:
>> On 11.09.19 08:55, Kevin Wolf wrote:
>>> Am 11.09.2019 um 08:20 hat Max Reitz geschrieben:
>>>> On 10.09.19 16:52, Kevin Wolf wrote:
>>>>> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>>>>>> If the driver does not implement bdrv_get_allocated_file_size(), w=
e
>>>>>> should fall back to cumulating the allocated size of all non-COW
>>>>>> children instead of just bs->file.
>>>>>>
>>>>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>
>>>>> This smells like an overgeneralisation, but if we want to count all=
 vmdk
>>>>> extents, the qcow2 external data file, etc. it's an improvement any=
way.
>>>>> A driver that has a child that should not be counted must just reme=
mber
>>>>> to implement the callback.
>>>>>
>>>>> Let me think of an example... How about quorum, for a change? :-)
>>>>> Or the second blkverify child.
>>>>>
>>>>> Or eventually the block job filter nodes.
>>>>
>>>> I actually think it makes sense for all of these nodes to report the=
 sum
>>>> of all of their children=E2=80=99s allocated sizes.
>>>
>>> Hm... Yes, in a way. But not much more than it would make sense to
>>> report the sum of the sizes of all images in the whole backing chain
>>> (this is a useful thing to ask for, just maybe not the right thing to=

>>> return for a low-level interface). But I can accept that it's maybe a=

>>> bit more expected for quorum and blkverify than for COW images.
>>>
>>> If you include the block job filter nodes, I have to disagree, though=
=2E
>>> If mirror_top_bs (or any other job filter) sits in the middle of the
>>> source chain, then I certainly don't want to see the target size adde=
d
>>> to it.
>>
>> Hm, I don=E2=80=99t care much either way.  I think it makes complete s=
ense to
>> add the target size there, but OTOH it=E2=80=99s only temporary while =
the job
>> runs, so it may be a bit confusing if it suddenly goes up and then dow=
n
>> again.
>=20
> I think the number that most users are interested in is knowing how muc=
h
> space the image for their /dev/vda takes up on the host.
>=20
> I can see how they might be interested in not only that one image file,=

> but all other image files connected to it, i.e. their /dev/vda with all=

> of its snapshots. This would mean counting backing files. I think addin=
g
> up the numbers for this should be done in the management layer.

My main argument against counting backing files is that we=E2=80=99ve nev=
er done it.

(Whereas for quorum, I=E2=80=99d argue we just forgot to adjust
bdrv_get_allocated_file_size() for it.)

> I can possibly also imagine users wanting to count everything that's
> even loosely connected to their /dev/vda, like copies of it. I doubt,
> however, they want to count only copies that are currently being made,
> but not snapshots and copies that have been completed earlier. So this
> is clearly a management layer thing, too.

OK.

>> But I think this is the special case, so this is what should be handle=
d
>> in a driver callback.
>=20
> It's a special case, yes. But see below.
>=20
>>>> If a quorum node has three children with allocated sizes of 3 MB, 1 =
MB,
>>>> and 2 MB, respectively (totally possible if some have explicit zeroe=
s
>>>> and others don=E2=80=99t; it may also depend on the protocol, the fi=
lesystem,
>>>> etc.), then I think it makes most sense to report indeed 6 MB for th=
e
>>>> quorum subtree as a whole.  What would you report?  3 MB?
>>>
>>> Do it's the quorum way: Just vote!
>>
>> Add an option for it?  Average, maximum, median, majority, sum? :-)
>=20
> We could also introduce a mode with an Electoral College so that
> sometimes an image that missed the majority has a chance to win anyway.=


That=E2=80=99s actually a good idea for a quorum mode in general.  Who sa=
ys the
majority is right?  Better let someone with more authority cross-check
the result.

>>> No, you're right, of course. -ENOTSUP is probably the only other thin=
g
>>> you could do then.
>>>
>>>>> Ehm... Maybe I should just take back what I said first. It almost f=
eels
>>>>> like it would be better if qcow2 and vmdk explicitly used a handler=
 that
>>>>> counts all children (could still be a generic one in block.c) rathe=
r
>>>>> than having to remember to disable the functionality everywhere whe=
re we
>>>>> don't want to have it.
>>>>
>>>> I don=E2=80=99t, because everywhere we don=E2=80=99t want this funct=
ionality, we still
>>>> need to choose a child.  This has to be done by the driver anyway.
>>>
>>> Well, by default the primary child, which should cover like 90% of th=
e
>>> drivers?
>>
>> Hm, yes.
>>
>> But I still think that the drivers that do not want to count every
>> single non-COW child are the exception.
>=20
> They are, but drivers that want to count more than their primary node
> are exceptions, too. And I think you're more likely to remember adding
> the callback when you want to have a certain feature, not when you don'=
t
> want to have it.
>=20
> I really think we're likely to forget adding the callback where we need=

> to disable the feature.

Well, I mean, we did forget adding it for qcow2.

> I can see two options that should address both of our views:
>=20
> 1. Just don't have a fallback at all, make the callback mandatory and
>    provide implementations in block.c that can be referred to in
>    BlockDriver. Not specifying the callback causes an assertion failure=
,
>    so we'd hopefully notice it quite early (assuming that we run either=

>    'qemu-img info' or 'query-block' on a configuration with the block
>    driver, but I think that's faily safe to assume).

Hm.  Seems a bit much, but if we can=E2=80=99t agree on what=E2=80=99s a =
good general
implementation that works for everything, this is probably the only
thing that would actually keep us from forgetting to add special cases.

Though I actually don=E2=80=99t know.  I=E2=80=99d probably add two globa=
lly available
helpers, one that returns the sum of everything but the backing node,
and one that just returns the primary node.

Now if I were to make qcow2 use the primary node helper function, would
we have remembered changing it once we added a data file?

Hmm.  Maybe not, but it should be OK to just make everything use the sum
helper, except the drivers that want the primary node.  That should work
for all cases.  (I think that whenever a format driver suddenly gains
more child nodes, we probably will want to count them.  OTOH, everything
that has nodes that shouldn=E2=80=99t be counted probably always wants to=
 use
the primary node helper function from the start.)

> 2. Make the 90% solution a 100% solution: Allow drivers to have multipl=
e
>    storage children (for vmdk) and then have the fallback add up the
>    primary child plus all storage children. This is what I suggested as=

>    the documented semantics in my initial reply to this patch (that you=

>    chose not to answer).

I didn=E2=80=99t answer that because I didn=E2=80=99t disagree.

>    Adding the size of storage children covers qcow2 and vmdk.

That=E2=80=99s of course exactly what we=E2=80=99re trying to do, but the=
 question is,
how do we figure out that storage children?  Make it a per-BdrvChild
attribute?  That seems rather heavy-handed, because I think we=E2=80=99d =
need it
only here.

>    As the job filter won't declare the target or any other involved
>    nodes their storage nodes (I hope), this will do the right thing for=

>    them, too.
>=20
>    For quorum and blkverify both ways could be justifiable. I think the=
y
>    probably shouldn't declare their children as storage nodes. They are=

>    more like filters that don't have a single filtered node. So some
>    kind of almost-filters.

I don=E2=80=99t think quorum is a filter, and blkverify can only be justi=
fied to
be a filter because it quits qemu when there is a mismatch.

The better example is replication, but that has a clear filtered child
(the primary node).


So all in all I think it=E2=80=99s best to make the callback mandatory an=
d add
two global helper functions.  That=E2=80=99s simple enough and should pre=
vent us
from making mistakes by forgetting to adjust something in the future.

Max


--kD6cnmgGYgAb1RIEXEJTUdgmobOXohKxa--

--jOpdnQ5IrF0WEDPYVPDXubved54uxocSw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl14xcgACgkQ9AfbAGHV
z0AXCwf/bGnWJhqhXHFfkmRu1H0D6aRVxYZFguncsu44V6ciL9Cw3aPz9X9p+GiZ
yW+yd3wlGeGxbNCuxLI1gKH7rvu9r8pVqN7Nq4I8g91XIY8jTMtra7Dk5xkPbFqY
Pb/VcA6hqHALYBhRLUbeMpHKothemYNo0m7npzE9CCmu5d9eO+g1tBzj12/idaUu
hThLsu3oKjVvGwuJGv9KFUmybRBf7Yb36wSpIeHVNOwL4hW2wB4F1vk8+yNnfezB
QM9yKIdW+rZ3DZx7Z6tySrG5Ls0BIKLoMdYimSQGDv61Na2HQ8WfagKia/MZf9P1
ckhY+Iw6iHe69XSNAa5CwAEtjKBhLA==
=uAty
-----END PGP SIGNATURE-----

--jOpdnQ5IrF0WEDPYVPDXubved54uxocSw--

