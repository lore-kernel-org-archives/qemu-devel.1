Received: from eggs.gnu.org ([2001:4830:134:3::10]:49758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1f0nrr-0007v4-5e
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sathnaga@linux.vnet.ibm.com>) id 1f0nro-0000sF-2r
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:38:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sathnaga@linux.vnet.ibm.com>)
	id 1f0nrn-0000qb-R9
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:38:20 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2RCYUBP146649
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 08:38:16 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gyn1vkbsy-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 08:38:15 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sathnaga@linux.vnet.ibm.com>;
	Tue, 27 Mar 2018 08:38:12 -0400
From: sathnaga@linux.vnet.ibm.com
Date: Tue, 27 Mar 2018 18:08:00 +0530
Message-Id: <20180327123800.28851-1-sathnaga@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] hmp.c: Revert hmp_info_cpus output format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

This commit 137b5cb6ab565cb3781d5337591e155932b4230e
refactors info cpus output and changes output format from
'thread_id' to 'thread-id', this would break parsing
of output in above layers like libvirt, test framework etc.

This patch just reverts back output format to 'thread_id'.

CC: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
---
 hmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 679467d85a..a25c7bd9a8 100644
--- a/hmp.c
+++ b/hmp.c
@@ -381,7 +381,7 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
 
         monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
                        cpu->value->cpu_index);
-        monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
+        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
     }
 
     qapi_free_CpuInfoFastList(cpu_list);
-- 
2.14.3
