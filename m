Received: from eggs.gnu.org ([2001:4830:134:3::10]:37199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQEmN-0000s3-AL
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQEmJ-0004xD-7J
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:25:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53550 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fQEmJ-0004x2-2P
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:25:47 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Jun 2018 17:25:43 +0100
Message-Id: <20180605162545.80778-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/2] Fixups for non-migratable RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, clg@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  C=C3=A9dric's b895de50 got merged at about the same
time as some of Peter's changes and there's a rdma
case as well; so tidy up those cases that were looping
over all (rather than just migratable) RAMBlocks
and poison it so we don't end up doing the same thing
again.

Dave

Dr. David Alan Gilbert (2):
  migration: Fixes for non-migratable RAMBlocks
  migration: Poison ramblock loops in migration

 include/exec/ramlist.h | 4 +++-
 migration/migration.h  | 3 +++
 migration/ram.c        | 8 +++++---
 migration/rdma.c       | 2 +-
 4 files changed, 12 insertions(+), 5 deletions(-)

--=20
2.17.0
