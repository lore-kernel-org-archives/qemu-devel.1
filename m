Received: from eggs.gnu.org ([2001:4830:134:3::10]:43269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV5cf-0004Nh-Sb
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 21:12:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV5cZ-0002OS-5Q
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 21:12:09 -0500
Date: Fri, 7 Dec 2018 13:07:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181207020735.GY768@umbus.fritz.box>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-4-clg@kaod.org>
	<20181206032535.GL768@umbus.fritz.box>
	<aa579a81-aeec-4197-1ea9-c6a7f995949f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w+MAdceOglSEzbpc"
Content-Disposition: inline
In-Reply-To: <aa579a81-aeec-4197-1ea9-c6a7f995949f@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 03/37] ppc/xive: introduce the
 XiveNotifier interface
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


--w+MAdceOglSEzbpc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 07:17:47AM +0100, C=E9dric Le Goater wrote:
> On 12/6/18 4:25 AM, David Gibson wrote:
> > On Thu, Dec 06, 2018 at 12:22:17AM +0100, C=E9dric Le Goater wrote:
> >> The XiveNotifier offers a simple interface, between the XiveSource
> >> object and the main interrupt controller of the machine. It will
> >> forward event notifications to the XIVE Interrupt Virtualization
> >> Routing Engine (IVRE).
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/xive.h | 23 +++++++++++++++++++++++
> >>  hw/intc/xive.c        | 25 +++++++++++++++++++++++++
> >>  2 files changed, 48 insertions(+)
> >>
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> index 7cebc32eba4c..6770cffec67d 100644
> >> --- a/include/hw/ppc/xive.h
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -142,6 +142,27 @@
> >> =20
> >>  #include "hw/qdev-core.h"
> >> =20
> >> +/*
> >> + * XIVE Fabric (Interface between Source and Router)
> >> + */
> >> +
> >> +typedef struct XiveNotifier {
> >> +    Object parent;
> >> +} XiveNotifier;
> >> +
> >> +#define TYPE_XIVE_NOTIFIER "xive-fabric"
> >=20
> > I'm applying this, but changing the string here from "xive-fabric" to
> > "xive-notifier".
>=20
> Ah yes. My sed command missed that.

So, I've now applied patches 1-5.  I think we've agreed to a change in
patch 6 which will require tweaks to a bunch further down the series,
so I think the rest will need a v7.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w+MAdceOglSEzbpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwJ1ecACgkQbDjKyiDZ
s5IEUxAAu7+Hc1Zkqn2czDEf5c0NSw4TKxW4Uq4/RkjOvJoUf3hhweIxgu11d3fa
+qC3W755msABtF5Ke7HQtWX+nGZPz9rMiN4bX0BbG3UeYZ4ybmlbDDQU2SxkoKKW
JTxdXc4I24MbMPwgMqkGO4etNc5aXotzGLzpfInaNdKicU61BzcnEeizXOcK6XM2
vOrBrPtsn6y109mMxRJxdEEzZ6vJaIHRSJI5NUDc1scIxZ/Dr2FVPt9vJbY9ns6+
YJ33xeGvpHZX9dAJPs7bkPS6t/o9QAwTw0BstfxaQBCZOVUTesgAzkCRwPEb3Bnk
j3QeEMDPkJU77HrQ3l3Uft9AZWkUyfYtVRX2wzPtI+FMtR8iDJeWPiKWDC/A1u+l
EFWaVsJiG/VPGHmR/sjA5A3B+sZrB8WdsuUVSu2foeNGj4+JBJuO/h4qMXoZQxWY
ZHJ6B/3bPBp4+gyMteAiyOp4gCz03u3Nf4yfWmzIV+TC0WKhoKk6pp+VlcnMihnT
7rt/t75B4VSC7RPAZEBlqvwC9++8zjqzqk8fkxCr8xTHTMmGSPOpewjN4GXEm47m
EW67yr1T0WvOnMz0SIjwZuvjw8BjQoLnXAQ7UoWUnnSsyq3/DqS/2/AhDG7HXBT9
5xjMAZQxVsb/JRxH/hLzos1FYR5R5TII/cB3nDvMqKAU+DoJbCw=
=QGSt
-----END PGP SIGNATURE-----

--w+MAdceOglSEzbpc--
