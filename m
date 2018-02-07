Received: from eggs.gnu.org ([2001:4830:134:3::10]:34707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1ejJBb-0008Kf-Ib
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 01:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1ejJBX-0007e9-KQ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 01:26:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rnsastry@linux.vnet.ibm.com>)
	id 1ejJBX-0007dk-Bz
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 01:26:23 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w176PRBg065267
	for <qemu-devel@nongnu.org>; Wed, 7 Feb 2018 01:26:21 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyp00vqne-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 01:26:20 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <rnsastry@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 23:26:20 -0700
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Date: Wed,  7 Feb 2018 11:56:04 +0530
Message-Id: <20180207062604.82947-1-rnsastry@linux.vnet.ibm.com>
Subject: [Qemu-devel] [patch] linux-user/syscall.c: Fix missing break for
 host_to_target_cmsg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rnsastry@linux.vnet.ibm.com

Detected by by Coverity (CID 1385425)
with out this break statement the assigned value of 'tgt_len' at
line 1824 will be replaced by value of 'tgt_len' at line 1830.

Signed-off-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 74378947f0..3ecd533880 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1826,6 +1826,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
             default:
                 break;
             }
+        break;
         default:
             tgt_len = len;
             break;
-- 
2.14.3 (Apple Git-98)
