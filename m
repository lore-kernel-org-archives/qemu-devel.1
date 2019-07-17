Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26E1C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A838821743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A838821743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnjrI-0007SY-Qi
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49108)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnjr5-0006xD-3N
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnjr3-0006qI-36
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:20:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnjqw-0006n8-O9; Wed, 17 Jul 2019 09:20:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0910821D8;
 Wed, 17 Jul 2019 13:20:13 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25D9F60BEE;
 Wed, 17 Jul 2019 13:20:09 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190619152603.5937-1-mreitz@redhat.com>
 <20190716144016.GE7297@linux.fritz.box>
 <82ce3044-e228-2453-5da2-9f86e4627066@redhat.com>
 <20190716163746.GH7297@linux.fritz.box>
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
Message-ID: <ced90b10-b5ee-21dc-4c46-e47aaac27fc9@redhat.com>
Date: Wed, 17 Jul 2019 15:20:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716163746.GH7297@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cZKTTdNFa8tdXoW3MFyxQdtwSYN87W39H"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 17 Jul 2019 13:20:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/9] block: Delay poll when ending
 drained sections
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cZKTTdNFa8tdXoW3MFyxQdtwSYN87W39H
Content-Type: multipart/mixed; boundary="UZYrh9tEO2Es68Db94Zy1GFmrlLqrQSUc";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <ced90b10-b5ee-21dc-4c46-e47aaac27fc9@redhat.com>
Subject: Re: [PATCH v2 0/9] block: Delay poll when ending drained sections
References: <20190619152603.5937-1-mreitz@redhat.com>
 <20190716144016.GE7297@linux.fritz.box>
 <82ce3044-e228-2453-5da2-9f86e4627066@redhat.com>
 <20190716163746.GH7297@linux.fritz.box>
In-Reply-To: <20190716163746.GH7297@linux.fritz.box>

--UZYrh9tEO2Es68Db94Zy1GFmrlLqrQSUc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 18:37, Kevin Wolf wrote:
> Am 16.07.2019 um 18:24 hat Max Reitz geschrieben:
>> On 16.07.19 16:40, Kevin Wolf wrote:
>>> Am 19.06.2019 um 17:25 hat Max Reitz geschrieben:
>>>> Hi,
>>>>
>>>> This is v2 to =E2=80=9Cblock: Keep track of parent quiescing=E2=80=9D=
=2E
>>>>
>>>> Please read this cover letter, because I=E2=80=99m very unsure about=
 the design
>>>> in this series and I=E2=80=99d appreciate some comments.
>>>>
>>>> As Kevin wrote in his reply to that series, the actual problem is th=
at
>>>> bdrv_drain_invoke() polls on every node whenever ending a drain.  Th=
is
>>>> may cause graph changes, which is actually forbidden.
>>>>
>>>> To solve that problem, this series makes the drain code construct a =
list
>>>> of undrain operations that have been initiated, and then polls all o=
f
>>>> them on the root level once graph changes are acceptable.
>>>>
>>>> Note that I don=E2=80=99t like this list concept very much, so I=E2=80=
=99m open to
>>>> alternatives.
>>>
>>> So drain_end is different from drain_begin in that it wants to wait o=
nly
>>> for all bdrv_drain_invoke() calls to complete, but not for other
>>> requests that are in flight. Makes sense.
>>>
>>> Though instead of managing a whole list, wouldn't a counter suffice?
>>>
>>>> Furthermore, all BdrvChildRoles with BDS parents have a broken
>>>> .drained_end() implementation.  The documentation clearly states tha=
t
>>>> this function is not allowed to poll, but it does.  So this series
>>>> changes it to a variant (using the new code) that does not poll.
>>>>
>>>> There is a catch, which may actually be a problem, I don=E2=80=99t k=
now: The new
>>>> variant of that .drained_end() does not poll at all, never.  As
>>>> described above, now every bdrv_drain_invoke() returns an object tha=
t
>>>> describes when it will be done and which can thus be polled for.  Th=
ese
>>>> objects are just discarded when using BdrvChildRole.drained_end().  =
That
>>>> does not feel quite right.  It would probably be more correct to let=

>>>> BdrvChildRole.drained_end() return these objects so the top level
>>>> bdrv_drained_end() can poll for their completion.
>>>>
>>>> I decided not to do this, for two reasons:
>>>> (1) Doing so would spill the =E2=80=9Clist of objects to poll for=E2=
=80=9D design to
>>>>     places outside of block/io.c.  I don=E2=80=99t like the design v=
ery much as
>>>>     it is, but I can live with it as long as it=E2=80=99s constraine=
d to the
>>>>     core drain code in block/io.c.
>>>>     This is made worse by the fact that currently, those objects are=
 of
>>>>     type BdrvCoDrainData.  But it shouldn=E2=80=99t be a problem to =
add a new
>>>>     type that is externally visible (we only need the AioContext and=

>>>>     whether bdrv_drain_invoke_entry() is done).
>>>>
>>>> (2) It seems to work as it is.
>>>>
>>>> The alternative would be to add the same GSList ** parameter to
>>>> BdrvChildRole.drained_end() that I added in the core drain code in p=
atch
>>>> 2, and then let the .drained_end() implementation fill that with obj=
ects
>>>> to poll for.  (Which would be accomplished by adding a frontend to
>>>> bdrv_do_drained_end() that lets bdrv_child_cb_drained_poll() pass th=
e
>>>> parameter through.)
>>>>
>>>> Opinions?
>>>
>>> I think I would add an int* to BdrvChildRole.drained_end() so that we=

>>> can just increase the counter whereever we need to.
>>
>> So you mean just polling the @bs for which a caller gave poll=3Dtrue u=
ntil
>> the counter reaches 0?  I=E2=80=99ll try, sounds good (if I can get it=
 to work).
>=20
> Yes, that's what I have in mind.
>=20
> We expect graph changes to happen during the polling, but I think the
> caller is responsible for making sure that the top-level @bs stays
> around, so we don't need to be extra careful here.
>=20
> Also, bdrv_drain_invoke() is always called in the same AioContext as th=
e
> top-level drain operation, so the whole aio_context_acquire/release
> stuff from this series should become unnecessary, and we don't need
> atomics to access the counter either.
>=20
> So I think this should really simplify the series a lot.

Hm.  Unfortunately, not all nodes in a chain always have the same
AioContext.

I think they generally should, but there is at least one exception:
bdrv_set_aio_context*() itself.  bdrv_set_aio_context_ignore() drains
the node, then puts other members of the subgraph into the same
AioContext, then itself.

Now say this reaches the bottom node.  That node will not recurse
anywhere else, but only change its own AioContext, in a drained section.
 So when that section ends, the bottom node will be in a different
AioContext than the other nodes.

So, er, well.  I have three ideas:

(1) Skip the polling on the top level drained_end if the node still has
another quiesce_counter on it.  Sounds a bit too error-prone to me.

(2) Drop the drained sections in bdrv_set_aio_context_ignore().  Instead
require the root caller to have the whole subtree drained.  That way,
drained_end will never be invoked while the subtree has different
AioContexts.

(3) I need a list after all (one that only contains AioContexts, but stil=
l).


I like (3) as little as I did in this series.  (1) seems wrong.  I=E2=80=99=
ll
try (2) first.

Max


--UZYrh9tEO2Es68Db94Zy1GFmrlLqrQSUc--

--cZKTTdNFa8tdXoW3MFyxQdtwSYN87W39H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0vIIcACgkQ9AfbAGHV
z0Dhvwf/dluGUc+EYuBscELMkbSf/45cTKJ2eEhyqwIrcwrVKGNQp1CzSWmVJgyX
H32AUXk6kYMgGeh06NNkZOoAqSLR7vC3JGAxAoR9lX76J5Q4sqqjc0vknK6MsSpQ
4+AWAfWt7W1PpqKM+uvZsQRkrZGTHkfdq7XlLa+HO9ZCnxlhP7O6xRcmH87TpSKy
GXoIkoHNf+zRxReAna68FD9tYJ12C1R0DFCUt8Jjk/i1/8bT6pK2pqHLpaET7D1n
moTtpqmsR/XbnhOvKDX/u7MY+S6z29oKbvOWvMK2N1TnijKcDMswJc3tuMWYLAJx
Fl3OtJZI7Z2li8rColRZdtv4QXmJcg==
=lqtU
-----END PGP SIGNATURE-----

--cZKTTdNFa8tdXoW3MFyxQdtwSYN87W39H--

