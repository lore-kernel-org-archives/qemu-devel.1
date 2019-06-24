Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB350C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 19:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB6420645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 19:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB6420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfUMT-0007Cn-0v
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 15:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42459)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfUJX-0005AI-Og
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfUJV-0002IC-Ld
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:07:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfUJD-0001Lc-Cu; Mon, 24 Jun 2019 15:07:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AEE7308FBAF;
 Mon, 24 Jun 2019 19:06:37 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-152.brq.redhat.com
 [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24B521001B00;
 Mon, 24 Jun 2019 19:06:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
References: <156140133234.24.13306518272551026541@c4a48874b076>
 <25efa330-c016-7b99-a49f-53e1e590395c@redhat.com>
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
Message-ID: <f3f2c7e1-a7b1-49fd-5425-c7cadde31e0c@redhat.com>
Date: Mon, 24 Jun 2019 21:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <25efa330-c016-7b99-a49f-53e1e590395c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QNr15qLUV9vNORxorrVBFw33zIcMOMK7v"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 24 Jun 2019 19:06:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 00/14] block: Try to create well-typed
 json:{} filenames
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
Cc: kwolf@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QNr15qLUV9vNORxorrVBFw33zIcMOMK7v
Content-Type: multipart/mixed; boundary="KFDWKcOvx01LZ1TH2ToTAugOaAGagu6vB";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mdroth@linux.vnet.ibm.com,
 armbru@redhat.com
Message-ID: <f3f2c7e1-a7b1-49fd-5425-c7cadde31e0c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/14] block: Try to create well-typed
 json:{} filenames
References: <156140133234.24.13306518272551026541@c4a48874b076>
 <25efa330-c016-7b99-a49f-53e1e590395c@redhat.com>
In-Reply-To: <25efa330-c016-7b99-a49f-53e1e590395c@redhat.com>

--KFDWKcOvx01LZ1TH2ToTAugOaAGagu6vB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.06.19 21:04, Max Reitz wrote:
> On 24.06.19 20:35, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20190624173935.25747-1-mreitz@re=
dhat.com/
>>
>>
>>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below=
 for
>> more information:
>>
>> Message-id: 20190624173935.25747-1-mreitz@redhat.com
>> Type: series
>> Subject: [Qemu-devel] [PATCH v4 00/14] block: Try to create well-typed=
 json:{} filenames
>>
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> git rev-parse base > /dev/null || exit 0
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>> git config --local diff.algorithm histogram
>> ./scripts/checkpatch.pl --mailback base..
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>
>> Switched to a new branch 'test'
>> ddd669a block: Make use of QAPI defaults
>> 3bcf922 iotests: qcow2's encrypt.format is now optional
>> 155c1db iotests: Test internal option typing
>> 364eac1 block: Try to create well typed json:{} filenames
>> 11726d2 qapi: Formalize qcow encryption probing
>> 567644f qapi: Formalize qcow2 encryption probing
>> 4eb3ca4 tests: Add QAPI optional discriminator tests
>> f3d9f53 tests: Test QAPI default values for struct members
>> 2862824 test-qapi: Print struct members' default values
>> ff7a7c5 qapi: Document default values for struct members
>> faef37f qapi: Allow optional discriminators
>> 64ae73c qapi: Introduce default values for struct members
>> f485950 qapi: Move to_c_string() to common.py
>> 8711bb4 qapi: Parse numeric values
>>
>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>> 1/14 Checking commit 8711bb4c30f3 (qapi: Parse numeric values)
>> 2/14 Checking commit f485950c4595 (qapi: Move to_c_string() to common.=
py)
>> 3/14 Checking commit 64ae73cfedd6 (qapi: Introduce default values for =
struct members)
>> 4/14 Checking commit faef37f6cd45 (qapi: Allow optional discriminators=
)
>> 5/14 Checking commit ff7a7c5b6024 (qapi: Document default values for s=
truct members)
>> 6/14 Checking commit 28628249dcf1 (test-qapi: Print struct members' de=
fault values)
>> 7/14 Checking commit f3d9f5343a99 (tests: Test QAPI default values for=
 struct members)
>> ERROR: Invalid UTF-8, patch and commit message should be encoded in UT=
F-8
>> #106: FILE: tests/qapi-schema/qapi-schema-test.out:420:
>> +    member str: str optional=3DTrue default=3Dfoo \=E9=B9=BF""'
>>                                                     ^
>=20
> Already noted in patch 7.

Oops.  Didn=E2=80=99t note it in patch 7 because I reformatted the patche=
s
afterwards and thus deleted my note. m(

Yes, it=E2=80=99s a test output and I=E2=80=99d like to test weird contro=
l characters,
mostly that the generated C code doesn=E2=80=99t break.  Any ideas how to=
 fix
this?  I could just use \t instead of \b\x7f, but that would be boring.

Max


--KFDWKcOvx01LZ1TH2ToTAugOaAGagu6vB--

--QNr15qLUV9vNORxorrVBFw33zIcMOMK7v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0RHzoACgkQ9AfbAGHV
z0CJ7wf/dWIw7mX0Kx9eXUz68o/d8x+ZSh9WZQpPvfO6WUSJufAWQx2BWfe2cbNI
inFxoHuACWwfTQetcK1AB/dpdBlzw/24HGoBEL8ZzUfdJGCcDm8j7582oy5e1ZFi
4sTm7LiDwTGPpsT8B7PsRRIctTEhzkKdGmZ94POr2GA/CjcJsbzbA0T6OhMVZFPA
QKNgWoGH7ACJXjzZwTcH5LxvIio291aRn92llFw7JZbH9xvPkHxO+t98Wnx4Nkm1
Yp9pPVg3G0A6iZuJnMR3Me3+JWbE9uqkQ2/SRbCmyg2q8RxMJlyC88IlefuoM5An
S+XrjC2O6tOyhmCJjxpcGa3lPbMb1Q==
=kfFh
-----END PGP SIGNATURE-----

--QNr15qLUV9vNORxorrVBFw33zIcMOMK7v--

