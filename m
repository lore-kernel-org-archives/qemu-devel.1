Received: from eggs.gnu.org ([2001:4830:134:3::10]:35084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihh-0002tF-T8
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihd-00077G-S7
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:41 -0400
Received: from mail.kernel.org ([198.145.29.136]:38640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihd-00076L-MB
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:37 -0400
Date: Wed, 22 Mar 2017 18:01:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1490198476-12244-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/4] virtio, pc: fixes
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

The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:

  Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 807211b76603b094c46a0cd95a3c785f47f3ab73:

  hw/acpi/vmgenid: prevent more than one vmgenid device (2017-03-22 17:56:00 +0200)

----------------------------------------------------------------
virtio, pc: fixes

virtio and misc fixes for 2.9.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Fam Zheng (1):
      virtio: Fix error handling in virtio_bus_device_plugged

Laszlo Ersek (2):
      hw/acpi/vmgenid: prevent device realization on pre-2.5 machine types
      hw/acpi/vmgenid: prevent more than one vmgenid device

Paolo Bonzini (1):
      virtio: always use handle_aio_output if registered

 include/hw/acpi/vmgenid.h |  2 ++
 include/hw/compat.h       |  4 ++++
 hw/acpi/vmgenid.c         | 22 ++++++++++++++++++++++
 hw/virtio/virtio-bus.c    | 20 +++++++++++++++++---
 hw/virtio/virtio.c        | 13 ++++++++++++-
 5 files changed, 57 insertions(+), 4 deletions(-)
