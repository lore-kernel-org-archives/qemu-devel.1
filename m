Received: from eggs.gnu.org ([2001:4830:134:3::10]:41865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHsx1-0003vd-F7
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHsww-0004Ns-K0
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 10:25:47 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon,  5 Jun 2017 17:25:36 +0300
Message-Id: <cover.1496672631.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/21] Trivial patches for 2017-06-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

This is a resend of the yesterday's trivial-patches queue, without
an ivshmem change which broke static build (will take a look at
that later). The rest is exactly the same, so sending only the
cover letter.

Thanks,

/mjt

The following changes since commit c6e84fbd447a51e1161d74d71566a5f67b47ea=
c5:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-06-02 17:46:22 +0100)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to 03e947f9c2264356aef037e6bf9c496b5deae2d2:

  hw/core: nmi.c can be compiled as common-obj nowadays (2017-06-05 17:23=
:36 +0300)

----------------------------------------------------------------
trivial patches for 2017-06-05

----------------------------------------------------------------
Eric Blake (2):
      block: Correct documentation for BLOCK_WRITE_THRESHOLD
      qapi: Fix some QMP documentation regressions

John Snow (1):
      ide-test: check return of fwrite

Juan Quintela (1):
      trivial: Remove unneeded ifndef in memory.h

Kamil Rytarowski (1):
      configure: Detect native NetBSD curses(3)

Luc MICHEL (1):
      target/arm: add data cache invalidation cp15 instruction to cortex-=
r5

Mao Zhongyi (1):
      scsi/lsi53c895a: Remove unused lsi_mem_*() return value

Marc-Andr=C3=A9 Lureau (2):
      qemu-ga: remove useless allocation
      dump: fix memory_mapping_filter leak

Markus Armbruster (2):
      docs qemu-doc: Avoid ide-drive, it's deprecated
      docs/qdev-device-use.txt: update section Default Devices

Max Filippov (1):
      hw/xtensa: sim: use g_string/g_new

Paolo Bonzini (1):
      altera_timer: fix incorrect memset

Philippe Mathieu-Daud=C3=A9 (3):
      hw/sparc: use ARRAY_SIZE() macro
      register: display register prefix (name) since it is available
      hw/mips: add missing include

Suraj Jitindar Singh (1):
      help: Add newline to end of thread option help text

Thomas Huth (4):
      qemu-doc: Move the qemu-ga description into a separate chapter
      qemu-doc: Add hyperlinks to further license information
      tests/libqtest: Print error instead of aborting when env variable i=
s missing
      hw/core: nmi.c can be compiled as common-obj nowadays

 configure                |  3 +--
 docs/bootindex.txt       |  2 +-
 docs/qdev-device-use.txt | 13 +++++++------
 hw/core/Makefile.objs    |  2 +-
 hw/core/register.c       |  8 ++++----
 hw/scsi/lsi53c895a.c     | 10 ++++------
 hw/sparc64/sun4u.c       |  2 +-
 hw/timer/altera_timer.c  |  2 +-
 hw/xtensa/sim.c          | 10 +++++-----
 include/exec/memory.h    |  2 --
 include/hw/mips/mips.h   |  1 +
 memory_mapping.c         |  1 +
 qapi/block-core.json     | 30 +++++++++++++++---------------
 qapi/block.json          |  2 +-
 qemu-doc.texi            | 21 +++++++++++----------
 qemu-options.hx          |  4 ++--
 qga/commands-posix.c     |  4 +---
 target/arm/cpu.c         |  2 ++
 tests/ide-test.c         |  8 ++++++--
 tests/libqtest.c         |  5 ++++-
 20 files changed, 69 insertions(+), 63 deletions(-)
