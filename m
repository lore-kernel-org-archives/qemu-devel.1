Received: from eggs.gnu.org ([2001:4830:134:3::10]:48168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1deplS-0005HB-8p
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 17:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1deplN-0006Qp-6e
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 17:40:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1deplM-0006QZ-RZ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 17:40:37 -0400
Date: Tue, 8 Aug 2017 00:40:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1502142009-9370-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/2] virtio: fix for rc2
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

The following changes since commit e6a74868d92f858ac33915b6772999d7de2fd288:

  build-sys: add --disable-vhost-user (2017-08-03 15:55:41 +0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to e2a7f28693aea7e194ec1435697ec4feb24f8a6f:

  cpu: add APIs to allocate/free CPU environment (2017-08-08 00:31:09 +0300)

----------------------------------------------------------------
virtio: fix for rc2

It turns out there's a way to setup SHPC on Q35: just put
a PCI to PCI bridge behind a DMI to PCI one. Our _OSC is
thus incorrect.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Aleksandr Bezzubikov (1):
      hw/i386: allow SHPC for Q35 machine

Michael S. Tsirkin (1):
      cpu: add APIs to allocate/free CPU environment

 include/qom/cpu.h    | 31 +++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c |  4 ++--
 qom/cpu.c            | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)
