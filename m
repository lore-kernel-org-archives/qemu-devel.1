Received: from eggs.gnu.org ([2001:4830:134:3::10]:33655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eant5-0000mC-E6
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 14:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eant2-0005R7-Kj
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 14:24:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1eant2-0005QZ-CQ
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 14:24:08 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0EJNsbi067441
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 14:24:07 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fgbbdkg4q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 14:24:06 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Sun, 14 Jan 2018 14:24:05 -0500
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Sun, 14 Jan 2018 17:23:48 -0200
In-Reply-To: <20180114192349.22212-1-joserz@linux.vnet.ibm.com>
References: <20180114192349.22212-1-joserz@linux.vnet.ibm.com>
Message-Id: <20180114192349.22212-2-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/2] ppc: Change Power9 compat table to
 support at most 8 threads/core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org, lvivier@redhat.com

Increases the max smt mode to 8 for Power9. That's because KVM supports
smt emulation in this platform so QEMU should allow users to use it as
well.

Today if we try to pass -smp ...,threads=8, QEMU will silently truncate
it to smt4 mode and may cause a crash if we try to perform a cpu
hotplug.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 target/ppc/compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index ad8f93c064..d1770cdc6f 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -73,7 +73,7 @@ static const CompatInfo compat_table[] = {
         .pvr = CPU_POWERPC_LOGICAL_3_00,
         .pcr = PCR_COMPAT_3_00,
         .pcr_level = PCR_COMPAT_3_00,
-        .max_threads = 4,
+        .max_threads = 8,
     },
 };
 
-- 
2.14.3
