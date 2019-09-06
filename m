Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FBFC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431842067B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431842067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6FDF-00018a-G6
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 10:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i6FBy-0000Il-0u
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i6FBv-00044P-QZ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:26:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i6FBr-00041B-4O; Fri, 06 Sep 2019 10:26:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C235883823;
 Fri,  6 Sep 2019 14:26:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F9BD5D784;
 Fri,  6 Sep 2019 14:26:09 +0000 (UTC)
Message-ID: <b6d1e1d73d85dbce235c160fee6320698d9fbfd3.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Fri, 06 Sep 2019 17:26:09 +0300
In-Reply-To: <20190906141443.GR5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-11-mlevitsk@redhat.com>
 <20190906141443.GR5119@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 06 Sep 2019 14:26:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 10/10] iotests : add tests for encryption
 key management
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-06 at 15:14 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 30, 2019 at 11:56:08PM +0300, Maxim Levitsky wrote:
> > Note that currently I add tests 300-302, which are
> > placeholders to ease the rebase. In final version
> > of these patches I will update these.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  tests/qemu-iotests/087.out       |   6 +-
> >  tests/qemu-iotests/134.out       |   2 +-
> >  tests/qemu-iotests/158.out       |   4 +-
> >  tests/qemu-iotests/188.out       |   2 +-
> >  tests/qemu-iotests/189.out       |   4 +-
> >  tests/qemu-iotests/198.out       |   4 +-
> >  tests/qemu-iotests/300           | 202 +++++++++++++++++++++++++
> >  tests/qemu-iotests/300.out       |  98 ++++++++++++
> >  tests/qemu-iotests/301           |  90 +++++++++++
> >  tests/qemu-iotests/301.out       |  30 ++++
> >  tests/qemu-iotests/302           | 247 +++++++++++++++++++++++++++++=
++
> >  tests/qemu-iotests/302.out       |  18 +++
> >  tests/qemu-iotests/common.filter |   6 +-
> >  tests/qemu-iotests/group         |   8 +
> >  14 files changed, 708 insertions(+), 13 deletions(-)
> >  create mode 100755 tests/qemu-iotests/300
> >  create mode 100644 tests/qemu-iotests/300.out
> >  create mode 100755 tests/qemu-iotests/301
> >  create mode 100644 tests/qemu-iotests/301.out
> >  create mode 100644 tests/qemu-iotests/302
> >  create mode 100644 tests/qemu-iotests/302.out
> >=20
> > diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
> > index 2d92ea847b..b61ba638af 100644
> > --- a/tests/qemu-iotests/087.out
> > +++ b/tests/qemu-iotests/087.out
> > @@ -34,7 +34,7 @@ QMP_VERSION
> > =20
> >  =3D=3D=3D Encrypted image QCow =3D=3D=3D
> > =20
> > -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryp=
tion=3Don encrypt.key-secret=3Dsec0
> > +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryp=
tion=3Don
>=20
> Why is the output format changing ? There's no code changes in
> this patch. If the change is due to an earlier patch, then this
> patch chunk should be put in the earlier patch that causes it.
>=20
> Likewise for the changed output to other files in this patch.
>=20
> > =20

I tweaked the common.filter to filter more luks specific create options
so that a test could have same output for both qcow2 and plain raw luks e=
ncryption.
(due to the "encrypt.*" prefix)


I can move this in a separate patch if you think this is worth it.

Best regards,
	Maxim Levitsky


