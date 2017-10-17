Received: from eggs.gnu.org ([2001:4830:134:3::10]:50343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOS-0008H0-Kb
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOO-0006rS-JD
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:16 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:18 +1100
Message-Id: <20171017042152.29443-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/34] ppc-for-2.11 queue 20171017
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit c5bbcaa4b7c0f8a322bebe9ec563560178a68b=
55:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-10-16 17:29:16 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171017

for you to fetch changes up to e7cca3e94f7595b7b5a493a87146e782831611d7:

  spapr_cpu_core: rewrite machine type sanity check (2017-10-17 10:34:01 =
+1100)

----------------------------------------------------------------
ppc patch queue 2017-10-17

Here's the currently accumulated set of ppc patches for qemu.

  * The biggest set here is the ppc parts of Igor Mammedov's cleanups
    to cpu model handling
  * The above also includes a generic patches which are required as
    prerequisites for the ppc parts.  They don't seem to have been
    merged by Eduardo yet, so I hope they're ok to include here.
  * Apart from that it's basically just assorted bug fixes and cleanups

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      hw/ppc/spapr.c: abort unplug_request if previous unplug isn't done

David Gibson (2):
      target/ppc: Add POWER9 DD2.0 model information
      spapr: Correct RAM size calculation for HPT resizing

Greg Kurz (5):
      hw/ppc: use 0 instead of fdt_path_offset(fdt, "/")
      spapr: fix OF word name in comment
      spapr: sanity check size of the CAS buffer
      spapr_pci: fail gracefully with non-pseries machine types
      spapr_cpu_core: rewrite machine type sanity check

Igor Mammedov (23):
      qom: introduce type_register_static_array()
      qom: add helper macro DEFINE_TYPES()
      ppc: mpc8544ds/e500plat: use generic cpu_model parsing
      ppc: mac_newworld: use generic cpu_model parsing
      ppc: mac_oldworld: use generic cpu_model parsing
      ppc: bamboo: use generic cpu_model parsing
      ppc: replace cpu_model with cpu_type on ref405ep,taihu boards
      ppc: virtex-ml507: replace cpu_model with cpu_type
      ppc: 40p/prep: replace cpu_model with cpu_type
      ppc: spapr: replace ppc_cpu_parse_features() with cpu_parse_cpu_mod=
el()
      ppc: move '-cpu foo,compat=3Dxxx' parsing into ppc_cpu_parse_featur=
estr()
      ppc: spapr: define core types statically
      ppc: spapr: use cpu type name directly
      ppc: spapr: register 'host' core type along with the rest of core t=
ypes
      ppc: spapr: use cpu model names as tcg defaults instead of aliases
      ppc: move ppc_cpu_lookup_alias() before its first user
      ppc: spapr: use generic cpu_model parsing
      ppc: pnv: use generic cpu_model parsing
      ppc: pnv: normalize core/chip type names
      ppc: pnv: drop PnvCoreClass::cpu_oc field
      ppc: pnv: define core types statically
      ppc: pnv: drop PnvChipClass::cpu_model field
      ppc: pnv: consolidate type definitions and batch register them

Mark Cave-Ayland (1):
      macio: add missing registers to VMStateDescription

Sandipan Das (1):
      target/ppc: Fix carry flag setting for shift algebraic instructions

Thomas Huth (1):
      target/ppc: Remove unused PPC 460 and 460F definitions

 hw/ide/macio.c                  |   4 +-
 hw/ppc/e500.c                   |   8 +-
 hw/ppc/e500plat.c               |   1 +
 hw/ppc/mac_newworld.c           |  15 +--
 hw/ppc/mac_oldworld.c           |   6 +-
 hw/ppc/mpc8544ds.c              |   2 +
 hw/ppc/pnv.c                    | 134 ++++++++-----------
 hw/ppc/pnv_core.c               |  67 +++++-----
 hw/ppc/ppc.c                    |  25 ----
 hw/ppc/ppc405_uc.c              |   6 +-
 hw/ppc/ppc440_bamboo.c          |   7 +-
 hw/ppc/ppc4xx_devs.c            |   4 +-
 hw/ppc/prep.c                   |  12 +-
 hw/ppc/spapr.c                  |  51 ++++---
 hw/ppc/spapr_cpu_core.c         | 196 ++++++++-------------------
 hw/ppc/spapr_hcall.c            |   4 +-
 hw/ppc/spapr_pci.c              |  12 +-
 hw/ppc/virtex_ml507.c           |  11 +-
 include/hw/ppc/pnv.h            |  12 +-
 include/hw/ppc/pnv_core.h       |   4 +-
 include/hw/ppc/ppc.h            |   2 -
 include/hw/ppc/spapr.h          |   2 -
 include/hw/ppc/spapr_cpu_core.h |   7 +-
 include/qom/object.h            |  46 +++++++
 qom/object.c                    |   9 ++
 target/ppc/cpu-models.c         |   6 +-
 target/ppc/cpu-models.h         |   1 +
 target/ppc/cpu-qom.h            |   1 +
 target/ppc/cpu.h                |   1 -
 target/ppc/int_helper.c         |  16 +--
 target/ppc/kvm.c                |  22 ++--
 target/ppc/translate.c          |  12 ++
 target/ppc/translate_init.c     | 286 +++++++++-------------------------=
------
 33 files changed, 378 insertions(+), 614 deletions(-)
