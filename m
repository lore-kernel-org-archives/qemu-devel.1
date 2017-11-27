Received: from eggs.gnu.org ([2001:4830:134:3::10]:43856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eJB9i-0007pC-Gf
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 23:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eJB9d-0004v6-I3
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 23:36:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:3941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eJB9d-0004tw-99
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 23:36:25 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 27 Nov 2017 12:35:14 +0800
Message-Id: <20171127043517.22441-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH-for-2.12 v3 0/3] nvdimm: fixes for (non-)dax
 backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

Previous versions can be found at
  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01203.html
  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05919.html

Changes in v3:
 * Add an option 'align' to 'memory-backend-file' to address the
   failure when mmap device dax (patch 1).
 * Remove device dax check, which needs to access sysfs and may not
   work with SELinux.
 * Add a boolean option 'unarmed' to '-device nvdimm', which allows
   users to control the unarmed flag in guest ACPI NFIT. I don't make
   it as OnOffAuto, because of the remove of device dax check.
 * Document new options added by this patch series.

Haozhong Zhang (3):
  hostmem-file: add "align" option
  nvdimm: add a macro for property "label-size"
  nvdimm: add 'unarmed' option

 backends/hostmem-file.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 docs/nvdimm.txt         | 31 +++++++++++++++++++++++++++++++
 exec.c                  |  8 +++++++-
 hw/acpi/nvdimm.c        |  7 +++++++
 hw/mem/nvdimm.c         | 28 +++++++++++++++++++++++++++-
 include/exec/memory.h   |  3 +++
 include/hw/mem/nvdimm.h | 12 ++++++++++++
 memory.c                |  2 ++
 numa.c                  |  2 +-
 9 files changed, 130 insertions(+), 4 deletions(-)

-- 
2.14.1
