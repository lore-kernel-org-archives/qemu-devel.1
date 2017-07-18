Received: from eggs.gnu.org ([2001:4830:134:3::10]:50668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXOYX-0000Lz-Sk
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXOYT-0002LY-90
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:12:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32889
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dXOYT-0002LO-3J
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:12:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I99NCZ040418
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 05:12:31 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bs6nd4d5m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 05:12:31 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 18 Jul 2017 10:12:30 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 18 Jul 2017 11:12:24 +0200
In-Reply-To: <1500369144-143949-1-git-send-email-borntraeger@de.ibm.com>
References: <1500369144-143949-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500369144-143949-3-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 2/2] s390x/cpumodel: z14 cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

This patch introduces the CPU model for z14, along with all base and
optional features.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_models.c   |  1 +
 target/s390x/gen-features.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c654279..e2ccc32 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -75,6 +75,7 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x2964, 13, 1, 47, 0x08000000U, "z13", "IBM z13 GA1"),
     CPUDEF_INIT(0x2964, 13, 2, 47, 0x08000000U, "z13.2", "IBM z13 GA2"),
     CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"),
+    CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
 };
 
 void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat)
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index af14b11..cf69157 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -338,6 +338,14 @@ static uint16_t base_GEN13_GA1[] = {
 
 #define base_GEN13_GA2 EmptyFeat
 
+static uint16_t base_GEN14_GA1[] = {
+    S390_FEAT_ENTROPY_ENC_COMP,
+    S390_FEAT_MISC_INSTRUCTION_EXT,
+    S390_FEAT_SEMAPHORE_ASSIST,
+    S390_FEAT_TIME_SLICE_INSTRUMENTATION,
+    S390_FEAT_ORDER_PRESERVING_COMPRESSION,
+};
+
 /* Full features (in order of release)
  * Automatically includes corresponding base features.
  * Full features are all features this hardware supports even if kvm/QEMU do not
@@ -442,6 +450,22 @@ static uint16_t full_GEN13_GA1[] = {
 
 #define full_GEN13_GA2 EmptyFeat
 
+static uint16_t full_GEN14_GA1[] = {
+    S390_FEAT_INSTRUCTION_EXEC_PROT,
+    S390_FEAT_GUARDED_STORAGE,
+    S390_FEAT_VECTOR_PACKED_DECIMAL,
+    S390_FEAT_VECTOR_ENH,
+    S390_FEAT_MULTIPLE_EPOCH,
+    S390_FEAT_TEST_PENDING_EXT_INTERRUPTION,
+    S390_FEAT_INSERT_REFERENCE_BITS_MULT,
+    S390_FEAT_GROUP_MSA_EXT_6,
+    S390_FEAT_GROUP_MSA_EXT_7,
+    S390_FEAT_GROUP_MSA_EXT_8,
+    S390_FEAT_CMM_NT,
+    S390_FEAT_HPMA2,
+    S390_FEAT_SIE_KSS,
+};
+
 /* Default features (in order of release)
  * Automatically includes corresponding base features.
  * Default features are all features this version of QEMU supports for this
@@ -502,6 +526,18 @@ static uint16_t default_GEN13_GA1[] = {
 
 #define default_GEN13_GA2 EmptyFeat
 
+static uint16_t default_GEN14_GA1[] = {
+    S390_FEAT_ADAPTER_INT_SUPPRESSION,
+    S390_FEAT_INSTRUCTION_EXEC_PROT,
+    S390_FEAT_GUARDED_STORAGE,
+    S390_FEAT_VECTOR_PACKED_DECIMAL,
+    S390_FEAT_VECTOR_ENH,
+    S390_FEAT_GROUP_MSA_EXT_6,
+    S390_FEAT_GROUP_MSA_EXT_7,
+    S390_FEAT_GROUP_MSA_EXT_8,
+    S390_FEAT_SIE_KSS,
+};
+
 /****** END FEATURE DEFS ******/
 
 #define _YEARS  "2016"
@@ -559,6 +595,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
     CPU_FEAT_INITIALIZER(GEN12_GA2),
     CPU_FEAT_INITIALIZER(GEN13_GA1),
     CPU_FEAT_INITIALIZER(GEN13_GA2),
+    CPU_FEAT_INITIALIZER(GEN14_GA1),
 };
 
 #define FEAT_GROUP_INITIALIZER(_name)                  \
-- 
2.7.4
