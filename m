Received: from eggs.gnu.org ([2001:4830:134:3::10]:47806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fNhh1-0002Wb-Rh
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fNhgx-0003sS-2N
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:41:51 -0400
Received: from mail-db5eur01on0139.outbound.protection.outlook.com
	([104.47.2.139]:7424
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1fNhgw-0003qD-Gv
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:41:47 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 29 May 2018 19:41:30 +0300
Message-Id: <1527612092-65980-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/2] qapi: allow empty branches in flat
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

since v1:
 - reworked to always allow empty branches
 - more types removed in patch 2

v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg02525.html

Anton Nefedov (2):
  qapi: allow empty branches in flat unions
  qapi: remove empty flat union branches and types

 docs/devel/qapi-code-gen.txt                       |  7 +--
 qapi/block-core.json                               | 55 ++--------------------
 qapi/crypto.json                                   | 13 +----
 qapi/misc.json                                     | 46 +-----------------
 qapi/net.json                                      | 12 -----
 qapi/ui.json                                       | 19 +-------
 block/qcow2.c                                      |  1 -
 cpus.c                                             |  2 -
 scripts/qapi/common.py                             | 11 ++---
 scripts/qapi/types.py                              |  4 +-
 scripts/qapi/visit.py                              | 17 +++++--
 tests/qapi-schema/flat-union-incomplete-branch.err |  1 -
 .../qapi-schema/flat-union-incomplete-branch.exit  |  2 +-
 tests/qapi-schema/flat-union-incomplete-branch.out | 14 ++++++
 14 files changed, 47 insertions(+), 157 deletions(-)

-- 
2.7.4
