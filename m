Received: from eggs.gnu.org ([2001:4830:134:3::10]:48853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fLtqA-0007kR-HL
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fLtq5-0000ZO-Jb
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:15:50 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:52553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fLtq5-0000Vd-D0
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:15:45 -0400
Received: from player791.ha.ovh.net (unknown [10.109.122.11])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 19D6513C55
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 19:15:37 +0200 (CEST)
Date: Thu, 24 May 2018 19:15:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180524191531.00fe263c@bahia.lan>
In-Reply-To: <20180524165256.GA31656@stefanha-x1.localdomain>
References: <152715298769.397287.11782572103987618822.stgit@bahia>
	<20180524165256.GA31656@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/QYb3QGBUh8F0PFirbmlPPOv";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2] block: fix QEMU crash with scsi-hd and
 drive_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/QYb3QGBUh8F0PFirbmlPPOv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 24 May 2018 17:52:56 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Thu, May 24, 2018 at 11:09:47AM +0200, Greg Kurz wrote:
> > diff --git a/block.c b/block.c
> > index 676e57f5623a..fc9379439883 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -2127,12 +2127,16 @@ BdrvChild *bdrv_attach_child(BlockDriverState *=
parent_bs,
> > =20
> >  static void bdrv_detach_child(BdrvChild *child)
> >  {
> > +    BlockDriverState *child_bs =3D child->bs;
> > +
> >      if (child->next.le_prev) {
> >          QLIST_REMOVE(child, next);
> >          child->next.le_prev =3D NULL;
> >      } =20
>=20
> This child->next modification makes me nervous.  Please start the
> drained region before modifying the graph.

Ok, I'll send a v3, and Cc qemu-stable@nongnu.org instead of
stable@vger.kernel.org this time :P

--Sig_/QYb3QGBUh8F0PFirbmlPPOv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsG8zMACgkQcdTV5YIv
c9YIPQ//ej7QAtbdkswv106oHCpCLfq+bfrj/+Nw7+bxW1Msyu+IzqUyxEdvvaHo
fJwy4CgCIc/FyB58khIULYSyLePOQEEJKpF+SY6t/HOCjT8DAE2gaqHq4yR1vJdy
9UAPnWoRAC0b5QfprS9V+HGGpcir4zY4zFFxR6CLFfRseXm6Yu+DErz5vEWmRgt3
uSUcXaX/MFUnMn3hjX4u2mFkvTrDXRSsdI9l70Dazat7zHj0RpOYUGZRv5owh0bL
t7upEyuneASWPWwnL1iZ81veKTy2UaOzIHFD15PVCe+IoLelMq5WHOWLyg/AsvY6
D80ITuwKNVzJfET1qoY0xhCWI8t/qyoEXr1RV/5QDagLaX43VjMzkk2Y2WPG3T6R
ifznHLNrZhQuKdKgej8/PqWxj7FWVijon5jJgbB0T4BS14kknPaKtflzjSVk5phl
Gxm6+EWMkjeOaTmJdnvXhOdBn3h+xNxirco/COfAv2I0ZtH0WRB699K0DqhukuZ5
ASN6bJmXrkcFYq31KyOMHEEm+qdb/oQEcdZ9TMc9+ioeqRYGxrgQz1KlaZ4TvqtD
3eK9aSG5Tmjk6xxpKevfzsKS5BkMiAQkMiavqiT6H6dFYYeUImUKk9hCUA39s5jo
fx0qXMBuhCpyq+dwEYDvBWmQEKoG/OP5gl3Q2IcC7g8pRQo4aRE=
=o+8G
-----END PGP SIGNATURE-----

--Sig_/QYb3QGBUh8F0PFirbmlPPOv--
