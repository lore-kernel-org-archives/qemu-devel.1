Received: from eggs.gnu.org ([2001:4830:134:3::10]:38232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9UYa-0002JO-BO
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 07:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9UYW-0001U5-DW
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 07:50:24 -0400
Date: Fri, 20 Apr 2018 20:48:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180420104826.GR2434@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-5-david@gibson.dropbear.id.au>
	<20180420111627.53428980@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Isdj7O9hWi8F9Bn"
Content-Disposition: inline
In-Reply-To: <20180420111627.53428980@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.13 04/10] spapr: Set compatibility
 mode before the rest of spapr_cpu_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--/Isdj7O9hWi8F9Bn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 11:16:27AM +0200, Greg Kurz wrote:
> On Tue, 17 Apr 2018 17:17:16 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Although the order doesn't really matter at the moment, it's possible
> > other initializastions could depend on the compatiblity mode, so make s=
ure
> > we set it first in spapr_cpu_reset().
> >=20
> > While we're at it drop the test against first_cpu.  Setting the compat =
mode
> > to the value it already has is redundant, but harmless, so we might as =
well
> > make a small simplification to the code.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Ta.  This one also doesn't really depend on the others, so I've merged
it into ppc-for-2.13.

>=20
> >  hw/ppc/spapr_cpu_core.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index f39d99a8da..2aab6ccd15 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -31,6 +31,11 @@ static void spapr_cpu_reset(void *opaque)
> > =20
> >      cpu_reset(cs);
> > =20
> > +    /* Set compatibility mode to match the boot CPU, which was either =
set
> > +     * by the machine reset code or by CAS. This should never fail.
> > +     */
> > +    ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abo=
rt);
> > +
> >      /* All CPUs start halted.  CPU0 is unhalted from the machine level
> >       * reset code and the rest are explicitly started up by the guest
> >       * using an RTAS call */
> > @@ -43,12 +48,6 @@ static void spapr_cpu_reset(void *opaque)
> >          env->spr[SPR_LPCR] &=3D ~pcc->lpcr_pm;
> >      }
> > =20
> > -    /* Set compatibility mode to match the boot CPU, which was either =
set
> > -     * by the machine reset code or by CAS. This should never fail.
> > -     */
> > -    if (cs !=3D first_cpu) {
> > -        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error=
_abort);
> > -    }
> >  }
> > =20
> >  static void spapr_cpu_destroy(PowerPCCPU *cpu)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/Isdj7O9hWi8F9Bn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZxXgACgkQbDjKyiDZ
s5JYrRAAsyfjWPG1q4Up5jJT72Oc9kHToKMFT+ClNaQNn3OGt7EVJgrCTq5KkGVV
WIQJRT7e+fRZjRC9VWQ3g4glXZm0iDasdWDbw+QC1IQe4qzmjkmYv0z1zhFsTW0s
VHXF4GWJZZBFbg2sGehlLAJlGh2lkLSPuKHXSHhkIQiEEjYStSKbGR3nSlB6XITy
ZSB9o1YGyVyufv9B1oG70VqoHN1nBPFp+pv3b62ZEkaO7MXlLXM894Y5L2HPn3TI
U/J220hZI0rTMY4gIM/1Lje5p2KfQnY+ioQKrMYxPWHrfdCXprQqLbfF3cCn5CiK
AIfTNXgtV+ssWK/AewkoZ8mItqpfJ6l2Z5dcka09MRv5z5p/sDjSAa+MCdekpf3B
T5wUkDFk9oxsQbZQ6qGiJ1bgM344hu+IZ4nuT3Qsqd4N+iarPkMNs1iXwsArWm7K
pTagoSzWnAwy43cmB0Vj5ecm0Pg7FjWsuAcEY13zg5b9Sa/Yy0YID5YBUI93bpE5
GiBMQ+ZbynpTlRAam4IOvaGocEaIwPP3BJFR/ePjsa7RnJpQR02LI8Bu0qgKtQ9f
1V00/2Rgji5Y2ZFm+Fi0MoRXPWXAeyJmp0sFwtB7fV2s5lMFF/ALvvfnzBqLtm9Q
BVIv6FfxX8THt6Ccm78gPQurNSpQu5w4CMfv3e8UU1jDtE47TaM=
=2YfJ
-----END PGP SIGNATURE-----

--/Isdj7O9hWi8F9Bn--
