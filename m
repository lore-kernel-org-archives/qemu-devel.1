Received: from eggs.gnu.org ([2001:4830:134:3::10]:38766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdT5l-0005wn-JV
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 21:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdT5k-0003a7-7z
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 21:43:45 -0500
Date: Tue, 14 Feb 2017 13:43:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170214024331.GD2169@umbus.fritz.box>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486636445-24109-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170210001035.GJ27610@umbus.fritz.box>
	<87k28yekze.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <87k28yekze.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 5/6] target-ppc: support for 32-bit carry
 and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 09:49:17AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > [ Unknown signature status ]
> > On Thu, Feb 09, 2017 at 04:04:04PM +0530, Nikunj A Dadhania wrote:
> >> POWER ISA 3.0 adds CA32 and OV32 status in 64-bit mode. Add the flags
> >> and corresponding defines. Moreover, CA32 is set when CA is set and
> >> OV32 is set when OV is set, there is no need to have a new
> >> fields in the CPUPPCState structure.
> >>=20
> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> >
> > Um.. I don't quite understand this.  If CA always has the same value
> > as CA32, what's the point?
>=20
> I am not clear either. I think that as CA was set for both 32/64-bit
> mode, that couldn't be changed for backward compatibility. CA32 should
> have affected only the instructions working one word variants.
>=20
> Re-scanning the ISA 3.0, found this in 3.3.9 Fixed-Point Arithmetic
> Instructions:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> addic, addic., subfic, addc, subfc, adde, subfe,
> addme, subfme, addze, and subfze always set CA, to
> reflect the carry out of bit 0 in 64-bit mode and out of bit
> 32 in 32-bit mode. These instructions also always set
> CA32 to reflect the carry out of bit 32.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Which is conflicting to what is said in 3.2.2 Fixed-Point Exception
> Register:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Carry32 (CA32)
> CA32 is set whenever CA is set, and is set to
> the same value that CA is defined to be set to
> in 32-bit mode.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Ok, I've had a look at the ISA and discussed this with Michael
Ellerman.  We think what's going on here is that it's using some
unfortunately unclear wording.  When it says "OV32 is set when OV is
set" we think that means "OV32 is updated when OV is updated", not
that "OV32 is set to the same value as OV".

So although they're updated at the same time, the 32-bit variants can
have different values and will need real representation in the CPU
model.  Well, at least in 64-bit mode.  When the CPU is in 32-bit
mode, I believe they really will have the same values.

That would make your implementation suggested here incorrect.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYom7RAAoJEGw4ysog2bOSGeoP/j/DyB4LMWxlMOvvesDPOm44
gv+YR6y8jMJxoGOtRS+VjKAavNG4IcWkQKXJtbjp74bC4WVKdUlMLkoESPlNCSNn
E7vuOqm/kPI5r6cYk/5KjEPeINj4yQc3SCrwMoqpwoNmwWW/xNnoRN7NPkQpapte
N+ITbUIZSMMG4j7looh66fEa/Qb79bZ78YJPJXlDmzXppja4dzA4K6vK4KO9bLty
9csP03D9F8JRSBzhGp6PCQLWfdCN+SM30db0eNLQ/hJ6ye9Xr3n1Rhv/b8gldUuS
Qg8kBe+T+Z0uajfwkv20hmb5zVjfFc5vNfjoZiA2UtCrbQ/IXLosu5tKypbfuyB4
UKxNXnocVA4ieOvLLjWih5jKsG1h7e8fwWJwN7DzB1A3ePwXJM2JwWW1BPawOFbF
+iZtjh7iEHiSDYhFRCLVfPFvmCy1H39QW9Q3MAO+e6BS/bo6izUHyoaCi83wKb/Z
xi+cmaDn6u9ycsXWWdEMYWMdF0dGrVMl3rrcg9FjB5W4FO+4aUw/pENK1HzKbUCh
xHln71ZEYzYNWJA1j9Q7+IokFdNYJ/1kcBaXTUtkKeRZaFQ7kP5sQNUxK27VWsAs
CaRRJyFpK6lhAxBBymVSIZVaDSqdkHJM8MtCC2vpNtUF1WmbEkj8nFnJx1Cqn3Yw
GgrTK9LJli7/RizQ+sC8
=Cfci
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
