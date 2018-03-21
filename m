Received: from eggs.gnu.org ([2001:4830:134:3::10]:53097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eykeR-00023L-G9
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eykeP-00027N-63
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:48:02 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eykeO-000277-Vx
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:48:01 -0400
Received: by mail-pg0-x241.google.com with SMTP id m24so2398510pgv.8
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 13:48:00 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 21 Mar 2018 13:46:48 -0700
Message-Id: <1521665220-3869-13-git-send-email-mjc@sifive.com>
In-Reply-To: <1521665220-3869-1-git-send-email-mjc@sifive.com>
References: <1521665220-3869-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/24] RISC-V: Make some header guards more
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
