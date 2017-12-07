Received: from eggs.gnu.org ([2001:4830:134:3::10]:38881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eN0hN-0008Im-Gy
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eN0hJ-0006nT-Mg
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:15:05 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Dec 2017 18:14:52 +0000
Message-Id: <1512670493-18114-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 5/6] hw/arm/virt: Add "max" to the list of CPU
 types "virt" supports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>

Allow the virt board to support '-cpu max' in the same way
it already handles '-cpu host'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 62af013..92bd776 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -167,6 +167,7 @@ static const char *valid_cpus[] = {
     ARM_CPU_TYPE_NAME("cortex-a53"),
     ARM_CPU_TYPE_NAME("cortex-a57"),
     ARM_CPU_TYPE_NAME("host"),
+    ARM_CPU_TYPE_NAME("max"),
 };
 
 static bool cpu_type_valid(const char *cpu)
-- 
2.7.4
