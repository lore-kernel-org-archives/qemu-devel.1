Received: from eggs.gnu.org ([2001:4830:134:3::10]:52552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRrLW-00071p-Jh
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 22:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRrLR-0006lY-OT
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 22:44:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dRrLR-0006kv-Hr
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 22:44:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8D83C04B30E
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 02:44:11 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  3 Jul 2017 10:44:04 +0800
Message-Id: <1499049848-18012-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] migration: fix iotest 055,
 only-migratable break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Two breakage introduced during the migration objectify series: one for
--only-migratable, another one for iotest 055.

First two patches fixes the breakages. Latter two are documentation
updates suggested by Eduardo. Please review. Thanks.

Peter Xu (4):
  migration: fix handling for --only-migratable
  vl: move global property, migrate init earlier
  doc: add item for "-M enforce-config-section"
  doc: update TYPE_MIGRATION documents

 include/migration/misc.h |  1 -
 migration/migration.c    | 20 +++++++++-----------
 qemu-options.hx          |  8 ++++++++
 vl.c                     | 26 +++++++++++++-------------
 4 files changed, 30 insertions(+), 25 deletions(-)

--=20
2.7.4
