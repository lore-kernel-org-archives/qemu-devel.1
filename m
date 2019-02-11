Received: from eggs.gnu.org ([209.51.188.92]:53554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtIYB-0006w5-7F
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtIYA-0006bW-9A
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:51:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gtIYA-0006b0-3a
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 15:51:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A223B89AC5
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:51:32 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-127.phx2.redhat.com [10.3.116.127])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 587FF57BF
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:51:32 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Feb 2019 14:51:24 -0600
Message-Id: <20190211205128.27146-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] NBD patches for 2019-02-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 22c5f446514a2a4bb0dbe1fea26713da92fc85=
fa:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190211' into =
staging (2019-02-11 17:04:57 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-02-11

for you to fetch changes up to ddd113beedd22908e676d53803843d2f85bf91ab:

  qcow2: list of bitmaps new test 242 (2019-02-11 14:35:43 -0600)

----------------------------------------------------------------
nbd patches for 2019-02-11

- Add qcow2 bitmap details to 'qemu-img info'

----------------------------------------------------------------
Andrey Shinkevich (3):
      bdrv_query_image_info Error parameter added
      qcow2: Add list of bitmaps to ImageInfoSpecificQCow2
      qcow2: list of bitmaps new test 242

Eric Blake (1):
      nbd/server: Kill pointless shadowed variable

 qapi/block-core.json       |  41 ++++++++++-
 block/qcow2.h              |   2 +
 include/block/block.h      |   3 +-
 include/block/block_int.h  |   3 +-
 block.c                    |   5 +-
 block/crypto.c             |   9 +--
 block/qapi.c               |   7 +-
 block/qcow2-bitmap.c       |  76 +++++++++++++++++++++
 block/qcow2.c              |  21 +++++-
 block/vmdk.c               |   3 +-
 nbd/server.c               |   1 -
 qemu-io-cmds.c             |   7 +-
 tests/qemu-iotests/242     | 104 ++++++++++++++++++++++++++++
 tests/qemu-iotests/242.out | 166 +++++++++++++++++++++++++++++++++++++++=
++++++
 tests/qemu-iotests/group   |   1 +
 15 files changed, 431 insertions(+), 18 deletions(-)
 create mode 100755 tests/qemu-iotests/242
 create mode 100644 tests/qemu-iotests/242.out

--=20
2.20.1
