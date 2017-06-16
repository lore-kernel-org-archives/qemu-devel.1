Received: from eggs.gnu.org ([2001:4830:134:3::10]:48572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dLiWx-0003n0-82
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 00:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dLiWu-0007AT-2C
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 00:06:43 -0400
Date: Fri, 16 Jun 2017 12:00:31 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170616040031.GE30484@umbus>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
	<4f1e9592-566f-b558-91e8-e39ac8691455@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
In-Reply-To: <4f1e9592-566f-b558-91e8-e39ac8691455@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] spapr: DRC cleanups (part IV)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: mdroth@linux.vnet.ibm.com, sursingh@redhat.com, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 07:10:55PM +0200, Laurent Vivier wrote:
> On 08/06/2017 07:09, David Gibson wrote:
> > This fourth isntallment of cleanups to the DRC code introduces the
> > first changes to the fundamental state handling.  We change the
> > initial states in the reset code and attach code for PCI devices, and
> > are able to remove the 'signalled' state variable with those fixes.
> >=20
> > There are also some more mechanical cleanups in preparation for
> > further cleanups and fixes to the state management.
> >=20
> > David Gibson (6):
> >   spapr: Start hotplugged PCI devices in ISOLATED state
> >   spapr: Eliminate DRC 'signalled' state variable
> >   spapr: Split DRC release from DRC detach
> >   spapr: Make DRC reset force DRC into known state
> >   spapr: Clean up DRC set_allocation_state path
> >   spapr: Clean up DRC set_isolation_state() path
> >=20
> >  hw/ppc/spapr.c             |  15 --
> >  hw/ppc/spapr_drc.c         | 363 +++++++++++++++++++++++--------------=
--------
> >  hw/ppc/spapr_events.c      |  10 --
> >  include/hw/ppc/spapr_drc.h |  10 +-
> >  4 files changed, 188 insertions(+), 210 deletions(-)
> >=20
>=20
> I've tested your series rebased on master.
>=20
> - plugging a CPU while the OS is not started (stopped in SLOF/GRUB):
>=20
>     The cpu can be hotplugged, but once the OS is started, the OS
>     doesn't detect it and it can't be unplugged.
>=20
> - plugging a memory DIMM while the OS is not started:
>=20
>     The first device_del does nothing, the second one crashes qemu
>=20
> - migration with hotplugged cpu (with OS started):
>=20
>      CPU cannot be unplugged on destination side
>=20
> - migration with hotplugged memory DIMM (with OS started):
>=20
>      The first device_del does nothing, the second one crashes qemu
>=20
> As it's cleanup, I guess this is what is expected
> (the results are the same as before cleanup series).

Right, I wouldn't expect this series to fix problems yet - it just
makes the code clearer so it will be easier to do so in future.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQ1fcAAoJEGw4ysog2bOSjX4P/Ro7o64x79uREUv5PhmbcvVc
YW4XK848QyXfIXun9e7V4BXuQ290Kr7oFsT+K81j1wt26o8AVp8ZaLgIHl1iX3eA
g3xkvOPmNILlfEbd4PHUGQXWvm9t7seDv/4XsEbqcLjkw2r11Q6FBObgLgTB493w
8dANOGE317wTyvZR0Dur7PlNSFLGKVo0V+DFqpXRv9HyIEhvcvEaSazsVULlf10F
H35rgz82yVul7W4oRPdZcM0q/mUN/fMXu3OdxzRaaedvY2Ez58yFUwWyDIJs7WMl
4FxiJeUl/s84EIB97ve7P3XjGfUvsO26m1HFH2tkcboGhGvWl3FEv/ASD4kO5OHZ
6PYv2tyJEJQGeRK76Jbo7dB5LiOG6GZLHJcTZA7UVeVYule/s/aSdKDdF+qa92I+
789FKxuaCHhwdMyQtRnjSjpGRMb2L6yFrE3N8SrJ/gY5zeDzrhEL2GdEe8R1xul9
egpngtlSFQ5Hv5KEbrOYv8S14pUmDKn0tJe+rEXSoaDZP9VC23na6JzntB/Pb+ah
I8VNc8vWt/7tQ2CA2kg77s6262+QlI+5Kju/soUuGZrcDVo5J/ByZio+Eqfz8aV3
kYDwks/qM+6/b4mfcdWyQafF1cPd8pO46u31wgvz+joaOjRug4dBzllHiGf1cb5Z
ueBKjyrdSQ5/CUXX0WW4
=9l1t
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
