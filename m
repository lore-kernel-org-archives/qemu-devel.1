Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8p-0006OR-6v
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8m-0001WQ-0x
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVq8l-0001W9-Sa
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1864781663E4
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 03:20:07 +0000 (UTC)
Received: from red.redhat.com (ovpn-120-169.rdu2.redhat.com [10.10.120.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C9D571117626
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 03:20:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 20 Jun 2018 22:19:50 -0500
Message-Id: <20180621031957.134718-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] bitmap export over NBD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a9=
3b:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into =
staging (2018-06-20 09:51:30 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-06-20

for you to fetch changes up to 5bde4bbbd1e217c323551d2785a0efff6340d840:

  docs/interop: add nbd.txt (2018-06-20 21:20:05 -0500)

----------------------------------------------------------------
nbd patches for 2018-06-20

Add experimental x-nbd-server-add-bitmap to expose a disabled
bitmap over NBD, in preparation for a pull model incremental
backup scheme.

- Eric Blake: tests: Simplify .gitignore
- Vladimir Sementsov-Ogievskiy: 0/6 NBD export bitmaps

----------------------------------------------------------------
Eric Blake (1):
      tests: Simplify .gitignore

Vladimir Sementsov-Ogievskiy (6):
      nbd/server: fix trace
      nbd/server: refactor NBDExportMetaContexts
      nbd/server: add nbd_meta_empty_or_pattern helper
      nbd/server: implement dirty bitmap export
      qapi: new qmp command nbd-server-add-bitmap
      docs/interop: add nbd.txt

 docs/interop/nbd.txt |  38 ++++++
 qapi/block.json      |  23 ++++
 include/block/nbd.h  |   8 +-
 blockdev-nbd.c       |  23 ++++
 nbd/server.c         | 369 ++++++++++++++++++++++++++++++++++++++++++++-=
------
 MAINTAINERS          |   1 +
 nbd/trace-events     |   1 +
 tests/.gitignore     |  93 +------------
 8 files changed, 417 insertions(+), 139 deletions(-)
 create mode 100644 docs/interop/nbd.txt

--=20
2.14.4
