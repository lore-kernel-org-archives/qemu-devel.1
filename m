Received: from eggs.gnu.org ([2001:4830:134:3::10]:33518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dn6S2-0005xG-Jl
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dn6S1-0002Zx-QK
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dn6S1-0002YP-Jb
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:49 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Aug 2017 19:05:59 +0200
Message-Id: <20170830170601.15855-10-david@redhat.com>
In-Reply-To: <20170830170601.15855-1-david@redhat.com>
References: <20170830170601.15855-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 09/11] target/s390x:
 tcg_s390_program_interrupt() will never return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

The assert should hold in both scenarios.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/interrupt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 058e219fe5..79bab5e2f3 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -32,9 +32,8 @@ static void tcg_s390_program_interrupt(CPUS390XState *env, uint32_t code,
 #ifdef CONFIG_TCG
     trigger_pgm_exception(env, code, ilen);
     cpu_loop_exit(CPU(s390_env_get_cpu(env)));
-#else
-    g_assert_not_reached();
 #endif
+    g_assert_not_reached();
 }
 
 void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
-- 
2.13.5
