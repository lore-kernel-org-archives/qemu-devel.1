Received: from eggs.gnu.org ([2001:4830:134:3::10]:38239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1kSo-0003Da-73
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e1kSl-00033O-3W
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e1kSk-00032u-UD
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:40:07 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  9 Oct 2017 23:39:53 -0300
Message-Id: <20171010024001.4526-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/8] x86 and machine queue, 2017-10-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Changes on v2:
* Removed NUMA/ACPI patches until we figure out what's breaking
  the tests.
  (See: https://www.mail-archive.com/qemu-devel@nongnu.org/msg486368.html=
)
  Note that I didn't reproduce the failure yet.  I am just
  removing those patches because they are the only ones touching
  ACPI code.

The following changes since commit 530049bc1dcc24c1178a29d99ca08b6dd08413=
e0:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2017-10-06 17:43:02 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request

for you to fetch changes up to e0dd5fd41a1a38766009f442967fab700d2d0550:

  x86: Correct translation of some rdgsbase and wrgsbase encodings (2017-=
10-09 23:29:20 -0300)

----------------------------------------------------------------
x86 and machine queue, 2017-10-09

Includes x86, QOM, CPU, and option/config parsing patches.

Highlights:
* Deprecation of -nodefconfig option;
* MachineClass::valid_cpu_types field.

----------------------------------------------------------------

Alistair Francis (1):
  machine: Add a valid_cpu_types property

Eduardo Habkost (3):
  vl: Eliminate defconfig variable
  qemu-options: Deprecate -nodefconfig
  config: qemu_config_parse() return number of config groups

Igor Mammedov (1):
  qom: update doc comment for type_register[_static]()

Philippe Mathieu-Daud=C3=A9 (1):
  qom/cpu: move cpu_model null check to cpu_class_by_name()

Seeteena Thoufeek (1):
  vl: exit if maxcpus is negative

Todd Eisenberger (1):
  x86: Correct translation of some rdgsbase and wrgsbase encodings

 include/hw/boards.h     |  1 +
 include/qom/object.h    |  4 ++--
 include/sysemu/sysemu.h |  2 +-
 block/blkdebug.c        |  1 -
 hw/core/machine.c       | 32 ++++++++++++++++++++++++++++++++
 qom/cpu.c               |  7 ++++++-
 target/alpha/cpu.c      |  6 +-----
 target/arm/cpu.c        |  4 ----
 target/cris/cpu.c       |  4 ----
 target/i386/translate.c |  4 ++--
 target/lm32/cpu.c       |  4 ----
 target/m68k/cpu.c       |  4 ----
 target/mips/cpu.c       |  4 ----
 target/moxie/cpu.c      |  8 +-------
 target/openrisc/cpu.c   |  4 ----
 target/sh4/cpu.c        |  3 ---
 target/sparc/cpu.c      |  4 ----
 target/tricore/cpu.c    |  4 ----
 target/unicore32/cpu.c  |  4 ----
 target/xtensa/cpu.c     |  4 ----
 util/qemu-config.c      | 15 +++++++--------
 vl.c                    | 11 ++++-------
 qemu-doc.texi           |  4 ++++
 qemu-options.hx         | 17 ++++-------------
 24 files changed, 65 insertions(+), 90 deletions(-)

--=20
2.13.6
