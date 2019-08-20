Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66B9C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A807B2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A807B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyYG-0005nq-Q8
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hzyLv-0005JQ-Tl
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hzyLu-0000Qs-Jc
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:14:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hzyLr-0000M2-LN; Tue, 20 Aug 2019 03:14:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ACEE43082E0F;
 Tue, 20 Aug 2019 07:14:42 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 392305C298;
 Tue, 20 Aug 2019 07:14:41 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190819092118.18920-1-thuth@redhat.com>
 <763f15ee-a1ca-ba06-fc70-fdff9427ebf7@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <b4b99c07-6a56-108f-06b7-cfd77d2004ef@redhat.com>
Date: Tue, 20 Aug 2019 09:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <763f15ee-a1ca-ba06-fc70-fdff9427ebf7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eNAZZruwT9ocnLV1vvlN5ngasWiXLTDQI"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 20 Aug 2019 07:14:42 +0000 (UTC)
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
--eNAZZruwT9ocnLV1vvlN5ngasWiXLTDQI
Content-Type: multipart/mixed; boundary="ouCLcmIZHJAgyWHKxSwACgLxErsCpiF1d";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <b4b99c07-6a56-108f-06b7-cfd77d2004ef@redhat.com>
Subject: Re: [PATCH] iotests: Add more "skip_if_unsupported" statements to the
 python tests
References: <20190819092118.18920-1-thuth@redhat.com>
 <763f15ee-a1ca-ba06-fc70-fdff9427ebf7@redhat.com>
In-Reply-To: <763f15ee-a1ca-ba06-fc70-fdff9427ebf7@redhat.com>

--ouCLcmIZHJAgyWHKxSwACgLxErsCpiF1d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/19/19 9:13 PM, Max Reitz wrote:
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

Sure, feel free to ignore my patch here or to modify it according to
your reworks. As long as we finally get the iotests into a shape where
they are a little bit more flexible wrt the enabled/disabled drivers,
I'm happy.

 Thomas


--ouCLcmIZHJAgyWHKxSwACgLxErsCpiF1d--

--eNAZZruwT9ocnLV1vvlN5ngasWiXLTDQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1bneAACgkQLtnXdP5w
LbU8oRAAljEjmwht3FiQTouKA26fuPsddGuYDw5p6qUSEftxZmX8eGzllYVXRCii
9W1xkli1qC3ABMUhwCUrYhbpv2kAOuUKIVTXvf1gaF6i5Zp31u3xNhHWiyt9oEwj
8rIddX0RM9SDy4CGxShswHGyZ1b3dxQEiS7UXhM+/u4Kka80Q7jbK8Z/zXSD+FSR
5u0ex35WyBvhO8do3p3dEsieuK9xhEjBwVneRebaTV4a9Xea1URlJ/EWMfn7Z8D6
zKBXChX9ZBEfyOiSPAVTRtSwEKxv9CJsAmiZjlQCxEYrUsR5befUVC1iMUt3HvVh
xZHZ/meCoyzUPmg2nO1bpVtJNr78hfkkvfx0TKozhKxhXqLHibb3HjN39cge3Zs3
su08JWNDJxaXpNJfl7dJbAXVenLbC/FvYJrbpX2RiZ03B2ICDa/kzh9Yb6m6G3wx
fynQyF3gNQ4ZUK0qh0YRGo2MXEV9+dLzKxuczgtAKhuJYXGNi7dnPxlpvqpVdrmM
L34hHPNG7prt1qRJB4Z4ajWBU8W5we4O1BNqZ9qU2D8fZRU11+DDfiS2tRFPRNMs
6fHrWIVFC83Kuxs4bkJ5m1tRmYVpWLcN/GTkdCqBUF5eNck3KH3AN9B9UPXwhWdV
ucKqHsuVAyqvLhuqXr6I7i6E72EWnuKCq6mLrAPzXX4xSYlOVGo=
=dIvb
-----END PGP SIGNATURE-----

--eNAZZruwT9ocnLV1vvlN5ngasWiXLTDQI--

