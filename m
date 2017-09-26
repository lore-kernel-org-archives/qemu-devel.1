Received: from eggs.gnu.org ([2001:4830:134:3::10]:37888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwuEj-0002Lt-8Q
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwuEe-0000pb-VN
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:05:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwuEe-0000oL-KS
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:05:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8QI4sLF141645
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 14:05:28 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d7u90j4h1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 14:05:28 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 26 Sep 2017 19:05:26 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 26 Sep 2017 20:05:22 +0200
Message-Id: <20170926180522.68482-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH] s390x/cpumodel: remove ais from z14 default
 model-> also for 2.10.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

We disabled ais for 2.10 lets also remove it from the z14 default model.

Fixes: 3f2d07b3b01e  s390x/ais: for 2.10 stable: disable ais facility
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/gen-features.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index c8dc104..68e6c31 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -527,7 +527,6 @@ static uint16_t default_GEN13_GA1[] = {
 #define default_GEN13_GA2 EmptyFeat
 
 static uint16_t default_GEN14_GA1[] = {
-    S390_FEAT_ADAPTER_INT_SUPPRESSION,
     S390_FEAT_INSTRUCTION_EXEC_PROT,
     S390_FEAT_GUARDED_STORAGE,
     S390_FEAT_VECTOR_PACKED_DECIMAL,
-- 
2.9.4
