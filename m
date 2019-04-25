Received: from eggs.gnu.org ([209.51.188.92]:58250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJm-00031l-NK
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJl-0003Yz-QM
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:38 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 25 Apr 2019 15:21:15 +0200
Message-Id: <20190425132134.2839-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 00/19] first batch of s390x patches for 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:

  Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190425

for you to fetch changes up to 41c3d4269b1c18d12d33c5bf089dace25d08e82e:

  Merge tag 's390-ccw-bios-2019-04-12' into s390-next-staging (2019-04-25 14:09:20 +0200)

----------------------------------------------------------------
- properly detect page size of initial memory
- support for IPL (boot) from ECKD DASD passed through via vfio-ccw

----------------------------------------------------------------

Cornelia Huck (1):
      Merge tag 's390-ccw-bios-2019-04-12' into s390-next-staging

David Hildenbrand (2):
  s390x/kvm: Configure page size after memory has actually been
    initialized
  exec: Introduce qemu_maxrampagesize() and rename qemu_getrampagesize()

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

-- 
2.17.2
