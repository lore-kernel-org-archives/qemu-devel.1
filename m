Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4BAC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B8A21924
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B8A21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7KHy-0004Ei-QQ
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7KHH-0003gS-N7
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7KHG-00040g-3m
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:04:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7KHB-0003xJ-CB; Mon, 09 Sep 2019 10:04:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86085300183D;
 Mon,  9 Sep 2019 14:04:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37B135D9DC;
 Mon,  9 Sep 2019 14:04:10 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
 <20190909093604.GB13841@localhost.localdomain>
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
Message-ID: <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
Date: Mon, 9 Sep 2019 16:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909093604.GB13841@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3WEveU7XHsXAS47iKKMy6j5iIxlOvYxLq"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 09 Sep 2019 14:04:15 +0000 (UTC)
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
--3WEveU7XHsXAS47iKKMy6j5iIxlOvYxLq
Content-Type: multipart/mixed; boundary="tJOIOtgPBIq7wxqDkogNZ2JB9lYYdoOIX";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
Subject: Re: [PATCH v6 04/42] block: Add child access functions
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
 <20190909093604.GB13841@localhost.localdomain>
In-Reply-To: <20190909093604.GB13841@localhost.localdomain>

--tJOIOtgPBIq7wxqDkogNZ2JB9lYYdoOIX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 11:36, Kevin Wolf wrote:
> Am 09.09.2019 um 09:56 hat Max Reitz geschrieben:
>> On 04.09.19 18:16, Kevin Wolf wrote:
>>> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>>>> There are BDS children that the general block layer code can access,=

>>>> namely bs->file and bs->backing.  Since the introduction of filters =
and
>>>> external data files, their meaning is not quite clear.  bs->backing =
can
>>>> be a COW source, or it can be an R/W-filtered child; bs->file can be=
 an
>>>> R/W-filtered child, it can be data and metadata storage, or it can b=
e
>>>> just metadata storage.
>>>>
>>>> This overloading really is not helpful.  This patch adds function th=
at
>>>> retrieve the correct child for each exact purpose.  Later patches in=

>>>> this series will make use of them.  Doing so will allow us to handle=

>>>> filter nodes and external data files in a meaningful way.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>>>
>>> Each time I look at this patch, I'm confused by the function names.
>>> Maybe I should just ask what the idea there was, or more specifically=
:
>>> What does the "filtered" in "filtered child" really mean?
>>>
>>> Apparently any child of a filter node is "filtered" (which makes sens=
e),
>>
>> It isn=E2=80=99t, filters can have non-filter children.  For example, =
backup-top
>> could have the source as a filtered child and the target as a non-filt=
er
>> child.
>=20
> Hm, okay, makes sense. I had a definition in mind that says that filter=

> nodes only have a single child node. Is it that a filter may have only =
a
> single _filtered_ child node?

Well, there=E2=80=99s Quorum...

>>> but also bs->backing of a qcow2 image, while bs->file of qcow2 isn't.=

>>> raw doesn't have any "filtered" child. What's the system behind this?=

>>
>> =E2=80=9Cfiltered=E2=80=9D means: If the parent node returns data from=
 this child, it
>> won=E2=80=99t modify it, neither its content nor its position.  COW an=
d R/W
>> filters differ in how they handle writes; R/W filters pass them throug=
h
>> to the filtered child, COW filters copy them off to some other child
>> node (and then the filtered child=E2=80=99s data will no longer be vis=
ible at
>> that location).
>=20
> But there is no reason why a node couldn't fulfill this condition for
> more than one child node. bdrv_filtered_child() isn't well-defined then=
=2E
> Technically, the description "Return any filtered child" is correct
> because "any" can be interpreted as "an arbitrary", but obviously that
> makes the function useless.

Which is why it currently returns NULL for Quorum.

> Specficially, according to your definition, qcow2 filters both the
> backing file (COW filter) and the external data file (R/W filter).

Not wrong.  But the same question as for raw arises: Is there any use to
declaring qcow2 an R/W filter driver just because it fits the definition?=


>> The main reason behind the common =E2=80=9Cfiltered=E2=80=9D name is f=
or the generic
>> functions that work on both COW and true filter (R/W filters) chains.
>> We need such functionality sometimes.  I personally felt like the
>> concept of true (R/W) filters and COW children was similar enough to
>> share a common name base.
>=20
> We generally call this concept a "backing chain".

I suppose that=E2=80=99s an exclusive =E2=80=9Cwe=E2=80=9D?  Because I us=
e =E2=80=9Dbacking chain=E2=80=9D to
refer to COW chains exclusively.

Such a chain may or may not include filters, but they are not really
load-bearing nodes of the chain.  As such, I generally want to skip them
when looking at a backing chain (hence e.g. bdrv_backing_chain_next()).

=46rom what I can tell nobody has ever formalized any terms regarding COW=

backing chains or R/W filter chains.  This series is an attempt.

>> qcow2 has a COW child.  As such, it acts as a COW filter in the sense =
of
>> the function names.
>>
>> raw has neither a COW child nor acts as an R/W filter.  As such, it ha=
s
>> no filtered child.  My opinion on this hasn=E2=80=99t changed.
>>
>> (To reiterate, in practice I see no way anyone would ever use raw as a=
n
>> R/W filter.
>> Either you use it without offset/size, in which case you simply use it=

>> in lieu of a format node, so you precisely don=E2=80=99t want it to ac=
t as a
>> filter when it comes to allocation information and so on (even though =
it
>> can be classified a filter here).
>> Or you use it as kind of a filter with offset/size, but then it no
>> longer is a filter.
>=20
> Agreed with offset, but with only size, it matches your definition of a=

> filter.

So?

Should we treat it as a filter when @offset is 0 but otherwise not?
That totally wouldn=E2=80=99t be confusing to users.

>> Filters are defined by =E2=80=9CEvery filter must fulfill these condit=
ions: ...=E2=80=9D
>> =E2=80=93 not by =E2=80=9CEverything that fulfills these conditions is=
 a filter=E2=80=9D.
>> Marking a driver as a filter has consequences, and I don=E2=80=99t see=
 why we
>> would want those consequences for raw.)
>>
>>> It looks like bdrv_filtered_child() is the right function to iterate
>>> along a backing file chain, but I just still fail to connect that and=

>>> the name of the function in a meaningful way.
>>
>> It=E2=80=98s the right function to iterate along a filter chain.  This=
 includes
>> COW backing children and R/W filtered children.
>=20
> qcow2 doesn't fulfill the conditions for begin a filter driver. Two of
> its possible children fulfill the conditions for being a filtered child=
=2E
> You can pick either approach, talking about a "filter chain" just
> doesn't make sense there. Either the chain is broken by a non-filter
> driver like qcow2, or it must become a filter tree.

I have no idea what your point is.  There is no point in making it a
filter tree at this point, just as we never had a backing tree.

And the good example is Quorum.  qcow2 is a bad example because there is
no benefit in marking it an R/W filter for its external data file,
exactly like is the case for raw.

> What we're really interested in is iterating the backing chain even
> across filter nodes, so your implementation achieves the right result.
> It just feels completely arbitrary, counterintuitive and confusing to
> call this a (or actually "the") "filter chain" and to pretend that the
> name tells anyone what it really is.

So exactly the same as =E2=80=9Cbs->backing=E2=80=9D or =E2=80=9Cbacking =
chain=E2=80=9D for me.

You disagreeing with me on these terms to me shows that there is a need
to formalize.  This is precisely what I want to do in this series.

The fact that we don=E2=80=99t use the term =E2=80=9Cfilter chain=E2=80=9D=
 so far is the reason
why I introduce it.  Because it comes as a clean slate.  =E2=80=9Cbacking=
 chain=E2=80=9D
already means something to me, and it means something different.

Max


--tJOIOtgPBIq7wxqDkogNZ2JB9lYYdoOIX--

--3WEveU7XHsXAS47iKKMy6j5iIxlOvYxLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12W9YACgkQ9AfbAGHV
z0DqRggAs3PmTn1VGCg2yiMMaztTWtEQCEM0MPnCmiJxfzDpKjzTVxdInGl53AXj
ItOpbSyZfez7v9G5KZeJwxc//cmOw0pwsJ8cwWdRfxzHZIXdailD4szRhJOcNAAe
3cbdiAoL/KBaQMaje2paAzLPurE+wS9vkHe1mQP+4gz2cM6mOpXUnE7nzEdcPquC
Jj2F/En5SpSut3ejZdJqtCPiLBcVPOOV2kAaLd1CoUHflTeDMIa5JOKWFFA4f82/
s6X9S98Wl0STOCmCL64F82voKChMqGs2NttT4eSg42WGOLvlLJGPIKrexrIAyRlP
GT+k6cZJ2HZ2Pl8rv6N/pUQKCZKOMA==
=ZUHx
-----END PGP SIGNATURE-----

--3WEveU7XHsXAS47iKKMy6j5iIxlOvYxLq--

