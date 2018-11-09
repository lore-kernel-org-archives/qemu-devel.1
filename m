Received: from eggs.gnu.org ([2001:4830:134:3::10]:53744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gL5KQ-0004Wu-0b
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gL5KM-0006zM-N7
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:51:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:56441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gL5KM-0006rm-Dm
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:51:54 -0500
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Date: Fri,  9 Nov 2018 19:49:44 +0800
Message-Id: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
Subject: [Qemu-devel] [PATCH v1 0/3] intel-iommu: add support for 5-level
 virtual IOMMU.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>

Intel's upcoming processors will extend maximum linear address width to
57 bits, and introduce 5-level paging for CPU. Meanwhile, the platform
will also extend the maximum guest address width for IOMMU to 57 bits,
thus introducing the 5-level paging for 2nd level translation(See chapter 3
in Intel Virtualization Technology for Directed I/O). 

This patch set extends the current logic to support a wider address width.
A 5-level paging capable IOMMU(for 2nd level translation) can be rendered
with configuration "device intel-iommu,x-aw-bits=57".


Yu Zhang (3):
  intel-iommu: differentiate host address width from IOVA address width.
  intel-iommu: extend VTD emulation to allow 57-bit IOVA address width.
  intel-iommu: search iotlb for levels supported by the address width.
---
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: Igor Mammedov <imammedo@redhat.com> 
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com> 
Cc: Richard Henderson <rth@twiddle.net> 
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Xu <peterx@redhat.com>


 hw/i386/acpi-build.c           |   2 +-
 hw/i386/intel_iommu.c          | 101 +++++++++++++++++++++++++++--------------
 hw/i386/intel_iommu_internal.h |  13 ++++--
 include/hw/i386/intel_iommu.h  |  10 ++--
 4 files changed, 83 insertions(+), 43 deletions(-)

-- 
1.9.1
