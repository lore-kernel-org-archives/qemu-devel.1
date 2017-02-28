Received: from eggs.gnu.org ([2001:4830:134:3::10]:42958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibX1-0001oB-Lc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibWy-0003Dw-JY
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:45:07 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:56 +0300
Message-Id: <6c608953a5512b556fd0913d740e932366d6bb5d.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 13/14] hw/acpi/tco.c: fix tco timer stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Pavlikevich <ipavlikevich@gmail.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Igor Pavlikevich <ipavlikevich@gmail.com>

TCO timer does not actually stop

Signed-off-by: Igor Pavlikevich <ipavlikevich@gmail.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/acpi/tco.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
index 8ce7daf..b4adac8 100644
--- a/hw/acpi/tco.c
+++ b/hw/acpi/tco.c
@@ -49,6 +49,7 @@ static inline void tco_timer_reload(TCOIORegs *tr)
 static inline void tco_timer_stop(TCOIORegs *tr)
 {
     tr->expire_time = -1;
+    timer_del(tr->tco_timer);
 }
 
 static void tco_timer_expired(void *opaque)
-- 
2.1.4
