Received: from eggs.gnu.org ([2001:4830:134:3::10]:45890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1frjgt-00073E-Uw
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1frjgq-0005mW-QK
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:53:51 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 20 Aug 2018 14:53:34 +0200
Message-Id: <20180820125341.5882-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] s390x patches for 3.1
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

The following changes since commit 627fce617868df87b3757375a2a0318ad2beb381:

  tests/boot-serial-test: Bump timeout to 6 minutes (2018-08-20 10:39:27 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180820

for you to fetch changes up to 09c6c754804df4d997f84fd9c17d90c5b4ce948c:

  s390x: Enable KVM huge page backing support (2018-08-20 14:18:49 +0200)

----------------------------------------------------------------
First round of s390x patches for 3.1:
- add compat machine for 3.1
- remove deprecated 's390-squash-mcss' option
- cpu models: add "max" cpu model, enhance feature group code
- kvm: add support for etoken facility and huge page backing

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/kvm: add etoken facility

Cornelia Huck (3):
  s390x: introduce 3.1 compat machine
  s390x: remove 's390-squash-mcss' option
  linux-headers: update

David Hildenbrand (1):
  s390x/cpumodel: Add "-cpu max" support

Janosch Frank (1):
  s390x: Enable KVM huge page backing support

Michael Mueller (1):
  s390x/cpumodel: enum type S390FeatGroup now gets generated

 hw/s390x/3270-ccw.c                            |   5 +-
 hw/s390x/css-bridge.c                          |   1 -
 hw/s390x/css.c                                 |   6 +-
 hw/s390x/s390-ccw.c                            |   4 +-
 hw/s390x/s390-virtio-ccw.c                     |  54 +++-----
 hw/s390x/virtio-ccw.c                          |   5 +-
 include/hw/compat.h                            |   3 +
 include/hw/s390x/css-bridge.h                  |   1 -
 include/hw/s390x/css.h                         |   9 +-
 include/hw/s390x/s390-virtio-ccw.h             |   1 -
 include/standard-headers/asm-x86/kvm_para.h    |   1 +
 include/standard-headers/drm/drm_fourcc.h      | 176 +++++++++++++++++++++++++
 include/standard-headers/linux/ethtool.h       |  11 +-
 include/standard-headers/linux/pci_regs.h      |   4 +-
 include/standard-headers/linux/virtio_config.h |  16 ++-
 linux-headers/asm-generic/unistd.h             |   4 +-
 linux-headers/asm-mips/unistd.h                |  18 ++-
 linux-headers/asm-powerpc/kvm.h                |   1 +
 linux-headers/asm-powerpc/unistd.h             |   1 +
 linux-headers/asm-s390/kvm.h                   |   5 +-
 linux-headers/asm-s390/unistd_32.h             |   2 +
 linux-headers/asm-s390/unistd_64.h             |   2 +
 linux-headers/asm-x86/kvm.h                    |  37 ++++++
 linux-headers/linux/kvm.h                      |   5 +
 linux-headers/linux/vhost.h                    |  18 +++
 qemu-deprecated.texi                           |   8 --
 qemu-options.hx                                |  10 --
 target/s390x/cpu.c                             |  10 --
 target/s390x/cpu.h                             |   4 +-
 target/s390x/cpu_features.c                    |   4 +-
 target/s390x/cpu_features.h                    |  19 +--
 target/s390x/cpu_features_def.h                |   3 +-
 target/s390x/cpu_models.c                      |  82 ++++++++----
 target/s390x/gen-features.c                    |  21 ++-
 target/s390x/kvm.c                             |  46 ++++++-
 target/s390x/machine.c                         |  20 ++-
 36 files changed, 460 insertions(+), 157 deletions(-)

-- 
2.14.4
