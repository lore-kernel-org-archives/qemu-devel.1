Received: from eggs.gnu.org ([2001:4830:134:3::10]:54944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPSAx-0007LD-LT
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPSAu-0002W6-IS
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:27:27 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPSAu-0002VV-BE
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:27:24 -0400
Received: by mail-wm0-x236.google.com with SMTP id i127so4896078wma.0
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 04:27:24 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 26 Jun 2017 12:28:09 +0100
Message-Id: <20170626112809.15020-1-alex.bennee@linaro.org>
In-Reply-To: <149838143590.6497.11184953059640962891.stgit@frigg.lan>
References: <149838143590.6497.11184953059640962891.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] maybe fixup! target: [tcg] Redefine DISAS_*
 onto the generic translation framework (DJ_*)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vilanova@ac.upc.edu
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

Arguably these should be applied to nios2 before these changes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/nios2/cpu.h       | 2 --
 target/nios2/op_helper.c | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 13931f3f0b..b6a97c131e 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -259,8 +259,6 @@ static inline int cpu_interrupts_enabled(CPUNios2State *env)
 }
 
 #include "exec/cpu-all.h"
-#include "exec/exec-all.h"
-
 static inline void cpu_get_tb_cpu_state(CPUNios2State *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
diff --git a/target/nios2/op_helper.c b/target/nios2/op_helper.c
index efb1c489c9..04c16e8701 100644
--- a/target/nios2/op_helper.c
+++ b/target/nios2/op_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
+#include "exec/exec-all.h"
 #include "qemu/main-loop.h"
 
 #if !defined(CONFIG_USER_ONLY)
-- 
2.13.0
