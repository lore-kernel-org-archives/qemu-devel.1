Received: from eggs.gnu.org ([2001:4830:134:3::10]:35238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIwxL-0007ML-PX
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fIwxL-000630-1e
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:59:03 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 16 May 2018 14:03:02 -0400
Message-Id: <1526493784-25328-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] ARM SMMUv3: Fix a couple of Coverity issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org

This series includes 2 patches that fix Coverity issues respectively
in smmuv3 and smmu-common code.

Eric Auger (2):
  hw/arm/smmuv3: Fix Coverity issue in smmuv3_record_event
  hw/arm/smmu-common: Fix coverity issue in get_block_pte_address

 hw/arm/smmu-common.c | 4 ++--
 hw/arm/smmuv3.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.3.1
