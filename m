Received: from eggs.gnu.org ([2001:4830:134:3::10]:59859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUia1-00007T-Lj
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 21:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUia0-0003gc-Gg
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 21:03:37 -0400
Date: Mon, 18 Jun 2018 11:03:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618010327.GK25461@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<79692361d82a4d0b1f9c36b0d988369062351f00.1528935420.git.balaton@eik.bme.hu>
	<20180614013612.GF3042@umbus.fritz.box>
	<alpine.BSF.2.21.1806141001260.19899@zero.eik.bme.hu>
	<20180614124306.GD19339@umbus.fritz.box>
	<alpine.BSF.2.21.1806151131500.89745@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2pR2RtFp0tAjF3C"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806151131500.89745@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 9/9] target/ppc: Add missing opcode for
 icbt on PPC440
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--J2pR2RtFp0tAjF3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 11:35:37AM +0200, BALATON Zoltan wrote:
> On Thu, 14 Jun 2018, David Gibson wrote:
> > On Thu, Jun 14, 2018 at 10:03:41AM +0200, BALATON Zoltan wrote:
> > > On Thu, 14 Jun 2018, David Gibson wrote:
> > > > On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
> > >=20
> > > Maybe amend commit message like this:
> > >=20
> > > According to PPC440 User Manual
> >=20
> > On which page?  Where can I get that manual?
>=20
> By searching for "PPC440 User Manual"? The one I've found had an opcode
> table at the end in an appendix but I've seen one guest using this machine
> code and get invalid instruction on QEMU while apparently it works on real
> hardware (but I can't test that myself as I don't have real
> hardware).

Ok, I'm looking for something like this.

| According to the PPC440 User Manual[0] page XXXX, PPC440 has two
| opcodes for icbt, but qemu currently only implements one of them.
| Add the missing one.
|
| [0] https://link/to/the/manual (if you can find one)


>=20
> Regards,
> BALATON Zoltan
>=20
> > > > > PPC440 has two opcodes for icbt, add the missing one.
> > >=20
> > > If you can do this when committing then please feel free to adjust th=
is
> > > commit message as necessary, otherwise I'll change it in next iterati=
on.
> > >=20
> > > Regards,
> > > BALATON Zoltan
> > >=20
> > > > A document reference to confim this would be nice.
> > > >=20
> > > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > > > ---
> > > > >  target/ppc/translate.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >=20
> > > > > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > > > > index 5fe1ba6..3a215a1 100644
> > > > > --- a/target/ppc/translate.c
> > > > > +++ b/target/ppc/translate.c
> > > > > @@ -6707,6 +6707,8 @@ GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001=
FF801,
> > > > >  GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x03FFF801, PPC_BOOKE),
> > > > >  GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
> > > > >                 PPC_BOOKE, PPC2_BOOKE206),
> > > > > +GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
> > > > > +               PPC_440_SPEC),
> > > > >  GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
> > > > >  GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
> > > > >  GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
> > > >=20
> > > >=20
> > >=20
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J2pR2RtFp0tAjF3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnBN8ACgkQbDjKyiDZ
s5IFIg/8C1mBrOM0EOr7PuGbtsLPPTmhMX4ZfvgDa1eIqO+Jqegr6DGAZ6SPXGBo
1XtvIycficARoY0iWGTpS15ndWHzLLFr1PVNJrBEXrwKmRZnduDg3RwqycAzbMyK
kVBvLgOCSmTmo51t+XUYRdsdQYUZVB3RgzLL681HvqmgSXv6tzj60fYnYYLd6jfn
9LMG6oRV3Emkzj9Aqh4uOsD1tB6rFerICVEmzbG6M10NMdaT1UOKW/YS8EsWEa6U
yxfQMEOXCKXGcWB73FNvP/0D7JNOrjVOx+vR/werLXXXK6AW665ndZIzcn6X9gc1
kX2EOycQiT1jvdjL5kZFeFoa5sHEVBFogIVvBLVvOzD6nf+HWJ0TAWaJPtpWPjBg
HVPrvPg+pDvXP0Ld2iVaT/bcGBPew5TqyUtcb3Wy5UBrDrOfMRRs9OddJLnrpfRj
uc447uK4JKmFpp09z/M/dN1ObsLr3NGQ+TAH+HbeJm38+hqA9fDeDcpVo9O3AhW7
iJ8InQLfQojakTjhh0CY3c7HeL8Uy9+BuNeZzFPubjwpIsVKAtkqgb79fJpt9Nc8
kiA5r2AXnsXlKLlKvfK77cTZ7yyoxFahZT8lwnx8WDgboj+ynXjC5KplQ7ta6eRc
cnBbc1wYZqdmqzGmj8IRT5PuaWnsQstNJu2P+L3zjg6g+89Hvpk=
=AxBu
-----END PGP SIGNATURE-----

--J2pR2RtFp0tAjF3C--
