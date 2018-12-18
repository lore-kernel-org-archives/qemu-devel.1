Received: from eggs.gnu.org ([2001:4830:134:3::10]:50319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ6nm-0003vV-Pw
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ6j4-0001hm-Bx
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:11:26 -0500
Date: Tue, 18 Dec 2018 14:49:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181218034910.GF23604@umbus.fritz.box>
References: <20181214015520.20467-1-aik@ozlabs.ru>
	<20181217062133.GK5597@umbus.fritz.box>
	<20181218020924.GB23604@umbus.fritz.box>
	<1e2449a7-d89b-3ca5-db66-7da34ff59a35@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
In-Reply-To: <1e2449a7-d89b-3ca5-db66-7da34ff59a35@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v3] ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, gkurz@linux.ibm.com


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 02:04:54PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 18/12/2018 13:09, David Gibson wrote:
> > On Mon, Dec 17, 2018 at 05:21:33PM +1100, David Gibson wrote:
> >> On Fri, Dec 14, 2018 at 12:55:20PM +1100, Alexey Kardashevskiy wrote:
> >>> SLOF receives a device tree and updates it with various properties
> >>> before switching to the guest kernel and QEMU is not aware of any cha=
nges
> >>> made by SLOF. Since there is no real RTAS (QEMU implements it), it ma=
kes
> >>> sense to pass the SLOF final device tree to QEMU to let it implement
> >>> RTAS related tasks better, such as PCI host bus adapter hotplug.
> >>>
> >>> Specifially, now QEMU can find out the actual XICS phandle (for PHB
> >>> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
> >>> assisted NMI - FWNMI).
> >>>
> >>> This stores the initial DT blob in the sPAPR machine and replaces it
> >>> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
> >>>
> >>> This adds an @update_dt_enabled machine property to allow backward
> >>> migration.
> >>>
> >>> SLOF already has a hypercall since
> >>> https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
> >>>
> >>> This makes use of the new fdt_check_full() helper. In order to allow
> >>> the configure script to pick the correct DTC version, this adjusts
> >>> the DTC presense test.
> >>>
> >>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>
> >> Applied, thanks.
> >=20
> > And now, unapplied.
> >=20
> > I don't know quite how, but somehow this patch is causing aarch64
> > tests to SEGV.
>=20
>=20
> /home/aik/p/qemu/configure --target-list=3Daarch64-softmmu
> --source-path=3D/home/aik/p/qemu/ --disable-git-update --with-git=3Dfalse
>    --enable-trace-backend=3Dlog
>=20
> and
>=20
> make -C /home/aik/pbuild/qemu-localhost-aarch64-rel/ -j24 check
>=20
> did not produce segv. I am running this all on a power8 box + ubuntu
> 1804, what is your config?

Hm, curious.  I'm using Fedora 29 on an x86 host.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwYbjMACgkQbDjKyiDZ
s5KrBQ/4qmTEvbiKuBvbd8J9vyksvius+zcbZx6e95ZbwrteTjqEMdFse5T8nu3G
n50GeoCIlSJ3nVrO5CYRHWr/dnbXlr8oLa4xvYP+KGnTwlpTin8ojY91iDV9C+a+
ibwUStj44WJBthhvL9A7f48CDe61hnulw1c3rEKzPy1UAbCD9+k1PtSX/nsPmlZZ
Nwe7ga/UuO5hE6gBXDX0nIBN0XgVBvb32S1dES49uMLuGplXJQPPficcrJmdMbeg
Bq4H2BrJl6uzpofmQ1kyDgTA7OREdfsEZCmeNkkm9kIuaSCq9rbXtE37Sc7j+mWk
IDGfqRoBornRM6UT9ljUoZHx+qwYx4t/XT59fm7dyEbqpbpSHVzv+niVJ2acK4LY
1OxIaGytz7m8HK3x0jtcxw6c8zfof4xeXVbQL+eXlIoFvR9+opj+g8bOLlo+rgZM
SsNiqvG7mf6I1bR3EZZTACBCl/GYGMSZGFLpVsgE9tVa/3JY7t8kxYcCJtcffavE
6YCK/gEr+enKzIEtqxRLT89D1ENHWnRbgUzN3vN9aAlxP2kN2dDYAEbqO6zZY4yH
9AgG5fPksXZD6ix6u6MwXJLrjFjiAnYVx4SsYphIlYqa76N8LSfR6Q5h/GXWS2Sj
kwn7zb3VX4L7dM6o5u8UN4qwuM8WcO3hhotXRTjzhsuHMYvMyQ==
=gAd/
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
