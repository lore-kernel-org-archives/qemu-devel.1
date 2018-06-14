Received: from eggs.gnu.org ([2001:4830:134:3::10]:58293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTbqI-0005x1-Rg
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 19:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTbqH-00043o-MH
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 19:39:50 -0400
Date: Thu, 14 Jun 2018 22:43:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614124306.GD19339@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<79692361d82a4d0b1f9c36b0d988369062351f00.1528935420.git.balaton@eik.bme.hu>
	<20180614013612.GF3042@umbus.fritz.box>
	<alpine.BSF.2.21.1806141001260.19899@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806141001260.19899@zero.eik.bme.hu>
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


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 10:03:41AM +0200, BALATON Zoltan wrote:
> On Thu, 14 Jun 2018, David Gibson wrote:
> > On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
>=20
> Maybe amend commit message like this:
>=20
> According to PPC440 User Manual

On which page?  Where can I get that manual?

> > > PPC440 has two opcodes for icbt, add the missing one.
>=20
> If you can do this when committing then please feel free to adjust this
> commit message as necessary, otherwise I'll change it in next iteration.
>=20
> Regards,
> BALATON Zoltan
>=20
> > A document reference to confim this would be nice.
> >=20
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > ---
> > >  target/ppc/translate.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > > index 5fe1ba6..3a215a1 100644
> > > --- a/target/ppc/translate.c
> > > +++ b/target/ppc/translate.c
> > > @@ -6707,6 +6707,8 @@ GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001FF80=
1,
> > >  GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x03FFF801, PPC_BOOKE),
> > >  GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
> > >                 PPC_BOOKE, PPC2_BOOKE206),
> > > +GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
> > > +               PPC_440_SPEC),
> > >  GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
> > >  GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
> > >  GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsiYtoACgkQbDjKyiDZ
s5Jadg//acSQx5SUI778mOXKZmSk2+N90gCFvg37mEMSoU6IgtlUbSa4Qaz8WR4K
5zbkGcWPRg9GTUgg3LFPsslrGGSOha8L7qqptFX9Uox+TM2AyQHvwoA2DN/b3CO+
MFEFaJWuzUrOiMtrctag/92uFQ1oov416sK0BNcnLrnsqP/cjQJpqxM2/iv7ZUdV
++siPklUHyDDLQszObQUcBWxOqH4fHJY3VNJai9PxJfxDfT522JIZ4phbSh3yD8h
jsLhwia56cdFJsV1huLPxqwWeI3YRfvmrrZTIf4j+Q8orwcRPUXjEDC6Q7T/cv6g
lI1hnf9w0P1wMfxmnmEqDVZ5zVpEIJ7FkpG+U7581PT4MD+RzTkzWG4zOLKIhMQo
OKQV0T7KYGjnvHFGe5epkx5T9rFLlVxCgPsU+FWA3kGFZj4Hgw1aCrdKshBfVKKK
apvW6MXqlHei76PgIi34LAiBvkd8DNksuXD7Gwz2ZpefBhxrZB14gdjM/ACtucAi
YuvczyvMsD2NvvDw4TLdzoLyPBlHFCDmYku8QIT0V5TM+ZmF/KGzTMOP6WDaTw1i
R9DrnequMHMuYTjIB+V8NDWzHd5GSaMaOp+rZGC5GD455GvrjIZKLCEEcUx4K2sm
stqW3RUtQJKNcddqlxI6h+2M4v5WILyH/D0bO+K8+XrVlmSRQCg=
=63qo
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
