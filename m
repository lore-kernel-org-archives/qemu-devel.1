Received: from eggs.gnu.org ([2001:4830:134:3::10]:49569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwlB-0003ax-4U
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dcwlA-0004na-Dv
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:44:37 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  2 Aug 2017 17:43:53 +0100
Message-Id: <1501692241-23310-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 07/15] target/arm: Fix outdated comment about
 exception exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

When we switched our handling of exception exit to detect
the magic addresses at translate time rather than via
a do_unassigned_access hook, we forgot to update a
comment; correct the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fd83a21..cb88c66 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6143,7 +6143,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     bool rettobase = false;
 
     /* We can only get here from an EXCP_EXCEPTION_EXIT, and
-     * arm_v7m_do_unassigned_access() enforces the architectural rule
+     * gen_bx_excret() enforces the architectural rule
      * that jumps to magic addresses don't have magic behaviour unless
      * we're in Handler mode (compare pseudocode BXWritePC()).
      */
-- 
2.7.4
