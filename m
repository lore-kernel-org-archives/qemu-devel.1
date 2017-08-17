Received: from eggs.gnu.org ([2001:4830:134:3::10]:47624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH0l-0006Za-5N
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH0i-0000HE-2X
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:22:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diH0h-0000Gb-SN
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:22:40 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 17 Aug 2017 11:22:19 +0200
Message-Id: <20170817092225.4264-5-david@redhat.com>
In-Reply-To: <20170817092225.4264-1-david@redhat.com>
References: <20170817092225.4264-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.11 04/10] target/s390x: move
 s390_do_cpu_reset() to diag.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

Only used in that file. Also drop the comment, not really needed.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h  | 7 -------
 target/s390x/diag.c | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 42d4ac0..d8bc134 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -490,13 +490,6 @@ static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
 /* Base/displacement are at the same locations. */
 #define decode_basedisp_rs decode_basedisp_s
 
-/* helper functions for run_on_cpu() */
-static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
-{
-    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
-
-    scc->cpu_reset(cs);
-}
 static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data arg)
 {
     cpu_reset(cs);
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 10ac845..1847cdb 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -39,6 +39,13 @@ static int modified_clear_reset(S390CPU *cpu)
     return 0;
 }
 
+static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
+{
+    S390CPUClass *scc = S390_CPU_GET_CLASS(cs);
+
+    scc->cpu_reset(cs);
+}
+
 static int load_normal_reset(S390CPU *cpu)
 {
     S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
-- 
2.9.4
