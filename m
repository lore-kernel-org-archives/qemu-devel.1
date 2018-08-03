Received: from eggs.gnu.org ([2001:4830:134:3::10]:57265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flWNP-0003xM-Qu
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flWNK-0001xF-TP
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1flWNK-0001uW-Me
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:27:58 -0400
Date: Fri, 3 Aug 2018 12:27:55 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180803083830.775669-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/5] pc, virtio: fixes
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

Please consider for 3.0 if there is another rc.

The following changes since commit f7502360397d291be04bc040e9f96c92ff2d8030:

  Update version for v3.0.0-rc3 release (2018-07-31 19:30:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 1c707d6990eaf3db0c9dc4557bba5458977e9f8d:

  tests/acpi: update tables after memory hotplug changes (2018-08-03 11:35:21 +0300)

----------------------------------------------------------------
pc, virtio: fixes

A couple of last minute fixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dou Liyang (2):
      hw/acpi-build: Add a check for memory-less NUMA nodes
      tests/acpi-test: update ACPI tables test blobs

Igor Mammedov (1):
      pc: acpi: fix memory hotplug regression by reducing stub SRAT entry size

Michael S. Tsirkin (1):
      tests/acpi: update tables after memory hotplug changes

Tiwei Bie (1):
      vhost: check region type before casting

 hw/i386/acpi-build.c                  |  28 ++++++++++++++++------------
 hw/virtio/vhost.c                     |   4 +++-
 tests/acpi-test-data/pc/SRAT.dimmpxm  | Bin 472 -> 472 bytes
 tests/acpi-test-data/pc/SRAT.memhp    | Bin 264 -> 264 bytes
 tests/acpi-test-data/pc/SRAT.numamem  | Bin 224 -> 224 bytes
 tests/acpi-test-data/q35/SRAT.dimmpxm | Bin 472 -> 472 bytes
 tests/acpi-test-data/q35/SRAT.memhp   | Bin 264 -> 264 bytes
 tests/acpi-test-data/q35/SRAT.numamem | Bin 224 -> 224 bytes
 8 files changed, 19 insertions(+), 13 deletions(-)
