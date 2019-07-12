Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3865CC742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105CF20863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105CF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvvC-0007Oa-BI
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59876)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlvur-0006LN-4N
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlvup-0005W3-SS
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlvum-0005SE-2u; Fri, 12 Jul 2019 09:48:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3C8B308FC4D;
 Fri, 12 Jul 2019 13:48:42 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E57D5DD8D;
 Fri, 12 Jul 2019 13:48:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-3-mreitz@redhat.com>
 <20190712094919.GC4514@dhcp-200-226.str.redhat.com>
 <e0d93b2b-21c2-3eaa-bf27-0a1c7f19f4e4@redhat.com>
 <20190712111720.GF4514@dhcp-200-226.str.redhat.com>
 <78d1d91b-8a13-9b9b-a891-650c6b4d417b@redhat.com>
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
Message-ID: <6d7c64f1-079a-e50b-abcc-b290ae3f8137@redhat.com>
Date: Fri, 12 Jul 2019 15:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <78d1d91b-8a13-9b9b-a891-650c6b4d417b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RfUUmvDztYnrcSR5xqB0UGA72GiOzHF6b"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 12 Jul 2019 13:48:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 2/5] block: Generic truncation fallback
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
--RfUUmvDztYnrcSR5xqB0UGA72GiOzHF6b
Content-Type: multipart/mixed; boundary="93rPAXAAzi4f8HKV8HCcjTLjJ7gN1Z63s";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <6d7c64f1-079a-e50b-abcc-b290ae3f8137@redhat.com>
Subject: Re: [RFC 2/5] block: Generic truncation fallback
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-3-mreitz@redhat.com>
 <20190712094919.GC4514@dhcp-200-226.str.redhat.com>
 <e0d93b2b-21c2-3eaa-bf27-0a1c7f19f4e4@redhat.com>
 <20190712111720.GF4514@dhcp-200-226.str.redhat.com>
 <78d1d91b-8a13-9b9b-a891-650c6b4d417b@redhat.com>
In-Reply-To: <78d1d91b-8a13-9b9b-a891-650c6b4d417b@redhat.com>

--93rPAXAAzi4f8HKV8HCcjTLjJ7gN1Z63s
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.07.19 13:48, Max Reitz wrote:
> On 12.07.19 13:17, Kevin Wolf wrote:
>> Am 12.07.2019 um 12:58 hat Max Reitz geschrieben:
>>> On 12.07.19 11:49, Kevin Wolf wrote:
>>>> Am 11.07.2019 um 21:58 hat Max Reitz geschrieben:
>>>>> If a protocol driver does not support truncation, we call fall back=
 to
>>>>> effectively not doing anything if the new size is less than the act=
ual
>>>>> file size.  This is what we have been doing for some host device dr=
ivers
>>>>> already.
>>>>
>>>> Specifically, we're doing it for drivers that access a fixed-size im=
age,
>>>> i.e. block devices rather than regular files. We don't want to do th=
is
>>>> for drivers where the file size could be changed, but just didn't
>>>> implement it.
>>>>
>>>> So I would suggest calling the function more specifically something =
like
>>>> bdrv_co_truncate_blockdev(), and not using it as an automatic fallba=
ck
>>>> in bdrv_co_truncate(), but just make it the BlockDriver.bdrv_co_trun=
cate
>>>> implementation for those drivers where it makes sense.
>>>
>>> I was thinking about this, but the problem is that .bdrv_co_truncate(=
)
>>> does not get a BdrvChild, so an implementation for it cannot generica=
lly
>>> zero the first sector (without bypassing the permission system, which=

>>> would be wrong).
>>
>> Hm, I see. The next best thing would then probably having a bool in
>> BlockDriver that enables the fallback.
>>
>>> So the function pointer would actually need to be set to something li=
ke
>>> (int (*)(BlockDriverState *, int64_t, PreallocMode, Error **))42ul, o=
r a
>>> dummy function that just aborts, and then bdrv_co_truncate() would
>>> recognize this magic constant.  But that seemed so weird to me that I=

>>> decided just not to do it, mostly because I was wondering what would =
be
>>> so bad about treating images whose size we cannot change because we
>>> haven=E2=80=99t implemented it exactly like fixed-size images.
>>>
>>> (Also, =E2=80=9Cfixed-size=E2=80=9D is up to interpretation.  You can=
 change an LVM
>>> volume=E2=80=99s size.  qemu doesn=E2=80=99t do it, obviously.  But t=
hat is the reason
>>> for the warning qemu-img resize emits when it sees that the file size=

>>> did not change.)
>>>
>>>> And of course, we only need these fake implementations because qemu-=
img
>>>> (or .bdrv_co_create_opts) always wants to create the protocol level.=
 If
>>>> we could avoid this, then we wouldn't need any of this.
>>>
>>> It=E2=80=99s trivial to avoid this.  I mean, patch 4 does exactly tha=
t.
>>>
>>> So it isn=E2=80=99t about avoiding creating the protocol level, it=E2=
=80=99s about
>>> avoiding the truncation there.  But why would you do that?
>>
>> Because we can't actually truncate there. We can only do the fake thin=
g
>> and claim we have truncated even though the size didn't change.
>=20
> You=E2=80=99re right.  I actually didn=E2=80=99t realize that we have n=
o drivers that
> support truncation, but not image creation.
>=20
> Yes, then it=E2=80=99s stupid.
>=20
> I thought it was a reasonable thing to do for such drivers.
>=20
> So I suppose the best thing is to do what I hinted at in my reply to
> your reply to patch 3, which is to drop patches 2 and 3 and instead mak=
e
> the creation fallback work around blk_truncate() failures.

Oh no.  Now I remember.  The problem with that is that nowadays all
format drivers truncate the protocol file to 0 in their
=2Ebdrv_co_create() implementation.  Aw, man.

Max


--93rPAXAAzi4f8HKV8HCcjTLjJ7gN1Z63s--

--RfUUmvDztYnrcSR5xqB0UGA72GiOzHF6b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0oj7UACgkQ9AfbAGHV
z0CqCQgAnjWobyO2QlDE4RwprU+Bie2tSHcGQxoFAi2/BajpozJlRyF3W3BynQW8
qDPaYcGgdxmWH9N2uL3ReIVTWqBEc3sF7yAamerlhdgL+2mAiqltKirR4POhthaE
l6um96BqpYD9eALpwilz7uVszJjNPpM/Nqftrae37gT+8OWpaUa0m4zO5/486Au6
zptJIPmCMzQ09r7++aELnnl0dmDh++5L2F0aURbw0ccINWo6/eEneV95b6mFr22J
t/w0VK+b+PAyV+Uc01OH2RyT/4pr7rtBEPrMBcpHywzraE9WugDyzS++0OsF+R7y
DukPHbWaAs3SHK6e8kpD2b5XDsQJaw==
=mutK
-----END PGP SIGNATURE-----

--RfUUmvDztYnrcSR5xqB0UGA72GiOzHF6b--

