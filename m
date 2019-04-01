Received: from eggs.gnu.org ([209.51.188.92]:44155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hAxXJ-0005ft-W2
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hAxXH-0000lR-QA
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:03:41 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:58708)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hAxXH-0000kU-DV
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:03:39 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon,  1 Apr 2019 23:03:17 +0900
Message-Id: <20190401140318.80498-12-ysato@users.sourceforge.jp>
In-Reply-To: <20190401140318.80498-1-ysato@users.sourceforge.jp>
References: <20190325090047.122981-1-ysato@users.sourceforge.jp>
	<20190401140318.80498-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC v6 11/12] MAINTAINERS: Add RX
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
 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56139ac8ab..99d3428f04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -272,6 +272,13 @@ F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
 
+RENESAS RX
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+S: Maintained
+F: target/rx/
+F: hw/rx/
+F: include/hw/rx/
+
 S390
 M: Richard Henderson <rth@twiddle.net>
 M: David Hildenbrand <david@redhat.com>
@@ -1099,6 +1106,18 @@ F: pc-bios/canyonlands.dt[sb]
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
