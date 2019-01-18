Received: from eggs.gnu.org ([209.51.188.92]:52265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7b-0004wi-QJ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7a-0001I6-Np
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:39 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:14 +0100
Message-Id: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 00/11] s390x updates
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

The following changes since commit 681d61362d3f766a00806b89d6581869041f73cb:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-01-17 12:48:42 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20190118

for you to fetch changes up to 6e92c70c37547b6a247a206651dfcc583a57f484:

  s390x/pci: add common function measurement block (2019-01-18 11:52:01 +0100)

----------------------------------------------------------------
s390x updates:
- clang compilation fixes
- fixes in zpci hotplug code
- handle unimplemented diag 308 subcodes correctly
- add common fmb in zpci

----------------------------------------------------------------

David Hildenbrand (5):
  s390x/pci: Send correct event on hotplug
  s390x/pci: Use hotplug_dev instead of looking up the host bridge
  s390x/pci: Move some hotplug checks to the pre_plug handler
  s390x/pci: Always delete and free the release_timer
  s390x/pci: Ignore the unplug call if we already have a release_timer

Janosch Frank (1):
  s390x: Return specification exception for unimplemented diag 308
    subcodes

Li Qiang (1):
  s390: avoid potential null dereference in s390_pcihost_unplug()

Pierre Morel (1):
  s390x/pci: Set the iommu region size mpcifc request

Thomas Huth (2):
  pc-bios/s390-ccw: Use proper register names for Clang
  configure: Only build the s390-ccw bios if the compiler supports
    -march=z900

Yi Min Zhao (1):
  s390x/pci: add common function measurement block

 configure                |   6 +-
 hw/s390x/s390-pci-bus.c  |  62 +++++++++++-------
 hw/s390x/s390-pci-bus.h  |  29 +++++++++
 hw/s390x/s390-pci-inst.c | 133 ++++++++++++++++++++++++++++++++++++++-
 hw/s390x/s390-pci-inst.h |   1 +
 pc-bios/s390-ccw/start.S |  14 ++---
 target/s390x/diag.c      |   2 +-
 7 files changed, 213 insertions(+), 34 deletions(-)

-- 
2.17.2
