Received: from eggs.gnu.org ([2001:4830:134:3::10]:45942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29H-0008Ro-Sa
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29E-0002e8-Mq
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fi29E-0002dG-IE
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:00 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jul 2018 19:34:47 +0100
Message-Id: <20180724183454.120276-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] migration queue for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, kraxel@redhat.com, lidongchen@tencent.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 3bae150448dbd888a480f892ebbf01caec0d83=
29:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2018-07-24 15:26:01 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20180724a

for you to fetch changes up to 4b3fb65db973b51346e3456987ba80b15c1fc75c:

  migration: fix duplicate initialization for expected_downtime and clean=
up_bh (2018-07-24 17:28:57 +0100)

----------------------------------------------------------------
Migration pull for 3.0

Fixes only

----------------------------------------------------------------
Dr. David Alan Gilbert (2):
      migrate: Fix cancelling state warning
      audio/hda: Fix migration

Lidong Chen (1):
      migration: fix duplicate initialization for expected_downtime and c=
leanup_bh

Peter Xu (4):
      migration: fix potential overflow in multifd send
      migration: update recv bitmap only on dest vm
      migration: disallow recovery for release-ram
      tests: only update last_byte when at the edge

 hw/audio/hda-codec.c   |  2 +-
 migration/migration.c  | 22 ++++++++++++++++++++--
 migration/ram.c        | 13 ++++++++++---
 tests/migration-test.c |  2 +-
 4 files changed, 32 insertions(+), 7 deletions(-)
