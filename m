Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125CDC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D854820679
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D854820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iExAB-0002J9-AW
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iEx90-0001Nt-E0
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iEx8z-0008Ga-Cu
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:59:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iEx8w-0008Et-42; Mon, 30 Sep 2019 10:59:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F004C8AC6FD;
 Mon, 30 Sep 2019 14:59:16 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-240.brq.redhat.com
 [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AACDE5D712;
 Mon, 30 Sep 2019 14:59:15 +0000 (UTC)
Subject: Re: [PATCH 02/18] iotests: Replace IMGOPTS by _unsupported_imgopts
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-3-mreitz@redhat.com>
 <456ed2bf18ee3033aa2115cc3b31bde1e0833348.camel@redhat.com>
 <54c5cff5-b9c9-4274-3ff7-77bfc586ed18@redhat.com>
 <0036fc62910635b0fec0e5ac5e78a19360c08e34.camel@redhat.com>
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
Message-ID: <a04c390e-d017-b7a3-521b-c117ce87f1f5@redhat.com>
Date: Mon, 30 Sep 2019 16:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <0036fc62910635b0fec0e5ac5e78a19360c08e34.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m9i1ehHX9J91n517gB0G8rWgKSaCDWaOe"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Mon, 30 Sep 2019 14:59:17 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m9i1ehHX9J91n517gB0G8rWgKSaCDWaOe
Content-Type: multipart/mixed; boundary="fsJqdUWBSucyJXTvzXtSipWYP8xRVu9HW"

--fsJqdUWBSucyJXTvzXtSipWYP8xRVu9HW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.09.19 16:47, Maxim Levitsky wrote:
> On Mon, 2019-09-30 at 14:59 +0200, Max Reitz wrote:
>> On 29.09.19 18:31, Maxim Levitsky wrote:
>>> On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
>>>> Some tests require compat=3D1.1 and thus set IMGOPTS=3D'compat=3D1.1=
'
>>>> globally.  That is not how it should be done; instead, they should
>>>> simply set _unsupported_imgopts to compat=3D0.10 (compat=3D1.1 is th=
e
>>>> default anyway).
>>>>
>>>> This makes the tests heed user-specified $IMGOPTS.  Some do not work=

>>>> with all image options, though, so we need to disable them according=
ly.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/036 | 3 +--
>>>>  tests/qemu-iotests/060 | 4 ++--
>>>>  tests/qemu-iotests/062 | 3 ++-
>>>>  tests/qemu-iotests/066 | 3 ++-
>>>>  tests/qemu-iotests/068 | 3 ++-
>>>>  tests/qemu-iotests/098 | 3 +--
>>>>  6 files changed, 10 insertions(+), 9 deletions(-)

[...]

>>
>>>> +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
>>>> =20
>>>> -IMGOPTS=3D"compat=3D1.1"
>>>>  IMG_SIZE=3D128K
>>>> =20
>>>>  case "$QEMU_DEFAULT_MACHINE" in
>>>> diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
>>>> index 1c1d1c468f..2d68dc7d6c 100755
>>>> --- a/tests/qemu-iotests/098
>>>> +++ b/tests/qemu-iotests/098
>>>> @@ -40,8 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>>> =20
>>>>  _supported_fmt qcow2
>>>>  _supported_proto file
>>>> -
>>>> -IMGOPTS=3D"compat=3D1.1"
>>>> +_unsupported_imgopts 'compat=3D0.10'
>>>
>>> Any idea why? I am not familiar with qcow2 well enought to
>>> know but this misses a comment with justification.
>>
>> Because the special bdrv_make_empty() version we want to test only wor=
ks
>> with qcow2 v3 images.
> Just to understand this, we have
>=20
> compat=3D0.10, also known as v2, which is the classical qcow2 (and v1 i=
s basically qcow)
> and then we have compat=3D1.1 which is also known as v3, and once upon =
a time was supposed
> to be called qcow3, but at the end remained qcow2.

Yep, that=E2=80=99s correct.  If you want to, you can still call it qcow3=
=2E  I
wanted to do that at some point, but it turned out that nobody else does =
it.

Max


--fsJqdUWBSucyJXTvzXtSipWYP8xRVu9HW--

--m9i1ehHX9J91n517gB0G8rWgKSaCDWaOe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2SGEEACgkQ9AfbAGHV
z0C57Af+M1/XCOrIhjjN8MXE09Xpkwu0/3QA0E1NTRbl/YpGWliWccSq+0dzgDfN
EFyTQx5wDg4wHr3Bl5ki4dDdrwk9i/H4ZlLGvM5XJeJRYUh62fVwVnns8kYvgT7S
Jh8lh9Cp1bB5wz4W8DmhlhCPF1fmEkN/WBs1RAwyCIsaI7/0svzmTH5KfD/HLVio
CITMqsJgB5SQyIK4E9QQrzDdxjMjOCHZBk7SgHwpv2ZHqegPqqgeMitEWgG1vrFO
7gfTWxE7GsWeKxQsVCAwtuh/q7C2tNBE8AZdXIeg86yVhW35IkB7Eh2Z1jWbs2P0
FOX8a/CjDXohFNCvZzhT2tX3j0TtOg==
=eusl
-----END PGP SIGNATURE-----

--m9i1ehHX9J91n517gB0G8rWgKSaCDWaOe--

