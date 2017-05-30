Received: from eggs.gnu.org ([2001:4830:134:3::10]:55754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFcmM-0007Tv-J2
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFcmJ-0007xI-HG
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:45:26 -0400
Date: Tue, 30 May 2017 09:45:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530084520.GC11362@stefanha-x1.localdomain>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PULL 00/18] ppc-for-2.10 queue 20170525
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, aik@ozlabs.ru, sursingh@redhat.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, sbobroff@redhat.com


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2017 at 01:51:14PM +1000, David Gibson wrote:
> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:
>=20
>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170525
>=20
> for you to fetch changes up to 62f94fc94f98095173146e753a1f03d7c2cc7ba3:
>=20
>   xics: add unrealize handler (2017-05-25 11:31:33 +1000)
>=20
> ----------------------------------------------------------------
> ppc patch queue 2017-05-25
>=20
> Assorted accumulated patches.  These are nearly all bugfixes at one
> level or another - some for longstanding problems, others for some
> regressions caused by more recent cleanups.
>=20
> This includes preliminary patches towards fixing migration for Radix
> Page Table guests under POWER9 and also fixing some migration
> regressions due to the re-organization of the interrupt controller
> code.  Not all the pieces are there yet, so those still won't quite
> work, but the preliminary changes make sense on their own.
>=20
> ----------------------------------------------------------------
> Bharata B Rao (1):
>       spapr: Consolidate HPT freeing code into a routine
>=20
> Daniel Henrique Barboza (4):
>       hw/ppc/spapr_events.c: removing 'exception' from sPAPREventLogEntry
>       hw/ppc: removing drc->detach_cb and drc->detach_cb_opaque
>       hw/ppc: migrating the DRC state of hotplugged devices
>       hw/ppc/spapr.c: recover pending LMB unplug info in spapr_lmb_release
>=20
> David Gibson (3):
>       pseries: Split CAS PVR negotiation out into a separate function
>       pseries: Restore support for total vcpus not a multiple of threads-=
per-core for old machine types
>       hw/ppc/spapr.c: adding pending_dimm_unplugs to sPAPRMachineState
>=20
> Greg Kurz (8):
>       ppc/xics: simplify prototype of xics_spapr_init()
>       spapr: sanitize error handling in spapr_ics_create()
>       spapr-cpu-core: release ICP object when realization fails
>       xics_kvm: cache already enabled vCPU ids
>       spapr: ensure core_slot isn't NULL in spapr_core_unplug()
>       spapr_cpu_core: drop reference on ICP object during CPU realization
>       spapr: fix error reporting in xics_system_init()
>       xics: add unrealize handler
>=20
> Laurent Vivier (1):
>       spapr: add pre_plug function for memory
>=20
> Nikunj A Dadhania (1):
>       target/ppc: reset reservation in do_rfi()
>=20
>  hw/intc/xics.c              |   5 +
>  hw/intc/xics_kvm.c          |  33 ++++--
>  hw/intc/xics_spapr.c        |   3 +-
>  hw/ppc/spapr.c              | 239 +++++++++++++++++++++++++++++++-------=
------
>  hw/ppc/spapr_cpu_core.c     |  19 ++--
>  hw/ppc/spapr_drc.c          |  92 ++++++++++++++---
>  hw/ppc/spapr_events.c       |  52 ++--------
>  hw/ppc/spapr_hcall.c        |  54 ++++++----
>  hw/ppc/spapr_pci.c          |   5 +-
>  include/hw/pci-host/spapr.h |   3 +
>  include/hw/ppc/spapr.h      |  12 ++-
>  include/hw/ppc/spapr_drc.h  |   8 +-
>  include/hw/ppc/xics.h       |   3 +-
>  target/ppc/excp_helper.c    |   3 +
>  14 files changed, 349 insertions(+), 182 deletions(-)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLTEgAAoJEJykq7OBq3PIiucIAMRpGotWcYOYo7DpFQMVlndd
87bE6i3Bs6u4lAT01yDhk/VYlrmw6jRJEEn9yMT6KwlG+Lr3cznAVYRyDEheCJ2n
v2sfwKKxkhTAuK8ScaxH/ig/CE9djsN4Zi2TeD2gDq8cd5u0p8ru82Umj7SfycNr
Fymvyp8v29V10/Rhs8fvGhLALptFu9zOoAcFW+1aZkx+7LGEnB6RwPAC5p83mx8o
+3xzwsoDJAEST7BzCeyW6UPGi7c7v19f6BdDT5ViBdr7Mzx87kSxCEY/d/uT0ED7
gR4IigQrQVZRB3/juSdbI003BApFTA9hvPGLsdDIEklI3hk3NMACPLwk1mUuiF0=
=rtfE
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
