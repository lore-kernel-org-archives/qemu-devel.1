Received: from eggs.gnu.org ([2001:4830:134:3::10]:50715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKH1A-0005PI-SL
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKH19-0005cB-Jw
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:04:12 -0500
Date: Thu, 30 Nov 2017 15:28:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171130042857.GA3023@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-11-clg@kaod.org>
	<20171128063827.GP11775@umbus.fritz.box>
	<e9b1f002-671b-7ba5-2b5b-34715d63585c@kaod.org>
	<20171129045941.GH3023@umbus.fritz.box>
	<512a0e63-43c1-bf8c-3060-66ab52bc054f@kaod.org>
	<c620afca-f6df-b3ed-8317-c805ec66b31b@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huLXOlJ1ghGp/P5+"
Content-Disposition: inline
In-Reply-To: <c620afca-f6df-b3ed-8317-c805ec66b31b@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 10/25] spapr: add MMIO handlers for the
 XIVE interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: "list@suse.de:PowerPC" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--huLXOlJ1ghGp/P5+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 05:23:25PM +0100, C=E9dric Le Goater wrote:
> On 11/29/2017 02:56 PM, C=E9dric Le Goater wrote:
> >>>>> +    switch (offset) {
> >>>>> +    case 0:
> >>>>> +        spapr_xive_source_eoi(xive, lisn);
> >>>>
> >>>> Hrm.  I don't love that you're dealing with clearing that LSI bit
> >>>> here, but setting it at a different level.
> >>>>
> >>>> The state machines are doing my head in a bit, is there any way
> >>>> you could derive the STATUS_SENT bit from the PQ bits?
> >>>
> >>> Yes. I should.=20
> >>>
> >>> I am also lacking a guest driver to exercise these LSIs so I didn't
> >>> pay a lot of attention to level interrupts. Any idea ?
> >>
> >> How about an old-school emulated PCI device?  Maybe rtl8139?
> >=20
> > Perfect. The current model is working but I will see how I can=20
> > improve it to use the PQ bits instead.
>=20
> Using the PQ bits is simplifying the model but we still have to=20
> maintain an array to store the IRQ type.=20
>=20
> There are 3 unused bits in the IVE descriptor, bits[1-3]: =20
>=20
>   #define IVE_VALID       PPC_BIT(0)
>   #define IVE_EQ_BLOCK    PPC_BITMASK(4, 7)        /* Destination EQ bloc=
k# */
>   #define IVE_EQ_INDEX    PPC_BITMASK(8, 31)       /* Destination EQ inde=
x */
>   #define IVE_MASKED      PPC_BIT(32)              /* Masked */
>   #define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to the=
 EQ */
>=20
> We could hijack one of them to store the LSI type and get rid of=20
> the type array. Would you object to that ?

Hrm.  These IVE bits are architected, aren't they?  In which case I'd
be wary of stealing a reserved bit in case of future extensions.

I'm wondering if we want another word / structure for storing
non-architected, implementation specific flags or info.

How does this work at the hardware level?  Presumbly the actual
hardware components don't communicate with the XIVE to request edge or
level.  So how does it know?  Specific ranges for LSIs?  If that we
should probably do the same.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--huLXOlJ1ghGp/P5+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofiQkACgkQbDjKyiDZ
s5KyFBAA4/T5uvwX3/z2oh9dDzv+8n2q50diFac0JzsiU3uF98ljZWzAkNgVwBry
v97EBuwXbnJwvIedt/dYDLRMbz57KQ4+PFI4BmXmz3Td2HBc5Gr6Qfr61xCuJLQn
GsBZH35WNOH9WU/xvAmEHZRnBaRbaaVw2VssAO0Ly90DR4jRF76sSsF8ZZiYP/+e
FM7zQMo1FrEqG7hEJzxiEHzvH6rSXbB5IICqPnwkoVLmOVnBWuZmHKuYF5OmtcEz
D5avD8bTItHDHRf1EZ4AIWtbRw7H5d17xUx1OI2yyjsVgPg1LUDFXD7rjnxVrJ/O
OVjDQtonbW4dXXMsCi/Ih44873vek9Fln9mYTtcV8effm/wSa1VMzULzg9yiG+4S
UZoE0Kok3M81sOCUdn2EUU5cvAwPaNemA+BWPANxTsiF3zCf/aKS0nQSxcqU/fqU
LYIX7hRqJ6Xz6bi219ZwKZL6m4SiQ5znaH3ahKDrOZnDdz1i6KXKcZebW1MI0sRO
2LPSV2mCSyoGS14N4hHNbXCKhwhnn+ozPclpfTzXzl9JOYbtnz63AZ+GRwk+dBDD
IRMydkK3VmCArvtcuCnD1aAPWjUf+Ny7K3Tjd9psQqgCcV+Zp4usTMfb6Z/30l0X
WkC/FW/w/cA5YQz4trCjeEO129JsvdODepEmmLz+u+j/8gzlte4=
=YHsg
-----END PGP SIGNATURE-----

--huLXOlJ1ghGp/P5+--
