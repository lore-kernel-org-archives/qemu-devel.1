Received: from eggs.gnu.org ([2001:4830:134:3::10]:53452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR6a5-0002Gv-Mu
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:20:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR6a4-0002xz-IX
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:20:29 -0500
Date: Tue, 19 Dec 2017 12:18:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171219011847.GH4786@umbus.fritz.box>
References: <20171216224842.EE8C17456B3@zero.eik.bme.hu>
	<20171218040946.GS7753@umbus.fritz.box>
	<alpine.BSF.2.21.1712181329050.96474@zero.eik.bme.hu>
	<730aec0f-3f10-55ea-eb26-e5740c2fbfe2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline
In-Reply-To: <730aec0f-3f10-55ea-eb26-e5740c2fbfe2@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] hw/ide: Emulate SiI3112 SATA
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 01:33:07PM -0500, John Snow wrote:
>=20
>=20
> On 12/18/2017 07:30 AM, BALATON Zoltan wrote:
> > On Mon, 18 Dec 2017, David Gibson wrote:
> >> On Sat, Dec 16, 2017 at 11:42:39PM +0100, BALATON Zoltan wrote:
> >>> This is a common generic PCI SATA controller that is also used in PCs
> >>> but more importantly guests running on the Sam460ex board prefer this
> >>> card and have a driver for it (unlike for other SATA controllers
> >>> already emulated).
> >>>
> >>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>
> >> I don't know enough about IDE to give this any more than a quick check
> >> for anything obviously bogus looking.=A0 So,
> >>
> >> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>
> >> John, can you take this through your tree, or should I take it through
> >> the ppc tree?
> >=20
> > I think he said before it can go via ppc tree:
> >=20
> > http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg04480.html
> >=20
>=20
> Yep, I tend to use Acked-by to indicate that it's okay for you to stage.
> I'll give it another look-over in a minute, but I'm fine with adding the
> model in general, even if it's not quite complete just yet.
>=20
> (More musings: we really ought to have a way to indicate to QEMU
> programmatically which devices we think are supported, which are
> experimental, and which are rudimentary.)

Ok, I've taken it into my tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo4aPQACgkQbDjKyiDZ
s5KMNA/8CV4D28PL36jvECN/Z0zT6YAW1bPbQORJ/Zq4w0FTKeao78nxMDUztNLp
Ahl1ArA/nT+7n0cMhQIU5HlHmJL3mz2zJq22c8mAhuh0QlF1aJ5lbxl0cMAqnifL
VvYVF1KdpsS5UHjMt9uTihYwjbXe47Q9yHS305qYf4gfM7bNXXMgYUKc2EI41Z4v
90225soEAScNJY2q8P8Np2BEyvVZdpsQOjGpKxLugp7L/nENI5b3nzqI4BcCdkqD
feEbmR3ZG0py+YFkxytvoLIu97+WdIvwN+C0zHMG+xFPOLLgzol3fKaxMQ5e9D+T
rRd0RXqnrJsXq1yjz2QOFRGITKD+bBrKRaSwTrS+mbL2LeOteZcrighL9zCs233e
n4DqYnHbxMx1zG7hFsLKjMS7BnULGfcCzy+gilqbmTSpvJb60qJ2FoxdyNuuygqg
lGfWBUMENQPcjYlg66ZL5zovnP8a+S3gZOKc8yuYfAOY2kYJUx5FqECFkaoFghB3
NvYM6shvPtDj0d1Umjcwt0Sd2yWAe+r7zcF/ZrRo8YXnpIi9HT08R6iFXN3w7W/F
vN2xPNdsHz6YnHzzYDpEHlrWuzJx9cRiIx/uFuu1glNgcPanb9oT0gAJ2kTB5bQ5
dr30lrCiDEF/Hlt8T7D/4/0jIceMdybHTUpYYJZfR6vFEOEIB7Y=
=ZtIk
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--
