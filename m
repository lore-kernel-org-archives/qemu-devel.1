Received: from eggs.gnu.org ([2001:4830:134:3::10]:55302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPSBx-0008Ou-HL
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPSBn-0006Pu-BX
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:05:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gPSBl-0006H2-6a
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:05:05 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 21 Nov 2018 13:04:54 +0000
Message-Id: <20181121130456.35661-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, chen.zhang@intel.com, zhangckid@gmail.com, quintela@redhat.com
Cc: peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 47c1cc30e440860aa695358f7c2dd0b9d7b53d=
16:

  Update version for v3.1.0-rc2 release (2018-11-20 18:10:26 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20181121a

for you to fetch changes up to 7e934f5b27eee1b0d77be3dcf1fd18d4ccc602cc:

  migration/migration.c: Add COLO dependency checks (2018-11-21 11:38:12 =
+0000)

----------------------------------------------------------------
Migration fixes 2018-11-21

Notably the fix for building with --disable-replication

----------------------------------------------------------------
Zhang Chen (2):
      migration/colo.c: Fix compilation issue when disable replication
      migration/migration.c: Add COLO dependency checks

 migration/colo.c      | 28 +++++++++++++++++++++++++++-
 migration/migration.c |  9 +++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)
