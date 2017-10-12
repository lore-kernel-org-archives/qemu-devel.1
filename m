Received: from eggs.gnu.org ([2001:4830:134:3::10]:44097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxQ-0003IE-Vq
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxQ-0004aV-At
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fxQ-0004Xg-4L
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:03:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fxM-0000c5-8T
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:03:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 17:03:25 +0100
Message-Id: <1507824216-29058-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
References: <1507824216-29058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/13] arm: fix armv7m_init() declaration to
 match definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

s/cpu_model/cpu_type/ that has been forgotten during
conversion (ba1ba5cc), while touching the line also
fixup alignment.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 1507710805-221721-1-git-send-email-imammedo@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
