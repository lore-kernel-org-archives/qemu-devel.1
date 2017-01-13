Received: from eggs.gnu.org ([2001:4830:134:3::10]:52978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvLr-0005sn-7v
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvLq-0001tY-Fd
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:28:39 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:07 +1100
Message-Id: <1484288903-18807-2-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 01/17] powerpc/cpu-models: rename ISAv3.00
 logical PVR definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This logical PVR value now corresponds to ISA version 3.00 so rename it
accordingly.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/cpu-models.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index aafbbd7..d587e69 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -601,7 +601,7 @@ enum {
     CPU_POWERPC_LOGICAL_2_06       = 0x0F000003,
     CPU_POWERPC_LOGICAL_2_06_PLUS  = 0x0F100003,
     CPU_POWERPC_LOGICAL_2_07       = 0x0F000004,
-    CPU_POWERPC_LOGICAL_2_08       = 0x0F000005,
+    CPU_POWERPC_LOGICAL_3_00       = 0x0F000005,
 };
 
 /* System version register (used on MPC 8xxx)                                */
-- 
2.5.5
