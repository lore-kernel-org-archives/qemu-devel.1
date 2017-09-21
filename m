Received: from eggs.gnu.org ([2001:4830:134:3::10]:33468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1gb-0007e3-HV
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1gY-0006pt-EN
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:37 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:39991)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1gY-0006pD-8u
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:34 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 21 Sep 2017 14:38:04 +0100
Message-ID: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Hi,=20

The patch 1 and 2 contain checkpatch.pl errors but patch 1 is relocating =
a file
and patch 2 has false positive warnings.

Regards,
Yongbok

The following changes since commit ff5667ed53c544c4dc88dcd7cb23cc509c9a55=
e0:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' =
into staging (2017-09-21 10:56:09 +0100)

are available in the git repository at:

  git://github.com/yongbok/upstream-qemu.git tags/mips-20170921

for you to fetch changes up to 2a2be359c4335607c7f746cf27c412c08ab89aff:

  mips: Improve macro parenthesization (2017-09-21 13:25:41 +0100)

----------------------------------------------------------------
MIPS patches 2017-09-21

Changes:
QOMify MIPS cpu
Improve macro parenthesization

----------------------------------------------------------------

Eric Blake (1):
  mips: Improve macro parenthesization

Igor Mammedov (2):
  mips: MIPSCPU model subclasses
  mips: replace cpu_mips_init() with cpu_generic_init()

Philippe Mathieu-Daud=C3=A9 (4):
  mips: move hw/mips/cputimer.c to target/mips/
  mips: introduce internal.h and cleanup cpu.h
  mips: split cpu_mips_realize_env() out of cpu_mips_init()
  mips: call cpu_mips_realize_env() from mips_cpu_realizefn()

 hw/mips/Makefile.objs        |   2 +-
 hw/mips/cps.c                |   2 +-
 hw/mips/cputimer.c           | 165 -----------------
 hw/mips/mips_fulong2e.c      |   2 +-
 hw/mips/mips_jazz.c          |   2 +-
 hw/mips/mips_malta.c         |   2 +-
 hw/mips/mips_mipssim.c       |   2 +-
 hw/mips/mips_r4k.c           |   2 +-
 target/mips/Makefile.objs    |   2 +-
 target/mips/cp0_timer.c      | 165 +++++++++++++++++
 target/mips/cpu-qom.h        |   1 +
 target/mips/cpu.c            |  54 +++++-
 target/mips/cpu.h            | 357 +-----------------------------------
 target/mips/dsp_helper.c     |  56 +++---
 target/mips/gdbstub.c        |   1 +
 target/mips/helper.c         |   1 +
 target/mips/internal.h       | 422 +++++++++++++++++++++++++++++++++++++=
++++++
 target/mips/kvm.c            |   1 +
 target/mips/machine.c        |   1 +
 target/mips/msa_helper.c     |   1 +
 target/mips/op_helper.c      |   1 +
 target/mips/translate.c      |  23 +--
 target/mips/translate_init.c |  58 +-----
 23 files changed, 692 insertions(+), 631 deletions(-)
 delete mode 100644 hw/mips/cputimer.c
 create mode 100644 target/mips/cp0_timer.c
 create mode 100644 target/mips/internal.h

--=20
2.7.4
