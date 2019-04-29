Received: from eggs.gnu.org ([209.51.188.92]:33257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2GP-0001Sg-CK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2Bl-0000RL-40
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:03:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35082
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hL2Bk-0000Qv-Vs
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:03:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3T8sMvG075269
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:03:04 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s5vfvv883-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:03:04 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Apr 2019 10:03:03 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Apr 2019 05:02:50 -0400
In-Reply-To: <20190429090250.7648-1-borntraeger@de.ibm.com>
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
Message-Id: <20190429090250.7648-10-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3 9/9] s390x/cpumodel: wire up 8561 and 8562
 as gen15 machines
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

8561 and 8562 will be gen15 machines. There is no name yet, lets us use
gen15a and gen15tb as base name. Later on we can provide aliases with
the proper name.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_models.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index d683635eb5..21ea819483 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -43,10 +43,9 @@
     }
 
 /*
- * CPU definiton list in order of release. For now, base features of a
- * following release are always a subset of base features of the previous
- * release. Same is correct for the other feature sets.
- * A BC release always follows the corresponding EC release.
+ * CPU definition list in order of release. Up to generation 14 base features
+ * of a following release have been a superset of the previous release. With
+ * generation 15 one base feature and one optional feature have been deprecated.
  */
 static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x2064, 7, 1, 38, 0x00000000U, "z900", "IBM zSeries 900 GA1"),
@@ -83,6 +82,8 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
     CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
     CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
+    CPUDEF_INIT(0x8561, 15, 1, 47, 0x08000000U, "gen15a", "IBM 8561 GA1"),
+    CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "gen15b", "IBM 8562 GA1"),
 };
 
 #define QEMU_MAX_CPU_TYPE 0x2827
-- 
2.17.1
