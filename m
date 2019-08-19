Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D183C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715E9214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715E9214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzoMS-0004Kf-1u
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzoBF-0007C4-QE
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzoBD-0005kU-PS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:23:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzoB6-0005ir-2H; Mon, 19 Aug 2019 16:22:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 12E6E3001A9A;
 Mon, 19 Aug 2019 20:22:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-64.brq.redhat.com
 [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC6337E35;
 Mon, 19 Aug 2019 20:22:53 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20190819092118.18920-1-thuth@redhat.com>
 <763f15ee-a1ca-ba06-fc70-fdff9427ebf7@redhat.com>
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
Message-ID: <9df50705-4d16-f390-8c16-202eac567fa1@redhat.com>
Date: Mon, 19 Aug 2019 22:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <763f15ee-a1ca-ba06-fc70-fdff9427ebf7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2SjW1lopVo0DmSn8jPut5LgZxBeQjjOyV"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 19 Aug 2019 20:22:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Add more "skip_if_unsupported"
 statements to the python tests
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
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2SjW1lopVo0DmSn8jPut5LgZxBeQjjOyV
Content-Type: multipart/mixed; boundary="9PFG0hE1OmfIYt2JLVSEpzXUmxGclk3qH";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <9df50705-4d16-f390-8c16-202eac567fa1@redhat.com>
Subject: Re: [PATCH] iotests: Add more "skip_if_unsupported" statements to the
 python tests
References: <20190819092118.18920-1-thuth@redhat.com>
 <763f15ee-a1ca-ba06-fc70-fdff9427ebf7@redhat.com>
In-Reply-To: <763f15ee-a1ca-ba06-fc70-fdff9427ebf7@redhat.com>

--9PFG0hE1OmfIYt2JLVSEpzXUmxGclk3qH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.19 21:13, Max Reitz wrote:
> On 19.08.19 11:21, Thomas Huth wrote:
>> The python code already contains a possibility to skip tests if the
>> corresponding driver is not available in the qemu binary - use it
>> in more spots to avoid that the tests are failing if the driver has
>> been disabled.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qemu-iotests/030 |  3 +++
>>  tests/qemu-iotests/040 |  2 ++
>>  tests/qemu-iotests/041 | 14 +++++++++++++-
>>  tests/qemu-iotests/245 |  2 ++
>>  4 files changed, 20 insertions(+), 1 deletion(-)
>=20
> [...]
>=20
>> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
>> index 26bf1701eb..f45d20fbe0 100755
>> --- a/tests/qemu-iotests/041
>> +++ b/tests/qemu-iotests/041
>> @@ -817,6 +817,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
>>      image_len =3D 1 * 1024 * 1024 # MB
>>      IMAGES =3D [ quorum_img1, quorum_img2, quorum_img3 ]
>> =20
>> +    @iotests.skip_if_unsupported(['quorum'])
>>      def setUp(self):
>>          self.vm =3D iotests.VM()
>=20
> It=E2=80=99s clear that none of these tests can run if there is no quor=
um
> support, because setUp() creates a quorum node.  I think it would be
> nice if it would suffice to just skip everything automatically if
> setUp() is skipped and not have to bother about each of the test cases.=

>=20
> Coincidentally (:-)), I have a patch to do that, namely =E2=80=9Ciotest=
s: Allow
> skipping test cases=E2=80=9D in my =E2=80=9Ciotests: Selfish patches=E2=
=80=9D series:
>=20
> https://lists.nongnu.org/archive/html/qemu-block/2019-06/msg01106.html
>=20
> Yes, that means you cannot use an annotation because it needs @self to
> be able to skip the test.  Hm... But I think I can make that work by
> simply s/case_notrun/args[0].case_skip/ in skip_if_unsupported()?

(Sent a v3 now that does that.)

(Max)


--9PFG0hE1OmfIYt2JLVSEpzXUmxGclk3qH--

--2SjW1lopVo0DmSn8jPut5LgZxBeQjjOyV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1bBRwACgkQ9AfbAGHV
z0C3RAf+InNZruz7ZTQBfTrPE04JP1QjMhU0yQHdLvDp4gqpjRpBdWhDcpWXgGgq
qo8ebMjo//JxRKH1ERwrcF6cR8PLyR4EgIqbujIvEwt6lqLiRZeU42nYFJGYpmms
vneFxLTjQy+BEO5AGQZCjNvkhZgqRnGVKp75YrySoFkZ6QZatVz/g763jD2aYFzF
0DTQ5Ph/DmuYBJZLUs3gWrMDE3a+nVEuytJMAtAHqQSY6edtuOz7yITBaCfDe4oa
pw2Ssd0/CxQeN9w8TdcEPCyf1Bh+YIZ4WHveYg2Fdq4kvIdg8zn0xZvVS23Fyhb6
v5GAW1c7AxwzjS6KYUMbzaFepGVd4g==
=SUsb
-----END PGP SIGNATURE-----

--2SjW1lopVo0DmSn8jPut5LgZxBeQjjOyV--

