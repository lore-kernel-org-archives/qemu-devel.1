Received: from eggs.gnu.org ([2001:4830:134:3::10]:37377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9PVL-0007AB-PR
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9PKI-0003gp-Om
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:47:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g9PKI-0003fw-Hz
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 02:47:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C73481254
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 06:47:33 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  8 Oct 2018 14:47:11 +0800
Message-Id: <20181008064713.27349-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] intel_iommu: handle invalid ce for
 shadow sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Eric Auger <eric.auger@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Pei Zhang <pezhang@redhat.com>

v2:
- split patch into more, remove useless comment [Eric]
- remove one error_report_once() when rework the code [Jason]

This series fixes a QEMU crash reported here:

https://bugzilla.redhat.com/show_bug.cgi?id=1627272

Please review, thanks.

Peter Xu (2):
  intel_iommu: move ce fetching out when sync shadow
  intel_iommu: handle invalid ce for shadow sync

 dtc                   |  2 +-
 hw/i386/intel_iommu.c | 55 +++++++++++++++++++++++--------------------
 2 files changed, 30 insertions(+), 27 deletions(-)

-- 
2.17.1
