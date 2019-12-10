Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002C4C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B7820637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFzD5Fc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B7820637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieje5-0005up-Ub
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 12:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iejdM-0005TC-RJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iejdL-0004mY-Ms
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:49:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52031
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iejdL-0004mM-IS
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576000154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O7Vw+0YOW62wXhwi2/bwgDgBMaQ301sOoE1wBye0Ddw=;
 b=AFzD5Fc8Bq5l+0k6pgMlk0oBOAWN6fVjuOvKzK65DAGXCmnnjPD3Pnk+wKW71XnqAzvT5V
 S2fBrF2fyZpio2WZ70FpwCkJritD2WT6wA/OJ0JRg5OKFOCD+1YzOgWYqWFbGv3nAvNiM/
 HU7ofa0QrGdyjYzXdhW25xKtZkNY8xo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-YzxCJvqSPnGNm0Uw7V1qpg-1; Tue, 10 Dec 2019 12:49:12 -0500
X-MC-Unique: YzxCJvqSPnGNm0Uw7V1qpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCBE4107ACC4;
 Tue, 10 Dec 2019 17:49:11 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FFD219C6A;
 Tue, 10 Dec 2019 17:49:11 +0000 (UTC)
Date: Tue, 10 Dec 2019 12:49:09 -0500
From: Cleber Rosa <crosa@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 2/2] analyze-migration.py: replace numpy with python 3.2
Message-ID: <20191210174909.GA4230@dhcp-17-72.bos.redhat.com>
References: <20191127101038.327080-1-marcandre.lureau@redhat.com>
 <20191127101038.327080-3-marcandre.lureau@redhat.com>
 <20191206142723.GA5020@dhcp-17-72.bos.redhat.com>
 <20191210025857.GQ498046@habkost.net>
 <CAJ+F1CL_0ytd2O4m1FcqQbFSLh3S5v=fLY=FyUZa4zg47uCOQA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL_0ytd2O4m1FcqQbFSLh3S5v=fLY=FyUZa4zg47uCOQA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 02:14:18PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Dec 10, 2019 at 6:59 AM Eduardo Habkost <ehabkost@redhat.com> wro=
te:
> >
> > On Fri, Dec 06, 2019 at 09:27:23AM -0500, Cleber Rosa wrote:
> > > On Wed, Nov 27, 2019 at 02:10:38PM +0400, Marc-Andr=E9 Lureau wrote:
> > > > Use int.from_bytes() from python 3.2 instead.
> > > >
> > > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >  scripts/analyze-migration.py | 35 +++++++++++++++++++-------------=
---
> > > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/scripts/analyze-migration.py b/scripts/analyze-migrati=
on.py
> > > > index 2b835d9b70..96a31d3974 100755
> > > > --- a/scripts/analyze-migration.py
> > > > +++ b/scripts/analyze-migration.py
> > > > @@ -1,4 +1,4 @@
> > > > -#!/usr/bin/env python
> > > > +#!/usr/bin/env python3
> > [...]
> > >
> > > Marc-Andr=E9, I couldn't yet pinpoint the reason yet, but this patch
> > > changes the parsing of bool fields.  This is a diff between the outpu=
t
> > > pre/post this patch on the same images:
> > >
> > > $ diff -u out_x8664_pre out_x8664_post
> > > --- out_x8664_pre       2019-12-06 09:14:16.128943264 -0500
> > > +++ out_x8664_post      2019-12-06 09:23:35.861378600 -0500
> > > @@ -3039,7 +3039,7 @@
> > >              "mac_reg[RADV]": "0x00000000",
> > >              "mac_reg[TADV]": "0x00000000",
> > >              "mac_reg[ITR]": "0x00000000",
> > > -            "mit_irq_level": true
> > > +            "mit_irq_level": false
> > >          },
> > >          "e1000/full_mac_state": {
> > >              "mac_reg": [
> > > @@ -36010,10 +36010,10 @@
> > >              ],
> > >              "smb_auxctl": "0x02",
> > >              "smb_blkdata": "0x00",
> > > -            "i2c_enable": true,
> > > +            "i2c_enable": false,
> > >              "op_done": true,
> > > -            "in_i2c_block_read": true,
> > > -            "start_transaction_on_status_read": true
> > > +            "in_i2c_block_read": false,
> > > +            "start_transaction_on_status_read": false
> > >          },
> > >          "ar.tmr.timer": "ff ff ff ff ff ff ff ff",
> > >          "ar.tmr.overflow_time": "0x0000000000000000",
> > >
> > > This true/false flipping is consistent across various images (tried o=
n
> > > images generated on a few other targets).
> >
> > It looks like moving to python3 accidentally fixes a bug.
> >
> > This is VMSDFieldBool.read:
> >
> >     def read(self):
> >         super(VMSDFieldBool, self).read()
> >         if self.data[0] =3D=3D 0:
> >             self.data =3D False
> >         else:
> >             self.data =3D True
> >         return self.data
> >
> > On python2, MigrationFile.readvar() returned a string, so the
> > (self.data[0] =3D=3D 0) check was never true.  This means all boolean
> > fields were always initialized to True.
> >
> > On python3, MigrationFile.readvar() returns a bytearray, so the
> > (self.data[0] =3D=3D 0) check now works as expected.
>=20
> Ah! nice surprise. Do you mind updating the commit message on commit?
> Or should I resend?
>=20
> thanks
>=20
> --=20
> Marc-Andr=E9 Lureau
>=20

Yep, I'm queueing this with an updated commit message.

Eduardo, does your comment imply a "Reviewed-by"?

Cheers,
- Cleber.

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3v2pIACgkQZX6NM6Xy
CfPCIA//dyxviFZiUeQ7W9rjkKDEtA8LE0qxmwZ2IXq7kFcll05wayvSEJZ6JVf9
iKPqsPaUEsBRylG8FQdWln+TE2qr9GKTzJPcMaRzCJpM4ot7fMstanG0s2+AI6v0
aE3xREA/vkKhVB3pr9OeLb+9K3VjVvguzCmaMMdr3J+q9Bi2OcnOeL8523wdULRx
1FQ/cQ8cXnCGPghwAjux9viJ2v6MgqBirSmQU1h+OjMHIypyw8MpbdFxDB8YeMhX
eHWgOr0wOHJUMlMs+SMVKQok31OqO6WFKtAaeUrS0g1v2JsibXjYV8tQPmORgHIR
mmvwBpMbkQQf97k6VUo6sjOvwOmKsRVfCT9oXJ7SecbEYM9QN9gxjJcIRrvSSPRh
9alaDTEjlLzCsGxJ0UTSQpPSgtYRrQnpKIBsw2Bj0rBkZZ6b5VLEULORwLr6h4DQ
R2Ovpifwcn1Upi/S6SVyWrGB5wH+Kz4iORm7KOK50pUiXeSPpaaToY49jWzC9WWc
NENVwgeSSgEE6uz121p3/2u8Krtj+06jJzbJkyZ1aWIZxx63bc5vhYK/RBR1evFJ
YpiHdZJBuL6KDSnV90cPeQzTH2qpd8zAqNcmKruWmEkbzhnhcTrdFsjCJuh0dzh+
F96zAnH3I8QhFna96f9DsuA1wceyLfCL8Wxz9gzeGLVppY3SS3s=
=vnQJ
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--


