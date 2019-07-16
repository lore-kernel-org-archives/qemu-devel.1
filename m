Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1EDC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715DA20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715DA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnPkV-0000Zx-AV
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40198)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hnPkI-00006V-4I
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hnPkG-00033F-W4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:52:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hnPkE-00032A-J5; Tue, 16 Jul 2019 11:51:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44C1837F46;
 Tue, 16 Jul 2019 15:51:57 +0000 (UTC)
Received: from thuth.remote.csb (reserved-198-198.str.redhat.com
 [10.33.198.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F260A5C221;
 Tue, 16 Jul 2019 15:51:53 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20190716122836.31187-1-thuth@redhat.com>
 <20190716122836.31187-5-thuth@redhat.com>
 <b9abc916-59b1-3edb-16c4-2b817393ae9d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
 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
Organization: Red Hat
Message-ID: <8b63564b-bfb4-38e9-8368-119a0a7a1c84@redhat.com>
Date: Tue, 16 Jul 2019 17:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b9abc916-59b1-3edb-16c4-2b817393ae9d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3Z7cjq1vxoD08ZgurwY5SqLh4qhvIThhD"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 16 Jul 2019 15:51:57 +0000 (UTC)
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
--3Z7cjq1vxoD08ZgurwY5SqLh4qhvIThhD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16/07/2019 17.41, Max Reitz wrote:
> On 16.07.19 14:28, Thomas Huth wrote:
>> Since most iotests are now run during "make check" already, we do not
>> need to test them explicitly from the gitlab-ci.yml script anymore.
>> And while we're at it, add some of the new non-auto tests >=3D 248 ins=
tead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  .gitlab-ci.yml | 12 +++---------
>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index c63bf2f822..fa5d094453 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -45,15 +45,9 @@ build-tcg-disabled:
>>   - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 0=
33 048
>>              052 063 077 086 101 104 106 113 147 148 150 151 152 157 1=
59 160
>>              163 170 171 183 184 192 194 197 205 208 215 221 222 226 2=
27 236
>> - - ./check -qcow2 001 002 003 004 005 007 008 009 010 011 012 013 017=
 018 019
>> -            020 021 022 024 025 027 028 029 031 032 033 034 035 036 0=
37 038
>> -            039 040 042 043 046 047 048 049 050 051 052 053 054 056 0=
57 058
>> -            060 061 062 063 065 066 067 068 069 071 072 073 074 079 0=
80 082
>> -            085 086 089 090 091 095 096 097 098 099 102 103 104 105 1=
07 108
>> -            110 111 114 117 120 122 124 126 127 129 130 132 133 134 1=
37 138
>> -            139 140 141 142 143 144 145 147 150 151 152 154 155 156 1=
57 158
>> -            161 165 170 172 174 176 177 179 184 186 187 190 192 194 1=
95 196
>> -            197 200 202 203 205 208 209 214 215 216 217 218 222 226 2=
27 229 234
>> + - ./check -qcow2 028 040 051 056 057 058 065 067 068 082 085 091 095=
 096 102
>> +            124 127 129 132 139 142 144 145 147 151 152 155 157 165 1=
94 196
>> +            200 202 203 205 208 209 216 218 222 227 234 248 250 254 2=
55 256
>=20
> This removes 197 and 215.  Why?

As mentioned in the cover letter, I've seen problems with 197 and 215 in
the gitlab CI pipelines (since the two tests apparently cause a lot of
memory pressure). At least they were causing trouble when "make check"
was running with other tests in parallel. Maybe they still work fine
when they run alone here. I'll give it another try...

 Thomas


--3Z7cjq1vxoD08ZgurwY5SqLh4qhvIThhD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJdLfKZAAoJEC7Z13T+cC21AawP/ieu2z5zIMce8hkuGO8ps2mh
SQLdkNkCLX4AQp1YR+3r3VbTjGUCabdY+iwoLg+zoSGOKuDziTsejw14W7NPSLXM
CDL2btvBeTPHWjBcH/fix6o7VuBfggcEmXEFbOqabWINccoHzptFi3Tzg3/1rGGZ
U7CaiivLiLVyWhLtXdJlOTFRNDgsGwXkxPdl0tgNeeSGMTxf+sLK1YsiRmrsrd3M
6zP57oIMkC39K/zcRp9gvVFOjYzA/sJ6aOLjd8yYI4Q/xCNpNrSWkzu/bKBeuJg5
VHK6KMM+alz/btCxXGWFM/L/2lB8gN9HBhusgkL2uf9n6Qgf/c0PXA6va0zF2+oV
GUveKUvZfYq8ZW1nf2S2SplawmcQTgDCBVKXCKwA1PetvMqW2w0d4um6m46xwvZr
QqW9YT/Ea4ahhYieIoxglAlhHKN+QfezNTgz11owkwivcS1lzJJxtBqdKZFsiz2d
v7HjNOYTxN2+dP7zYMKas/3P7Mxh/Q1M0BvzOWnh/YHRDiq0C7X3PSDX7v88oc69
ID7FEWCKI6hNPtKFX+YOr/LUJJHV6B4UzRazS6aNDirYWsOQZPTcbBd3/c7HkQRx
7AhxJ9c7xkXAuzrxy6d4u4+A4qEzPFxNg0TAntsocnC0lZtw+TecbEIWUzkqyARj
e/+KlHlovpbSFBBtaOln
=ScNk
-----END PGP SIGNATURE-----

--3Z7cjq1vxoD08ZgurwY5SqLh4qhvIThhD--

