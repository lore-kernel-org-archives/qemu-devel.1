Received: from eggs.gnu.org ([2001:4830:134:3::10]:52663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cSiPU-0002pd-43
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 05:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cSiPT-0006Ws-Iv
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 05:51:40 -0500
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Sun, 15 Jan 2017 18:51:02 +0800
Message-ID: <1484477462-14088-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] arm: virt: Fix the segmentation fault when
 specifying an unsupported CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, zhaoshenglong@huawei.com, wu.wubin@huawei.com

From: Shannon Zhao <shannon.zhao@linaro.org>

For example, using -cpu generic will cause qemu segmentation fault.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7a03f84..4b301c2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -175,7 +175,7 @@ static bool cpuname_valid(const char *cpu)
     int i;
 
     for (i = 0; i < ARRAY_SIZE(valid_cpus); i++) {
-        if (strcmp(cpu, valid_cpus[i]) == 0) {
+        if (valid_cpus[i] != NULL && strcmp(cpu, valid_cpus[i]) == 0) {
             return true;
         }
     }
-- 
2.0.4
