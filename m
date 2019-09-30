Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53070C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A92216F4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A92216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvLM-0004Cs-8j
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iEvIp-00039A-4p
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iEvIn-0000Yg-Ak
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37864)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iEvIV-0000MB-Ts; Mon, 30 Sep 2019 09:01:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFB473D965;
 Mon, 30 Sep 2019 13:01:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-240.brq.redhat.com
 [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68E9A60A9F;
 Mon, 30 Sep 2019 13:01:01 +0000 (UTC)
Subject: Re: [PATCH 07/18] iotests: Replace IMGOPTS= by -o
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-8-mreitz@redhat.com>
 <e31504bf97e8944b9317546ebad75a669c6a2b90.camel@redhat.com>
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
Message-ID: <bc672333-6b9c-dd36-1e87-14792f63bcde@redhat.com>
Date: Mon, 30 Sep 2019 15:00:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e31504bf97e8944b9317546ebad75a669c6a2b90.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Uu6yXI9UYlC8gMCzrA2nLnrkc1VCZC11L"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 30 Sep 2019 13:01:02 +0000 (UTC)
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
--Uu6yXI9UYlC8gMCzrA2nLnrkc1VCZC11L
Content-Type: multipart/mixed; boundary="e6Ws5KxYCp5kdaAg6WI1JmdSX37wkQA3Z"

--e6Ws5KxYCp5kdaAg6WI1JmdSX37wkQA3Z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.09.19 18:33, Maxim Levitsky wrote:
> On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
>> Tests should not overwrite all user-supplied image options, but only a=
dd
>> to it (which will effectively overwrite conflicting values).  Accompli=
sh
>> this by passing options to _make_test_img via -o instead of $IMGOPTS.
>>
>> For some tests, there is no functional change because they already onl=
y
>> appended options to IMGOPTS.  For these, this patch is just a
>> simplification.
>>
>> For others, this is a change, so they now heed user-specified $IMGOPTS=
=2E
>> Some of those tests do not work with all image options, though, so we
>> need to disable them accordingly.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/031 |  9 ++++---
>>  tests/qemu-iotests/039 | 24 ++++++------------
>>  tests/qemu-iotests/059 | 18 ++++++-------
>>  tests/qemu-iotests/060 |  6 ++---
>>  tests/qemu-iotests/061 | 57 ++++++++++++++++++++++-------------------=
-
>>  tests/qemu-iotests/079 |  3 +--
>>  tests/qemu-iotests/106 |  2 +-
>>  tests/qemu-iotests/108 |  2 +-
>>  tests/qemu-iotests/112 | 32 ++++++++++++------------
>>  tests/qemu-iotests/115 |  3 +--
>>  tests/qemu-iotests/121 |  6 ++---
>>  tests/qemu-iotests/125 |  2 +-
>>  tests/qemu-iotests/137 |  2 +-
>>  tests/qemu-iotests/138 |  3 +--
>>  tests/qemu-iotests/175 |  2 +-
>>  tests/qemu-iotests/190 |  2 +-
>>  tests/qemu-iotests/191 |  3 +--
>>  tests/qemu-iotests/220 |  4 ++-
>>  tests/qemu-iotests/243 |  6 +++--
>>  tests/qemu-iotests/244 | 10 +++++---
>>  tests/qemu-iotests/250 |  3 +--
>>  tests/qemu-iotests/265 |  2 +-
>>  22 files changed, 100 insertions(+), 101 deletions(-)

[...]

>> diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
>> index 325da63a4c..99563bf126 100755
>> --- a/tests/qemu-iotests/039
>> +++ b/tests/qemu-iotests/039
>> @@ -50,8 +50,7 @@ size=3D128M
>>  echo
>>  echo "=3D=3D Checking that image is clean on shutdown =3D=3D"
>> =20
>> -IMGOPTS=3D"compat=3D1.1,lazy_refcounts=3Don"
>> -_make_test_img $size
>> +_make_test_img -o "compat=3D1.1,lazy_refcounts=3Don" $size
> Any reason for compat=3D1.1 here? Other that it was before like that.

Lazy refcounts only work with qcow2 v3 (compat=3D1.1).

Max


--e6Ws5KxYCp5kdaAg6WI1JmdSX37wkQA3Z--

--Uu6yXI9UYlC8gMCzrA2nLnrkc1VCZC11L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2R/IsACgkQ9AfbAGHV
z0Ar4QgAmbXiRhz1LPruq3nOjH/hA6lzXzU3s53YVw3c/J/e/NwEY1OrcZ7Rf0fT
rl4XJECXTkoujkDcP5hteSrepH713Gkk8bUZkQdCrJKH5Ln5xVRZBG4HjFPpXxbD
lSAqTSoXsIhncGokujwNEbkemkDXQVfZKq5gr/lM2M57VyUHjjSYEhjF0bUwTSVh
53QFpZHOmd+SRKseNIcl+Z1x1C7VjMwyUPQBroEUyaKRd+rVszbrLmmZXkXzIPd+
ST9O1uFq+sjx1LyZAIwL7IJL9oykZ1MGhF4Svcbhweul2bu6I+JcQfEevUAlAEe9
whTSrZru6HILnyvH/sojC7zRhEKeig==
=9BwN
-----END PGP SIGNATURE-----

--Uu6yXI9UYlC8gMCzrA2nLnrkc1VCZC11L--

