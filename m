Received: from eggs.gnu.org ([2001:4830:134:3::10]:42893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQFJO-0001Rw-Uf
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQFJO-0001K7-8m
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:55:27 -0400
Date: Wed, 28 Jun 2017 17:55:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628155514.GK5378@noname.redhat.com>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-7-el13635@mail.ntua.gr>
	<20170626151154.GG29664@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Content-Disposition: inline
In-Reply-To: <20170626151154.GG29664@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 6/8] block: add options
 parameter to bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 26.06.2017 um 17:11 hat Stefan Hajnoczi geschrieben:
> On Fri, Jun 23, 2017 at 03:46:58PM +0300, Manos Pitsidianakis wrote:
> > diff --git a/block.c b/block.c
> > index 694396281b..c7d9f8959a 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -1150,20 +1150,25 @@ free_and_fail:
> >  }
> > =20
> >  BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *n=
ode_name,
> > -                                       int flags, Error **errp)
> > +                                       int flags, QDict *options, Erro=
r **errp)
>=20
> Please add a doc comment that explains the QDict ownership when options
> !=3D NULL.  Users need to understand whether the options QDict still
> belongs to them after the call or bdrv_new_open_driver() takes over
> ownership.
>=20
> See bdrv_open_inherit() for an example.

I think we might not only want to document it, but probably also change
this function. bdrv_open_inherit() and friends take ownership of the
QDict, so doing the same here would probably avoid bugs in the future.

It also seems more practical, because the only user that is added in
patch 8 already does QDECREF() after calling bdrv_new_open_driver().

Kevin

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZU9FiAAoJEH8JsnLIjy/WHNgQAMY5OV9vBkd7qAiwPcHiY9yA
wnYIh66JIsYqbxcPcnwZZrFMZroWI4ed9QhCbeAUbHi26mtZnvAAigY4WC8GDBmM
smp3eqS4HGNBiRjLB98siBpuEhGhzdxyU3vxYLV89vNUNJsANN1EleXpAcBVmsr8
sKun+WH0L/MN5XoxMTgmQCARZwvCIVqYuSPho/v4ZNViJBARkCDw+xqcM2BMBdUK
bP1raNTlCGfX9UCYeej4v8HS7LKvqTxy+M7AwiRTr52QxUdx8gdGs/5OADaPCUuI
kSp9bfxMPZTuE83F8OrnOJjIk27k26NuHOXOTAbEx14dJwFRzgKfVGDAt86OUSxe
NNhDbZfTI/rSzrslvvGDkqq5XZbwQFvqhCEJC8vx1gvyLSH+vb/LaJNvU8jcgP44
yVzs6dobDgNtoIUe2fXduewhwpM/VDHksQKw5dqO/5vGmYJn3Htb0AR0K/eTi+mZ
NVSr2dSGUVONy6mtMRp3bIvqGXszIIuqFpbGfXySuQ7p24mLIpAcD8cbf4QAzPu8
VUbEHGJxFcTz0HApuyDlLUv5i8G2+8Olulq31P5+bLmTs3m2KbGVmDhxAZehjkFW
qdBWWL2nRfvooXqTESadOIvrnhXXsOU4jGKUEELhZy3gUK7QCKmIYZSsUAQuXEHM
GFklmzTeUJMlOTYCvPsO
=KJjW
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
