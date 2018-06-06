Received: from eggs.gnu.org ([2001:4830:134:3::10]:39289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaG5-0004fK-6M
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaG3-0003fg-Sk
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:21:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 12:21:23 -0300
Message-Id: <20180606152128.449-7-f4bug@amsat.org>
In-Reply-To: <20180606152128.449-1-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/11] hw/mips/boston: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/boston.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 5302e5c885..52cce19766 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -176,7 +176,7 @@ static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
     uint32_t gic_freq, val;
 
     if (size != 4) {
-        qemu_log_mask(LOG_UNIMP, "%uB platform register read", size);
+        qemu_log_mask(LOG_UNIMP, "%uB platform register read\n", size);
         return 0;
     }
 
@@ -205,7 +205,7 @@ static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
         val |= PLAT_DDR_CFG_MHZ;
         return val;
     default:
-        qemu_log_mask(LOG_UNIMP, "Read platform register 0x%" HWADDR_PRIx,
+        qemu_log_mask(LOG_UNIMP, "Read platform register 0x%" HWADDR_PRIx "\n",
                       addr & 0xffff);
         return 0;
     }
@@ -215,7 +215,7 @@ static void boston_platreg_write(void *opaque, hwaddr addr,
                                  uint64_t val, unsigned size)
 {
     if (size != 4) {
-        qemu_log_mask(LOG_UNIMP, "%uB platform register write", size);
+        qemu_log_mask(LOG_UNIMP, "%uB platform register write\n", size);
         return;
     }
 
@@ -237,7 +237,7 @@ static void boston_platreg_write(void *opaque, hwaddr addr,
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "Write platform register 0x%" HWADDR_PRIx
-                      " = 0x%" PRIx64, addr & 0xffff, val);
+                      " = 0x%" PRIx64 "\n", addr & 0xffff, val);
         break;
     }
 }
-- 
2.17.1
