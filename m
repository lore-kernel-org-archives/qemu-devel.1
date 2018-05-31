Received: from eggs.gnu.org ([2001:4830:134:3::10]:58449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8O-0003WW-Av
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8L-0008QR-Qb
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59670 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8L-0008Q3-N5
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CCA840201A0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:13:05 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE4B22026DEF
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:13:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:11 +0200
Message-Id: <20180531171253.21012-12-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/53] nios2: do not include exec-all.h from
 cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

exec-all.h contains TCG-specific declarations, it should only be
includer from helper C files.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/nios2/cpu.h       | 1 -
 target/nios2/op_helper.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 145796e8ce..047f3764b7 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -260,7 +260,6 @@ static inline int cpu_interrupts_enabled(CPUNios2State *env)
 }
 
 #include "exec/cpu-all.h"
-#include "exec/exec-all.h"
 
 static inline void cpu_get_tb_cpu_state(CPUNios2State *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
diff --git a/target/nios2/op_helper.c b/target/nios2/op_helper.c
index c853aeae02..529ec6ac0e 100644
--- a/target/nios2/op_helper.c
+++ b/target/nios2/op_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
+#include "exec/exec-all.h"
 #include "qemu/main-loop.h"
 
 #if !defined(CONFIG_USER_ONLY)
-- 
2.17.0
