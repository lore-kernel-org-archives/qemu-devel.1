Received: from eggs.gnu.org ([2001:4830:134:3::10]:51643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRqs7-00033t-Uy
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gRqs7-000468-4u
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:50:43 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 28 Nov 2018 20:12:49 +0800
Message-Id: <1543407172-16175-7-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V10 6/9] hw/misc/pvpanic: add configure query
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
 include/hw/misc/pvpanic.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index f1a05b2..dc042cf 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -2,10 +2,12 @@
  * QEMU simulated pvpanic device.
  *
  * Copyright Fujitsu, Corp. 2013
+ * Copyright ZTE Ltd. 2018
  *
  * Authors:
  *     Wen Congyang <wency@cn.fujitsu.com>
  *     Hu Tao <hutao@cn.fujitsu.com>
+ *     Peng Hao <peng.hao2@zte.com.cn>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -28,4 +30,9 @@ static inline uint16_t pvpanic_port(void)
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
