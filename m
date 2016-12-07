Received: from eggs.gnu.org ([2001:4830:134:3::10]:40665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEVA3-0005yx-2B
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 00:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEV9y-0000Wu-7p
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 00:52:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cEV9y-0000WG-1f
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 00:52:54 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0CC64E357
	for <qemu-devel@nongnu.org>; Wed,  7 Dec 2016 05:52:51 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  7 Dec 2016 13:52:43 +0800
Message-Id: <1481089965-3888-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/2] VT-d extend GAW to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, famz@redhat.com, peterx@redhat.com, mst@redhat.com

The first patch did some check to make sure the CE GAW bits are always
valid (it can overflow in old codes, I see it dangerous).

The second patch extended VT-d GAW (Guest Address Width) from 39 bits
to 48 bits.

Please review. Thanks,

Peter Xu (2):
  intel_iommu: check validity for GAW bits in CE
  intel_iommu: extend supported guest aw to 48 bits

 hw/i386/intel_iommu.c          | 12 +++++++++++-
 hw/i386/intel_iommu_internal.h |  7 +++++--
 include/hw/i386/intel_iommu.h  |  2 +-
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.7.4
