Received: from eggs.gnu.org ([209.51.188.92]:50816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkNF-0004sY-Pi
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gzkHP-0005nI-IB
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:40:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gzkHP-0005lf-Au
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:40:55 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Mar 2019 16:40:44 +0100
Message-Id: <20190301154051.23317-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] qapi: Code generation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, eblake@redhat.com, quintela@redhat.com

Markus Armbruster (7):
  tests/qapi-schema: Make test-qapi.py print arrays
  tests/qapi-schema: Cover conditional arrays
  qapi: Pass file name to QAPIGen constructor instead of methods
  qapi: Fix code generation for sub-modules in other directories
  tests: Rename UserDefNativeListUnion to UserDefListUnion
  tests/qapi-schema: Cover forward reference to sub-module
  qapi: Fix array first used in a different module

 scripts/qapi/commands.py                   |   2 +-
 scripts/qapi/common.py                     | 106 ++++++-----
 scripts/qapi/doc.py                        |   4 +-
 tests/.gitignore                           |   8 +
 tests/Makefile.include                     |  44 ++++-
 tests/qapi-schema/include-relpath-sub.json |   2 -
 tests/qapi-schema/include-relpath.err      |   0
 tests/qapi-schema/include-relpath.exit     |   1 -
 tests/qapi-schema/include-relpath.json     |   1 -
 tests/qapi-schema/include-relpath.out      |  20 ---
 tests/qapi-schema/include/relpath.json     |   1 -
 tests/qapi-schema/include/sub-module.json  |   7 +
 tests/qapi-schema/qapi-schema-test.json    |  14 +-
 tests/qapi-schema/qapi-schema-test.out     |  37 +++-
 tests/qapi-schema/sub-sub-module.json      |   6 +
 tests/qapi-schema/test-qapi.py             |   6 +
 tests/test-clone-visitor.c                 |  16 +-
 tests/test-qmp-cmds.c                      |   2 +-
 tests/test-qobject-input-visitor.c         | 196 ++++++++++-----------
 tests/test-qobject-output-visitor.c        | 190 ++++++++++----------
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
