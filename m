Received: from eggs.gnu.org ([2001:4830:134:3::10]:47883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1eyBgW-0001Bu-Ex
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 03:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1eyBgV-00006h-KX
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 03:27:52 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Tue, 20 Mar 2018 15:26:47 +0800
Message-ID: <1521530809-11780-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/2] two fixes for KVM GICv3 dist get/put
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com

Changes in V2:
* patch 1 use the existing variable
* patch 2 add more comments to explain the problem

Shannon Zhao (2):
  arm_gicv3_kvm: increase clroffset accordingly
  arm_gicv3_kvm: kvm_dist_get/put: skip the registers banked by GICR

 hw/intc/arm_gicv3_kvm.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

-- 
2.0.4
