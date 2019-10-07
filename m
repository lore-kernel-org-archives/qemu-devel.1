Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D47BECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471E82070B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471E82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHWJS-0001zd-Ge
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iHWIH-0001Id-Gb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iHWIF-0001fP-5A
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:55:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iHWIA-0001YT-SK; Mon, 07 Oct 2019 12:55:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A11E13086258;
 Mon,  7 Oct 2019 16:55:24 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB9D8600C1;
 Mon,  7 Oct 2019 16:55:20 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
 <20191002164438.GD5819@localhost.localdomain>
 <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
 <20191004101952.GC5491@linux.fritz.box>
 <d194e22c-7125-e558-0a80-131a28a87419@redhat.com>
 <e7d5cc8a-7a61-70a2-7efc-8f1af8e7a41f@redhat.com>
 <8a6b9c09-70f2-e2cc-4c65-33375396d319@redhat.com>
 <793fa056-2fc5-8d15-c563-046d3a336f2f@redhat.com>
 <c7b5052c-45d6-9d6e-9cc5-373c7522d6df@redhat.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <bc6318b6-30c2-0978-64e9-c8cccd0c65a7@redhat.com>
Date: Mon, 7 Oct 2019 18:55:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c7b5052c-45d6-9d6e-9cc5-373c7522d6df@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C9PYci96uB3tPQB4eMMprsz9NwLFwOId7"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 07 Oct 2019 16:55:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C9PYci96uB3tPQB4eMMprsz9NwLFwOId7
Content-Type: multipart/mixed; boundary="0LHBm8F7NVPDeeS97sTrticn8Yos97fNc"

--0LHBm8F7NVPDeeS97sTrticn8Yos97fNc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.10.19 18:28, Thomas Huth wrote:
> On 07/10/2019 15.11, Thomas Huth wrote:
>> On 07/10/2019 14.52, Max Reitz wrote:
>>> On 07.10.19 14:16, Thomas Huth wrote:
>>>> On 04/10/2019 14.44, Max Reitz wrote:
>>>>> On 04.10.19 12:19, Kevin Wolf wrote:
>>>>>> Am 02.10.2019 um 19:47 hat Max Reitz geschrieben:
>>>>>>> On 02.10.19 18:44, Kevin Wolf wrote:
>>>>>>>> Am 02.10.2019 um 13:57 hat Max Reitz geschrieben:
>>>>>>>>> It usually worked fine for me because it=E2=80=99s rather rare =
that non-block
>>>>>>>>> patches broke the iotests.
>>>>>>>>
>>>>>>>> I disagree. It happened all the time that someone else broke the=
 iotests
>>>>>>>> in master and we needed to fix it up.
>>>>>>>
>>>>>>> OK.
>>>>>>>
>>>>>>> (In my experience, it=E2=80=99s still mostly block patches, only =
that they tend
>>>>>>> to go through non-block trees.)
>>>>>>
>>>>>> Fair enough, it's usually code that touches block code. I assumed =
"block
>>>>>> patches" to mean patches that go through one of the block trees an=
d for
>>>>>> which iotests are run before sending a pull request.
>>>>>>
>>>>>> In the end, I don't care what code these patches touched. I do an
>>>>>> innocent git pull, and when I finally see that it's master that br=
eaks
>>>>>> iotests and not my patches on top of it, I'm annoyed.
>>>>>
>>>>> Hm.  Part of my point was that this still happens all the time.
>>>>>
>>>>> Which is why I=E2=80=99d prefer more tests to run in CI than a hand=
ful of not
>>>>> very useful ones in make check.
>>>>
>>>> Ok, so let's try to add some more useful test to the "auto" group. K=
evin
>>>> mentioned 030, 040 and 041, and I think it should be ok to enable th=
em
>>>> (IIRC the only issue was that they run a little bit longer, but if t=
hey
>>>> are very useful, we should include them anyway).
>>>
>>> I agree on those.  (Maybe not 040, but definitely 030 and 041.)
>>>
>>> Maybe one of the issues was the =E2=80=9Cpath too long=E2=80=9D thing=
 for Unix sockets?
>>
>> Ah, right. I've applied John's "remove 'linux' from default" patch and=

>> added the three iotests to the "auto" group, and indeed, they fail now=

>> on cirrus-ci due to the "path too long" socket problem. "We" (royal we=
,
>> I guess) should likely fix that first...

I=E2=80=99m looking into that, by the way.  I hope a SOCK_DIR that defaul=
ts to
$(mktemp -d) will suffice...

> FWIW, 041 also fails on macOS on Travis (which does not have the "path
> too long" issue):
>=20
>  https://travis-ci.com/huth/qemu/jobs/242942716#L8415
>=20
> ... so we might need to declare this as "linux only" again after John's=

> patch gets merged.

:/

Either that, or let make check skip the iotests generally on non-Linux
systems.

Max


--0LHBm8F7NVPDeeS97sTrticn8Yos97fNc--

--C9PYci96uB3tPQB4eMMprsz9NwLFwOId7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2bbfcACgkQ9AfbAGHV
z0Ahmwf9E/K7etJC0YnkJe/8mdlzK+50dAOCyXrLTjhqxO5e+IRBeGOJsQhzCREb
jKmjnvpzw18dChtj+tnuZEjHejwtvrc1q1L+M+T/m9Q2Qs/86oeUMne7D97hDKKF
2sNypLCH1vSyYlicwh4cb2+z1wEcLrV5RGWZcU0asquTDEbVWT3g9VM54VDcTNUk
+eRjZici+djZiqeg7AGmprltpY1NKYqzlF1F+Ps/fsFO6CDi3QshMShjpeK0DRjx
t4JKz7Gb+1bHYGncq3nlmFWkVto7UdrmOAi4sikxwKzG6A4WYHxlMM7BlNDiKawp
p09jhO0ezZQjXnIWtpQ/j2xwsbxJYQ==
=5gqv
-----END PGP SIGNATURE-----

--C9PYci96uB3tPQB4eMMprsz9NwLFwOId7--

