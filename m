Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A84C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEE620879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEE620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTorS-0006zl-Bd
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:38:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTogx-0005lt-Gq
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTogw-0000lo-AT
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:27:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40317)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTogt-0000jc-6d; Thu, 23 May 2019 10:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB9CB3088DB5;
	Thu, 23 May 2019 14:27:06 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.176])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D90C27D676;
	Thu, 23 May 2019 14:26:56 +0000 (UTC)
To: Sam Eiderman <shmuel.eiderman@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-3-shmuel.eiderman@oracle.com>
	<c117d2e2-eef2-df4f-ef3d-37a33426dd51@redhat.com>
	<B8380028-641C-4355-AF16-2F881E25CF8D@oracle.com>
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
Message-ID: <f8b7c7b3-fe64-59cc-6b11-1a87270caf00@redhat.com>
Date: Thu, 23 May 2019 16:26:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <B8380028-641C-4355-AF16-2F881E25CF8D@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="arstRX0SFu8Oi6JVaqbwy5rKPBEEFE2K4"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 23 May 2019 14:27:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qemu-img: rebase: Reduce reads on
 in-chain rebase
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
Cc: kwolf@redhat.com, eyal.moscovici@oracle.com, qemu-block@nongnu.org,
	arbel.moshe@oracle.com, qemu-devel@nongnu.org,
	liran.alon@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--arstRX0SFu8Oi6JVaqbwy5rKPBEEFE2K4
From: Max Reitz <mreitz@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 eyal.moscovici@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com,
 liran.alon@oracle.com, arbel.moshe@oracle.com
Message-ID: <f8b7c7b3-fe64-59cc-6b11-1a87270caf00@redhat.com>
Subject: Re: [PATCH v2 2/3] qemu-img: rebase: Reduce reads on in-chain rebase
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
 <20190502135828.42797-1-shmuel.eiderman@oracle.com>
 <20190502135828.42797-3-shmuel.eiderman@oracle.com>
 <c117d2e2-eef2-df4f-ef3d-37a33426dd51@redhat.com>
 <B8380028-641C-4355-AF16-2F881E25CF8D@oracle.com>
In-Reply-To: <B8380028-641C-4355-AF16-2F881E25CF8D@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.05.19 16:09, Sam Eiderman wrote:
>=20
>=20
>> On 23 May 2019, at 17:01, Max Reitz <mreitz@redhat.com
>> <mailto:mreitz@redhat.com>> wrote:
>>
>> On 02.05.19 15:58, Sam Eiderman wrote:
>>> In the following case:
>>>
>>> (base) A <- B <- C (tip)
>>>
>>> when running:
>>>
>>> =C2=A0=C2=A0=C2=A0qemu-img rebase -b A C
>>>
>>> QEMU would read all sectors not allocated in the file being rebased (=
C)
>>> and compare them to the new base image (A), regardless of whether the=
y
>>> were changed or even allocated anywhere along the chain between the n=
ew
>>> base and the top image (B). This causes many unneeded reads when
>>> rebasing an image which represents a small diff of a large disk, as i=
t
>>> would read most of the disk's sectors.
>>>
>>> Instead, use bdrv_is_allocated_above() to reduce the number of
>>> unnecessary reads.
>>>
>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com
>>> <mailto:karl.heubaum@oracle.com>>
>>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com
>>> <mailto:shmuel.eiderman@oracle.com>>
>>> Signed-off-by: Eyal Moscovici <eyal.moscovici@oracle.com
>>> <mailto:eyal.moscovici@oracle.com>>
>>> ---
>>> qemu-img.c | 25 ++++++++++++++++++++++++-
>>> 1 file changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qemu-img.c b/qemu-img.c
>>> index d9b609b3f0..7f20858cb9 100644
>>> --- a/qemu-img.c
>>> +++ b/qemu-img.c
>>
>> [...]
>>
>>> @@ -3422,6 +3428,23 @@ static int img_rebase(int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0continue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0}
>>>
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i=
f (prefix_chain_bs) {
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/*
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0* If cluster wasn't changed since prefix_chain=
, we
>>> don't need
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0* to take action
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D bdrv_is_allocated_above(bs, prefix_chain_bs,=

>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0offset, n, &n);
>>
>> This will always return true because it definitely is allocated in @bs=
,
>> or we wouldn=E2=80=99t be here. =C2=A0(We just checked that with
>> bdrv_is_allocated().) =C2=A0I think @top should be backing_bs(bs).
>>
>> Max
>=20
> I don=E2=80=99t think that=E2=80=99s true:
>=20
> Examine the case where we have the following chain:
>=20
> A <- B <- C
>=20
> When we rebase C directly over A: qemu-img rebase -b A C
>=20
> We must check for every offset (sector): bdrv_is_allocated_above(C, A,
> offset, n, &n);
>=20
> If a sector from C is allocated above A - it may have been changed - so=

> we need to do a read from A and a read from C and compare.
> If the sector is not allocated above, it was not changed - we don=E2=80=
=99t need
> to read from A or C.

First: Oops, somehow I inverted the bdrv_is_allocated() check in my
head.  (For context: I mean this part above this hunk here:

    /* If the cluster is allocated, we don't need to take action */
    ret =3D bdrv_is_allocated(bs, offset, n, &n);
    if (ret < 0) {
        error_report("error while reading image metadata: %s",
                     strerror(-ret));
        goto out;
    }



    if (ret) {
        continue;
    }

)  So at this point, the range definitely is *not* allocated in @bs.

But second: That still means that we do not have to check @bs itself,
because we already did.  We know the range isn=E2=80=99t allocated there,=
 so we
can start at its backing file.

On a more abstract level: No, we do not need to read all sectors from A
and C and compare them if they are allocated anywhere above A.  If they
are allocated in C, we=E2=80=99re good, because all we=E2=80=99d do is wr=
ite them back
to C (which is a no-op).  That=E2=80=99s exactly what the existing
bdrv_is_allocated() check is for.

So we only need to know whether the sectors are allocated above the base
(A) and below the top (C), so in your example, whether they are
allocated in B.  If they are, we need to compare and potentially copy,
if they are not, we can skip them.

So my claim that bdrv_is_allocated_above() would always return true is
wrong, but it still should use backing_bs(bs) for the top because we
have checked @bs already.

Max


--arstRX0SFu8Oi6JVaqbwy5rKPBEEFE2K4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzmra8ACgkQ9AfbAGHV
z0BQzwf/ZVdJIIJqqNj2bPye75yytP8HyAedpzJyVrspiHBx4+CSTArCTBynqSYH
8s8IMcxTz4MRdjQIz+JpqSqogGi/ZnE1hMN83aG+fUH+dAOWf/i/Wbr7/RNlA0iw
I1bN5yZNNDuehmuKPtOUZnYsff6AYXCfrsAWXwe4QOc3sO0KL8GFrzT5JBRzPgDY
kFR89n/TsIhZI33oumodOZ/RbQGsdEfjKyK4caccbiThJJuztfF2EdNVK2nr+7jm
nw6ph/TEXkoWFcCa9zS+3ylJ2CRnsaoATUxzklkD8GD19KsyTP1UZy/j06/y4QEX
Hl87rNT6qhO+b1OkhVUR2tMZAUErLA==
=+J5M
-----END PGP SIGNATURE-----

--arstRX0SFu8Oi6JVaqbwy5rKPBEEFE2K4--

