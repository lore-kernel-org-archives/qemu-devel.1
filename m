Received: from eggs.gnu.org ([2001:4830:134:3::10]:39572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU8yY-0006Ey-NH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU8yV-0008GB-HH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:25:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cU8yV-0008FF-6G
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:25:43 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AD52635F9
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:25:43 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 19 Jan 2017 17:25:29 +0800
Message-Id: <1484817932-14452-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/3] vfio: allow to notify unmap for very
 big region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, peterx@redhat.com

This requirement originates from the VT-d vfio series:

  https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03495.html

The goal of this series is to allow IOMMU to notify unmap with very
big IOTLB range, for example, with base=0 and size=2^63-1 (to unmap
the whole address space).

The first patch is a good to have, for traces.

The second one is a cleanup of existing code, only.

The third one moves the further RAM translation and check into map
operation logic, so that it'll free unmap operations.

The series is marked as RFC since I am not sure whether this is a
workable way. Anyway, please review to help confirm it.

Thanks.

Peter Xu (3):
  vfio: trace map/unmap for notify as well
  vfio: introduce vfio_get_vaddr()
  vfio: allow to notify unmap for very large region

 hw/vfio/common.c     | 56 ++++++++++++++++++++++++++++++++++------------------
 hw/vfio/trace-events |  2 +-
 2 files changed, 38 insertions(+), 20 deletions(-)

-- 
2.7.4
