Received: from eggs.gnu.org ([2001:4830:134:3::10]:48118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luzhipeng@uniudc.com>) id 1gRb9A-0000hw-27
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luzhipeng@uniudc.com>) id 1gRb94-0000eU-FG
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:03:14 -0500
From: luzhipeng@uniudc.com
Date: Tue, 27 Nov 2018 19:02:45 +0800
Message-Id: <1543316565-1101590-1-git-send-email-luzhipeng@uniudc.com>
Subject: [Qemu-devel] [PATCH RESEND] hw/virt/arm: Add support for Cortex-A72
 in virt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, ZhiPeng Lu <luzhipeng@uniudc.com>

From: ZhiPeng Lu <luzhipeng@uniudc.com>

Signed-off-by: ZhiPeng Lu <luzhipeng@uniudc.com>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a2b8d8f..f69e7eb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -174,6 +174,7 @@ static const char *valid_cpus[] = {
     ARM_CPU_TYPE_NAME("cortex-a15"),
     ARM_CPU_TYPE_NAME("cortex-a53"),
     ARM_CPU_TYPE_NAME("cortex-a57"),
+    ARM_CPU_TYPE_NAME("cortex-a72"),
     ARM_CPU_TYPE_NAME("host"),
     ARM_CPU_TYPE_NAME("max"),
 };
-- 
1.8.3.1
