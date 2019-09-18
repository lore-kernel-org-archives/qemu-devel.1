Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A63C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B790B21920
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B790B21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAeqi-0002Y0-RH
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 14:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iAeq2-0001jK-C5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iAeq1-0002F3-81
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 14:38:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iAepy-0002DR-TM; Wed, 18 Sep 2019 14:37:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31C0730860CB;
 Wed, 18 Sep 2019 18:37:58 +0000 (UTC)
Received: from [10.10.124.73] (ovpn-124-73.rdu2.redhat.com [10.10.124.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C1AC19C5B;
 Wed, 18 Sep 2019 18:37:57 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190917092004.999-1-mreitz@redhat.com>
 <20190917092004.999-6-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bc98f0b2-4b6e-5d7d-efe1-b2eb740ade31@redhat.com>
Date: Wed, 18 Sep 2019 14:37:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917092004.999-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 18 Sep 2019 18:37:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 5/7] iotests: Test driver whitelisting
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/17/19 5:20 AM, Max Reitz wrote:
> null-aio may not be whitelisted.  Skip all test cases that require it.
>=20
> (And skip the whole test if null-co is not whitelisted.)
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Sorry for the goose chase on v(n-1).

I feel like maybe there's a nicer way to do this, but I can't figure out=20
what it is, so ... my mistake.

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>   tests/qemu-iotests/093 | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
> index 50c1e7f2ec..f03fa24a07 100755
> --- a/tests/qemu-iotests/093
> +++ b/tests/qemu-iotests/093
> @@ -24,7 +24,7 @@ import iotests
>   nsec_per_sec =3D 1000000000
>  =20
>   class ThrottleTestCase(iotests.QMPTestCase):
> -    test_img =3D "null-aio://"
> +    test_driver =3D "null-aio"
>       max_drives =3D 3
>  =20
>       def blockstats(self, device):
> @@ -35,10 +35,14 @@ class ThrottleTestCase(iotests.QMPTestCase):
>                   return stat['rd_bytes'], stat['rd_operations'], stat[=
'wr_bytes'], stat['wr_operations']
>           raise Exception("Device not found for blockstats: %s" % devic=
e)
>  =20
> +    def required_drivers(self):
> +        return [self.test_driver]
> +
> +    @iotests.skip_if_unsupported(required_drivers)
>       def setUp(self):
>           self.vm =3D iotests.VM()
>           for i in range(0, self.max_drives):
> -            self.vm.add_drive(self.test_img, "file.read-zeroes=3Don")
> +            self.vm.add_drive(self.test_driver + "://", "file.read-zer=
oes=3Don")
>           self.vm.launch()
>  =20
>       def tearDown(self):
> @@ -264,7 +268,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
>           self.assertEqual(self.blockstats('drive1')[0], 4096)
>  =20
>   class ThrottleTestCoroutine(ThrottleTestCase):
> -    test_img =3D "null-co://"
> +    test_driver =3D "null-co"
>  =20
>   class ThrottleTestGroupNames(iotests.QMPTestCase):
>       max_drives =3D 3
> @@ -425,4 +429,6 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCas=
e):
>  =20
>  =20
>   if __name__ =3D=3D '__main__':
> +    if 'null-co' not in iotests.supported_formats():
> +        iotests.notrun('null-co driver support missing')
>       iotests.main(supported_fmts=3D["raw"])
>=20

--=20
=E2=80=94js

