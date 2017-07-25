Received: from eggs.gnu.org ([2001:4830:134:3::10]:54656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZpRb-0000qU-PI
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZpRa-00060F-KQ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:19:31 -0400
Date: Tue, 25 Jul 2017 12:17:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170725021749.GC9471@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<5ead830d-760e-3486-9287-c1243acad3ea@kaod.org>
	<b94d43ed-3d9b-2727-fb0f-8ffb2910aa00@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <b94d43ed-3d9b-2727-fb0f-8ffb2910aa00@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 04/26] ppc/xive: introduce a
 skeleton for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 11:26:13AM +1000, Alexey Kardashevskiy wrote:
> On 24/07/17 23:00, C=E9dric Le Goater wrote:
> >>> +#include "qemu/osdep.h"
> >>> +#include "qemu/log.h"
> >>> +#include "qapi/error.h"
> >>> +#include "target/ppc/cpu.h"
> >>> +#include "sysemu/cpus.h"
> >>> +#include "sysemu/dma.h"
> >>> +#include "monitor/monitor.h"
> >>> +#include "hw/ppc/xive.h"
> >>> +
> >>> +#include "xive-internal.h"
> >>> +
> >>> +/*
> >>> + * Main XIVE object
> >>
> >> As with XICs, does it really make sense for there to be a "main" XIVE
> >> object, or should be an interface attached to the machine?
> >=20
> > yes. There are internal tables which are very specific to the controlle=
r=20
> > and I don't think they belong to the machine.
>=20
> These tables belong to a CPU chip (die?) and we do not emulate these now
> (machines and cores are the closest) and since we do not want (do we?) to
> treat a core as a chip, the machine is the most obvious owner for these t=
ables.

No, I think it's reasonable for them to be owned by a XIVE object
under the machine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll2qk0ACgkQbDjKyiDZ
s5JQIxAA0giGqR9pPBnMhb0bwRhmKHLcyCm8ufws2PquzNfbWxr+yzswSb8hBfE/
HQlrBLfOY/nlPFDGATeh9PzAnhfECNujzEdpeq2aKg/uxgvHWD/fN1ZkiMvCdzhI
o4vMgT8KRr6ZcwUQ65iOB/Zu0sYOIyzl2F6KmF5xbq5VVLeDmIhUwnR9NAAuGwlh
yH1lhxcA7fJLHPu2u03mr35dTd3cwYZFYA86YNB0gz+g2VRy3CJUDhOZkoUyx599
+vqEbJqO4IekCnOSeGO/UZDHIkhzNij2PnVtC93jrYBfHi52rwyWL0Kb0ZnqXccn
MXvs1BUS61R/0xQLhk084oQuMeJfBqomZbx6VqOy3bkgorG33709s2Bj0vc2RePj
MQzxb6TFjPeTvitc3PmgLFWI4NppDOm/isuswoDDtCJV8iMp3rSOBvtluSTQFzb1
uwmMY2ECgLTnKAkF8fwfc58xMAkDrLS50gpRlqhgTOHWqXSxiNMxB7Nlbbh9cjYP
l4kRTtsP2tkViHGY5ZiaQ0ULU4f5q+9tZ9MDmjloYt3ZBsAXEUjuX8kbtdBTGLdq
Aw33iqz59O+ULnXjUTB8zAICgvdaj6WDoYat5raON5AmovfI5m8KEuSy6giXIfWH
r0Af+1wstaR8J6Me8ccBGCcTHUVzxXsq/RuvAuIeWzF5IJdk6Os=
=y6PO
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
