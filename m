Received: from eggs.gnu.org ([2001:4830:134:3::10]:54222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4au-0003Ub-MX
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4at-0002wy-Qn
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:18 +1000
Message-Id: <20170606025135.2685-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/17] ppc-for-2.10 queue 20170606
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 199e19ee538eb61fd08b1c1ee5aa838ebdcc96=
8e:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' i=
nto staging (2017-06-05 15:28:12 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170606

for you to fetch changes up to 91dcb1ffa67cfa41a13dcc89dd44e2310b5773b0:

  spapr: Remove some non-useful properties on DRC objects (2017-06-06 09:=
24:25 +1000)

----------------------------------------------------------------
ppc patch queue 2017-06-06

Accumulated patches for ppc targets and the pseries machine type.

The big thing in this batch is a start on a substantial cleanup of the
pseries hotplug mechanisms, which were pretty confusing.  For now
these shouldn't cause substantial behavioural changes, but I am hoping
these lead to clearer code and eventually to fixes for the bugs we
have in hotplug handling, particularly when hotplug and migration are
combined.

The remaining patches are mostly bugfixes.

----------------------------------------------------------------
Aaron Larson (1):
      target-ppc: Fix openpic timer read register offset

C=C3=A9dric Le Goater (1):
      ppc/pnv: check the return value of fdt_setprop()

David Gibson (10):
      migration: Mark CPU states dirty before incoming migration/loadvm
      spapr: Move DRC RTAS calls into spapr_drc.c
      spapr: Abolish DRC get_fdt method
      spapr: Abolish DRC set_configured method
      spapr: Make DRC get_index and get_type methods into plain functions
      spapr: Introduce DRC subclasses
      spapr: Clean up spapr_dr_connector_by_*()
      spapr: Move configure-connector state into DRC
      spapr: Eliminate spapr_drc_get_type_str()
      spapr: Remove some non-useful properties on DRC objects

Felipe Franciosi (1):
      spapr: Allow boot from vhost-*-scsi backends

Greg Kurz (1):
      spapr/drc: don't migrate DRC of cold-plugged CPUs and LMBs

Laurent Vivier (1):
      migration: remove register_savevm()

Peter Maydell (1):
      spapr_nvram: Check return value from blk_getlength()

Suraj Jitindar Singh (1):
      target/ppc: Fixup set_spr error in h_register_process_table

 cpus.c                      |   9 +
 hw/intc/openpic.c           |  22 +-
 hw/net/vmxnet3.c            |   8 +-
 hw/nvram/spapr_nvram.c      |  10 +-
 hw/ppc/pnv.c                |   5 +-
 hw/ppc/spapr.c              |  58 +++--
 hw/ppc/spapr_drc.c          | 573 +++++++++++++++++++++++++++++++-------=
------
 hw/ppc/spapr_events.c       |  12 +-
 hw/ppc/spapr_hcall.c        |   5 +-
 hw/ppc/spapr_pci.c          |  13 +-
 hw/ppc/spapr_rtas.c         | 304 -----------------------
 hw/s390x/s390-skeys.c       |   9 +-
 hw/s390x/s390-virtio-ccw.c  |   8 +-
 include/hw/ppc/spapr.h      |  14 --
 include/hw/ppc/spapr_drc.h  |  69 +++++-
 include/migration/vmstate.h |   8 -
 include/sysemu/cpus.h       |   1 +
 include/sysemu/hax.h        |   1 +
 include/sysemu/hw_accel.h   |  10 +
 include/sysemu/kvm.h        |   1 +
 kvm-all.c                   |  10 +
 migration/savevm.c          |  18 +-
 slirp/slirp.c               |   8 +-
 target/i386/hax-all.c       |  10 +
 24 files changed, 595 insertions(+), 591 deletions(-)
