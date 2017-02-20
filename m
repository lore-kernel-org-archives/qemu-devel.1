Received: from eggs.gnu.org ([2001:4830:134:3::10]:39754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cffDd-0008UJ-Aw
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cffDc-0002Wb-Bc
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 23:04:57 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Mon, 20 Feb 2017 15:04:30 +1100
Message-Id: <1487563478-22265-3-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 02/10] target/ppc: Fix LPCR DPFD
 mask define
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, sjitindarsingh@gmail.com

The DPFD field in the LPCR is 3 bits wide. This has always been defined
as 0x3 << shift which indicates a 2 bit field, which is incorrect.
Correct this.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index bc2a2ce..bb96dd5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -381,7 +381,7 @@ struct ppc_slb_t {
 #define LPCR_ISL          (1ull << (63 - 2))
 #define LPCR_KBV          (1ull << (63 - 3))
 #define LPCR_DPFD_SHIFT   (63 - 11)
-#define LPCR_DPFD         (0x3ull << LPCR_DPFD_SHIFT)
+#define LPCR_DPFD         (0x7ull << LPCR_DPFD_SHIFT)
 #define LPCR_VRMASD_SHIFT (63 - 16)
 #define LPCR_VRMASD       (0x1full << LPCR_VRMASD_SHIFT)
 #define LPCR_RMLS_SHIFT   (63 - 37)
-- 
2.5.5
