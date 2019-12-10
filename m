Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78676C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A9720828
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 17:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3ioiFy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A9720828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iejn5-0001sV-Cx
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 12:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iejlR-0000Kk-Mc
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iejlO-0000nE-Tj
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:57:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44905
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iejlO-0000mf-O6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 12:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576000653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxhPPLC7q3VSkDCVEjZbM/EvE9Woz48CD6B0L6+bLyI=;
 b=U3ioiFy+a+4vZCWcDf8PTegkjx4Fu4afVmB4nDPC8wgAs8+vVrrPmiqbzmonvWLRXRbRA/
 /m6XwVIFbXij1/kPuBidmrgT3e196Jyg1mCKOOEGqy2e+PWv1eXxUakXDTtI2vHMseN1Fh
 4CQfvzWJAqzYfMJRnNtmLdIMKen0MG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-ydvRHCvUMemc1RUy-d0XrQ-1; Tue, 10 Dec 2019 12:57:32 -0500
X-MC-Unique: ydvRHCvUMemc1RUy-d0XrQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6D20185435D;
 Tue, 10 Dec 2019 17:57:30 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D24C605F9;
 Tue, 10 Dec 2019 17:57:30 +0000 (UTC)
Date: Tue, 10 Dec 2019 12:57:28 -0500
From: Cleber Rosa <crosa@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 2/2] analyze-migration.py: replace numpy with python 3.2
Message-ID: <20191210175728.GA21398@dhcp-17-72.bos.redhat.com>
References: <20191127101038.327080-1-marcandre.lureau@redhat.com>
 <20191127101038.327080-3-marcandre.lureau@redhat.com>
 <20191206142723.GA5020@dhcp-17-72.bos.redhat.com>
 <20191210025857.GQ498046@habkost.net>
 <CAJ+F1CL_0ytd2O4m1FcqQbFSLh3S5v=fLY=FyUZa4zg47uCOQA@mail.gmail.com>
 <20191210174909.GA4230@dhcp-17-72.bos.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191210174909.GA4230@dhcp-17-72.bos.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 12:49:11PM -0500, Cleber Rosa wrote:
> On Tue, Dec 10, 2019 at 02:14:18PM +0400, Marc-Andr=E9 Lureau wrote:
> > Hi
> >=20
> > On Tue, Dec 10, 2019 at 6:59 AM Eduardo Habkost <ehabkost@redhat.com> w=
rote:
> > >
> > > On Fri, Dec 06, 2019 at 09:27:23AM -0500, Cleber Rosa wrote:
> > > > On Wed, Nov 27, 2019 at 02:10:38PM +0400, Marc-Andr=E9 Lureau wrote=
:
> > > > > Use int.from_bytes() from python 3.2 instead.
> > > > >
> > > > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > > > ---
> > > > >  scripts/analyze-migration.py | 35 +++++++++++++++++++-----------=
-----
> > > > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > > > >
> > > > > diff --git a/scripts/analyze-migration.py b/scripts/analyze-migra=
tion.py
> > > > > index 2b835d9b70..96a31d3974 100755
> > > > > --- a/scripts/analyze-migration.py
> > > > > +++ b/scripts/analyze-migration.py
> > > > > @@ -1,4 +1,4 @@
> > > > > -#!/usr/bin/env python
> > > > > +#!/usr/bin/env python3
> > > [...]
> > > >
> > > > Marc-Andr=E9, I couldn't yet pinpoint the reason yet, but this patc=
h
> > > > changes the parsing of bool fields.  This is a diff between the out=
put
> > > > pre/post this patch on the same images:
> > > >
> > > > $ diff -u out_x8664_pre out_x8664_post
> > > > --- out_x8664_pre       2019-12-06 09:14:16.128943264 -0500
> > > > +++ out_x8664_post      2019-12-06 09:23:35.861378600 -0500
> > > > @@ -3039,7 +3039,7 @@
> > > >              "mac_reg[RADV]": "0x00000000",
> > > >              "mac_reg[TADV]": "0x00000000",
> > > >              "mac_reg[ITR]": "0x00000000",
> > > > -            "mit_irq_level": true
> > > > +            "mit_irq_level": false
> > > >          },
> > > >          "e1000/full_mac_state": {
> > > >              "mac_reg": [
> > > > @@ -36010,10 +36010,10 @@
> > > >              ],
> > > >              "smb_auxctl": "0x02",
> > > >              "smb_blkdata": "0x00",
> > > > -            "i2c_enable": true,
> > > > +            "i2c_enable": false,
> > > >              "op_done": true,
> > > > -            "in_i2c_block_read": true,
> > > > -            "start_transaction_on_status_read": true
> > > > +            "in_i2c_block_read": false,
> > > > +            "start_transaction_on_status_read": false
> > > >          },
> > > >          "ar.tmr.timer": "ff ff ff ff ff ff ff ff",
> > > >          "ar.tmr.overflow_time": "0x0000000000000000",
> > > >
> > > > This true/false flipping is consistent across various images (tried=
 on
> > > > images generated on a few other targets).
> > >
> > > It looks like moving to python3 accidentally fixes a bug.
> > >
> > > This is VMSDFieldBool.read:
> > >
> > >     def read(self):
> > >         super(VMSDFieldBool, self).read()
> > >         if self.data[0] =3D=3D 0:
> > >             self.data =3D False
> > >         else:
> > >             self.data =3D True
> > >         return self.data
> > >
> > > On python2, MigrationFile.readvar() returned a string, so the
> > > (self.data[0] =3D=3D 0) check was never true.  This means all boolean
> > > fields were always initialized to True.
> > >
> > > On python3, MigrationFile.readvar() returns a bytearray, so the
> > > (self.data[0] =3D=3D 0) check now works as expected.
> >=20
> > Ah! nice surprise. Do you mind updating the commit message on commit?
> > Or should I resend?
> >=20
> > thanks
> >=20
> > --=20
> > Marc-Andr=E9 Lureau
> >=20
>=20
> Yep, I'm queueing this with an updated commit message.
>=20
> Eduardo, does your comment imply a "Reviewed-by"?
>=20
> Cheers,
> - Cleber.

Eduardo,

I only noticed now that you queued patch 1/2.  Do you want me to queue
that one instead?  Or do you wanto to queue both on this series?

Cheers,
- Cleber.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3v3IUACgkQZX6NM6Xy
CfOXog//aCCiVOQwkhQ5vZ1njNiQwjFd8JVtEEQY6QjNXJXMTOuwzObEt7VVHRJY
4nucwAk3KiZNrUrvWZ6IJdnqNseg5vBEicQTczjFthvNKFgUFUNT1ZQmEmiJ9eYT
ldtrvLKIXz2sDmZin5v2yTZpvyStJPossQtMdVLh05IXaAD/C1RctGccbwXGQgO3
mQ/ZmgFoYmFbNY0MnTpyo9npT21obP5q0paKkuPYX1cJzB/kRKi2pu9Mxqa6gGfi
93ayOdexAA2z5A/S01k/nVmMRWmDKAVFqwlR/1gV2VDHkrx+EyTFg8S5qT4tcu/H
+lP8oc+v/zQROMa463alYMkjwNa/FtJuHGDKLZj18YDcbkRHOqG+eRQP/DWTKI5o
k6x0emN1a+rtXavz2oUt+HaA1+ZuYopEmjXdwaONAA6D/dbfHpGUjQM5cvYya8uq
t77Lb14AlkqQkBO+nXdHFTiYqvxIO3nle3QL+hnZDYo7DxYQy4ksda+hzFqf3GBQ
OisMqAGwnuud3q5DofPTKV2hhiCRiHulcoZc+5tz08ORN4YVg32DPpOZ0oublxI4
/gxzmqoYCO6VW1g6jyyKfud1ZxZ3u5e0VWk5X/x+l3NSZrzpexLgghnWQHPO3RCX
ER8JFeZrGhOYqqv7fRjp83UrKozfDLGktf2lhoefVAi/rSxub6I=
=cNQh
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--


