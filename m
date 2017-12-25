Received: from eggs.gnu.org ([2001:4830:134:3::10]:48694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eTHEC-00064Y-Kk
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 20:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eTHE9-0007n9-GF
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 20:06:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:19628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eTHE9-0007jz-97
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 20:06:49 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 25 Dec 2017 09:06:09 +0800
Message-Id: <20171225010611.32621-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 0/2] mem/nvdimm: ensure persistence of QEMU
 writes to real NVDIMM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

QEMU intercepts guest writes to vNVDIMM labels, and then stores them
to the backend. When the backend is a real NVDIMM device, QEMU needs
to ensure the write persistence before returning to guest, so that the
guest labels will not be lost if QEMU exits abnormally.

Haozhong Zhang (2):
  util/pmem: add function to make writes to pmem persistent
  mem/nvdimm: ensure persistence of QEMU writes to real NVDIMM device

 hw/mem/nvdimm.c     |   3 ++
 include/qemu/pmem.h |  25 ++++++++++
 util/Makefile.objs  |   1 +
 util/pmem.c         | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+)
 create mode 100644 include/qemu/pmem.h
 create mode 100644 util/pmem.c

-- 
2.14.1
