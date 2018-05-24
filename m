Received: from eggs.gnu.org ([2001:4830:134:3::10]:40976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fLlfR-0007Af-FZ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fLlfO-0008CX-Ao
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:32:13 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:40512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fLlfO-0008Bk-3l
	for qemu-devel@nongnu.org; Thu, 24 May 2018 04:32:10 -0400
Received: from player737.ha.ovh.net (unknown [10.109.105.75])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2E2371B3049
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 10:32:08 +0200 (CEST)
Date: Thu, 24 May 2018 10:32:00 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180524103200.600f6ed1@bahia.lan>
In-Reply-To: <20180524080553.GB20733@stefanha-x1.localdomain>
References: <152646971421.34839.18198173866060880395.stgit@bahia.lan>
	<20180518153246.GE31915@stefanha-x1.localdomain>
	<20180523164610.09ec083b@bahia.lan>
	<ede94233-e969-0de4-c8ee-a9ff91ce808a@redhat.com>
	<20180524080553.GB20733@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/3DaFGhu5b+J5c3qIgN.owDB";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] block: fix QEMU crash with scsi-hd and
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

--Sig_/3DaFGhu5b+J5c3qIgN.owDB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 24 May 2018 09:05:53 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Thu, May 24, 2018 at 08:04:59AM +0200, Paolo Bonzini wrote:
> > On 23/05/2018 16:46, Greg Kurz wrote: =20
> > > Maybe change bdrv_root_unref_child() to ensure we don't call
> > > bdrv_close() with pending I/O requests ?
> > >=20
> > >  void bdrv_root_unref_child(BdrvChild *child)
> > >  {
> > >      BlockDriverState *child_bs;
> > > =20
> > >      child_bs =3D child->bs;
> > > +    bdrv_drained_begin(child_bs);
> > >      bdrv_detach_child(child);
> > > +    bdrv_drained_end(child_bs);
> > >      bdrv_unref(child_bs);
> > >  } =20
> >=20
> > Maybe bdrv_detach_child should do it. =20
>=20
> Sounds good.
>=20
> Stefan

I guess it makes sense for bdrv_detach_child() to *break* blk->root without
leaving I/O requests behind. I'll just do that then.

Cheers,

--
Greg

--Sig_/3DaFGhu5b+J5c3qIgN.owDB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsGeIAACgkQcdTV5YIv
c9Y7lQ//azG2/8Koi4xBBNz4MTmyUcJdh0IqKuUQIfnfuxFPS9YJxBD0+hMMF0vc
2GIX4rqwI9WtLHi5W/3h1kDK0b9E3Ir+elt9KomPwGblcuZKgU1VL7h45iaGuNUS
TWh7H0OLwkseLkBBj4TAr1Zepzz5QoUZr4vNdJKOvtaPdvAVJE/TAP2u1vmMiVzf
lH1bpVkPHo7+ezzGpEGI2EN/Q4EYgYbtTht4yU4bQ+svzRRkrgONl8E2+zpr/6fo
KYWBUd+K0I0KRT/ROiz9GMKARNMsN2uB0+yUM/t6lUwZY9Pf7iZLSQrA/+UuiHpH
8Y0cCZEysoAaOdzAQUTy3Dc3EYDrU+df68YrVh6JDQ98EpfT3P6Kt0xBHhhmZybD
Ahc6wA+TeyfhkMNA5LKpV/efvxE9VthLuhxN5YDgmdXbTj5I0ATjMGXDwiLKri1Q
R05Z8VO3HEmaH4AaclJe1BM9z8L4/lrxXRaanK+X6ByguDEhiK4Cs7ZWgFvG4waF
MGhLgPR0xFIvmBG2Fo2sMI1G+aWH8GIqqR3LslKIVncIxVTWUWkfWSWdUeAPd0GI
BOi8g//E5JnaSGwNHgEEUdOxcrc6Ssw+hIMq/uJQjc4qmUVHOP3GDyuuyOB1DRdU
ptYaRwtpcudn/vGLhSJGYE+N7LPp6ZD61UipbTtLLpCE+aH5bLg=
=lWhY
-----END PGP SIGNATURE-----

--Sig_/3DaFGhu5b+J5c3qIgN.owDB--
