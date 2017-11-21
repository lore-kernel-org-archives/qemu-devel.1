Received: from eggs.gnu.org ([2001:4830:134:3::10]:39821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eH9F4-0001Z1-EW
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eH9Ez-0002tO-Oo
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34338
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1eH9Ez-0002t4-J8
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:33 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vALE8hfJ141642
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 09:09:27 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ecm8nx0m7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 09:09:27 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Tue, 21 Nov 2017 14:09:26 -0000
From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Date: Tue, 21 Nov 2017 19:39:18 +0530
Message-Id: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1] hmp: 'info snapshots' not showing the id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, qemu-devel@nongnu.org
Cc: s1seetee@linux.vnet.ibm.com

(qemu) info snapshots
List of snapshots present on all disks:
ID        TAG                 VM SIZE                DATE       VM CLOCK
--         1                      314M 2017-11-15 15:22:18   00:02:25.695
--         2                      319M 2017-11-15 15:23:03   00:02:45.970
--         3                      319M 2017-11-15 15:23:37   00:02:56.328

ID field is showing -- with no information.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
---
 hmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 35a7041..1921b3b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1454,7 +1454,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
             /* The ID is not guaranteed to be the same on all images, so
              * overwrite it.
              */
-            pstrcpy(sn->id_str, sizeof(sn->id_str), "--");
+            pstrcpy(sn->id_str, sizeof(sn->id_str), sn->id_str);
             bdrv_snapshot_dump((fprintf_function)monitor_printf, mon, sn);
             monitor_printf(mon, "\n");
         }
-- 
1.8.3.1
