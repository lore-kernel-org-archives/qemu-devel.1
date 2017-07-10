Received: from eggs.gnu.org ([2001:4830:134:3::10]:35565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcCv-0004oM-Uf
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcCr-0008Fi-SE
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dUcCr-0008EV-MK
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87FF5C0587EF
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 17:10:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 10 Jul 2017 18:10:31 +0100
Message-Id: <20170710171040.21021-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 6b06e3e49eb8c91cc286c16d6bf3181ac296f3=
3d:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-10-v2=
' into staging (2017-07-10 16:12:47 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20170710a

for you to fetch changes up to f0afa331ce670ba39bde3f5620d75dcd56890cb6:

  migration: Make compression_threads use save/load_setup/cleanup() (2017=
-07-10 17:52:21 +0100)

----------------------------------------------------------------
Migration pull 2017-07-10

----------------------------------------------------------------
Juan Quintela (5):
      migration: Rename save_live_setup() to save_setup()
      migration: Rename cleanup() to save_cleanup()
      migration: Create load_setup()/cleanup() methods
      migration: Convert ram to use new load_setup()/load_cleanup()
      migration: Make compression_threads use save/load_setup/cleanup()

Peter Xu (4):
      migration: fix handling for --only-migratable
      vl: move global property, migrate init earlier
      doc: add item for "-M enforce-config-section"
      doc: update TYPE_MIGRATION documents

 hw/ppc/spapr.c               |  6 ++---
 include/migration/misc.h     |  1 -
 include/migration/register.h |  6 +++--
 migration/block.c            |  4 +--
 migration/colo.c             |  2 +-
 migration/migration.c        | 27 +++++--------------
 migration/ram.c              | 63 +++++++++++++++++++++++++++++++-------=
------
 migration/ram.h              |  6 -----
 migration/savevm.c           | 61 +++++++++++++++++++++++++++++++++++---=
----
 migration/savevm.h           |  3 ++-
 migration/trace-events       |  4 ++-
 qemu-options.hx              |  6 +++++
 vl.c                         | 26 +++++++++---------
 13 files changed, 138 insertions(+), 77 deletions(-)
