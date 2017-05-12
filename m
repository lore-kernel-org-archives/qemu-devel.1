Received: from eggs.gnu.org ([2001:4830:134:3::10]:57368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d98oL-0003XQ-Hx
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d98oI-0000tR-E6
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:32:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:13817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d98oI-0000kD-87
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:32:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OPU00IYO820FZ80@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 12 May 2017 12:32:24 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 12 May 2017 14:31:43 +0300
Message-id: <1494588703-9076-10-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1494588703-9076-1-git-send-email-a.perevalov@samsung.com>
References: <1494588703-9076-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512113223eucas1p2c2a88ead00f3121fc1bfc8dab4f18c78@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH V4 9/9] migration: postcopy_blocktime
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
Cc: dgilbert@redhat.com, a.perevalov@samsung.com, i.maximets@samsung.com, peterx@redhat.com

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 docs/migration.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/migration.txt b/docs/migration.txt
index 1b940a8..d0f5a6d 100644
--- a/docs/migration.txt
+++ b/docs/migration.txt
@@ -402,6 +402,16 @@ will now cause the transition from precopy to postcopy.
 It can be issued immediately after migration is started or any
 time later on.  Issuing it after the end of a migration is harmless.
 
+Blocktime it's a postcopy live migration metric, intend to show
+when source vCPU was in state interruptable sleep due to pagefault.
+This value is calculated on destination side.
+To enable postcopy blocktime calculation, enter following command on destination
+monitor:
+
+migrate_set_capability postcopy-blocktime on
+
+Postcopy blocktime could be retrieved by query-migrate qmp command.
+
 Note: During the postcopy phase, the bandwidth limits set using
 migrate_set_speed is ignored (to avoid delaying requested pages that
 the destination is waiting for).
-- 
1.8.3.1
