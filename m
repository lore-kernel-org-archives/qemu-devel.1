Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDFFECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16834208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16834208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xDc-0001Xt-8A
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7xBu-00083m-Gt
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7xBt-0002M1-Ck
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:37:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7xBq-0002Ko-Oi; Wed, 11 Sep 2019 03:37:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 018E2307D853;
 Wed, 11 Sep 2019 07:37:22 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-94.ams2.redhat.com
 [10.36.116.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A203160BF7;
 Wed, 11 Sep 2019 07:37:20 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <20190910145229.GI4446@localhost.localdomain>
 <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
 <20190911065517.GA4907@localhost.localdomain>
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
Message-ID: <f082931e-154f-5393-f5b0-ff82f43eff31@redhat.com>
Date: Wed, 11 Sep 2019 09:37:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911065517.GA4907@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1SwZw7Fa3nnB6EgvdN1OsVjUe1tSr6fK0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 11 Sep 2019 07:37:22 +0000 (UTC)
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
--1SwZw7Fa3nnB6EgvdN1OsVjUe1tSr6fK0
Content-Type: multipart/mixed; boundary="olfXk1fQ18ht43IMWrf9iZgHQeKFOWSuh";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f082931e-154f-5393-f5b0-ff82f43eff31@redhat.com>
Subject: Re: [PATCH v6 22/42] block: Fix bdrv_get_allocated_file_size's
 fallback
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <20190910145229.GI4446@localhost.localdomain>
 <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
 <20190911065517.GA4907@localhost.localdomain>
In-Reply-To: <20190911065517.GA4907@localhost.localdomain>

--olfXk1fQ18ht43IMWrf9iZgHQeKFOWSuh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.09.19 08:55, Kevin Wolf wrote:
> Am 11.09.2019 um 08:20 hat Max Reitz geschrieben:
>> On 10.09.19 16:52, Kevin Wolf wrote:
>>> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>>>> If the driver does not implement bdrv_get_allocated_file_size(), we
>>>> should fall back to cumulating the allocated size of all non-COW
>>>> children instead of just bs->file.
>>>>
>>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>
>>> This smells like an overgeneralisation, but if we want to count all v=
mdk
>>> extents, the qcow2 external data file, etc. it's an improvement anywa=
y.
>>> A driver that has a child that should not be counted must just rememb=
er
>>> to implement the callback.
>>>
>>> Let me think of an example... How about quorum, for a change? :-)
>>> Or the second blkverify child.
>>>
>>> Or eventually the block job filter nodes.
>>
>> I actually think it makes sense for all of these nodes to report the s=
um
>> of all of their children=E2=80=99s allocated sizes.
>=20
> Hm... Yes, in a way. But not much more than it would make sense to
> report the sum of the sizes of all images in the whole backing chain
> (this is a useful thing to ask for, just maybe not the right thing to
> return for a low-level interface). But I can accept that it's maybe a
> bit more expected for quorum and blkverify than for COW images.
>=20
> If you include the block job filter nodes, I have to disagree, though.
> If mirror_top_bs (or any other job filter) sits in the middle of the
> source chain, then I certainly don't want to see the target size added
> to it.

Hm, I don=E2=80=99t care much either way.  I think it makes complete sens=
e to
add the target size there, but OTOH it=E2=80=99s only temporary while the=
 job
runs, so it may be a bit confusing if it suddenly goes up and then down
again.

But I think this is the special case, so this is what should be handled
in a driver callback.

>> If a quorum node has three children with allocated sizes of 3 MB, 1 MB=
,
>> and 2 MB, respectively (totally possible if some have explicit zeroes
>> and others don=E2=80=99t; it may also depend on the protocol, the file=
system,
>> etc.), then I think it makes most sense to report indeed 6 MB for the
>> quorum subtree as a whole.  What would you report?  3 MB?
>=20
> Do it's the quorum way: Just vote!

Add an option for it?  Average, maximum, median, majority, sum? :-)

> No, you're right, of course. -ENOTSUP is probably the only other thing
> you could do then.
>=20
>>> Ehm... Maybe I should just take back what I said first. It almost fee=
ls
>>> like it would be better if qcow2 and vmdk explicitly used a handler t=
hat
>>> counts all children (could still be a generic one in block.c) rather
>>> than having to remember to disable the functionality everywhere where=
 we
>>> don't want to have it.
>>
>> I don=E2=80=99t, because everywhere we don=E2=80=99t want this functio=
nality, we still
>> need to choose a child.  This has to be done by the driver anyway.
>=20
> Well, by default the primary child, which should cover like 90% of the
> drivers?

Hm, yes.

But I still think that the drivers that do not want to count every
single non-COW child are the exception.

Max


--olfXk1fQ18ht43IMWrf9iZgHQeKFOWSuh--

--1SwZw7Fa3nnB6EgvdN1OsVjUe1tSr6fK0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl14pC4ACgkQ9AfbAGHV
z0C19gf/SnD0/QfeSzVhtr2oJFTrwe1ku7ScBFMO5RSYs7P+mjLxNm8qBS/6d4rM
pKdXu21YsIdBE/Jw/aqVeXHwUn6OPaYQpHtRicttToXu0FBnRzcu30YTdbm6lhcV
8BWjLhMAZ7hHGUE0QFJGz1oNEFd1gIIn9C5Sush+mrMogTCVZ9Z8jPb0diyb5/gn
XDEgAzwVqH/Qvixa8wyu6AG6tcjEI34bgAJapy2wHEHPiZbIu2eGSdnEb9zKtaZF
S4Id1+ilIT1VSARq48XoYZRgHPm/yzZ9FYCB6KwBlWP6nxMS9EPIgIX43N+Fmkyh
fSMqDP1G95goAjcnM8U3flPdbmbLMQ==
=shrY
-----END PGP SIGNATURE-----

--1SwZw7Fa3nnB6EgvdN1OsVjUe1tSr6fK0--

