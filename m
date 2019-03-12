Received: from eggs.gnu.org ([209.51.188.92]:39205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3WCB-0001VD-PM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3WAl-0005Nd-0b
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:25:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:51647)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1h3WAk-0005MY-OO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:25:38 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 12 Mar 2019 09:24:54 +0800
Message-Id: <20190312012457.8092-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] nvdimm: clean up
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

Here are three trivial cleanup on argument/variable.

---
v2:
  * remove the last one which breaks hotplug

Wei Yang (3):
  nvdimm: fix typo in nvdimm_build_nvdimm_devices argument
  nvdimm: use *function* directly instead of allocating it again
  nvdimm: use NVDIMM_ACPI_IO_LEN for the proper IO size

 hw/acpi/nvdimm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.19.1
