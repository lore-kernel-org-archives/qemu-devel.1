Received: from eggs.gnu.org ([2001:4830:134:3::10]:33967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV5u-0004Ib-Ta
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV5r-00071V-Jw
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:30 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 May 2018 09:24:59 +0200
Message-Id: <20180504072514.8450-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 00/15] first s390x update for 2.13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 6f0c4706b35dead265509115ddbd2a8d1af516c1:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180427-pull-request' into staging (2018-04-27 12:27:59 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180504

for you to fetch changes up to 532cd4b067d37b96496dbacbfab6c990c063d33d:

  Merge tag 'tags/s390x-2018-05-02' into staging (2018-05-03 16:33:01 +0200)

----------------------------------------------------------------
First s390x pull request for 2.13.
- new machine type
- extend SCLP event masks
- support configuration of consoles via -serial
- firmware improvements: non-sequential entries in boot menu, support
  for indirect loading via .INS files in s390-netboot
- bugfixes and cleanups

----------------------------------------------------------------

Claudio Imbrenda (1):
  s390x/sclp: extend SCLP event masks to 64 bits

Collin Walling (4):
  pc-bios/s390-ccw: rename MAX_TABLE_ENTRIES to MAX_BOOT_ENTRIES
  pc-bios/s390-ccw: fix loadparm initialization and int conversion
  pc-bios/s390-ccw: fix non-sequential boot entries (eckd)
  pc-bios/s390-ccw: fix non-sequential boot entries (enum)

Cornelia Huck (2):
  s390x: introduce 2.13 compat machine
  s390-ccw: force diag 308 subcode to unsigned long

David Hildenbrand (1):
  s390x/kvm: cleanup calls to cpu_synchronize_state()

Greg Kurz (1):
  vfio-ccw: introduce vfio_ccw_get_device()

Thomas Huth (6):
  hw/s390x: Allow to configure the consoles with the "-serial" parameter
  pc-bios/s390-ccw: size_t should be unsigned
  pc-bios/s390-ccw/net: Split up net_load() into init, load and release
    parts
  pc-bios/s390-ccw/net: Use diag308 to reset machine before jumping to
    the OS
  pc-bios/s390-ccw/net: Add support for .INS config files
  pc-bios/s390: Update firmware images

 hw/s390x/event-facility.c         |  64 +++++++++++++--
 hw/s390x/ipl.c                    |   4 +
 hw/s390x/s390-pci-inst.c          |   8 --
 hw/s390x/s390-virtio-ccw.c        |  36 +++++++-
 hw/vfio/ccw.c                     |  56 ++++++++-----
 include/hw/boards.h               |   1 -
 include/hw/s390x/event-facility.h |   4 +-
 pc-bios/s390-ccw.img              | Bin 30520 -> 34568 bytes
 pc-bios/s390-ccw/Makefile         |   4 +-
 pc-bios/s390-ccw/bootmap.c        |  79 +++---------------
 pc-bios/s390-ccw/bootmap.h        |   6 --
 pc-bios/s390-ccw/iplb.h           |   3 +-
 pc-bios/s390-ccw/jump2ipl.c       |  91 +++++++++++++++++++++
 pc-bios/s390-ccw/libc.c           |   2 +-
 pc-bios/s390-ccw/libc.h           |   2 +-
 pc-bios/s390-ccw/main.c           |  14 ++--
 pc-bios/s390-ccw/menu.c           |  58 +++++++++----
 pc-bios/s390-ccw/netboot.mak      |   3 +-
 pc-bios/s390-ccw/netmain.c        | 168 +++++++++++++++++++++++++++++++-------
 pc-bios/s390-ccw/s390-ccw.h       |   8 +-
 pc-bios/s390-netboot.img          | Bin 83856 -> 87872 bytes
 target/s390x/kvm.c                |  20 +----
 tests/boot-serial-test.c          |   3 +-
 vl.c                              |  50 ------------
 24 files changed, 436 insertions(+), 248 deletions(-)
 create mode 100644 pc-bios/s390-ccw/jump2ipl.c

-- 
2.14.3
