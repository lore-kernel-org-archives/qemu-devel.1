Received: from eggs.gnu.org ([2001:4830:134:3::10]:43476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dnIEO-0007hd-BY
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dnIEL-0004Lj-6N
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:41:32 -0400
Date: Thu, 31 Aug 2017 14:16:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170831041616.GJ3386@umbus.fritz.box>
References: <20170830182141.19996-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <20170830182141.19996-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 0/3] hw/ppc: CAS reset on early
 device hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2017 at 03:21:38PM -0300, Daniel Henrique Barboza wrote:
> v3:
> - split into 3 patches, first 2 are fixes that are independent of the
> reboot code that can be applied separately:
>     - patch 1: spapr_drc_needed fix
>     - patch 2: clear pending_events on reboot, following David's
> suggestions on the v2 review.
>     - patch 3: CAS reboot
>=20
> v2:
> - rebased with ppc-for-2.11
> - function 'spapr_cas_completed' dropped
> - function 'spapr_drc_needed' made public and it's now used inside
>   'spapr_hotplugged_dev_before_cas'
> - 'spapr_drc_needed' was changed to support the migration of logical
>   DRCs with devs attached in UNUSED state
> - new function: 'spapr_clear_pending_events'. This function is used
>   inside ppc_spapr_reset to reset the pending_events QTAILQ

Applied to ppc-for-2.11.  The first two I'm also considering sending
off for the 2.10 stable branch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmnjY0ACgkQbDjKyiDZ
s5JrmA/9EW4B5g14k7MdGg9gHhnS9lB6wHMqIBa63PK+PHcD3vGPLSLC7T8AbWWm
UWQs7NXDzhx6e2sAhDL2ML7LfTTiZJBQuiYogU3wUYOBvvwDIs5kFtKbWxk8awXL
sb8jtNJyybZ6KHDWe6E3ct/S3dlIyRkdeDlxxi+wTgD/6+DTR+etahP2NMC17o1S
VA8VdCs34SPIMW5hwzYuJfjbjFi1NTKdGw2gMXF7Fr+LEAHD7HX1BXqQ7U49cylq
LDsIfZWNszAVywgRtzQW0FTTHQFlIoTnMxuLtzm55axk7agcBEzwrNZHSztRrQy7
AZmdoIpd4v0W5Llq5phTs7hNWQN+ayT3KZ4sZmwOc10OjuyL/jVWhuM0PqYGgH/V
2XyWDzc2L2PMc7Eo6FZlTikOUG/KXG+G6tKFqQsfOmRPOttIGSuZvZVNDIZsGFkY
yRsNcj5zkDDBeKyXk+Y1TQ0wGI6mOO6Adf4UAR+0+p/X1jrgG6jcTq5oMvlhN3Jb
QwCh1f7xdJc0+N6scmv6XXKKWbCnLSIH5qQ5E2/OTqEuQpwg6D+ZvfTBPUKxvz0d
IznoMAH22M0kDLNQ/0vh4M5+5RTqQxQBpbnVfKNT4rFnLN1nNShExWHYAx7HL/n8
kd3uXx5EWSu+fdsqeS9KF1pg8wTBX4s2emoMRnr3odx5YBzcY0M=
=gYlo
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--
