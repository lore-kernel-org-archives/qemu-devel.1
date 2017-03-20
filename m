Received: from eggs.gnu.org ([2001:4830:134:3::10]:49280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6R-0003dC-RC
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6P-0002bW-Cg
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cpx6P-0002bD-6u
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 14:11:49 +0100
Message-Id: <1490015515-25851-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/6] qapi: Small qapi2texi fixes and
 addition tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Code changes only in QAPI generator scripts and tests.  Generated code
is identical.  Generated documentation is improved slightly.

Markus Armbruster (6):
  qapi: Drop excessive Make dependencies on qapi2texi.py
  qapi2texi: Fix to actually fail when 'doc-required' is false
  qapi: Drop unused QAPIDoc member optional
  tests/qapi-schema: Make test-qapi.py print docs again
  tests/qapi-schema: Systematic positive doc comment tests
  qapi2texi: Fix translation of *strong* and _emphasized_

 Makefile                        |   7 +-
 scripts/qapi.py                 |   1 -
 scripts/qapi2texi.py            |   5 +-
 tests/Makefile.include          |  13 ++-
 tests/qapi-schema/doc-good.err  |   0
 tests/qapi-schema/doc-good.exit |   1 +
 tests/qapi-schema/doc-good.json | 136 ++++++++++++++++++++++
 tests/qapi-schema/doc-good.out  | 148 ++++++++++++++++++++++++
 tests/qapi-schema/doc-good.texi | 243 ++++++++++++++++++++++++++++++++++++++++
 tests/qapi-schema/test-qapi.py  |  11 ++
 10 files changed, 555 insertions(+), 10 deletions(-)
 create mode 100644 tests/qapi-schema/doc-good.err
 create mode 100644 tests/qapi-schema/doc-good.exit
 create mode 100644 tests/qapi-schema/doc-good.json
 create mode 100644 tests/qapi-schema/doc-good.out
 create mode 100644 tests/qapi-schema/doc-good.texi

-- 
2.7.4
