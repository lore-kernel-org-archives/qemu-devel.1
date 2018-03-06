Received: from eggs.gnu.org ([2001:4830:134:3::10]:47108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJTB-0006SC-Nf
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJTA-0003XX-Qc
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:57 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJTA-0003XP-KP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:56 -0500
Received: by mail-pg0-x244.google.com with SMTP id r26so8748196pgv.13
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:45:56 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:43:48 +1300
Message-Id: <1520369037-37977-14-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369037-37977-1-git-send-email-mjc@sifive.com>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 13/22] RISC-V: Make spike and virt header
 guards more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches specific <patches@groups.riscv.org>

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/hw/riscv/spike.h | 4 ++--
 include/hw/riscv/virt.h  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 179b6cf..ed9d1db 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -16,8 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HW_SPIKE_H
-#define HW_SPIKE_H
+#ifndef HW_RISCV_SPIKE_H
+#define HW_RISCV_SPIKE_H
 
 #define TYPE_RISCV_SPIKE_V1_09_1_BOARD "riscv.spike_v1_9_1"
 #define TYPE_RISCV_SPIKE_V1_10_0_BOARD "riscv.spike_v1_10"
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 9588909..d22f184 100644
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
     RISCVHartArrayState soc;
-- 
2.7.0
