Received: from eggs.gnu.org ([2001:4830:134:3::10]:44340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e41Cw-00076O-Fg
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e41Ct-0003vF-F4
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:57:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:51760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1e41Ct-0003tI-6n
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:57:07 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Mon, 16 Oct 2017 16:56:21 +0800
Message-Id: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 0/2] add "nopin" option in the
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xiaoguangrong.eric@gmail.com, ehabkost@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, anthony.xu@intel.com, yang.zhong@intel.com

Qemu does not need pin NVDIMM memory for VFIO device during VFIO
hotplug, what's more, if there is no NVDIMM hw in the test machine,
the VFIO hotplug operation will need at least 10 minutes to pin RAM
as the NVDIMM, this time is not accepted. So we add "nopin=on" option
in the memory-backed-file, which can avoid to pin RAM memory for NVDIMM.

The new command like below:
-object memory-backend-file,id=mem0,share,nopin=on,mem-path=kvm.img,size=9161408512 

The default of "nopin" still "off" value, which is same with previous value.

Yang Zhong (2):
  hostmem-file: Add "nopin" option for memory-backend-file
  nvdimm: Add "nopin" for related documents

 backends/hostmem-file.c | 23 +++++++++++++++++++++++
 docs/nvdimm.txt         | 10 ++++++++--
 hw/vfio/common.c        | 12 +++++++++++-
 qemu-options.hx         |  6 +++++-
 4 files changed, 47 insertions(+), 4 deletions(-)

-- 
1.9.1
