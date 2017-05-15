Received: from eggs.gnu.org ([2001:4830:134:3::10]:35482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAFgE-0007GH-RR
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAFgA-0007kt-0z
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:04:54 -0400
Date: Mon, 15 May 2017 14:04:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515130445.GD1201@stefanha-x1.localdomain>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Content-Disposition: inline
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PULL 00/23] ppc-for-2.10 queue 20170511
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, aik@ozlabs.ru, mark.cave-ayland@ilande.co.uk, agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com, sam.bobroff@au1.ibm.com


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 02:14:03PM +1000, David Gibson wrote:
> The following changes since commit 76d20ea0f1b26ebd5da2f5fb2fdf3250cde887=
bb:
>=20
>   Merge remote-tracking branch 'armbru/tags/pull-qapi-2017-05-04-v3' into=
 staging (2017-05-09 15:49:14 -0400)
>=20
> are available in the git repository at:
>=20
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170511
>=20
> for you to fetch changes up to e9edd931eb1b7e4be2274a8d9b3e5d5c4b7d1aad:
>=20
>   target/ppc: Avoid printing wrong aliases in CPU help text (2017-05-11 0=
9:45:15 +1000)
>=20
> ----------------------------------------------------------------
> ppc patch queue for 2017-05-11
>=20
> This pull request supersedes the one from yesterday (20170510), fixing
> an important style bug in one patch, and adding an extra couple of
> simple patches.
>=20
> Highlights of this set:
>   * Some fixes for POWER9
>   * TCG support for POWER9 radix MMU
>   * VGA rom for Mac machine types
>   * Fixes for the XICS interrupt controller
>   * MTTCG support for ppc targets
>=20
> As suggested by Paolo, I've tried to add the Docker tests to my
> standard pre-pull-request tests.  I haven't wholly suceeded; this has
> been tested with some of the Docker images, but others I haven't
> managed due to problems that as best I can tell are not due to
> problems in this patch series.  I'll continue working on this for
> future pull requests.  Specifically, 'travis', 'fedora', and 'centos6'
> seem to work.  'min-glib' jammed while gtesting moxie, which seems
> very unlikely to be caused by this series.  'ubuntu', 'debian' and
> 'debian-bootstrap' hit build errors almost immediately that look like
> problems with the container configuration, and 'debian-*-cross' hit
> build errors later on which also look like missing dependencies from
> the container.
>=20
> ----------------------------------------------------------------
> Bharata B Rao (1):
>       cpus: Fix CPU unplug for MTTCG
>=20
> C=E9dric Le Goater (1):
>       ppc/pnv: restrict BMC object to the BMC simulator
>=20
> David Gibson (3):
>       spapr: Don't accidentally advertise HTM support on POWER9
>       target/ppc: Allow workarounds for POWER9 DD1
>       pnv: Fix build failures on some host platforms
>=20
> Mark Cave-Ayland (4):
>       Add QemuMacDrivers as submodule
>       Add QemuMacDrivers qemu_vga.ndrv revision d4e7d7a built as submodule
>       ppc: add qemu_vga.ndrv ROM to fw_cfg interface for OldWorld Macs
>       ppc: add qemu_vga.ndrv ROM to fw_cfg interface for NewWorld Macs
>=20
> Nikunj A Dadhania (5):
>       target/ppc: Emulate LL/SC using cmpxchg helpers
>       cputlb: handle first atomic write to the page
>       target/ppc: Generate fence operations
>       tcg: enable MTTCG by default for PPC64 on x86
>       target/ppc: do not reset reserve_addr in exec_enter
>=20
> Paolo Bonzini (1):
>       ppc: xics: fix compilation with CentOS 6
>=20
> Sam Bobroff (2):
>       ppc/xics: Fix stale irq->status bits after get
>       ppc/xics: preserve P and Q bits for KVM IRQs
>=20
> Suraj Jitindar Singh (5):
>       target/ppc: Set UPRT and GTSE on all cpus in H_REGISTER_PROCESS_TAB=
LE
>       target/ppc: Update tlbie to check privilege level based on GTSE
>       target/ppc: Change tlbie invalid fields for POWER9 support
>       target/ppc: Implement ISA V3.00 radix page fault handler
>       target/ppc: Enable RADIX mmu mode for pseries TCG guest
>=20
> Thomas Huth (1):
>       target/ppc: Avoid printing wrong aliases in CPU help text
>=20
>  .gitmodules                 |   3 +
>  Makefile                    |   3 +-
>  configure                   |   2 +
>  cpus.c                      |   6 +
>  cputlb.c                    |   8 +-
>  hw/intc/xics_kvm.c          |  13 +++
>  hw/ppc/mac_newworld.c       |  18 ++-
>  hw/ppc/mac_oldworld.c       |  18 ++-
>  hw/ppc/pnv.c                |   2 +-
>  hw/ppc/spapr.c              |  17 ++-
>  hw/ppc/spapr_hcall.c        |  18 ++-
>  include/hw/ppc/pnv.h        |   3 +-
>  include/hw/ppc/pnv_lpc.h    |   4 +-
>  include/hw/ppc/pnv_occ.h    |   4 +-
>  include/hw/ppc/xics.h       |   4 +-
>  pc-bios/README              |   3 +
>  pc-bios/qemu_vga.ndrv       | Bin 0 -> 14752 bytes
>  roms/QemuMacDrivers         |   1 +
>  target/ppc/Makefile.objs    |   1 +
>  target/ppc/cpu-models.h     |   1 +
>  target/ppc/cpu.h            |   5 +
>  target/ppc/excp_helper.c    |   3 +
>  target/ppc/kvm.c            |  23 ++--
>  target/ppc/mmu-book3s-v3.c  |   6 +-
>  target/ppc/mmu-book3s-v3.h  |   5 +
>  target/ppc/mmu-radix64.c    | 259 ++++++++++++++++++++++++++++++++++++++=
++++++
>  target/ppc/mmu-radix64.h    |  72 ++++++++++++
>  target/ppc/translate.c      |  48 ++++++--
>  target/ppc/translate_init.c |  38 +++++--
>  29 files changed, 525 insertions(+), 63 deletions(-)
>  create mode 100644 pc-bios/qemu_vga.ndrv
>  create mode 160000 roms/QemuMacDrivers
>  create mode 100644 target/ppc/mmu-radix64.c
>  create mode 100644 target/ppc/mmu-radix64.h
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJZGadtAAoJEJykq7OBq3PIFGkH+IKKzYLHJs1dP7uLN+XsU+HM
PF8xj/otDFt0xHSWqmmcsHnf4jtR4/iJinMQW4N7fzi74S7fv3v+a9+HgiH4v95z
SblHZNRzVT58eX1chQCfJL5KQ8bNDRH4UbQkTc4jCnLNjoi5sETWNg8VRiJ+1nZN
HDtWSfKJ7Fo3agKL80xUSOu88SQFRx+z9Uxe09UagUu96fojFCDh0zvS7J0piN32
kXoyFGk+aKn+GTZt/uqwn5ddzdxvUECfiwcFEfbsPpqVKlkwhjAPBNTDbczorTbm
vXT2e4rOIJwLlxavSgfVcvCP9ECV8WxVemWa5yn0rjfHZE7qu48JtE5HXC3heA==
=9wPo
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
