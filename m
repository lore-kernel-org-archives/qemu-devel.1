Received: from eggs.gnu.org ([2001:4830:134:3::10]:50191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ6no-0003qQ-OA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ6j4-0001hf-BA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:11:23 -0500
Date: Tue, 18 Dec 2018 15:11:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181218041108.GH23604@umbus.fritz.box>
References: <20181217223445.28594-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Content-Disposition: inline
In-Reply-To: <20181217223445.28594-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v9 0/7] ppc: support for the XIVE interrupt
 controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 11:34:38PM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> Here is the version 9 of the QEMU models adding support for the XIVE
> interrupt controller to the sPAPR machine, under TCG only.=20
>=20
> The 'dual' machine, supporting both interrupt modes, is nearly complete,
> only remains the question on the qirq array, which will be addressed
> in early 2019 with the support for KVM.

Ok, I've applied most of this lot.  I think that leaves my next pull
request just waiting on the GETFIELD stuff.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwYc1wACgkQbDjKyiDZ
s5KUZhAA0h9a873BRuWGbkSWWt4rkfLC1M/Uy6anVm24IJulN/sRhkn8HRPHX4kB
gQDkEuRZR7G9aVDSD1Irq9GJqZO6CmgoS6mxuSrdFsPM7vz7Etac7fnzaUNSC4OR
8hEn9c1EvvQzAGJJKINjxA9392IhF2AE6k/oteMqrZd5mQLoEqe316mq6pCfHl+m
G9bXJIDnhkBvibfXHSbRypME0MuY8BctVXiLflw3/umuhFB00zmqVTu2iYWpT7RW
4OWP7ek5khkFpLUhryJqy5cqJZv54gktusgDoZ6HuIXwBVFcEAOl11EgjVTylUWP
3imIauBF94mZEEoAN4yVSRFoxbU5MVluwKpuL8BGjhLZ2uoHPC0uHfTFLeSApn+4
PTBzxxs1hzESyaWdN9FaIK/TTTwLqo7SnjxB2dRyrZMDgZkPao0aQ07o4gypAmfZ
OgXCNaI9jYnv3YxgS1utINeTjnIX9FC2SPLXmaE6SBLMLT/bg22qQWw2ZVNl9TAa
vXMEKUqDcQEqWLpbHFKIQha2BF9Y0pY6+dGmnZevopjUKI6aEXYpIFZVajqFo4X7
AmSCxQxLBjorKTomaWxcITebeVfElJKrv8pf56vF/WRD57FjICVzYOjSrJAZW11l
gI/atMH6F5crrag9fDrNP6J570LfhlHqe+aB6RBkiAlRAnQNUWc=
=ofIS
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--
