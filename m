Received: from eggs.gnu.org ([2001:4830:134:3::10]:59758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fUpiA-0005ZW-Pn
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fUpi7-0000Ih-LI
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:40:30 -0400
Received: from mail-db5eur01on0097.outbound.protection.outlook.com
	([104.47.2.97]:43712
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1fUpi6-0000FC-DP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 04:40:27 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 18 Jun 2018 11:40:04 +0300
Message-Id: <1529311206-76847-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 0/2] qapi: allow empty branches in flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

v5: remarks for patch 1 fixed
v4: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg03638.html

Anton Nefedov (2):
  qapi: allow empty branches in flat unions
  qapi: remove empty flat union branches and types

 docs/devel/qapi-code-gen.txt                       |  8 ++--
 qapi/block-core.json                               | 52 ++--------------------
 qapi/crypto.json                                   | 13 +-----
 qapi/misc.json                                     | 46 +------------------
 qapi/net.json                                      | 12 -----
 qapi/ui.json                                       | 19 +-------
 .../qapi-schema/flat-union-incomplete-branch.json  |  9 ----
 tests/qapi-schema/qapi-schema-test.json            |  6 ++-
 block/qcow2.c                                      |  1 -
 cpus.c                                             |  2 -
 scripts/qapi/common.py                             | 15 ++++---
 scripts/qapi/types.py                              |  2 +
 scripts/qapi/visit.py                              | 19 +++++---
 tests/Makefile.include                             |  1 -
 tests/qapi-schema/flat-union-incomplete-branch.err |  1 -
 .../qapi-schema/flat-union-incomplete-branch.exit  |  1 -
 tests/qapi-schema/flat-union-incomplete-branch.out |  0
 tests/qapi-schema/qapi-schema-test.out             |  3 +-
 18 files changed, 42 insertions(+), 168 deletions(-)
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.json
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.err
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.exit
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.out

-- 
2.7.4
