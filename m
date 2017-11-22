Received: from eggs.gnu.org ([2001:4830:134:3::10]:35980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHQem-0007u9-K8
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHQej-00048y-Dz
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:45:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eHQej-00047e-8H
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:45:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F82C25C27
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 08:45:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Nov 2017 09:45:02 +0100
Message-Id: <20171122084504.11984-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Migration PULL take 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

This uses the right verslion of postcopy_running from from Daniel.

Please, apply.

Later, Juan.

The following changes since commit a15d835f00dce270fd3194e83d9910f4b5b44ac0:

  Update version for v2.11.0-rc2 release (2017-11-21 17:50:36 +0000)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20171122

for you to fetch changes up to acab30b85db0885ab161aff4c83c550628f6d8ca:

  migration/ram.c: do not set 'postcopy_running' in POSTCOPY_INCOMING_END (2017-11-22 08:50:37 +0100)

----------------------------------------------------------------
migration/next for 20171122

----------------------------------------------------------------
Anthony PERARD (1):
      migration, xen: Fix block image lock issue on live migration

Daniel Henrique Barboza (1):
      migration/ram.c: do not set 'postcopy_running' in POSTCOPY_INCOMING_END

 migration/ram.c     | 16 ++++++++++++++--
 migration/savevm.c  | 23 ++++++++++++++++++++++-
 qapi/migration.json |  6 +++++-
 3 files changed, 41 insertions(+), 4 deletions(-)
