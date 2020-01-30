Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F08FC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E12D20707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvyUyYnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E12D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCR6-0004Gs-KI
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1ixCQX-0003iW-2l
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1ixCQW-0007zO-3z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:12:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53505
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1ixCQW-0007z7-0O
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580400739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CZ+PaMyGUviZE9r49TikQGoEihaVpjQ/jm0IiQ/DYT4=;
 b=IvyUyYnRt2WXmrbYskvMoYZTvjMMpqtwEOJIumJr7vSPyA1oKLeRfAp9OHg0HeipupMiCA
 qheudouvM2Z+sE784zqjlcPMqoK5Lat5iUKx6JCA61ppt3WUlBwERqyhhfqTaoO+ZEIkm2
 YJJqdd4FZOYVXGUvloMiWp4p9LvMqXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-zV3onNlyMh-X-LMZBvobpA-1; Thu, 30 Jan 2020 11:12:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98ECE10509B4;
 Thu, 30 Jan 2020 16:12:16 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 214485DA75;
 Thu, 30 Jan 2020 16:12:09 +0000 (UTC)
Message-ID: <3d5144ed83abeaa588dbaff3a126817646478575.camel@redhat.com>
Subject: Re: [PATCH 08/13] iotests: filter few more luks specific create
 options
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 30 Jan 2020 18:12:09 +0200
In-Reply-To: <20200128173619.GA1446339@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-9-mlevitsk@redhat.com>
 <20200128173619.GA1446339@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: zV3onNlyMh-X-LMZBvobpA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Tue, 2020-01-28 at 17:36 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 14, 2020 at 09:33:45PM +0200, Maxim Levitsky wrote:
> > This allows more tests to be able to have same output on both qcow2 luk=
s encrypted images
> > and raw luks images
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  tests/qemu-iotests/087.out       | 6 +++---
> >  tests/qemu-iotests/134.out       | 2 +-
> >  tests/qemu-iotests/158.out       | 4 ++--
> >  tests/qemu-iotests/188.out       | 2 +-
> >  tests/qemu-iotests/189.out       | 4 ++--
> >  tests/qemu-iotests/198.out       | 4 ++--
> >  tests/qemu-iotests/common.filter | 6 ++++--
> >  7 files changed, 15 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
> > index 2d92ea847b..b61ba638af 100644
> > --- a/tests/qemu-iotests/087.out
> > +++ b/tests/qemu-iotests/087.out
> > @@ -34,7 +34,7 @@ QMP_VERSION
>=20
> 1> =20
> >  =3D=3D=3D Encrypted image QCow =3D=3D=3D
> > =20
> > -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encrypti=
on=3Don encrypt.key-secret=3Dsec0
> > +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encrypti=
on=3Don
>=20
> I'm not convinced about this - it feels like this is throwing
> away relevant info to be validated about the test scenario
This is mostly echo of the input info so it is only nice to have to debug t=
he test IMHO.

>=20
> Can you give more info about the scenario this benefits us in ?

This allows me to have same test output for raw luks and qcow2, and thus
use mostly the same test (sans adding the encrypt.* prefix everywhere) for =
both
luks and qcow2.

Best regards,
=09Maxim Levitsky

>=20
> Regards,
> Daniel



