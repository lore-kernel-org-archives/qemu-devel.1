Received: from eggs.gnu.org ([2001:4830:134:3::10]:52350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1e99w2-0002GM-8I
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1e99vx-00045S-HF
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:16:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1e99vx-00044N-Ak
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:16:53 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Mon, 30 Oct 2017 16:16:28 +0300
Message-id: <1509369390-8285-5-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131649eucas1p1f96847d18071ffdc4ea869438edb2e12@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH v12 4/6] migration: postcopy_blocktime
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
Cc: Alexey Perevalov <a.perevalov@samsung.com>, quintela@redhat.com, peterx@redhat.com, i.maximets@samsung.com, heetae82.ahn@samsung.com, dgilbert@redhat.com

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 docs/devel/migration.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/docs/devel/migration.txt b/docs/devel/migration.txt
index 4030703..cebfe7a 100644
--- a/docs/devel/migration.txt
+++ b/docs/devel/migration.txt
@@ -402,6 +402,19 @@ will now cause the transition from precopy to postcopy.
 It can be issued immediately after migration is started or any
 time later on.  Issuing it after the end of a migration is harmless.
 
+Blocktime is a postcopy live migration metric, intended to show
+how long the vCPU was in state of interruptable sleep due to pagefault.
+That metric is calculated both for all vCPUs as overlapped value, and
+separately for each vCPU. These values are calculated on destination side.
+To enable postcopy blocktime calculation, enter following command on destination
+monitor:
+
+migrate_set_capability postcopy-blocktime on
+
+Postcopy blocktime can be retrieved by query-migrate qmp command.
+postcopy-blocktime value of qmp command will show overlapped blocking time for
+all vCPU, postcopy-vcpu-blocktime will show list of blocking time per vCPU.
+
 Note: During the postcopy phase, the bandwidth limits set using
 migrate_set_speed is ignored (to avoid delaying requested pages that
 the destination is waiting for).
-- 
2.7.4
