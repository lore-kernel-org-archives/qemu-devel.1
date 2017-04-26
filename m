Received: from eggs.gnu.org ([2001:4830:134:3::10]:41210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3Roi-0000I8-KN
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 14:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3Rog-0006Xv-0e
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 14:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d3Rof-0006Xf-QH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 14:37:29 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 26 Apr 2017 19:37:19 +0100
Message-Id: <20170426183721.7482-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Postcopy fix and traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, borntraeger@de.ibm.com, quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This is a small postcopy fix for a bug that
Christian ran into, and a couple of extra traces that
would have made finding it easier.

Dave

Dr. David Alan Gilbert (2):
  Postcopy: Force allocation of all-zero precopy pages
  migration: Extra tracing

 include/migration/migration.h |  3 ++-
 migration/ram.c               | 14 ++++++++++----
 migration/rdma.c              |  2 +-
 migration/trace-events        |  2 ++
 4 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.12.2
