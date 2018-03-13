Received: from eggs.gnu.org ([2001:4830:134:3::10]:59156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evlJW-0003OJ-KZ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evlJT-0001MZ-H1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1evlJT-0001MC-As
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:03 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 13 Mar 2018 17:53:42 +0300
Message-id: <1520952824-3172-5-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1520952824-3172-1-git-send-email-a.perevalov@samsung.com>
References: <1520952824-3172-1-git-send-email-a.perevalov@samsung.com>
	<CGME20180313145359eucas1p22721e2cbfd518aad83cbb6741ae802ac@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v1 4/6] migration: postcopy_blocktime
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: Alexey Perevalov <a.perevalov@samsung.com>, v.kuramshin@samsung.com, ash.billore@samsung.com, f4bug@amsat.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/devel/migration.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 9d1b765..18cd952 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -401,6 +401,20 @@ will now cause the transition from precopy to postcopy.
 It can be issued immediately after migration is started or any
 time later on.  Issuing it after the end of a migration is harmless.
 
+Blocktime is a postcopy live migration metric, intended to show how
+long the vCPU was in state of interruptable sleep due to pagefault.
+That metric is calculated both for all vCPUs as overlapped value, and
+separately for each vCPU. These values are calculated on destination
+side.  To enable postcopy blocktime calculation, enter following
+command on destination monitor:
+
+``migrate_set_capability postcopy-blocktime on``
+
+Postcopy blocktime can be retrieved by query-migrate qmp command.
+postcopy-blocktime value of qmp command will show overlapped blocking
+time for all vCPU, postcopy-vcpu-blocktime will show list of blocking
+time per vCPU.
+
 .. note::
   During the postcopy phase, the bandwidth limits set using
   ``migrate_set_speed`` is ignored (to avoid delaying requested pages that
-- 
2.7.4
