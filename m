Received: from eggs.gnu.org ([209.51.188.92]:50562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJyko-0002JQ-9z
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJykl-0003Ir-KD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:10:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45128
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hJykl-0003IM-0L
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:10:51 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3QB9ja1009690
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:10:50 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s3y27dkgx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:10:46 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 26 Apr 2019 12:10:15 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 26 Apr 2019 07:10:01 -0400
In-Reply-To: <20190426111003.21246-1-borntraeger@de.ibm.com>
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
Message-Id: <20190426111003.21246-9-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 08/10] s390x/cpumodel: add gen15 defintions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

add several new features (msa9, sort, deflate, additional vector
instructions, new general purpose instructions) to generation 15.

Also disable csske and bpb from the default model. This will allow
to migrate gen15 machines to future machines that do not have these
features.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/gen-features.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 8fc2e8e72f..6260f56dc1 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -419,6 +419,10 @@ static uint16_t base_GEN14_GA1[] = {
 
 #define base_GEN14_GA2 EmptyFeat
 
+static uint16_t base_GEN15_GA1[] = {
+    S390_FEAT_MISC_INSTRUCTION_EXT3,
+};
+
 /* Full features (in order of release)
  * Automatically includes corresponding base features.
  * Full features are all features this hardware supports even if kvm/QEMU do not
@@ -548,6 +552,16 @@ static uint16_t full_GEN14_GA1[] = {
 
 #define full_GEN14_GA2 EmptyFeat
 
+static uint16_t full_GEN15_GA1[] = {
+    S390_FEAT_VECTOR_ENH2,
+    S390_FEAT_GROUP_ENH_SORT,
+    S390_FEAT_GROUP_DEFLATE_CONVERSION,
+    S390_FEAT_VECTOR_BCD_ENH,
+    S390_FEAT_GROUP_MSA_EXT_9,
+    S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
+    S390_FEAT_ETOKEN,
+};
+
 /* Default features (in order of release)
  * Automatically includes corresponding base features.
  * Default features are all features this version of QEMU supports for this
@@ -624,6 +638,16 @@ static uint16_t default_GEN14_GA1[] = {
 
 #define default_GEN14_GA2 EmptyFeat
 
+static uint16_t default_GEN15_GA1[] = {
+    S390_FEAT_VECTOR_ENH2,
+    S390_FEAT_GROUP_ENH_SORT,
+    S390_FEAT_GROUP_DEFLATE_CONVERSION,
+    S390_FEAT_VECTOR_BCD_ENH,
+    S390_FEAT_GROUP_MSA_EXT_9,
+    S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
+    S390_FEAT_ETOKEN,
+};
+
 /* QEMU (CPU model) features */
 
 static uint16_t qemu_V2_11[] = {
@@ -740,6 +764,7 @@ static CpuFeatDefSpec CpuFeatDef[] = {
     CPU_FEAT_INITIALIZER(GEN13_GA2),
     CPU_FEAT_INITIALIZER(GEN14_GA1),
     CPU_FEAT_INITIALIZER(GEN14_GA2),
+    CPU_FEAT_INITIALIZER(GEN15_GA1),
 };
 
 #define FEAT_GROUP_INITIALIZER(_name)                  \
-- 
2.17.1
