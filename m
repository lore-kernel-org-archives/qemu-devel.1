Received: from eggs.gnu.org ([2001:4830:134:3::10]:49772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3Kj-0007M6-2S
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3Ki-0003Sx-8H
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eb3Ki-0003SX-23
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:44 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 15 Jan 2018 12:52:52 +0100
Message-Id: <20180115115309.23982-11-quintela@redhat.com>
In-Reply-To: <20180115115309.23982-1-quintela@redhat.com>
References: <20180115115309.23982-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 10/27] migration: postcopy_blocktime
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
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

From: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/devel/migration.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index bf97080dac..015a9ebdf7 100644
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
2.14.3
