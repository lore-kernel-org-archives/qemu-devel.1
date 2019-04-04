Received: from eggs.gnu.org ([209.51.188.92]:38035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hCBft-00017p-Fc
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 19:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hCBfs-0007av-7m
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 19:21:37 -0400
Date: Fri, 5 Apr 2019 10:17:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190404231707.GB25513@umbus.fritz.box>
References: <155323635511.18748.18133954505098138975.stgit@aravinda>
	<155323643836.18748.13006461397179281455.stgit@aravinda>
	<20190325062256.GO29295@umbus>
	<1fdde5df-408a-f81d-d9ac-eb9636324b54@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <1fdde5df-408a-f81d-d9ac-eb9636324b54@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/6] target/ppc: Handle NMI guest exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org, mahesh@linux.vnet.ibm.com


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 02:40:45PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Monday 25 March 2019 11:52 AM, David Gibson wrote:
> > On Fri, Mar 22, 2019 at 12:03:58PM +0530, Aravinda Prasad wrote:
> >> Memory error such as bit flips that cannot be corrected
> >> by hardware are passed on to the kernel for handling.
> >> If the memory address in error belongs to guest then
> >> the guest kernel is responsible for taking suitable action.
> >> Patch [1] enhances KVM to exit guest with exit reason
> >> set to KVM_EXIT_NMI in such cases. This patch handles
> >> KVM_EXIT_NMI exit.
> >>
> >> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
> >>     (e20bbd3d and related commits)
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr_events.c  |   22 ++++++++++++++++++++++
> >>  include/hw/ppc/spapr.h |    1 +
> >>  target/ppc/kvm.c       |   16 ++++++++++++++++
> >>  target/ppc/kvm_ppc.h   |    2 ++
> >>  4 files changed, 41 insertions(+)
> >>
>=20
> [...]
>=20
> >> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >> index 2427c8e..a593448 100644
> >> --- a/target/ppc/kvm.c
> >> +++ b/target/ppc/kvm.c
> >> @@ -1738,6 +1738,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct k=
vm_run *run)
> >>          ret =3D 0;
> >>          break;
> >> =20
> >> +    case KVM_EXIT_NMI:
> >> +        DPRINTF("handle NMI exception\n");
> >=20
> > tracepoints are generally preferred to new DPRINTFs.
>=20
> I see DPRINTFs used in all other exit reasons in this function. Do you
> want me to change this particular exit case to tracepoints? I think it
> is better to keep this DPRINTF as of now and change all the DPRINTFs to
> tracepoints in a separate patch set.

Ah, good point.  Tracepoints are generally preferred, but since
DPRINTFs are in use here, stick with that (at some point it would be
good to change the whole file, but that's out of scope here).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlymkHMACgkQbDjKyiDZ
s5Kk1Q//fxTYGx9HX1OpXOG5hQC3Hi4wXlXe7XBTCi/xh7OdK2qUPJXbHxNn4Qqh
KE+VaDmf3BEnfkkthZ7WTjrADVugx/DCll8LyCWEG9NBz/JFxS4vfCDcr5SbtEBe
EVhd/eUSvIYnME4Lf/bVRvI7L75N54pSc6Bl9TtBWNtNEmZQOiQFak/rmaSy4MXk
vcUGZhSFe44dM2YaSZkI7PjLk5zvcHrQwfkkUamYAV50uEePCUqvvul6RdwbQcXS
HYAcFQv2b+hLHefAm8ooLXChqcODYS+NHKbKfWcyuWGsU5PoGOPbJNSmBkbRp5Hp
Ynxb0cBcrWNahiNadT4fmnphlNVKthdTc2FpJDH9c25JBi1XCxTAiY0AlZUBHcj4
lzTZEd2qJqEzCCUMQGtLi75HYAhVAdAqJMKUM2BRIMuRSAQhbuGfrEk6GPLcdCFZ
kn6ayqeGmVYDbeZHGZUjnlzXah/gKkVA1yalQ3x4wXeec4KFw3EnNqJImvuRMjKw
MpHrY7ANAUcIV9aAlLcWb/iNgG56vmidHC39zrfS7iAdO6NSNuovLRwougg8CWi3
VKw1L0NsbOPprPv8KYPTgnabiZtYg6v2JOxHQ2Ax8KY4Mt/L06XnAIJD+VwUJ+1d
baaksapuaVFYdPvDLLuBG4iYTu6Krf5/aIiIludQFNKCIx/PiHQ=
=4cJ7
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
