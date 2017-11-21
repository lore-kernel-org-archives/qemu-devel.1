Received: from eggs.gnu.org ([2001:4830:134:3::10]:33035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHDaH-0002w1-8M
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHDaC-0007Pj-Us
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:47:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eHDaC-0007PZ-Oe
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:47:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A81B4A6EB
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 18:47:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 21 Nov 2017 19:47:36 +0100
Message-Id: <20171121184738.8502-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/2]  Migration pull request
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

THis has two fixes for migration, please apply.

Later, Juan.

The following changes since commit a15d835f00dce270fd3194e83d9910f4b5b44ac0:

  Update version for v2.11.0-rc2 release (2017-11-21 17:50:36 +0000)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20171121

for you to fetch changes up to 383d8a77222c016610d626887de80e770cdd9936:

  migration/ram.c: do not set 'postcopy_running' in POSTCOPY_INCOMING_END (2017-11-21 19:42:26 +0100)

----------------------------------------------------------------
migration/next for 20171121

----------------------------------------------------------------
Anthony PERARD (1):
      migration, xen: Fix block image lock issue on live migration

Daniel Henrique Barboza (1):
      migration/ram.c: do not set 'postcopy_running' in POSTCOPY_INCOMING_END

 migration/ram.c     | 22 +++++++++++++++-------
 migration/savevm.c  | 23 ++++++++++++++++++++++-
 qapi/migration.json |  6 +++++-
 3 files changed, 42 insertions(+), 9 deletions(-)
