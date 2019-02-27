Received: from eggs.gnu.org ([209.51.188.92]:53037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gyu0d-0006r4-6k
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 02:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gyu0c-0004oe-3q
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 02:52:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:4827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gyu0b-0004iU-Mg
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 02:52:05 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed, 27 Feb 2019 15:50:57 +0800
Message-Id: <20190227075101.6263-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] nvdimm: clean up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, Wei Yang <richardw.yang@linux.intel.com>

Here are 4 cleanup patches for nvdimm.

The first three are trivial clean on argument/variable.
The last one move setup place of the FIT table.

Wei Yang (4):
  nvdimm: fix typo in nvdimm_build_nvdimm_devices argument
  nvdimm: use *function* directly instead of allocating it again
  nvdimm: use NVDIMM_ACPI_IO_LEN for the proper IO size
  nvdimm: build FIT in nvdimm_build_acpi

 hw/acpi/nvdimm.c        | 14 +++++---------
 hw/i386/pc.c            |  5 -----
 include/hw/mem/nvdimm.h |  1 -
 3 files changed, 5 insertions(+), 15 deletions(-)

-- 
2.19.1
