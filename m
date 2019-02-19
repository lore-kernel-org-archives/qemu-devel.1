Received: from eggs.gnu.org ([209.51.188.92]:48703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvyZc-0002iP-LT
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gvyZc-0006D0-3m
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:08:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:53031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gvyZb-0006CZ-Rj
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:08:08 -0500
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 19 Feb 2019 14:07:17 +0800
Message-Id: <20190219060719.8211-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] PCDIMM cleanup
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

Two trivial cleanup for pc-dimm.

Patch [1] remove the check on class->hotpluggable since pc-dimm is always
hotpluggable.
Patch [2] remove realized callback since the task is done in pre_plug stage.

Wei Yang (2):
  pc-dimm: remove check on pc-dimm hotpluggable
  pc-dimm: remove realize callback

 hw/acpi/memory_hotplug.c |  5 -----
 hw/mem/nvdimm.c          | 11 -----------
 hw/mem/pc-dimm.c         |  5 -----
 include/hw/mem/pc-dimm.h |  3 ---
 4 files changed, 24 deletions(-)

-- 
2.19.1
