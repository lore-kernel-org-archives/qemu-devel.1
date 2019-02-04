Received: from eggs.gnu.org ([209.51.188.92]:59848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7R-0005cv-Lk
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7O-0003td-I6
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:20 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7M-0003qb-MP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id s12so971676wrt.4
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:35:56 +0100
Message-Id: <1549305379-51117-55-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 54/77] hw/microblaze/Makefile.objs: Create
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
Cc: =?UTF-8?q?=C3=81kos=20Kov=C3=A1cs?= <akoskovacs@gmx.com>

From: Ákos Kovács <akoskovacs@gmx.com>

CONFIG_PETALOGIX_* and CONFIG_XLNX_*  configs added to
default-configs/microblaze-softmmu.mak and
default-configs/microblazeel-softmmu.mak.

Signed-off-by: Ákos Kovács <akoskovacs@gmx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-10-yang.zhong@intel.com>
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
