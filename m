Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86517C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1759C2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1759C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33038 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnIy-0008Rb-28
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54532)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfmyu-0007aE-SF
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfmys-0000hd-9n
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfmyo-0000br-Hd; Tue, 25 Jun 2019 11:03:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 39B9E307D945;
 Tue, 25 Jun 2019 15:03:23 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-156.brq.redhat.com
 [10.40.204.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59FCB1019303;
 Tue, 25 Jun 2019 15:03:07 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87a5ec62-6274-77c6-60a3-b4ad7b4ec822@redhat.com>
 <3362e8ef-d698-e860-9830-45a3f924ef48@virtuozzo.com>
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
Message-ID: <a63c700d-8206-06c5-ee5e-70d0534dd147@redhat.com>
Date: Tue, 25 Jun 2019 17:03:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3362e8ef-d698-e860-9830-45a3f924ef48@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="naesmTpyGTh4gWMrzve75dQXPgeaBjflU"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 25 Jun 2019 15:03:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 0/3] block/stream: get rid of the base
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--naesmTpyGTh4gWMrzve75dQXPgeaBjflU
Content-Type: multipart/mixed; boundary="1c2ynLPIb71Ys6PSBgV8FO7cJMtSipvWs";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "berto@igalia.com"
 <berto@igalia.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a63c700d-8206-06c5-ee5e-70d0534dd147@redhat.com>
Subject: Re: [PATCH v7 0/3] block/stream: get rid of the base
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87a5ec62-6274-77c6-60a3-b4ad7b4ec822@redhat.com>
 <3362e8ef-d698-e860-9830-45a3f924ef48@virtuozzo.com>
In-Reply-To: <3362e8ef-d698-e860-9830-45a3f924ef48@virtuozzo.com>

--1c2ynLPIb71Ys6PSBgV8FO7cJMtSipvWs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.06.19 16:40, Andrey Shinkevich wrote:
>=20
>=20
> On 19/06/2019 22:29, Max Reitz wrote:
>> On 29.05.19 19:56, Andrey Shinkevich wrote:
>>> This series introduces a bottom intermediate node that eliminates the=

>>> dependency on the base that may change while stream job is running.
>>> It happens when stream/commit parallel jobs are running on the same
>>> backing chain. The base node of the stream job may be a top node of
>>> the parallel commit job and can change before the stream job is
>>> completed. We avoid that dependency by introducing the bottom node.
>>>
>>> v7: [resend by Andrey]
>>>    01: assert(intermediate) was inserted before the call to
>>>        bdrv_is_allocated() in the intermediate node loop of the
>>>        bdrv_is_allocated_above() as suggested by Max.
>>>    02: The change of the intermediate node loop in the stream_start()=
 was
>>>        rolled back to its original design and the reassignment of the=
 base
>>>        node pointer was added as Vladimir and Max suggested. The rele=
vant
>>>        comment was amended.
>>>
>>> v6: [resend by Vladimir]
>>>    01: improve comment in block/io.c, suggested by Alberto
>>>
>>> v5: [resend by Vladimir]
>>>    01: use comment wording in block/io.c suggested by Alberto
>>>
>>> v4:
>>> trace_stream_start reverted to the base.
>>> bdrv_is_allocated_above_inclusive() deleted and the new parameter
>>> 'bool include_base' was added to the bdrv_is_allocated_above().
>>>
>>> Andrey Shinkevich (3):
>>>    block: include base when checking image chain for block allocation=

>>>    block/stream: refactor stream_run: drop goto
>>>    block/stream: introduce a bottom node
>>>
>>>   block/commit.c         |  2 +-
>>>   block/io.c             | 21 +++++++++++++------
>>>   block/mirror.c         |  2 +-
>>>   block/replication.c    |  2 +-
>>>   block/stream.c         | 56 ++++++++++++++++++++++++---------------=
-----------
>>>   include/block/block.h  |  3 ++-
>>>   tests/qemu-iotests/245 |  4 ++--
>>>   7 files changed, 49 insertions(+), 41 deletions(-)
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> Just needs some simple changes to patch 1 to rebase it on 863cc78f1b3
>> and c8bb23cbdbe.
>>
>> Max
>>
>=20
> Please let us know who would take this series for pull request?

Nothing, I was just waiting for my current pull request (lingering from
last week due to a build failure because of one of the patches) to be
processed.

I suppose I won=E2=80=99t wait longer and just take this series now and d=
eal
with the fallout later if there=E2=80=99s something else in my last week=E2=
=80=99s pull
request that needs fixing...

So: Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--1c2ynLPIb71Ys6PSBgV8FO7cJMtSipvWs--

--naesmTpyGTh4gWMrzve75dQXPgeaBjflU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0SN6kACgkQ9AfbAGHV
z0AV0gf8C26hTvBJFcjt42I1OLimAiFs+GFiSpfjcexjmC91UmhBGOkfFVbIU15v
MyPz8uZK8hqQDZZAPNAOiKV8HECdfVql5Jyj4dPbjj8DcmFzQwreBNacaWUgbui5
0DRl/JaQRjAjlY8/5tiZEVaMFC4IIMn71qSfq8oVrN5HVW1ifge1M2/SBsGyebI1
jhTWA2hqJ9qxwEOvyybiu4XxeYZFmLJPr5oBmzw5rWb3UfJjURAQKwsBwbGJO6Rt
6wt3g3QsZ6K6wA/pSov5xrl+jUneu68K7BU0jLW/uST8UbupMtC8F+zUBdN3UjW+
6yC0IaAs8Zvap9z+WpoKfTTknNm4fg==
=0i/f
-----END PGP SIGNATURE-----

--naesmTpyGTh4gWMrzve75dQXPgeaBjflU--

