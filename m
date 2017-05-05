Received: from eggs.gnu.org ([2001:4830:134:3::10]:46998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aF6-0002CM-KN
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aF2-0006a1-Kc
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aF2-0006Zm-Ay
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:40 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B60B3D971
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 10:13:39 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-145.ams2.redhat.com
	[10.36.116.145])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v45ADbkH026855
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 06:13:38 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:16 +0200
Message-Id: <20170505101337.4650-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/21] Misc patches for 2017-05-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:

  Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 95615ce5a1beffff1a5dd3597d8cb6ba83f0010e:

  vhost-scsi: create a vhost-scsi-common abstraction (2017-05-05 12:10:00=
 +0200)

----------------------------------------------------------------
A large set of small patches.  I have not included yet vhost-user-scsi,
but it'll come in the next pull request.

* use GDB XML register description for x86
* use _Static_assert in QEMU_BUILD_BUG_ON
* add "R:" to MAINTAINERS and get_maintainers
* checkpatch improvements
* dump threading fixes
* first part of vhost-user-scsi support
* QemuMutex tracing
* vmw_pvscsi and megasas fixes
* sgabios module update
* use Rev3 (ACPI 2.0) FADT
* deprecate -hdachs
* improve -accel documentation
* hax fix
* qemu-char GSource bugfix

----------------------------------------------------------------
Abdallah Bouassida (1):
      target/i386: Add GDB XML register description support

Andreas Grapentin (1):
      use _Static_assert in QEMU_BUILD_BUG_ON

Brian Norris (2):
      get_maintainer: it's '--pattern-depth', not '-pattern-depth'
      get_maintainer: --r (list reviewer) is on by default

Dr. David Alan Gilbert (1):
      checkpatch: Disallow glib asserts in main code

Fam Zheng (1):
      dump: Acquire BQL around vm_start() in dump thread

Felipe Franciosi (2):
      libvhost-user: replace vasprintf() to fix build
      vhost-scsi: create a vhost-scsi-common abstraction

Joe Perches (2):
      get_maintainer: Teach get_maintainer.pl about the new "R:" tag
      get_maintainer: add subsystem to reviewer output

Jose Ricardo Ziviani (1):
      trace: add qemu mutex lock and unlock trace events

P J P (1):
      vmw_pvscsi: check message ring page count at initialisation

Paolo Bonzini (1):
      sgabios: update for "fix wrong video attrs for int 10h,ah=3D=3D13h"

Paul E. McKenney (1):
      MAINTAINERS: Add "R:" tag for self-appointed reviewers

Phil Dennis-Jordan (2):
      hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest =
OS support.
      hw/i386: Build-time assertion on pc/q35 reset register being identi=
cal.

Prasad J Pandit (1):
      scsi: avoid an off-by-one error in megasas_mmio_write

Thomas Huth (2):
      vl: deprecate the "-hdachs" option
      Fix the -accel parameter and the documentation for 'hax'

Yu Ning (1):
      hax: Fix memory mapping de-duplication logic

zhanghailiang (1):
      char: Fix removing wrong GSource that be found by fd_in_tag

 MAINTAINERS                           |   2 +
 chardev/char-fd.c                     |   8 +-
 chardev/char-io.c                     |  23 ++--
 chardev/char-io.h                     |   4 +-
 chardev/char-pty.c                    |   6 +-
 chardev/char-socket.c                 |   8 +-
 chardev/char-udp.c                    |   8 +-
 chardev/char.c                        |   2 +-
 configure                             |  20 ++++
 contrib/libvhost-user/libvhost-user.c |   2 +-
 dump.c                                |   7 ++
 gdb-xml/i386-32bit-core.xml           |  65 ++++++++++++
 gdb-xml/i386-64bit-core.xml           |  73 +++++++++++++
 hw/i386/acpi-build.c                  |  35 +++++-
 hw/pci-host/piix.c                    |   6 --
 hw/scsi/Makefile.objs                 |   2 +-
 hw/scsi/megasas.c                     |  10 +-
 hw/scsi/vhost-scsi-common.c           | 143 +++++++++++++++++++++++++
 hw/scsi/vhost-scsi.c                  | 194 ++++++++++------------------=
------
 hw/scsi/vmw_pvscsi.c                  |   2 +-
 include/hw/acpi/acpi-defs.h           |  77 +++++++-------
 include/hw/i386/pc.h                  |   6 ++
 include/hw/virtio/vhost-scsi-common.h |  48 +++++++++
 include/hw/virtio/vhost-scsi.h        |  11 +-
 include/hw/virtio/virtio-scsi.h       |   2 +
 include/qemu/compiler.h               |   4 +-
 include/sysemu/char.h                 |   2 +-
 include/sysemu/dump.h                 |   1 +
 pc-bios/sgabios.bin                   | Bin 4096 -> 4096 bytes
 qemu-options.hx                       |  22 ++--
 roms/sgabios                          |   2 +-
 scripts/checkpatch.pl                 |  21 ++++
 scripts/get_maintainer.pl             |  53 +++++++---
 target/i386/cpu.c                     |  21 +++-
 target/i386/hax-mem.c                 |  19 +++-
 tests/acpi-utils.h                    |  10 ++
 tests/bios-tables-test.c              |  23 +++-
 util/qemu-thread-posix.c              |  18 +++-
 util/qemu-thread-win32.c              |  11 +-
 util/trace-events                     |   4 +
 vl.c                                  |  25 ++---
 41 files changed, 705 insertions(+), 295 deletions(-)
 create mode 100644 gdb-xml/i386-32bit-core.xml
 create mode 100644 gdb-xml/i386-64bit-core.xml
 create mode 100644 hw/scsi/vhost-scsi-common.c
 create mode 100644 include/hw/virtio/vhost-scsi-common.h
--=20
2.12.2
