Received: from eggs.gnu.org ([2001:4830:134:3::10]:50530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq5-0000V4-2M
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq1-0004dn-28
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:36 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:18687 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e1bq0-0004ZG-JX
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Oct 2017 20:27:06 +0300
Message-Id: <20171009172723.190282-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 00/10] nbd minimal structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Minimally implement nbd structured read extension.

v2:

clone: tag up-nbd-minimal-structured-read-v2 from https://src.openvz.org/scm/~vsementsov/qemu.git
online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=up-nbd-minimal-structured-read-v2

01: improve assertion (Eric)
02: add Eric's r-b
06: define NBD_SREP_TYPE_OFFSET_HOLE and NBD_SREP_TYPE_ERROR_OFFSET
    here (Eric)
07: fix return value of nbd_request_simple_option
08-09: new patches
10: mostly rewritten

Vladimir Sementsov-Ogievskiy (10):
  block/nbd-client: assert qiov len once in nbd_co_request
  block/nbd-client: refactor nbd_co_receive_reply
  nbd: rename NBD_REPLY_MAGIC to NBD_SIMPLE_REPLY_MAGIC
  nbd-server: refactor simple reply sending
  nbd: header constants indenting
  nbd: Minimal structured read for server
  nbd/client: refactor nbd_receive_starttls
  nbd: share some nbd entities to be reused in block/nbd-client.c
  nbd/client: prepare nbd_receive_reply for structured reply
  nbd: Minimal structured read for client

 include/block/nbd.h                      | 132 ++++++++++-
 nbd/nbd-internal.h                       |  65 +++---
 block/nbd-client.c                       | 364 ++++++++++++++++++++++++++++---
 nbd/client.c                             | 205 +++++++++++------
 nbd/server.c                             | 189 +++++++++++-----
 nbd/trace-events                         |  10 +-
 tests/qemu-iotests/nbd-fault-injector.py |   4 +-
 7 files changed, 756 insertions(+), 213 deletions(-)

-- 
2.11.1
