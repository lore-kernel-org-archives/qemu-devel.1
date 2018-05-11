Received: from eggs.gnu.org ([2001:4830:134:3::10]:49354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fH3zy-0000aO-AN
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fH3zu-0000ek-9E
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:05:58 -0400
Received: from mail-he1eur01on0724.outbound.protection.outlook.com
	([2a01:111:f400:fe1e::724]:32813
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1fH3zt-0000WI-MY
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:05:54 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 11 May 2018 12:05:32 +0300
Message-Id: <1526029534-35771-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] qapi: allow flat unions with empty branches
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

hej,

inspired by this thread
http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg04802.html

Seems that nobody got around to this since (did anybody?),
so I thought I'd give a try.

There's a generator patch and usage example.

Anton Nefedov (2):
  qapi: allow flat unions with empty branches
  qapi: avoid empty CpuInfoOther type

 qapi/misc.json                 | 48 ++++--------------------------------------
 cpus.c                         |  2 --
 scripts/qapi/common.py         | 18 ++++++++++------
 scripts/qapi/doc.py            |  2 +-
 scripts/qapi/types.py          |  2 +-
 scripts/qapi/visit.py          | 12 ++++++-----
 tests/qapi-schema/test-qapi.py |  2 +-
 7 files changed, 26 insertions(+), 60 deletions(-)

-- 
2.7.4
