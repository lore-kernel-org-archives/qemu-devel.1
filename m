Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CFAC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 18:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3E624056
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 18:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3E624056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW3B8-0002OD-TB
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 14:19:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hW3A2-0001yv-G3
	for qemu-devel@nongnu.org; Wed, 29 May 2019 14:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hW3A1-00043l-2f
	for qemu-devel@nongnu.org; Wed, 29 May 2019 14:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hW39t-0003wJ-Jl; Wed, 29 May 2019 14:18:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2DAF309B6D9;
	Wed, 29 May 2019 18:18:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-183.ams2.redhat.com
	[10.36.116.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AE0B710AFECC;
	Wed, 29 May 2019 18:18:27 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190523154733.54944-1-vsementsov@virtuozzo.com>
	<20190523154733.54944-4-vsementsov@virtuozzo.com>
	<1950138d-f65a-9458-2d7d-8267ba3463e8@redhat.com>
	<a49711ca-2845-bac5-022e-abcde1f103c5@virtuozzo.com>
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
Message-ID: <f4073e6b-ba54-e089-7f21-fc5dedfd2059@redhat.com>
Date: Wed, 29 May 2019 20:18:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a49711ca-2845-bac5-022e-abcde1f103c5@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MstzIDLGCPJ7urjG7uRRILJ4TV3P7rIu6"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 29 May 2019 18:18:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 3/3] block/qcow2-bitmap: rewrite bitmap
 reopening logic
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MstzIDLGCPJ7urjG7uRRILJ4TV3P7rIu6
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <f4073e6b-ba54-e089-7f21-fc5dedfd2059@redhat.com>
Subject: Re: [PATCH 3/3] block/qcow2-bitmap: rewrite bitmap reopening logic
References: <20190523154733.54944-1-vsementsov@virtuozzo.com>
 <20190523154733.54944-4-vsementsov@virtuozzo.com>
 <1950138d-f65a-9458-2d7d-8267ba3463e8@redhat.com>
 <a49711ca-2845-bac5-022e-abcde1f103c5@virtuozzo.com>
In-Reply-To: <a49711ca-2845-bac5-022e-abcde1f103c5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.05.19 17:58, Vladimir Sementsov-Ogievskiy wrote:
> 29.05.2019 18:33, Max Reitz wrote:
>> On 23.05.19 17:47, Vladimir Sementsov-Ogievskiy wrote:
>>> Current logic
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Reopen rw -> ro:
>>>
>>> Store bitmaps and release BdrvDirtyBitmap's.
>>>
>>> Reopen ro -> rw:
>>>
>>> Load bitmap list
>>> Skip bitmaps which for which we don't have BdrvDirtyBitmap [this is
>>>     the worst thing]
>>> A kind of fail with error message if we see not readonly bitmap
>>>
>>> This leads to at least the following bug:
>>>
>>> Assume we have bitmap0.
>>> Create external snapshot
>>>    bitmap0 is stored and therefore removed
>>> Commit snapshot
>>>    now we have no bitmaps
>>> Do some writes from guest (*)
>>>    they are not marked in bitmap
>>> Shutdown
>>> Start
>>>    bitmap0 is loaded as valid, but it is actually broken! It misses
>>>    writes (*)
>>> Incremental backup
>>>    it will be inconsistent
>>>
>>> New logic
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Reopen rw -> ro:
>>>
>>> Store bitmaps and don't remove them from RAM, only mark them readonly=

>>> (the latter is already done, but didn't work properly because of
>>> removing in storing function)
>>>
>>> Reopen to rw (don't filter case with reopen rw -> rw, it is supported=

>>> now in qcow2_reopen_bitmaps_rw)
>>>
>>> Load bitmap list
>>>
>>> Carefully consider all possible combinations of bitmaps in RAM and in=

>>> the image, try to fix corruptions, print corresponding error messages=
=2E
>>>
>>> Also, call qcow2_reopen_bitmaps_rw after the whole reopen queue
>>> commited, as otherwise we can't write to the qcow2 file child on reop=
en
>>> ro -> rw.
>>>
>>> Also, add corresponding test-cases to 255.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/qcow2.h              |   5 +-
>>>   include/block/block_int.h  |   2 +-
>>>   block.c                    |  29 ++----
>>>   block/qcow2-bitmap.c       | 197 ++++++++++++++++++++++++++--------=
---
>>>   block/qcow2.c              |   2 +-
>>>   tests/qemu-iotests/255     |   2 +
>>>   tests/qemu-iotests/255.out |  35 +++++++
>>>   7 files changed, 193 insertions(+), 79 deletions(-)
>>
>> [...]
>>
>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>> index 2b84bfa007..4e565db11f 100644
>>> --- a/block/qcow2-bitmap.c
>>> +++ b/block/qcow2-bitmap.c
>>
>> [...]
>>
>>> @@ -1103,76 +1110,150 @@ Qcow2BitmapInfoList *qcow2_get_bitmap_info_l=
ist(BlockDriverState *bs,
>>>       return list;
>>>   }
>>>  =20
>>> -int qcow2_reopen_bitmaps_rw_hint(BlockDriverState *bs, bool *header_=
updated,
>>> -                                 Error **errp)
>>> +/*
>>> + * qcow2_reopen_bitmaps_rw
>>> + *
>>> + * The function is called in bdrv_reopen_multiple after all calls to=

>>> + * bdrv_reopen_commit, when final bs is writable. It is done so, as =
we need
>>> + * write access to child bs, and with current reopening architecture=
, when
>>> + * reopen ro -> rw it is possible only after all reopen commits.
>>> + *
>>> + * So, we can't fail here.
>>
>> Why?  Because the current design forbids it?
>>
>> Then the current design seems flawed to me.
>>
>> [CC-ing Berto]
>>
>> Without having looked too close into this, it seems from your commit
>> message that it is possible to run into unrecoverable fatal errors her=
e.
>>   We cannot just ignore that on the basis that the current design cann=
ot
>> deal with that.
>>
>> It just appears wrong to me to update any flags in the image in the
>> .commit() part of a transaction.  We should try to do so in .prepare()=
=2E
>>   If it works, great, we=E2=80=99re set for .commit().  If it doesn=E2=
=80=99t, welp, time
>> for .abort() and pretend the image is still read-only (even though it
>> kind of may be half-prepared for writing).
>>
>> If we fail to set IN_USE in .commit(), that=E2=80=99s a fatal error in=
 my opinion.
>>
>> After some chatting with John, I=E2=80=99ve come to the following beli=
ef:
>>
>> When switching a node from RO to R/W, it must be able to write to its
>> children in .prepare() -- precisely because performing this switch may=

>> need some metadata change.  If we cannot do this change, then we canno=
t
>> switch the node to R/W.  So it=E2=80=99s clear to me that this needs t=
o be done
>> in .prepare().
>>
>> So I think a node=E2=80=99s children must be R/W before we can .prepar=
e() the
>> node.  That means we need to .commit() them.  That means we cannot hav=
e
>> a single transaction that switches a whole tree to be R/W, but it must=

>> consist of one transaction per level.
>>
>> If something fails, we need to roll back all the previous layers.  Wel=
l,
>> it depends.
>>
>> If we switch to R/W (and something fails), then we need to try to reve=
rt
>> the children we have already made R/W to be RO.  If that doesn=E2=80=99=
t work,
>> welp, too bad, but not fatal.
>=20
> And, than, why not do full reopen rw in .prepare, and just organize
> recursion so that children reopened rw before parent?

(1) Because .abort() must always succeed.  What I=E2=80=99m proposing is =
a
solution where we have to actively roll back, and that may not always wor=
k.

(2) Intuitively, I=E2=80=99d think it=E2=80=99d be easier to modify the c=
entral block
layer instead of having to check/modify all drivers that (A) their
prepare does everything, and (B) their abort can still roll back.  I may
well be wrong.

Maybe that is the easier solution.  .commit() would then just be a
cleanup, right?

> Than we again have
> one transaction for the tree, but abort may fail to rollback it in wors=
t case.
> But we cant avoid it anyway, with one transaction or with transactions =
per level..

If abort can roll back.

> So, just move all code from .commit to .prepare for reopen-rw and try t=
o roll-back
> it in .abort?

Well, "just".  It=E2=80=99s not just this one driver.

> Or do you have an idea for a patch?

No, I don=E2=80=99t.

Max

>> Switching to RO goes the other way around (parents to children), so if=

>> we encounter an error there, we cannot make that node=E2=80=99s childr=
en RO,
>> too.  We could try to revert the whole change and make the whole tree
>> R/W again, or we just don=E2=80=99t.  I think =E2=80=9Cjust don=E2=80=99=
t=E2=80=9D is reasonable.
>>
>> Max
>>
>>>      On the other hand, we may face different kinds of
>>> + * corruptions and/or just can't write IN_USE flags to the image due=
 to EIO.
>>> + *
>>> + * Try to handle as many cases as we can.
>>> + */
>>> +void qcow2_reopen_bitmaps_rw(BlockDriverState *bs)
>>
>=20
>=20



--MstzIDLGCPJ7urjG7uRRILJ4TV3P7rIu6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzuzPIACgkQ9AfbAGHV
z0BEnQf+MAx2Qf79KkyNIH1kAH1SIXFCpTTPLrJFc1V9LrzQPQZVBHepybKIgAec
k6lW2Zqw0WMA2Q4/NA8BFCno5qutFBg0cDSqoDcCnfTj+z+qxhW/plp59q94XR81
PxZVyJKW7Ln870XrzRcINUEC4UAG88SaOL8uqqLkMlmalfCXiPsY7c9pfLVYmQ8A
bvR4U+VT+e1IpXaOng36xmUzAtwfT9f3jgXCfhzxrBLuVhgvPsl6i2hYGK5eahmi
C2CuK6XBCdpxevkuz8F9ug29FFjZu0srx2txXt6DWOdiaJFt+zFtQXQI16BMakcm
7AAF+QbDl2VzitYC9v4ZRLmd/eFHHA==
=Pnrx
-----END PGP SIGNATURE-----

--MstzIDLGCPJ7urjG7uRRILJ4TV3P7rIu6--

