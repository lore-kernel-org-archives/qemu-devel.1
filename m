Received: from eggs.gnu.org ([2001:4830:134:3::10]:49421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djzwo-0005kj-BK
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djzwn-0003h2-4R
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:33:46 -0400
Date: Tue, 22 Aug 2017 12:35:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170822023521.GZ12356@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<5e493fd14e60d92d4fd80492ceff5ba13eb7b558.1502643878.git.balaton@eik.bme.hu>
	<20170818061028.GU5509@umbus.fritz.box>
	<alpine.BSF.2.21.1708181436550.19483@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y2MHPAl/EzyWgzIZ"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708181436550.19483@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 12/12] ppc: Add aCube Sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--y2MHPAl/EzyWgzIZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 02:46:42PM +0200, BALATON Zoltan wrote:
> On Fri, 18 Aug 2017, David Gibson wrote:
> > On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> > > Add emulation of aCube Sam460ex board based on AMCC 460EX embedded So=
C.
> > > This is not a full implementation yet with a lot of components still
> > > missing but enough to start a Linux kernel and the U-Boot firmware.
> > >=20
> > > Signed-off-by: Fran=E7ois Revol <revol@free.fr>
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >=20
> > There are a *lot* of devices defined here.  Most of them look like
> > they belong to the SoC, not the board (since they use DCRs), so it
> > doesn't really make sense to define them in a board file.  It would
> > also make it easier to review if they were split up into separate
> > patches.
>=20
> I thought it's simpler to review a series with 12 reasonably sized patches
> than one with twice as many which only modify a few lines here and there
> each. Also adding a lot of code scattered in hw directories is probably l=
ess
> clear than having them all at one place. But of course each approach can =
be
> reasoned. I thought this might have to be split up but I've left it one
> place for now for first review to get some advice on what's preferred.

Well, it depends on the content of the patches.  If splitting it up
means a lot of looking between patches to make sense of what's going
on then that's certainly not good.  But if the small patches are
independent of each other and can be assessed on their own merits,
then that usually makes it easier.

In this case the various new 440 devices should be pretty much
independent of each other, so I think splitting is the better option.

> Maybe I should put things that belong to the SoC in ppc440_uc.c (similar =
to
> ppc405uc.c we already have) and move common devices used by both to
> ppc4xx_devs.c (which already seems to serve that purpose). If more cleanup
> is needed that could be done separately afterwards, I don't think it's a
> good idea to mix in too much cleanup now to keep patches relatively simpl=
e.
> (I already have some moving around included as clean up patches but I'd l=
ike
> to focus on actual functions than clean up at this point).
>=20
> Does putting these devices from board code to ppc440_uc.c sound
> acceptable?

That'd be ok - though again, I'd prefer to see each device as a
separate patch.  It would probably be preferable to put each device in
a separate file as well though, unless they're _really_ tiny.  Nothing
inherently wrong with small .c files, if they're still more or less
self contained.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y2MHPAl/EzyWgzIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmbmGMACgkQbDjKyiDZ
s5Lj8hAAn6PQ9gQW6iacGLpOyoeanHImszbogzcy5RI2puUUcDt+KGV2jI54vX+o
jG8kXA/8vyjHve3vU56iOp7JCdbWpWtC5gic0K3Ziji1qem3+vt5KzwDJ2u18PFL
YONshO8d6oswKbOzxnPlW7LDlNFSuhJ0trlfGApdxubsq+O02RvSUQofpOOFyRkn
ZPC8+v5C5OYAoDthYrzsZ28YtAHBY+fH5D68YApB8YTKnfxZuAG80K+/cxqWfHJs
Tpe9eRjKbMCJHKQ7QRSvP+teu77P1mILFAAo3/usyRjDWVmBGp7OxNHCfPLnVb7n
Ulre2iwPqtCBL4o6EpftKOF0xdNomVUu7rH7+hQNWw65DB1EFY/U/XHSBSvC0uEP
FMyLHEmr2EJwNaHP8BrxT96k/dJJKXWEn00iGDTLSl6b9++j+PN6S1NyIV/ZCU8w
VC3MXOlcHZGGW97NNmCxiLx22EqrraTlV6KYzPLWKoXlISvjjf5Iwf5vrVFGfZx5
i0D2iz3fj/7nFoVL+7LO/k15sHgiTcu6MuupYy2iCaHzJEjVHgIYN5e+AtQBT4/W
LtHnGFFrQ3/HCGnt7hI536jES8a1CnQbrTlaox4HdhZIZRkzGpMgtSuNRbka0gu1
OvACJtVtm9WxKARdm9vIYgnpSnXjgtUH1es6Zjydcu40UEY3SuA=
=cSF7
-----END PGP SIGNATURE-----

--y2MHPAl/EzyWgzIZ--
