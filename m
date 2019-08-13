Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0D4C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137062067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137062067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxa1s-00041o-EH
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 12:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxa1R-0003Xc-Dv
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxa1P-0001rq-9O
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxa1M-0001pz-K0; Tue, 13 Aug 2019 12:51:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C03430D17F4;
 Tue, 13 Aug 2019 16:51:38 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB7AE8220F;
 Tue, 13 Aug 2019 16:51:31 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
 <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
 <e3fc5e07-33c6-1fe3-2042-35bdac0a03c3@virtuozzo.com>
 <4093762b-a1bc-d6b1-8358-4f9d1ab52557@virtuozzo.com>
 <e05af208-c7cb-31e6-bfab-62a44f5281e7@redhat.com>
 <cf9718b9-f36d-27f3-ad49-4f6fb1e1d7b3@virtuozzo.com>
 <9b7a3060-4880-9ef4-89f2-e8327ce655b8@redhat.com>
 <9479f6b6-3cfe-8594-d8fc-9a66c8f799c1@virtuozzo.com>
 <f331ace9-de9f-e5d9-a569-5f50059a522c@redhat.com>
 <cab80946-e12b-b47b-c825-12aef7cee615@virtuozzo.com>
 <e9e8070a-8c76-c8ef-ccd4-a3761f07f0f9@redhat.com>
 <699db7d9-f692-cf2c-259f-238a1dd53f51@virtuozzo.com>
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
Message-ID: <439fe503-5d2e-6b2f-5c53-d2efca4ac434@redhat.com>
Date: Tue, 13 Aug 2019 18:51:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <699db7d9-f692-cf2c-259f-238a1dd53f51@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PPdRBcHkymWGhy4TcWPl6zQjwz5u4YD4t"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 13 Aug 2019 16:51:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PPdRBcHkymWGhy4TcWPl6zQjwz5u4YD4t
Content-Type: multipart/mixed; boundary="VtOjIvqknPEM5Tyz8SeSCtM60dcQhn9Vm";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <439fe503-5d2e-6b2f-5c53-d2efca4ac434@redhat.com>
Subject: Re: [PATCH v3 6/7] block/backup: teach backup_cow_with_bounce_buffer
 to copy more at once
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
 <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
 <e3fc5e07-33c6-1fe3-2042-35bdac0a03c3@virtuozzo.com>
 <4093762b-a1bc-d6b1-8358-4f9d1ab52557@virtuozzo.com>
 <e05af208-c7cb-31e6-bfab-62a44f5281e7@redhat.com>
 <cf9718b9-f36d-27f3-ad49-4f6fb1e1d7b3@virtuozzo.com>
 <9b7a3060-4880-9ef4-89f2-e8327ce655b8@redhat.com>
 <9479f6b6-3cfe-8594-d8fc-9a66c8f799c1@virtuozzo.com>
 <f331ace9-de9f-e5d9-a569-5f50059a522c@redhat.com>
 <cab80946-e12b-b47b-c825-12aef7cee615@virtuozzo.com>
 <e9e8070a-8c76-c8ef-ccd4-a3761f07f0f9@redhat.com>
 <699db7d9-f692-cf2c-259f-238a1dd53f51@virtuozzo.com>
In-Reply-To: <699db7d9-f692-cf2c-259f-238a1dd53f51@virtuozzo.com>

--VtOjIvqknPEM5Tyz8SeSCtM60dcQhn9Vm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.19 18:45, Vladimir Sementsov-Ogievskiy wrote:
> 13.08.2019 19:30, Max Reitz wrote:
>> On 13.08.19 17:32, Vladimir Sementsov-Ogievskiy wrote:
>>> 13.08.2019 18:02, Max Reitz wrote:
>>>> On 13.08.19 17:00, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 13.08.2019 17:57, Max Reitz wrote:
>>>>>> On 13.08.19 16:39, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> 13.08.2019 17:23, Max Reitz wrote:
>>>>>>>> On 13.08.19 16:14, Vladimir Sementsov-Ogievskiy wrote:
>>
>> [...]
>>
>>>>>>>>> But still..
>>>>>>>>>
>>>>>>>>> Synchronous mirror allocates full-request buffers on guest writ=
e. Is it correct?
>>>>>>>>>
>>>>>>>>> If we assume that it is correct to double memory usage of guest=
 operations, than for backup
>>>>>>>>> the problem is only in write_zero and discard where guest-assum=
ed memory usage should be zero.
>>>>>>>>
>>>>>>>> Well, but that is the problem.  I didn=E2=80=99t say anything in=
 v2, because I
>>>>>>>> only thought of normal writes and I found it fine to double the =
memory
>>>>>>>> usage there (a guest won=E2=80=99t issue huge write requests in =
parallel).  But
>>>>>>>> discard/write-zeroes are a different matter.
>>>>>>>>
>>>>>>>>> And if we should distinguish writes from write_zeroes and disca=
rd, it's better to postpone this
>>>>>>>>> improvement to be after backup-top filter merged.
>>>>>>>>
>>>>>>>> But do you need to distinguish it?  Why not just keep track of m=
emory
>>>>>>>> usage and put the current I/O coroutine to sleep in a CoQueue or=

>>>>>>>> something, and wake that up at the end of backup_do_cow()?
>>>>>>>>
>>>>>>>
>>>>>>> 1. Because if we _can_ allow doubling of memory, it's more effect=
ive to not restrict allocations on
>>>>>>> guest writes. It's just seems to be more effective technique.
>>>>>>
>>>>>> But the problem with backup and zero writes/discards is that the m=
emory
>>>>>> is not doubled.  The request doesn=E2=80=99t need any memory, but =
the CBW
>>>>>> operation does, and maybe lots of it.
>>>>>>
>>>>>> So the guest may issue many zero writes/discards in parallel and t=
hus
>>>>>> exhaust memory on the host.
>>>>>
>>>>> So this is the reason to separate writes from write-zeros/discrads.=
 So at least write will be happy. And I
>>>>> think that write is more often request than write-zero/discard
>>>>
>>>> But that makes it complicated for no practical gain whatsoever.
>>>>
>>>>>>
>>>>>>> 2. Anyway, I'd allow some always-available size to allocate - let=
 it be one cluster, which will correspond
>>>>>>> to current behavior and prevent guest io hang in worst case.
>>>>>>
>>>>>> The guest would only hang if it we have to copy more than e.g. 64 =
MB at
>>>>>> a time.  At which point I think it=E2=80=99s not unreasonable to s=
equentialize
>>>>>> requests.
>>>>
>>>> Because of this.  How is it bad to start sequentializing writes when=
 the
>>>> data exceeds 64 MB?
>>>>
>>>
>>> So you want total memory limit of 64 MB? (with possible parameter lik=
e in mirror)
>>>
>>> And allocation algorithm to copy count bytes:
>>>
>>> if free_mem >=3D count: allocate count bytes
>>> else if free_mem >=3D cluster: allocate cluster and copy in a loop
>>> else wait in co-queue until some memory available and retry
>>>
>>> Is it OK for you?
>>
>> Sounds good to me, although I don=E2=80=99t know whether the second br=
anch is
>> necessary.  As I=E2=80=99ve said, the total limit is just an insurance=
 against a
>> guest that does some crazy stuff.
>>
>=20
> I'm afraid that if there would be one big request it may wait forever w=
hile smaller
> requests will eat most of available memory. So it would be unfair queue=
: smaller
> requests will have higher priority in low memory case. With [2] it beco=
mes more fair.

OK.  Sounds reasonable.

Max


--VtOjIvqknPEM5Tyz8SeSCtM60dcQhn9Vm--

--PPdRBcHkymWGhy4TcWPl6zQjwz5u4YD4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1S6pIACgkQ9AfbAGHV
z0C74wgAtmVdNQbJCVrLqlOoZzECu4Xxc/fWS/Ph3t1l+4cFc0cN/fWxPF2m7qkF
4KC/SbPGydMHkYPYDYrE5a+6hWmah5XxpHizmg6i2Ca8S2qyCEL+3FpA3uAJHdni
0rmNwqxCr6HLAb79kt6FqqHVM7T8FDY2uBshnfvXVBAgNbvOTMgHOFjajJSFBlhD
GzHrF8Lz2ufSFBLaCCo2q1icKJc4+vuLa6K5xqO5oNFEOM8AUb0k0jZGT3Io4RPW
epPxP8WLriImxxmzKinjj/ta6aEWcsszpYGLu+JhN8k2aEOxwQDHKVctj6tKCnWM
DFUWUbHQV3uY9QjOOXRgUkZxFpTqwQ==
=SX0A
-----END PGP SIGNATURE-----

--PPdRBcHkymWGhy4TcWPl6zQjwz5u4YD4t--

