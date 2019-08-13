Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1874BC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11A420651
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11A420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxY4c-0006S1-5J
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42304)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxY4C-00060F-Pq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxY4B-0006TG-Dv
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:46:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxY48-0006SB-GT; Tue, 13 Aug 2019 10:46:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA8B4307D848;
 Tue, 13 Aug 2019 14:46:23 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52B707FB8C;
 Tue, 13 Aug 2019 14:46:22 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <7fcab62a-ad7b-4105-7a23-76c46d8cee0f@virtuozzo.com>
 <20190813120112.GH4663@localhost.localdomain>
 <20190813132150.GI4663@localhost.localdomain>
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
Message-ID: <6c666a03-e679-c566-e309-5472a2bbef3f@redhat.com>
Date: Tue, 13 Aug 2019 16:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813132150.GI4663@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JEuZoX91LkbmZWfOMGkq3wlLmALoRyVgr"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 13 Aug 2019 14:46:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block/raw-format: switch
 to BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JEuZoX91LkbmZWfOMGkq3wlLmALoRyVgr
Content-Type: multipart/mixed; boundary="DqEnOkyNnkPUadNoi0DcxqGlBtfF7mPrE";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <6c666a03-e679-c566-e309-5472a2bbef3f@redhat.com>
Subject: Re: [Qemu-block] [PATCH 1/2] block/raw-format: switch to
 BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <7fcab62a-ad7b-4105-7a23-76c46d8cee0f@virtuozzo.com>
 <20190813120112.GH4663@localhost.localdomain>
 <20190813132150.GI4663@localhost.localdomain>
In-Reply-To: <20190813132150.GI4663@localhost.localdomain>

--DqEnOkyNnkPUadNoi0DcxqGlBtfF7mPrE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.19 15:21, Kevin Wolf wrote:
> Am 13.08.2019 um 14:01 hat Kevin Wolf geschrieben:
>> Am 13.08.2019 um 13:28 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> 13.08.2019 14:04, Kevin Wolf wrote:
>>>> Am 12.08.2019 um 20:11 hat Vladimir Sementsov-Ogievskiy geschrieben:=

>>>>> BDRV_BLOCK_RAW makes generic bdrv_co_block_status to fallthrough to=

>>>>> returned file. But is it correct behavior at all? If returned file
>>>>> itself has a backing file, we may report as totally unallocated and=

>>>>> area which actually has data in bottom backing file.
>>>>>
>>>>> So, mirroring of qcow2 under raw-format is broken. Which is illustr=
ated
>>>>> by following commit with a test. Let's make raw-format behave more
>>>>> correctly returning BDRV_BLOCK_DATA.
>>>>>
>>>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
>>>>
>>>> After some reading, I think I came to the conclusion that RAW is the=

>>>> correct thing to do. There is indeed a problem, but this patch is tr=
ying
>>>> to fix it in the wrong place.
>>>>
>>>> In the case where the backing file contains some data, and we have a=

>>>> 'raw' node above the qcow2 overlay node, the content of the respecti=
ve
>>>> block is not defined by the queried backing file layer, so it is
>>>> completely correct that bdrv_is_allocated() returns false, like it w=
ould
>>>> if you queried the qcow2 layer directly. If it returned true, we wou=
ld
>>>> copy everything, which isn't right either (the test cases should may=
 add
>>>> the qemu-img map output of the target so this becomes visible).
>>>>
>>>> The problem is that we try to recurse along the backing chain, but w=
e
>>>> fail to make the step from the raw node to the backing file.
>>>
>>> I'd say, the problem is that we ignore backing chain of non-backing
>>> child
>>
>> Yes, exactly. And I know even less about what happens if a child is
>> neither bs->file nor bs->backing. Imagine a qcow2 image with an extern=
al
>> data file that is a qcow2 image with a backing file itself. :-)
>>
>> Actually, just having two qcow2 layers nested with bs->file probably
>> already fails.
>>
>>>> Note that just extending Max's "deal with filters" is not enough to =
fix
>>>> this because raw doesn't actually meet all of the criteria for being=
 a
>>>> filter in this sense (at least because the 'offset' option can chang=
e
>>>> offsets between raw and its child).
>>>>
>>>> I think this is essentially a result of special-casing backing files=

>>>> everywhere instead of treating them like children like any other.
>>>
>>> But we need to special-case them, as we have interfaces operating on
>>> backing chain,
>>
>> I'm not sure yet if this means that these interfaces are wrong, but it=

>> might. But in any case, I think we depend on special-casing in more
>> places than we should.
>>
>>>> bdrv_co_block_status_above() probably shouldn't recurse along the
>>>> backing chain, but along the returned *file pointers, and consider t=
he
>>>> returned offset in *map.
>>>
>>> So, you mean that in case of unallocated, format layer should return
>>> it's backing file as file?
>>
>> Yes, because that's where it's reading the data from.
>>
>> Hm... Now I wonder what this means for DATA... In theory it would have=

>> to be set for backing files, but that would make it completely useless=
=2E
>> We can distinguish the cases by looking at *file, but how does the
>> generic block layer know which child should be counted as "allocated"
>> and which shouldn't?
>=20
> Possible answer to my own question:
>=20
> bdrv_is_allocated(bs) isn't even asking a complete question. What we
> really need to ask is whether a specific child is where data comes from=
=2E
>=20
> What the current callers of bdrv_is_allocated() are interested in is
> whether the data comes from bs->backing or from somewhere else. That is=
,
> if removing bs from the graph (so that all parents of bs would point to=

> bs->backing instead) would still result in the same data in the given
> block.

Maybe callers of bdrv_is_allocated() should just ensure that the node
they pass actually has a backing file.

(If it doesn=E2=80=99t, they should skip all filters until it does.)

Max


--DqEnOkyNnkPUadNoi0DcxqGlBtfF7mPrE--

--JEuZoX91LkbmZWfOMGkq3wlLmALoRyVgr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1SzTwACgkQ9AfbAGHV
z0As2AgAlIqPUOBASETBROrYYEMldjlsXr9NNPAJ+nvo5FkQ/hVJDDa6w+iQCzrr
86KADQpetrWsBM5FCsdWxc7iErVwIcVHXVigtrQ5Ezhb7NL1A5HyLCeea0S+BgtH
q2LDMpWbR67rP9FisZY3AjfiFx1aAJO8BjfoqIbXvqABJPZFCpG6I0z7pomi2Jf+
n03L41ZE4wBXB2xjDT73ed9IYMtLkif5AffWzEWzT5+EatbfPOXROsMT02vaK2g3
BEis3fYfiQWm6Nhu76eV2nzDD8g45sn8lil7qrdgjVXUpRUHQrx35i7vvBPeaH3a
uqhcsYyAcSmGhJh8Jo4kRCivF7FUJQ==
=NQ+c
-----END PGP SIGNATURE-----

--JEuZoX91LkbmZWfOMGkq3wlLmALoRyVgr--

