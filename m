Received: from eggs.gnu.org ([2001:4830:134:3::10]:56884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRF8h-0000Jj-Sj
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRF8f-0001yw-7K
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:33:19 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Tue, 27 Nov 2018 03:55:59 +0800
Message-Id: <1543262162-6351-7-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543262162-6351-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543262162-6351-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V9 6/9] hw/misc/pvpanic: add configure query
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

Add configure query interface for pvpanic-mmio.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 include/hw/misc/pvpanic.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index f1a05b2..2f0e9f4 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -28,4 +28,9 @@ static inline uint16_t pvpanic_port(void)
     return object_property_get_uint(o, PVPANIC_IOPORT_PROP, NULL);
 }
 
+static inline Object *pvpanic_mmio(void)
+{
+    return object_resolve_path_type("", TYPE_PVPANIC_MMIO, NULL);
+}
+
 #endif
-- 
1.8.3.1
