Received: from eggs.gnu.org ([209.51.188.92]:47792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqtgw-000705-DZ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 00:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqtgv-000850-90
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 00:54:42 -0500
Date: Tue, 5 Feb 2019 16:41:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190205054147.GJ22661@umbus.fritz.box>
References: <20190201185358.6972-1-ppandit@redhat.com>
	<20190204010904.GD2593@umbus.fritz.box>
	<20190204101005.GC1905@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline
In-Reply-To: <20190204101005.GC1905@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: add host-serial and host-model
 machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 10:10:05AM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Feb 04, 2019 at 12:09:04PM +1100, David Gibson wrote:
> > On Sat, Feb 02, 2019 at 12:23:58AM +0530, P J P wrote:
> > > From: Prasad J Pandit <pjp@fedoraproject.org>
> > >=20
> > > On ppc hosts, hypervisor shares following system attributes
> > >=20
> > >   - /proc/device-tree/system-id
> > >   - /proc/device-tree/model
> > >=20
> > > with a guest. This could lead to information leakage and misuse.[*]
> > > Add machine attributes to control such system information exposure
> > > to a guest.
> > >=20
> > > [*] https://wiki.openstack.org/wiki/OSSN/OSSN-0028
> > >=20
> > > Reported-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > Fix-suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> >=20
> > Hm.  This seems like it might be overkill.  I mean, obviously we need
> > to not leak that host information, but it's not clear we really need
> > these properties at all.  They're not specified in PAPR (contrary to
> > my previous guess) and it's not clear what actually uses them.
> >=20
> > I'm wondering if we can just ditch them entirely, or at least make
> > them default to not present without regard to machine version.
> >=20
> > Yes, that's technically a compatibility breaking change, but it's hard
> > to see anything that actually relied on these as not being broken
> > already, so I think that's actually a fair trade off for the security
> > improvement here.
>=20
> We cannot assume that no one is using it.
>=20
> In fact this issue came to light precisely because a person on IRC
> was asking why x86 couldn't provide the same info as PPC, because
> they found it useful on PPC.

"Found it useful" is not the same as actually relying on.

> So we will definitely break people if we remove this from existing
> VMs.

I don't think that follows from the information you've presented so
far.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxZIhsACgkQbDjKyiDZ
s5L5Zw//aHoI3DdZsqRTcRc7GieR2OdNTw5i+tN141J4Wmn8a8LBIbs0ZsRlcS2I
HhSgiHCyP+MAaLS0/XSULusHkb4hkxUdmnHhIw46mS9hZCW09bsrhYOc+vcYZsrv
ziCnfJv5UBQs1xIgXbtLdBi3GTO6PpmHakhuD4OIilmR0GyysolHtXtojEoI+WyO
F1QjCotZTLOeJx90i8iK9ZHjjzFW9Rp9QDlsZ3/O6nHNoC+FK+bBaLeseos65Iln
S/VESBzj/P1aWL7x/DWtCAeKv8e0z8F0ppEwcKBGMRiyCaSqiFb49UyrFx2ZXOIS
eukV1ne8cC0cTBIVQKIWD4ygZRpxdqIvDtCIJpvi9vjzcEuS9nkQULzTL8bBGzaf
AIu0Md0rXcOfkPGh9UEyIol4feZceVOitiqbjT1p31JgTYhQkZNk48Lsen1eFAmD
P6RZ1n8USH7NrDxxq2Ci////A7h/0j0mpEGwwls8B0rTKZJXonJQN6+4YaR+HlO7
j+QG7lbbgVJ37FXcbv74SSHDoFjbgJN1owNqFPkY0sBrJEGaoVIVR1vQDwHrg0MG
3nIfOG5x16FNV/CQcUP5QKVqesf4AdO/9ayTkAk90qlbrPqtvMoBfZ1HZilhN7OC
OufiR+aKu7WRjhiUsz1HtGd/sIK+eOouzRVzV4dzeuA0BUxpwYs=
=YymM
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--
