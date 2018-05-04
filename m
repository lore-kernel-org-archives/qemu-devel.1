Received: from eggs.gnu.org ([2001:4830:134:3::10]:53834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUV-00022z-WB
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUU-0004BL-Vn
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:32 -0400
Date: Fri, 4 May 2018 10:11:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504001102.GH13229@umbus.fritz.box>
References: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a58rN+WbXIGauCK9"
Content-Disposition: inline
In-Reply-To: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 0/3] spapr: fix backward migration from
 POWER9 to POWER8 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>


--a58rN+WbXIGauCK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 11:16:10PM +0200, Greg Kurz wrote:
> Hi,
>=20
> It is expected to be able to migrate a guest started with
>=20
>      -machine max-cpu-compat=3Dpower8
>=20
> from a POWER9 host to a POWER8 host. It works with recent QEMU versions,
> but it is badly broken if the destination runs QEMU 2.7 or older.
>=20
> This can cause problems in cloud environments that still have systems with
> older QEMU versions, eg, hosts running ubuntu LTS 16.04.4 (QEMU 2.5) which
> are likely to stay around until admins could transition to some newer OS.
>=20
> This series was lightly tested, but the patches are simple enough, so I'm
> confident they shouldn't break anything :)
>=20
> Please review as I'd like these to go to QEMU 2.11.2 as well.

Applied to ppc-for-2.13.  As you say, these should probably go to the
2.12 and 2.11 stable trees too.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a58rN+WbXIGauCK9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrrpRYACgkQbDjKyiDZ
s5Ieww/+J6l5Gm2NmACi6RFiJ5ullsaHFL6xibvhzx0XVAEHtHzt9o4apHRNIwIs
Jp+F8AXpZcvsP//8XkXDxquTQ0BysM4MdX03BK7u2NS6Zjj0hBOUTi5w0hvY3VdL
rfxSQXIllbGA33ABVL3BbP8mOKZ4j6/1l3KPOyYtVEl+etH+HLyj6Zu7yiD/k66b
Skt5We6MZJt0Hhz4Tah1iRlnCt3D3E6xYJS3KTr0l+99FR8YL5nkAUd1fO3Z/pIp
LVonapbu+rbLJ7WcoSrawpKsvROVTB4zoLMZ6s9yHCzJjgptVYRI8Y9P5toWH2Ts
Atlit2sTbU0AqcAIcifipGpAZnmozwt5ZsMp0ZRl6+HaOKDb8jZW38u2pnk42NBU
mgJoJ4qi99ClqfyeXOnLTKnTadfnkkgWaH42JkqLkKCxS8DhFWw5ClTMKQ7pfOoQ
F5vV1hcrrLj7Flt8FxUsH0tiS6jDbLeqCf6pPXk9wgai9wjE9xTVg1OYz8hek6Yc
ReCAsv0utDriTmigk1raljSuiNC0rQ00JpDRSSmPTpAjlq0IAGab6gk5K0VYkcR5
eKb/kpaRWZh2UG4J30BIiA4OYHgBUp7cetJwtDvK6QaHeBvez9A5W8qqIEKMfAf/
KWDxTl7xG3myj8dMnkxi6Ar4kOFmMzY9tEwtyf9SRK/M0hFIn0Y=
=SGvQ
-----END PGP SIGNATURE-----

--a58rN+WbXIGauCK9--
