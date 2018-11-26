Received: from eggs.gnu.org ([2001:4830:134:3::10]:39506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRBIL-0007ir-0x
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 02:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRBIG-0005jQ-Qm
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 02:27:00 -0500
Date: Mon, 26 Nov 2018 16:44:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181126054429.GH2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
	<20181122044450.GF10448@umbus.fritz.box>
	<121d4f915a03c2e734feebceda023947aedb78a3.camel@kernel.crashing.org>
	<20181123011005.GU10448@umbus.fritz.box>
	<12f3da3b-3761-a26f-4460-65d3c978f52d@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Content-Disposition: inline
In-Reply-To: <12f3da3b-3761-a26f-4460-65d3c978f52d@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 04/36] ppc/xive: introduce the
 XiveRouter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--X+8siUETKMkW99st
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 11:28:24AM +0100, C=E9dric Le Goater wrote:
> On 11/23/18 2:10 AM, David Gibson wrote:
> > On Thu, Nov 22, 2018 at 05:50:07PM +1100, Benjamin Herrenschmidt wrote:
> >> On Thu, 2018-11-22 at 15:44 +1100, David Gibson wrote:
> >>>
> >>> Sorry, didn't think of this in my first reply.
> >>>
> >>> 1) Does the hardware ever actually write back to the EAS?  I know it
> >>> does for the END, but it's not clear why it would need to for the
> >>> EAS.  If not, we don't need the setter.
> >>
> >> Nope, though the PAPR model will via hcalls
> >=20
> > Right, bit AIUI the set_eas hook is about abstracting PAPR vs bare
> > metal details.  Since the hcall knows it's PAPR it can just update the
> > backing information for the EAS directly, and no need for an
> > abstracted hook.
>=20
> Indeed, the first versions of the XIVE patchset did not use such hooks,=
=20
> but when discussed we said we wanted abstract methods for the router=20
> to validate the overall XIVE model, which is useful for PowerNV.=20
>=20
> We can change again and have the hcalls get/set directly in the EAT
> and ENDT. It would certainly simplify the sPAPR model.

I think that's the better approach.

> >>> 2) The signatures are a bit odd here.  For the setter, a value would
> >>> make sense than a (XiveEAS *), since it's just a word.  For the getter
> >>> you could return the EAS value directly rather than using a pointer -
> >>> there's already a valid bit in the EAS so you can construct a value
> >>> with that cleared if the lisn is out of bounds.
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv7iD0ACgkQbDjKyiDZ
s5J+pg//Ua979wYc2jYwCO5f3+SsIZDveO+cB73USbuz3Yyf1UNXVAf4C+V73C3X
QJW+WS2ZEQ9osp9h4Nqa1PaIO6lPKuxJNuXUXtksGuvXFQPu+mRJtAWD1OWywGOz
yZekJYNnJWzYdJEHhbbWxwGOiJrw4Z/KOpKTqaYY2uLEFqeJlmIlfXwnkBh9cJfH
gXmQpJIm8HvWS5j3ib4xs/CFkJZ7cedWOdXAobXKlotx+W4b+d3cRHDF4/ZSZk45
KKfleH/rWn+VwhZUyD29glNZydzi2ZeZDMD2pENBdf6Iq18ZA+Ijjiu2UjUrKTZb
5B0sPHEWDWuvrbty58bqh9YbkD9PVx8I8ssLqwWo8gQ1AEMv41EpLEuBsAnhsdaZ
0m9qCxm4mMCFuK3FM3Fb/c9vqBIoZz7rAPnz1EYhNq0Yan3w+BYhdv76E/qAeL/D
6PfQruyfHF4rLAGVSnw0Gc7jxneFEz8+w9L7tWXsGVqfpGi+wX07THMfw13gzZ9Z
WhCZVPYJuFmnZcVS6Ma/xi9cxdavfR0wWbMAyLVvepKw7RJDWt70IWTT96RzKFN/
9loUSznUogLfdmXBWgnfIxLG46sujulRQDzRdnfyfnDNPWqEw+Q2575b5I1CPTpF
10H4cgMLXoNxjKga2j9uzWk3JR/TdqL+Zs1Y/XhTt53xvvqBKtE=
=xCTU
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--
