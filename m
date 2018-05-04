Received: from eggs.gnu.org ([2001:4830:134:3::10]:35296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fERCH-0007bv-Bk
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fERCG-0001mY-9A
	for qemu-devel@nongnu.org; Thu, 03 May 2018 23:15:49 -0400
Date: Fri, 4 May 2018 13:15:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504031538.GQ13229@umbus.fritz.box>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-63-git-send-email-mst@redhat.com>
	<20180504001701.GL13229@umbus.fritz.box>
	<20180504054007-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lYtTbTuCUQxZgETo"
Content-Disposition: inline
In-Reply-To: <20180504054007-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 62/67] kvm: use include "kvm_ppc.h"
 consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--lYtTbTuCUQxZgETo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 05:44:02AM +0300, Michael S. Tsirkin wrote:
> On Fri, May 04, 2018 at 10:17:01AM +1000, David Gibson wrote:
> > On Thu, May 03, 2018 at 10:51:42PM +0300, Michael S. Tsirkin wrote:
> > > Some places include kvm_ppc.h, others target/ppc/kvm_ppc.h.
> > > Let's be consistent.
> > >=20
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> > One of your earlier patches in this series moved to using a full
> > target/ppc/whatever.h for includers outside target/ppc itself.  So I'm
> > not sure why you're standardizing on the short form here.
>=20
> It's not a short form. The specific header is kvm_ppc.h.

I don't see what you're getting at.  Just a couple of lines below in
the context we have #include "target/ppc/mmu-hash64.h".  That's in
exactly the same directory as kvm_ppc.h - which does it get the path,
but this one doesn't?

> That's how
> most files used it so I selected a location minimizing the churn.
>=20
> I also don't know why is it kvm_ppc.h and not just kvm.h.

Neither do I, it was like that when I started work on qemu and I've
never had a compelling reason to change it.

>=20
> > > ---
> > >  hw/ppc/spapr_cpu_core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index 94afeb3..312d6ed 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -15,7 +15,7 @@
> > >  #include "qapi/error.h"
> > >  #include "sysemu/cpus.h"
> > >  #include "sysemu/kvm.h"
> > > -#include "target/ppc/kvm_ppc.h"
> > > +#include "kvm_ppc.h"
> > >  #include "hw/ppc/ppc.h"
> > >  #include "target/ppc/mmu-hash64.h"
> > >  #include "sysemu/numa.h"
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lYtTbTuCUQxZgETo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrr0FkACgkQbDjKyiDZ
s5IAfRAAlWO61dfSnAwItbSOiGP6vCuR9erpspWdH9yIrUNKWaZxI8np3xicTcy2
1ztGUOgp7CuWGwQS5I4o6znzOHelGeSmxn1/uIsYKExG+4T2zhvQAFHlHG+GEzyb
1MNprV/JlY+yMtMYVqExoOfciERMc+oDKtlXV6OSYG+Y7RpjNgU5nxu/cT4dkedm
u33OBQ1kpfIrCvjUjwMkxLoz0djkTGqKPRfQqCpPmpGSOAVbmB7yJG4kPQx0eEgp
UTkL5SSMilINaXvEdWoYmbp54ID9c0HAy+ZkB7LY255xkCciLzC5RZTw7HW19zNl
kNwdiizNmrui5WGzNGXUVUsjGfTECogECFnuMqIuyvxGFOdiy1h4nL0ia7RfGi7D
v/SOSPRuvdVbNWSSzDCsZyEMekj+q62JpqRlJxLKFGM3OHQXnuSxIZs+nPqzLSJb
94I54jxelftI40OrQB/wIyGSN6z1M6tabw3L36yOS8PbO5A5Aca7p7kT1pEM6PC/
wNf2nyzJZOMuXRrB+I2xJgzHhU3CZ6h5IfpOngRFzK0yGYa/dbfvtuZrJ46rDQ2t
xZtflX1xSv4azQ4KojVLbm7lLbolQQ3lCXwM9n6y5HzUp6EUQPoiHMIcPhMOrkCY
04GnEwx8IWwP/IQNYFn9SNU3kOdJKMLtkxeW2wOVb1XRhvSDhZA=
=ERZq
-----END PGP SIGNATURE-----

--lYtTbTuCUQxZgETo--
