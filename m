Received: from eggs.gnu.org ([2001:4830:134:3::10]:46255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iW-00028v-IW
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iV-0000Bj-Dn
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:56 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:16 -0500
Message-Id: <20180619014319.28272-51-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 050/113] tcg: Mark muluh_i64 and mulsh_i64 as
 64-bit ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Failure to do so results in the tcg optimizer sign-extending
any constant fold from 32-bits.  This turns out to be visible
in the RISC-V testsuite using a host that emits these opcodes
(e.g. any non-x86_64).

Reported-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit f2f1dde75160cac6ede330f3db50dc817d01a2d6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tcg/tcg-opc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 956fb1e9f3..bb28b863ce 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -182,8 +182,8 @@ DEF(add2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_add2_i64))
 DEF(sub2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_sub2_i64))
 DEF(mulu2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulu2_i64))
 DEF(muls2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muls2_i64))
-DEF(muluh_i64, 1, 2, 0, IMPL(TCG_TARGET_HAS_muluh_i64))
-DEF(mulsh_i64, 1, 2, 0, IMPL(TCG_TARGET_HAS_mulsh_i64))
+DEF(muluh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muluh_i64))
+DEF(mulsh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulsh_i64))
 
 #define TLADDR_ARGS  (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? 1 : 2)
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
-- 
2.11.0
