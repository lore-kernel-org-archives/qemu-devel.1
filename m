Received: from eggs.gnu.org ([209.51.188.92]:38470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHU-0001LR-Ic
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHS-0003Wi-Td
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:48 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:37759)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hFuHS-0003WE-Ji
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:35:46 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 15 Apr 2019 14:35:31 +0900
Message-Id: <20190415053531.77264-14-ysato@users.sourceforge.jp>
In-Reply-To: <20190415053531.77264-1-ysato@users.sourceforge.jp>
References: <20190415053531.77264-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC v7 12/12] include/hw/regiserfields.h: Add
 8bit and 16bit registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, peter.maydell@linaro.org, richard.henderson@linaro.org

Some RX peripheral using 8bit and 16bit registers.
Added 8bit and 16bit APIs.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/registerfields.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index 2659a58737..f6bf911990 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -22,6 +22,14 @@
     enum { A_ ## reg = (addr) };                                          \
     enum { R_ ## reg = (addr) / 4 };
 
+#define REG8(reg, addr)                                                  \
+    enum { A_ ## reg = (addr) };                                          \
+    enum { R_ ## reg = (addr) };
+
+#define REG16(reg, addr)                                                  \
+    enum { A_ ## reg = (addr) };                                          \
+    enum { R_ ## reg = (addr) / 2 };
+
 /* Define SHIFT, LENGTH and MASK constants for a field within a register */
 
 /* This macro will define R_FOO_BAR_MASK, R_FOO_BAR_SHIFT and R_FOO_BAR_LENGTH
@@ -40,6 +48,8 @@
 #define FIELD_EX64(storage, reg, field)                                   \
     extract64((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
               R_ ## reg ## _ ## field ## _LENGTH)
+#define FIELD_EX8  FIELD_EX32
+#define FIELD_EX16 FIELD_EX32
 
 /* Extract a field from an array of registers */
 #define ARRAY_FIELD_EX32(regs, reg, field)                                \
-- 
2.11.0
