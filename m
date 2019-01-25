Received: from eggs.gnu.org ([209.51.188.92]:57877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOe-0007TP-Li
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOZ-0001eM-00
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:34 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOT-0001ZH-Dt
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:26 -0500
Received: by mail-wr1-x434.google.com with SMTP id s12so9630998wrt.4
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:28 +0100
Message-Id: <1548410831-19553-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/52] hw/microblaze/Makefile.objs: Create
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
Cc: yang.zhong@intel.com, thuth@redhat.com, =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

CONFIG_PETALOGIX_* and CONFIG_XLNX_*  configs added to
default-configs/microblaze-softmmu.mak and
default-configs/microblazeel-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20190123065618.3520-7-yang.zhong@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/microblaze-softmmu.mak | 3 +++
 hw/microblaze/Makefile.objs            | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/default-configs/microblaze-softmmu.mak b/default-configs/microblaze-softmmu.mak
index 7fca8e4..14837cf 100644
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
index ae9fd40..8595a62 100644
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
1.8.3.1
