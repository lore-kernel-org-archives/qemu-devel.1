Received: from eggs.gnu.org ([2001:4830:134:3::10]:53847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fMAof-0003Kj-LU
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fMAoe-0002z4-V8
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:23:25 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Fri, 25 May 2018 19:22:49 +0800
Message-ID: <1527247371-10592-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/2] Fix ARM KVM GICv3 get/put data shift bug
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

Major Changes in V4: 
* Fix the kvm_dist_get/put_priority in a separate patch since it doesn't
need migration compatibility.
* Fix the data within post-load function

Shannon Zhao (2):
  arm_gicv3_kvm: kvm_dist_get/put_priority: skip the registers banked by
    GICR_IPRIORITYR
  arm_gicv3_kvm: kvm_dist_get/put: skip the registers banked by GICR

 hw/intc/arm_gicv3_common.c         | 66 ++++++++++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_kvm.c            | 48 +++++++++++++++++++++++++--
 include/hw/intc/arm_gicv3_common.h |  1 +
 3 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.0.4
