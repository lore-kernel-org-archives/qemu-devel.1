Received: from eggs.gnu.org ([2001:4830:134:3::10]:52236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSA-0004ou-P3
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS3-0004bv-1B
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqS2-0004RY-Q0
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:02 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS1-0005Ri-Gj
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:01 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:38 +0100
Message-Id: <1504527967-29248-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/36] target/arm: Fix outdated comment about
 exception exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When we switched our handling of exception exit to detect
the magic addresses at translate time rather than via
a do_unassigned_access hook, we forgot to update a
comment; correct the omission.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-8-git-send-email-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8190682..2fb0202 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6138,7 +6138,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     bool rettobase = false;
 
     /* We can only get here from an EXCP_EXCEPTION_EXIT, and
-     * arm_v7m_do_unassigned_access() enforces the architectural rule
+     * gen_bx_excret() enforces the architectural rule
      * that jumps to magic addresses don't have magic behaviour unless
      * we're in Handler mode (compare pseudocode BXWritePC()).
      */
-- 
2.7.4
