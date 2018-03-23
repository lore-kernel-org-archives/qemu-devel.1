Received: from eggs.gnu.org ([2001:4830:134:3::10]:42243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezTEA-0000aE-Kt
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezTE7-0003mg-Cs
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50320 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ezTE7-0003mR-8R
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:51 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 23 Mar 2018 20:23:39 +0000
Message-Id: <20180323202344.70640-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, berrange@redhat.com, lidongchen@tencent.com, pl@kamp.de, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 4c2c1015905fa1d616750dfe024b4c0b358759=
50:

  Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20180323' =
into staging (2018-03-23 10:20:54 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20180323a

for you to fetch changes up to 09576e74dbe697c5f0a7bc2ad7b59601457a2ff4:

  migration: Fix block migration flag case (2018-03-23 18:24:11 +0000)

----------------------------------------------------------------
Migration fixes for 2.12

All small fixes.  Dan's is a missing piece
of a cleanup that finally completes something,
and between Paolo, Dan and myself we recon it's
still on the edge of being a bug fix.

----------------------------------------------------------------
Daniel P. Berrang=C3=A9 (1):
      migration: convert socket server to QIONetListener

Dr. David Alan Gilbert (1):
      migration: Fix block migration flag case

Lidong Chen (1):
      migration: Fix rate limiting issue on RDMA migration

Peter Lieven (2):
      migration/block: limit the number of parallel I/O requests
      migration/block: compare only read blocks against the rate limiter

 migration/block.c     |  5 +++--
 migration/migration.c |  1 +
 migration/qemu-file.c |  2 +-
 migration/socket.c    | 48 ++++++++++++++++-----------------------------=
---
 4 files changed, 21 insertions(+), 35 deletions(-)
