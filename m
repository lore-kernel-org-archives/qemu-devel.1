Received: from eggs.gnu.org ([2001:4830:134:3::10]:57416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2CSL-0002Pc-Is
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e2CSK-00024e-P6
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:33:33 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 11 Oct 2017 10:33:25 +0200
Message-Id: <1507710805-221721-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] arm: fix armv7m_init() declaration to match
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

s/cpu_model/cpu_type/ that has been forgotten during
conversion (ba1ba5cc), while touching the line also
fixup alignment.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/arm/arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index a3f79d3..ce769bd 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -25,7 +25,7 @@ typedef enum {
 
 /* armv7m.c */
 DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
-                      const char *kernel_filename, const char *cpu_model);
+                         const char *kernel_filename, const char *cpu_type);
 /**
  * armv7m_load_kernel:
  * @cpu: CPU
-- 
2.7.4
