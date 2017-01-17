Received: from eggs.gnu.org ([2001:4830:134:3::10]:45280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cTJMs-00010O-Ob
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 21:19:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cTJMp-0003wI-Js
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 21:19:26 -0500
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Tue, 17 Jan 2017 10:15:34 +0800
Message-ID: <1484619334-10488-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] arm: virt: Fix the segmentation fault when
 specifying an unsupported CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, zhaoshenglong@huawei.com, wu.wubin@huawei.com

From: Shannon Zhao <shannon.zhao@linaro.org>

For example, using -cpu generic will cause qemu segmentation fault.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
V2: Just remove the member NULL instead of checking twice
---
 hw/arm/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7a03f84..95ac585 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -167,7 +167,6 @@ static const char *valid_cpus[] = {
     "cortex-a53",
     "cortex-a57",
     "host",
-    NULL
 };
 
 static bool cpuname_valid(const char *cpu)
-- 
2.0.4
