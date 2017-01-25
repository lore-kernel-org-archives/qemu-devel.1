Received: from eggs.gnu.org ([2001:4830:134:3::10]:39977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cWMVx-0000hs-QD
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cWMVt-00048O-Ql
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:17:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cWMVt-00048I-GV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:17:21 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0PCEAWH028648
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 07:17:20 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0a-001b2d01.pphosted.com with ESMTP id 286ua01h3v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 07:17:19 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 25 Jan 2017 12:17:15 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Wed, 25 Jan 2017 13:17:10 +0100
Message-Id: <20170125121710.13561-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH] s390x/flic: fix compilation of kvm flic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, duanj@linux.vnet.ibm.com, dgilbert@redhat.com, Cornelia Huck <cornelia.huck@de.ibm.com>

2c21ee7 ("migration: extend VMStateInfo") missed a void -> int
return conversion for kvm_flic_save().

Fixes: 2c21ee7 ("migration: extend VMStateInfo")
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index da8e4dfab6..e86a84e49a 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -303,7 +303,7 @@ static int kvm_flic_save(QEMUFile *f, void *opaque, size_t size,
          * migration state */
         error_report("flic: couldn't allocate memory");
         qemu_put_be64(f, FLIC_FAILED);
-        return;
+        return 0;
     }
 
     count = __get_all_irqs(flic, &buf, len);
-- 
2.11.0
