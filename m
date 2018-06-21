Received: from eggs.gnu.org ([2001:4830:134:3::10]:42643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW12B-00019O-Pn
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW126-0006eF-RY
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:58:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fW126-0006di-Lm
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:57:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0EFA401EF07
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 14:57:57 +0000 (UTC)
Received: from red.redhat.com (ovpn-120-169.rdu2.redhat.com [10.10.120.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8500F10FD2A4
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 14:57:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu, 21 Jun 2018 09:57:40 -0500
Message-Id: <20180621145749.191944-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/9] bitmap export over NBD
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

  git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-06-20-v2

for you to fetch changes up to bc37b06a5cde24fb24c2a2cc44dd86756034ba9d:

  nbd/server: introduce NBD_CMD_CACHE (2018-06-21 09:41:39 -0500)

Only sending the new patches (2, 9) and the changed patch (6, was 5/7
in v1)

----------------------------------------------------------------
nbd patches for 2018-06-20

Add experimental x-nbd-server-add-bitmap to expose a disabled
bitmap over NBD, in preparation for a pull model incremental
backup scheme. Also fix a corner case protocol issue with
NBD_CMD_BLOCK_STATUS, and add new NBD_CMD_CACHE.

- Eric Blake: tests: Simplify .gitignore
- Eric Blake: nbd/server: Reject 0-length block status request
- Vladimir Sementsov-Ogievskiy: 0/6 NBD export bitmaps
- Vladimir Sementsov-Ogievskiy: nbd/server: introduce NBD_CMD_CACHE

----------------------------------------------------------------
Eric Blake (2):
      tests: Simplify .gitignore
      nbd/server: Reject 0-length block status request

Vladimir Sementsov-Ogievskiy (7):
      nbd/server: fix trace
      nbd/server: refactor NBDExportMetaContexts
      nbd/server: add nbd_meta_empty_or_pattern helper
      nbd/server: implement dirty bitmap export
      qapi: new qmp command nbd-server-add-bitmap
      docs/interop: add nbd.txt
      nbd/server: introduce NBD_CMD_CACHE

 docs/interop/nbd.txt |  38 +++++
 qapi/block.json      |  23 +++
 include/block/nbd.h  |  11 +-
 blockdev-nbd.c       |  23 +++
 nbd/common.c         |   2 +
 nbd/server.c         | 385 ++++++++++++++++++++++++++++++++++++++++++++-=
------
 MAINTAINERS          |   1 +
 nbd/trace-events     |   1 +
 tests/.gitignore     |  93 +------------
 9 files changed, 433 insertions(+), 144 deletions(-)
 create mode 100644 docs/interop/nbd.txt

--=20
2.14.4
