Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B8FC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256C1205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256C1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYMN-0000E4-Ej
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxYLZ-0007l9-Fo
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxYLY-0006Tp-Fy
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:04:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxYLW-0006Rw-52; Tue, 13 Aug 2019 11:04:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A7C4300A242;
 Tue, 13 Aug 2019 15:04:21 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 091708D641;
 Tue, 13 Aug 2019 15:04:19 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
 <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
 <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
 <43fb7754-6f94-00f6-6172-70cbb53e787c@virtuozzo.com>
 <94ccf129-cc7e-2778-7688-fd718f8df249@virtuozzo.com>
 <20190813115115.GG4663@localhost.localdomain>
 <b0c32bfc-f4cf-0d46-beb8-ba4cf79b76c5@redhat.com>
 <48fa03d6-259d-9ded-dacb-a4975f8d24e4@virtuozzo.com>
 <fcad59bc-0190-004f-3aee-20dfb3fc3a89@redhat.com>
 <20190813150303.GK4663@localhost.localdomain>
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
Message-ID: <cb79d424-09c9-0add-71d0-075f46a00da3@redhat.com>
Date: Tue, 13 Aug 2019 17:04:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813150303.GK4663@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X6YRewNllq3g3hDyuJl6T9ou5StReP0HE"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 13 Aug 2019 15:04:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X6YRewNllq3g3hDyuJl6T9ou5StReP0HE
Content-Type: multipart/mixed; boundary="88SGst3zyB0DYtRgIzx92wxFrVopd0KvC";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <cb79d424-09c9-0add-71d0-075f46a00da3@redhat.com>
Subject: Re: [PATCH 0/2] deal with BDRV_BLOCK_RAW
References: <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
 <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
 <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
 <43fb7754-6f94-00f6-6172-70cbb53e787c@virtuozzo.com>
 <94ccf129-cc7e-2778-7688-fd718f8df249@virtuozzo.com>
 <20190813115115.GG4663@localhost.localdomain>
 <b0c32bfc-f4cf-0d46-beb8-ba4cf79b76c5@redhat.com>
 <48fa03d6-259d-9ded-dacb-a4975f8d24e4@virtuozzo.com>
 <fcad59bc-0190-004f-3aee-20dfb3fc3a89@redhat.com>
 <20190813150303.GK4663@localhost.localdomain>
In-Reply-To: <20190813150303.GK4663@localhost.localdomain>

--88SGst3zyB0DYtRgIzx92wxFrVopd0KvC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.19 17:03, Kevin Wolf wrote:
> Am 13.08.2019 um 16:53 hat Max Reitz geschrieben:
>> On 13.08.19 16:46, Vladimir Sementsov-Ogievskiy wrote:
>>> 13.08.2019 17:31, Max Reitz wrote:
>>>> On 13.08.19 13:51, Kevin Wolf wrote:
>>>>
>>>> [...]
>>>>
>>>>> Hm... This is a mess. :-)
>>>>
>>>> Just out of curiosity: Why?
>>>>
>>>> Aren=E2=80=99t there only two things we really need from the block_s=
tatus
>>>> infrastructure?
>>>>
>>>> (1) Whether something is allocated in the given layer of the backing=
 chain,
>>>>
>>>> (2) Whether we know that a given range reads as zeroes.
>>>>
>>>> Do we really need anything else?
>>>>
>>>
>>> qemu-img map?
>>
>> Which is a debugging tool.  So it doesn=E2=80=99t fall under =E2=80=9C=
really=E2=80=9D in my
>> book.  If removing everything but allocation+zero information would ma=
ke
>> the code a lot simpler, I think that would be worth it.
>>
>>> 1. We need to fix the bug somehow
>>> 2. We need to fix comment about different block-status flags, as it r=
eally
>>> lacks information of what actually "DATA" means (together with *file)=
=2E
>>> And what finally means "allocated", can you define it precisely?
>>
>> As I wrote in my other mails, I think the problem is that it=E2=80=99s=
 just
>> unexpected that block_status automatically skips through for filters.
>> It shouldn=E2=80=99t, that=E2=80=99s just black magic that the caller =
should not rely on.
>>
>> (We see precisely here that it=E2=80=99s wrong, because the callers ar=
e not
>> prepared for the allocation information returned to be associated with=
 a
>> different node than what they passed.)
>>
>> So my definition is just =E2=80=9CIf the node has a COW backing file a=
nd
>> block_status returns =E2=80=98not allocated=E2=80=99, the data will be=
 there.
>> Otherwise, the data is in the current node.=E2=80=9D  Yes, that means =
that
>> filters should appear as fully allocated.
>=20
> You can do that, but then the callers need to learn to do the recursion=

> instead. After all, just copying everything if a filter is in the
> subtree isn't the desired behaviour.

Yes, hence the =E2=80=9Cdeal with filters=E2=80=9D series.

Max


--88SGst3zyB0DYtRgIzx92wxFrVopd0KvC--

--X6YRewNllq3g3hDyuJl6T9ou5StReP0HE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1S0XIACgkQ9AfbAGHV
z0BdFggAxLh8edib3SUF5/bJfgxioUYqyos5HrOx8z38tVuRrpXRc+drSEiLD92/
Ys0ppBT1TiVyYZ3jIKtkRIE1Mb3fhzC+fNDvPZuPZCLrSejqxNnDLH5e2TKWm7Xw
Fvy+SUMCQHMjhcGAH3ViCLn10FSMOby7uM38UpSkfRG1EGLcVftkb4Rx+AolI+Gi
f0L1YY7GJAV49gyuftoapvdT8n4KSNfTLZKgrjzOOjSo6OvPoo141P0cX2cH/Xjm
BxdOGfv89mNRZ8AhD3t1m8oT7+h9LZl31repR+hvR7cxncDFe9wQ1ZMzsKd+B2gK
udvJw7MOkGn2jtjIIJKGNt9aEpXMcg==
=SM0j
-----END PGP SIGNATURE-----

--X6YRewNllq3g3hDyuJl6T9ou5StReP0HE--

