Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C843C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515A42086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515A42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4bF-0001MK-KC
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 09:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53819)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw4Ou-00044R-Bo
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw4Ot-0004Bo-Ak
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:53:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw4Or-0004A7-2s; Fri, 09 Aug 2019 08:53:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62966308FFB1;
 Fri,  9 Aug 2019 12:53:40 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46F455D9D3;
 Fri,  9 Aug 2019 12:53:33 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-5-vsementsov@virtuozzo.com>
 <23fd227d-9074-3a9e-b6c7-09f4abadc021@redhat.com>
 <ba8ea007-06dd-03fb-9f9c-6e31a4764156@virtuozzo.com>
 <b3b788fc-cf2d-8fe4-df35-a3fd8f18995f@redhat.com>
 <7783cb6f-4e71-c789-3105-4a6dc3b1533d@virtuozzo.com>
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
Message-ID: <07f45d08-33dd-b49c-6a71-58fc84876697@redhat.com>
Date: Fri, 9 Aug 2019 14:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7783cb6f-4e71-c789-3105-4a6dc3b1533d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RDR7tmmdkpJoXjrrv67ZiGAbadZDnNvkn"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 09 Aug 2019 12:53:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/8] block/backup: improve unallocated
 clusters skipping
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
--RDR7tmmdkpJoXjrrv67ZiGAbadZDnNvkn
Content-Type: multipart/mixed; boundary="846srVejgHDJbo1MgXslFWaJt5okTOadu";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <07f45d08-33dd-b49c-6a71-58fc84876697@redhat.com>
Subject: Re: [PATCH 4/8] block/backup: improve unallocated clusters skipping
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-5-vsementsov@virtuozzo.com>
 <23fd227d-9074-3a9e-b6c7-09f4abadc021@redhat.com>
 <ba8ea007-06dd-03fb-9f9c-6e31a4764156@virtuozzo.com>
 <b3b788fc-cf2d-8fe4-df35-a3fd8f18995f@redhat.com>
 <7783cb6f-4e71-c789-3105-4a6dc3b1533d@virtuozzo.com>
In-Reply-To: <7783cb6f-4e71-c789-3105-4a6dc3b1533d@virtuozzo.com>

--846srVejgHDJbo1MgXslFWaJt5okTOadu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.08.19 14:47, Vladimir Sementsov-Ogievskiy wrote:
> 09.08.2019 15:25, Max Reitz wrote:
>> On 09.08.19 09:50, Vladimir Sementsov-Ogievskiy wrote:
>>> 07.08.2019 21:01, Max Reitz wrote:
>>>> On 07.08.19 10:07, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Limit block_status querying to request bounds on write notifier to
>>>>> avoid extra seeking.
>>>>
>>>> I don=E2=80=99t understand this reasoning.  Checking whether somethi=
ng is
>>>> allocated for qcow2 should just mean an L2 cache lookup.  Which we h=
ave
>>>> to do anyway when we try to copy data off the source.
>>>
>>> But for raw it's seeking.
>>
>> (1) That=E2=80=99s a bug in block_status then, isn=E2=80=99t it?
>>
>> file-posix cannot determine the allocation status, or rather, everythi=
ng
>> is allocated.  bdrv_co_block_status() should probably pass @want_zero =
on
>> to the driver=E2=80=99s implementation, and file-posix should just
>> unconditionally return DATA if it=E2=80=99s false.
>>
>> (2) Why would you even use sync=3Dtop for raw nodes?
>>
>=20
> As I described in parallel letters, raw was bad example. NBD is good.

Does NBD support backing files?

> Anyway, now I'm refactoring cluster skipping more deeply for v2.
>=20
> About top-mode: finally block-status should be used to improve other
> modes too. In virtuozzo we skip unallocated for full mode too, for exam=
ple.

But this patch here is about sync=3Dtop.

Skipping is an optimization, the block_status querying here happens
because copying anything that isn=E2=80=99t allocated in the top layer wo=
uld be
wrong.

Max

> Unfortunately, backup is most long-term thing to upstream for me..


--846srVejgHDJbo1MgXslFWaJt5okTOadu--

--RDR7tmmdkpJoXjrrv67ZiGAbadZDnNvkn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1NbMsACgkQ9AfbAGHV
z0CyKwf9EwKWp0iQMIAC4lu0Bb6YkkUTZzCQ2cj4Zq7m07fel4CX+zOFmmqc7fPS
II2Qc8vMAtL/lWMWc53iVYscIi3txqtp0bEeRc9moXWevAC+phpqxMHdntlHQJnI
n/eXl2W2UWKmr1cwBWmt7ebywQMguvdrK3G5m2n5A4Y6AoUZFQ1zt8WkSxMalfCT
CrXZuOyPl0YgsvFVpdKz4o8Q5JOvYCHLX8P2g2J1J+73dZH1gZXe6aAPlBw4gok3
/XP/dWRLaJNMp55ykPLLlo9XAcpeTJpaCJx8dUJ/6RjIvBHho89KsIF/WrR6XXLe
RtAPdiqyY+wi243chB0Pg+TA3yigFQ==
=mYi8
-----END PGP SIGNATURE-----

--RDR7tmmdkpJoXjrrv67ZiGAbadZDnNvkn--

