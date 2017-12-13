Received: from eggs.gnu.org ([2001:4830:134:3::10]:54915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eOzRU-000085-OM
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 00:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eOzRT-0004ac-Q5
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 00:18:52 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 02:17:35 -0300
Message-Id: <20171213051736.17755-4-f4bug@amsat.org>
In-Reply-To: <20171213051736.17755-1-f4bug@amsat.org>
References: <20171213051736.17755-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/4] hw/registerfields: add 64-bit
 extract/deposit macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/registerfields.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index ad9d7a82a3..f59e7f47bd 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -35,6 +35,9 @@
 #define FIELD_EX32(storage, reg, field)                                   \
     extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
               R_ ## reg ## _ ## field ## _LENGTH)
+#define FIELD_EX64(storage, reg, field)                                   \
+    extract64((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
+              R_ ## reg ## _ ## field ## _LENGTH)
 
 /* Extract a field from an array of registers */
 #define ARRAY_FIELD_EX32(regs, reg, field)                                \
@@ -52,6 +55,14 @@
     d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
                   R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
     d; })
+#define FIELD_DP64(storage, reg, field, val) ({                           \
+    struct {                                                              \
+        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
+    } v = { .v = val };                                                   \
+    uint64_t d;                                                           \
+    d = deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
+                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
+    d; })
 
 /* Deposit a field to array of registers.  */
 #define ARRAY_FIELD_DP32(regs, reg, field, val)                           \
-- 
2.15.1
