Received: from eggs.gnu.org ([2001:4830:134:3::10]:45033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvMce-0004T7-Tj
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvMca-0002MM-O3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:59:56 -0400
Date: Fri, 22 Sep 2017 21:49:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922114933.GU4998@umbus.fritz.box>
References: <87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170921053107.GD4998@umbus.fritz.box>
	<87y3p7nugc.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<e2ad1b05-0e93-5389-92b5-7d9ebdd273f8@kaod.org>
	<20170922101201.GG4998@umbus.fritz.box>
	<8cf3e77a-e397-c082-f1a2-b6b8c6be439f@kaod.org>
	<20170922112042.GR4998@umbus.fritz.box>
	<42a1f20a-09d0-f510-c3be-4062b7ffdafe@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KJvkvZqQCzHgjKcr"
Content-Disposition: inline
In-Reply-To: <42a1f20a-09d0-f510-c3be-4062b7ffdafe@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org


--KJvkvZqQCzHgjKcr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 01:37:39PM +0200, C=E9dric Le Goater wrote:
> >> well, it would be good to be able to define chips with different
> >> numbers of cpus. That is something will we want to do for sure.
> >=20
> > You mean multiple chips in a single system with non-uniform numbers of
> > cores?  Are there really such systems in the wild?
> >=20
>=20
> When CPU fail for some reason, yes. They are garded by the FW and next
> boot the system will have different numbers of CPUs on its chip.

Ok, but you can model that with max_cpus the full potential number,
then just don't have all of them on initially.  The basic topology
remains uniform.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KJvkvZqQCzHgjKcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE+MsACgkQbDjKyiDZ
s5IVVBAA1ToWICmYEE+QyYlFQYx0SZQ7jTYsT04+3H70CVrDw5Hqxw993fF3eVZO
gkc0ligN67yyQkZSU4UtDG9k6Xoq22by4N36PqqJ3FQTGvSdhzzqJ2AeN5GNnfZr
3AFMsUlXBbvr4rvTgwnaQ7bs1W+n0vBQumvveCPusUATAk5tUcGxpB1bi7S1213W
rG2ghy6shzwDF+KdwDP4tvwFuqIQGAW1ASiJxNPxVKx0kd2Evj5ssgG5aNAf6u7X
zpJwuaEMXZkpSJWSfiZdPQAGBC2qTirk7R6L5evlHIpv0uzIK47DGHZwHMldzQlP
Jdjj3JcmOPjLXRIFZijchPrDidudI9UniAIuxfAoWvzlt67tCKtGSWO7GSAGXi8B
kpPFtzy9kIbOq1i8kQiGrIwVHrIxHnoxv63is8TANch6UUg+bM2pI7oaPj9d+175
FMB+QABhTV1+2MBBKCipxgNIw11Xxllvq6uiEYROB/Kx0cTbbuOGt76qDwGm39K6
wQnjGrLm0ZShQ6vqsOodClVD4npDzmRgCyI9n703IK/+V7KmbZuvElGNFxH2Xq/V
kIT1H0h271qWlMs1Zwj3Ros+FOUwPrLf+sHIffbJOGJx8wd+dlXIgjRFYZcZBMfl
AdN+2+8TGN+ffHmjeyRtNyYF/4SEcWlHBAn3cgTIy6GRBORrqpg=
=iSls
-----END PGP SIGNATURE-----

--KJvkvZqQCzHgjKcr--
