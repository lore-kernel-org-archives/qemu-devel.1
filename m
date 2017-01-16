Received: from eggs.gnu.org ([2001:4830:134:3::10]:48737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cT3bj-0002z8-13
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1cT3bi-00027k-9j
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 04:29:43 -0500
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Mon, 16 Jan 2017 17:27:00 +0800
Message-ID: <1484558821-15512-6-git-send-email-zhaoshenglong@huawei.com>
In-Reply-To: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
References: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC 5/6] arm: virt: Enable generic type CPU in
 virt machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, drjones@redhat.com, christoffer.dall@linaro.org, kvmarm@lists.cs.columbia.edu, zhaoshenglong@huawei.com, wu.wubin@huawei.com

From: Shannon Zhao <shannon.zhao@linaro.org>

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4b301c2..49b7b65 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -166,6 +166,7 @@ static const char *valid_cpus[] = {
     "cortex-a15",
     "cortex-a53",
     "cortex-a57",
+    "generic",
     "host",
     NULL
 };
-- 
2.0.4
