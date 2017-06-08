Received: from eggs.gnu.org ([2001:4830:134:3::10]:59166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ3EL-0001QT-VX
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ3EI-0007j4-1i
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dJ3EH-0007iy-Rj
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:25 -0400
Date: Thu, 8 Jun 2017 22:36:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496950567-26343-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] pc, pci, vhost: fixes
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

The following changes since commit 64175afc695c0672876fbbfc31b299c86d562c=
b4:

  arm_gicv3: Fix ICC_BPR1 reset value when EL3 not implemented (2017-06-0=
7 17:21:44 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to bc277a52fbea1532d1adf30ba0edf15ab3dcdead:

  hw/pcie: fix the generic pcie root port to support migration (2017-06-0=
8 22:02:37 +0300)

----------------------------------------------------------------
pc, pci, vhost: fixes

Some fixes all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Haozhong Zhang (1):
      nvdimm acpi: fix region format interface code

Marc-Andr=C3=A9 Lureau (1):
      vhost-user-bridge: fix iov_restore_front() warning

Marcel Apfelbaum (1):
      hw/pcie: fix the generic pcie root port to support migration

 include/hw/compat.h                |  4 ++++
 hw/acpi/nvdimm.c                   |  7 ++++---
 hw/pci-bridge/gen_pcie_root_port.c | 25 +++++++++++++++++++++++++
 tests/vhost-user-bridge.c          | 11 +++++++++--
 4 files changed, 42 insertions(+), 5 deletions(-)
