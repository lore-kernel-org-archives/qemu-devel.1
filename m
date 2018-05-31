Received: from eggs.gnu.org ([2001:4830:134:3::10]:50595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fOE56-0004PC-T6
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fOE56-0004Zz-6c
	for qemu-devel@nongnu.org; Wed, 30 May 2018 23:16:52 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Thu, 31 May 2018 11:15:55 +0800
Message-ID: <1527736557-11084-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 0/2] Fix ARM KVM GICv3 get/put data shift bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, Shannon Zhao <zhaoshenglong@huawei.com>

These two patches fix ARM KVM GICv3 get/put data shift bug and add
compatibility fro migration from old qemu to new one.

Major Changes in V5: 
* Add detailed comment as suggested by Peter
* Use memmove instead of memcpy
* Delete .need callback
* set gicd_no_migration_shift_bug to true after move the data

Shannon Zhao (2):
  arm_gicv3_kvm: kvm_dist_get/put_priority: skip the registers banked by
    GICR_IPRIORITYR
  arm_gicv3_kvm: kvm_dist_get/put: skip the registers banked by GICR

 hw/intc/arm_gicv3_common.c         | 79 ++++++++++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_kvm.c            | 56 ++++++++++++++++++++++++++-
 include/hw/intc/arm_gicv3_common.h |  1 +
 3 files changed, 134 insertions(+), 2 deletions(-)

-- 
2.0.4
