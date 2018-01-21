Received: from eggs.gnu.org ([2001:4830:134:3::10]:36078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Gg-0000Yc-AS
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Gc-0007I3-9z
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:10 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 21 Jan 2018 16:33:41 +1100
Message-Id: <20180121053353.25970-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180121
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc7=
8f:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-01-19 16:35:25 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180121

for you to fetch changes up to 1f63ebaa91f73f469c8f107dbd266cabdbea3a40:

  target/ppc/spapr_caps: Add macro to generate spapr_caps migration vmsta=
te (2018-01-20 17:15:05 +1100)

Peter, since I'm on my way to linux.conf.au, this hasn't been through
my full usual test regimen, just a quick sanity check.  I'm hoping
this is ok, since the only changes since the superseded pull request
(which did pass the full set of tests) is a clean rebase and removal
of Thomas' patch deprecating ppcemb.

----------------------------------------------------------------
ppc patch queue 2018-01-21

This request supersedes the one from 2018-01-19.  The only difference
is that the patch deprecating ppcemb-softmmu, and thereby creating
many annying warnings from make check has been removed.

Highlights are:
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

Thomas Huth (3):
      default-configs/ppc64-softmmu: Include 32-bit configs instead of co=
pying them
      default-configs/ppc-softmmu: Restructure the switches according to =
the machines
      hw/ppc/Makefile: Add a way to disable the PPC4xx boards

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
 target/ppc/cpu.h                  | 16 +++++---
 target/ppc/excp_helper.c          | 52 ++++++++++++++++++++++++++
 target/ppc/helper.h               |  2 +
 target/ppc/translate.c            | 58 ++++++++++++++++++-----------
 target/ppc/translate_init.c       |  2 +-
 14 files changed, 191 insertions(+), 190 deletions(-)
