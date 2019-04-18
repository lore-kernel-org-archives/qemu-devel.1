Received: from eggs.gnu.org ([209.51.188.92]:50653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GH-0002ji-2m
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GF-0004WD-Ju
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hH5GF-0004Td-50
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:23 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3IBTThu134685
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:20 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rxq723fpw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:19 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Apr 2019 12:31:17 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Apr 2019 13:31:09 +0200
In-Reply-To: <20190418113110.160664-1-borntraeger@de.ibm.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190418113110.160664-10-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 09/10] s390x/cpumodel: wire up 8561 and 8562 as
 gen15 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

8561 and 8562 will be gen15 machines. There is no name yet, lets us use
the cpu id as base name. Later on we can provide aliases with the proper
name.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_models.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 4c355e936e..e727519686 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -82,6 +82,8 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
     CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
     CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
+    CPUDEF_INIT(0x8561, 15, 1, 47, 0x08000000U, "8561", "IBM 8561 GA1"),
+    CPUDEF_INIT(0x8562, 15, 1, 47, 0x08000000U, "8562", "IBM 8562 GA1"),
 };
 
 #define QEMU_MAX_CPU_TYPE 0x2827
-- 
2.19.1
