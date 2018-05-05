Received: from eggs.gnu.org ([2001:4830:134:3::10]:54314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6jv-00043h-Jx
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6ju-0003l1-Ot
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:19 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:39484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fF6ju-0003jP-K3
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:18 -0400
Received: by mail-pf0-x241.google.com with SMTP id a22so5989475pfn.6
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 16:37:18 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sun,  6 May 2018 11:35:13 +1200
Message-Id: <1525563325-62963-9-git-send-email-mjc@sifive.com>
In-Reply-To: <1525563325-62963-1-git-send-email-mjc@sifive.com>
References: <1525563325-62963-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/20] RISC-V: Make some header guards more
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
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/spike.h | 4 ++--
 include/hw/riscv/virt.h  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 8410430614b7..641b70da67b6 100644
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
index b91a4125dd61..3a4f23e8d075 100644
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
