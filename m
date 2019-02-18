Received: from eggs.gnu.org ([209.51.188.92]:52442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqU-000773-JB
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqT-0006s1-PP
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:22 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 18 Feb 2019 12:11:51 +0100
Message-Id: <20190218111153.22681-9-cohuck@redhat.com>
In-Reply-To: <20190218111153.22681-1-cohuck@redhat.com>
References: <20190218111153.22681-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] s390x/cpumodel: add z14 GA2 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Collin Walling <walling@linux.ibm.com>

Introduce the z14 GA2 cpu model for QEMU. There are no new features
introduced with this model, and will inherit the same feature set as
z14 GA1.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190212011657.18324-3-walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c   | 1 +
 target/s390x/gen-features.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 4e7e8cab0198..54026c3c0013 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -79,6 +79,7 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x2964, 13, 2, 47, 0x08000000U, "z13.2", "IBM z13 GA2"),
     CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"),
     CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
+    CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
     CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
 };
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index dd6e8458ef00..44eca4547475 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -353,6 +353,8 @@ static uint16_t base_GEN14_GA1[] = {
     S390_FEAT_ORDER_PRESERVING_COMPRESSION,
 };
 
+#define base_GEN14_GA2 EmptyFeat
+
 /* Full features (in order of release)
  * Automatically includes corresponding base features.
  * Full features are all features this hardware supports even if kvm/QEMU do not
@@ -480,6 +482,8 @@ static uint16_t full_GEN14_GA1[] = {
     S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
 };
 
+#define full_GEN14_GA2 EmptyFeat
+
 /* Default features (in order of release)
  * Automatically includes corresponding base features.
  * Default features are all features this version of QEMU supports for this
@@ -554,6 +558,8 @@ static uint16_t default_GEN14_GA1[] = {
     S390_FEAT_GROUP_MULTIPLE_EPOCH_PTFF,
 };
 
+#define default_GEN14_GA2 EmptyFeat
+
 /* QEMU (CPU model) features */
 
 static uint16_t qemu_V2_11[] = {
@@ -664,6 +670,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
     CPU_FEAT_INITIALIZER(GEN13_GA1),
     CPU_FEAT_INITIALIZER(GEN13_GA2),
     CPU_FEAT_INITIALIZER(GEN14_GA1),
+    CPU_FEAT_INITIALIZER(GEN14_GA2),
 };
 
 #define FEAT_GROUP_INITIALIZER(_name)                  \
-- 
2.17.2
