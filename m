Received: from eggs.gnu.org ([2001:4830:134:3::10]:55774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Qg-0004JR-Ov
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Qf-00072E-Ly
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:50 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu9Qf-00071q-G4
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:49 -0500
Received: by mail-pg0-x244.google.com with SMTP id y26so3124872pgv.4
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 20:14:49 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri,  9 Mar 2018 17:12:35 +1300
Message-Id: <1520568765-58189-14-git-send-email-mjc@sifive.com>
In-Reply-To: <1520568765-58189-1-git-send-email-mjc@sifive.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 13/23] RISC-V: Make some header guards more
 specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/hw/riscv/spike.h | 4 ++--
 include/hw/riscv/virt.h  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 8410430..641b70d 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -16,8 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HW_SPIKE_H
-#define HW_SPIKE_H
+#ifndef HW_RISCV_SPIKE_H
+#define HW_RISCV_SPIKE_H
 
 typedef struct {
     /*< private >*/
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index b91a412..3a4f23e 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -16,8 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HW_VIRT_H
-#define HW_VIRT_H
+#ifndef HW_RISCV_VIRT_H
+#define HW_RISCV_VIRT_H
 
 typedef struct {
     /*< private >*/
-- 
2.7.0
