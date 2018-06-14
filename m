Received: from eggs.gnu.org ([2001:4830:134:3::10]:47756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTJJv-0000qH-RI
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTJJs-0007eV-Pu
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:53:11 -0400
Date: Thu, 14 Jun 2018 13:52:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614035207.GK3042@umbus.fritz.box>
References: <20180614010446.30854-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2WS97oupGEGbYNpW"
Content-Disposition: inline
In-Reply-To: <20180614010446.30854-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCHv2 0/7] BROKEN,
 SORRY: Better handling of machine specific per-cpu information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--2WS97oupGEGbYNpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 11:04:39AM +1000, David Gibson wrote:
> It's moderately common for a machine type to need to keep track of
> information that is specific to the platform it implements, but
> per-cpu.
>=20
> While it could keep such information inside the MachineState, this
> makes lookup from the CPUState awkward.  So, this series adds a
> standard way to stash machine-specific per-cpu information using a
> void pointer in the PowerPCCPU object.  The machine is responsible for
> alloc()ing, free()ing and (if applicable) migrating this state.
>=20
> The meat of the series is the last two patches.  The first 5 clean up
> a number of minor uglies I encountered while implementing.

Oops, realized 7/7 is totally broken on a KVM build.  I'll send a new
spin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2WS97oupGEGbYNpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsh5mcACgkQbDjKyiDZ
s5IoIA//VPfykZYRqJGwK8DnYPwH665Yd+4RcNK+5K4s66/WlzT8HyaBGVNldQ/9
h8eu4leqvDrEmg7hci5SLBxKUgHW6khd77xn8dGhFN8eEUc2pGQOc8miS88G5aaK
2UKkmDlBEhxTwSlFPtxwVE+Kag03jn0rApguYDkVClq3Rt1iBARdXKFDMIU/SmLH
htiT3XNrWaU6D157HxOAQbSe1IVVt1JJlzXLqpN+xi1MGta6k9TYNqfyqQ09FCTV
GKRqmvR/T+GoGMeSnW7u1APwdqA49Rdsx+qyGs+WHguliUcthma+K4wQVT5OWXcG
6agZ/x4IOeMfBjjuRbGAxKNX4isPXr/z/TTcelsBtQenZmWVTBtuVHSDX+nUhLzI
tHuVTWVrfIC9q00j9ZRgBDpXpc+zk5vMCHELhrhBUyKNfP4tMX5/Nu1SfdJU8fL6
5Y3VNnVbopSc/I6F4UZa5Nj7KflCpC4lbc5DMrfycaPuGBuaXtxQ0Nwyi3G6Lexm
vAzbX7L5q80zTHk2FXpOiblqaiWnep6Hz8YI2kNiJyuNANgVRhBpWIVmh1xJnPcm
UpdR/PuMze+u5inAReriGGnWtgGhXRm4s2D+Y81lc4vU1H6kkoMkKHLVZVQxPK1Q
gnK+DbMYIlyrXQ0HERTt74+iiO6VaUNrbBxCv5bLt/bmfZojlog=
=rpm7
-----END PGP SIGNATURE-----

--2WS97oupGEGbYNpW--
