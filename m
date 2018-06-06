Received: from eggs.gnu.org ([2001:4830:134:3::10]:39360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaGA-0004q1-Ky
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQaG8-0003iy-Qd
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:22:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 12:21:25 -0300
Message-Id: <20180606152128.449-9-f4bug@amsat.org>
In-Reply-To: <20180606152128.449-1-f4bug@amsat.org>
References: <20180606152128.449-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/11] target/arm: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f75aa6e9ca..1248d84e6f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4570,7 +4570,7 @@ void hw_breakpoint_update(ARMCPU *cpu, int n)
     case 4: /* unlinked address mismatch (reserved if AArch64) */
     case 5: /* linked address mismatch (reserved if AArch64) */
         qemu_log_mask(LOG_UNIMP,
-                      "arm: address mismatch breakpoint types not implemented");
+                      "arm: address mismatch breakpoint types not implemented\n");
         return;
     case 0: /* unlinked address match */
     case 1: /* linked address match */
@@ -4604,7 +4604,7 @@ void hw_breakpoint_update(ARMCPU *cpu, int n)
     case 8: /* unlinked VMID match (reserved if no EL2) */
     case 10: /* unlinked context ID and VMID match (reserved if no EL2) */
         qemu_log_mask(LOG_UNIMP,
-                      "arm: unlinked context breakpoint types not implemented");
+                      "arm: unlinked context breakpoint types not implemented\n");
         return;
     case 9: /* linked VMID match (reserved if no EL2) */
     case 11: /* linked context ID and VMID match (reserved if no EL2) */
-- 
2.17.1
