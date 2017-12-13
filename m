Received: from eggs.gnu.org ([2001:4830:134:3::10]:54872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eOzRK-0008To-7J
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 00:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eOzRJ-0004Vv-BB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 00:18:42 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 02:17:34 -0300
Message-Id: <20171213051736.17755-3-f4bug@amsat.org>
In-Reply-To: <20171213051736.17755-1-f4bug@amsat.org>
References: <20171213051736.17755-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/4] hw/registerfields: fix a typo in the
 FIELD() documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/registerfields.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index af101d5ae6..ad9d7a82a3 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -22,7 +22,7 @@
 
 /* Define SHIFT, LENGTH and MASK constants for a field within a register */
 
-/* This macro will define FOO_BAR_MASK, FOO_BAR_SHIFT and FOO_BAR_LENGTH 
+/* This macro will define R_FOO_BAR_MASK, R_FOO_BAR_SHIFT and R_FOO_BAR_LENGTH
  * constants for field BAR in register FOO.
  */
 #define FIELD(reg, field, shift, length)                                  \
-- 
2.15.1
