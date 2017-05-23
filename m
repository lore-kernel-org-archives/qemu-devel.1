Received: from eggs.gnu.org ([2001:4830:134:3::10]:48876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dD82P-0006pK-9p
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dD82K-0003hq-AW
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:41 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:54537)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dD82K-0003hW-5a
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:31:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OQE0031OLCMDF70@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 23 May 2017 12:31:34 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 23 May 2017 14:31:11 +0300
Message-id: <1495539071-12995-11-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113132eucas1p19143aceccbb30a0051635cddcf376bb6@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH V6 10/10] migration: postcopy_blocktime
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, dgilbert@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 docs/migration.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/migration.txt b/docs/migration.txt
index 1b940a8..2207c6d 100644
--- a/docs/migration.txt
+++ b/docs/migration.txt
@@ -402,6 +402,16 @@ will now cause the transition from precopy to postcopy.
 It can be issued immediately after migration is started or any
 time later on.  Issuing it after the end of a migration is harmless.
 
+Blocktime is a postcopy live migration metric, intended to show
+how long the source vCPU was in state of interruptable sleep due to pagefault.
+This value is calculated on destination side.
+To enable postcopy blocktime calculation, enter following command on destination
+monitor:
+
+migrate_set_capability postcopy-blocktime on
+
+Postcopy blocktime can be retrieved by query-migrate qmp command.
+
 Note: During the postcopy phase, the bandwidth limits set using
 migrate_set_speed is ignored (to avoid delaying requested pages that
 the destination is waiting for).
-- 
1.8.3.1
