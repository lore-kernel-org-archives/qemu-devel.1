Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F33BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F7E2082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F7E2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6FEb-0002QJ-G4
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 10:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6FDT-0001YP-N1
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6FDS-00058m-0x
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:27:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i6FDP-00057T-95; Fri, 06 Sep 2019 10:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9EA59A28928;
 Fri,  6 Sep 2019 14:27:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2A105C1D4;
 Fri,  6 Sep 2019 14:27:49 +0000 (UTC)
Date: Fri, 6 Sep 2019 15:27:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190906142746.GV5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-11-mlevitsk@redhat.com>
 <20190906141443.GR5119@redhat.com>
 <b6d1e1d73d85dbce235c160fee6320698d9fbfd3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6d1e1d73d85dbce235c160fee6320698d9fbfd3.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 06 Sep 2019 14:27:54 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 05:26:09PM +0300, Maxim Levitsky wrote:
> On Fri, 2019-09-06 at 15:14 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Aug 30, 2019 at 11:56:08PM +0300, Maxim Levitsky wrote:
> > > Note that currently I add tests 300-302, which are
> > > placeholders to ease the rebase. In final version
> > > of these patches I will update these.
> > >=20
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  tests/qemu-iotests/087.out       |   6 +-
> > >  tests/qemu-iotests/134.out       |   2 +-
> > >  tests/qemu-iotests/158.out       |   4 +-
> > >  tests/qemu-iotests/188.out       |   2 +-
> > >  tests/qemu-iotests/189.out       |   4 +-
> > >  tests/qemu-iotests/198.out       |   4 +-
> > >  tests/qemu-iotests/300           | 202 +++++++++++++++++++++++++
> > >  tests/qemu-iotests/300.out       |  98 ++++++++++++
> > >  tests/qemu-iotests/301           |  90 +++++++++++
> > >  tests/qemu-iotests/301.out       |  30 ++++
> > >  tests/qemu-iotests/302           | 247 +++++++++++++++++++++++++++=
++++
> > >  tests/qemu-iotests/302.out       |  18 +++
> > >  tests/qemu-iotests/common.filter |   6 +-
> > >  tests/qemu-iotests/group         |   8 +
> > >  14 files changed, 708 insertions(+), 13 deletions(-)
> > >  create mode 100755 tests/qemu-iotests/300
> > >  create mode 100644 tests/qemu-iotests/300.out
> > >  create mode 100755 tests/qemu-iotests/301
> > >  create mode 100644 tests/qemu-iotests/301.out
> > >  create mode 100644 tests/qemu-iotests/302
> > >  create mode 100644 tests/qemu-iotests/302.out
> > >=20
> > > diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.ou=
t
> > > index 2d92ea847b..b61ba638af 100644
> > > --- a/tests/qemu-iotests/087.out
> > > +++ b/tests/qemu-iotests/087.out
> > > @@ -34,7 +34,7 @@ QMP_VERSION
> > > =20
> > >  =3D=3D=3D Encrypted image QCow =3D=3D=3D
> > > =20
> > > -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encr=
yption=3Don encrypt.key-secret=3Dsec0
> > > +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encr=
yption=3Don
> >=20
> > Why is the output format changing ? There's no code changes in
> > this patch. If the change is due to an earlier patch, then this
> > patch chunk should be put in the earlier patch that causes it.
> >=20
> > Likewise for the changed output to other files in this patch.
> >=20
> > > =20
>=20
> I tweaked the common.filter to filter more luks specific create options
> so that a test could have same output for both qcow2 and plain raw luks=
 encryption.
> (due to the "encrypt.*" prefix)

Oh i see, I was not looking carefully enough.

> I can move this in a separate patch if you think this is worth it.

Yeah that's a good idea.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

