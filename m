Received: from eggs.gnu.org ([2001:4830:134:3::10]:42988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gYnQB-00048k-Cu
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gYnNC-0002gt-Em
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:31:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gYnNC-0002ez-8a
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 02:31:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59AE681F0F
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 07:31:27 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Dec 2018 15:31:09 +0800
Message-Id: <20181217073114.11984-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] intel_iommu: fix windows svvp verification,
 and trivial cleanups
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

Patch 1-2: mostly for debugging purpose, either on continuous
           converting tracepoints into error reports, or fix incorrect
           debug messages.

Patch 3:   enable dma read/write draining support for vt-d emulation.
           The major reason is to pass Windows SVVP verification.

Patch 4-5: some tunes on existing VT-d parameters, either name or
           default value.  This turns IR on by default for 4.0 or later.

Please review.  Thanks.

Peter Xu (5):
  intel_iommu: dump correct iova when failed
  intel_iommu: convert invalid traces into error reports
  intel_iommu: dma read/write draining support
  intel_iommu: remove "x-" prefix for "aw-bits"
  intel_iommu: turn on IR by default

 hw/i386/intel_iommu.c          | 66 +++++++++++++++++++++++++---------
 hw/i386/intel_iommu_internal.h |  3 ++
 hw/i386/trace-events           |  6 ----
 hw/i386/x86-iommu.c            |  2 +-
 include/hw/i386/intel_iommu.h  |  1 +
 include/hw/i386/pc.h           |  9 +++++
 6 files changed, 63 insertions(+), 24 deletions(-)

-- 
2.17.1
