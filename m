Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C2C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8303420880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8303420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnPpg-0005NG-Pr
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnPpW-0004yU-2i
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnPpS-0005jY-LA
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:57:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnPpG-0005f0-8d; Tue, 16 Jul 2019 11:57:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19E7330BA077;
 Tue, 16 Jul 2019 15:57:07 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8915600C4;
 Tue, 16 Jul 2019 15:57:05 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190716122836.31187-1-thuth@redhat.com>
 <20190716122836.31187-5-thuth@redhat.com>
 <b9abc916-59b1-3edb-16c4-2b817393ae9d@redhat.com>
 <8b63564b-bfb4-38e9-8368-119a0a7a1c84@redhat.com>
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
Message-ID: <621a49be-7374-8e2f-03a2-4f07c4c5429e@redhat.com>
Date: Tue, 16 Jul 2019 17:57:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8b63564b-bfb4-38e9-8368-119a0a7a1c84@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AlwTuge3xVuF3RVaPgEv9XCctNCdwTT6q"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 16 Jul 2019 15:57:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/4] gitlab-ci: Remove qcow2 tests that
 are handled by "make check" already
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
--AlwTuge3xVuF3RVaPgEv9XCctNCdwTT6q
Content-Type: multipart/mixed; boundary="ogg8SrYHYHetG29CaKmZoXYnPo8kKFBDx";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <621a49be-7374-8e2f-03a2-4f07c4c5429e@redhat.com>
Subject: Re: [PATCH v2 4/4] gitlab-ci: Remove qcow2 tests that are handled by
 "make check" already
References: <20190716122836.31187-1-thuth@redhat.com>
 <20190716122836.31187-5-thuth@redhat.com>
 <b9abc916-59b1-3edb-16c4-2b817393ae9d@redhat.com>
 <8b63564b-bfb4-38e9-8368-119a0a7a1c84@redhat.com>
In-Reply-To: <8b63564b-bfb4-38e9-8368-119a0a7a1c84@redhat.com>

--ogg8SrYHYHetG29CaKmZoXYnPo8kKFBDx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 17:51, Thomas Huth wrote:
> On 16/07/2019 17.41, Max Reitz wrote:
>> On 16.07.19 14:28, Thomas Huth wrote:
>>> Since most iotests are now run during "make check" already, we do not=

>>> need to test them explicitly from the gitlab-ci.yml script anymore.
>>> And while we're at it, add some of the new non-auto tests >=3D 248 in=
stead.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  .gitlab-ci.yml | 12 +++---------
>>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index c63bf2f822..fa5d094453 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -45,15 +45,9 @@ build-tcg-disabled:
>>>   - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 =
033 048
>>>              052 063 077 086 101 104 106 113 147 148 150 151 152 157 =
159 160
>>>              163 170 171 183 184 192 194 197 205 208 215 221 222 226 =
227 236
>>> - - ./check -qcow2 001 002 003 004 005 007 008 009 010 011 012 013 01=
7 018 019
>>> -            020 021 022 024 025 027 028 029 031 032 033 034 035 036 =
037 038
>>> -            039 040 042 043 046 047 048 049 050 051 052 053 054 056 =
057 058
>>> -            060 061 062 063 065 066 067 068 069 071 072 073 074 079 =
080 082
>>> -            085 086 089 090 091 095 096 097 098 099 102 103 104 105 =
107 108
>>> -            110 111 114 117 120 122 124 126 127 129 130 132 133 134 =
137 138
>>> -            139 140 141 142 143 144 145 147 150 151 152 154 155 156 =
157 158
>>> -            161 165 170 172 174 176 177 179 184 186 187 190 192 194 =
195 196
>>> -            197 200 202 203 205 208 209 214 215 216 217 218 222 226 =
227 229 234
>>> + - ./check -qcow2 028 040 051 056 057 058 065 067 068 082 085 091 09=
5 096 102
>>> +            124 127 129 132 139 142 144 145 147 151 152 155 157 165 =
194 196
>>> +            200 202 203 205 208 209 216 218 222 227 234 248 250 254 =
255 256
>>
>> This removes 197 and 215.  Why?
>=20
> As mentioned in the cover letter, I've seen problems with 197 and 215 i=
n
> the gitlab CI pipelines (since the two tests apparently cause a lot of
> memory pressure). At least they were causing trouble when "make check"
> was running with other tests in parallel. Maybe they still work fine
> when they run alone here. I'll give it another try...

OK.  Shouldn=E2=80=99t this be mentioned in the commit message here, too?=
 ;-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ogg8SrYHYHetG29CaKmZoXYnPo8kKFBDx--

--AlwTuge3xVuF3RVaPgEv9XCctNCdwTT6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0t89AACgkQ9AfbAGHV
z0DlYgf+P2rDrg4KihcbO60yXHb8D+QYP1eNe5RByEG+6ntObgfwu7HE/eJ6XrmZ
1jH4dSmg28AQc4RKaA4IiejpxG/PP3jJHDxAyQGl8vEiK+VSbfnDQa+pWsf+o/Re
uyZNqvwAvexBOsU0glmQSo+IoEuv9kcf8oclNsX3lUkwoSAaRNjMzPESX92oJwzH
OskKwgl13W3Sa68nmKn+/hdhzo8rndEdgIwM3hrKa7XTFIJJ8uMU4XF54Cj06kB6
6An6VEnpjEnqJEGccsnS9darhSpTYgLDIh8tijrjf00GpAUW/v728xJhkKGWu3r3
dIhljn5Ij03dPSCfSLBec7/JXiqoWA==
=voAZ
-----END PGP SIGNATURE-----

--AlwTuge3xVuF3RVaPgEv9XCctNCdwTT6q--

