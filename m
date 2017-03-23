Received: from eggs.gnu.org ([2001:4830:134:3::10]:60749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cqzWz-00011J-Pu
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cqzWv-0001o8-Go
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:59:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cqzWv-0001ms-57
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:59:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2N9xLNd067201
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 05:59:39 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29bv4jkkvg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 05:59:38 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 23 Mar 2017 09:59:36 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu, 23 Mar 2017 10:59:29 +0100
In-Reply-To: <20170323095929.20140-1-cornelia.huck@de.ibm.com>
References: <20170323095929.20140-1-cornelia.huck@de.ibm.com>
Message-Id: <20170323095929.20140-2-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL for-2.9 1/1] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-stable@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Stefan Weil <sw@weilnetz.de>

Returning NULL from get_max_cpu_model results in a SIGSEGV runtime error.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170130131517.8092-1-sw@weilnetz.de>
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target/s390x/cpu_models.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 4ea3a2de80..1434d15315 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -660,7 +660,6 @@ static void check_compatibility(const S390CPUModel *max_model,
 
 static S390CPUModel *get_max_cpu_model(Error **errp)
 {
-#ifndef CONFIG_USER_ONLY
     static S390CPUModel max_model;
     static bool cached;
 
@@ -680,7 +679,6 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
         cached = true;
         return &max_model;
     }
-#endif
     return NULL;
 }
 
-- 
2.11.0
