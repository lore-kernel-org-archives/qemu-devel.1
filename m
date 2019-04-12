Received: from eggs.gnu.org ([209.51.188.92]:38693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFM-0001ZC-CO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFL-0002Fd-6C
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:32 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 12 Apr 2019 14:25:06 +0200
Message-Id: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 00/17] vfio-ccw dasd ipl
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, borntraeger@de.ibm.com

This pull request is not for master.

 Hi Cornelia,

the following changes since commit 532cc6da74ec25b5ba6893b5757c977d545829=
49:

  Update version for v4.0.0-rc3 release (2019-04-10 15:38:59 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/s390-ccw-bios-2019-04-12

for you to fetch changes up to 4a33fac54665558b7f7a68135c4a4c602eceb72f:

  pc-bios/s390: Update firmware images (2019-04-12 12:40:35 +0200)

----------------------------------------------------------------
Support for booting from a vfio-ccw passthrough dasd device
----------------------------------------------------------------

Jason J. Herne (16):
      s390 vfio-ccw: Add bootindex property and IPLB data
      s390-bios: decouple cio setup from virtio
      s390-bios: decouple common boot logic from virtio
      s390-bios: Clean up cio.h
      s390-bios: Decouple channel i/o logic from virtio
      s390-bios: Map low core memory
      s390-bios: ptr2u32 and u32toptr
      s390-bios: Support for running format-0/1 channel programs
      s390-bios: cio error handling
      s390-bios: Extend find_dev() for non-virtio devices
      s390-bios: Factor finding boot device out of virtio code path
      s390-bios: Refactor virtio to run channel programs via cio
      s390-bios: Use control unit type to determine boot method
      s390-bios: Add channel command codes/structs needed for dasd-ipl
      s390-bios: Support booting from real dasd device
      s390-bios: Use control unit type to find bootable devices

Thomas Huth (1):
      pc-bios/s390: Update firmware images

 MAINTAINERS                  |   2 +
 docs/devel/s390-dasd-ipl.txt | 133 ++++++++++++++
 hw/s390x/ipl.c               |  61 +++++--
 hw/s390x/s390-ccw.c          |   9 +
 hw/vfio/ccw.c                |   6 +-
 include/hw/s390x/s390-ccw.h  |   1 +
 include/hw/s390x/vfio-ccw.h  |  28 +++
 pc-bios/s390-ccw.img         | Bin 34568 -> 42608 bytes
 pc-bios/s390-ccw/Makefile    |   2 +-
 pc-bios/s390-ccw/cio.c       | 423 +++++++++++++++++++++++++++++++++++++=
++++++
 pc-bios/s390-ccw/cio.h       | 270 +++++++++++++++++++++------
 pc-bios/s390-ccw/dasd-ipl.c  | 235 ++++++++++++++++++++++++
 pc-bios/s390-ccw/dasd-ipl.h  |  16 ++
 pc-bios/s390-ccw/helper.h    |  31 ++++
 pc-bios/s390-ccw/libc.h      |  11 ++
 pc-bios/s390-ccw/main.c      | 190 +++++++++++++------
 pc-bios/s390-ccw/netboot.mak |   2 +-
 pc-bios/s390-ccw/netmain.c   |   2 +
 pc-bios/s390-ccw/s390-arch.h | 103 +++++++++++
 pc-bios/s390-ccw/s390-ccw.h  |  10 +-
 pc-bios/s390-ccw/start.S     |  29 +++
 pc-bios/s390-ccw/virtio.c    |  81 +++------
 pc-bios/s390-netboot.img     | Bin 54944 -> 67232 bytes
 tests/boot-serial-test.c     |   2 +-
 24 files changed, 1446 insertions(+), 201 deletions(-)
 create mode 100644 docs/devel/s390-dasd-ipl.txt
 create mode 100644 include/hw/s390x/vfio-ccw.h
 create mode 100644 pc-bios/s390-ccw/cio.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.h
 create mode 100644 pc-bios/s390-ccw/helper.h
 create mode 100644 pc-bios/s390-ccw/s390-arch.h
