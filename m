Received: from eggs.gnu.org ([2001:4830:134:3::10]:43900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6eC-0001Fq-Tk
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6e9-0007c7-Nq
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:20:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dx6e9-0007bk-Ei
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:20:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8R7JZJH064751
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:20:38 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d808abdj9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:20:37 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 27 Sep 2017 08:20:35 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 27 Sep 2017 09:20:28 +0200
In-Reply-To: <20170927072030.35737-1-borntraeger@de.ibm.com>
References: <20170927072030.35737-1-borntraeger@de.ibm.com>
Message-Id: <20170927072030.35737-2-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/3] s390x/cpumodel: remove ais from z14
 default model-> also for 2.10.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

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
