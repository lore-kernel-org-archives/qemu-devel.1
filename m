Received: from eggs.gnu.org ([2001:4830:134:3::10]:57784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHtoM-0000eU-0x
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHtoI-0002o5-6Y
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gHtoH-0002c7-S4
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F1F5308FF0D
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 16:57:27 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 31 Oct 2018 16:57:22 +0000
Message-Id: <20181031165725.61938-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9=
cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1=
-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20181031a

for you to fetch changes up to 3d63da16fbcd05405efd5946000cdb45474a9bad:

  migration: avoid segmentfault when take a snapshot of a VM which being =
migrated (2018-10-31 09:38:59 +0000)

----------------------------------------------------------------
Minor migration fixes 2018-10-31

----------------------------------------------------------------
Jia Lina (1):
      migration: avoid segmentfault when take a snapshot of a VM which be=
ing migrated

Zhang Chen (1):
      qapi: Fix COLOStatus and query-colo-status since version

wangguang (1):
      COLO: Fix Colo doc secondeary should be secondary

 docs/COLO-FT.txt      |  2 +-
 migration/migration.c |  2 +-
 migration/migration.h |  2 ++
 migration/savevm.c    | 19 +++++++++++--------
 qapi/migration.json   |  4 ++--
 5 files changed, 17 insertions(+), 12 deletions(-)
