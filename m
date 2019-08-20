Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6766C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A948722DA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A948722DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i03BD-0006tC-MJ
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 08:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i03AR-0006M2-PY
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i03AQ-0004F8-KO
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:23:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i03AN-0004Ah-D9; Tue, 20 Aug 2019 08:23:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 753863001BF1;
 Tue, 20 Aug 2019 12:23:10 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 338F61B5C2;
 Tue, 20 Aug 2019 12:23:06 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-7-mreitz@redhat.com>
 <c0d92948-0d97-321d-ea26-17ce4d2da5d9@redhat.com>
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
Message-ID: <2f7dd6c5-477d-d833-869b-a6f94eb83a90@redhat.com>
Date: Tue, 20 Aug 2019 14:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c0d92948-0d97-321d-ea26-17ce4d2da5d9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8Lh5AI99b7XeE5keyXh8M6KEqRXgyy1NG"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 20 Aug 2019 12:23:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/8] iotests: Test driver whitelisting
 in 093
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Lh5AI99b7XeE5keyXh8M6KEqRXgyy1NG
Content-Type: multipart/mixed; boundary="ijV0h0mHKrGks4JzqTkaJYZsMYY9myIXq";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <2f7dd6c5-477d-d833-869b-a6f94eb83a90@redhat.com>
Subject: Re: [PATCH v3 6/8] iotests: Test driver whitelisting in 093
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-7-mreitz@redhat.com>
 <c0d92948-0d97-321d-ea26-17ce4d2da5d9@redhat.com>
In-Reply-To: <c0d92948-0d97-321d-ea26-17ce4d2da5d9@redhat.com>

--ijV0h0mHKrGks4JzqTkaJYZsMYY9myIXq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.08.19 08:40, Thomas Huth wrote:
> On 8/19/19 10:18 PM, Max Reitz wrote:
>> null-aio may not be whitelisted.  Skip all test cases that require it.=

>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/093 | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
>> index 50c1e7f2ec..f03fa24a07 100755
>> --- a/tests/qemu-iotests/093
>> +++ b/tests/qemu-iotests/093
>> @@ -24,7 +24,7 @@ import iotests
>>  nsec_per_sec =3D 1000000000
>> =20
>>  class ThrottleTestCase(iotests.QMPTestCase):
>> -    test_img =3D "null-aio://"
>> +    test_driver =3D "null-aio"
>>      max_drives =3D 3
>> =20
>>      def blockstats(self, device):
>> @@ -35,10 +35,14 @@ class ThrottleTestCase(iotests.QMPTestCase):
>>                  return stat['rd_bytes'], stat['rd_operations'], stat[=
'wr_bytes'], stat['wr_operations']
>>          raise Exception("Device not found for blockstats: %s" % devic=
e)
>> =20
>> +    def required_drivers(self):
>> +        return [self.test_driver]
>> +
>> +    @iotests.skip_if_unsupported(required_drivers)
>>      def setUp(self):
>>          self.vm =3D iotests.VM()
>>          for i in range(0, self.max_drives):
>> -            self.vm.add_drive(self.test_img, "file.read-zeroes=3Don")=

>> +            self.vm.add_drive(self.test_driver + "://", "file.read-ze=
roes=3Don")
>>          self.vm.launch()
>> =20
>>      def tearDown(self):
>> @@ -264,7 +268,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
>>          self.assertEqual(self.blockstats('drive1')[0], 4096)
>> =20
>>  class ThrottleTestCoroutine(ThrottleTestCase):
>> -    test_img =3D "null-co://"
>> +    test_driver =3D "null-co"
>> =20
>>  class ThrottleTestGroupNames(iotests.QMPTestCase):
>>      max_drives =3D 3
>> @@ -425,4 +429,6 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCa=
se):
>> =20
>> =20
>>  if __name__ =3D=3D '__main__':
>> +    if 'null-co' not in iotests.supported_formats():
>> +        iotests.notrun('null-co driver support missing')
>>      iotests.main(supported_fmts=3D["raw"])
>=20
> Maybe also mention null-co in the patch description?

I probably didn=E2=80=99t because I felt bad that maybe I should add a nu=
ll-co
check to all tests that require it...  But two wrongs don=E2=80=99t make =
a
right, so I=E2=80=99ll leave it at one wrong and put =E2=80=9CSkip the wh=
ole test if
null-co is not whitelisted.=E2=80=9D into the commit message, yes.

Max


--ijV0h0mHKrGks4JzqTkaJYZsMYY9myIXq--

--8Lh5AI99b7XeE5keyXh8M6KEqRXgyy1NG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1b5igACgkQ9AfbAGHV
z0BDoQf9ESeQ1XuAqNVpQhlq3lDDXjOT3aqzq58vsExxWS3LTur9w8QeayDDD0VV
sdhsVQa535bKg5TFB2zP8x2SuOuUbVcCzswnMy73U1JODQoCUN8KnRN7G4ebvlhl
az+AkGvusMVxgzK6Zu80Rkt2helB4fReX4s1uZj4yOFl0KRxn6z4dpDL4iAOPG4E
N9yvLOcpmtu1tQYwhXnH/+dGC1kQZ4MN6jX1pTiNt7kwNhkqzngWOkmjPoUlAbSA
39qh+GDWLttqper4ACCC8azGgIEJlwtjT1xgZZEwE3x3BVRUemAiw03yz2GEOwgN
7HHH2PNxrDJpct/2fQwvHcZdN/FVIw==
=5fPD
-----END PGP SIGNATURE-----

--8Lh5AI99b7XeE5keyXh8M6KEqRXgyy1NG--

