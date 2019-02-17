Received: from eggs.gnu.org ([209.51.188.92]:52481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi6-0008Al-Vh
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi5-0005aB-T4
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:02 -0500
Date: Mon, 18 Feb 2019 10:32:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217233221.GC2765@umbus.fritz.box>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023079461.1011724.12644984391500635645.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Content-Disposition: inline
In-Reply-To: <155023079461.1011724.12644984391500635645.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 02/10] xics: Handle KVM ICP reset from the
 common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 12:39:54PM +0100, Greg Kurz wrote:
> The KVM ICP reset handler simply writes the ICP state to KVM. This
> doesn't need the overkill parent_reset logic we have today. Call
> icp_set_kvm_state() from the base ICP reset function instead.
>=20
> Since there are no other users for ICPStateClass::parent_reset, and
> it isn't currently expected to change, drop it as well.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp7wMACgkQbDjKyiDZ
s5JAIg/9FrnLdWf6z6dUgm0jusZM8MjZ6CMlx1NQKfZCEaXVyLdYCytqfsXLb8kZ
/4CfNVmVEZwOXGFsqGK1TuU3mydNVZ9ffg5Cq/vPabFn48BUfuu0430rtoOYkM2n
IGSImP0cz7+zQOQlaSLt+s+a1Of4Je8MEPKMqi7uXal7TOxGfyZO6++U3TQy/qWQ
WDm6yt+R6xlgu06S2Ki2FqxA+o8iKM/ZRnxYCDuH5EqlBP2Wb1IlUbJcg6l/rf6j
upeb6ZBryXvY+h8UIzOeG4J1KjBEiT9ZNr5QYXQgsyPTyzmlVMre3jD9SzVAzo84
O8cNAirPh3cGsh3g4Z3bjYcFGL2h6VswgO5u2dLaNDOFLPte/oSZ9gzvDYkomyL4
DAhsBQUerpyxhSFIOU1qNL2URRzbgCs9/PyLudPW2EGsS7R9No31V1WhkKRscBhi
x/nZR+kih4qnFsPQXH7Lwd7TGSnEy9ZusGbKjL3KF1IxbQaCxlgRfLj1U6WaqfQe
4j9fe1OW2PHxHTQ2wpRJSyMue5+7bZmxb1mt3QMiKVcEXWwqNSAzSxAbTGQP+7ZS
kGHA4UtUzEeLPxTNYkS3FTviLXuUIEdqRTYnJdDzOtbOPq5MCwgxKXNk5K+0zEZ8
qvdkhiiu5lCo8wkvzOh8LHeSIgtyu9n1i5/4m8kmIjdvuUM+diA=
=7rSm
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
