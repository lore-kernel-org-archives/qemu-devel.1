Received: from eggs.gnu.org ([2001:4830:134:3::10]:48791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFq-0000AY-7i
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFn-00010C-4z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:06 -0400
Received: from mail.kernel.org ([198.145.29.136]:60934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=4WEX=2Z=redhat.com=mst@kernel.org>)
	id 1coLFm-0000ye-Ul
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 22:35:03 -0400
Date: Thu, 16 Mar 2017 04:34:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489631689-6382-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/5] virtio, pci: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f642:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-15 18:44:05 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to bdf4c4ec53f293ea1baa7ce7c31fe0301887b513:

  virtio-serial-bus: Delete timer from list before free it (2017-03-16 01:46:42 +0200)

----------------------------------------------------------------
virtio, pci: fixes

More fixes missed in the previous pull request.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Marcel Apfelbaum (4):
      hw/pcie: fix Extended Configuration Space for devices with no Extended Capabilities
      hw/virtio: fix error enabling flags in Device Control register
      hw/virtio: fix Link Control Register for PCI Express virtio devices
      hw/virtio: fix Power Management Control Register for PCI Express virtio devices

zhanghailiang (1):
      virtio-serial-bus: Delete timer from list before free it

 hw/virtio/virtio-pci.h      | 12 ++++++++++++
 include/hw/compat.h         | 16 ++++++++++++++++
 include/hw/pci/pci.h        |  2 ++
 include/hw/pci/pcie.h       |  5 +++++
 hw/char/virtio-serial-bus.c |  1 +
 hw/pci/pci.c                |  2 ++
 hw/pci/pcie.c               | 20 ++++++++++++++++++++
 hw/virtio/virtio-pci.c      | 31 +++++++++++++++++++++++++++++++
 dtc                         |  2 +-
 9 files changed, 90 insertions(+), 1 deletion(-)
