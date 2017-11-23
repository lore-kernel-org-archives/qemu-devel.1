Received: from eggs.gnu.org ([2001:4830:134:3::10]:54760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHpS8-0005Ap-N7
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHpS4-0005QD-MS
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:13:56 -0500
Date: Thu, 23 Nov 2017 22:12:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171123111202.GD22454@umbus.fritz.box>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-9-clg@kaod.org>
	<20171117045412.GC26448@umbus.fritz.box>
	<54f87bb8-e502-fdc8-1069-2f6081e0d446@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <54f87bb8-e502-fdc8-1069-2f6081e0d446@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 08/11] spapr: introduce a
 XICSFabric irq_is_lsi() operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2017 at 08:23:00AM +0100, C=E9dric Le Goater wrote:
> On 11/17/2017 05:54 AM, David Gibson wrote:
> > On Fri, Nov 10, 2017 at 03:20:14PM +0000, C=E9dric Le Goater wrote:
> >> It will be used later on to distinguish the allocation of an LSI
> >> interrupt from an MSI and also to reduce the use of the ICSIRQState
> >> array of the ICSState object, which is on our way to introduce XIVE.
> >>
> >> The 'irq' parameter continues to refer to the global IRQ number space.
> >>
> >> On PowerNV, only the PSI controller interrupts are handled and they
> >> are all LSIs.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > !?! AFAICT this is a step backwards.  The users of ics_is_lsi() here
> > are in the xics code.  So they already have the right information
> > locally in the ICSState object.  Why on earth would you indirect
> > through the fabric.
>=20
> because I am trying to get rid of the fact that the current ICS=20
> allocator handles two things at the same time : IRQ allocation=20
> and IRQ type. And that's a problem because the ICSState object=20
> is just used everywhere in the code.

That's a good goal, but I don't think this is the right way there.
One of the reasons that conflation of allocation and typing is bad is
that the typing is essentially local information to the PIC itself,
whereas the allocation is a machine concern.

By using a XICSFabric hook you're essentially wiring the irq typing
through the machine, which again seems like a step in the wrong
direction.

> OK, So that's is not to your liking, I will come up with some=20
> other solution. Thanks for looking.

Sorry if I was a bit harsh; quite a few unrelated things have been
frustrating me, which has made me grumpy.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloWrQIACgkQbDjKyiDZ
s5IQ3A//Rd1DXensVzMGgknf08iQ89i3uqV25dLOreKJatsVQ4pLLv9xce8Khto1
/qb2lXxiyZpMZmGb3u7VQIuNbK20xpaNcfjWKYHdse8ofcPfhjBv9ISyyxQ0vTQ7
jM/J4pM+aE5Ywwm72yNZwWShulcIvUhH8p36ARKbLdMQylXSzvr2k/y/Ek3rj2yc
EvnHfdl2Wo0x64J4aHofXspEZNL4kA95NM+oLsZaewHnwym8pYwIWsX8nAs3d3Hb
0hmwHqj5siEMYFdbKwy8XaSanKtBb26dC9NOft5kCPIIQKNJKHQHKbkoFbedK2m5
QiWvgLtOwNM6Kpt5QsPNVBfeBMoE/abq8iorwPnDWwdKz2wmgT79+QaHnEkGFDTr
+LlIuwtZpXpCG7OFhQi6lHjeT/N+YPi72OwEYS0G4QtYoBX6TGmiZh6ESpEnekLP
+bYL3I5DCyKDKjp26Bv9i1+bsldiVtQsN92pcv7CCMIPzWqivifxLyiLAugfuJiC
JUXpSMeLoeHcnuxtlA3sNipEFdAoINB13jIXcGSk5jpPQ06WQQ1M28ZKmTK3RDww
ZlereiIPHolKPuwuGLLuqNn+2uhKd6RaiO79gCwzcKv+sbX1AEt8hEBkFEf2lgm2
A0yDbnH2P4FUzuXSw4QNZ05ntw8+qQZ+C9nhbKEYwqC2An+wgcU=
=oW/C
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
