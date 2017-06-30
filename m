Received: from eggs.gnu.org ([2001:4830:134:3::10]:40045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQtie-0007Ms-ND
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQtiZ-0001wy-Qx
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:04:12 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:49153)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQtiZ-0001v4-L3
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:04:07 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 0DA2510F46A
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 13:04:04 +0200 (CEST)
Date: Fri, 30 Jun 2017 13:03:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170630130346.2b66197a@bahia.lan>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/6Z4y_eZSle_Nr364rTlY+Kh";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 00/21] ppc-for-2.10 queue 20170730
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, lvivier@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org, sursingh@redhat.com, mdroth@linux.vnet.ibm.com, agraf@suse.de, qemu-ppc@nongnu.org, sbobroff@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>

--Sig_/6Z4y_eZSle_Nr364rTlY+Kh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Not sure Sam's and Suraj's email addresses are correct but you also used
them in the "target/ppc/cpu-models: set POWER9_v1.0 as  POWER9 DD1" thread
and, strangely, I don't seem to receive 'unknow recipient' messages from
the Redhat MX servers... :)

Cheers,

--
Greg

On Fri, 30 Jun 2017 20:46:11 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The following changes since commit c5eb5846d2d207bbde7f4b665d9ff90b92c8ad=
ff:
>=20
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170629' =
into staging (2017-06-29 17:37:11 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170630
>=20
> for you to fetch changes up to 0dfabd39d523fc3f6f0f8c441f41c013cc429b52:
>=20
>   spapr: Clean up DRC set_isolation_state() path (2017-06-30 14:03:32 +10=
00)
>=20
> ----------------------------------------------------------------
> ppc patch queue 2017-06-30
>=20
>   * More DRC cleanups, these now actually fix a few bugs
>   * Properly implements the openpic timers (they now count and
>     generate interrupts)
>   * Fixes for XICS migration
>   * Fixes for migration of POWER9 RPT guests
>   * The last of the compatibility mode rework
>=20
> ----------------------------------------------------------------
> Aaron Larson (1):
>       target-ppc: Enable open-pic timers to count and generate interrupts
>=20
> Bharata B Rao (4):
>       spapr: Add a "no HPT" encoding to HTAB migration stream
>       spapr: Fix migration of Radix guests
>       target/ppc: Proper cleanup when ppc_cpu_realizefn fails
>       spapr: prevent QEMU crash when CPU realization fails
>=20
> Daniel Henrique Barboza (1):
>       hw/ppc/spapr.c: consecutive 'spapr->patb_entry =3D 0' statements
>=20
> David Gibson (9):
>       pseries: Move CPU compatibility property to machine
>       pseries: Reset CPU compatibility mode
>       ppc: Rework CPU compatibility testing across migration
>       spapr: Start hotplugged PCI devices in ISOLATED state
>       spapr: Eliminate DRC 'signalled' state variable
>       spapr: Split DRC release from DRC detach
>       spapr: Make DRC reset force DRC into known state
>       spapr: Clean up DRC set_allocation_state path
>       spapr: Clean up DRC set_isolation_state() path
>=20
> Greg Kurz (3):
>       qapi: add explicit null to string input and output visitors
>       xics: directly register ICPState objects to vmstate
>       spapr: fix migration of ICPState objects from/to older QEMU
>=20
> Suraj Jitindar Singh (1):
>       target/ppc: Fix return value in tcg radix mmu fault handler
>=20
> Thomas Huth (2):
>       hw/ppc/prep: Remove superfluous call to soundhw_init()
>       target/ppc/excp_helper: Take BQL before calling cpu_interrupt()
>=20
>  hw/intc/openpic.c            | 117 +++++++++++++-
>  hw/intc/xics.c               |   5 +-
>  hw/ppc/prep.c                |   4 -
>  hw/ppc/spapr.c               | 160 ++++++++++++++++---
>  hw/ppc/spapr_cpu_core.c      |  68 +++++++--
>  hw/ppc/spapr_drc.c           | 355 +++++++++++++++++++++++--------------=
------
>  hw/ppc/spapr_events.c        |  10 --
>  hw/ppc/spapr_hcall.c         |   8 +-
>  include/hw/ppc/spapr.h       |  13 +-
>  include/hw/ppc/spapr_drc.h   |  10 +-
>  qapi/string-input-visitor.c  |  11 ++
>  qapi/string-output-visitor.c |  14 ++
>  target/ppc/compat.c          | 102 +++++++++++++
>  target/ppc/cpu.h             |   6 +-
>  target/ppc/excp_helper.c     |   3 +
>  target/ppc/machine.c         |  69 ++++++++-
>  target/ppc/mmu-radix64.c     |   2 +-
>  target/ppc/translate_init.c  | 100 +++++-------
>  18 files changed, 749 insertions(+), 308 deletions(-)
>=20


--Sig_/6Z4y_eZSle_Nr364rTlY+Kh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllWMBIACgkQAvw66wEB28LrnwCfZL8YYtiKVJiKYdvgDvlg9T8/
mkQAoIYFtl8cpIIZZxj3bzOWr9lxFxwN
=wBMj
-----END PGP SIGNATURE-----

--Sig_/6Z4y_eZSle_Nr364rTlY+Kh--
