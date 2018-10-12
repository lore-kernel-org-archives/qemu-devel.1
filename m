Received: from eggs.gnu.org ([2001:4830:134:3::10]:45377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAuFt-0000on-9V
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gAuFp-0007Hd-5k
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:01:13 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 12 Oct 2018 12:00:53 +0200
Message-Id: <20181012100101.29058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 0/8] s390x updates
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

The following changes since commit 75e50c80e051423a6f55a34ee4a1eec842444a5b:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-10-10' into staging (2018-10-11 10:43:37 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20181012

for you to fetch changes up to 0161215d435ef5680c4623bcbdfe89ce5b35cf42:

  hw/s390x: Include the tod-qemu also for builds with --disable-tcg (2018-10-12 11:32:19 +0200)

----------------------------------------------------------------
More s390x updates:
- introduce support for vfio-ap (s390 crypto devices), including a
  Linux headers update to get the new interfaces
- the usual fixing + cleanup

----------------------------------------------------------------

Cornelia Huck (1):
  linux-headers: update

Thomas Huth (2):
  target/s390x/excp_helper: Remove DPRINTF() macro
  hw/s390x: Include the tod-qemu also for builds with --disable-tcg

Tony Krowiak (5):
  s390x/cpumodel: Set up CPU model for AP device support
  s390x/kvm: enable AP instruction interpretation for guest
  s390x/ap: base Adjunct Processor (AP) object model
  s390x/vfio: ap: Introduce VFIO AP device
  s390: doc: detailed specifications for AP virtualization

 MAINTAINERS                            |  16 +
 default-configs/s390x-softmmu.mak      |   1 +
 docs/vfio-ap.txt                       | 825 +++++++++++++++++++++++++++++++++
 hw/s390x/Makefile.objs                 |   4 +-
 hw/s390x/ap-bridge.c                   |  78 ++++
 hw/s390x/ap-device.c                   |  38 ++
 hw/s390x/s390-virtio-ccw.c             |   4 +
 hw/vfio/Makefile.objs                  |   1 +
 hw/vfio/ap.c                           | 181 ++++++++
 include/hw/s390x/ap-bridge.h           |  19 +
 include/hw/s390x/ap-device.h           |  22 +
 include/hw/vfio/vfio-common.h          |   1 +
 include/standard-headers/linux/input.h |   9 +-
 linux-headers/asm-arm/kvm.h            |  13 +
 linux-headers/asm-arm64/kvm.h          |  13 +
 linux-headers/asm-s390/kvm.h           |   2 +
 linux-headers/asm-x86/kvm.h            |   1 +
 linux-headers/linux/kvm.h              |   2 +
 linux-headers/linux/vfio.h             |   2 +
 linux-headers/linux/vhost.h            |   2 +-
 target/s390x/cpu_features.c            |   3 +
 target/s390x/cpu_features_def.h        |   3 +
 target/s390x/cpu_models.c              |   2 +
 target/s390x/excp_helper.c             |  48 +-
 target/s390x/gen-features.c            |   3 +
 target/s390x/kvm.c                     |  19 +
 26 files changed, 1269 insertions(+), 43 deletions(-)
 create mode 100644 docs/vfio-ap.txt
 create mode 100644 hw/s390x/ap-bridge.c
 create mode 100644 hw/s390x/ap-device.c
 create mode 100644 hw/vfio/ap.c
 create mode 100644 include/hw/s390x/ap-bridge.h
 create mode 100644 include/hw/s390x/ap-device.h

-- 
2.14.4
