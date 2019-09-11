Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C95C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 11:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72842089F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 11:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72842089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i80PX-0000qx-SZ
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 07:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i80Mp-0007pR-UJ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 07:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i80Mo-0003t4-DI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 07:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i80Mj-0003rM-Gw; Wed, 11 Sep 2019 07:00:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 540FD30860CA;
 Wed, 11 Sep 2019 11:00:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-94.ams2.redhat.com
 [10.36.116.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC5571001959;
 Wed, 11 Sep 2019 11:00:46 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <20190910145229.GI4446@localhost.localdomain>
 <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
 <20190911065517.GA4907@localhost.localdomain>
 <f082931e-154f-5393-f5b0-ff82f43eff31@redhat.com>
 <20190911082743.GC4907@localhost.localdomain>
 <aa9a6a3d-73ae-c7d4-78c9-a9c6c18fcfa4@redhat.com>
 <20190911103123.GE4907@localhost.localdomain>
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
Message-ID: <c22a405b-d79b-ad00-427f-c4e54e897f0d@redhat.com>
Date: Wed, 11 Sep 2019 13:00:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911103123.GE4907@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9uxkJB5cBs6V9ZLlEHHDbEHt08buEWqNa"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 11 Sep 2019 11:00:48 +0000 (UTC)
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
--9uxkJB5cBs6V9ZLlEHHDbEHt08buEWqNa
Content-Type: multipart/mixed; boundary="mARJXUyEctLFAkeEsWNtDP2kRqVaxRAey";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c22a405b-d79b-ad00-427f-c4e54e897f0d@redhat.com>
Subject: Re: [PATCH v6 22/42] block: Fix bdrv_get_allocated_file_size's
 fallback
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <20190910145229.GI4446@localhost.localdomain>
 <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
 <20190911065517.GA4907@localhost.localdomain>
 <f082931e-154f-5393-f5b0-ff82f43eff31@redhat.com>
 <20190911082743.GC4907@localhost.localdomain>
 <aa9a6a3d-73ae-c7d4-78c9-a9c6c18fcfa4@redhat.com>
 <20190911103123.GE4907@localhost.localdomain>
In-Reply-To: <20190911103123.GE4907@localhost.localdomain>

--mARJXUyEctLFAkeEsWNtDP2kRqVaxRAey
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.09.19 12:31, Kevin Wolf wrote:
> Am 11.09.2019 um 12:00 hat Max Reitz geschrieben:
>> On 11.09.19 10:27, Kevin Wolf wrote:
>>> Am 11.09.2019 um 09:37 hat Max Reitz geschrieben:
>>>> On 11.09.19 08:55, Kevin Wolf wrote:
>>>>> Well, by default the primary child, which should cover like 90% of =
the
>>>>> drivers?
>>>>
>>>> Hm, yes.
>>>>
>>>> But I still think that the drivers that do not want to count every
>>>> single non-COW child are the exception.
>>>
>>> They are, but drivers that want to count more than their primary node=

>>> are exceptions, too. And I think you're more likely to remember addin=
g
>>> the callback when you want to have a certain feature, not when you do=
n't
>>> want to have it.
>>>
>>> I really think we're likely to forget adding the callback where we ne=
ed
>>> to disable the feature.
>>
>> Well, I mean, we did forget adding it for qcow2.
>=20
> I'm afraid I have to agree. So the conclusion is that we won't get it
> right anyway?
>=20
>>> I can see two options that should address both of our views:
>>>
>>> 1. Just don't have a fallback at all, make the callback mandatory and=

>>>    provide implementations in block.c that can be referred to in
>>>    BlockDriver. Not specifying the callback causes an assertion failu=
re,
>>>    so we'd hopefully notice it quite early (assuming that we run eith=
er
>>>    'qemu-img info' or 'query-block' on a configuration with the block=

>>>    driver, but I think that's faily safe to assume).
>>
>> Hm.  Seems a bit much, but if we can=E2=80=99t agree on what=E2=80=99s=
 a good general
>> implementation that works for everything, this is probably the only
>> thing that would actually keep us from forgetting to add special cases=
=2E
>>
>> Though I actually don=E2=80=99t know.  I=E2=80=99d probably add two gl=
obally available
>> helpers, one that returns the sum of everything but the backing node,
>> and one that just returns the primary node.
>=20
> Yes, I think this is the same as I meant by "provide implementations in=

> block.c".
>=20
>> Now if I were to make qcow2 use the primary node helper function, woul=
d
>> we have remembered changing it once we added a data file?
>>
>> Hmm.  Maybe not, but it should be OK to just make everything use the s=
um
>> helper, except the drivers that want the primary node.  That should wo=
rk
>> for all cases.  (I think that whenever a format driver suddenly gains
>> more child nodes, we probably will want to count them.  OTOH, everythi=
ng
>> that has nodes that shouldn=E2=80=99t be counted probably always wants=
 to use
>> the primary node helper function from the start.)
>=20
> The job filter nodes have only one child currently, which should be
> counted. We'll add other children that shouldn't be counted only later.=

>=20
> But we already have an idea of what possible extensions look like, so w=
e
> can probably choose the right function from the start.

Yep.

>>> 2. Make the 90% solution a 100% solution: Allow drivers to have multi=
ple
>>>    storage children (for vmdk) and then have the fallback add up the
>>>    primary child plus all storage children. This is what I suggested =
as
>>>    the documented semantics in my initial reply to this patch (that y=
ou
>>>    chose not to answer).
>>
>> I didn=E2=80=99t answer that because I didn=E2=80=99t disagree.
>>
>>>    Adding the size of storage children covers qcow2 and vmdk.
>>
>> That=E2=80=99s of course exactly what we=E2=80=99re trying to do, but =
the question is,
>> how do we figure out that storage children?  Make it a per-BdrvChild
>> attribute?  That seems rather heavy-handed, because I think we=E2=80=99=
d need it
>> only here.
>=20
> Well, you added bdrv_storage_child().I'd argue this interface is wrong

Yes, it probably is.

> because it assumes that only one storage child exists. You just didn't
> implement it for vmdk so that the problem didn't become apparent. It
> would have to return a list rather than a single child. So fixing the
> interface and then using it is what I was thinking.
>=20
> Now that you mention a per-BdrvChild attribute, however, I start to
> wonder if the distinction between COW children, filter children, storag=
e
> children, metadata children, etc. isn't really what BdrvChildRole was
> supposed to represent?

That=E2=80=99s a good point.

> Maybe we want to split off child_storage from child_file, though it's
> not strictly necessary for this specific case because we want to treat
> both metadata and storage nodes the same. But it could be useful for
> other users of bdrv_storage_child(), if there are any.

Possible.  Maybe it turns out that at least for this series I don=E2=80=99=
t need
bdrv_storage_child() at all.

>>>    As the job filter won't declare the target or any other involved
>>>    nodes their storage nodes (I hope), this will do the right thing f=
or
>>>    them, too.
>>>
>>>    For quorum and blkverify both ways could be justifiable. I think t=
hey
>>>    probably shouldn't declare their children as storage nodes. They a=
re
>>>    more like filters that don't have a single filtered node. So some
>>>    kind of almost-filters.
>>
>> I don=E2=80=99t think quorum is a filter, and blkverify can only be ju=
stified to
>> be a filter because it quits qemu when there is a mismatch.
>>
>> The better example is replication, but that has a clear filtered child=

>> (the primary node).
>>
>>
>> So all in all I think it=E2=80=99s best to make the callback mandatory=
 and add
>> two global helper functions.  That=E2=80=99s simple enough and should =
prevent
>> us from making mistakes by forgetting to adjust something in the
>> future.
>=20
> Yes, that should work.
>=20
> We should probably still figure out what the relationship between the
> child access functions and child roles is, even if we don't need it for=

> this solution. But it feels like an important part of the design.

Hm.  It feels like something that should be done before this series,
actually.

So I think we should add at least a child role per child access function
so that they match?  And then maybe in bdrv_attach_child() assert that a
BDS never has more than one primary or filtered child (a filtered child
acts as a primary child, too), or more than one COW child.  (And that
these are always in bs->file or bs->backing so the child access
functions do work.)

Max


--mARJXUyEctLFAkeEsWNtDP2kRqVaxRAey--

--9uxkJB5cBs6V9ZLlEHHDbEHt08buEWqNa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1409wACgkQ9AfbAGHV
z0DAnAgAg66yrj4fD+acyRShTpNUjdo0t64JUKYwrEtlUFC6+HeKWn7KGoHSBwYd
bbHxCH0DAz+dPMOkDhXmKiZYL4d9wQOHBkpSvpabLXyKq9hEN91W68TH2jw38iQt
9fk/sBJoIOWnzcmesGpOJaitQUlfSl4mcLdX6mrXosytdFMVSYNBBVxypwgsogn5
LZQXmeLzBj97d29jsNtcIqLa5ZMi8NdGF51LfqzSADf3DuklyZUnZkRqqwNwVd7X
2gef02oWGH2EZ8r30d2qKhKo4Ax5+8Y7qR8YMvq+sQU5f47/riDh9SB1TWHtx7fv
avvsBmzZ5grqs6Rro92hnQWfbsrpcQ==
=2gHV
-----END PGP SIGNATURE-----

--9uxkJB5cBs6V9ZLlEHHDbEHt08buEWqNa--

