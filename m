Received: from eggs.gnu.org ([209.51.188.92]:36772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goppj-0001NZ-U0
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1goppf-0006PD-OM
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:13 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 30 Jan 2019 14:22:01 +0100
Message-Id: <20190130132214.25493-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/13] Trivial branch patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Stefan Hajnoczi <stefanha@redhat.com>, Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

The following changes since commit b4fbe1f65a4769c09e6bf2d79fc84360f840f40e:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190129' into staging (2019-01-29 12:00:19 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 95b3c9cfd5eaaa4a2a4afa1eaf09612a94ade1da:

  virtio-blk: remove duplicate definition of VirtIOBlock *s pointer (2019-01-30 14:20:18 +0100)

----------------------------------------------------------------
- add device category (edu, i8042, sd memory card)
- code clean-up
- LGPL information clean-up
- fix typo (acpi)

----------------------------------------------------------------

Dr. David Alan Gilbert (1):
  typo: apci->acpi

Paul Durrant (1):
  hw/block: clean up stale xen_disk trace entries

Stefano Garzarella (1):
  virtio-blk: remove duplicate definition of VirtIOBlock *s pointer

Thomas Huth (7):
  Don't talk about the LGPL if the file is licensed under the GPL
  COPYING.LIB: Synchronize the LGPL 2.1 with the version from gnu.org
  target/openrisc: Fix LGPL version number
  target/tricore: Fix LGPL version number
  tcg: Fix LGPL version number
  target/s390x: Fix LGPL version in the file header comments
  target/m68k: Fix LGPL information in the file headers

kumar sourav (3):
  hw: edu: set category of the edu device
  hw: input: set category of the i8042 device
  hw: sd: set category of the sd memory card

 COPYING.LIB                        | 22 ++++++++++------------
 accel/tcg/atomic_template.h        |  2 +-
 accel/tcg/cpu-exec-common.c        |  2 +-
 accel/tcg/cpu-exec.c               |  2 +-
 accel/tcg/cputlb.c                 |  2 +-
 accel/tcg/softmmu_template.h       |  2 +-
 accel/tcg/tcg-runtime-gvec.c       |  2 +-
 accel/tcg/translate-all.c          |  2 +-
 accel/tcg/translate-all.h          |  2 +-
 accel/tcg/user-exec.c              |  2 +-
 crypto/afsplit.c                   | 11 +++++------
 hw/acpi/cpu.c                      |  2 +-
 hw/block/trace-events              |  7 -------
 hw/block/virtio-blk.c              |  2 --
 hw/i386/acpi-build.c               |  2 +-
 hw/input/pckbd.c                   |  1 +
 hw/misc/edu.c                      |  2 ++
 hw/sd/sd.c                         |  1 +
 include/crypto/afsplit.h           | 11 +++++------
 include/hw/acpi/cpu.h              |  2 +-
 include/hw/pci-host/gpex.h         |  4 ++--
 include/hw/pci-host/q35.h          |  4 ++--
 include/qemu/range.h               | 11 +++++------
 linux-user/m68k/target_cpu.h       |  4 ++--
 linux-user/m68k/target_structs.h   |  2 +-
 target/i386/hvf/hvf.c              |  6 +++---
 target/m68k/cpu.h                  |  4 ++--
 target/m68k/fpu_helper.c           |  4 ++--
 target/m68k/gdbstub.c              |  2 +-
 target/m68k/helper.c               |  4 ++--
 target/m68k/op_helper.c            |  2 +-
 target/m68k/translate.c            |  4 ++--
 target/openrisc/cpu.c              |  2 +-
 target/openrisc/exception.h        |  2 +-
 target/openrisc/gdbstub.c          |  2 +-
 target/openrisc/helper.h           |  2 +-
 target/openrisc/interrupt_helper.c |  2 +-
 target/openrisc/sys_helper.c       |  2 +-
 target/openrisc/translate.c        |  2 +-
 target/s390x/cc_helper.c           |  2 +-
 target/s390x/excp_helper.c         |  2 +-
 target/s390x/fpu_helper.c          |  2 +-
 target/s390x/gdbstub.c             |  2 +-
 target/s390x/helper.c              |  2 +-
 target/s390x/int_helper.c          |  2 +-
 target/s390x/mem_helper.c          |  2 +-
 target/s390x/misc_helper.c         |  2 +-
 target/s390x/translate.c           |  2 +-
 target/tricore/cpu-qom.h           |  2 +-
 target/tricore/cpu.c               |  2 +-
 target/tricore/cpu.h               |  2 +-
 target/tricore/fpu_helper.c        |  2 +-
 target/tricore/helper.c            |  2 +-
 target/tricore/helper.h            |  2 +-
 target/tricore/op_helper.c         |  2 +-
 target/tricore/translate.c         |  2 +-
 target/tricore/tricore-defs.h      |  2 +-
 target/tricore/tricore-opcodes.h   |  2 +-
 tcg/tcg-gvec-desc.h                |  2 +-
 tcg/tcg-op-gvec.c                  |  2 +-
 tcg/tcg-op-gvec.h                  |  2 +-
 tcg/tcg-op-vec.c                   |  2 +-
 util/range.c                       | 11 +++++------
 63 files changed, 96 insertions(+), 107 deletions(-)

-- 
2.20.1
