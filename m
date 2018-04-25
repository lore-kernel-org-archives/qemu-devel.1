Received: from eggs.gnu.org ([2001:4830:134:3::10]:45238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQde-0003ZX-9c
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdc-000306-IX
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBQdc-0002zt-E8
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:36 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 25 Apr 2018 21:03:14 +0100
Message-Id: <20180425200326.72337-5-dgilbert@redhat.com>
In-Reply-To: <20180425200326.72337-1-dgilbert@redhat.com>
References: <20180425200326.72337-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 04/16] migration: postcopy_blocktime
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

From: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <1521742647-25550-5-git-send-email-a.perevalov@samsung.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/devel/migration.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index e32b087f6e..9342a8af06 100644
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
2.17.0
