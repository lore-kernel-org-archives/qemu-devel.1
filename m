Received: from eggs.gnu.org ([2001:4830:134:3::10]:38856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dI8pK-0000lm-Hy
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dI8pF-0005K2-Q6
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:42129)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dI8pF-0005Ji-I4
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:49 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Tue,  6 Jun 2017 15:22:25 +0800
Message-Id: <20170606072229.9302-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/4] nvdimm: fixes for (non-)dax backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

This is v2 of patch series
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05919.html.

Changes in v2:
* Patch 2: use major/minor numbers of device and sysfs to check
  whether a backend file refers to DAX device. (Dan & Stefan)

* Patch 3: set ACPI_NFIT_MEM_NOT_ARMED bit of state flags in guest
  NVDIMM region mapping structure. This behavior is controlled by a
  new QEMU nvdimm option "restrict". See details in patch 3. (Dan)

* Patch 4: drop the "align" property and get the alignment of DAX
  device by QEMU itself.

* Wrap Linux specific code by __linux__. (Stefan)


Haozhong Zhang (4):
  nvdimm: add a macro for property "label-size"
  nvdimm: warn if the backend is not a DAX device
  nvdimm: add a boolean option "restrict"
  util/mmap-alloc: account for DAX device in qemu_fd_getpagesize

 hw/acpi/nvdimm.c        | 16 ++++++++++
 hw/mem/nvdimm.c         | 44 +++++++++++++++++++++++++-
 include/hw/mem/nvdimm.h |  8 +++++
 include/qemu/osdep.h    | 19 +++++++++++
 util/mmap-alloc.c       |  6 ++++
 util/osdep.c            | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 176 insertions(+), 1 deletion(-)

-- 
2.11.0
