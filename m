Received: from eggs.gnu.org ([2001:4830:134:3::10]:52641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luzhipeng@uniudc.com>) id 1gPJfC-00028Q-KD
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 22:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luzhipeng@uniudc.com>) id 1gPJf9-0007Sx-Aq
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 22:58:54 -0500
From: luzhipeng@uniudc.com
Date: Wed, 21 Nov 2018 11:57:42 +0800
Message-Id: <1542772662-2621257-1-git-send-email-luzhipeng@uniudc.com>
Subject: [Qemu-devel] [PATCH] hw/virt/arm: Add support fot Cortex-A72
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, ZhiPeng Lu <luzhipeng@uniudc.com>

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
