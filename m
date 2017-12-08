Received: from eggs.gnu.org ([2001:4830:134:3::10]:55957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNAFh-0007p5-W8
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 23:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eNAFe-0005SN-Sx
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 23:27:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eNAFe-0005Rs-Mw
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 23:27:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A905949012
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 04:27:04 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  8 Dec 2017 12:26:52 +0800
Message-Id: <20171208042654.10910-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] vtd: tiny fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Please review.  Thanks,

Peter Xu (2):
  intel_iommu: remove X86_IOMMU_PCI_DEVFN_MAX
  intel_iommu: fix error param in string

 hw/i386/intel_iommu.c       | 12 ++++++------
 include/hw/i386/x86-iommu.h |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.14.3
