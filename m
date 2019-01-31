Received: from eggs.gnu.org ([209.51.188.92]:35713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qM-00067r-Ic
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qL-0002fd-Sc
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:60061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6qL-0002Yq-Jz
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:33:01 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:16 +0800
Message-Id: <20190131073234.18037-10-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 09/27] hw/microblaze/Makefile.objs: Create
 configs for petalogix and xilinx boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

CONFIG_PETALOGIX_* and CONFIG_XLNX_*  configs added to
default-configs/microblaze-softmmu.mak and
default-configs/microblazeel-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
