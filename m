Received: from eggs.gnu.org ([209.51.188.92]:49165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gsENO-0001ES-JM
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gsENK-0007FF-Om
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:12:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41480
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gsENK-0007EF-JI
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:11:58 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x18M8lCD098914
	for <qemu-devel@nongnu.org>; Fri, 8 Feb 2019 17:11:54 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qhgk3c4rv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 17:11:54 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Fri, 8 Feb 2019 22:11:54 -0000
From: Collin Walling <walling@linux.ibm.com>
Date: Fri,  8 Feb 2019 17:11:11 -0500
In-Reply-To: <20190208221111.25237-1-walling@linux.ibm.com>
References: <20190208221111.25237-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190208221111.25237-2-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] s390x/cpumodel: add z14 GA2 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com, rth@twiddle.net

Introduce the z14 GA2 cpu model for QEMU. There are no new features
introduced with this model, and will inherit the same feature set as
z14 GA1.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 target/s390x/cpu_models.c   | 1 +
 target/s390x/gen-features.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 7c253ff308..968c21cd47 100644
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
index d258d67dca..3026fbd88e 100644
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
@@ -553,6 +557,8 @@ static uint16_t default_GEN14_GA1[] = {
     S390_FEAT_MULTIPLE_EPOCH,
 };
 
+#define default_GEN14_GA2 EmptyFeat
+
 /* QEMU (CPU model) features */
 
 static uint16_t qemu_V2_11[] = {
@@ -661,6 +667,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
     CPU_FEAT_INITIALIZER(GEN13_GA1),
     CPU_FEAT_INITIALIZER(GEN13_GA2),
     CPU_FEAT_INITIALIZER(GEN14_GA1),
+    CPU_FEAT_INITIALIZER(GEN14_GA2),
 };
 
 #define FEAT_GROUP_INITIALIZER(_name)                  \
-- 
2.20.1
