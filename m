Received: from eggs.gnu.org ([209.51.188.92]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy4R-0002xb-U8
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy28-0002zM-RX
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:06 -0500
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:36034)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy25-0002u1-5B
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:03 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat,  2 Mar 2019 15:21:38 +0900
Message-Id: <20190302062138.10713-12-ysato@users.sourceforge.jp>
In-Reply-To: <20190302062138.10713-1-ysato@users.sourceforge.jp>
References: <20190122121413.31437-1-ysato@users.sourceforge.jp>
	<20190302062138.10713-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC v3 11/11] MAINTAINERS: Add RX entry.
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

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 MAINTAINERS | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5040d9dfb1..141c4994b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -270,6 +270,14 @@ F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
 
+RX
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+S: Maintained
+F: target/rx/
+F: hw/rx/
+F: include/hw/rx/
+F: disas/rx.c
+
 S390
 M: Richard Henderson <rth@twiddle.net>
 M: David Hildenbrand <david@redhat.com>
@@ -1084,6 +1092,18 @@ F: pc-bios/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
 
+RX Machines
+-----------
+RX-QEMU
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+S: Maintained
+F: hw/rx/rxqemu.c
+F: hw/intc/rx_icu.c
+F: hw/timer/renesas_*.c
+F: hw/char/renesas_sci.c
+F: include/hw/timer/renesas_*.h
+F: include/hw/char/renesas_sci.h
+
 SH4 Machines
 ------------
 R2D
-- 
2.11.0
