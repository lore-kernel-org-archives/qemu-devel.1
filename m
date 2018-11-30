Received: from eggs.gnu.org ([2001:4830:134:3::10]:36853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSXeP-00082w-6Y
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSXeJ-0000ev-6L
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 20:31:24 -0500
Date: Fri, 30 Nov 2018 12:11:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181130011135.GG30479@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-12-clg@kaod.org>
	<20181128023902.GU2251@umbus.fritz.box>
	<dbd8810e-09b9-7344-92d2-faddebf30c10@kaod.org>
	<20181129010047.GM2251@umbus.fritz.box>
	<cde0bf38-a766-deab-8d46-41fa7e776185@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <cde0bf38-a766-deab-8d46-41fa7e776185@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 11/36] spapr/xive: use the VCPU id as a
 NVT identifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 04:27:31PM +0100, C=E9dric Le Goater wrote:
> [ ... ]=20
>=20
> >>>> +/*
> >>>> + * The allocation of VP blocks is a complex operation in OPAL and t=
he
> >>>> + * VP identifiers have a relation with the number of HW chips, the
> >>>> + * size of the VP blocks, VP grouping, etc. The QEMU sPAPR XIVE
> >>>> + * controller model does not have the same constraints and can use a
> >>>> + * simple mapping scheme of the CPU vcpu_id
> >>>> + *
> >>>> + * These identifiers are never returned to the OS.
> >>>> + */
> >>>> +
> >>>> +#define SPAPR_XIVE_VP_BASE 0x400
> >>>
> >>> 0x400 =3D=3D 1024.  Could we ever have the possibility of needing to
> >>> consider both physical NVTs and PAPR NVTs at the same time? =20
> >>
> >> They would not be in the same CAM line: OS ring vs. PHYS ring.=20
> >=20
> > Hm.  They still inhabit the same NVT number space though, don't they?
>=20
> No. skiboot reserves the range of VPs for the HW at init.
>=20
> https://github.com/open-power/skiboot/blob/master/hw/xive.c#L1093

Uh.. I don't see how they're reserved is relevant.

What I mean is that the ENDs address the NVTs for HW endpoints by the
same (block, index) tuples as the NVTs for virtualized endpoints, yes?

> > I'm thinking about the END->NVT stage of the process here, rather than
> > the NVT->TCTX stage.
> >
> > Oh, also, you're using "VP" here which IIUC =3D=3D "NVT".  Can we
> > standardize on one, please.
>=20
> VP is used in Linux/KVM Linux/Native and skiboot. Yes. it's a mess.=20
> Let's have consistent naming in QEMU and use NVT.=20

Right.  And to cover any inevitable missed ones is why I'd like to see
a cheatsheet giving both terms in the header comments somewhere.

[snip]

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwAjkcACgkQbDjKyiDZ
s5KoQBAAicg2y5MAn/1GplIbRQ5cNpo2KrwlyL+fp5Mx+PxXA9/m9/5ErNWVMI1W
mOAzyPbg59J4pjIIiXBk6iL9xE4J3RsQ0VebnoSsoxbZ0zXaLEA0C9j9vSClXNIZ
Nafh4SPwRxy5eGSu8y1JT6AC+VhhvQxiwW8B7WgwpGkCwT8U8H8hXxMsqswRwNoM
Bq8YBuf5RtJTslpF9t8t/slNR6qKVM1i7XxzjRxJzjHxT6yuPSHAJfC2+qdK64jl
TU2yr1SIFDr1WLoZiRlnYDHCEKJOFNF0LT6XdnSuHxqoMmgzhl33RZtY2r0m82Ty
+6U7CL6mkq2j7XpBqYjQpp2FDtPVh6cGeFMf7UdXehk5IU+QC1tJFUPycITL80uw
JyCEbH+Y0YOyakeDegxJArjqmDXnqbnAQEmHZHA57UH2/XUqJJ/Isj4RVGZ8G6V1
M9hY4eU9cUC3OysMN0JGhgJS2oT5QWHlVX2JLYBWCSdgzF/S152Oa5RBUujUbpDg
BWBYmPvfwtqsq2w10svtSWgI4zNXpCe7sjaaCszYpAaMwn2CZkJ242k9jNAtARpq
kzXSOwJZGpT+KTx37ie4CQkn4ggPo5JWB+g/aeGim6unJWlaYLSJx7S1YbO3DMCr
P0X5nLVDkr4VOadzJsKKazRmuHKWcwrOCRZl+fVufaQ7mrFrAbE=
=653u
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
