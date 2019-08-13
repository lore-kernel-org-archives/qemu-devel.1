Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5A9C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011B4205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011B4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYLq-00081O-1M
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45425)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxYLM-0007NR-6e
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxYLL-0006Ls-4L
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:04:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxYLA-0006Df-UM; Tue, 13 Aug 2019 11:04:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 33E1D3001834;
 Tue, 13 Aug 2019 15:04:00 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9831805D6;
 Tue, 13 Aug 2019 15:03:58 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
 <6af67f42-b5ee-1ca9-6fb1-500fd993616a@virtuozzo.com>
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
Message-ID: <d0b0fc4e-eb2f-796d-3413-366a6bb5aeca@redhat.com>
Date: Tue, 13 Aug 2019 17:03:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6af67f42-b5ee-1ca9-6fb1-500fd993616a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RKg1czQDNAEXwIsOOwsGnV4CacKEbkO1L"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 13 Aug 2019 15:04:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] block/raw-format: switch to
 BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RKg1czQDNAEXwIsOOwsGnV4CacKEbkO1L
Content-Type: multipart/mixed; boundary="PSuoERA0bApUk6Uj4kSJ3yBZJpTHZ3Xts";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <d0b0fc4e-eb2f-796d-3413-366a6bb5aeca@redhat.com>
Subject: Re: [PATCH 1/2] block/raw-format: switch to BDRV_BLOCK_DATA with
 BDRV_BLOCK_RECURSE
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
 <6af67f42-b5ee-1ca9-6fb1-500fd993616a@virtuozzo.com>
In-Reply-To: <6af67f42-b5ee-1ca9-6fb1-500fd993616a@virtuozzo.com>

--PSuoERA0bApUk6Uj4kSJ3yBZJpTHZ3Xts
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.19 16:56, Vladimir Sementsov-Ogievskiy wrote:
> 13.08.2019 17:43, Max Reitz wrote:
>> On 13.08.19 13:04, Kevin Wolf wrote:
>>> Am 12.08.2019 um 20:11 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> BDRV_BLOCK_RAW makes generic bdrv_co_block_status to fallthrough to
>>>> returned file. But is it correct behavior at all? If returned file
>>>> itself has a backing file, we may report as totally unallocated and
>>>> area which actually has data in bottom backing file.
>>>>
>>>> So, mirroring of qcow2 under raw-format is broken. Which is illustra=
ted
>>>> by following commit with a test. Let's make raw-format behave more
>>>> correctly returning BDRV_BLOCK_DATA.
>>>>
>>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>
>>> After some reading, I think I came to the conclusion that RAW is the
>>> correct thing to do. There is indeed a problem, but this patch is try=
ing
>>> to fix it in the wrong place.
>>>
>>> In the case where the backing file contains some data, and we have a
>>> 'raw' node above the qcow2 overlay node, the content of the respectiv=
e
>>> block is not defined by the queried backing file layer, so it is
>>> completely correct that bdrv_is_allocated() returns false,like it wou=
ld
>>> if you queried the qcow2 layer directly.
>>
>> I disagree.  The queried backing file layer is the raw node.  As I sai=
d,
>> in my opinion raw nodes are not filter nodes, neither in behavior (the=
y
>> have an offset option), nor in how they are generally used (as a forma=
t).
>>
>> The raw format does not support backing files.  Therefore, everything =
on
>> a raw node is allocated.
>>
>=20
> Could you tell me at least, what means "allocated" ?
>=20
> It's a term that describing a region somehow.. But how? Allocated where=
?
> In raw node, in its child or both? Am I right that if region allocated =
in
> one of non-cow children it is assumed to be allocated in parent too? Or=
 what?
>=20
> And it's unrelated to real disk allocation which (IMHO) directly shows =
that
> this a bad term.

It=E2=80=99s a term for COW backing chains.  If something is allocated on=
 a
given node in a COW backing chain, it means it is either present in
exactly that node or in one of its storage children (in case the node is
a format node).  If it is not allocated, it is not, and read accesses
will be forwarded to the COW backing child.

Max


--PSuoERA0bApUk6Uj4kSJ3yBZJpTHZ3Xts--

--RKg1czQDNAEXwIsOOwsGnV4CacKEbkO1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1S0V0ACgkQ9AfbAGHV
z0AtzAf7BfSi4G+UQ93acHuHg6MmZuijZiQr4IOHI6ok4Ww2sXb0t4BuUIcAbvi9
P/UutkediTSiLmXexXwMEZ3imtGYKxsWTsbFBaSpDIH3nyGitTZ5zd6bMoYJwbGR
EAfb+kASfxMfqktMrnebK6cY/xRg7zqSibou7cNSXAK7PLoBxHeLiPFtdYjbyvcC
jA6TzjSVaXWqgub6KmdMoJd98+rRE2Q8coNcGAcadMsJZ9pCr4KIvGZwlniT9CF5
rWJB2pML3Z+FK2653xJDzJGzE3YiRpK8IlJ5Vs3OHOk936RXrxUNKtkOj1bsM0Pe
iVIYQd5jTi4Wp1AJMnRLZDnoGwqZ9g==
=yIP+
-----END PGP SIGNATURE-----

--RKg1czQDNAEXwIsOOwsGnV4CacKEbkO1L--

