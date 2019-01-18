Received: from eggs.gnu.org ([209.51.188.92]:35837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSGd-0008Is-OR
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkSGb-0005iu-MG
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:24:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:46976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkSGZ-0005dV-Qr
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:24:53 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 18 Jan 2019 19:23:32 +0800
Message-Id: <20190118112410.3010-6-yang.zhong@intel.com>
In-Reply-To: <20190118112410.3010-1-yang.zhong@intel.com>
References: <20190118112410.3010-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v3 05/43] hw/microblaze/Makefile.objs:
 Create configs for petalogix and xilinx boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

CONFIG_PETALOGIX_* and CONFIG_XLNX_*  configs added to
default-configs/microblaze-softmmu.mak and
default-configs/microblazeel-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/microblaze-softmmu.mak | 3 +++
 hw/microblaze/Makefile.objs            | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/default-configs/microblaze-softmmu.mak b/default-configs/microblaze-softmmu.mak
index 7fca8e4c99..14837cf74a 100644
--- a/default-configs/microblaze-softmmu.mak
+++ b/default-configs/microblaze-softmmu.mak
@@ -10,3 +10,6 @@ CONFIG_XILINX_ETHLITE=y
 CONFIG_SSI=y
 CONFIG_SSI_M25P80=y
 CONFIG_XLNX_ZYNQMP=y
+CONFIG_PETALOGIX_S3ADSP1800=y
+CONFIG_PETALOGIX_ML605=y
+CONFIG_XLNX_ZYNQMP_PMU=y
diff --git a/hw/microblaze/Makefile.objs b/hw/microblaze/Makefile.objs
index ae9fd40de7..8595a62f6c 100644
--- a/hw/microblaze/Makefile.objs
+++ b/hw/microblaze/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += petalogix_s3adsp1800_mmu.o
-obj-y += petalogix_ml605_mmu.o
-obj-y += xlnx-zynqmp-pmu.o
+obj-$(CONFIG_PETALOGIX_S3ADSP1800) += petalogix_s3adsp1800_mmu.o
+obj-$(CONFIG_PETALOGIX_ML605) += petalogix_ml605_mmu.o
+obj-$(CONFIG_XLNX_ZYNQMP_PMU) += xlnx-zynqmp-pmu.o
 obj-y += boot.o
-- 
2.17.1
