Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47701CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A84421897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A84421897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTkw-0001sC-6I
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iLTjj-0000zB-MG
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iLTji-0006K1-Fu
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:00:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iLTjf-0006IV-ML; Fri, 18 Oct 2019 11:00:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43ED010CC219;
 Fri, 18 Oct 2019 15:00:10 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C6501018A34;
 Fri, 18 Oct 2019 15:00:04 +0000 (UTC)
Subject: Re: [PATCH] iotests: Skip read-only cases in 118 when run as root
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20191018115127.2671-1-kwolf@redhat.com>
 <a810971a-639e-e7dc-d5e6-6b0bb524079b@redhat.com>
 <20191018142720.GH6122@localhost.localdomain>
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
Message-ID: <69055f0f-70a3-2a94-01f8-82fe3e8bca7b@redhat.com>
Date: Fri, 18 Oct 2019 17:00:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191018142720.GH6122@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MzBhu0IaS63PrJF8JA737cTMHmesyKqf3"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 18 Oct 2019 15:00:10 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MzBhu0IaS63PrJF8JA737cTMHmesyKqf3
Content-Type: multipart/mixed; boundary="XW0jTr12a6QpuiabGwXss89SXT13Mrf0b"

--XW0jTr12a6QpuiabGwXss89SXT13Mrf0b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.10.19 16:27, Kevin Wolf wrote:
> Am 18.10.2019 um 14:59 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>> Hi Kevin,
>>
>> On 10/18/19 1:51 PM, Kevin Wolf wrote:
>>> Some tests in 118 use chmod to remove write permissions from the file=

>>> and assume that the image can indeed not be opened read-write
>>> afterwards. This doesn't work when the test is run as root, because r=
oot
>>> can still open the file as writable even when the permission bit isn'=
t
>>> set.
>>>
>>> Introduce a @skip_if_root decorator and use it in 118 to skip the tes=
ts
>>> in question when the script is run as root.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>   tests/qemu-iotests/118        |  3 +++
>>>   tests/qemu-iotests/iotests.py | 10 ++++++++++
>>>   2 files changed, 13 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
>>> index ea0b326ae0..9eff46d189 100755
>>> --- a/tests/qemu-iotests/118
>>> +++ b/tests/qemu-iotests/118
>>> @@ -446,6 +446,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>>>           self.assert_qmp(result, 'return[0]/inserted/ro', True)
>>>           self.assert_qmp(result, 'return[0]/inserted/image/filename'=
, new_img)
>>> +    @iotests.skip_if_root
>>
>> Why not have case_notrun() return 'reason' and use:
>>
>> @unittest.skipIf(os.getuid() =3D=3D 0, case_notrun("cannot be run as r=
oot"))
>=20
> Because we can't skip test cases using unittest functionality, it
> results in different output (the test is marked as 's' instead of '.'
> and a message '(skipped=3Dn)' is added), which means failure for
> qemu-iotests.

Not arguing that we should use unittest skipping here, but my =E2=80=9CSe=
lfish
patches=E2=80=9D series allows it:

https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg03423.html

The advantage is that using unittest skipping works in setUp, too.

Max


--XW0jTr12a6QpuiabGwXss89SXT13Mrf0b--

--MzBhu0IaS63PrJF8JA737cTMHmesyKqf3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2p03IACgkQ9AfbAGHV
z0BUVwf/TluHyOArYw6BkYjLLfpnkI22otm1IXPnfz+Yb3XWhj2OgzzeLYl5//O+
AtvzqkhEFUMoYXpOqXKpaFn7v0qwicKS0m5vB+UmEK1SnNfI3055Oc7qjKVzYVdH
P2NSfEa8pbZFEoakDGJKrASuyXBKQ7HI64s348VSPT3FVj26dW8PZ0sIjPkLIXqv
0YjwEf1Sn7S6m3+nMJqI83GmCGgIvsIgd5iecnFkuyULG/pk7JXnhZcHTKb3ePu9
GjgkWLunaeVPsR1Du4JpK1xhNaRo8E3W/yE7MSsScl2GUK2/Ym6BpPg3ZFZRvlom
58p+H5Z5RjXUV5EbmTXjDDrHxJjgXA==
=m9B4
-----END PGP SIGNATURE-----

--MzBhu0IaS63PrJF8JA737cTMHmesyKqf3--

