Received: from eggs.gnu.org ([2001:4830:134:3::10]:55286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7dN1-0001a3-Kv
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7dMy-0000eI-Dk
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:18:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e7dMy-0000da-7G
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:18:28 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 26 Oct 2017 10:18:19 +0200
Message-Id: <20171026081819.28032-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH] tcg: fix x86 compilation with !CONFIG_TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Richard Henderson <richard.henderson@linaro.org>

This commit:

commit 55c3ceef61fcf06fc98ddc752b7cce788ce7680b
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Sun Oct 15 19:02:42 2017 -0700

    qom: Introduce CPUClass.tcg_initialize

Brocke compilation without CONFIG_TCG

Signed-off-by: Juan Quintela <quintela@redhat.com>
CC: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 53ec94ac9b..100a55688f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4212,7 +4212,9 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
 #endif
     cc->cpu_exec_enter = x86_cpu_exec_enter;
     cc->cpu_exec_exit = x86_cpu_exec_exit;
+#ifdef CONFIG_TCG
     cc->tcg_initialize = tcg_x86_init;
+#endif 
 
     dc->user_creatable = true;
 }
-- 
2.13.6
