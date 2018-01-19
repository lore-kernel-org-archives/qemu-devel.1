Received: from eggs.gnu.org ([2001:4830:134:3::10]:40785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTA9-0001iy-8q
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecTA6-0008UX-4i
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:41 -0500
Received: from ozlabs.org ([103.22.144.67]:52049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ecTA5-0008TX-9Y
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 04:40:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 19 Jan 2018 20:40:02 +1100
Message-Id: <20180119094015.28266-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] ppc-for-2.12 queue 20180119
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, lvivier@redhat.com, agraf@suse.de, qemu-ppc@nognu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit b4d6ed1c5ae519d3efb5297be3ef6625ca2a20=
f4:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-17' i=
nto staging (2018-01-18 15:25:17 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180119

for you to fetch changes up to 040cb0a2badf9e265cdbb78380048cd1624dd434:

  target/ppc/spapr_caps: Add macro to generate spapr_caps migration vmsta=
te (2018-01-19 16:06:26 +1100)

----------------------------------------------------------------
ppc patch queue 2018-01-19

Quite soon after my previous pull request, but it's already
accumulated a reasonable amount of stuff:
  * Significant TCG speedup by optimizing cmp generation
  * Fix a regression caused by recent change to set compat mode on
    hotplugged cpus
  * Cleanup of default configs
  * Some implementation of msgsnd/msgrcv instructions for server chips

----------------------------------------------------------------
BALATON Zoltan (2):
      sm501: Add missing break to case
      sii3112: Add explicit type casts to avoid unintended sign extension

C=C3=A9dric Le Goater (3):
      target/ppc: fix doorbell and hypervisor doorbell definitions
      target/ppc: msgsnd and msgclr instructions need hypervisor privileg=
e
      target/ppc: add support for hypervisor doorbells on book3s CPUs

Greg Kurz (2):
      spapr: drop duplicate variable in spapr_core_plug()
      spapr: fix device tree properties when using compatibility mode

Suraj Jitindar Singh (1):
      target/ppc/spapr_caps: Add macro to generate spapr_caps migration v=
mstate

Thomas Huth (4):
      default-configs/ppc64-softmmu: Include 32-bit configs instead of co=
pying them
      default-configs/ppc-softmmu: Restructure the switches according to =
the machines
      hw/ppc/Makefile: Add a way to disable the PPC4xx boards
      ppc: Deprecate qemu-system-ppcemb

pbonzini@redhat.com (1):
      target-ppc: optimize cmp translation

 default-configs/ppc-softmmu.mak   | 59 +++++++++++++++--------------
 default-configs/ppc64-softmmu.mak | 61 ++++--------------------------
 hw/display/sm501.c                |  1 +
 hw/ide/sii3112.c                  | 10 ++---
 hw/ppc/Makefile.objs              |  4 +-
 hw/ppc/spapr.c                    | 22 +++++------
 hw/ppc/spapr_caps.c               | 78 ++++++++++++---------------------=
------
 hw/ppc/spapr_cpu_core.c           |  7 ++++
 hw/ppc/spapr_rtas.c               |  9 -----
 qemu-doc.texi                     |  6 +++
 target/ppc/cpu.h                  | 16 +++++---
 target/ppc/excp_helper.c          | 52 ++++++++++++++++++++++++++
 target/ppc/helper.h               |  2 +
 target/ppc/translate.c            | 58 ++++++++++++++++++-----------
 target/ppc/translate_init.c       |  7 +++-
 15 files changed, 202 insertions(+), 190 deletions(-)
