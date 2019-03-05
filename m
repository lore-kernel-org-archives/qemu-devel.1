Received: from eggs.gnu.org ([209.51.188.92]:55144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1DJH-00031I-OE
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1DJG-0002eF-Ny
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:52:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h1DJD-0002Uq-Kl
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:52:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B7853082E67
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 16:52:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BE4A17566
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 16:52:39 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  5 Mar 2019 17:52:29 +0100
Message-Id: <20190305165236.8389-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] QAPI patches for 2019-03-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 0984a157c1c053394adbf64ed7de97f1aebe6a2d:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2019-03-05 09:33:20 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-03-05

for you to fetch changes up to 56a4689582433125d7042ba506a081e08dc264d4:

  qapi: Fix array first used in a different module (2019-03-05 14:43:11 +0100)

----------------------------------------------------------------
QAPI patches for 2019-03-05

----------------------------------------------------------------
Markus Armbruster (7):
      tests/qapi-schema: Make test-qapi.py print arrays
      tests/qapi-schema: Cover conditional arrays
      qapi: Pass file name to QAPIGen constructor instead of methods
      qapi: Fix code generation for sub-modules in other directories
      tests: Rename UserDefNativeListUnion to UserDefListUnion
      tests/qapi-schema: Cover forward reference to sub-module
      qapi: Fix array first used in a different module

 scripts/qapi/commands.py                   |   2 +-
 scripts/qapi/common.py                     | 106 +++++++++-------
 scripts/qapi/doc.py                        |   4 +-
 tests/.gitignore                           |   8 ++
 tests/Makefile.include                     |  44 ++++++-
 tests/qapi-schema/include-relpath-sub.json |   2 -
 tests/qapi-schema/include-relpath.err      |   0
 tests/qapi-schema/include-relpath.exit     |   1 -
 tests/qapi-schema/include-relpath.json     |   1 -
 tests/qapi-schema/include-relpath.out      |  20 ---
 tests/qapi-schema/include/relpath.json     |   1 -
 tests/qapi-schema/include/sub-module.json  |   7 ++
 tests/qapi-schema/qapi-schema-test.json    |  14 ++-
 tests/qapi-schema/qapi-schema-test.out     |  37 +++++-
 tests/qapi-schema/sub-sub-module.json      |   6 +
 tests/qapi-schema/test-qapi.py             |   6 +
 tests/test-clone-visitor.c                 |  16 +--
 tests/test-qmp-cmds.c                      |   2 +-
 tests/test-qobject-input-visitor.c         | 196 ++++++++++++++---------------
 tests/test-qobject-output-visitor.c        | 190 ++++++++++++++--------------
 20 files changed, 371 insertions(+), 292 deletions(-)
 delete mode 100644 tests/qapi-schema/include-relpath-sub.json
 delete mode 100644 tests/qapi-schema/include-relpath.err
 delete mode 100644 tests/qapi-schema/include-relpath.exit
 delete mode 100644 tests/qapi-schema/include-relpath.json
 delete mode 100644 tests/qapi-schema/include-relpath.out
 delete mode 100644 tests/qapi-schema/include/relpath.json
 create mode 100644 tests/qapi-schema/include/sub-module.json
 create mode 100644 tests/qapi-schema/sub-sub-module.json

-- 
2.17.2
