Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FFDC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C043C20659
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C043C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJR4-0000ej-Vx
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 05:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnJQu-0000CW-7l
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnJQs-0008Im-QD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:07:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnJQq-0008Gm-80; Tue, 16 Jul 2019 05:07:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B74C23081244;
 Tue, 16 Jul 2019 09:07:30 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73B32600C1;
 Tue, 16 Jul 2019 09:07:28 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <20190715145438.6880-1-thuth@redhat.com>
 <20190715145438.6880-2-thuth@redhat.com>
 <db02273f-24ea-5c90-a206-b8203db2c819@redhat.com>
 <d8430e47-3fe6-d3f4-bdbd-529b9cf31ae5@redhat.com>
 <d62de778-5e2a-c7c2-7dc7-4cb2f78b8552@redhat.com>
 <a8e79f08-22ee-6adc-7de0-4f870d91eb12@redhat.com>
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
Message-ID: <d5f6493c-8d35-ab1a-ee9c-e3bc6226ac7d@redhat.com>
Date: Tue, 16 Jul 2019 11:07:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <a8e79f08-22ee-6adc-7de0-4f870d91eb12@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Y2bFyYrYbT530atlXuAvmZsw3aDzPdNWR"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 16 Jul 2019 09:07:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/qemu-iotests/group: Remove some
 more tests from the "auto" group
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y2bFyYrYbT530atlXuAvmZsw3aDzPdNWR
Content-Type: multipart/mixed; boundary="vQHRObmtHgHr6SDY4VWnneVtbdvc5fhTP";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-block@nongnu.org
Message-ID: <d5f6493c-8d35-ab1a-ee9c-e3bc6226ac7d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/qemu-iotests/group: Remove some
 more tests from the "auto" group
References: <20190715145438.6880-1-thuth@redhat.com>
 <20190715145438.6880-2-thuth@redhat.com>
 <db02273f-24ea-5c90-a206-b8203db2c819@redhat.com>
 <d8430e47-3fe6-d3f4-bdbd-529b9cf31ae5@redhat.com>
 <d62de778-5e2a-c7c2-7dc7-4cb2f78b8552@redhat.com>
 <a8e79f08-22ee-6adc-7de0-4f870d91eb12@redhat.com>
In-Reply-To: <a8e79f08-22ee-6adc-7de0-4f870d91eb12@redhat.com>

--vQHRObmtHgHr6SDY4VWnneVtbdvc5fhTP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 11:03, Thomas Huth wrote:
> On 15/07/2019 19.17, Max Reitz wrote:
>> On 15.07.19 17:18, Thomas Huth wrote:
>>> On 15/07/2019 17.12, Eric Blake wrote:
>>>> On 7/15/19 9:54 AM, Thomas Huth wrote:
>>>>> Remove some more tests from the "auto" group that either have issue=
s
>>>>> in certain environments (like macOS or FreeBSD, or on certain file =
systems
>>>>> like ZFS or tmpfs), do not work with the qcow2 format, or that are =
simply
>>>>> taking too much time.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  tests/qemu-iotests/group | 109 ++++++++++++++++++++---------------=
----
>>>>>  1 file changed, 55 insertions(+), 54 deletions(-)
>>>>
>>>>>  251 rw auto quick
>>>>>  252 rw auto backing quick
>>>>> -253 rw auto quick
>>>>> -254 rw auto backing quick
>>>>> -255 rw auto quick
>>>>> -256 rw auto quick
>>>>> +253 rw o_direct quick
>>>>
>>>> Where is the new 'o_direct' group documented?  Is this a typo for
>>>> something else?
>>>
>>> I needed a new group for test 142 since it would be without any group=
 at
>>> all otherwise:
>>>
>>> -142 auto
>>> +142 o_direct
>>>
>>> Tests without a group are currently only possible if the line ends wi=
th
>>> a space - which is quite error prone.
>>
>> Why not just fix that, then?
>=20
> That's of course the even better solution :-)
>=20
>>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>>> index f925606cc5..c24874ff4a 100755
>>> --- a/tests/qemu-iotests/check
>>> +++ b/tests/qemu-iotests/check
>>> @@ -488,7 +488,7 @@ testlist options
>>>  BEGIN        { for (t=3D'$start'; t<=3D'$end'; t++) printf "%03d\n",=
t }' \
>>>          | while read id
>>>          do
>>> -            if grep -s "^$id " "$source_iotests/group" >/dev/null
>>> +            if grep -s "^$id\( \|\$\)" "$source_iotests/group" >/dev=
/null
>>>              then
>>>                  # in group file ... OK
>>>                  echo $id >>$tmp.list
>>> @@ -547,7 +547,7 @@ else
>>>          touch $tmp.list
>>>      else
>>>          # no test numbers, do everything from group file
>>> -        sed -n -e '/^[0-9][0-9][0-9]*/s/[         ].*//p' <"$source_=
iotests/group" >$tmp.list
>=20
> That old "[       ]" looks quite strange anyway! I guess there was a TA=
B
> in here originally which got replaced by spaces at one point in time?

That=E2=80=99s what I think, too.

>>> +        sed -n -e '/^[0-9][0-9][0-9]*/s/^\([0-9]*\).*/\1/p' <"$sourc=
e_iotests/group" >$tmp.list
>>>      fi
>>>  fi
>>> =20
>>
>> looks to be enough for me.
>=20
> Seems to work, thanks! I'll respin my series with your patch included.

Great :-)

Max


--vQHRObmtHgHr6SDY4VWnneVtbdvc5fhTP--

--Y2bFyYrYbT530atlXuAvmZsw3aDzPdNWR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0tk8wACgkQ9AfbAGHV
z0BUpAf8DnRv2p+nOzUXwNnc4zv/BzmCKyddqcAaJVkzTwKCGm5aTlsdZEyOjKCi
KZYPCWcn1L/oMyP1Ip4k075qI67jLLG18yHUwQutOvlknwoGOwMKFugzFKoGfDtw
g7WyHG11H61AsQ+80qlWMOwysyGAYfVcBLrcNU2je9iTWP/JVPnwKavH4SI7imoR
+20Aak7wUbVebVT5gAUujW1WiH3cVNnLOM1+3UFA+axeILEh1cjtcwfzL7lg4iQY
d1wOkYTWGhi3JR5ggANLgfqoyzxafjo4B1xUFhd455+ZCajBoajic9HWkKqgQL9D
AabMylAaPkLTKgmMCvGavzQYqyagrA==
=3W9f
-----END PGP SIGNATURE-----

--Y2bFyYrYbT530atlXuAvmZsw3aDzPdNWR--

