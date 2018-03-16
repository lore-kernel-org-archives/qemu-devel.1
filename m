Received: from eggs.gnu.org ([2001:4830:134:3::10]:40331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFH-0007Tq-7A
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFG-0003mY-0O
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:31 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:46819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ewvFF-0003mL-Qb
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:29 -0400
Received: by mail-pl0-x244.google.com with SMTP id f5-v6so6484927plj.13
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:42:29 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 12:41:10 -0700
Message-Id: <1521229281-73637-14-git-send-email-mjc@sifive.com>
In-Reply-To: <1521229281-73637-1-git-send-email-mjc@sifive.com>
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 13/24] RISC-V: Make some header guards more
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
