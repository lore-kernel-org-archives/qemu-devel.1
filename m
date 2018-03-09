Received: from eggs.gnu.org ([2001:4830:134:3::10]:39116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euMEN-00083F-JQ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euMEK-0003Ki-FT
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:54:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1euMEK-0003KX-BN
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:54:56 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  9 Mar 2018 17:54:47 +0000
Message-Id: <20180309175453.41548-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pl@kamp.de, peterx@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit b39b61e410022f96ceb53d4381d25cba5126ac=
44:

  memory: fix flatview_access_valid RCU read lock/unlock imbalance (2018-=
03-09 15:55:20 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20180309a

for you to fetch changes up to f96d6651e4b7cb8a8e91774b9330d82c333171d6:

  tests: Silence migration-test 'bad' test (2018-03-09 17:39:25 +0000)

----------------------------------------------------------------
Migration pull 2018-03-09

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      tests: Silence migration-test 'bad' test

Marc-Andr=C3=A9 Lureau (1):
      migration: fix minor finalize leak

Peter Lieven (3):
      migration: do not transfer ram during bulk storage migration
      migration/block: reset dirty bitmap before read in bulk phase
      migration/block: rename MAX_INFLIGHT_IO to MAX_IO_BUFFERS

Peter Xu (1):
      migration: fix applying wrong capabilities

 migration/block.c      | 12 +++++-------
 migration/migration.c  |  5 ++++-
 migration/ram.c        |  8 ++++++++
 tests/migration-test.c | 17 ++++++++++++++---
 4 files changed, 31 insertions(+), 11 deletions(-)
