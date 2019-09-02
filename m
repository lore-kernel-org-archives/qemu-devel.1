Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B1C3A5A7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 15:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92481217D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 15:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92481217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4nz0-0007Yl-L8
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 11:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i4nxH-0006bT-R5
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 11:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i4nxG-0002nE-QY
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 11:09:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i4nxE-0002cx-0j; Mon, 02 Sep 2019 11:09:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 193DC8980F6;
 Mon,  2 Sep 2019 15:09:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-221.brq.redhat.com
 [10.40.204.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6DA65C54A;
 Mon,  2 Sep 2019 15:09:13 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-40-mreitz@redhat.com>
 <f3fa020d-569a-272c-bf7c-b438aff8bb45@virtuozzo.com>
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
Message-ID: <e9e0382f-5169-8e2e-bb93-aa5f4014b89b@redhat.com>
Date: Mon, 2 Sep 2019 17:09:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f3fa020d-569a-272c-bf7c-b438aff8bb45@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SdeywSl8mJJcmnpGcRBClyRzfymeQgJsa"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Mon, 02 Sep 2019 15:09:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 39/42] iotests: Add filter commit test
 cases
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SdeywSl8mJJcmnpGcRBClyRzfymeQgJsa
Content-Type: multipart/mixed; boundary="ZUmyM3vyrAETr4Tcyio3OU82egNZVQWqX";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <e9e0382f-5169-8e2e-bb93-aa5f4014b89b@redhat.com>
Subject: Re: [PATCH v6 39/42] iotests: Add filter commit test cases
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-40-mreitz@redhat.com>
 <f3fa020d-569a-272c-bf7c-b438aff8bb45@virtuozzo.com>
In-Reply-To: <f3fa020d-569a-272c-bf7c-b438aff8bb45@virtuozzo.com>

--ZUmyM3vyrAETr4Tcyio3OU82egNZVQWqX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.08.19 14:35, Vladimir Sementsov-Ogievskiy wrote:
> 09.08.2019 19:14, Max Reitz wrote:
>> This patch adds some tests on how commit copes with filter nodes.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/040     | 177 +++++++++++++++++++++++++++++++++++=
++
>>   tests/qemu-iotests/040.out |   4 +-
>>   2 files changed, 179 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
>> index 6db9abf8e6..a0a0db8889 100755
>> --- a/tests/qemu-iotests/040
>> +++ b/tests/qemu-iotests/040
>> @@ -428,5 +428,182 @@ class TestReopenOverlay(ImageCommitTestCase):
>>       def test_reopen_overlay(self):
>>           self.run_commit_test(self.img1, self.img0)
>>  =20
>> +class TestCommitWithFilters(iotests.QMPTestCase):
>> +    img0 =3D os.path.join(iotests.test_dir, '0.img')
>> +    img1 =3D os.path.join(iotests.test_dir, '1.img')
>> +    img2 =3D os.path.join(iotests.test_dir, '2.img')
>> +    img3 =3D os.path.join(iotests.test_dir, '3.img')
>> +
>> +    def setUp(self):
>> +        qemu_img('create', '-f', iotests.imgfmt, self.img0, '64M')
>> +        qemu_img('create', '-f', iotests.imgfmt, self.img1, '64M')
>> +        qemu_img('create', '-f', iotests.imgfmt, self.img2, '64M')
>> +        qemu_img('create', '-f', iotests.imgfmt, self.img3, '64M')
>> +
>> +        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 1 0M 1M', self.=
img0)
>> +        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 2 1M 1M', self.=
img1)
>> +        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 3 2M 1M', self.=
img2)
>> +        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 4 3M 1M', self.=
img3)
>> +
>> +        # Distributions of the patterns in the files; this is checked=

>> +        # by tearDown() and should be changed by the test cases as is=

>> +        # necessary
>> +        self.pattern_files =3D [self.img0, self.img1, self.img2, self=
=2Eimg3]
>> +
>> +        self.vm =3D iotests.VM()
>> +        self.vm.launch()
>> +        self.has_quit =3D False
>=20
> has_quit is unused actually. It's always False.

True. (:-))  I wonder why I added it.

Max


--ZUmyM3vyrAETr4Tcyio3OU82egNZVQWqX--

--SdeywSl8mJJcmnpGcRBClyRzfymeQgJsa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1tMJgACgkQ9AfbAGHV
z0D2dQf/TkUoxq3fCBOGCGMFVcNm0ciC7Qof3wY1gO3PKGPaaaRjjiMvbGuIXEtC
DRou7LL+VFzd9VB3v3TFPC8HmfoGuSIJ2dvA3DVOUxB4SX6gLoPFHNc78fdJnQdh
j0mN5R6GDB6fRQL4aZbynUJv3BmfjdeF89W2VObSQ7ykb3u1zWoEZIqG8UbJr1pl
fA179XSd4KgqWj/yN5TDPX/OM84VRpZbFyl3e1fBXM0Ow1t6er3Os6OKZti3+wHB
HLt0ITKQ8P6f24Ao8tnfkbSKUD1lw1Q3oWJKUPnfmhK8pb3WAtTX3znZs6lk0zUw
WbVUSu2S+Ge9K8g/BnNwALXGP7IjFw==
=8M0a
-----END PGP SIGNATURE-----

--SdeywSl8mJJcmnpGcRBClyRzfymeQgJsa--

