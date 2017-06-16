Received: from eggs.gnu.org ([2001:4830:134:3::10]:49636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLwfV-00079t-LG
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLwfT-0007SM-K1
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dLwfT-0007Rs-EL
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORN00MNMMOQQ340@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 16 Jun 2017 20:12:26 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 16 Jun 2017 22:12:05 +0300
Message-id: <1497640325-10960-9-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1497640325-10960-1-git-send-email-a.perevalov@samsung.com>
References: <1497640325-10960-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170616191224eucas1p2e8c1ff33f630b6beaff096b73ab3462b@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v9 8/8] migration: postcopy_blocktime
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
Cc: Alexey Perevalov <a.perevalov@samsung.com>, peterx@redhat.com, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 docs/devel/migration.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/devel/migration.txt b/docs/devel/migration.txt
index 1b940a8..4b625ca 100644
--- a/docs/devel/migration.txt
+++ b/docs/devel/migration.txt
@@ -402,6 +402,16 @@ will now cause the transition from precopy to postcopy.
 It can be issued immediately after migration is started or any
 time later on.  Issuing it after the end of a migration is harmless.
 
+Blocktime is a postcopy live migration metric, intended to show
+how long the vCPU was in state of interruptable sleep due to pagefault.
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
