Received: from eggs.gnu.org ([2001:4830:134:3::10]:40109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fO46p-0002XK-1V
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fO46k-0002bs-Gv
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:37:59 -0400
Received: from mail-ve1eur02on072a.outbound.protection.outlook.com
	([2a01:111:f400:fe06::72a]:37787
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1fO46j-0002bE-8A
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:37:54 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 30 May 2018 19:37:30 +0300
Message-Id: <1527698252-86258-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/2] qapi: allow empty branches in flat
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

since v2: remarks addressed:
 - qapi-code-gen.txt comment added
 - negative testcase (which became positive) is removed,
   verification added to qapi-schema-test

Anton Nefedov (2):
  qapi: allow empty branches in flat unions
  qapi: remove empty flat union branches and types

 docs/devel/qapi-code-gen.txt                       |  8 ++--
 qapi/block-core.json                               | 55 ++--------------------
 qapi/crypto.json                                   | 13 +----
 qapi/misc.json                                     | 46 +-----------------
 qapi/net.json                                      | 12 -----
 qapi/ui.json                                       | 19 +-------
 .../qapi-schema/flat-union-incomplete-branch.json  |  9 ----
 tests/qapi-schema/qapi-schema-test.json            |  4 +-
 block/qcow2.c                                      |  1 -
 cpus.c                                             |  2 -
 scripts/qapi/common.py                             | 11 ++---
 scripts/qapi/types.py                              |  4 +-
 scripts/qapi/visit.py                              | 17 +++++--
 tests/Makefile.include                             |  1 -
 tests/qapi-schema/flat-union-incomplete-branch.err |  1 -
 .../qapi-schema/flat-union-incomplete-branch.exit  |  1 -
 tests/qapi-schema/flat-union-incomplete-branch.out |  0
 tests/qapi-schema/qapi-schema-test.out             |  3 +-
 18 files changed, 37 insertions(+), 170 deletions(-)
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.json
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.err
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.exit
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.out

-- 
2.7.4
