Received: from eggs.gnu.org ([2001:4830:134:3::10]:50462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqj6-0001FO-Ru
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1frqiy-00081m-6D
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:24:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1frqiv-0007yd-K5
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:24:25 -0400
Date: Mon, 20 Aug 2018 23:24:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180820104045.133968-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/7] pc: fixes
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

The following changes since commit f7502360397d291be04bc040e9f96c92ff2d8030:

  Update version for v3.0.0-rc3 release (2018-07-31 19:30:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 56eb90af39abf66c0e80588a9f50c31e7df7320b:

  migration/ram: ensure write persistence on loading all data to PMEM. (2018-08-10 13:29:39 +0300)

----------------------------------------------------------------
pc: fixes

This includes nvdimm persistence fixes queued before the release.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Junyan He (7):
      memory, exec: Expose all memory block related flags.
      memory, exec: switch file ram allocation functions to 'flags' parameters
      configure: add libpmem support
      hostmem-file: add the 'pmem' option
      mem/nvdimm: ensure write persistence to PMEM in label emulation
      migration/ram: Add check and info message to nvdimm post copy.
      migration/ram: ensure write persistence on loading all data to PMEM.

 docs/nvdimm.txt         | 22 ++++++++++++++++++++++
 configure               | 29 +++++++++++++++++++++++++++++
 include/exec/memory.h   | 31 +++++++++++++++++++++++++++++--
 include/exec/ram_addr.h | 28 ++++++++++++++++++++++++++--
 include/qemu/pmem.h     | 36 ++++++++++++++++++++++++++++++++++++
 backends/hostmem-file.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 exec.c                  | 38 +++++++++++++-------------------------
 hw/mem/nvdimm.c         |  9 ++++++++-
 memory.c                |  8 +++++---
 migration/ram.c         | 17 +++++++++++++++++
 numa.c                  |  2 +-
 qemu-options.hx         |  7 +++++++
 12 files changed, 235 insertions(+), 36 deletions(-)
 create mode 100644 include/qemu/pmem.h
