Received: from eggs.gnu.org ([2001:4830:134:3::10]:52744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJfS-0003DN-Ib
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJfR-0003pP-AV
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:37:10 -0400
Date: Wed, 23 Aug 2017 10:35:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823003553.GE5379@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<5e493fd14e60d92d4fd80492ceff5ba13eb7b558.1502643878.git.balaton@eik.bme.hu>
	<20170818061028.GU5509@umbus.fritz.box>
	<alpine.BSF.2.21.1708181436550.19483@zero.eik.bme.hu>
	<20170822023521.GZ12356@umbus.fritz.box>
	<alpine.BSF.2.21.1708221310280.67133@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1708221310280.67133@zero.eik.bme.hu>
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


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2017 at 01:18:02PM +0200, BALATON Zoltan wrote:
> On Tue, 22 Aug 2017, David Gibson wrote:
> > On Fri, Aug 18, 2017 at 02:46:42PM +0200, BALATON Zoltan wrote:
> > > On Fri, 18 Aug 2017, David Gibson wrote:
> > > > On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> > > > > Add emulation of aCube Sam460ex board based on AMCC 460EX embedde=
d SoC.
> > > > > This is not a full implementation yet with a lot of components st=
ill
> > > > > missing but enough to start a Linux kernel and the U-Boot firmwar=
e.
> > > > >=20
> > > > > Signed-off-by: Fran=E7ois Revol <revol@free.fr>
> > > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > >=20
> > > > There are a *lot* of devices defined here.  Most of them look like
> > > > they belong to the SoC, not the board (since they use DCRs), so it
> > > > doesn't really make sense to define them in a board file.  It would
> > > > also make it easier to review if they were split up into separate
> > > > patches.
> > >=20
> > > I thought it's simpler to review a series with 12 reasonably sized pa=
tches
> > > than one with twice as many which only modify a few lines here and th=
ere
> > > each. Also adding a lot of code scattered in hw directories is probab=
ly less
> > > clear than having them all at one place. But of course each approach =
can be
> > > reasoned. I thought this might have to be split up but I've left it o=
ne
> > > place for now for first review to get some advice on what's preferred.
> >=20
> > Well, it depends on the content of the patches.  If splitting it up
> > means a lot of looking between patches to make sense of what's going
> > on then that's certainly not good.  But if the small patches are
> > independent of each other and can be assessed on their own merits,
> > then that usually makes it easier.
> >=20
> > In this case the various new 440 devices should be pretty much
> > independent of each other, so I think splitting is the better option.
> >=20
> > > Maybe I should put things that belong to the SoC in ppc440_uc.c (simi=
lar to
> > > ppc405uc.c we already have) and move common devices used by both to
> > > ppc4xx_devs.c (which already seems to serve that purpose). If more cl=
eanup
> > > is needed that could be done separately afterwards, I don't think it'=
s a
> > > good idea to mix in too much cleanup now to keep patches relatively s=
imple.
> > > (I already have some moving around included as clean up patches but I=
'd like
> > > to focus on actual functions than clean up at this point).
> > >=20
> > > Does putting these devices from board code to ppc440_uc.c sound
> > > acceptable?
> >=20
> > That'd be ok - though again, I'd prefer to see each device as a
> > separate patch.  It would probably be preferable to put each device in
> > a separate file as well though, unless they're _really_ tiny.  Nothing
> > inherently wrong with small .c files, if they're still more or less
> > self contained.
>=20
> Since most of these are just stubs for now and not really full emulation =
of
> the device I'd leave them in one file similar to ppc405 for now. They both
> could be cleaned up later if it's found necessary or devices that are dee=
med
> ready and big enough to be moved out could be split off (like I did with =
i2c
> and pcix). If you insist, I can split it now but I think it's more diffic=
ult
> to work with a lot of small files scattered in hw instead of everything
> related to ppc440 in one place until there's still missing fucntionality.=
 I
> consider splitting it up cleanup which could be done later separately unl=
ess
> it's a requirement to get this series in.

Ok, that's a reasonable argument.  Go ahead and put them in a
ppc440_uc.c file.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmczegACgkQbDjKyiDZ
s5KhURAA5yns5IsPPz4gcd4A77jJa1yZukhKLfQYfO0LWX8tGsAq4XnBIwEv79/w
lK/iGAoIofLhfl6cLoHJG83qr9zJZdyiaGFWdmtCx/Hud+kxowpImTr0D9AkR+8n
tPOzsFRdG6HqI2nKVtcRjOcLpSjJH6050eQvZaZEVjFlnFoHp9uzO6Bb5uSonsmF
SXt2E3cMlmcu0fg3bGT4q5kGFni4Xuf16T4Ix7rjjnQZsTbJaejRk+0gQkWec7Bx
5yTVPo6oKy/LP9+cLB0HLhD3hiabL7I//tROV9NMf1DidSBnKH8vNCzqoPsdttz9
CrNLe3Af+X7ptgjtqQmuZVtkN8PDyKgPeTxmK0u3NEF6YhKpHUSC88A57E2GUYZ5
Y801NEMeMt4CLPjDZxyaGEP0UgOdUvVnoBemfElqxnGpiTdZ3BCUkWbqu92CTNL6
KjWY3xhmvnyIorXKupkmczOYxuGQmlVP8ulkCK0lI9+IR2kKgn5WYJ3bCxPzjDvl
AUBFtxfVrlCks3ais1E4EKqokVPfHLuVkAOdNEx8faC3AgGDI5RY8DSFqaJpBxgq
Kykyc79Jd1fqkejLSVZRojU5FvdMSbG7PIVsz4b6UQUd+XeKq2qjNjcdzaoeHE/R
QxWVZ7hmn5adkCl5vO8ldp4q4SWovGtPCdb6OVxnF6UGohWAI2Q=
=zx5n
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
