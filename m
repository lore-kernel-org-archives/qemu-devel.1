Received: from eggs.gnu.org ([209.51.188.92]:39433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwG9P-00011m-Ur
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 19:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwG9M-0006cF-3o
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 19:54:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:23979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gwG9K-0005Wp-R0
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 19:54:11 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Wed, 20 Feb 2019 08:51:21 +0800
Message-Id: <20190220005124.24224-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] PCDIMM cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, philmd@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

Three trivial cleanup for pc-dimm.

Patch [1] remove the check on class->hotpluggable since pc-dimm is always
hotpluggable.
Patch [2] remove nvdimm_realize
Patch [2] remove pcdimm realize-callback

v2:
  * fix warning in Patch 1
  * split Patch 2 into two

Wei Yang (3):
  pc-dimm: remove check on pc-dimm hotpluggable
  mem/nvdimm: remove nvdimm_realize
  pc-dimm: revert "introduce realize callback"

 hw/acpi/memory_hotplug.c |  5 -----
 hw/mem/nvdimm.c          | 11 -----------
 hw/mem/pc-dimm.c         |  5 -----
 include/hw/mem/pc-dimm.h |  3 ---
 4 files changed, 24 deletions(-)

-- 
2.19.1
