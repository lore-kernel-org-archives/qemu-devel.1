Received: from eggs.gnu.org ([2001:4830:134:3::10]:40886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR6OB-0002Ze-0z
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR6O7-00081U-O2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 20:08:10 -0500
Date: Tue, 19 Dec 2017 11:37:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171219003703.GF4786@umbus.fritz.box>
References: <20171218092024.21645-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
In-Reply-To: <20171218092024.21645-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH 0/6] spapr: Add optional capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: surajjs@au1.ibm.com, groug@kaod.org, lvivier@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, abologna@redhat.com


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 08:20:18PM +1100, David Gibson wrote:
> This series is a first draft to add the notion of optional
> capabilities to the "pseries" machine type.  A default set of
> capabilities is selected based on the machine type version and
> selected cpu model, but this can be overridden with machine
> parameters.
>=20
> The purpose of this is to get rid of a number of places where we
> implicitly decide what features to advertise to the guest based on
> capabilities of the host.  This is bad, because it means it's
> difficult to be certain if machines started at different ends of a
> migration really match from the guest's point of view.
>=20
> By giving the user explicit control of these optional features, then
> validating that the chosen ones can be supplied on the host we make
> behaviour more predictable.
>=20
> The more specific motivation for this is that POWER9 has bugs in its
> hardware transactional memory (HTM) implementation making it unsafe to
> migrate POWER8 guests to POWER9 if they use HTM.

I've fixed the user-after-free bug Greg pointed out and merged this
into ppc-for-2.12.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo4Xy8ACgkQbDjKyiDZ
s5LIsxAA0bKDvnqA2M4OGTR0RHfMGCLxGbI7NQpPAhd8JdDq6ds2RC0jDwZOPLtF
pDFgf72WgSD3rXnLNuV2CUzRmHlokr+kzxMjzpGh12yPrOxjSsc3El75n7zAQAk7
4dtoC8SzCAz6fNfAh0vIe57eY5LlceY9N+X3Q2EBG3mDtNJSCLpK7abgN0ycujIN
fDOJvLJq3MHe1G+dBvy795dPNEGthZBOeg3eV2d1aI3XZWl7gya4wOIxUmzu0PK/
isU5vnX+RVPcqMnl+vpXli9C0lBb73fZStlIKeZBzjp0j0tqf6I+Aai8Qv11b5Gv
P33sxKtDlQHESIpmATpk5RAC4ajKxEZovi9PQYw93KmndePYJn0+r7ZfzqpktHaB
izKVk5jaZOzqd6Fg+LWUOZb3fcpSAmD0iVDTlrvErBrrFzfnt0ZN3bC+WC2qP96y
iqp4Pu0xr4xR7peBB0lBjcmwf8q+lDAgbrUy0kdotmvSxTzWXAcwptmgXZ8vdEWf
KSasVEk041MgtiDX5aySl1pf1zpsuWmKOLg755m9M4JSRm/W+Wa3KDauSKt+41LP
NzUFLsLAB7bKKPCP05IjPLAGIBJjhq4mFk52AeaLlEFIqGx3juL9mx/j2lWL8gsV
j3rsmJhem1OI6IlH5CN+sugqrAR1lId4m8FrWP6egzbtX/SzOkI=
=TKn7
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
