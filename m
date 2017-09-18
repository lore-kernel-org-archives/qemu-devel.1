Received: from eggs.gnu.org ([2001:4830:134:3::10]:53824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1du3zV-0001Gb-Gr
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 17:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1du3zR-0006H9-D5
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 17:54:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 18 Sep 2017 18:53:51 -0300
Message-Id: <20170918215351.16318-1-f4bug@amsat.org>
In-Reply-To: <1505318697-77161-6-git-send-email-imammedo@redhat.com>
References: <1505318697-77161-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] !fixup arm: missed comment update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Based-on: 1505318697-77161-6-git-send-email-imammedo@redhat.com

 include/hw/arm/armv7m.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 68cb30d611..9ad316c76e 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -35,7 +35,7 @@ typedef struct {
 /* ARMv7M container object.
  * + Unnamed GPIO input lines: external IRQ lines for the NVIC
  * + Named GPIO output SYSRESETREQ: signalled for guest AIRCR.SYSRESETREQ
- * + Property "cpu-model": CPU model to instantiate
+ * + Property "cpu-type": CPU type to instantiate
  * + Property "num-irq": number of external IRQ lines
  * + Property "memory": MemoryRegion defining the physical address space
  *   that CPU accesses see. (The NVIC, bitbanding and other CPU-internal
-- 
2.14.1
