Received: from eggs.gnu.org ([2001:4830:134:3::10]:50421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dNheN-0007vi-HG
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dNheI-0008QN-G2
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:35 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14692 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dNheI-0008Ou-4E
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Jun 2017 18:34:18 +0300
Message-Id: <20170621153424.16690-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/6] nbd refactoring part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is last part of "nbd errors and traces refactoring".

Patches 01-10 from "nbd errors and traces refactoring" are already merged.
Patches 11-13 from it are rejected - do not regret them.
So, these series is update of 14-19 patches from "nbd errors and traces
refactoring"

v2:
01: EPIPE not handled
    imporve comments
02: rebased on absence of old patch 13, errors are not saved into
    separate ret variable
    TRACE on fail of sending NBD_REP_ACK reply to NBD_OPT_ABORT
    instead of error propagating and EPIPE handling
03: fix error_prepend
04: just remove this TRACE
05: just trace nbd magic as 64bit number
06: improve commit message
    simplify trace_nbd_receive_negotiate_server_flags - do not trace
    separate flags
    add trace_nbd_opt_abort_reply_failed
    remove tail periods from traces


Vladimir Sementsov-Ogievskiy (6):
  nbd/server: nbd_negotiate: return 1 on NBD_OPT_ABORT
  nbd/server: use errp instead of LOG
  nbd/server: add errp to nbd_send_reply()
  nbd/common: nbd_tls_handshake: remove extra TRACE
  nbd/client: refactor TRACE of NBD_MAGIC
  nbd: use generic trace subsystem instead of TRACE macro

 Makefile.objs      |   1 +
 nbd/client.c       |  87 +++++--------
 nbd/common.c       |   4 +-
 nbd/nbd-internal.h |  19 ---
 nbd/server.c       | 368 +++++++++++++++++++++++++++++++----------------------
 nbd/trace-events   |  68 ++++++++++
 6 files changed, 320 insertions(+), 227 deletions(-)
 create mode 100644 nbd/trace-events

-- 
2.11.1
