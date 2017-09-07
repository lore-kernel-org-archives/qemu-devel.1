Received: from eggs.gnu.org ([2001:4830:134:3::10]:38856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3BZ-00044V-6M
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3BU-00028E-KU
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dq3BU-00027p-Dv
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:13:56 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Sep 2017 22:13:19 +0200
Message-Id: <20170907201335.13956-6-david@redhat.com>
In-Reply-To: <20170907201335.13956-1-david@redhat.com>
References: <20170907201335.13956-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/21] target/s390x: move typedef of S390CPU
 to its definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

Let's move it to the place where struct S390CPU is defined.

Suggested-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu-qom.h | 2 --
 target/s390x/cpu.h     | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index 4e936e7788..c8fbf8ae03 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -61,6 +61,4 @@ typedef struct S390CPUClass {
     void (*initial_cpu_reset)(CPUState *cpu);
 } S390CPUClass;
 
-typedef struct S390CPU S390CPU;
-
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 0bd97a5670..a7426ef6e2 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -187,7 +187,7 @@ static inline CPU_DoubleU *get_freg(CPUS390XState *cs, int nr)
  *
  * An S/390 CPU.
  */
-struct S390CPU {
+typedef struct S390CPU {
     /*< private >*/
     CPUState parent_obj;
     /*< public >*/
@@ -198,7 +198,7 @@ struct S390CPU {
     /* needed for live migration */
     void *irqstate;
     uint32_t irqstate_saved_size;
-};
+} S390CPU;
 
 static inline S390CPU *s390_env_get_cpu(CPUS390XState *env)
 {
-- 
2.13.5
