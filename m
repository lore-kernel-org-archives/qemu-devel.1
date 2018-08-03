Received: from eggs.gnu.org ([2001:4830:134:3::10]:54508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flesO-0000To-0s
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1flesJ-00058H-1B
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:32:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1flesI-00057p-Ra
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:32:30 -0400
Date: Fri, 3 Aug 2018 21:32:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180803182100.874220-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL alternative 0/2] pc: regression fix
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

At Peter's request, this version of only including fix for a regression
since 2.12.

The following changes since commit f7502360397d291be04bc040e9f96c92ff2d8030:

  Update version for v3.0.0-rc3 release (2018-07-31 19:30:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream2

for you to fetch changes up to e40e905fe8c6e0e701c3533f7a3cd92a1ad54677:

  tests/acpi: update tables after memory hotplug changes (2018-08-03 21:17:37 +0300)

----------------------------------------------------------------
pc: regression fix

This fixes a regression from 2.12. The fix thus seems
appropriate for 3.0.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Igor Mammedov (1):
      pc: acpi: fix memory hotplug regression by reducing stub SRAT entry size

Michael S. Tsirkin (1):
      tests/acpi: update tables after memory hotplug changes

 hw/i386/acpi-build.c                  |  19 ++++++++++---------
 tests/acpi-test-data/pc/SRAT.dimmpxm  | Bin 472 -> 472 bytes
 tests/acpi-test-data/pc/SRAT.memhp    | Bin 264 -> 264 bytes
 tests/acpi-test-data/q35/SRAT.dimmpxm | Bin 472 -> 472 bytes
 tests/acpi-test-data/q35/SRAT.memhp   | Bin 264 -> 264 bytes
 5 files changed, 10 insertions(+), 9 deletions(-)
