Received: from eggs.gnu.org ([2001:4830:134:3::10]:44903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zK-0007h0-2Y
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zH-00067T-V9
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Feb 2018 14:40:42 +1100
Message-Id: <20180212034054.23441-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180212
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit c7b02d7d032d6022060e4b393827c963c93ce6=
3f:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-=
090218-1' into staging (2018-02-09 16:12:34 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180212

for you to fetch changes up to 51f233ec92cdab7030cb7407dd7f009911c805b0:

  misc: introduce new mos6522 VIA device and enable it for ppc builds (20=
18-02-11 10:18:52 +1100)

----------------------------------------------------------------
ppc patch queue 2018-02-12

Here's the accumulatead ppc and pseries related patches for the last
while.  Highlights are:
    * A number of Macintosh / CUDA cleanups from Mark Cave-Ayland
    * An important bug fix (missing "break;") for
      H_GET_CPU_CHARACTERISTICS
    * Yet another fix for SMT mode handling
    * Assorted other cleanups and fixes

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      hw/ppc: rename functions in comments

Greg Kurz (1):
      spapr: add missing break in h_get_cpu_characteristics()

Laurent Vivier (1):
      spapr: set vsmt to MAX(8, smp_threads)

Mark Cave-Ayland (9):
      cuda: do not use old_mmio accesses
      cuda: don't allow writes to port output pins
      cuda: introduce CUDAState parameter to get_counter()
      cuda: rename frequency property to tb_frequency
      cuda: minor cosmetic tidy-ups to get_next_irq_time()
      cuda: don't call cuda_update() when writing to ACR register
      cuda: set timer 1 frequency property to CUDA_TIMER_FREQ
      cuda: factor out timebase-derived counter value and load time
      misc: introduce new mos6522 VIA device and enable it for ppc builds

 default-configs/ppc-softmmu.mak |   1 +
 hw/misc/Makefile.objs           |   3 +
 hw/misc/macio/cuda.c            | 111 ++++-----
 hw/misc/macio/macio.c           |   2 +-
 hw/misc/mos6522.c               | 505 ++++++++++++++++++++++++++++++++++=
++++++
 hw/misc/trace-events            |   7 +
 hw/ppc/mac.h                    |   2 +-
 hw/ppc/spapr.c                  |   5 +-
 hw/ppc/spapr_hcall.c            |   3 +-
 include/hw/misc/mos6522.h       | 152 ++++++++++++
 10 files changed, 722 insertions(+), 69 deletions(-)
 create mode 100644 hw/misc/mos6522.c
 create mode 100644 include/hw/misc/mos6522.h
