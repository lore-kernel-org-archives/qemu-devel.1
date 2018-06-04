Received: from eggs.gnu.org ([2001:4830:134:3::10]:36246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPlY9-0006PC-7a
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPlY8-00014B-5f
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:13:13 -0400
Date: Mon, 4 Jun 2018 19:12:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604091231.GR4251@umbus>
References: <20180531130429.24911-1-joel@jms.id.au>
	<20180604080448.GM4251@umbus>
	<CACPK8XfrL8U_DCu3Ek9e+Gvj9oSn2+c9JnUBf0i4+OTz96-JRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OiITrshLgfui8fEl"
Content-Disposition: inline
In-Reply-To: <CACPK8XfrL8U_DCu3Ek9e+Gvj9oSn2+c9JnUBf0i4+OTz96-JRw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: Allow privileged access to
 SPR_PCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>


--OiITrshLgfui8fEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 06:06:04PM +0930, Joel Stanley wrote:
> On 4 June 2018 at 17:34, David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Thu, May 31, 2018 at 10:34:29PM +0930, Joel Stanley wrote:
> >> @@ -98,6 +99,15 @@ void helper_store_ptcr(CPUPPCState *env, target_ulo=
ng val)
> >>          tlb_flush(CPU(cpu));
> >>      }
> >>  }
> >> +
> >> +void helper_store_pcr(CPUPPCState *env, target_ulong value)
> >> +{
> >> +    if (value !=3D 0) {
> >> +        error_report("Invalid PCR value 0x"TARGET_FMT_lx, value);
> >> +        return;
> >> +    }
> >
> > I don't see a lot of point to this check.  For now the only user just
> > clears the PCR, but why limit yourself to that explicitly?
>=20
> As we're not emulating the features of the register when the value is
> non-zero, I thought it would make make sense to do something.

Ah.. I see what you mean.

Ok, the check makes sense in that case - but it needs a comment saying
it should go away once we actually put the proper PCR checks in the
various bits of TCG that should have them.

>=20
> I'll drop it in v3.
>=20
> >
> >> +    env->spr[SPR_PCR] =3D value;
> >
> > You definitely should be masking against pcr_mask too.
>=20
> Okay. Thanks for the review.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OiITrshLgfui8fEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsVAnwACgkQbDjKyiDZ
s5Kx3hAA0NBf3o4pTeCXMvLemtyqOkFWj/5oPc3wjQVkMYFNTU9ZYCGk+Y1JpdHN
XJ1BDSIz2s8Fz1n43J502gJDVn7b+xcW4k11hOuBYIKePtPh550YqgmhFn0PGVqn
Wp+5ElLMap7kfdpjkbwflYbb53rbrB6z4OE5L37RGoiP4atK0OWL3VtOXMd7LAej
zySukSM7e/cOfe4Lt8B+HJ3OQpMyxn0EYSja6KE5gZayfojm3RyC5CEZ4Cl4Dwsc
mRr4rb5pJJ1x/DI0DAVBuQ2G1t/eBaRYg1FklUdd+pLu5Wnjz6yNJdtpvCo3Lnid
zEf2Dpp5QycXyQb4j4f8KZP6SuKDtphs2RRovHbJwbnHJOkpUPCjT0VlrUA4l39z
ZL20NNzq/OnVLD2ysEbZdsBBcREF4Tl+zqjXv8uaIJF8Qz5JAp+Iybgyv5tHsa/1
Ma4gCsl6fImK2M/dClKvHow1zr4doQJ8j7TJf1I/qju/IBbzPrmqt93YBYSfPbmH
VaL+THQJl3bYxCPAZIOmwOLMCvLAAPjKF3nugAQ9l8lvs94YP0MH5lbH0nBUJrpR
JwVgqi7n+2Jk3k6wafbzRCK6g5jI/9VxT/76B9AZXadmlldia9qEWrhYwCJFiexN
J+L1acWd6/QaAdly2eLFlOiHxZnBjJW62vot7lFW3RZ7Jps65rk=
=iAO3
-----END PGP SIGNATURE-----

--OiITrshLgfui8fEl--
